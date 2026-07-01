import rt

fn get_preferred_from_update_core() bool {
	mut var_updates := rt.new_bool(rt.new_bool(get_core_updates(rt.new_null())))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_updates.dup().is_array()))))) {
		return false
	}
	if !rt.is_true(var_updates) {
		return (// unsupported expression: Expr_Cast_Object).to_bool()
	}
	return (var_updates.array_get(0)).to_bool()
}

fn get_core_updates(var_options rt.PhpVal) bool {
	var_options = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'available', val: true }, rt.ArrayItem{ key: 'dismissed', val: false }]), var_options.dup()])
	mut var_dismissed := rt.call_function('get_site_option', [rt.new_string('dismissed_update_core')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dismissed.dup().is_array()))))) {
		var_dismissed = rt.new_array()
	}
	mut var_from_api := rt.call_function('get_site_transient', [rt.new_string('update_core')])
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_from_api, 'updates')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_from_api, 'updates').is_array()))))))) {
		return false
	}
	mut var_updates := rt.get_property(var_from_api, 'updates')
	mut var_result := rt.new_array()
	{
		mut iter_1 := var_updates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update := item_1.val
			if rt.is_true(rt.identical(rt.new_string('autoupdate'), rt.get_property(var_update, 'response'))) {
				continue
			}
			if rt.is_true(rt.new_bool(var_dismissed.dup().array_isset((rt.get_property(var_update, 'current')).str() + '|' + (rt.get_property(var_update, 'locale')).str()))) {
				if rt.is_true(var_options.array_get('dismissed')) {
					rt.set_property(var_update, 'dismissed', rt.new_bool(true))
					var_result << var_update.dup()
				}
			} else {
				if rt.is_true(var_options.array_get('available')) {
					rt.set_property(var_update, 'dismissed', rt.new_bool(false))
					var_result << var_update.dup()
				}
			}
		}
	}
	return (var_result).to_bool()
}

fn find_core_auto_update() bool {
	mut var_updates := rt.call_function('get_site_transient', [rt.new_string('update_core')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_updates)))) || !rt.is_true(rt.get_property(var_updates, 'updates')))) {
		return false
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '4')
	mut var_auto_update := rt.new_bool(rt.new_bool(false))
	mut var_upgrader := create_wp_automatic_updater()
	{
		mut iter_1 := rt.get_property(var_updates, 'updates').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_upgrader.should_update(rt.new_string('core'), var_update.dup(), rt.get_constant('ABSPATH')))))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_auto_update)))) || rt.is_true(rt.call_function('version_compare', [rt.get_property(var_update, 'current'), rt.get_property(var_auto_update, 'current'), rt.new_string('>')])))) {
				var_auto_update = var_update.dup()
			}
		}
	}
	return (var_auto_update).to_bool()
}

fn get_core_checksums(var_version rt.PhpVal, var_locale rt.PhpVal) bool {
	mut var_http_url := rt.new_string('http://api.wordpress.org/core/checksums/1.0/?' + (rt.call_function('http_build_query', [rt.call_function('compact', [rt.new_string('version'), rt.new_string('locale')]), rt.new_string(''), rt.new_string('&')])).str())
	mut var_url := var_http_url.dup()
	mut var_ssl := rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])
	if rt.is_true(var_ssl) {
		var_url = rt.call_function('set_url_scheme', [var_url.dup(), rt.new_string('https')])
	}
	mut var_options := rt.create_array([rt.ArrayItem{ key: 'timeout', val: if rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})) { 30 } else { 3 } }])
	mut var_response := rt.call_function('wp_remote_get', [var_url.dup(), var_options.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])))) {
		rt.call_function('wp_trigger_error', [rt.new_string(@FN), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() + ' ' + (rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str(), if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) || rt.is_true(rt.get_constant('WP_DEBUG')))) { rt.get_constant('E_USER_WARNING') } else { rt.get_constant('E_USER_NOTICE') }])
		var_response = rt.call_function('wp_remote_get', [var_http_url.dup(), var_options.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	mut var_body := rt.new_string(rt.new_string(rt.call_function('wp_remote_retrieve_body', [var_response.dup()]).to_string().trim_space()))
	var_body = rt.call_function('json_decode', [var_body.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_body.dup().is_array()))))) || !(var_body.array_isset(rt.new_string('checksums'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_body.array_get('checksums').is_array()))))))) {
		return false
	}
	return (var_body.array_get('checksums')).to_bool()
}

fn dismiss_core_update(var_update rt.PhpVal) rt.PhpVal {
	mut var_dismissed := rt.call_function('get_site_option', [rt.new_string('dismissed_update_core')])
	var_dismissed.array_set((rt.get_property(var_update, 'current')).str() + '|' + (rt.get_property(var_update, 'locale')).str(), true)
	return rt.call_function('update_site_option', [rt.new_string('dismissed_update_core'), var_dismissed.dup()])
}

fn undismiss_core_update(var_version rt.PhpVal, var_locale rt.PhpVal) bool {
	mut var_dismissed := rt.call_function('get_site_option', [rt.new_string('dismissed_update_core')])
	mut var_key := rt.new_string((var_version).str() + '|' + (var_locale).str())
	if !(var_dismissed.array_isset(var_key)) {
		return false
	}
	var_dismissed.array_unset(var_key)
	return (rt.call_function('update_site_option', [rt.new_string('dismissed_update_core'), var_dismissed.dup()])).to_bool()
}

fn find_core_update(var_version rt.PhpVal, var_locale rt.PhpVal) bool {
	mut var_from_api := rt.call_function('get_site_transient', [rt.new_string('update_core')])
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_from_api, 'updates')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_from_api, 'updates').is_array()))))))) {
		return false
	}
	mut var_updates := rt.get_property(var_from_api, 'updates')
	{
		mut iter_1 := var_updates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(var_update, 'current'), var_version)) && rt.is_true(rt.identical(rt.get_property(var_update, 'locale'), var_locale)))) {
				return (var_update).to_bool()
			}
		}
	}
	return false
}

fn core_update_footer(msg string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))))) {
		return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s')]), rt.call_function('get_bloginfo', [rt.new_string('version'), rt.new_string('display')])])
	}
	mut var_cur := rt.new_bool(rt.new_bool(get_preferred_from_update_core()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cur.dup().is_object()))))) {
		var_cur = create_stdclass()
	}
	if !(!(rt.get_property(var_cur, 'current')).is_null()) {
		rt.set_property(var_cur, 'current', rt.new_string(''))
	}
	if !(!(rt.get_property(var_cur, 'response')).is_null()) {
		rt.set_property(var_cur, 'response', rt.new_string(''))
	}
	mut var_is_development_version := rt.call_function('preg_match', [rt.new_string('/alpha|beta|RC/'), rt.call_function('wp_get_wp_version', []rt.PhpVal{})])
	if rt.is_true(var_is_development_version) {
		return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You are using a development version (%1$s). Cool! Please <a href="%2$s">stay updated</a>.')]), rt.call_function('get_bloginfo', [rt.new_string('version'), rt.new_string('display')]), rt.call_function('network_admin_url', [rt.new_string('update-core.php')])])
	}
	mut switch_val_1 := rt.get_property(var_cur, 'response')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrade'))) {
		return rt.call_function('sprintf', [rt.new_string('<strong><a href="%s">%s</a></strong>'), rt.call_function('network_admin_url', [rt.new_string('update-core.php')]), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Get Version %s')]), rt.get_property(var_cur, 'current')])])
	} else {
		return rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Version %s')]), rt.call_function('get_bloginfo', [rt.new_string('version'), rt.new_string('display')])])
	}
	return rt.new_null()
}

fn update_nag() bool {
	mut var_pagenow := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('update-core.php'), var_pagenow)) {
		return false
	}
	mut var_cur := get_preferred_from_update_core()
	if rt.is_true(rt.new_bool(!(!(rt.get_property(rt.new_bool(var_cur), 'response')).is_null()) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	mut var_version_url := rt.call_function('sprintf', [rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://wordpress.org/documentation/wordpress-version/version-%s/')])]), rt.call_function('sanitize_title', [rt.get_property(rt.new_bool(var_cur), 'current')])])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		mut var_msg := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%1$s">WordPress %2$s</a> is available! <a href="%3$s" aria-label="%4$s">Please update now</a>.')]), var_version_url.dup(), rt.get_property(rt.new_bool(var_cur), 'current'), rt.call_function('network_admin_url', [rt.new_string('update-core.php')]), rt.call_function('esc_attr__', [rt.new_string('Please update WordPress now')])])
	} else {
		var_msg = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<a href="%1$s">WordPress %2$s</a> is available! Please notify the site administrator.')]), var_version_url.dup(), rt.get_property(rt.new_bool(var_cur), 'current')])
	}
	rt.call_function('wp_admin_notice', [var_msg.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([rt.ArrayItem{ key: none, val: 'update-nag' }, rt.ArrayItem{ key: none, val: 'inline' }]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	return false
}

fn update_right_now_message() {
	mut var_theme_name := rt.call_function('wp_get_theme', []rt.PhpVal{})
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) {
		var_theme_name = rt.call_function('sprintf', [rt.new_string('<a href="themes.php">%1$s</a>'), var_theme_name.dup()])
	}
	mut var_msg := ''
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
		mut var_cur := get_preferred_from_update_core()
		if rt.is_true(rt.new_bool(!(rt.get_property(rt.new_bool(var_cur), 'response')).is_null() && rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(rt.new_bool(var_cur), 'response'))))) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_content := rt.call_function('__', [rt.new_string('WordPress %1$s running %2$s theme.')])
	var_content = rt.call_function('apply_filters', [rt.new_string('update_right_now_text'), var_content.dup()])
	// unsupported expression: Expr_AssignOp_Concat
	print("<p id='wp-version-message'>${var_msg}</p>")
}

fn get_plugin_updates() rt.PhpVal {
	mut var_all_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_upgrade_plugins := rt.new_array()
	mut var_current := rt.call_function('get_site_transient', [rt.new_string('update_plugins')])
	{
		mut iter_1 := rt.cast_array(var_all_plugins).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin_data := item_1.val
			mut var_plugin_file := item_1.key
			if rt.get_property(, 'response').array_isset(var_plugin_file) {
				
			}
		}
	}
	return .dup()
}

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_automatic_updater() &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Automatic_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Automatic_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Automatic_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_admin_includes_update_php() {
}
