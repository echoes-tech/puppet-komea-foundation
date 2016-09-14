# Private class
class komea_foundation::config inherits komea_foundation {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
}
