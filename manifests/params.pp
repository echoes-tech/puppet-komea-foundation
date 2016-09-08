# == Class: komea_foundation::params
#
# This is a container class with default parameters for Komea Foundation classes.
class komea_foundation::params {

  # default user credential
  $ksf_fqdn = "localhost"
  $dashboard_metrics_url = "undef"
  $superuser_login = "ksfuser"
  $superuser_password = "password"
  $root_ca_content = "undef"
  $resources_static_locations = '/opt/echoes/foundation/resources/'
  $ksf_security_internal_remember_token = "undef"
}
