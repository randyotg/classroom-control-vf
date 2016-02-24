define users::managed_user (
  $home_base = '/home',
) {
  user { $title:
    ensure  =>  present,
  }
  file { "$home_base/$title":
    ensure  =>  directory,
    require =>  User[$title],
  }
  file { "$home_base/$title/.ssh":
    ensure  =>  directory,
    mode    =>  '0700',
    require =>  [User[$title],File["$home_base/$title"]],
  }
}
