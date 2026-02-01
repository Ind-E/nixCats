; extends

((script_element
  (start_tag
    (attribute
      (attribute_name) @_attr_name
      (quoted_attribute_value
        (attribute_value) @_attr_val)))
  (raw_text) @injection.content)
 (#eq? @_attr_name "type")
 (#match? @_attr_val "x-shader/x-(vertex|fragment)")
 (#set! injection.language "glsl"))
