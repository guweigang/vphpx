import rt

pub fn init_wp_admin_includes_ms_admin_filters_php() {
	rt.call_function('add_filter', [rt.new_string('wp_handle_upload_prefilter'),
		rt.new_string('check_upload_size')])
	rt.call_function('add_action', [rt.new_string('user_admin_notices'),
		rt.new_string('new_user_email_admin_notice')])
	rt.call_function('add_action', [rt.new_string('network_admin_notices'),
		rt.new_string('new_user_email_admin_notice')])
	rt.call_function('add_action', [rt.new_string('admin_page_access_denied'),
		rt.new_string('_access_denied_splash'), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('wpmueditblogaction'),
		rt.new_string('upload_space_setting')])
	rt.call_function('add_action', [rt.new_string('update_site_option_admin_email'),
		rt.new_string('wp_network_admin_email_change_notification'),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'),
		rt.new_string('avoid_blog_page_permalink_collision'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('import_allow_create_users'),
		rt.new_string('check_import_new_users')])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.new_string('site_admin_notice')])
	rt.call_function('add_action', [rt.new_string('network_admin_notices'),
		rt.new_string('site_admin_notice')])
	rt.call_function('add_action', [rt.new_string('network_admin_notices'),
		rt.new_string('update_nag'), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('network_admin_notices'),
		rt.new_string('maintenance_nag'), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('add_site_option_new_admin_email'),
		rt.new_string('update_network_option_new_admin_email'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('update_site_option_new_admin_email'),
		rt.new_string('update_network_option_new_admin_email'),
		rt.new_int(10), rt.new_int(2)])
}
