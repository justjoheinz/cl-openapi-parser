(in-package :openapi-parser/schema)

(defconstant +default-version-package+ :openapi-parser/schema/3.1.0)
(defconstant +patterned-field-slot-name+ 'field*)
(defconstant +json-schema-class-name+ '<json-schema>)

(defvar *openapi-version-package*)

(defun missing-initarg (class-name initarg)
  (warn "Required initarg ~S missing in ~S." initarg class-name))

(defclass schema-metaclass (c2mop:standard-class) ())

(defmethod c2mop:validate-superclass ((class schema-metaclass) (super c2mop:standard-class))
  t)

(defmethod c2mop:validate-superclass ((class standard-class) (super schema-metaclass))
  t)

(defclass field-slot (c2mop:standard-direct-slot-definition)
  ((field-name :initarg :field-name
               :initform nil
               :reader field-slot-field-name)
   (pattern :initarg :field-pattern
            :initform nil
            :reader field-slot-pattern)
   (required :initarg :required
             :initform nil
             :reader field-slot-required)))

(defmethod c2mop:direct-slot-definition-class ((class schema-metaclass) &rest initargs)
  (declare (ignore initargs))
  (find-class 'field-slot))

(defun convert-patterned-field (field-name)
  (cond ((string= field-name "[HTTP Status Code](#httpCodes)")
         (ppcre:parse-string "^(\\d+)$"))
        (t
         (multiple-value-bind (start end) (ppcre:scan "(\\{\\w+\\}+)" field-name)
           (let ((prefix (subseq field-name 0 start))
                 (suffix (subseq field-name end)))
             `(:sequence
               :start-anchor
               ,@(unless (length= prefix 0) (list prefix))
               (:register (:greedy-repetition 0 nil :everything))
               ,@(unless (length= suffix 0) (list suffix))
               :end-anchor))))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun make-reader-name (class-name slot-name)
    (declare (ignore class-name))
    (let ((*package* (find-package :openapi-parser/schema/3/interface)))
      (symbolicate "->"
                   (ppcre:regex-replace "^<(.*)>$"
                                        (string slot-name)
                                        "\\1")))
    #+(or)
    (alexandria:symbolicate (ppcre:regex-replace "^<(.*)>$"
                                                 (string class-name)
                                                 "\\1")
                            '-
                            slot-name))
  (defun generate-schema-slot-reader (class-name slot-name)
    (let ((reader-name (make-reader-name class-name slot-name))
          (instance (make-symbol "INSTANCE"))
          (default (make-symbol "DEFAULT")))
      `(defmethod ,reader-name
           ((,instance ,class-name)
            &optional ,default)
         (if (slot-boundp ,instance ',slot-name)
             (slot-value ,instance ',slot-name)
             ,default)))))

(defmacro define-schema (name direct-superclasses &body slots)
  `(progn
     (defclass ,name (,@direct-superclasses)
       ,(mapcar (lambda (slot)
                  (destructuring-bind (slot-name
                                       &key documentation required (type nil type-p) field-name)
                      slot
                    `(,slot-name :initarg ,(make-keyword slot-name)
                                 :required ,required
                                 ,@(when required `(:initform (missing-initarg
                                                               ',name
                                                               ,(make-keyword slot-name))))
                                 :documentation ,documentation
                                 ,@(when type-p `(:type ,type))
                                 :field-name ,field-name
                                 ,@(when (and (eq slot-name +patterned-field-slot-name+)
                                              field-name)
                                     `(:field-pattern ,(convert-patterned-field field-name))))))
                slots)
       (:metaclass schema-metaclass))
     ,@(loop :for (slot-name) :in slots
             :collect (generate-schema-slot-reader name
                                                   slot-name))))

(defclass schema ()
  ((x-properties :initarg :x-properties
                 :initform nil
                 :reader schema-x-properties)))

(defun class-precedence-list (class)
  (unless (c2mop:class-finalized-p class)
    (c2mop:finalize-inheritance class))
  (c2mop:class-precedence-list class))

(defun schema-spec-slots (class)
  ;; x-propertiesを除外してdefine-schemaで定義したスロットだけを返す
  (loop :with root-class := (find-class 'schema)
        :for c :in (class-precedence-list class)
        :until (eq c root-class)
        :append (progn
                  (c2mop:class-direct-slots c))))

(defclass fixed-fields-schema (schema) ()
  (:metaclass schema-metaclass))

(defclass patterned-fields-schema (schema)
  ((field*
    :initarg :field
    :accessor patterned-fields-schema-field))
  (:metaclass schema-metaclass))

(defun patterned-schema-field-slot (schema)
  (find 'field*
        (c2mop:class-direct-slots (class-of schema))
        :key #'c2mop:slot-definition-name))

(deftype <map> (k v)
  (declare (ignore k v))
  t)

(deftype <forward-referenced-schema> ()
  t)

;; https://datatracker.ietf.org/doc/html/draft-bhutton-json-schema-validation-00#section-6
;; TODO: キーが足りない&型宣言がない
(define-schema <json-schema> (fixed-fields-schema openapi-parser/schema/3/interface:<json-schema>)
  (type :type string)
  (enum :type (trivial-types:proper-list (or boolean string)))
  (const)
  (multiple-of)
  (maximum)
  (exclusive-maximum)
  (minimum)
  (exclusive-minimum)
  (max-length)
  (min-length)
  (pattern)
  (max-items)
  (min-items)
  (unique-items)
  (max-contents)
  (min-contents)
  (max-properties)
  (min-properties)
  (required)
  (dependent-required)
  (default)
  (properties :type (<map> string <forward-referenced-schema>))
  (all-of :type (trivial-types:proper-list <forward-referenced-schema>))
  (any-of :type (trivial-types:proper-list <forward-referenced-schema>))
  (one-of :type (trivial-types:proper-list <forward-referenced-schema>))
  (not :type <forward-referenced-schema>)
  (items :type <forward-referenced-schema>)
  (title :type string)
  (additional-properties :type (or booeal <forward-referenced-schema>))

  ;; openapi
  (description :field-name "description" :type string)
  (format :field-name "format" :type string)
  ($ref :field-name "$ref" :type string))

(defun $ref (object)
  (slot-value object '$ref))

(defun openapi-version-package ()
  (if (boundp '*openapi-version-package*)
      *openapi-version-package*
      (find-package +default-version-package+)))

(defun get-schema-class ()
  (let ((result (find-symbol (string '#:<schema>) (openapi-version-package))))
    (assert result)
    result))

(defun get-reference-class ()
  (let ((result (find-symbol (string '#:<reference>) (openapi-version-package))))
    (assert result)
    result))

(defun get-openapi-class ()
  (let ((result (find-symbol (string '#:<open-api>) (openapi-version-package))))
    (assert result)
    result))

(defun version-package (version-string)
  (find-package
   (eswitch (version-string :test #'string=)
     ("3.0.1" :openapi-parser/schema/3.0.1)
     ("3.1.0" :openapi-parser/schema/3.1.0))))

(defun get-x-property (schema key)
  (gethash key (schema-x-properties schema)))
