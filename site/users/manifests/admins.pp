class users::admins {
  users::manage_users { 'jose': }
  users::manage_users { 'alice': }
  users::manage_users { 'chen': }
}
