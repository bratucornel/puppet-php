# Configure php.ini settings
#
# === Parameters
#
# [*key*]
#   The key of the value, like `ini_setting`
#
# [*file*]
#   The path to ini file
#
# [*value*]
#   The value to set
#
# === Examples
#
#   php::config::setting { 'Date/date.timezone':
#     file  => '$full_path_to_ini_file'
#     value => 'Europe/Berlin'
#   }
#
define php::config::setting (
  String[1] $key,
  Variant[Integer, String[1]] $value,
  Stdlib::Absolutepath $file,
) {
  assert_private()

  $split_name = split($key, '/')
  if count($split_name) == 1 {
    $section = '' # lint:ignore:empty_string_assignment
    $setting = $split_name[0]
  } else {
    $section = $split_name[0]
    $setting = $split_name[1]
  }

  if $value == undef {
    $ensure = 'absent'
  } else {
    $ensure = 'present'
  }

  ini_setting { $name:
    ensure  => $ensure,
    value   => $value,
    path    => $file,
    section => $section,
    setting => $setting,
  }
}
