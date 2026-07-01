import rt



pub fn init_wp_includes_default_filters_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'pre_term_name' }, rt.ArrayItem{ key: none, val: 'pre_comment_author_name' }, rt.ArrayItem{ key: none, val: 'pre_link_name' }, rt.ArrayItem{ key: none, val: 'pre_link_target' }, rt.ArrayItem{ key: none, val: 'pre_link_rel' }, rt.ArrayItem{ key: none, val: 'pre_user_display_name' }, rt.ArrayItem{ key: none, val: 'pre_user_first_name' }, rt.ArrayItem{ key: none, val: 'pre_user_last_name' }, rt.ArrayItem{ key: none, val: 'pre_user_nickname' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('sanitize_text_field')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_filter_kses')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('_wp_specialchars'), rt.new_int(30)])
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'term_name' }, rt.ArrayItem{ key: none, val: 'comment_author_name' }, rt.ArrayItem{ key: none, val: 'link_name' }, rt.ArrayItem{ key: none, val: 'link_target' }, rt.ArrayItem{ key: none, val: 'link_rel' }, rt.ArrayItem{ key: none, val: 'user_display_name' }, rt.ArrayItem{ key: none, val: 'user_first_name' }, rt.ArrayItem{ key: none, val: 'user_last_name' }, rt.ArrayItem{ key: none, val: 'user_nickname' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
				rt.call_function('add_filter', [var_filter.dup(), rt.new_string('sanitize_text_field')])
				rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_kses_data')])
			}
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('_wp_specialchars'), rt.new_int(30)])
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'pre_term_description' }, rt.ArrayItem{ key: none, val: 'pre_link_description' }, rt.ArrayItem{ key: none, val: 'pre_link_notes' }, rt.ArrayItem{ key: none, val: 'pre_user_description' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_filter_kses')])
		}
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		{
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'term_description' }, rt.ArrayItem{ key: none, val: 'link_description' }, rt.ArrayItem{ key: none, val: 'link_notes' }, rt.ArrayItem{ key: none, val: 'user_description' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_filter := item_1.val
				rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_kses_data')])
			}
		}
		rt.call_function('add_filter', [rt.new_string('comment_text'), rt.new_string('wp_kses_post')])
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'pre_comment_author_email' }, rt.ArrayItem{ key: none, val: 'pre_user_email' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('trim')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('sanitize_email')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_filter_kses')])
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'comment_author_email' }, rt.ArrayItem{ key: none, val: 'user_email' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('sanitize_email')])
			if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
				rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_kses_data')])
			}
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'pre_comment_author_url' }, rt.ArrayItem{ key: none, val: 'pre_user_url' }, rt.ArrayItem{ key: none, val: 'pre_link_url' }, rt.ArrayItem{ key: none, val: 'pre_link_image' }, rt.ArrayItem{ key: none, val: 'pre_link_rss' }, rt.ArrayItem{ key: none, val: 'pre_post_guid' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_strip_all_tags')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('sanitize_url')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_filter_kses')])
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'user_url' }, rt.ArrayItem{ key: none, val: 'link_url' }, rt.ArrayItem{ key: none, val: 'link_image' }, rt.ArrayItem{ key: none, val: 'link_rss' }, rt.ArrayItem{ key: none, val: 'comment_url' }, rt.ArrayItem{ key: none, val: 'post_guid' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
				rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_strip_all_tags')])
			}
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('esc_url')])
			if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
				rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wp_kses_data')])
			}
		}
	}
	rt.call_function('add_filter', [rt.new_string('pre_term_slug'), rt.new_string('sanitize_title')])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'), rt.new_string('_wp_customize_changeset_filter_insert_post_data'), rt.new_int(10), rt.new_int(2)])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'pre_post_type' }, rt.ArrayItem{ key: none, val: 'pre_post_status' }, rt.ArrayItem{ key: none, val: 'pre_post_comment_status' }, rt.ArrayItem{ key: none, val: 'pre_post_ping_status' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('sanitize_key')])
		}
	}
	rt.call_function('add_filter', [rt.new_string('pre_post_mime_type'), rt.new_string('sanitize_mime_type')])
	rt.call_function('add_filter', [rt.new_string('post_mime_type'), rt.new_string('sanitize_mime_type')])
	rt.call_function('add_filter', [rt.new_string('register_meta_args'), rt.new_string('_wp_register_meta_args_allowed_list'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.new_string('wp_schedule_update_user_counts')])
	rt.call_function('add_action', [rt.new_string('wp_update_user_counts'), rt.new_string('wp_schedule_update_user_counts'), rt.new_int(10), rt.new_int(0)])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'user_register' }, rt.ArrayItem{ key: none, val: 'deleted_user' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			rt.call_function('add_action', [var_action.dup(), rt.new_string('wp_maybe_update_user_counts'), rt.new_int(10), rt.new_int(0)])
		}
	}
	rt.call_function('add_action', [rt.new_string('added_post_meta'), rt.new_string('wp_cache_set_posts_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_post_meta'), rt.new_string('wp_cache_set_posts_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_post_meta'), rt.new_string('wp_cache_set_posts_last_changed')])
	rt.call_function('add_action', [rt.new_string('added_user_meta'), rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_user_meta'), rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_user_meta'), rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('add_user_role'), rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('set_user_role'), rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('remove_user_role'), rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('added_term_meta'), rt.new_string('wp_cache_set_terms_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_term_meta'), rt.new_string('wp_cache_set_terms_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_term_meta'), rt.new_string('wp_cache_set_terms_last_changed')])
	rt.call_function('add_filter', [rt.new_string('get_term_metadata'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('add_term_metadata'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_term_metadata'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('delete_term_metadata'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('get_term_metadata_by_mid'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_term_metadata_by_mid'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('delete_term_metadata_by_mid'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_term_metadata_cache'), rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_action', [rt.new_string('added_comment_meta'), rt.new_string('wp_cache_set_comments_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_comment_meta'), rt.new_string('wp_cache_set_comments_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_comment_meta'), rt.new_string('wp_cache_set_comments_last_changed')])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('wp_create_initial_comment_meta')])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'content_save_pre' }, rt.ArrayItem{ key: none, val: 'excerpt_save_pre' }, rt.ArrayItem{ key: none, val: 'comment_save_pre' }, rt.ArrayItem{ key: none, val: 'pre_comment_content' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('convert_invalid_entities')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('balanceTags'), rt.new_int(50)])
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'comment_author' }, rt.ArrayItem{ key: none, val: 'term_name' }, rt.ArrayItem{ key: none, val: 'link_name' }, rt.ArrayItem{ key: none, val: 'link_description' }, rt.ArrayItem{ key: none, val: 'link_notes' }, rt.ArrayItem{ key: none, val: 'bloginfo' }, rt.ArrayItem{ key: none, val: 'wp_title' }, rt.ArrayItem{ key: none, val: 'document_title' }, rt.ArrayItem{ key: none, val: 'widget_title' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wptexturize')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('convert_chars')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('esc_html')])
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'the_content' }, rt.ArrayItem{ key: none, val: 'the_title' }, rt.ArrayItem{ key: none, val: 'wp_title' }, rt.ArrayItem{ key: none, val: 'document_title' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('capital_P_dangit'), rt.new_int(11)])
		}
	}
	rt.call_function('add_filter', [rt.new_string('comment_text'), rt.new_string('capital_P_dangit'), rt.new_int(31)])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'single_post_title' }, rt.ArrayItem{ key: none, val: 'single_cat_title' }, rt.ArrayItem{ key: none, val: 'single_tag_title' }, rt.ArrayItem{ key: none, val: 'single_month_title' }, rt.ArrayItem{ key: none, val: 'nav_menu_attr_title' }, rt.ArrayItem{ key: none, val: 'nav_menu_description' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wptexturize')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('strip_tags')])
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'term_description' }, rt.ArrayItem{ key: none, val: 'get_the_post_type_description' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_filter := item_1.val
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wptexturize')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('convert_chars')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('wpautop')])
			rt.call_function('add_filter', [var_filter.dup(), rt.new_string('shortcode_unautop')])
		}
	}
	rt.call_function('add_filter', [rt.new_string('term_name_rss'), rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_parent'), rt.new_string('wp_check_post_hierarchy_for_loops'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_update_term_parent'), rt.new_string('wp_check_term_hierarchy_for_loops'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('the_title'), rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('the_title'), rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('the_title'), rt.new_string('trim')])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('apply_block_hooks_to_content_from_post_object'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('do_blocks'), rt.new_int(9)])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('convert_smilies'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('wpautop')])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('shortcode_unautop')])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('prepend_attachment')])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('wp_replace_insecure_home_url')])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('do_shortcode'), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.new_string('wp_filter_content_tags'), rt.new_int(12)])
	rt.call_function('add_filter', [, ])
	
}
