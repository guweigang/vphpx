import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'pre_term_name' },
		rt.ArrayItem{ key: none, val: 'pre_comment_author_name' },
		rt.ArrayItem{ key: none, val: 'pre_link_name' }, rt.ArrayItem{
			key: none
			val: 'pre_link_target'
		}, rt.ArrayItem{ key: none, val: 'pre_link_rel' }, rt.ArrayItem{
			key: none
			val: 'pre_user_display_name'
		}, rt.ArrayItem{ key: none, val: 'pre_user_first_name' },
		rt.ArrayItem{ key: none, val: 'pre_user_last_name' },
		rt.ArrayItem{ key: none, val: 'pre_user_nickname' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_filter := item_1.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('sanitize_text_field')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wp_filter_kses')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('_wp_specialchars'),
			rt.new_int(30)])
	}
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'term_name' },
		rt.ArrayItem{ key: none, val: 'comment_author_name' },
		rt.ArrayItem{ key: none, val: 'link_name' }, rt.ArrayItem{ key: none, val: 'link_target' },
		rt.ArrayItem{ key: none, val: 'link_rel' }, rt.ArrayItem{
			key: none
			val: 'user_display_name'
		}, rt.ArrayItem{ key: none, val: 'user_first_name' },
		rt.ArrayItem{ key: none, val: 'user_last_name' }, rt.ArrayItem{
			key: none
			val: 'user_nickname'
		}]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_filter := item_2.val
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_function('add_filter', [var_filter.clone(),
				rt.new_string('sanitize_text_field')])
			rt.call_function('add_filter', [var_filter.clone(),
				rt.new_string('wp_kses_data')])
		}
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('_wp_specialchars'),
			rt.new_int(30)])
	}
	mut iter_3 := rt.create_array([
		rt.ArrayItem{ key: none, val: 'pre_term_description' },
		rt.ArrayItem{ key: none, val: 'pre_link_description' },
		rt.ArrayItem{ key: none, val: 'pre_link_notes' },
		rt.ArrayItem{ key: none, val: 'pre_user_description' },
	]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_filter := item_3.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wp_filter_kses')])
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		mut iter_4 := rt.create_array([
			rt.ArrayItem{ key: none, val: 'term_description' },
			rt.ArrayItem{ key: none, val: 'link_description' },
			rt.ArrayItem{ key: none, val: 'link_notes' },
			rt.ArrayItem{ key: none, val: 'user_description' },
		]).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_filter := item_4.val
			rt.call_function('add_filter', [var_filter.clone(),
				rt.new_string('wp_kses_data')])
		}
		rt.call_function('add_filter', [rt.new_string('comment_text'),
			rt.new_string('wp_kses_post')])
	}
	mut iter_5 := rt.create_array([
		rt.ArrayItem{ key: none, val: 'pre_comment_author_email' },
		rt.ArrayItem{ key: none, val: 'pre_user_email' },
	]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_filter := item_5.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('trim')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('sanitize_email')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wp_filter_kses')])
	}
	mut iter_6 := rt.create_array([
		rt.ArrayItem{ key: none, val: 'comment_author_email' },
		rt.ArrayItem{ key: none, val: 'user_email' },
	]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_filter := item_6.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('sanitize_email')])
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_function('add_filter', [var_filter.clone(),
				rt.new_string('wp_kses_data')])
		}
	}
	mut iter_7 := rt.create_array([
		rt.ArrayItem{ key: none, val: 'pre_comment_author_url' },
		rt.ArrayItem{ key: none, val: 'pre_user_url' },
		rt.ArrayItem{ key: none, val: 'pre_link_url' },
		rt.ArrayItem{ key: none, val: 'pre_link_image' },
		rt.ArrayItem{ key: none, val: 'pre_link_rss' },
		rt.ArrayItem{ key: none, val: 'pre_post_guid' },
	]).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_filter := item_7.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wp_strip_all_tags')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('sanitize_url')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wp_filter_kses')])
	}
	mut iter_8 := rt.create_array([rt.ArrayItem{ key: none, val: 'user_url' },
		rt.ArrayItem{ key: none, val: 'link_url' }, rt.ArrayItem{ key: none, val: 'link_image' },
		rt.ArrayItem{ key: none, val: 'link_rss' }, rt.ArrayItem{ key: none, val: 'comment_url' },
		rt.ArrayItem{ key: none, val: 'post_guid' }]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_filter := item_8.val
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_function('add_filter', [var_filter.clone(),
				rt.new_string('wp_strip_all_tags')])
		}
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('esc_url')])
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_function('add_filter', [var_filter.clone(),
				rt.new_string('wp_kses_data')])
		}
	}
	rt.call_function('add_filter', [rt.new_string('pre_term_slug'),
		rt.new_string('sanitize_title')])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'),
		rt.new_string('_wp_customize_changeset_filter_insert_post_data'),
		rt.new_int(10), rt.new_int(2)])
	mut iter_9 := rt.create_array([rt.ArrayItem{ key: none, val: 'pre_post_type' },
		rt.ArrayItem{ key: none, val: 'pre_post_status' }, rt.ArrayItem{
			key: none
			val: 'pre_post_comment_status'
		}, rt.ArrayItem{ key: none, val: 'pre_post_ping_status' }]).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_filter := item_9.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('sanitize_key')])
	}
	rt.call_function('add_filter', [rt.new_string('pre_post_mime_type'),
		rt.new_string('sanitize_mime_type')])
	rt.call_function('add_filter', [rt.new_string('post_mime_type'),
		rt.new_string('sanitize_mime_type')])
	rt.call_function('add_filter', [rt.new_string('register_meta_args'),
		rt.new_string('_wp_register_meta_args_allowed_list'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('wp_schedule_update_user_counts')])
	rt.call_function('add_action', [rt.new_string('wp_update_user_counts'),
		rt.new_string('wp_schedule_update_user_counts'), rt.new_int(10),
		rt.new_int(0)])
	mut iter_10 := rt.create_array([rt.ArrayItem{ key: none, val: 'user_register' },
		rt.ArrayItem{ key: none, val: 'deleted_user' }]).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_action := item_10.val
		rt.call_function('add_action', [var_action.clone(), rt.new_string('wp_maybe_update_user_counts'),
			rt.new_int(10), rt.new_int(0)])
	}
	rt.call_function('add_action', [rt.new_string('added_post_meta'),
		rt.new_string('wp_cache_set_posts_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_post_meta'),
		rt.new_string('wp_cache_set_posts_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_post_meta'),
		rt.new_string('wp_cache_set_posts_last_changed')])
	rt.call_function('add_action', [rt.new_string('added_user_meta'),
		rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_user_meta'),
		rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_user_meta'),
		rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('add_user_role'),
		rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('set_user_role'),
		rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('remove_user_role'),
		rt.new_string('wp_cache_set_users_last_changed')])
	rt.call_function('add_action', [rt.new_string('added_term_meta'),
		rt.new_string('wp_cache_set_terms_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_term_meta'),
		rt.new_string('wp_cache_set_terms_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_term_meta'),
		rt.new_string('wp_cache_set_terms_last_changed')])
	rt.call_function('add_filter', [rt.new_string('get_term_metadata'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('add_term_metadata'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_term_metadata'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('delete_term_metadata'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('get_term_metadata_by_mid'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_term_metadata_by_mid'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('delete_term_metadata_by_mid'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_filter', [rt.new_string('update_term_metadata_cache'),
		rt.new_string('wp_check_term_meta_support_prefilter')])
	rt.call_function('add_action', [rt.new_string('added_comment_meta'),
		rt.new_string('wp_cache_set_comments_last_changed')])
	rt.call_function('add_action', [rt.new_string('updated_comment_meta'),
		rt.new_string('wp_cache_set_comments_last_changed')])
	rt.call_function('add_action', [rt.new_string('deleted_comment_meta'),
		rt.new_string('wp_cache_set_comments_last_changed')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('wp_create_initial_comment_meta')])
	mut iter_11 := rt.create_array([rt.ArrayItem{ key: none, val: 'content_save_pre' },
		rt.ArrayItem{ key: none, val: 'excerpt_save_pre' }, rt.ArrayItem{
			key: none
			val: 'comment_save_pre'
		}, rt.ArrayItem{ key: none, val: 'pre_comment_content' }]).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_filter := item_11.val
		rt.call_function('add_filter',
			[var_filter.clone(), rt.new_string('convert_invalid_entities')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('balanceTags'),
			rt.new_int(50)])
	}
	mut iter_12 := rt.create_array([rt.ArrayItem{ key: none, val: 'comment_author' },
		rt.ArrayItem{ key: none, val: 'term_name' }, rt.ArrayItem{ key: none, val: 'link_name' },
		rt.ArrayItem{ key: none, val: 'link_description' }, rt.ArrayItem{
			key: none
			val: 'link_notes'
		}, rt.ArrayItem{ key: none, val: 'bloginfo' }, rt.ArrayItem{ key: none, val: 'wp_title' },
		rt.ArrayItem{ key: none, val: 'document_title' }, rt.ArrayItem{
			key: none
			val: 'widget_title'
		}]).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_filter := item_12.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wptexturize')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('convert_chars')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('esc_html')])
	}
	mut iter_13 := rt.create_array([rt.ArrayItem{ key: none, val: 'the_content' },
		rt.ArrayItem{ key: none, val: 'the_title' }, rt.ArrayItem{ key: none, val: 'wp_title' },
		rt.ArrayItem{ key: none, val: 'document_title' }]).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_filter := item_13.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('capital_P_dangit'),
			rt.new_int(11)])
	}
	rt.call_function('add_filter', [rt.new_string('comment_text'),
		rt.new_string('capital_P_dangit'), rt.new_int(31)])
	mut iter_14 := rt.create_array([rt.ArrayItem{ key: none, val: 'single_post_title' },
		rt.ArrayItem{ key: none, val: 'single_cat_title' }, rt.ArrayItem{
			key: none
			val: 'single_tag_title'
		}, rt.ArrayItem{ key: none, val: 'single_month_title' },
		rt.ArrayItem{ key: none, val: 'nav_menu_attr_title' },
		rt.ArrayItem{ key: none, val: 'nav_menu_description' }]).iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_filter := item_14.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wptexturize')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('strip_tags')])
	}
	mut iter_15 := rt.create_array([rt.ArrayItem{ key: none, val: 'term_description' },
		rt.ArrayItem{ key: none, val: 'get_the_post_type_description' }]).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_filter := item_15.val
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wptexturize')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('convert_chars')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('wpautop')])
		rt.call_function('add_filter', [var_filter.clone(), rt.new_string('shortcode_unautop')])
	}
	rt.call_function('add_filter', [rt.new_string('term_name_rss'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_parent'),
		rt.new_string('wp_check_post_hierarchy_for_loops'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_update_term_parent'),
		rt.new_string('wp_check_term_hierarchy_for_loops'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('the_title'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('the_title'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('the_title'),
		rt.new_string('trim')])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('apply_block_hooks_to_content_from_post_object'),
		rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('do_blocks'), rt.new_int(9)])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('convert_smilies'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('wpautop')])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('shortcode_unautop')])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('prepend_attachment')])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('wp_replace_insecure_home_url')])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('do_shortcode'), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('wp_filter_content_tags'), rt.new_int(12)])
	rt.call_function('add_filter', [rt.new_string('the_excerpt'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt'),
		rt.new_string('convert_smilies')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt'),
		rt.new_string('wpautop')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt'),
		rt.new_string('shortcode_unautop')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt'),
		rt.new_string('wp_replace_insecure_home_url')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt'),
		rt.new_string('wp_filter_content_tags'), rt.new_int(12)])
	rt.call_function('add_filter', [rt.new_string('get_the_excerpt'),
		rt.new_string('wp_trim_excerpt'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('the_post_thumbnail_caption'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('the_post_thumbnail_caption'),
		rt.new_string('convert_smilies')])
	rt.call_function('add_filter', [rt.new_string('the_post_thumbnail_caption'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('comment_text'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('comment_text'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('comment_text'),
		rt.new_string('make_clickable'), rt.new_int(9)])
	rt.call_function('add_filter', [rt.new_string('comment_text'),
		rt.new_string('force_balance_tags'), rt.new_int(25)])
	rt.call_function('add_filter', [rt.new_string('comment_text'),
		rt.new_string('convert_smilies'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('comment_text'),
		rt.new_string('wpautop'), rt.new_int(30)])
	rt.call_function('add_filter', [rt.new_string('comment_excerpt'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('list_cats'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('wp_sprintf'),
		rt.new_string('wp_sprintf_l'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('widget_text'),
		rt.new_string('balanceTags')])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('capital_P_dangit'), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('convert_smilies'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('wpautop')])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('shortcode_unautop')])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('wp_replace_insecure_home_url')])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('do_shortcode'), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('widget_text_content'),
		rt.new_string('wp_filter_content_tags'), rt.new_int(12)])
	rt.call_function('add_filter', [rt.new_string('widget_block_content'),
		rt.new_string('do_blocks'), rt.new_int(9)])
	rt.call_function('add_filter', [rt.new_string('widget_block_content'),
		rt.new_string('do_shortcode'), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('widget_block_content'),
		rt.new_string('wp_filter_content_tags'), rt.new_int(12)])
	rt.call_function('add_filter', [rt.new_string('block_type_metadata'),
		rt.new_string('wp_migrate_old_typography_shape')])
	rt.call_function('add_filter', [rt.new_string('wp_get_custom_css'),
		rt.new_string('wp_replace_insecure_home_url')])
	rt.call_function('add_filter', [rt.new_string('the_title_rss'),
		rt.new_string('strip_tags')])
	rt.call_function('add_filter', [rt.new_string('the_title_rss'),
		rt.new_string('ent2ncr'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('the_title_rss'),
		rt.new_string('esc_html')])
	rt.call_function('add_filter', [rt.new_string('the_content_rss'),
		rt.new_string('ent2ncr'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('the_content_feed'),
		rt.new_string('wp_staticize_emoji')])
	rt.call_function('add_filter', [rt.new_string('the_content_feed'),
		rt.new_string('_oembed_filter_feed_content')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt_rss'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt_rss'),
		rt.new_string('ent2ncr'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('comment_author_rss'),
		rt.new_string('ent2ncr'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('comment_text_rss'),
		rt.new_string('ent2ncr'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('comment_text_rss'),
		rt.new_string('esc_html')])
	rt.call_function('add_filter', [rt.new_string('comment_text_rss'),
		rt.new_string('wp_staticize_emoji')])
	rt.call_function('add_filter', [rt.new_string('bloginfo_rss'),
		rt.new_string('ent2ncr'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('the_author'),
		rt.new_string('ent2ncr'), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('the_guid'),
		rt.new_string('esc_url')])
	rt.call_function('add_filter', [rt.new_string('wp_mail'),
		rt.new_string('wp_staticize_emoji_for_email')])
	rt.call_function('add_filter', [rt.new_string('wp_robots'),
		rt.new_string('wp_robots_noindex')])
	rt.call_function('add_filter', [rt.new_string('wp_robots'),
		rt.new_string('wp_robots_noindex_embeds')])
	rt.call_function('add_filter', [rt.new_string('wp_robots'),
		rt.new_string('wp_robots_noindex_search')])
	rt.call_function('add_filter', [rt.new_string('wp_robots'),
		rt.new_string('wp_robots_max_image_preview_large')])
	mut iter_16 := rt.create_array([rt.ArrayItem{ key: none, val: 'publish_post' },
		rt.ArrayItem{ key: none, val: 'publish_page' }, rt.ArrayItem{
			key: none
			val: 'wp_ajax_save-widget'
		}, rt.ArrayItem{ key: none, val: 'wp_ajax_widgets-order' },
		rt.ArrayItem{ key: none, val: 'customize_save_after' },
		rt.ArrayItem{ key: none, val: 'rest_after_save_widget' },
		rt.ArrayItem{ key: none, val: 'rest_delete_widget' },
		rt.ArrayItem{ key: none, val: 'rest_save_sidebar' }]).iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_action := item_16.val
		rt.call_function('add_action', [var_action.clone(), rt.new_string('_delete_option_fresh_site'),
			rt.new_int(0)])
	}
	rt.call_function('add_filter', [rt.new_string('wp_default_autoload_value'),
		rt.new_string('wp_filter_default_autoload_value_via_option_size'),
		rt.new_int(5), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('option_ping_sites'),
		rt.new_string('privacy_ping_filter')])
	rt.call_function('add_filter', [rt.new_string('option_blog_charset'),
		rt.new_string('_wp_specialchars')])
	rt.call_function('add_filter', [rt.new_string('option_blog_charset'),
		rt.new_string('_canonical_charset')])
	rt.call_function('add_filter', [rt.new_string('option_home'),
		rt.new_string('_config_wp_home')])
	rt.call_function('add_filter', [rt.new_string('option_siteurl'),
		rt.new_string('_config_wp_siteurl')])
	rt.call_function('add_filter', [rt.new_string('tiny_mce_before_init'),
		rt.new_string('_mce_set_direction')])
	rt.call_function('add_filter', [rt.new_string('teeny_mce_before_init'),
		rt.new_string('_mce_set_direction')])
	rt.call_function('add_filter', [rt.new_string('pre_kses'),
		rt.new_string('wp_pre_kses_less_than')])
	rt.call_function('add_filter', [rt.new_string('pre_kses'),
		rt.new_string('wp_pre_kses_block_attributes'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('sanitize_title'),
		rt.new_string('sanitize_title_with_dashes'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('check_comment_flood'),
		rt.new_string('check_comment_flood_db'), rt.new_int(10),
		rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('comment_flood_filter'),
		rt.new_string('wp_throttle_comment_flood'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('pre_comment_content'),
		rt.new_string('wp_rel_ugc'), rt.new_int(15)])
	rt.call_function('add_filter', [rt.new_string('comment_email'),
		rt.new_string('antispambot')])
	rt.call_function('add_filter', [rt.new_string('option_tag_base'),
		rt.new_string('_wp_filter_taxonomy_base')])
	rt.call_function('add_filter', [rt.new_string('option_category_base'),
		rt.new_string('_wp_filter_taxonomy_base')])
	rt.call_function('add_filter', [rt.new_string('the_posts'),
		rt.new_string('_close_comments_for_old_posts'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comments_open'),
		rt.new_string('_close_comments_for_old_post'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('pings_open'),
		rt.new_string('_close_comments_for_old_post'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('editable_slug'),
		rt.new_string('urldecode')])
	rt.call_function('add_filter', [rt.new_string('editable_slug'),
		rt.new_string('esc_textarea')])
	rt.call_function('add_filter', [rt.new_string('pingback_ping_source_uri'),
		rt.new_string('pingback_ping_source_uri')])
	rt.call_function('add_filter', [rt.new_string('xmlrpc_pingback_error'),
		rt.new_string('xmlrpc_pingback_error')])
	rt.call_function('add_filter', [rt.new_string('title_save_pre'),
		rt.new_string('trim')])
	rt.call_function('add_action', [rt.new_string('transition_comment_status'),
		rt.new_string('_clear_modified_cache_on_transition_comment_status'),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('http_request_host_is_external'),
		rt.new_string('allowed_http_request_hosts'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('xmlrpc_rsd_apis'),
		rt.new_string('rest_output_rsd')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('rest_output_link_wp_head'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('rest_output_link_header'), rt.new_int(11),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('auth_cookie_malformed'),
		rt.new_string('rest_cookie_collect_status')])
	rt.call_function('add_action', [rt.new_string('auth_cookie_expired'),
		rt.new_string('rest_cookie_collect_status')])
	rt.call_function('add_action', [rt.new_string('auth_cookie_bad_username'),
		rt.new_string('rest_cookie_collect_status')])
	rt.call_function('add_action', [rt.new_string('auth_cookie_bad_hash'),
		rt.new_string('rest_cookie_collect_status')])
	rt.call_function('add_action', [rt.new_string('auth_cookie_valid'),
		rt.new_string('rest_cookie_collect_status')])
	rt.call_function('add_action', [
		rt.new_string('application_password_failed_authentication'),
		rt.new_string('rest_application_password_collect_status'),
	])
	rt.call_function('add_action', [
		rt.new_string('application_password_did_authenticate'),
		rt.new_string('rest_application_password_collect_status'),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_filter', [rt.new_string('rest_authentication_errors'),
		rt.new_string('rest_application_password_check_errors'),
		rt.new_int(90)])
	rt.call_function('add_filter', [rt.new_string('rest_authentication_errors'),
		rt.new_string('rest_cookie_check_errors'), rt.new_int(100)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('_wp_render_title_tag'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_enqueue_scripts'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_resource_hints'), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_preload_resources'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('feed_links'), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('feed_links_extra'), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('rsd_link')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('locale_stylesheet')])
	rt.call_function('add_action', [rt.new_string('publish_future_post'),
		rt.new_string('check_and_publish_future_post'), rt.new_int(10),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_robots'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('print_emoji_detection_script'), rt.new_int(7)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_print_styles'), rt.new_int(8)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_print_head_scripts'), rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_generator')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('rel_canonical')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_shortlink_wp_head'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_custom_css_cb'), rt.new_int(101)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_site_icon'), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_print_speculation_rules')])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_print_footer_scripts'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('wp_shortlink_header'), rt.new_int(11),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
		rt.new_string('_wp_footer_scripts')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('_register_core_block_patterns_and_categories')])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('check_theme_switched'),
		rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Block_Supports' },
			rt.ArrayItem{ key: none, val: 'init' }]),
		rt.new_int(22)])
	rt.call_function('add_action', [rt.new_string('switch_theme'),
		rt.new_string('wp_clean_theme_json_cache')])
	rt.call_function('add_action', [rt.new_string('start_previewing_theme'),
		rt.new_string('wp_clean_theme_json_cache')])
	rt.call_function('add_action', [rt.new_string('after_switch_theme'),
		rt.new_string('_wp_menus_changed')])
	rt.call_function('add_action', [rt.new_string('after_switch_theme'),
		rt.new_string('_wp_sidebars_changed')])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_emoji_styles')])
	rt.call_function('add_action', [rt.new_string('wp_print_styles'),
		rt.new_string('print_emoji_styles')])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('replytocom'))
		|| (rt.get_superglobal('_GET').array_isset(rt.new_string('unapproved'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('moderation-hash'))) {
		rt.call_function('add_filter', [rt.new_string('wp_robots'),
			rt.new_string('wp_robots_no_robots')])
	}
	rt.call_function('add_action', [rt.new_string('login_head'),
		rt.new_string('wp_robots'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('login_head'),
		rt.new_string('wp_resource_hints'), rt.new_int(8)])
	rt.call_function('add_action', [rt.new_string('login_head'),
		rt.new_string('wp_print_head_scripts'), rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('login_head'),
		rt.new_string('print_admin_styles'), rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('login_head'),
		rt.new_string('wp_site_icon'), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('login_footer'),
		rt.new_string('wp_print_footer_scripts'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('login_init'),
		rt.new_string('send_frame_options_header'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('login_init'),
		rt.new_string('wp_admin_headers')])
	mut iter_17 := rt.create_array([rt.ArrayItem{ key: none, val: 'rss2_head' },
		rt.ArrayItem{ key: none, val: 'commentsrss2_head' }, rt.ArrayItem{
			key: none
			val: 'rss_head'
		}, rt.ArrayItem{ key: none, val: 'rdf_header' }, rt.ArrayItem{ key: none, val: 'atom_head' },
		rt.ArrayItem{ key: none, val: 'comments_atom_head' },
		rt.ArrayItem{ key: none, val: 'opml_head' }, rt.ArrayItem{ key: none, val: 'app_head' }]).iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_action := item_17.val
		rt.call_function('add_action', [var_action.clone(), rt.new_string('the_generator')])
	}
	rt.call_function('add_action', [rt.new_string('atom_head'),
		rt.new_string('atom_site_icon')])
	rt.call_function('add_action', [rt.new_string('rss2_head'),
		rt.new_string('rss2_site_icon')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('DOING_CRON'),
	])))))
	{
		rt.call_function('add_action', [rt.new_string('init'),
			rt.new_string('wp_cron')])
	}
	rt.call_function('add_action', [rt.new_string('update_option_home'),
		rt.new_string('wp_update_https_migration_required'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('do_feed_rdf'),
		rt.new_string('do_feed_rdf'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('do_feed_rss'),
		rt.new_string('do_feed_rss'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('do_feed_rss2'),
		rt.new_string('do_feed_rss2'), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('do_feed_atom'),
		rt.new_string('do_feed_atom'), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('do_pings'),
		rt.new_string('do_all_pings'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('do_all_pings'),
		rt.new_string('do_all_pingbacks'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('do_all_pings'),
		rt.new_string('do_all_enclosures'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('do_all_pings'),
		rt.new_string('do_all_trackbacks'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('do_all_pings'),
		rt.new_string('generic_ping'), rt.new_int(10), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('do_robots'),
		rt.new_string('do_robots')])
	rt.call_function('add_action', [rt.new_string('do_favicon'),
		rt.new_string('do_favicon')])
	rt.call_function('add_action', [rt.new_string('wp_before_include_template'),
		rt.new_string('wp_start_template_enhancement_output_buffer'),
		rt.new_int(1000)])
	rt.call_function('add_action', [rt.new_string('set_comment_cookies'),
		rt.new_string('wp_set_comment_cookies'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('sanitize_comment_cookies'),
		rt.new_string('sanitize_comment_cookies')])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('smilies_init'),
		rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.new_string('wp_maybe_load_widgets'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.new_string('wp_maybe_load_embeds'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.new_string('wp_ob_end_flush_all'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_after_insert_post'),
		rt.new_string('wp_save_post_revision_on_insert'), rt.new_int(9),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('post_updated'),
		rt.new_string('wp_save_post_revision'), rt.new_int(10),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('publish_post'),
		rt.new_string('_publish_post_hook'), rt.new_int(5), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('_transition_post_status'), rt.new_int(5),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('_update_term_count_on_transition_post_status'),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('comment_form'),
		rt.new_string('wp_comment_form_unfiltered_html_nonce')])
	rt.call_function('add_action', [rt.new_string('user_request_action_confirmed'),
		rt.new_string('_wp_privacy_account_request_confirmed')])
	rt.call_function('add_action', [rt.new_string('user_request_action_confirmed'),
		rt.new_string('_wp_privacy_send_request_confirmation_notification'),
		rt.new_int(12)])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_exporters'),
		rt.new_string('wp_register_comment_personal_data_exporter')])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_exporters'),
		rt.new_string('wp_register_media_personal_data_exporter')])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_exporters'),
		rt.new_string('wp_register_user_personal_data_exporter'),
		rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_erasers'),
		rt.new_string('wp_register_comment_personal_data_eraser')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('wp_schedule_delete_old_privacy_export_files')])
	rt.call_function('add_action', [rt.new_string('wp_privacy_delete_old_export_files'),
		rt.new_string('wp_privacy_delete_old_export_files')])
	rt.call_function('add_action', [rt.new_string('wp_scheduled_delete'),
		rt.new_string('wp_scheduled_delete')])
	rt.call_function('add_action', [rt.new_string('wp_scheduled_auto_draft_delete'),
		rt.new_string('wp_delete_auto_drafts')])
	rt.call_function('add_action', [rt.new_string('importer_scheduled_cleanup'),
		rt.new_string('wp_delete_attachment')])
	rt.call_function('add_action', [rt.new_string('upgrader_scheduled_cleanup'),
		rt.new_string('wp_delete_attachment')])
	rt.call_function('add_action', [rt.new_string('delete_expired_transients'),
		rt.new_string('delete_expired_transients')])
	rt.call_function('add_action', [rt.new_string('delete_post'),
		rt.new_string('_wp_delete_post_menu_item')])
	rt.call_function('add_action', [rt.new_string('delete_term'),
		rt.new_string('_wp_delete_tax_menu_item'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('_wp_auto_add_pages_to_menu'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('delete_post'),
		rt.new_string('_wp_delete_customize_changeset_dependent_auto_drafts')])
	rt.call_function('add_action', [rt.new_string('begin_fetch_post_thumbnail_html'),
		rt.new_string('_wp_post_thumbnail_class_filter_add')])
	rt.call_function('add_action', [rt.new_string('end_fetch_post_thumbnail_html'),
		rt.new_string('_wp_post_thumbnail_class_filter_remove')])
	rt.call_function('add_action', [rt.new_string('begin_fetch_post_thumbnail_html'),
		rt.new_string('_wp_post_thumbnail_context_filter_add')])
	rt.call_function('add_action', [rt.new_string('end_fetch_post_thumbnail_html'),
		rt.new_string('_wp_post_thumbnail_context_filter_remove')])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('wp_old_slug_redirect')])
	rt.call_function('add_action', [rt.new_string('post_updated'),
		rt.new_string('wp_check_for_changed_slugs'), rt.new_int(12),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('attachment_updated'),
		rt.new_string('wp_check_for_changed_slugs'), rt.new_int(12),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('post_updated'),
		rt.new_string('wp_check_for_changed_dates'), rt.new_int(12),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('attachment_updated'),
		rt.new_string('wp_check_for_changed_dates'), rt.new_int(12),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('_show_post_preview')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_post_preview_js'), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('pre_option_gmt_offset'),
		rt.new_string('wp_timezone_override_offset')])
	rt.call_function('add_filter', [rt.new_string('default_option_link_manager_enabled'),
		rt.new_string('__return_true')])
	rt.call_function('add_filter', [rt.new_string('pre_option_embed_autourls'),
		rt.new_string('__return_true')])
	rt.call_function('add_filter', [rt.new_string('heartbeat_settings'),
		rt.new_string('wp_heartbeat_settings')])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('wp_auth_check_load')])
	rt.call_function('add_filter', [rt.new_string('heartbeat_send'),
		rt.new_string('wp_auth_check')])
	rt.call_function('add_filter', [rt.new_string('heartbeat_nopriv_send'),
		rt.new_string('wp_auth_check')])
	rt.call_function('add_filter', [rt.new_string('authenticate'),
		rt.new_string('wp_authenticate_username_password'), rt.new_int(20),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('authenticate'),
		rt.new_string('wp_authenticate_email_password'), rt.new_int(20),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('authenticate'),
		rt.new_string('wp_authenticate_application_password'),
		rt.new_int(20), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('authenticate'),
		rt.new_string('wp_authenticate_spam_check'), rt.new_int(99)])
	rt.call_function('add_filter', [rt.new_string('determine_current_user'),
		rt.new_string('wp_validate_auth_cookie')])
	rt.call_function('add_filter', [rt.new_string('determine_current_user'),
		rt.new_string('wp_validate_logged_in_cookie'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('determine_current_user'),
		rt.new_string('wp_validate_application_password'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('_wp_check_for_scheduled_split_terms')])
	rt.call_function('add_action', [rt.new_string('split_shared_term'),
		rt.new_string('_wp_check_split_default_terms'), rt.new_int(10),
		rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('split_shared_term'),
		rt.new_string('_wp_check_split_terms_in_menus'), rt.new_int(10),
		rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('split_shared_term'),
		rt.new_string('_wp_check_split_nav_menu_terms'), rt.new_int(10),
		rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('wp_split_shared_term_batch'),
		rt.new_string('_wp_batch_split_terms')])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('_wp_check_for_scheduled_update_comment_type')])
	rt.call_function('add_action', [rt.new_string('wp_update_comment_type_batch'),
		rt.new_string('_wp_batch_update_comment_type')])
	rt.call_function('add_action', [rt.new_string('comment_post'),
		rt.new_string('wp_new_comment_notify_moderator')])
	rt.call_function('add_action', [rt.new_string('comment_post'),
		rt.new_string('wp_new_comment_notify_postauthor')])
	rt.call_function('add_action', [rt.new_string('rest_insert_comment'),
		rt.new_string('wp_new_comment_via_rest_notify_postauthor')])
	rt.call_function('add_action', [rt.new_string('after_password_reset'),
		rt.new_string('wp_password_change_notification')])
	rt.call_function('add_action', [rt.new_string('register_new_user'),
		rt.new_string('wp_send_new_user_notifications')])
	rt.call_function('add_action', [rt.new_string('edit_user_created_user'),
		rt.new_string('wp_send_new_user_notifications'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('rest_api_init')])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_string('rest_api_default_filters'), rt.new_int(10),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_string('register_initial_settings'), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_string('create_initial_rest_routes'), rt.new_int(99)])
	rt.call_function('add_action', [rt.new_string('parse_request'),
		rt.new_string('rest_api_loaded')])
	rt.call_function('add_action', [rt.new_string('wp_abilities_api_categories_init'),
		rt.new_string('wp_register_core_ability_categories')])
	rt.call_function('add_action', [rt.new_string('wp_abilities_api_init'),
		rt.new_string('wp_register_core_abilities')])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('_wp_connectors_init'),
		rt.new_int(15)])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('wp_sitemaps_get_server')])
	rt.call_function('add_action', [rt.new_string('setup_theme'),
		rt.new_string('create_initial_theme_features'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.new_string('_add_default_theme_supports'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.new_string('_custom_header_background_just_in_time')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('_custom_logo_header_styles')])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.new_string('_wp_customize_include')])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('_wp_customize_publish_changeset'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('_wp_customize_loader_settings')])
	rt.call_function('add_action', [rt.new_string('delete_attachment'),
		rt.new_string('_delete_attachment_theme_mod')])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('_wp_keep_alive_customize_changeset_dependent_auto_drafts'),
		rt.new_int(20), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.new_string('wp_initialize_theme_preview_hooks'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('wp_initialize_site_preview_hooks'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('save_post'),
		rt.new_string('delete_get_calendar_cache')])
	rt.call_function('add_action', [rt.new_string('delete_post'),
		rt.new_string('delete_get_calendar_cache')])
	rt.call_function('add_action', [rt.new_string('update_option_start_of_week'),
		rt.new_string('delete_get_calendar_cache')])
	rt.call_function('add_action', [rt.new_string('update_option_gmt_offset'),
		rt.new_string('delete_get_calendar_cache')])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_string('__clear_multi_author_cache')])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('create_initial_post_types'),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.new_string('_add_post_type_submenus')])
	rt.call_function('add_action', [rt.new_string('before_delete_post'),
		rt.new_string('_reset_front_page_settings_for_post')])
	rt.call_function('add_action', [rt.new_string('wp_trash_post'),
		rt.new_string('_reset_front_page_settings_for_post')])
	rt.call_function('add_action', [rt.new_string('change_locale'),
		rt.new_string('create_initial_post_types')])
	rt.call_function('add_filter', [rt.new_string('request'),
		rt.new_string('_post_format_request')])
	rt.call_function('add_filter', [rt.new_string('term_link'),
		rt.new_string('_post_format_link'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_post_format'),
		rt.new_string('_post_format_get_term')])
	rt.call_function('add_filter', [rt.new_string('get_terms'),
		rt.new_string('_post_format_get_terms'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('wp_get_object_terms'),
		rt.new_string('_post_format_wp_get_object_terms')])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('kses_init')])
	rt.call_function('add_action', [rt.new_string('set_current_user'),
		rt.new_string('kses_init')])
	rt.call_function('add_action', [rt.new_string('wp_default_scripts'),
		rt.new_string('wp_default_scripts')])
	rt.call_function('add_action', [rt.new_string('wp_default_scripts'),
		rt.new_string('wp_default_packages')])
	rt.call_function('add_action', [rt.new_string('wp_default_scripts'),
		rt.new_string('wp_default_script_modules')])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_localize_jquery_ui_datepicker'), rt.new_int(1000)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_common_block_scripts_and_styles')])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_classic_theme_styles')])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('wp_localize_jquery_ui_datepicker'), rt.new_int(1000)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('wp_common_block_scripts_and_styles')])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('wp_enqueue_command_palette_assets')])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('wp_enqueue_view_transitions_admin_css')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_assets'),
		rt.new_string('wp_enqueue_classic_theme_styles')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_assets'),
		rt.new_string('wp_enqueue_registered_block_scripts_and_styles')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_assets'),
		rt.new_string('enqueue_block_styles_assets'), rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('wp_default_styles'),
		rt.new_string('wp_load_classic_theme_block_styles_on_demand'),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('wp_enqueue_registered_block_scripts_and_styles')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('enqueue_editor_block_styles_assets')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('wp_enqueue_editor_block_directory_assets')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('wp_enqueue_editor_format_library_assets')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('wp_enqueue_block_editor_script_modules')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('wp_enqueue_global_styles_css_custom_properties')])
	rt.call_function('add_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('_wp_enqueue_auto_register_blocks')])
	rt.call_function('add_action', [rt.new_string('wp_print_scripts'),
		rt.new_string('wp_just_in_time_script_localization')])
	rt.call_function('add_filter', [rt.new_string('print_scripts_array'),
		rt.new_string('wp_prototype_before_jquery')])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_styles'),
		rt.new_string('wp_resource_hints'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.new_string('wp_check_widget_editor_deps')])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_global_styles')])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_enqueue_global_styles'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_stored_styles')])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_enqueue_stored_styles'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_default_styles'),
		rt.new_string('wp_default_styles')])
	rt.call_function('add_filter', [rt.new_string('style_loader_src'),
		rt.new_string('wp_style_loader_src'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_enqueue_img_auto_sizes_contain_css_fix'),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_print_auto_sizes_contain_css_fix'),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_maybe_inline_styles'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_maybe_inline_styles'), rt.new_int(1)])
	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('_wp_footnotes_kses_init')])
	rt.call_function('add_action', [rt.new_string('set_current_user'),
		rt.new_string('_wp_footnotes_kses_init')])
	rt.call_function('add_filter', [rt.new_string('force_filtered_html_on_import'),
		rt.new_string('_wp_footnotes_force_filtered_html_on_import_filter'),
		rt.new_int(999)])
	rt.call_function('add_filter', [rt.new_string('theme_wp_navigation_templates'),
		rt.new_string('__return_empty_array')])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('create_initial_taxonomies'),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('change_locale'),
		rt.new_string('create_initial_taxonomies')])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('redirect_canonical')])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('wp_redirect_admin_locations'), rt.new_int(1000)])
	rt.call_function('add_action', [rt.new_string('wp_playlist_scripts'),
		rt.new_string('wp_playlist_scripts')])
	rt.call_function('add_action', [rt.new_string('customize_controls_enqueue_scripts'),
		rt.new_string('wp_plupload_default_settings')])
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.new_string('_wp_add_additional_image_sizes'), rt.new_int(0)])
	rt.call_function('add_filter', [rt.new_string('plupload_default_settings'),
		rt.new_string('wp_show_heic_upload_error')])
	rt.call_function('add_filter', [rt.new_string('nav_menu_item_id'),
		rt.new_string('_nav_menu_item_id_use_once'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('nav_menu_css_class'),
		rt.new_string('wp_nav_menu_remove_menu_item_has_children_class'),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.new_string('wp_setup_widgets_block_editor'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('wp_widgets_init'),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('change_locale'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Widget_Media' },
			rt.ArrayItem{ key: none, val: 'reset_default_labels' }])])
	rt.call_function('add_action', [rt.new_string('widgets_init'),
		rt.new_string('_wp_block_theme_register_classic_sidebars'),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.new_string('_wp_admin_bar_init'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('_wp_admin_bar_init')])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_admin_bar_bump_styles')])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_admin_bar_header_styles')])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('wp_enqueue_admin_bar_header_styles')])
	rt.call_function('add_action', [rt.new_string('before_signup_header'),
		rt.new_string('_wp_admin_bar_init')])
	rt.call_function('add_action', [rt.new_string('activate_header'),
		rt.new_string('_wp_admin_bar_init')])
	rt.call_function('add_action', [rt.new_string('wp_body_open'),
		rt.new_string('wp_admin_bar_render'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('wp_admin_bar_render'), rt.new_int(1000)])
	rt.call_function('add_action', [rt.new_string('in_admin_header'),
		rt.new_string('wp_admin_bar_render'), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('media_buttons'),
		rt.new_string('media_buttons')])
	rt.call_function('add_filter', [rt.new_string('image_send_to_editor'),
		rt.new_string('image_add_caption'), rt.new_int(20), rt.new_int(8)])
	rt.call_function('add_filter', [rt.new_string('media_send_to_editor'),
		rt.new_string('image_media_send_to_editor'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.new_string('wp_oembed_register_route')])
	rt.call_function('add_filter', [rt.new_string('rest_pre_serve_request'),
		rt.new_string('_oembed_rest_pre_serve_request'), rt.new_int(10),
		rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_oembed_add_discovery_links'), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_oembed_add_discovery_links')])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_oembed_add_host_js')])
	rt.call_function('add_filter', [rt.new_string('embed_oembed_html'),
		rt.new_string('wp_maybe_enqueue_oembed_host_js')])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('enqueue_embed_scripts'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('print_emoji_detection_script')])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('wp_enqueue_embed_styles'), rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('print_embed_styles')])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('wp_print_head_scripts'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('wp_print_styles'), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('wp_robots')])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('rel_canonical')])
	rt.call_function('add_action', [rt.new_string('embed_head'),
		rt.new_string('locale_stylesheet'), rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('enqueue_embed_scripts'),
		rt.new_string('wp_enqueue_emoji_styles')])
	rt.call_function('add_action', [rt.new_string('embed_content_meta'),
		rt.new_string('print_embed_comments_button')])
	rt.call_function('add_action', [rt.new_string('embed_content_meta'),
		rt.new_string('print_embed_sharing_button')])
	rt.call_function('add_action', [rt.new_string('embed_footer'),
		rt.new_string('print_embed_sharing_dialog')])
	rt.call_function('add_action', [rt.new_string('embed_footer'),
		rt.new_string('print_embed_scripts')])
	rt.call_function('add_action', [rt.new_string('embed_footer'),
		rt.new_string('wp_print_footer_scripts'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('excerpt_more'),
		rt.new_string('wp_embed_excerpt_more'), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('the_excerpt_embed'),
		rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt_embed'),
		rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt_embed'),
		rt.new_string('wpautop')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt_embed'),
		rt.new_string('shortcode_unautop')])
	rt.call_function('add_filter', [rt.new_string('the_excerpt_embed'),
		rt.new_string('wp_embed_excerpt_attachment')])
	rt.call_function('add_filter', [rt.new_string('oembed_dataparse'),
		rt.new_string('wp_filter_oembed_iframe_title_attribute'),
		rt.new_int(5), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('oembed_dataparse'),
		rt.new_string('wp_filter_oembed_result'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('oembed_response_data'),
		rt.new_string('get_oembed_response_data_rich'), rt.new_int(10),
		rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('pre_oembed_result'),
		rt.new_string('wp_filter_pre_oembed_result'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('user_has_cap'),
		rt.new_string('wp_maybe_grant_install_languages_cap'),
		rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('user_has_cap'),
		rt.new_string('wp_maybe_grant_resume_extensions_caps'),
		rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('user_has_cap'),
		rt.new_string('wp_maybe_grant_site_health_caps'), rt.new_int(1),
		rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('render_block_context'),
		rt.new_string('_block_template_render_without_post_block_context')])
	rt.call_function('add_filter', [rt.new_string('pre_wp_unique_post_slug'),
		rt.new_string('wp_filter_wp_template_unique_post_slug'),
		rt.new_int(10), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('save_post_wp_template_part'),
		rt.new_string('wp_set_unique_slug_on_create_template_part')])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_string('wp_enqueue_block_template_skip_link')])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('the_block_template_skip_link')])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.new_string('wp_enable_block_templates'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.new_string('_add_template_loader_filters')])
	rt.call_function('add_filter', [rt.new_string('rest_wp_navigation_item_schema'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Navigation_Fallback' },
			rt.ArrayItem{ key: none, val: 'update_wp_navigation_post_schema' }])])
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.new_string('wp_render_typography_support'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('wp_register_persisted_preferences_meta')])
	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('wp_create_initial_post_meta')])
	rt.call_function('add_filter', [
		rt.new_string('wp_save_post_revision_post_has_changed'),
		rt.new_string('wp_check_revisioned_meta_fields_have_changed'),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_action', [rt.new_string('_wp_put_post_revision'),
		rt.new_string('wp_save_revisioned_meta_fields'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_creating_autosave'),
		rt.new_string('wp_autosave_post_revisioned_meta_fields')])
	rt.call_function('add_action', [rt.new_string('wp_restore_post_revision'),
		rt.new_string('wp_restore_post_revision_meta'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_string('wp_print_font_faces'), rt.new_int(50)])
	rt.call_function('add_action', [rt.new_string('deleted_post'),
		rt.new_string('_wp_after_delete_font_family'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('before_delete_post'),
		rt.new_string('_wp_before_delete_font_face'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('_wp_register_default_font_collections')])
	rt.call_function('add_filter', [rt.new_string('rest_pre_insert_wp_template'),
		rt.new_string('inject_ignored_hooked_blocks_metadata_attributes')])
	rt.call_function('add_filter', [rt.new_string('rest_pre_insert_wp_template_part'),
		rt.new_string('inject_ignored_hooked_blocks_metadata_attributes')])
	var_filter = rt.new_null()
	var_action = rt.new_null()
}
