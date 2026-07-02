import rt

const global_const_db_name = 'database_name_here'
const global_const_db_user = 'username_here'
const global_const_db_password = 'password_here'
const global_const_db_host = 'localhost'
const global_const_db_charset = 'utf8mb4'
const global_const_db_collate = ''
const global_const_auth_key = 'put your unique phrase here'
const global_const_secure_auth_key = 'put your unique phrase here'
const global_const_logged_in_key = 'put your unique phrase here'
const global_const_nonce_key = 'put your unique phrase here'
const global_const_auth_salt = 'put your unique phrase here'
const global_const_secure_auth_salt = 'put your unique phrase here'
const global_const_logged_in_salt = 'put your unique phrase here'
const global_const_nonce_salt = 'put your unique phrase here'
const global_const_wp_debug = false

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_table_prefix := 'wp_'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('ABSPATH'),
			rt.new_string(@DIR + '/')])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-settings.php', '4')
}
