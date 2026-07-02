import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('ms_subdomain_constants')])
	rt.call_function('add_action', [rt.new_string('update_option_blog_public'),
		rt.new_string('update_blog_public'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('option_users_can_register'),
		rt.new_string('users_can_register_signup_filter')])
	rt.call_function('add_filter', [rt.new_string('site_option_welcome_user_email'),
		rt.new_string('welcome_user_msg_filter')])
	rt.call_function('add_filter', [rt.new_string('wpmu_validate_user_signup'),
		rt.new_string('signup_nonce_check')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('maybe_add_existing_user_to_blog')])
	rt.call_function('add_action', [rt.new_string('wpmu_new_user'),
		rt.new_string('newuser_notify_siteadmin')])
	rt.call_function('add_action', [rt.new_string('wpmu_activate_user'),
		rt.new_string('add_new_user_to_blog'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wpmu_activate_user'),
		rt.new_string('wpmu_welcome_user_notification'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('after_signup_user'),
		rt.new_string('wpmu_signup_user_notification'), rt.new_int(10),
		rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('network_site_new_created_user'),
		rt.new_string('wp_send_new_user_notifications')])
	rt.call_function('add_action', [rt.new_string('network_site_users_created_user'),
		rt.new_string('wp_send_new_user_notifications')])
	rt.call_function('add_action', [rt.new_string('network_user_new_created_user'),
		rt.new_string('wp_send_new_user_notifications')])
	rt.call_function('add_filter', [rt.new_string('sanitize_user'),
		rt.new_string('strtolower')])
	rt.call_function('add_action', [rt.new_string('deleted_user'),
		rt.new_string('wp_delete_signup_on_user_delete'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('switch_blog'),
		rt.new_string('wp_switch_roles_and_user'), rt.new_int(1),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wpmu_validate_blog_signup'),
		rt.new_string('signup_nonce_check')])
	rt.call_function('add_action', [rt.new_string('wpmu_activate_blog'),
		rt.new_string('wpmu_welcome_notification'), rt.new_int(10),
		rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('after_signup_site'),
		rt.new_string('wpmu_signup_blog_notification'), rt.new_int(10),
		rt.new_int(7)])
	rt.call_function('add_filter', [rt.new_string('wp_normalize_site_data'),
		rt.new_string('wp_normalize_site_data'), rt.new_int(10),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_validate_site_data'),
		rt.new_string('wp_validate_site_data'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_insert_site'),
		rt.new_string('wp_maybe_update_network_site_counts_on_update'),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_update_site'),
		rt.new_string('wp_maybe_update_network_site_counts_on_update'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_delete_site'),
		rt.new_string('wp_maybe_update_network_site_counts_on_update'),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_insert_site'),
		rt.new_string('wp_maybe_transition_site_statuses_on_update'),
		rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_update_site'),
		rt.new_string('wp_maybe_transition_site_statuses_on_update'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_update_site'),
		rt.new_string('wp_maybe_clean_new_site_cache_on_update'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_initialize_site'),
		rt.new_string('wp_initialize_site'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_initialize_site'),
		rt.new_string('wpmu_log_new_registrations'), rt.new_int(100),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_initialize_site'),
		rt.new_string('newblog_notify_siteadmin'), rt.new_int(100),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_uninitialize_site'),
		rt.new_string('wp_uninitialize_site'), rt.new_int(10),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('update_blog_public'),
		rt.new_string('wp_update_blog_public_option_on_site_update'),
		rt.new_int(1), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('added_blog_meta'),
		rt.new_string('wp_cache_set_sites_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_blog_meta'),
		rt.new_string('wp_cache_set_sites_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_blog_meta'),
		rt.new_string('wp_cache_set_sites_last_changed')])
	rt.call_function('add_filter', [rt.new_string('get_blog_metadata'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('add_blog_metadata'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_blog_metadata'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('delete_blog_metadata'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('get_blog_metadata_by_mid'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_blog_metadata_by_mid'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('delete_blog_metadata_by_mid'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_blog_metadata_cache'),
		rt.new_string('wp_check_site_meta_support_prefilter')])
	rt.call_function('add_action', [rt.new_string('signup_hidden_fields'),
		rt.new_string('signup_nonce_fields')])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('maybe_redirect_404')])
	rt.call_function('add_filter', [rt.new_string('allowed_redirect_hosts'),
		rt.new_string('redirect_this_site')])
	rt.call_function('add_action', [rt.new_string('after_delete_post'),
		rt.new_string('_update_posts_count_on_delete'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('delete_post'),
		rt.new_string('_update_blog_date_on_post_delete')])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('_update_blog_date_on_post_publish'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('_update_posts_count_on_transition_post_status'),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('wp_schedule_update_network_counts')])
	rt.call_function('add_action', [rt.new_string('update_network_counts'),
		rt.new_string('wp_update_network_counts'), rt.new_int(10),
		rt.new_int(0)])
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'wpmu_new_user' },
		rt.ArrayItem{ key: none, val: 'make_spam_user' }, rt.ArrayItem{
			key: none
			val: 'make_ham_user'
		}]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action := item_1.val
		rt.call_function('add_action', [var_action.clone(),
			rt.new_string('wp_maybe_update_network_user_counts'),
			rt.new_int(10), rt.new_int(0)])
	}
	rt.call_function('remove_action', [rt.new_string('admin_init'),
		rt.new_string('wp_schedule_update_user_counts')])
	rt.call_function('remove_action', [rt.new_string('wp_update_user_counts'),
		rt.new_string('wp_schedule_update_user_counts')])
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'make_spam_blog' },
		rt.ArrayItem{ key: none, val: 'make_ham_blog' }, rt.ArrayItem{
			key: none
			val: 'archive_blog'
		}, rt.ArrayItem{ key: none, val: 'unarchive_blog' }, rt.ArrayItem{
			key: none
			val: 'make_delete_blog'
		}, rt.ArrayItem{ key: none, val: 'make_undelete_blog' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_action := item_2.val
		rt.call_function('add_action', [var_action.clone(),
			rt.new_string('wp_maybe_update_network_site_counts'),
			rt.new_int(10), rt.new_int(0)])
	}
	var_action = rt.new_null()
	rt.call_function('add_filter', [rt.new_string('wp_upload_bits'),
		rt.new_string('upload_is_file_too_big')])
	rt.call_function('add_filter', [rt.new_string('import_upload_size_limit'),
		rt.new_string('fix_import_form_size')])
	rt.call_function('add_filter', [rt.new_string('upload_mimes'),
		rt.new_string('check_upload_mimes')])
	rt.call_function('add_filter', [rt.new_string('upload_size_limit'),
		rt.new_string('upload_size_limit_filter')])
	rt.call_function('add_action', [rt.new_string('upload_ui_over_quota'),
		rt.new_string('multisite_over_quota_message')])
	rt.call_function('add_action', [rt.new_string('phpmailer_init'),
		rt.new_string('fix_phpmailer_messageid')])
	rt.call_function('add_filter', [
		rt.new_string('enable_update_services_configuration'),
		rt.new_string('__return_false'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('POST_BY_EMAIL')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('POST_BY_EMAIL'))))) {
		rt.call_function('add_filter', [
			rt.new_string('enable_post_by_email_configuration'),
			rt.new_string('__return_false'),
		])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('EDIT_ANY_USER')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EDIT_ANY_USER'))))) {
		rt.call_function('add_filter', [
			rt.new_string('enable_edit_any_user_configuration'),
			rt.new_string('__return_false'),
		])
	}
	rt.call_function('add_filter', [rt.new_string('force_filtered_html_on_import'),
		rt.new_string('__return_true')])
	rt.call_function('remove_filter', [rt.new_string('option_siteurl'),
		rt.new_string('_config_wp_siteurl')])
	rt.call_function('remove_filter', [rt.new_string('option_home'),
		rt.new_string('_config_wp_home')])
	rt.call_function('add_action', [rt.new_string('update_option_blogname'),
		rt.new_string('clean_site_details_cache'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('update_option_siteurl'),
		rt.new_string('clean_site_details_cache'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('update_option_post_count'),
		rt.new_string('clean_site_details_cache'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('update_option_home'),
		rt.new_string('clean_site_details_cache'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_filter', [
		rt.new_string('default_site_option_ms_files_rewriting'),
		rt.new_string('__return_true'),
	])
	rt.call_function('add_filter', [rt.new_string('http_request_host_is_external'),
		rt.new_string('ms_allowed_http_request_hosts'), rt.new_int(20),
		rt.new_int(2)])
}
