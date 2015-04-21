# == Class graphiteapi::install
#
class graphiteapi::install {
  include graphiteapi::params

  # Install some Graphite API dependencies.
  package { [
    'cairo',
    'cairo-devel',
    'libffi',
    'libffi-devel',
    'libyaml',
    'libyaml-devel',
    'libtool',
    'bitmap-fonts-compat',
    ]:
    ensure => installed,
  } ->

  # Install graphite-api in a virtualenv.
  python::virtualenv { $graphiteapi::virtualenv_path:
    ensure  => present,
    version => 'system',
  }
  python::pip { 'graphite-api':
    virtualenv => $graphiteapi::virtualenv_path,
  } ->
  python::pip {'uWSGI':
    pkgname    => 'uWSGI==2.0.6',
    virtualenv => $graphiteapi::virtualenv_path,
  }

  if $graphiteapi::create_search_index == true {
    file { $graphiteapi::graphiteapi_search_index:
      ensure => present,
      owner  => $graphiteapi::graphiteapi_user,
      group  => $graphiteapi::graphiteapi_group,
    }
  }
}
