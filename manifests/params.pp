# == Class graphite::params
#
# This class is meant to be called from graphite
# It sets variables according to platform
#
class graphiteapi::params ( 
  $bind_addr = '127.0.0.1',
  $bind_port = '8080',
) {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $graphiteapi_user  = 'graphite'
      $graphiteapi_group = 'graphite'
      $virtualenv_path = '/opt/graphite-api'
      $whisper_paths = ['/opt/graphite/storage/whisper']
      $graphiteapi_tz = 'America/New_York'
      $graphiteapi_search_index = '/srv/graphiteapi_index'
      $graphiteapi_log_path = '/var/log/supervisor/graphite-api.log'
      $create_search_index = true
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
