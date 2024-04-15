; extends

; matches "await sql<MyModel>`...`" for postgres library
; (call_expression
;   function: (await_expression
;     (identifier) @injection.language (#eq? @injection.language "sql")
;   )
;   type_arguments: (type_arguments)
;   arguments: [
;     (arguments
;       (template_string) @injection.content)
;     (template_string) @injection.content
;   ]
;   (#set! injection.include-children)
; )
