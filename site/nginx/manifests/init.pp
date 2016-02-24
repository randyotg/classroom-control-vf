class nginx {
  package { 'nginx':
    ensure  =>  present,
  }
  
  File {
    owner =>  'root',
    group =>  'root',
    mode  =>  '0644',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  =>  file,
    source  =>  "puppet:///modules/nginx/nginx.conf",
    notify  =>  Service['nginx'],
    require =>  Package['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure  =>  file,
    source  =>  "puppet:///modules/nginx/default.conf",
    notify  =>  Service['nginx'],
    require =>  Package['nginx'],
  }
  
  file { '/var/www/index.html':
    ensure  =>  file,
    source  =>  "puppet:///modules/nginx/index.html",
  }  
  
  file { '/var/www':
    ensure  =>  directory,
  }
  
  service { 'nginx':
    ensure  =>  running,
    require =>  [Package['nginx'], File['/var/www/index.html']],
  }
  
}
