class nginx (
  $root = '/var/www'
) {
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
    content =>  template('nginx/default.conf.erb'),
    notify  =>  Service['nginx'],
    require =>  Package['nginx'],
  }
  
  file { "$root/index.html":
    ensure  =>  file,
    source  =>  "puppet:///modules/nginx/index.html",
  }  
  
  file { "$root":
    ensure  =>  directory,
  }
  
  service { 'nginx':
    ensure  =>  running,
    require =>  [Package['nginx'], File["$root/index.html"]],
  }
  
}
