import rt
import crypto.md5

fn wp_dashboard_setup() {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	mut var_screen := rt.new_null()
	mut var_wp_dashboard_control_callbacks := rt.new_null()
	mut var_check_browser := rt.new_null()
	mut var_check_php := rt.new_null()
	mut var_quick_draft_title := rt.new_null()
	mut var_dashboard_widgets := rt.new_null()
	mut var_widget_id := rt.new_null()
	mut var_name := rt.new_null()
	var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	var_wp_dashboard_control_callbacks = rt.new_array()
	var_check_browser = rt.new_bool(wp_check_browser_version())
	if rt.is_true(var_check_browser)
		&& rt.is_true(var_check_browser.array_get(rt.new_string('upgrade'))) {
		rt.call_function('add_filter', [
			rt.new_string('postbox_classes_dashboard_dashboard_browser_nag'),
			rt.new_string('dashboard_browser_nag_class'),
		])
		if rt.is_true(var_check_browser.array_get(rt.new_string('insecure'))) {
			wp_add_dashboard_widget(rt.new_string('dashboard_browser_nag'), rt.call_function('__', [
				rt.new_string('You are using an insecure browser!'),
			]), rt.new_string('wp_dashboard_browser_nag'), rt.new_null(), rt.new_null(), '', '')
		} else {
			wp_add_dashboard_widget(rt.new_string('dashboard_browser_nag'), rt.call_function('__', [
				rt.new_string('Your browser is out of date!'),
			]), rt.new_string('wp_dashboard_browser_nag'), rt.new_null(), rt.new_null(), '', '')
		}
	}
	var_check_php = rt.call_function('wp_check_php_version', []rt.PhpVal{})
	if rt.is_true(var_check_php)
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])) {
		if var_check_php.array_isset(rt.new_string('is_acceptable'))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_check_php.array_get(rt.new_string('is_acceptable')))))) {
			rt.call_function('add_filter', [
				rt.new_string('postbox_classes_dashboard_dashboard_php_nag'),
				rt.new_string('dashboard_php_nag_class'),
			])
			if rt.is_true(var_check_php.array_get(rt.new_string('is_lower_than_future_minimum'))) {
				wp_add_dashboard_widget(rt.new_string('dashboard_php_nag'), rt.call_function('__', [
					rt.new_string('PHP Update Required'),
				]), rt.new_string('wp_dashboard_php_nag'), rt.new_null(), rt.new_null(), '', '')
			} else {
				wp_add_dashboard_widget(rt.new_string('dashboard_php_nag'), rt.call_function('__', [
					rt.new_string('PHP Update Recommended'),
				]), rt.new_string('wp_dashboard_php_nag'), rt.new_null(), rt.new_null(), '', '')
			}
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_site_health_checks')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
			rt.new_string('WP_Site_Health'),
		])))))
		{
			rt.include_file(
				(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php',
				'4')
		}
		mut iife_temp_0 := Class_WP_Site_Health{}
		mut iife_result_0 := iife_temp_0.get_instance()
		rt.call_function('wp_enqueue_style', [rt.new_string('site-health')])
		rt.call_function('wp_enqueue_script', [rt.new_string('site-health')])
		wp_add_dashboard_widget(rt.new_string('dashboard_site_health'), rt.call_function('__', [
			rt.new_string('Site Health Status'),
		]), rt.new_string('wp_dashboard_site_health'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		wp_add_dashboard_widget(rt.new_string('dashboard_right_now'), rt.call_function('__', [
			rt.new_string('At a Glance'),
		]), rt.new_string('wp_dashboard_right_now'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		wp_add_dashboard_widget(rt.new_string('network_dashboard_right_now'), rt.call_function('__', [
			rt.new_string('Right Now'),
		]), rt.new_string('wp_network_dashboard_right_now'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{})) {
		wp_add_dashboard_widget(rt.new_string('dashboard_activity'), rt.call_function('__', [
			rt.new_string('Activity'),
		]), rt.new_string('wp_dashboard_site_activity'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('post')]), 'cap'), 'create_posts')])) {
		var_quick_draft_title = rt.call_function('sprintf', [
			rt.new_string('<span class="hide-if-no-js">%1$s</span> <span class="hide-if-js">%2$s</span>'),
			rt.call_function('__', [rt.new_string('Quick Draft')]),
			rt.call_function('__', [rt.new_string('Your Recent Drafts')]),
		])
		wp_add_dashboard_widget(rt.new_string('dashboard_quick_press'),
			var_quick_draft_title.clone(), rt.new_string('wp_dashboard_quick_press'),
			rt.new_null(), rt.new_null(), '', '')
	}
	wp_add_dashboard_widget(rt.new_string('dashboard_primary'), rt.call_function('__', [
		rt.new_string('WordPress Events and News'),
	]), rt.new_string('wp_dashboard_events_news'), rt.new_null(), rt.new_null(), '', '')
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('wp_network_dashboard_setup')])
		var_dashboard_widgets = rt.call_function('apply_filters', [
			rt.new_string('wp_network_dashboard_widgets'),
			rt.new_array(),
		])
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('wp_user_dashboard_setup')])
		var_dashboard_widgets = rt.call_function('apply_filters', [
			rt.new_string('wp_user_dashboard_widgets'),
			rt.new_array(),
		])
	} else {
		rt.call_function('do_action', [rt.new_string('wp_dashboard_setup')])
		var_dashboard_widgets = rt.call_function('apply_filters', [
			rt.new_string('wp_dashboard_widgets'),
			rt.new_array(),
		])
	}
	mut iter_1 := var_dashboard_widgets.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_widget_id_shadow := item_1.val
		var_name = if !rt.is_true(var_wp_registered_widgets.array_get(var_widget_id_shadow).array_get(rt.new_string('all_link'))) {
			var_wp_registered_widgets.array_get(var_widget_id_shadow).array_get(rt.new_string('name'))
		} else {
				(var_wp_registered_widgets.array_get(var_widget_id_shadow).array_get(rt.new_string('name'))).str() +
				rt.concat(rt.concat(rt.new_string(" <a href='"), var_wp_registered_widgets.array_get(var_widget_id_shadow).array_get(rt.new_string('all_link'))), rt.new_string("' class='edit-box open-box'>")) +
				(rt.call_function('__', [rt.new_string('View all')])).str() + '</a>'
		}
		wp_add_dashboard_widget(var_widget_id_shadow.clone(), var_name.clone(),
			var_wp_registered_widgets.array_get(var_widget_id_shadow).array_get(rt.new_string('callback')),
			var_wp_registered_widget_controls.array_get(var_widget_id_shadow).array_get(rt.new_string('callback')),
			rt.new_null(), '', '')
	}
	if rt.is_true(rt.identical(rt.new_string('POST'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('widget_id')) {
		rt.call_function('check_admin_referer', [
			rt.new_string('edit-dashboard-widget_' +
				(rt.get_superglobal('_POST').array_get(rt.new_string('widget_id'))).str()),
			rt.new_string('dashboard-widget-nonce'),
		])
		rt.call_function('ob_start', []rt.PhpVal{})
		wp_dashboard_trigger_widget_control(rt.get_superglobal('_POST').array_get(rt.new_string('widget_id')))
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		rt.call_function('wp_redirect', [
			rt.call_function('remove_query_arg', [rt.new_string('edit')]),
		])
		exit(0)
	}
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		rt.get_property(var_screen, 'id'), rt.new_string('normal'),
		rt.new_string('')])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'),
		rt.get_property(var_screen, 'id'), rt.new_string('side'),
		rt.new_string('')])
}

fn wp_add_dashboard_widget(var_widget_id rt.PhpVal, var_widget_name rt.PhpVal, var_callback_arg rt.PhpVal, var_control_callback rt.PhpVal, var_callback_args_arg rt.PhpVal, context string, priority string) {
	mut var_context := context
	mut var_priority := priority
	mut var_callback := var_callback_arg
	mut var_callback_args := var_callback_args_arg
	mut var_wp_dashboard_control_callbacks := rt.new_null()
	mut var_url := rt.new_null()
	mut var_screen := rt.new_null()
	mut var_private_callback_args := map[string]rt.PhpVal{}
	mut var_side_widgets := []rt.PhpVal{}
	mut var_high_priority_widgets := []rt.PhpVal{}
	var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	var_private_callback_args = {
		'__widget_basename': var_widget_name
	}
	if rt.is_true(rt.new_bool(var_callback_args.clone().is_null())) {
		var_callback_args = var_private_callback_args.clone()
	} else if rt.is_true(rt.new_bool(var_callback_args.clone().is_array())) {
		var_callback_args = rt.call_function('array_merge', [
			var_callback_args.clone(), rt.create_array_from_native_map(var_private_callback_args)])
	}
	if rt.is_true(var_control_callback)
		&& rt.call_function('is_callable', [var_control_callback.clone()])
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_dashboard')])) {
		var_wp_dashboard_control_callbacks.array_set(var_widget_id, var_control_callback.clone())
		if rt.get_superglobal('_GET').array_isset(rt.new_string('edit'))
			&& rt.is_true(rt.identical(var_widget_id, rt.get_superglobal('_GET').array_get(rt.new_string('edit')))) {
			mut list_tmp_1 := rt.call_function('explode', [rt.new_string('#'),
				rt.call_function('add_query_arg', [rt.new_string('edit'),
					rt.new_bool(false)]),
				rt.new_int(2)])
			var_url = list_tmp_1.array_get(0)
			var_widget_name = rt.concat(var_widget_name, rt.new_string(
				' <span class="postbox-title-action"><a href="' +
				(rt.call_function('esc_url', [var_url.clone()])).str() + '">' +
				(rt.call_function('__', [rt.new_string('Cancel')])).str() + '</a></span>'))
			var_callback = '_wp_dashboard_control_callback'
		} else {
			mut list_tmp_2 := rt.call_function('explode', [rt.new_string('#'),
				rt.call_function('add_query_arg', [rt.new_string('edit'),
					var_widget_id.clone()]),
				rt.new_int(2)])
			var_url = list_tmp_2.array_get(0)
			var_widget_name = rt.concat(var_widget_name, rt.new_string(
				' <span class="postbox-title-action"><a href="' +
				(rt.call_function('esc_url', [rt.new_string('${var_url.to_string()}#${var_widget_id.to_string()}')])).str() +
				'" class="edit-box open-box">' +
				(rt.call_function('__', [rt.new_string('Configure')])).str() + '</a></span>'))
		}
	}
	var_side_widgets = ['dashboard_quick_press', 'dashboard_primary']
	if rt.is_true(rt.call_function('in_array', [var_widget_id.clone(),
		rt.create_array_from_list(var_side_widgets), rt.new_bool(true)]))
	{
		var_context = 'side'
	}
	var_high_priority_widgets = ['dashboard_browser_nag', 'dashboard_php_nag']
	if rt.is_true(rt.call_function('in_array', [var_widget_id.clone(),
		rt.create_array_from_list(var_high_priority_widgets),
		rt.new_bool(true)]))
	{
		var_priority = 'high'
	}
	if var_context == '' {
		var_context = 'normal'
	}
	if var_priority == '' {
		var_priority = 'core'
	}
	rt.call_function('add_meta_box', [var_widget_id.clone(), var_widget_name.clone(),
		rt.new_string(var_callback.str()).clone(), var_screen.clone(),
		rt.new_string(var_context.str()), rt.new_string(var_priority.str()),
		var_callback_args.clone()])
}

fn _wp_dashboard_control_callback(var_dashboard rt.PhpVal, var_meta_box rt.PhpVal) {
	print('<form method="post" class="dashboard-widget-control-form wp-clearfix">')
	wp_dashboard_trigger_widget_control(var_meta_box.array_get(rt.new_string('id')))
	rt.call_function('wp_nonce_field', [
		rt.new_string('edit-dashboard-widget_' + (var_meta_box.array_get(rt.new_string('id'))).str()),
		rt.new_string('dashboard-widget-nonce'),
	])
	print('<input type="hidden" name="widget_id" value="' +
		(rt.call_function('esc_attr', [var_meta_box.array_get(rt.new_string('id'))])).str() + '" />')
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Save Changes')]),
	])
	print('</form>')
}

fn wp_dashboard() {
	mut var_screen := rt.new_null()
	mut var_columns := rt.new_null()
	mut var_columns_css := ''
	var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	var_columns = rt.call_function('absint', [
		rt.call_method(var_screen, 'get_columns', []rt.PhpVal{}),
	])
	var_columns_css = ''
	if rt.is_true(var_columns) {
		var_columns_css = ' columns-${var_columns.to_string()}'
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_columns_css)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'),
		rt.new_string('normal'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'),
		rt.new_string('side'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'),
		rt.new_string('column3'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'),
		rt.new_string('column4'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'),
		rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
	rt.call_function('wp_nonce_field', [rt.new_string('meta-box-order'),
		rt.new_string('meta-box-order-nonce'), rt.new_bool(false)])
}

fn wp_dashboard_right_now() {
	mut var_post_type := rt.new_null()
	mut var_num_posts := rt.new_null()
	mut var_text := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_url := rt.new_null()
	mut var_num_comm := rt.new_null()
	mut var_moderated_comments_count_i18n := rt.new_null()
	mut var_elements := rt.new_null()
	mut var_title := rt.new_null()
	mut var_content := rt.new_null()
	mut var_title_attr := ''
	mut var_actions := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'post' },
		rt.ArrayItem{ key: none, val: 'page' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_post_type_shadow := item_2.val
		var_num_posts = rt.call_function('wp_count_posts', [var_post_type_shadow.clone()])
		if rt.is_true(var_num_posts) && rt.is_true(rt.get_property(var_num_posts, 'publish')) {
			if rt.is_true(rt.identical(rt.new_string('post'), var_post_type_shadow)) {
				var_text = rt.call_function('_n', [rt.new_string('%s Published post'),
					rt.new_string('%s Published posts'), rt.get_property(var_num_posts, 'publish')])
			} else {
				var_text = rt.call_function('_n', [rt.new_string('%s Published page'),
					rt.new_string('%s Published pages'), rt.get_property(var_num_posts, 'publish')])
			}
			var_text = rt.call_function('sprintf', [var_text.clone(),
				rt.call_function('number_format_i18n', [
					rt.get_property(var_num_posts, 'publish'),
				])])
			var_post_type_object = rt.call_function('get_post_type_object', [
				var_post_type_shadow.clone()])
			if rt.is_true(var_post_type_object)
				&& rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_posts')])) {
				var_url = rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'publish' },
						rt.ArrayItem{ key: 'post_type', val: var_post_type_shadow }]),
					rt.call_function('admin_url', [rt.new_string('edit.php')]),
				])
				rt.call_function('printf', [
					rt.new_string('<li class="%1$s-count"><a href="%2$s">%3$s</a></li>'),
					var_post_type_shadow.clone(),
					rt.call_function('esc_url', [var_url.clone()]),
					rt.call_function('esc_html', [var_text.clone()]),
				])
			} else {
				rt.call_function('printf', [
					rt.new_string('<li class="%1$s-count"><span>%2$s</span></li>'),
					var_post_type_shadow.clone(),
					var_text.clone(),
				])
			}
		}
	}
	var_num_comm = rt.call_function('wp_count_comments', []rt.PhpVal{})
	if rt.is_true(var_num_comm) && rt.is_true(rt.get_property(var_num_comm, 'approved'))
		|| rt.is_true(rt.get_property(var_num_comm, 'moderated')) {
		var_text = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s Comment'),
				rt.new_string('%s Comments'), rt.get_property(var_num_comm, 'approved')]),
			rt.call_function('number_format_i18n', [rt.get_property(var_num_comm, 'approved')]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_text)
		// unsupported statement: Stmt_InlineHTML
		var_moderated_comments_count_i18n = rt.call_function('number_format_i18n', [
			rt.get_property(var_num_comm, 'moderated'),
		])
		var_text = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s Comment in moderation'),
				rt.new_string('%s Comments in moderation'), rt.get_property(var_num_comm,
					'moderated')]),
			var_moderated_comments_count_i18n.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_num_comm, 'moderated'))))) {
			' hidden'
		} else {
			''
		})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_text)
		// unsupported statement: Stmt_InlineHTML
	}
	var_elements = rt.call_function('apply_filters', [
		rt.new_string('dashboard_glance_items'),
		rt.new_array(),
	])
	if rt.is_true(var_elements) {
		print('<li>' +
			(rt.call_function('implode', [rt.new_string('</li>\n<li>'), var_elements.clone()])).str() +
			'</li>\n')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('update_right_now_message', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('blog_public')]))))) {
		var_title = rt.call_function('apply_filters', [
			rt.new_string('privacy_on_link_title'),
			rt.new_string(''),
		])
		var_content = rt.call_function('apply_filters', [
			rt.new_string('privacy_on_link_text'),
			rt.call_function('__', [rt.new_string('Search engines discouraged')]),
		])
		var_title_attr = if rt.is_true(rt.identical(rt.new_string(''), var_title)) {
			''
		} else {
			" title='${var_title.to_string()}'"
		}
		print("<p class='search-engines-info'><a href='options-reading.php'${var_title_attr}>${var_content.to_string()}</a></p>")
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('rightnow_end')])
	rt.call_function('do_action', [rt.new_string('activity_box_end')])
	var_actions = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if !(!rt.is_true(var_actions)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_actions)
		// unsupported statement: Stmt_InlineHTML
	}
}

fn wp_network_dashboard_right_now() {
	mut var_actions := rt.new_null()
	mut var_c_users := rt.new_null()
	mut var_c_blogs := rt.new_null()
	mut var_user_text := rt.new_null()
	mut var_blog_text := rt.new_null()
	mut var_sentence := rt.new_null()
	mut var_action := rt.new_null()
	mut var_class := rt.new_null()
	var_actions = rt.new_array()
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_sites')])) {
		var_actions.array_set('create-site', '<a href="' +
			(rt.call_function('network_admin_url', [rt.new_string('site-new.php')])).str() + '">' +
			(rt.call_function('__', [rt.new_string('Create a New Site')])).str() + '</a>')
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('create_users')])) {
		var_actions.array_set('create-user', '<a href="' +
			(rt.call_function('network_admin_url', [rt.new_string('user-new.php')])).str() + '">' +
			(rt.call_function('__', [rt.new_string('Create a New User')])).str() + '</a>')
	}
	var_c_users = rt.call_function('get_user_count', []rt.PhpVal{})
	var_c_blogs = rt.call_function('get_blog_count', []rt.PhpVal{})
	var_user_text = rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s user'), rt.new_string('%s users'),
			var_c_users.clone()]),
		rt.call_function('number_format_i18n', [var_c_users.clone()]),
	])
	var_blog_text = rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s site'), rt.new_string('%s sites'),
			var_c_blogs.clone()]),
		rt.call_function('number_format_i18n', [var_c_blogs.clone()]),
	])
	var_sentence = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('You have %1$s and %2$s.')]),
		var_blog_text.clone(),
		var_user_text.clone(),
	])
	if rt.is_true(var_actions) {
		print('<ul class="subsubsub">')
		mut iter_3 := var_actions.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_action_shadow := item_3.val
			mut var_class_shadow := item_3.key
			var_actions.array_set(var_class_shadow,
				"\t<li class='${var_class.to_string()}'>${var_action.to_string()}")
		}
		print(
			(rt.call_function('implode', [rt.new_string(' |</li>\n'), var_actions.clone()])).str() +
			'</li>\n')
		print('</ul>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_sentence)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('wpmuadminresult')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('network_admin_url', [rt.new_string('users.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search Users')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Search Users')]),
		rt.new_string(''),
		rt.new_bool(false),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'submit_users' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('network_admin_url', [rt.new_string('sites.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search Sites')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Search Sites')]),
		rt.new_string(''),
		rt.new_bool(false),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'submit_sites' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('mu_rightnow_end')])
	rt.call_function('do_action', [rt.new_string('mu_activity_box_end')])
}

fn wp_dashboard_quick_press(error_msg bool) {
	mut var_error_msg := error_msg
	mut var_last_post_id := rt.new_null()
	mut var_post := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_post_ID := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return
	}
	var_last_post_id = rt.new_int((rt.call_function('get_user_option', [
		rt.new_string('dashboard_quick_press_last_post_id'),
	])).to_i64())
	if rt.is_true(var_last_post_id) {
		var_post = rt.call_function('get_post', [var_last_post_id.clone()])
		if !rt.is_true(var_post)
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))))) {
			var_post = rt.call_function('get_default_post_to_edit', [
				rt.new_string('post'),
				rt.new_bool(true),
			])
			rt.call_function('update_user_option', [
				rt.call_function('get_current_user_id', []rt.PhpVal{}),
				rt.new_string('dashboard_quick_press_last_post_id'),
				rt.new_int((rt.get_property(var_post, 'ID')).to_i64()),
			])
		} else {
			rt.set_property(var_post, 'post_title', rt.new_string(''))
		}
	} else {
		var_post = rt.call_function('get_default_post_to_edit', [
			rt.new_string('post'), rt.new_bool(true)])
		var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
		if rt.is_true(rt.call_function('in_array', [
			rt.call_function('get_current_blog_id', []rt.PhpVal{}),
			rt.func_array_keys(rt.call_function('get_blogs_of_user', [
				var_user_id.clone()])),
			rt.new_bool(true),
		]))
		{
			rt.call_function('update_user_option', [var_user_id.clone(),
				rt.new_string('dashboard_quick_press_last_post_id'),
				rt.new_int((rt.get_property(var_post, 'ID')).to_i64())])
		}
	}
	var_post_ID = rt.new_int((rt.get_property(var_post, 'ID')).to_i64())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('post.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if var_error_msg {
		rt.call_function('wp_admin_notice', [rt.new_bool(error_msg),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('enter_title_here'),
		rt.call_function('__', [rt.new_string('Title')]), var_post.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Content')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('What&#8217;s on your mind?')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_post_ID)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('add-post')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [
		rt.call_function('__', [rt.new_string('Save Draft')]),
		rt.new_string('primary'),
		rt.new_string('save'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'save-post' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	wp_dashboard_recent_drafts(false)
}

fn wp_dashboard_recent_drafts(drafts bool) {
	mut var_drafts := drafts
	mut var_query_args := rt.new_null()
	mut var_draft_length := rt.new_null()
	mut var_draft := rt.new_null()
	mut var_url := rt.new_null()
	mut var_title := rt.new_null()
	mut var_the_content := rt.new_null()
	if !var_drafts {
		var_query_args = rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'post' },
			rt.ArrayItem{ key: 'post_status', val: 'draft' },
			rt.ArrayItem{ key: 'author', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'posts_per_page', val: 4 }, rt.ArrayItem{
				key: 'orderby'
				val: 'modified'
			}, rt.ArrayItem{ key: 'order', val: 'DESC' }])
		var_query_args = rt.call_function('apply_filters', [
			rt.new_string('dashboard_recent_drafts_query_args'),
			var_query_args.clone(),
		])
		var_drafts = (rt.call_function('get_posts', [var_query_args.clone()])).to_bool()
		if !var_drafts {
			return
		}
	}
	print('<div class="drafts">')
	if rt.new_bool(var_drafts).array_count() > 3 {
		rt.call_function('printf', [
			rt.new_string('<p class="view-all"><a href="%s">%s</a></p>' + '\n'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [
					rt.new_string('edit.php?post_status=draft'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('View all drafts'),
			]),
		])
	}
	print('<h2 class="hide-if-no-js">' +
		(rt.call_function('__', [rt.new_string('Your Recent Drafts')])).str() + '</h2>\n')
	print('<ul>')
	var_draft_length = rt.new_int((rt.call_function('_x', [rt.new_string('10'),
		rt.new_string('draft_length')])).to_i64())
	var_drafts = (rt.call_function('array_slice', [rt.new_bool(var_drafts),
		rt.new_int(0), rt.new_int(3)])).to_bool()
	mut iter_4 := rt.new_bool(var_drafts).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_draft_shadow := item_4.val
		var_url = rt.call_function('get_edit_post_link', [
			rt.get_property(var_draft_shadow, 'ID'),
		])
		var_title = rt.call_function('_draft_or_post_title', [
			rt.get_property(var_draft_shadow, 'ID'),
		])
		print('<li>\n')
		rt.call_function('printf', [
			rt.new_string('<div class="draft-title"><a href="%s" aria-label="%s">%s</a><time datetime="%s">%s</time></div>'),
			rt.call_function('esc_url', [var_url.clone()]),
			rt.call_function('esc_attr', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Edit &#8220;%s&#8221;')]),
					var_title.clone(),
				]),
			]),
			rt.call_function('esc_html', [
				var_title.clone(),
			]),
			rt.call_function('get_the_time', [
				rt.new_string('c'),
				var_draft_shadow.clone(),
			]),
			rt.call_function('get_the_time', [
				rt.call_function('__', [
					rt.new_string('F j, Y'),
				]),
				var_draft_shadow.clone(),
			]),
		])
		var_the_content = rt.call_function('wp_trim_words', [
			rt.get_property(var_draft_shadow, 'post_content'),
			var_draft_length.clone(),
		])
		if rt.is_true(var_the_content) {
			print('<p>' + var_the_content.str() + '</p>')
		}
		print('</li>\n')
	}
	print('</ul>\n')
	print('</div>')
}

fn _wp_dashboard_recent_comments_row(var_comment rt.PhpVal, show_date bool) {
	mut var_show_date := show_date
	mut var_GLOBALS := rt.new_null()
	mut var_comment_post_title := rt.new_null()
	mut var_comment_post_url := rt.new_null()
	mut var_comment_post_link := rt.new_null()
	mut var_actions_string := ''
	mut var_actions := rt.new_null()
	mut var_approve_nonce := rt.new_null()
	mut var_del_nonce := rt.new_null()
	mut var_action_string := rt.new_null()
	mut var_approve_url := rt.new_null()
	mut var_unapprove_url := rt.new_null()
	mut var_spam_url := rt.new_null()
	mut var_trash_url := rt.new_null()
	mut var_delete_url := rt.new_null()
	mut var_i := i64(0)
	mut var_link := rt.new_null()
	mut var_action := rt.new_null()
	mut var_separator := ''
	mut var_comment_row_class := ''
	mut var_type := rt.new_null()
	var_GLOBALS.array_set('comment', var_comment.dup())
	if rt.is_true(rt.greater(rt.get_property(var_comment, 'comment_post_ID'), rt.new_int(0))) {
		var_comment_post_title = rt.call_function('_draft_or_post_title', [
			rt.get_property(var_comment, 'comment_post_ID'),
		])
		var_comment_post_url = rt.call_function('get_the_permalink', [
			rt.get_property(var_comment, 'comment_post_ID'),
		])
		var_comment_post_link = rt.new_string('<a href="' +
			(rt.call_function('esc_url', [var_comment_post_url.clone()])).str() + '">' +
			var_comment_post_title.str() + '</a>')
	} else {
		var_comment_post_link = rt.new_string('')
	}
	var_actions_string = ''
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'),
		rt.get_property(var_comment, 'comment_ID')]))
	{
		var_actions = rt.create_array([rt.ArrayItem{ key: 'approve', val: '' },
			rt.ArrayItem{ key: 'unapprove', val: '' }, rt.ArrayItem{ key: 'reply', val: '' },
			rt.ArrayItem{ key: 'edit', val: '' }, rt.ArrayItem{ key: 'spam', val: '' },
			rt.ArrayItem{ key: 'trash', val: '' }, rt.ArrayItem{ key: 'delete', val: '' },
			rt.ArrayItem{ key: 'view', val: '' }])
		var_approve_nonce = rt.call_function('esc_html', [
			rt.new_string('_wpnonce=' +
				(rt.call_function('wp_create_nonce', [rt.new_string('approve-comment_' +
				(rt.get_property(var_comment, 'comment_ID')).str())])).str()),
		])
		var_del_nonce = rt.call_function('esc_html', [
			rt.new_string('_wpnonce=' +
				(rt.call_function('wp_create_nonce', [rt.new_string('delete-comment_' +
				(rt.get_property(var_comment, 'comment_ID')).str())])).str()),
		])
		var_action_string = rt.new_string('comment.php?action=%s&p=' +
			(rt.get_property(var_comment, 'comment_post_ID')).str() + '&c=' +
			(rt.get_property(var_comment, 'comment_ID')).str() + '&%s')
		var_approve_url = rt.call_function('sprintf', [var_action_string.clone(),
			rt.new_string('approvecomment'), var_approve_nonce.clone()])
		var_unapprove_url = rt.call_function('sprintf', [var_action_string.clone(),
			rt.new_string('unapprovecomment'), var_approve_nonce.clone()])
		var_spam_url = rt.call_function('sprintf', [var_action_string.clone(),
			rt.new_string('spamcomment'), var_del_nonce.clone()])
		var_trash_url = rt.call_function('sprintf', [var_action_string.clone(),
			rt.new_string('trashcomment'), var_del_nonce.clone()])
		var_delete_url = rt.call_function('sprintf', [var_action_string.clone(),
			rt.new_string('deletecomment'), var_del_nonce.clone()])
		var_actions.array_set('approve', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-a aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_approve_url.clone()]),
			rt.concat(rt.concat(rt.new_string('dim:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string(':unapproved:e7e7d3:e7e7d3:new=approved')),
			rt.call_function('esc_attr__', [rt.new_string('Approve this comment')]),
			rt.call_function('__', [rt.new_string('Approve')]),
		]))
		var_actions.array_set('unapprove', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-u aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_unapprove_url.clone()]),
			rt.concat(rt.concat(rt.new_string('dim:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string(':unapproved:e7e7d3:e7e7d3:new=unapproved')),
			rt.call_function('esc_attr__', [rt.new_string('Unapprove this comment')]),
			rt.call_function('__', [rt.new_string('Unapprove')]),
		]))
		var_actions.array_set('edit', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" aria-label="%s">%s</a>'),
			rt.concat(rt.new_string('comment.php?action=editcomment&amp;c='), rt.get_property(var_comment,
				'comment_ID')),
			rt.call_function('esc_attr__', [rt.new_string('Edit this comment')]),
			rt.call_function('__', [rt.new_string('Edit')]),
		]))
		var_actions.array_set('reply', rt.call_function('sprintf', [
			rt.new_string('<button type="button" onclick="window.commentReply && commentReply.open(\'%s\',\'%s\');" class="vim-r button-link hide-if-no-js" aria-label="%s">%s</button>'),
			rt.get_property(var_comment, 'comment_ID'),
			rt.get_property(var_comment, 'comment_post_ID'),
			rt.call_function('esc_attr__', [rt.new_string('Reply to this comment')]),
			rt.call_function('_x', [rt.new_string('Reply'), rt.new_string('verb')]),
		]))
		var_actions.array_set('spam', rt.call_function('sprintf', [
			rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-s vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [var_spam_url.clone()]),
			rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
				'comment_ID')), rt.new_string('::spam=1')),
			rt.call_function('esc_attr__', [rt.new_string('Mark this comment as spam')]),
			rt.call_function('_x', [rt.new_string('Spam'), rt.new_string('verb')]),
		]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
			var_actions.array_set('delete', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" data-wp-lists="%s" class="delete vim-d vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
				rt.call_function('esc_url', [var_delete_url.clone()]),
				rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
					'comment_ID')), rt.new_string('::trash=1')),
				rt.call_function('esc_attr__', [rt.new_string('Delete this comment permanently')]),
				rt.call_function('__', [rt.new_string('Delete Permanently')]),
			]))
		} else {
			var_actions.array_set('trash', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" data-wp-lists="%s" class="delete vim-d vim-destructive aria-button-if-js" aria-label="%s">%s</a>'),
				rt.call_function('esc_url', [var_trash_url.clone()]),
				rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_comment,
					'comment_ID')), rt.new_string('::trash=1')),
				rt.call_function('esc_attr__', [rt.new_string('Move this comment to the Trash')]),
				rt.call_function('_x', [rt.new_string('Trash'),
					rt.new_string('verb')]),
			]))
		}
		var_actions.array_set('view', rt.call_function('sprintf', [
			rt.new_string('<a class="comment-link" href="%s" aria-label="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('get_comment_link', [var_comment.clone()]),
			]),
			rt.call_function('esc_attr__', [
				rt.new_string('View this comment'),
			]),
			rt.call_function('__', [
				rt.new_string('View'),
			]),
		]))
		var_actions = rt.call_function('apply_filters', [
			rt.new_string('comment_row_actions'),
			rt.call_function('array_filter', [var_actions.clone()]),
			var_comment.clone(),
		])
		var_i = 0
		mut iter_5 := var_actions.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_link_shadow := item_5.val
			mut var_action_shadow := item_5.key
			var_i += 1
			if (rt.is_true(rt.identical(rt.new_string('approve'), var_action_shadow))
				|| rt.is_true(rt.identical(rt.new_string('unapprove'), var_action_shadow))
				&& 2 == var_i) || 1 == var_i {
				var_separator = ''
			} else {
				var_separator = ' | '
			}
			if rt.is_true(rt.identical(rt.new_string('reply'), var_action_shadow))
				|| rt.is_true(rt.identical(rt.new_string('quickedit'), var_action_shadow)) {
				var_action_shadow = rt.concat(var_action_shadow, rt.new_string(' hide-if-no-js'))
			}
			if rt.is_true(rt.identical(rt.new_string('view'), var_action_shadow))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_comment, 'comment_approved'))))) {
				var_action_shadow = rt.concat(var_action_shadow, rt.new_string(' hidden'))
			}
			var_actions_string = var_actions_string +
				"<span class='${var_action.to_string()}'>${var_separator}${var_link.to_string()}</span>"
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(var_comment, 'comment_ID'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_class', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'comment-item' },
			rt.ArrayItem{ key: none, val: rt.call_function('wp_get_comment_status', [
				var_comment.clone(),
			]) }]),
		var_comment.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	var_comment_row_class = ''
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		rt.echo_val(rt.call_function('get_avatar', [var_comment.clone(),
			rt.new_int(50), rt.new_string('mystery')]))
		var_comment_row_class = var_comment_row_class + ' has-avatar'
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_comment, 'comment_type')))))
		|| rt.is_true(rt.identical(rt.new_string('comment'), rt.get_property(var_comment, 'comment_type'))) {
		// unsupported statement: Stmt_InlineHTML
		print(var_comment_row_class)
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_comment_post_link) {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('From %1$s on %2$s %3$s')]),
				rt.new_string('<cite class="comment-author">' +
					(rt.call_function('get_comment_author_link', [var_comment.clone()])).str() +
					'</cite>'),
				var_comment_post_link.clone(),
				rt.new_string('<span class="approve">' +
					(rt.call_function('__', [rt.new_string('[Pending]')])).str() + '</span>'),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('__', [rt.new_string('From %1$s %2$s')]),
				rt.new_string('<cite class="comment-author">' +
					(rt.call_function('get_comment_author_link', [var_comment.clone()])).str() +
					'</cite>'),
				rt.new_string('<span class="approve">' +
					(rt.call_function('__', [rt.new_string('[Pending]')])).str() + '</span>'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		mut switch_val_1 := rt.get_property(var_comment, 'comment_type')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('pingback'))) {
			var_type = rt.call_function('__', [rt.new_string('Pingback')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trackback'))) {
			var_type = rt.call_function('__', [rt.new_string('Trackback')])
		} else {
			var_type = rt.call_function('ucwords', [
				rt.get_property(var_comment, 'comment_type'),
			])
		}
		var_type = rt.call_function('esc_html', [var_type.clone()])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_comment_post_link) {
			rt.call_function('printf', [
				rt.call_function('_x', [rt.new_string('%1$s on %2$s %3$s'),
					rt.new_string('dashboard')]),
				rt.new_string('<strong>${var_type.to_string()}</strong>'),
				var_comment_post_link.clone(),
				rt.new_string('<span class="approve">' +
					(rt.call_function('__', [rt.new_string('[Pending]')])).str() + '</span>'),
			])
		} else {
			rt.call_function('printf', [
				rt.call_function('_x', [rt.new_string('%1$s %2$s'),
					rt.new_string('dashboard')]),
				rt.new_string('<strong>${var_type.to_string()}</strong>'),
				rt.new_string('<span class="approve">' +
					(rt.call_function('__', [rt.new_string('[Pending]')])).str() + '</span>'),
			])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_author_link', [var_comment.clone()])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('comment_excerpt', [var_comment.clone()])
	// unsupported statement: Stmt_InlineHTML
	if var_actions_string.len > 0 && var_actions_string != '0' {
		// unsupported statement: Stmt_InlineHTML
		print(var_actions_string)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	var_GLOBALS.array_set('comment', rt.new_null())
}

fn wp_dashboard_site_activity() {
	mut var_future_posts := rt.new_null()
	mut var_recent_posts := rt.new_null()
	mut var_recent_comments := rt.new_null()
	print('<div id="activity-widget">')
	var_future_posts = rt.new_bool(wp_dashboard_recent_posts(rt.create_array([
		rt.ArrayItem{ key: 'max', val: 5 },
		rt.ArrayItem{ key: 'status', val: 'future' },
		rt.ArrayItem{ key: 'order', val: 'ASC' },
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Publishing Soon'),
		]) },
		rt.ArrayItem{ key: 'id', val: 'future-posts' },
	])))
	var_recent_posts = rt.new_bool(wp_dashboard_recent_posts(rt.create_array([
		rt.ArrayItem{ key: 'max', val: 5 },
		rt.ArrayItem{ key: 'status', val: 'publish' },
		rt.ArrayItem{ key: 'order', val: 'DESC' },
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Recently Published'),
		]) },
		rt.ArrayItem{ key: 'id', val: 'published-posts' },
	])))
	var_recent_comments = rt.new_bool(wp_dashboard_recent_comments(0))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_future_posts))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_recent_posts))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_recent_comments)))) {
		print('<div class="no-activity">')
		print('<p>' + (rt.call_function('__', [rt.new_string('No activity yet!')])).str() + '</p>')
		print('</div>')
	}
	print('</div>')
}

fn wp_dashboard_recent_posts(var_args rt.PhpVal) bool {
	mut var_query_args := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_today := rt.new_null()
	mut var_tomorrow := rt.new_null()
	mut var_year := rt.new_null()
	mut var_time := rt.new_null()
	mut var_date := rt.new_null()
	mut var_recent_post_link := rt.new_null()
	mut var_draft_or_post_title := rt.new_null()
	var_query_args = rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'post' },
		rt.ArrayItem{ key: 'post_status', val: var_args.array_get(rt.new_string('status')) },
		rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{
			key: 'order'
			val: var_args.array_get(rt.new_string('order'))
		}, rt.ArrayItem{
			key: 'posts_per_page'
			val: rt.new_int((var_args.array_get(rt.new_string('max'))).to_i64())
		}, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{
			key: 'cache_results'
			val: true
		}, rt.ArrayItem{
			key: 'perm'
			val: if rt.is_true(rt.identical(rt.new_string('future'),
				var_args.array_get(rt.new_string('status'))))
			{
				'editable'
			} else {
				'readable'
			}
		}])
	var_query_args = rt.call_function('apply_filters', [
		rt.new_string('dashboard_recent_posts_query_args'),
		var_query_args.clone(),
	])
	var_posts = create_wp_query(var_query_args.clone())
	if rt.is_true(var_posts.have_posts()) {
		print('<div id="' +
			(var_args.array_get(rt.new_string('id'))).str() + '" class="activity-block">')
		print('<h3>' + (var_args.array_get(rt.new_string('title'))).str() + '</h3>')
		print('<ul>')
		var_today = rt.call_function('current_time', [rt.new_string('Y-m-d')])
		var_tomorrow = rt.call_method(rt.call_method(rt.call_function('current_datetime',
			[]rt.PhpVal{}), 'modify', [rt.new_string('+1 day')]), 'format', [
			rt.new_string('Y-m-d'),
		])
		var_year = rt.call_function('current_time', [rt.new_string('Y')])
		for rt.is_true(var_posts.have_posts()) {
			var_posts.the_post()
			var_time = rt.call_function('get_the_time', [rt.new_string('U')])
			if !(var_time.clone().is_long()) {
				var_date = rt.call_function('get_the_date', [
					rt.call_function('__', [rt.new_string('M jS Y')]),
				])
			} else if rt.is_true(rt.identical(rt.call_function('gmdate', [
				rt.new_string('Y-m-d'),
				var_time.clone(),
			]), var_today))
			{
				var_date = rt.call_function('__', [rt.new_string('Today')])
			} else if rt.is_true(rt.identical(rt.call_function('gmdate', [
				rt.new_string('Y-m-d'),
				var_time.clone(),
			]), var_tomorrow))
			{
				var_date = rt.call_function('__', [rt.new_string('Tomorrow')])
			} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('gmdate', [
				rt.new_string('Y'),
				var_time.clone(),
			]), var_year))))
			{
				var_date = rt.call_function('date_i18n', [
					rt.call_function('__', [rt.new_string('M jS Y')]),
					var_time.clone(),
				])
			} else {
				var_date = rt.call_function('date_i18n', [
					rt.call_function('__', [rt.new_string('M jS')]),
					var_time.clone(),
				])
			}
			var_recent_post_link = if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_post'),
				rt.call_function('get_the_ID', []rt.PhpVal{}),
			]))
			{
				rt.call_function('get_edit_post_link', []rt.PhpVal{})
			} else {
				rt.call_function('get_permalink', []rt.PhpVal{})
			}
			var_draft_or_post_title = rt.call_function('_draft_or_post_title', []rt.PhpVal{})
			rt.call_function('printf', [
				rt.new_string('<li><span>%1$s</span> <a href="%2$s" aria-label="%3$s">%4$s</a></li>'),
				rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('%1$s, %2$s'),
						rt.new_string('dashboard')]),
					var_date.clone(),
					rt.call_function('get_the_time', []rt.PhpVal{}),
				]),
				var_recent_post_link.clone(),
				rt.call_function('esc_attr', [
					rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Edit &#8220;%s&#8221;')]),
						var_draft_or_post_title.clone(),
					]),
				]),
				var_draft_or_post_title.clone(),
			])
		}
		print('</ul>')
		print('</div>')
	} else {
		return false
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return true
}

fn wp_dashboard_recent_comments(total_items i64) bool {
	mut var_total_items := total_items
	mut var_comments := []rt.PhpVal{}
	mut var_comments_query := map[string]rt.PhpVal{}
	mut var_comments_count := i64(0)
	mut var_possible := rt.new_null()
	mut var_comment := rt.new_null()
	var_comments = rt.new_array()
	var_comments_query = {
		'number': total_items * 5
		'offset': rt.new_int(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		var_comments_query['status'] = rt.new_string('approve')
	}
	var_comments_count = 0
	for {
		var_possible = rt.call_function('get_comments', [
			rt.create_array_from_native_map(var_comments_query),
		])
		if !rt.is_true(var_possible) || !(var_possible.clone().is_array()) {
			break
		}
		mut iter_6 := var_possible.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_comment_shadow := item_6.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_comment_shadow, 'comment_post_ID')])))))
				&& rt.is_true(rt.call_function('post_password_required', [rt.get_property(var_comment_shadow, 'comment_post_ID')]))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_comment_shadow, 'comment_post_ID')]))))) {
				continue
			}
			var_comments << var_comment_shadow.clone()
			var_comments_count = var_comments.len
			if var_comments_count == total_items {
				break
			}
		}
		var_comments_query['offset'] = rt.add(var_comments_query['offset'],
			var_comments_query['number'])
		var_comments_query['number'] = total_items * 10
		if !(var_comments_count < total_items) {
			break
		}
	}
	if rt.is_true(var_comments) {
		print('<div id="latest-comments" class="activity-block table-view-list">')
		print('<h3>' + (rt.call_function('__', [rt.new_string('Recent Comments')])).str() + '</h3>')
		print('<ul id="the-comment-list" data-wp-lists="list:comment">')
		for var_comment_shadow in var_comments {
			_wp_dashboard_recent_comments_row(var_comment_shadow.clone(), false)
		}
		print('</ul>')
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
			print('<h3 class="screen-reader-text">' +
				(rt.call_function('__', [rt.new_string('View more comments')])).str() + '</h3>')
			rt.call_method(rt.call_function('_get_list_table', [
				rt.new_string('WP_Comments_List_Table'),
			]), 'views', []rt.PhpVal{})
		}
		rt.call_function('wp_comment_reply', [rt.new_int(-1),
			rt.new_bool(false), rt.new_string('dashboard'), rt.new_bool(false)])
		rt.call_function('wp_comment_trashnotice', []rt.PhpVal{})
		print('</div>')
	} else {
		return false
	}
	return true
}

fn wp_dashboard_rss_output(var_widget_id rt.PhpVal) {
	mut var_widgets := rt.new_null()
	var_widgets = rt.call_function('get_option', [
		rt.new_string('dashboard_widget_options'),
	])
	print('<div class="rss-widget">')
	rt.call_function('wp_widget_rss_output', [var_widgets.array_get(var_widget_id)])
	print('</div>')
}

fn wp_dashboard_cached_rss_widget(widget_id string, callback string, var_check_urls_arg rt.PhpVal, var_args_origin ...rt.PhpVal) bool {
	mut var_args := rt.create_array_from_list(var_args_origin)
	mut var_widget_id := widget_id
	mut var_callback := callback
	mut var_check_urls := var_check_urls_arg
	mut var_doing_ajax := rt.new_null()
	mut var_loading := rt.new_null()
	mut var_widgets := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_cache_key := rt.new_null()
	mut var_output := rt.new_null()
	var_doing_ajax = rt.call_function('wp_doing_ajax', []rt.PhpVal{})
	var_loading = rt.new_string('<p class="widget-loading hide-if-no-js">' +
		(rt.call_function('__', [rt.new_string('Loading&hellip;')])).str() + '</p>')
	var_loading = rt.concat(var_loading, rt.call_function('wp_get_admin_notice', [
		rt.call_function('__', [rt.new_string('This widget requires JavaScript.')]),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'inline' },
				rt.ArrayItem{ key: none, val: 'hide-if-js' },
			]) }]),
	]))
	if !rt.is_true(var_check_urls) {
		var_widgets = rt.call_function('get_option', [
			rt.new_string('dashboard_widget_options'),
		])
		if !rt.is_true(var_widgets.array_get(rt.new_string(widget_id)).array_get(rt.new_string('url')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_doing_ajax)))) {
			rt.echo_val(var_loading)
			return false
		}
		var_check_urls = [var_widgets.array_get(rt.new_string(widget_id)).array_get(rt.new_string('url'))]
	}
	var_locale = rt.call_function('get_user_locale', []rt.PhpVal{})
	var_cache_key = rt.new_string('dash_v2_' + md5.hexhash(widget_id + '_' + var_locale.str()))
	var_output = rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_output)))) {
		rt.echo_val(var_output)
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_doing_ajax)))) {
		rt.echo_val(var_loading)
		return false
	}
	if var_callback.len > 0 && var_callback != '0'
		&& rt.call_function('is_callable', [rt.new_string(callback)]) {
		rt.call_function('array_unshift', [rt.create_array_from_native_map(var_args),
			rt.new_string(widget_id), rt.create_array_from_list(var_check_urls)])
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('call_user_func_array', [rt.new_string(callback),
			rt.create_array_from_native_map(var_args)])
		rt.call_function('set_transient', [var_cache_key.clone(),
			rt.call_function('ob_get_flush', []rt.PhpVal{}),
			rt.mul(rt.new_int(12),
				rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return true
}

fn wp_dashboard_trigger_widget_control(widget_control_id bool) {
	mut var_widget_control_id := widget_control_id
	mut var_wp_dashboard_control_callbacks := rt.new_null()
	if rt.is_true(rt.call_function('is_scalar', [rt.new_bool(widget_control_id)]))
		&& var_widget_control_id
		&& var_wp_dashboard_control_callbacks.array_isset(rt.new_bool(widget_control_id))
		&& rt.call_function('is_callable', [var_wp_dashboard_control_callbacks.array_get(rt.new_bool(widget_control_id))]) {
		rt.call_function('call_user_func', [var_wp_dashboard_control_callbacks.array_get(rt.new_bool(widget_control_id)),
			rt.new_string(''),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: widget_control_id },
				rt.ArrayItem{
					key: 'callback'
					val: var_wp_dashboard_control_callbacks.array_get(rt.new_bool(widget_control_id))
				},
			])])
	}
}

fn wp_dashboard_rss_control(var_widget_id rt.PhpVal, var_form_inputs rt.PhpVal) {
	mut var_widget_options := rt.new_null()
	mut var_number := i64(0)
	mut var_rss := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_cache_key := rt.new_null()
	var_widget_options = rt.call_function('get_option', [
		rt.new_string('dashboard_widget_options'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_widget_options)))) {
		var_widget_options = rt.new_array()
	}
	if !(var_widget_options.array_isset(var_widget_id)) {
		var_widget_options.array_set(var_widget_id, rt.new_array())
	}
	var_number = 1
	var_widget_options.array_get_mut(var_widget_id).array_set('number', var_number)
	if rt.is_true(rt.identical(rt.new_string('POST'), rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_METHOD'))))
		&& rt.get_superglobal('_POST').array_get(rt.new_string('widget-rss')).array_isset(rt.new_int(var_number)) {
		rt.get_superglobal('_POST').array_get_mut('widget-rss').array_set(var_number, rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('widget-rss')).array_get(rt.new_int(var_number)),
		]))
		var_widget_options.array_set(var_widget_id, rt.call_function('wp_widget_rss_process', [
			rt.get_superglobal('_POST').array_get(rt.new_string('widget-rss')).array_get(rt.new_int(var_number)),
		]))
		var_widget_options.array_get_mut(var_widget_id).array_set('number', var_number)
		if rt.is_true(rt.new_bool(!(rt.is_true(var_widget_options.array_get(var_widget_id).array_get(rt.new_string('title'))))))
			&& rt.get_superglobal('_POST').array_get(rt.new_string('widget-rss')).array_get(rt.new_int(var_number)).array_isset(rt.new_string('title')) {
			var_rss = rt.call_function('fetch_feed',
				[var_widget_options.array_get(var_widget_id).array_get(rt.new_string('url'))])
			if rt.is_true(rt.call_function('is_wp_error', [var_rss.clone()])) {
				var_widget_options.array_get_mut(var_widget_id).array_set('title', rt.call_function('htmlentities', [
					rt.call_function('__', [rt.new_string('Unknown Feed')]),
				]))
			} else {
				var_widget_options.array_get_mut(var_widget_id).array_set('title', rt.call_function('htmlentities', [
					rt.call_function('strip_tags', [
						rt.call_method(var_rss, 'get_title', []rt.PhpVal{}),
					]),
				]))
				rt.call_method(var_rss, '__destruct', []rt.PhpVal{})
				var_rss = rt.new_null()
			}
		}
		rt.call_function('update_option', [rt.new_string('dashboard_widget_options'),
			var_widget_options.clone(), rt.new_bool(false)])
		var_locale = rt.call_function('get_user_locale', []rt.PhpVal{})
		var_cache_key = rt.new_string('dash_v2_' + md5.hexhash(var_widget_id.str() + '_' +
			var_locale.str()))
		rt.call_function('delete_transient', [var_cache_key.clone()])
	}
	rt.call_function('wp_widget_rss_form', [var_widget_options.array_get(var_widget_id),
		var_form_inputs.clone()])
}

fn wp_dashboard_events_news() {
	wp_print_community_events_markup()
	// unsupported statement: Stmt_InlineHTML
	wp_dashboard_primary()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string('<a href="%1$s" target="_blank">%2$s <span class="screen-reader-text"> %3$s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>'),
		rt.new_string('https://make.wordpress.org/community/meetups-landing-page'),
		rt.call_function('__', [rt.new_string('Meetups')]),
		rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string('<a href="%1$s" target="_blank">%2$s <span class="screen-reader-text"> %3$s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>'),
		rt.new_string('https://central.wordcamp.org/schedule/'),
		rt.call_function('__', [rt.new_string('WordCamps')]),
		rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string('<a href="%1$s" target="_blank">%2$s <span class="screen-reader-text"> %3$s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>'),
		rt.call_function('esc_url', [
			rt.call_function('_x', [rt.new_string('https://wordpress.org/news/'),
				rt.new_string('Events and News dashboard widget')]),
		]),
		rt.call_function('__', [
			rt.new_string('News'),
		]),
		rt.call_function('__', [
			rt.new_string('(opens in a new tab)'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_print_community_events_markup() {
	mut var_community_events_notice := rt.new_null()
	var_community_events_notice = rt.new_string('<p class="hide-if-js">' +
		'This widget requires JavaScript.' + '</p>')
	var_community_events_notice = rt.concat(var_community_events_notice, rt.new_string(
		'<p class="community-events-error-occurred" aria-hidden="true">' +
		(rt.call_function('__', [rt.new_string('An error occurred. Please try again.')])).str() +
		'</p>'))
	var_community_events_notice = rt.concat(var_community_events_notice,
		rt.new_string('<p class="community-events-could-not-locate" aria-hidden="true"></p>'))
	rt.call_function('wp_admin_notice', [var_community_events_notice.clone(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'community-events-errors' },
				rt.ArrayItem{ key: none, val: 'inline' },
				rt.ArrayItem{ key: none, val: 'hide-if-js' },
			]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select location')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('City:')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Cincinnati')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Submit')]),
		rt.new_string('secondary'), rt.new_string('community-events-submit'),
		rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Cancel')])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_print_community_events_templates() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Attend an upcoming event near %s.')]),
		rt.new_string('<strong>{{ data.location.description }}</strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('%s could not be located. Please try another nearby city. For example: Kansas City; Springfield; Portland.'),
		]),
		rt.new_string('<em>{{data.unknownCity}}</em>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('Want more events? <a href="%s">Help organize the next one</a>!'),
		]),
		rt.call_function('__', [
			rt.new_string('https://make.wordpress.org/community/organize-event-landing-page/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There are no events scheduled near %1$s at the moment. Would you like to <a href="%2$s">organize a WordPress event</a>?'),
		]),
		rt.new_string('{{ data.location.description }}'),
		rt.call_function('__', [
			rt.new_string('https://make.wordpress.org/community/handbook/meetup-organizer/welcome/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [
			rt.new_string('There are no events scheduled near you at the moment. Would you like to <a href="%s">organize a WordPress event</a>?'),
		]),
		rt.call_function('__', [
			rt.new_string('https://make.wordpress.org/community/handbook/meetup-organizer/welcome/'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn wp_dashboard_primary() {
	mut var_feeds := map[string]rt.PhpVal{}
	var_feeds = {
		'news':   {
			'link':         rt.call_function('apply_filters', [
				rt.new_string('dashboard_primary_link'),
				rt.call_function('__', [rt.new_string('https://wordpress.org/news/')]),
			])
			'url':          rt.call_function('apply_filters', [
				rt.new_string('dashboard_primary_feed'),
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/news/feed/'),
				]),
			])
			'title':        rt.call_function('apply_filters', [
				rt.new_string('dashboard_primary_title'),
				rt.call_function('__', [rt.new_string('WordPress Blog')]),
			])
			'items':        rt.new_int(2)
			'show_summary': rt.new_int(0)
			'show_author':  rt.new_int(0)
			'show_date':    rt.new_int(0)
		}
		'planet': {
			'link':         rt.call_function('apply_filters', [
				rt.new_string('dashboard_secondary_link'),
				rt.call_function('__', [rt.new_string('https://planet.wordpress.org/')]),
			])
			'url':          rt.call_function('apply_filters', [
				rt.new_string('dashboard_secondary_feed'),
				rt.call_function('__', [
					rt.new_string('https://planet.wordpress.org/feed/'),
				]),
			])
			'title':        rt.call_function('apply_filters', [
				rt.new_string('dashboard_secondary_title'),
				rt.call_function('__', [rt.new_string('Other WordPress News')]),
			])
			'items':        rt.call_function('apply_filters', [
				rt.new_string('dashboard_secondary_items'),
				rt.new_int(3),
			])
			'show_summary': rt.new_int(0)
			'show_author':  rt.new_int(0)
			'show_date':    rt.new_int(0)
		}
	}
	rt.new_bool(wp_dashboard_cached_rss_widget('dashboard_primary', 'wp_dashboard_primary_output',
		rt.create_array_from_native_map(var_feeds)))
}

fn wp_dashboard_primary_output(var_widget_id rt.PhpVal, var_feeds rt.PhpVal) {
	mut var_args := map[string]rt.PhpVal{}
	mut var_type := rt.new_null()
	for var_type_shadow, var_args_shadow in var_feeds {
		var_args_shadow['type'] = rt.new_string(var_type_shadow.str()).clone()
		print('<div class="rss-widget">')
		rt.call_function('wp_widget_rss_output', [var_args_shadow['url'], var_args_shadow.clone()])
		print('</div>')
	}
}

fn wp_dashboard_quota() bool {
	mut var_quota := rt.new_null()
	mut var_used := rt.new_null()
	mut var_percentused := rt.new_null()
	mut var_used_class := ''
	mut var_text := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')])))))
		|| rt.is_true(rt.call_function('get_site_option', [rt.new_string('upload_space_check_disabled')])) {
		return true
	}
	var_quota = rt.call_function('get_space_allowed', []rt.PhpVal{})
	var_used = rt.call_function('get_space_used', []rt.PhpVal{})
	if rt.is_true(rt.greater(var_used, var_quota)) {
		var_percentused = rt.new_string('100')
	} else {
		var_percentused = rt.mul(rt.div(var_used, var_quota), rt.new_int(100))
	}
	var_used_class = if rt.is_true(rt.greater_equal(var_percentused, rt.new_int(70))) {
		' warning'
	} else {
		''
	}
	var_used = rt.call_function('round', [var_used.clone(), rt.new_int(2)])
	var_percentused = rt.call_function('number_format', [var_percentused.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Storage Space')])
	// unsupported statement: Stmt_InlineHTML
	var_text = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%s MB Space Allowed')]),
		rt.call_function('number_format_i18n', [var_quota.clone()]),
	])
	rt.call_function('printf', [
		rt.new_string('<a href="%1$s">%2$s<span class="screen-reader-text"> (%3$s)</span></a>'),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('upload.php')]),
		]),
		var_text.clone(),
		rt.call_function('__', [
			rt.new_string('Manage Uploads'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	print(var_used_class)
	// unsupported statement: Stmt_InlineHTML
	var_text = rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%1$s MB (%2$s%%) Space Used')]),
		rt.call_function('number_format_i18n', [var_used.clone(),
			rt.new_int(2)]),
		var_percentused.clone(),
	])
	rt.call_function('printf', [
		rt.new_string('<a href="%1$s" class="musublink">%2$s<span class="screen-reader-text"> (%3$s)</span></a>'),
		rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('upload.php')]),
		]),
		var_text.clone(),
		rt.call_function('__', [
			rt.new_string('Manage Uploads'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	return false
}

fn wp_dashboard_browser_nag() {
	mut var_is_IE := rt.new_null()
	mut var_notice := ''
	mut var_response := rt.new_null()
	mut var_msg := rt.new_null()
	mut var_browser_nag_class := ''
	mut var_img_src := rt.new_null()
	mut var_browsehappy := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_msg_browsehappy := rt.new_null()
	var_notice = ''
	var_response = rt.new_bool(wp_check_browser_version())
	if rt.is_true(var_response) {
		if rt.is_true(var_is_IE) {
			var_msg = rt.call_function('__', [
				rt.new_string('Internet Explorer does not give you the best WordPress experience. Switch to Microsoft Edge, or another more modern browser to get the most from your site.'),
			])
		} else if rt.is_true(var_response.array_get(rt.new_string('insecure'))) {
			var_msg = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("It looks like you're using an insecure version of %s. Using an outdated browser makes your computer unsafe. For the best WordPress experience, please update your browser."),
				]),
				rt.call_function('sprintf', [
					rt.new_string('<a href="%s">%s</a>'),
					rt.call_function('esc_url', [
						var_response.array_get(rt.new_string('update_url')),
					]),
					rt.call_function('esc_html', [
						var_response.array_get(rt.new_string('name')),
					]),
				]),
			])
		} else {
			var_msg = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("It looks like you're using an old version of %s. For the best WordPress experience, please update your browser."),
				]),
				rt.call_function('sprintf', [
					rt.new_string('<a href="%s">%s</a>'),
					rt.call_function('esc_url', [
						var_response.array_get(rt.new_string('update_url')),
					]),
					rt.call_function('esc_html', [
						var_response.array_get(rt.new_string('name')),
					]),
				]),
			])
		}
		var_browser_nag_class = ''
		if !(!rt.is_true(var_response.array_get(rt.new_string('img_src')))) {
			var_img_src = if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{}))
				&& !(!rt.is_true(var_response.array_get(rt.new_string('img_src_ssl')))) {
				var_response.array_get(rt.new_string('img_src_ssl'))
			} else {
				var_response.array_get(rt.new_string('img_src'))
			}
			var_notice = var_notice + '<div class="alignright browser-icon"><img src="' +
				(rt.call_function('esc_url', [var_img_src.clone()])).str() + '" alt="" /></div>'
			var_browser_nag_class = ' has-browser-icon'
		}
		var_notice = var_notice +
			"<p class='browser-update-nag${var_browser_nag_class}'>${var_msg.to_string()}</p>"
		var_browsehappy = rt.new_string('https://browsehappy.com/')
		var_locale = rt.call_function('get_user_locale', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en_US'), var_locale)))) {
			var_browsehappy = rt.call_function('add_query_arg', [
				rt.new_string('locale'), var_locale.clone(), var_browsehappy.clone()])
		}
		if rt.is_true(var_is_IE) {
			var_msg_browsehappy = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Learn how to <a href="%s" class="update-browser-link">browse happy</a>'),
				]),
				rt.call_function('esc_url', [
					var_browsehappy.clone(),
				]),
			])
		} else {
			var_msg_browsehappy = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('<a href="%1$s" class="update-browser-link">Update %2$s</a> or learn how to <a href="%3$s" class="browse-happy-link">browse happy</a>'),
				]),
				rt.call_function('esc_attr', [
					var_response.array_get(rt.new_string('update_url')),
				]),
				rt.call_function('esc_html', [
					var_response.array_get(rt.new_string('name')),
				]),
				rt.call_function('esc_url', [
					var_browsehappy.clone(),
				]),
			])
		}
		var_notice = var_notice + '<p>' + var_msg_browsehappy.str() + '</p>'
		var_notice = var_notice +
			'<p class="hide-if-no-js"><a href="" class="dismiss" aria-label="' +
			(rt.call_function('esc_attr__', [rt.new_string('Dismiss the browser warning panel')])).str() +
			'">' + (rt.call_function('__', [rt.new_string('Dismiss')])).str() + '</a></p>'
		var_notice = var_notice + '<div class="clear"></div>'
	}
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('browse-happy-notice'),
		rt.new_string(var_notice.str()).clone(), var_response.clone()]))
}

fn dashboard_browser_nag_class(var_classes rt.PhpVal) rt.PhpVal {
	mut var_response := rt.new_null()
	var_response = rt.new_bool(wp_check_browser_version())
	if rt.is_true(var_response) && rt.is_true(var_response.array_get(rt.new_string('insecure'))) {
		var_classes << 'browser-insecure'
	}
	return var_classes.clone()
}

fn wp_check_browser_version() bool {
	mut var_key := ''
	mut var_response := rt.new_null()
	mut var_url := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))) {
		return false
	}
	var_key =
		md5.hexhash(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')).to_string())
	var_response = rt.call_function('get_site_transient', [
		rt.new_string('browser_' + var_key),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_response)) {
		var_url = rt.new_string('http://api.wordpress.org/core/browse-happy/1.1/')
		var_options = {
			'body':       {
				'useragent': rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))
			}
			'user-agent': 'WordPress/' +
				(rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() + '; ' +
				(rt.call_function('home_url', [rt.new_string('/')])).str()
		}
		if rt.is_true(rt.call_function('wp_http_supports', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
		]))
		{
			var_url = rt.call_function('set_url_scheme', [var_url.clone(),
				rt.new_string('https')])
		}
		var_response = rt.call_function('wp_remote_post', [var_url.clone(),
			rt.create_array_from_native_map(var_options)])
		if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()]))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]))))) {
			return false
		}
		var_response = rt.call_function('json_decode', [
			rt.call_function('wp_remote_retrieve_body', [var_response.clone()]),
			rt.new_bool(true),
		])
		if !(var_response.clone().is_array()) {
			return false
		}
		rt.call_function('set_site_transient', [rt.new_string('browser_' + var_key),
			var_response.clone(), rt.get_constant('WEEK_IN_SECONDS')])
	}
	return var_response.to_bool()
}

fn wp_dashboard_php_nag() {
	mut var_response := rt.new_null()
	mut var_message := rt.new_null()
	var_response = rt.call_function('wp_check_php_version', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_response)))) {
		return
	}
	if var_response.array_isset(rt.new_string('is_secure'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_response.array_get(rt.new_string('is_secure')))))) {
		if rt.is_true(var_response.array_get(rt.new_string('is_lower_than_future_minimum'))) {
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your site is running on an outdated version of PHP (%s), which does not receive security updates and soon will not be supported by WordPress. Ensure that PHP is updated on your server as soon as possible. Otherwise you will not be able to upgrade WordPress.'),
				]),
				rt.get_constant('PHP_VERSION'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your site is running on an outdated version of PHP (%s), which does not receive security updates. It should be updated.'),
				]),
				rt.get_constant('PHP_VERSION'),
			])
		}
	} else if rt.is_true(var_response.array_get(rt.new_string('is_lower_than_future_minimum'))) {
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running on an outdated version of PHP (%s), which soon will not be supported by WordPress. Ensure that PHP is updated on your server as soon as possible. Otherwise you will not be able to upgrade WordPress.'),
			]),
			rt.get_constant('PHP_VERSION'),
		])
	} else {
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running on an outdated version of PHP (%s), which should be updated.'),
			]),
			rt.get_constant('PHP_VERSION'),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_message)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('What is PHP and how does it affect my site?')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('PHP is one of the programming languages used to build WordPress. Newer versions of PHP receive regular security updates and may increase your site&#8217;s performance.'),
	])
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_response.array_get(rt.new_string('recommended_version')))) {
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('The minimum recommended version of PHP is %s.'),
			]),
			var_response.array_get(rt.new_string('recommended_version')),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.new_string('<a class="button button-primary" href="%1$s" target="_blank">%2$s<span class="screen-reader-text"> %3$s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a>'),
		rt.call_function('esc_url', [
			rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
		]),
		rt.call_function('__', [
			rt.new_string('Learn more about updating PHP'),
		]),
		rt.call_function('__', [
			rt.new_string('(opens in a new tab)'),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_update_php_annotation', []rt.PhpVal{})
	rt.call_function('wp_direct_php_update_button', []rt.PhpVal{})
}

fn dashboard_php_nag_class(var_classes rt.PhpVal) rt.PhpVal {
	mut var_response := rt.new_null()
	var_response = rt.call_function('wp_check_php_version', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_response)))) {
		return var_classes.clone()
	}
	if var_response.array_isset(rt.new_string('is_secure'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_response.array_get(rt.new_string('is_secure')))))) {
		var_classes << 'php-no-security-updates'
	} else if rt.is_true(var_response.array_get(rt.new_string('is_lower_than_future_minimum'))) {
		var_classes << 'php-version-lower-than-future-minimum'
	}
	return var_classes.clone()
}

fn wp_dashboard_site_health() {
	mut var_get_issues := rt.new_null()
	mut var_issue_counts := rt.new_null()
	mut var_issues_total := rt.new_null()
	var_get_issues = rt.call_function('get_transient', [
		rt.new_string('health-check-site-status-result'),
	])
	var_issue_counts = rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_get_issues)))) {
		var_issue_counts = rt.call_function('json_decode', [var_get_issues.clone(),
			rt.new_bool(true)])
	}
	if !(var_issue_counts.clone().is_array())
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_issue_counts)))) {
		var_issue_counts = rt.create_array([rt.ArrayItem{ key: 'good', val: 0 },
			rt.ArrayItem{ key: 'recommended', val: 0 }, rt.ArrayItem{ key: 'critical', val: 0 }])
	}
	var_issues_total = rt.add(var_issue_counts.array_get(rt.new_string('recommended')),
		var_issue_counts.array_get(rt.new_string('critical')))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_bool(false), var_get_issues)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('No information yet&hellip;')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Results are still loading&hellip;')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_bool(false), var_get_issues)) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Site health checks will automatically run periodically to gather information about your site. You can also <a href="%s">visit the Site Health screen</a> to gather information about your site now.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('site-health.php')]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.less_equal(var_issues_total, rt.new_int(0))) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Great job! Your site currently passes all site health checks.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else if 1 == rt.new_int((var_issue_counts.array_get(rt.new_string('critical'))).to_i64()) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Your site has a critical issue that should be addressed as soon as possible to improve its performance and security.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.greater(var_issue_counts.array_get(rt.new_string('critical')),
			rt.new_int(1)))
		{
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Your site has critical issues that should be addressed as soon as possible to improve its performance and security.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else if 1 == rt.new_int((var_issue_counts.array_get(rt.new_string('recommended'))).to_i64()) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Your site&#8217;s health is looking good, but there is still one thing you can do to improve its performance and security.'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Your site&#8217;s health is looking good, but there are still some things you can do to improve its performance and security.'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.greater(var_issues_total, rt.new_int(0)))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_get_issues)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('_n', [
				rt.new_string('Take a look at the <strong>%1$d item</strong> on the <a href="%2$s">Site Health screen</a>.'),
				rt.new_string('Take a look at the <strong>%1$d items</strong> on the <a href="%2$s">Site Health screen</a>.'),
				var_issues_total.clone(),
			]),
			var_issues_total.clone(),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('site-health.php')]),
			]),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_dashboard_empty() {
}

fn wp_welcome_panel() {
	mut var_display_version := rt.new_null()
	mut var_can_customize := rt.new_null()
	mut var_is_block_theme := rt.new_null()
	mut list_tmp_3 := rt.call_function('explode', [rt.new_string('-'),
		rt.call_function('wp_get_wp_version', []rt.PhpVal{})])
	var_display_version = list_tmp_3.array_get(0)
	var_can_customize = rt.call_function('current_user_can', [
		rt.new_string('customize')])
	var_is_block_theme = rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('file_get_contents', [
		rt.new_string((rt.call_function('dirname', [rt.new_string(@DIR)])).str() +
			'/images/dashboard-background.svg'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Welcome to WordPress!')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('about.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Learn more about the %s version.')]),
		rt.call_function('esc_html', [var_display_version.clone()]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Author rich content with blocks and patterns'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Block patterns are pre-configured block layouts. Use them to get inspired or create new pages in a flash.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('post-new.php?post_type=page')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add a new page')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_is_block_theme) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Customize your entire site with block themes'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Design everything on your site &#8212; from the header down to the footer, all using blocks and patterns.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [rt.new_string('site-editor.php')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Open site editor')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Start Customizing')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Configure your site&#8217;s logo, header, menus, and more in the Customizer.'),
		])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_can_customize) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_customize_url', []rt.PhpVal{}))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [rt.new_string('Open the Customizer')])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_is_block_theme) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Switch up your site&#8217;s look & feel with Styles'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Tweak your site, or give it a whole new look! Get creative &#8212; how about a new color palette or font?'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('add_query_arg', [rt.new_string('p'),
				rt.call_function('rawurlencode', [rt.new_string('/styles')]),
				rt.call_function('admin_url', [rt.new_string('site-editor.php')])]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Edit styles')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Discover a new way to build your site.')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('There is a new kind of WordPress theme, called a block theme, that lets you build the site you&#8217;ve always wanted &#8212; with blocks and styles.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('__', [
				rt.new_string('https://wordpress.org/documentation/article/block-themes/'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Learn about block themes')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_site_health(_args ...rt.PhpVal) &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site_Health) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
