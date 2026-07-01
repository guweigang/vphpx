import rt

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

fn create_wp_plugin_dependencies() &Class_WP_Plugin_Dependencies {
	mut obj := &Class_WP_Plugin_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Plugin_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_status := rt.new_null()
	mut var_page := rt.new_null()
	mut var_user_ID := rt.new_null()
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('activate_plugins'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to manage plugins for this site.'),
			]),
		])
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Plugins_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	mut var_action := rt.call_method(var_wp_list_table, 'current_action', []rt.PhpVal{})
	mut var_plugin := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('plugin')) { rt.call_function('wp_unslash', [
			rt.get_superglobal('_REQUEST').array_get('plugin'),
		]) } else { rt.new_string('') }
	mut var_s := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('urlencode', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')]),
		]) } else { rt.new_string('') }
	mut var_query_args_to_remove := ['error', 'deleted', 'activate', 'activate-multi', 'deactivate',
		'deactivate-multi', 'enabled-auto-update', 'disabled-auto-update',
		'enabled-auto-update-multi', 'disabled-auto-update-multi', '_error_nonce']
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
		var_query_args_to_remove.dup(),
		rt.get_superglobal('_SERVER').array_get('REQUEST_URI'),
	]))
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	fn () rt.PhpVal {
		mut temp := Class_WP_Plugin_Dependencies{}
		return temp.initialize()
	}()
	if rt.is_true(var_action) {
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('activate'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('activate_plugin'),
				var_plugin.dup(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to activate this plugin.'),
					]),
				])
			}
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))))))
				&& rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin.dup()]))))
			{
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				// unsupported expression: Expr_Exit
			}
			rt.call_function('check_admin_referer', [
				'activate-plugin_' + var_plugin.str(),
			])
			mut var_result := rt.call_function('activate_plugin', [
				var_plugin.dup(),
				rt.call_function('self_admin_url', [
					'plugins.php?error=true&plugin=' +
						(rt.call_function('urlencode', [var_plugin.dup()])).str(),
				]),
				rt.call_function('is_network_admin', []rt.PhpVal{})])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
				if rt.is_true(rt.identical(rt.new_string('unexpected_output'), rt.call_method(var_result,
					'get_error_code', []rt.PhpVal{})))
				{
					mut var_redirect := rt.call_function('self_admin_url', [
						'plugins.php?error=true&charsout=' +
							rt.call_method(var_result, 'get_error_data', []rt.PhpVal{}).to_string().len.str() +
							'&plugin=' + (rt.call_function('urlencode', [var_plugin.dup()])).str() +
							'&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}',
					])
					rt.call_function('wp_redirect', [
						rt.call_function('add_query_arg', [rt.new_string('_error_nonce'),
							rt.call_function('wp_create_nonce', [
								'plugin-activation-error_' + var_plugin.str(),
							]),
							var_redirect.dup()]),
					])
					// unsupported expression: Expr_Exit
				} else {
					rt.call_function('wp_die', [var_result.dup()])
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin',
				[]rt.PhpVal{})))))
			{
				mut var_recent := rt.cast_array(rt.call_function('get_option', [
					rt.new_string('recently_activated'),
				]))
				var_recent.array_unset(var_plugin)
				rt.call_function('update_option', [rt.new_string('recently_activated'),
					var_recent.dup(), rt.new_bool(false)])
			} else {
				var_recent = rt.cast_array(rt.call_function('get_site_option', [
					rt.new_string('recently_activated'),
				]))
				var_recent.array_unset(var_plugin)
				rt.call_function('update_site_option', [
					rt.new_string('recently_activated'),
					var_recent.dup(),
				])
			}
			if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('from'))
				&& rt.is_true(rt.identical(rt.new_string('import'), rt.get_superglobal('_GET').array_get('from')))))
			{
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						'import.php?import=' +(rt.call_function('str_replace', [rt.new_string('-importer'), rt.new_string(''), rt.call_function('dirname', [var_plugin.dup()])])).str(),
					]),
				])
			} else if rt.is_true(rt.new_bool(
				rt.get_superglobal('_GET').array_isset(rt.new_string('from'))
				&& rt.is_true(rt.identical(rt.new_string('press-this'), rt.get_superglobal('_GET').array_get('from')))))
			{
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [rt.new_string('press-this.php')]),
				])
			} else {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?activate=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
			}
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('activate-selected'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('activate_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to activate plugins for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-plugins')])
			mut var_plugins := if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get('checked')]))
			} else {
				map[string]rt.PhpVal{}
			}
			if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
				for var_i, var_plugin_shadow in var_plugins {
					if rt.is_true(rt.call_function('is_plugin_active_for_network', [
						var_plugin_shadow.dup(),
					]))
					{
						var_plugins.delete(i)
					}
				}
			} else {
				for var_i, var_plugin_shadow in var_plugins {
					if rt.is_true(rt.new_bool(
						rt.is_true(rt.call_function('is_plugin_active', [var_plugin_shadow.dup()]))
						|| rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
						&& rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin_shadow.dup()]))))))
					{
						var_plugins.delete(i)
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('activate_plugin'),
						var_plugin_shadow.dup(),
					])))))
					{
						var_plugins.delete(i)
					}
				}
			}
			if !rt.is_true(var_plugins) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				// unsupported expression: Expr_Exit
			}
			rt.call_function('activate_plugins', [var_plugins.dup(),
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?error=true'),
				]),
				rt.call_function('is_network_admin', []rt.PhpVal{})])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin',
				[]rt.PhpVal{})))))
			{
				var_recent = rt.cast_array(rt.call_function('get_option', [
					rt.new_string('recently_activated'),
				]))
			} else {
				var_recent = rt.cast_array(rt.call_function('get_site_option', [
					rt.new_string('recently_activated'),
				]))
			}
			for _, var_plugin_shadow in var_plugins {
				var_recent.array_unset(var_plugin_shadow)
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin',
				[]rt.PhpVal{})))))
			{
				rt.call_function('update_option', [rt.new_string('recently_activated'),
					var_recent.dup(), rt.new_bool(false)])
			} else {
				rt.call_function('update_site_option', [
					rt.new_string('recently_activated'),
					var_recent.dup(),
				])
			}
			rt.call_function('wp_redirect', [
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?activate-multi=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
				]),
			])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-plugins')])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('plugins')) {
				var_plugins = rt.call_function('explode', [rt.new_string(','),
					rt.call_function('wp_unslash',
						[rt.get_superglobal('_GET').array_get('plugins')])])
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				var_plugins = rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get('checked'),
				]))
			} else {
				var_plugins = map[string]rt.PhpVal{}
			}
			mut var_title := rt.call_function('__', [rt.new_string('Update Plugins')])
			mut var_parent_file := 'plugins.php'
			rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			print('<div class="wrap">')
			print('<h1>' + (rt.call_function('esc_html', [var_title.dup()])).str() + '</h1>')
			mut var_url := rt.call_function('self_admin_url', [
				'update.php?action=update-selected&amp;plugins=' +(rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), var_plugins.dup()])])).str(),
			])
			var_url = rt.call_function('wp_nonce_url', [var_url.dup(),
				rt.new_string('bulk-update-plugins')])
			print("<iframe src='${var_url.to_string()}' style='width: 100%; height:100%; min-height:850px;'></iframe>")
			print('</div>')
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('error_scrape'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('activate_plugin'),
				var_plugin.dup(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to activate this plugin.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				'plugin-activation-error_' + var_plugin.str(),
			])
			mut var_valid := rt.call_function('validate_plugin', [
				var_plugin.dup()])
			if rt.is_true(rt.call_function('is_wp_error', [var_valid.dup()])) {
				rt.call_function('wp_die', [var_valid.dup()])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
				rt.call_function('error_reporting', [
					rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('E_CORE_ERROR'),
						rt.get_constant('E_CORE_WARNING')), rt.get_constant('E_COMPILE_ERROR')),
						rt.get_constant('E_ERROR')), rt.get_constant('E_WARNING')),
						rt.get_constant('E_PARSE')), rt.get_constant('E_USER_ERROR')),
						rt.get_constant('E_USER_WARNING')), rt.get_constant('E_RECOVERABLE_ERROR')),
				])
			}
			rt.call_function('ini_set', [rt.new_string('display_errors'),
				rt.new_bool(true)])
			rt.call_function('plugin_sandbox_scrape', [var_plugin.dup()])
			rt.call_function('do_action', [
				rt.new_string('activate_${var_plugin.to_string()}'),
			])
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('deactivate'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('deactivate_plugin'),
				var_plugin.dup(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to deactivate this plugin.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				'deactivate-plugin_' + var_plugin.str(),
			])
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))))
				&& rt.is_true(rt.call_function('is_plugin_active_for_network', [var_plugin.dup()]))))
			{
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				// unsupported expression: Expr_Exit
			}
			rt.call_function('deactivate_plugins', [var_plugin.dup(),
				rt.new_bool(false), rt.call_function('is_network_admin', []rt.PhpVal{})])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin',
				[]rt.PhpVal{})))))
			{
				rt.call_function('update_option', [rt.new_string('recently_activated'),
					rt.add(rt.create_array([
						rt.ArrayItem{ key: var_plugin, val: rt.call_function('time', []rt.PhpVal{}) },
					]), rt.cast_array(rt.call_function('get_option', [
						rt.new_string('recently_activated'),
					]))),
					rt.new_bool(false)])
			} else {
				rt.call_function('update_site_option', [
					rt.new_string('recently_activated'),
					rt.add(rt.create_array([
						rt.ArrayItem{ key: var_plugin, val: rt.call_function('time', []rt.PhpVal{}) },
					]), rt.cast_array(rt.call_function('get_site_option', [
						rt.new_string('recently_activated'),
					]))),
				])
			}
			if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
				print("<meta http-equiv='refresh' content='" +
					(rt.call_function('esc_attr', [rt.new_string('0;url=plugins.php?deactivate=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}')])).str() +
					"' />")
			} else {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?deactivate=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
			}
			// unsupported expression: Expr_Exit
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('deactivate-selected'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('deactivate_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to deactivate plugins for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-plugins')])
			var_plugins = if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get('checked')]))
			} else {
				map[string]rt.PhpVal{}
			}
			if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
				var_plugins = rt.call_function('array_filter', [
					var_plugins.dup(), rt.new_string('is_plugin_active_for_network')])
			} else {
				var_plugins = rt.call_function('array_filter', [
					var_plugins.dup(), rt.new_string('is_plugin_active')])
				var_plugins = rt.call_function('array_diff', [
					var_plugins.dup(),
					rt.call_function('array_filter', [
						var_plugins.dup(), rt.new_string('is_plugin_active_for_network')])])
				for var_i, var_plugin_shadow in var_plugins {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('deactivate_plugin'),
						var_plugin_shadow.dup(),
					])))))
					{
						var_plugins.delete(i)
					}
				}
			}
			if !rt.is_true(var_plugins) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				// unsupported expression: Expr_Exit
			}
			rt.call_function('deactivate_plugins', [var_plugins.dup(),
				rt.new_bool(false), rt.call_function('is_network_admin', []rt.PhpVal{})])
			mut var_deactivated := map[string]rt.PhpVal{}
			for _, var_plugin_shadow in var_plugins {
			}
		} else if rt.is_true(rt.equal(switch_val_1)) {
		} else if rt.is_true(rt.equal(switch_val_1)) {
		} else if rt.is_true(rt.equal(switch_val_1)) {
		} else if rt.is_true(rt.equal(switch_val_1)) || rt.is_true(rt.equal(switch_val_1))
			|| rt.is_true(rt.equal(switch_val_1)) || rt.is_true(rt.equal(switch_val_1)) {
		} else {
		}
	}
}
