# == Class graphite::service
#
# Run the graphite API via supervisord.
#
class graphiteapi::service {
  supervisord::program { 'graphite-api':
    command        => "${graphiteapi::virtualenv_path}/bin/uwsgi --buffer-size 8192 --master --socket ${graphiteapi::bind_addr}:${graphiteapi::bind_port} -H ${graphiteapi::virtualenv_path} --module graphite_api.app:app",
    stdout_logfile => $graphiteapi::graphiteapi_log_path,
    stderr_logfile => $graphiteapi::graphiteapi_log_path,
    user           => $graphiteapi::graphiteapi_user,
    autostart      => true,
    autorestart    => 'true',
  }
}
