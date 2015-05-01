# == Class: avahi
#
# Install, configure, run avahi service.
#
# === Parameters
#
# enable (T/F, default T)
#   - enable the service, true or false 
#
# === Variables
#
# None
#
# === Examples
#
#  class { 'avahi': enable => true }
#
#  include avahi
#
# === Authors
#
# Author <author@domain.tld>
#
# === Copyright
#
# No copyright expressed, or implied.
#
class avahi ( $enable = true ) {

  if ( $::lsbmajdistrelease >= 5 ) {
    package { 'avahi': ensure => 'installed'}

    if ( $enable ) {
      $ensure_service = 'running'
      $enable_service = true
    } else {
      $ensure_service = 'stopped'
      $enable_service = false
    }
 
    service {'avahi-daemon':
      ensure     => "${ensure_service}",
      enable     => ${enable_service},
      hasrestart => true,
      hasstatus  => true,
      require    => Package['avahi'],
    }

    service {'avahi-dnsconfd':
      ensure     => "${ensure_service}",
      enable     => ${enable_service},
      hasrestart => true,
      hasstatus  => true,
      require    => Package['avahi'],
    }
  } else {
    warn("The avahi module does not know how to deal with ${::lsbdistdescription}.")
  }

}
