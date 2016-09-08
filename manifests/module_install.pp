# class komea_foundation::module_install
# Used to add a file to be installed on the puppet server
class komea_foundation::module_install (

){

  $user="ksfuser"
  $script_directory="/home/ksfuser"

  file { "${script_directory}/install_module.sh":
    ensure  => 'file',
    owner   => $user,
    group   => $user,
    mode    => '0755',
    source  => 'puppet:///modules/komea_foundation/install_module.sh',
  }

}
