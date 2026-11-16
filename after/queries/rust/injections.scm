; extends

; Only the first string literal in a qualified SQLx query macro is SQL.
; The preceding tokens allow query_as! output types, including generic types.
((macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_namespace
    name: (identifier) @_macro)
  (token_tree
    . [
      (identifier) (crate) (self) (super) (token_tree)
      (integer_literal) (lifetime) (line_comment) (block_comment)
      "::" "<" ">" "," "&" "*" "+" "?" "->"
    ]*
    . (raw_string_literal
        (string_content) @injection.content)))
 (#eq? @_namespace "sqlx")
 (#any-of? @_macro "query" "query_as" "query_scalar"
   "query_unchecked" "query_as_unchecked" "query_scalar_unchecked")
 (#set! injection.language "sql")
 (#set! injection.include-children))

((macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_namespace
    name: (identifier) @_macro)
  (token_tree
    . [
      (identifier) (crate) (self) (super) (token_tree)
      (integer_literal) (lifetime) (line_comment) (block_comment)
      "::" "<" ">" "," "&" "*" "+" "?" "->"
    ]*
    . (string_literal) @injection.content))
 (#eq? @_namespace "sqlx")
 (#any-of? @_macro "query" "query_as" "query_scalar"
   "query_unchecked" "query_as_unchecked" "query_scalar_unchecked")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.language "sql")
 (#set! injection.include-children))

; (
;  macro_invocation
;  (identifier) @name
;  (#eq? @name "view")
;  (token_tree) @injection.content
;  ; (#offset! @injection.content 0 1 0 -1)
;  (#set! injection.language "typescriptreact")
;  (#set! injection.include-children)
;  )

(
  (attribute_item
    (attribute
      (identifier) @attribute_name
      arguments: (token_tree
        (identifier) @option
        (raw_string_literal
          (string_content) @injection.content))))
  (#eq? @attribute_name "wasm_bindgen")
  (#eq? @option "inline_js")
  (#set! injection.language "javascript")
)

