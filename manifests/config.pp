# Private class
class komea_foundation::config inherits komea_foundation {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { "/opt/echoes/foundation/application.properties":
    ensure  => file,
    content => template("${module_name}/application.properties.erb"),
  }
}
