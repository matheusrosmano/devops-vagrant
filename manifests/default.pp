class web {
  Exec {
    path    => '/bin:/sbin:/usr/bin:/usr/sbin'
  }

  exec { 'apt update':
    command => 'apt update',
  }

  package {
    [
      'php7.0',
      'php-pear',
      'php-curl',
      'php-gd',
      'php-intl',
      'php-xmlrpc',
      'php-mysql',
      'apache2',
      'wget',
      'zip',
      'curl',
      'vim',
      'libapache2-mod-php',
    ]:
    ensure    => installed,
    require   => Exec['apt update'],
  }

  file { '/etc/apache2/conf-available/direxpress.conf':
    ensure    => present,
    owner    => root,
    group     => root,
    mode      => '0644',
    replace   => true,
    content   => template('/home/vagrant/puppet/direxpress.conf'),
    require   => Package['apache2'],
  }

  file { '/etc/apache2/sites-available/express.conf':
    ensure    => present,
    owner    => root,
    group     => root,
    mode      => '0644',
    replace   => true,
    content   => template('/home/vagrant/puppet/express.conf'),
    require   => Package['apache2'],
  }

  file { '/etc/hosts':
    ensure    => present,
    owner    => root,
    group     => root,
    mode      => '0644',
    replace   => true,
    content   => template('/home/vagrant/puppet/hosts'),
  }

  file { '/srv/www':
    ensure      => directory,
    owner       => root,
    group       => www-data,
    mode        => '2750',
  }

  exec { 'wget-express.zip':
    cwd               => '/tmp',
    command           => "wget --no-check-certificate https://github.com/rogerramossilva/devops/raw/master/express.zip",
    creates           => "/tmp/express.zip",
    require           => Package['wget'],

  }

  exec { 'unzip':
    cwd             => '/tmp',
    command         => "unzip /tmp/express.zip -d /srv/www",
    require         => Package['zip'],
    unless          => "test -d /srv/www/express",
  }

  service { 'apache2':
    ensure          => running,
    enable          => true,
    hasrestart      => true,
    restart         => true,
    require         => Package['apache2'],
  }

  exec { 'a2enconf direxpress':
    provider      => shell,
    require       => Package['apache2'],
    notify        => Service['apache2'],
  }

  exec { 'a2ensite express':
    provider      => shell,
    require       => Package['apache2'],
    notify        => Service['apache2'],
  }

  exec { 'a2enmod vhost_alias':
    provider      => shell,
    require       => Package['apache2'],
    notify        => Service['apache2'],
  }

  exec { 'a2enmod php7.3':
    provider      => shell,
    require       => Package['apache2'],
    notify        => Service['apache2'],
  }
}

include web
