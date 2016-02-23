class nginx {
  package { 'nginx':
    ensure  =>  present,
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  =>  file,
    source  =>  "puppet:///moudles/nginx/nginx.conf",
    notify  =>  Service['nginx'],
    require =>  Package['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure  =>  file,
    source  =>  "puppet:///moudles/nginx/default.conf",
    notify  =>  Service['nginx'],
    require =>  Package['nginx'],
  }
  
  file { '/var/www/index.html':
    ensure  =>  file,
    source  =>  "puppet:///moudles/nginx/index.html",
  }  
  
  file { '/var/www':
    ensure  =>  directory,
  }
  
  service { 'nginx':
    ensure  =>  running,
    require =>  [Package['nginx'], File['/var/www/index.html']],
  }
  
}
