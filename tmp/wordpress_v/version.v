module wp_includes

import rt

pub fn init_wp_includes_version_php() {
	mut var_wp_version := '7.0'
	mut var_wp_db_version := 61833
	mut var_tinymce_version := '49110-20250317'
	mut var_required_php_version := '7.4'
	mut var_required_php_extensions := ['json', 'hash']
	mut var_required_mysql_version := '5.5.5'
}
