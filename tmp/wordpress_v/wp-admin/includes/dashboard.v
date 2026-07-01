import rt

fn wp_dashboard_setup() {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_wp_registered_widget_controls := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_wp_dashboard_control_callbacks := rt.new_array()
	mut var_check_browser := rt.new_bool(rt.new_bool(wp_check_browser_version()))
	if rt.is_true(rt.new_bool(rt.is_true(var_check_browser) && rt.is_true(var_check_browser.array_get('upgrade')))) {
		rt.call_function('add_filter', [rt.new_string('postbox_classes_dashboard_dashboard_browser_nag'), rt.new_string('dashboard_browser_nag_class')])
		if rt.is_true(var_check_browser.array_get('insecure')) {
			wp_add_dashboard_widget(rt.new_string('dashboard_browser_nag'), rt.call_function('__', [rt.new_string('You are using an insecure browser!')]), rt.new_string('wp_dashboard_browser_nag'), rt.new_null(), rt.new_null(), '', '')
		} else {
			wp_add_dashboard_widget(rt.new_string('dashboard_browser_nag'), rt.call_function('__', [rt.new_string('Your browser is out of date!')]), rt.new_string('wp_dashboard_browser_nag'), rt.new_null(), rt.new_null(), '', '')
		}
	}
	mut var_check_php := rt.call_function('wp_check_php_version', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_check_php) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_php')])))) {
		if rt.is_true(rt.new_bool(var_check_php.array_isset(rt.new_string('is_acceptable')) && rt.is_true(rt.new_bool(!(rt.is_true(var_check_php.array_get('is_acceptable'))))))) {
			rt.call_function('add_filter', [rt.new_string('postbox_classes_dashboard_dashboard_php_nag'), rt.new_string('dashboard_php_nag_class')])
			if rt.is_true(var_check_php.array_get('is_lower_than_future_minimum')) {
				wp_add_dashboard_widget(rt.new_string('dashboard_php_nag'), rt.call_function('__', [rt.new_string('PHP Update Required')]), rt.new_string('wp_dashboard_php_nag'), rt.new_null(), rt.new_null(), '', '')
			} else {
				wp_add_dashboard_widget(rt.new_string('dashboard_php_nag'), rt.call_function('__', [rt.new_string('PHP Update Recommended')]), rt.new_string('wp_dashboard_php_nag'), rt.new_null(), rt.new_null(), '', '')
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('view_site_health_checks')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Site_Health')]))))) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php', '4')
		}
		fn () rt.PhpVal { mut temp := Class_WP_Site_Health{}; return temp.get_instance() }()
		rt.call_function('wp_enqueue_style', [rt.new_string('site-health')])
		rt.call_function('wp_enqueue_script', [rt.new_string('site-health')])
		wp_add_dashboard_widget(rt.new_string('dashboard_site_health'), rt.call_function('__', [rt.new_string('Site Health Status')]), rt.new_string('wp_dashboard_site_health'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])))) {
		wp_add_dashboard_widget(rt.new_string('dashboard_right_now'), rt.call_function('__', [rt.new_string('At a Glance')]), rt.new_string('wp_dashboard_right_now'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		wp_add_dashboard_widget(rt.new_string('network_dashboard_right_now'), rt.call_function('__', [rt.new_string('Right Now')]), rt.new_string('wp_network_dashboard_right_now'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{})) {
		wp_add_dashboard_widget(rt.new_string('dashboard_activity'), rt.call_function('__', [rt.new_string('Activity')]), rt.new_string('wp_dashboard_site_activity'), rt.new_null(), rt.new_null(), '', '')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_blog_admin', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('post')]), 'cap'), 'create_posts')])))) {
		mut var_quick_draft_title := rt.call_function('sprintf', [rt.new_string('<span class="hide-if-no-js">%1$s</span> <span class="hide-if-js">%2$s</span>'), rt.call_function('__', [rt.new_string('Quick Draft')]), rt.call_function('__', [rt.new_string('Your Recent Drafts')])])
		wp_add_dashboard_widget(rt.new_string('dashboard_quick_press'), var_quick_draft_title.dup(), rt.new_string('wp_dashboard_quick_press'), rt.new_null(), rt.new_null(), '', '')
	}
	wp_add_dashboard_widget(rt.new_string('dashboard_primary'), rt.call_function('__', [rt.new_string('WordPress Events and News')]), rt.new_string('wp_dashboard_events_news'), rt.new_null(), rt.new_null(), '', '')
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('wp_network_dashboard_setup')])
		mut var_dashboard_widgets := rt.call_function('apply_filters', [rt.new_string('wp_network_dashboard_widgets'), rt.new_array()])
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('wp_user_dashboard_setup')])
		var_dashboard_widgets = rt.call_function('apply_filters', [rt.new_string('wp_user_dashboard_widgets'), rt.new_array()])
	} else {
		rt.call_function('do_action', [rt.new_string('wp_dashboard_setup')])
		var_dashboard_widgets = rt.call_function('apply_filters', [rt.new_string('wp_dashboard_widgets'), rt.new_array()])
	}
	{
		mut iter_1 := var_dashboard_widgets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_widget_id := item_1.val
			mut var_name := if !rt.is_true(var_wp_registered_widgets.array_get(var_widget_id).array_get('all_link')) { var_wp_registered_widgets.array_get(var_widget_id).array_get('name') } else { (var_wp_registered_widgets.array_get(var_widget_id).array_get('name')).str() + rt.concat(rt.concat(rt.new_string(' <a href=\''), var_wp_registered_widgets.array_get(var_widget_id).array_get('all_link')), rt.new_string('\' class=\'edit-box open-box\'>')) + (rt.call_function('__', [rt.new_string('View all')])).str() + '</a>' }
			wp_add_dashboard_widget(var_widget_id.dup(), var_name.dup(), var_wp_registered_widgets.array_get(var_widget_id).array_get('callback'), var_wp_registered_widget_controls.array_get(var_widget_id).array_get('callback'), rt.new_null(), '', '')
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('POST'), rt.get_superglobal('_SERVER').array_get('REQUEST_METHOD'))) && rt.get_superglobal('_POST').array_isset(rt.new_string('widget_id')))) {
		rt.call_function('check_admin_referer', ['edit-dashboard-widget_' + (rt.get_superglobal('_POST').array_get('widget_id')).str(), rt.new_string('dashboard-widget-nonce')])
		rt.call_function('ob_start', []rt.PhpVal{})
		wp_dashboard_trigger_widget_control(rt.get_superglobal('_POST').array_get('widget_id'))
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		rt.call_function('wp_redirect', [rt.call_function('remove_query_arg', [rt.new_string('edit')])])
		// unsupported expression: Expr_Exit
	}
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'), rt.get_property(var_screen, 'id'), rt.new_string('normal'), rt.new_string('')])
	rt.call_function('do_action', [rt.new_string('do_meta_boxes'), rt.get_property(var_screen, 'id'), rt.new_string('side'), rt.new_string('')])
}

fn wp_add_dashboard_widget(var_widget_id rt.PhpVal, var_widget_name rt.PhpVal, var_callback rt.PhpVal, var_control_callback rt.PhpVal, var_callback_args rt.PhpVal, context string, priority string) {
	mut var_wp_dashboard_control_callbacks := rt.new_null()
	mut var_url := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_private_callback_args := { '__widget_basename': var_widget_name }
	if rt.is_true(rt.new_bool(var_callback_args.dup().is_null())) {
		var_callback_args = var_private_callback_args.dup()
	} else if rt.is_true(rt.new_bool(var_callback_args.dup().is_array())) {
		var_callback_args = rt.call_function('array_merge', [var_callback_args.dup(), var_private_callback_args.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_control_callback) && rt.is_true(rt.call_function('is_callable', [var_control_callback.dup()])))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_dashboard')])))) {
		var_wp_dashboard_control_callbacks.array_set(var_widget_id, var_control_callback.dup())
		if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('edit')) && rt.is_true(rt.identical(var_widget_id, rt.get_superglobal('_GET').array_get('edit'))))) {
			// unsupported assign target: Expr_List
			// unsupported expression: Expr_AssignOp_Concat
			var_callback = '_wp_dashboard_control_callback'
		} else {
			// unsupported assign target: Expr_List
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_side_widgets := ['dashboard_quick_press', 'dashboard_primary']
	if rt.is_true(rt.call_function('in_array', [var_widget_id.dup(), var_side_widgets.dup(), rt.new_bool(true)])) {
		context = 'side'
	}
	mut var_high_priority_widgets := ['dashboard_browser_nag', 'dashboard_php_nag']
	if rt.is_true(rt.call_function('in_array', [var_widget_id.dup(), var_high_priority_widgets.dup(), rt.new_bool(true)])) {
		priority = 'high'
	}
	if context == '' {
		context = 'normal'
	}
	if priority == '' {
		priority = 'core'
	}
	rt.call_function('add_meta_box', [var_widget_id.dup(), var_widget_name.dup(), rt.new_string(var_callback).dup(), var_screen.dup(), rt.new_string(context), rt.new_string(priority), var_callback_args.dup()])
}

fn _wp_dashboard_control_callback(var_dashboard rt.PhpVal, var_meta_box rt.PhpVal) {
	print('<form method="post" class="dashboard-widget-control-form wp-clearfix">')
	wp_dashboard_trigger_widget_control(var_meta_box.array_get('id'))
	rt.call_function('wp_nonce_field', ['edit-dashboard-widget_' + (var_meta_box.array_get('id')).str(), rt.new_string('dashboard-widget-nonce')])
	print('<input type="hidden" name="widget_id" value="' + (rt.call_function('esc_attr', [var_meta_box.array_get('id')])).str() + '" />')
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Save Changes')])])
	print('</form>')
}

fn wp_dashboard() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_columns := rt.call_function('absint', [rt.call_method(var_screen, 'get_columns', []rt.PhpVal{})])
	mut var_columns_css := ''
	if rt.is_true(var_columns) {
		var_columns_css = " columns-${var_columns.to_string()}"
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_columns_css)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'), rt.new_string('normal'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'), rt.new_string('side'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'), rt.new_string('column3'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_meta_boxes', [rt.get_property(var_screen, 'id'), rt.new_string('column4'), rt.new_string('')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('closedpostboxes'), rt.new_string('closedpostboxesnonce'), rt.new_bool(false)])
	rt.call_function('wp_nonce_field', [rt.new_string('meta-box-order'), rt.new_string('meta-box-order-nonce'), rt.new_bool(false)])
}

fn wp_dashboard_right_now() {
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			mut var_num_posts := rt.call_function('wp_count_posts', [var_post_type.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(var_num_posts) && rt.is_true(rt.get_property(var_num_posts, 'publish')))) {
				if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
					mut var_text := rt.call_function('_n', [rt.new_string('%s Published post'), rt.new_string('%s Published posts'), rt.get_property(var_num_posts, 'publish')])
				} else {
					var_text = rt.call_function('_n', [rt.new_string('%s Published page'), rt.new_string('%s Published pages'), rt.get_property(var_num_posts, 'publish')])
				}
				var_text = rt.call_function('sprintf', [var_text.dup(), rt.call_function('number_format_i18n', [rt.get_property(var_num_posts, 'publish')])])
				mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(var_post_type_object) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_posts')])))) {
					mut var_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_type', val: var_post_type }]), rt.call_function('admin_url', [rt.new_string('edit.php')])])
					rt.call_function('printf', [rt.new_string('<li class="%1$s-count"><a href="%2$s">%3$s</a></li>'), var_post_type.dup(), rt.call_function('esc_url', [var_url.dup()]), rt.call_function('esc_html', [var_text.dup()])])
				} else {
					rt.call_function('printf', [rt.new_string('<li class="%1$s-count"><span>%2$s</span></li>'), var_post_type.dup(), var_text.dup()])
				}
			}
		}
	}
	mut var_num_comm := rt.call_function('wp_count_comments', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_num_comm) && rt.is_true(rt.new_bool(rt.is_true(rt.get_property(, 'approved')) || rt.is_true(rt.get_property(, 'moderated')))))) {
		mut var_text := rt.call_function('sprintf', [, ])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val()
	}
	
}

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

fn create_wp_site_health() &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
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




pub fn init_wp_admin_includes_dashboard_php() {
}
