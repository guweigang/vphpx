import rt

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

fn create_wp_plugin_dependencies(_args ...rt.PhpVal) &Class_WP_Plugin_Dependencies {
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
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('plugin')),
		]) } else { rt.new_string('') }
	mut var_s := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('urlencode', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]),
		]) } else { rt.new_string('') }
	mut var_query_args_to_remove := ['error', 'deleted', 'activate', 'activate-multi', 'deactivate',
		'deactivate-multi', 'enabled-auto-update', 'disabled-auto-update',
		'enabled-auto-update-multi', 'disabled-auto-update-multi', '_error_nonce']
	rt.get_superglobal('_SERVER').array_set('REQUEST_URI', rt.call_function('remove_query_arg', [
		rt.create_array_from_list(var_query_args_to_remove),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
	]))
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	mut iife_temp_0 := Class_WP_Plugin_Dependencies{}
	mut iife_result_0 := iife_temp_0.initialize()
	if rt.is_true(var_action) {
		mut switch_val_1 := var_action
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('activate'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('activate_plugin'),
				var_plugin.clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to activate this plugin.'),
					]),
				])
			}
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))))
				&& rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin.clone()])) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				exit(0)
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('activate-plugin_' + var_plugin.str()),
			])
			mut var_result := rt.call_function('activate_plugin', [
				var_plugin.clone(),
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?error=true&plugin=' +
						(rt.call_function('urlencode', [var_plugin.clone()])).str()),
				]),
				rt.call_function('is_network_admin', []rt.PhpVal{})])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				if rt.is_true(rt.identical(rt.new_string('unexpected_output'), rt.call_method(var_result,
					'get_error_code', []rt.PhpVal{})))
				{
					mut var_redirect := rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?error=true&charsout=' +
							rt.call_method(var_result, 'get_error_data', []rt.PhpVal{}).to_string().len.str() +
							'&plugin=' +
							(rt.call_function('urlencode', [var_plugin.clone()])).str() +
							'&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					])
					rt.call_function('wp_redirect', [
						rt.call_function('add_query_arg', [rt.new_string('_error_nonce'),
							rt.call_function('wp_create_nonce', [
								rt.new_string('plugin-activation-error_' + var_plugin.str()),
							]),
							var_redirect.clone()]),
					])
					exit(0)
				} else {
					rt.call_function('wp_die', [var_result.clone()])
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
					var_recent.clone(), rt.new_bool(false)])
			} else {
				var_recent = rt.cast_array(rt.call_function('get_site_option', [
					rt.new_string('recently_activated'),
				]))
				var_recent.array_unset(var_plugin)
				rt.call_function('update_site_option', [
					rt.new_string('recently_activated'),
					var_recent.clone(),
				])
			}
			if rt.get_superglobal('_GET').array_isset(rt.new_string('from'))
				&& rt.is_true(rt.identical(rt.new_string('import'), rt.get_superglobal('_GET').array_get(rt.new_string('from')))) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('import.php?import=' +(rt.call_function('str_replace', [rt.new_string('-importer'), rt.new_string(''), rt.call_function('dirname', [var_plugin.clone()])])).str()),
					]),
				])
			} else if rt.get_superglobal('_GET').array_isset(rt.new_string('from'))
				&& rt.is_true(rt.identical(rt.new_string('press-this'), rt.get_superglobal('_GET').array_get(rt.new_string('from')))) {
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
			exit(0)
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
					rt.get_superglobal('_POST').array_get(rt.new_string('checked')),
				]))
			} else {
				map[string]rt.PhpVal{}
			}
			if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
				for var_i, var_plugin_shadow in var_plugins {
					if rt.is_true(rt.call_function('is_plugin_active_for_network', [
						var_plugin_shadow.clone(),
					]))
					{
						var_plugins.delete(i)
					}
				}
			} else {
				for var_i, var_plugin_shadow in var_plugins {
					if rt.is_true(rt.call_function('is_plugin_active', [var_plugin_shadow.clone()]))
						|| (rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
						&& rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin_shadow.clone()]))) {
						var_plugins.delete(i)
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('activate_plugin'),
						var_plugin_shadow.clone(),
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
				exit(0)
			}
			rt.call_function('activate_plugins', [
				rt.create_array_from_native_map(var_plugins),
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?error=true'),
				]),
				rt.call_function('is_network_admin', []rt.PhpVal{}),
			])
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
					var_recent.clone(), rt.new_bool(false)])
			} else {
				rt.call_function('update_site_option', [
					rt.new_string('recently_activated'),
					var_recent.clone(),
				])
			}
			rt.call_function('wp_redirect', [
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?activate-multi=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
				]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('update-selected'))) {
			rt.call_function('check_admin_referer', [rt.new_string('bulk-plugins')])
			if rt.get_superglobal('_GET').array_isset(rt.new_string('plugins')) {
				var_plugins = rt.call_function('explode', [rt.new_string(','),
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_GET').array_get(rt.new_string('plugins')),
					])])
			} else if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				var_plugins = rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('checked')),
				]))
			} else {
				var_plugins = map[string]rt.PhpVal{}
			}
			mut var_title := rt.call_function('__', [rt.new_string('Update Plugins')])
			mut var_parent_file := 'plugins.php'
			rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
			print('<div class="wrap">')
			print('<h1>' + (rt.call_function('esc_html', [var_title.clone()])).str() + '</h1>')
			mut var_url := rt.call_function('self_admin_url', [
				rt.new_string('update.php?action=update-selected&amp;plugins=' +(rt.call_function('urlencode', [rt.call_function('implode', [rt.new_string(','), rt.create_array_from_native_map(var_plugins)])])).str()),
			])
			var_url = rt.call_function('wp_nonce_url', [var_url.clone(),
				rt.new_string('bulk-update-plugins')])
			print("<iframe src='${var_url.to_string()}' style='width: 100%; height:100%; min-height:850px;'></iframe>")
			print('</div>')
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('error_scrape'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('activate_plugin'),
				var_plugin.clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to activate this plugin.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('plugin-activation-error_' + var_plugin.str()),
			])
			mut var_valid := rt.call_function('validate_plugin', [
				var_plugin.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_valid.clone()])) {
				rt.call_function('wp_die', [var_valid.clone()])
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
			rt.call_function('plugin_sandbox_scrape', [var_plugin.clone()])
			rt.call_function('do_action', [
				rt.new_string('activate_${var_plugin.to_string()}'),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('deactivate'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('deactivate_plugin'),
				var_plugin.clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to deactivate this plugin.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('deactivate-plugin_' + var_plugin.str()),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})))))
				&& rt.is_true(rt.call_function('is_plugin_active_for_network', [var_plugin.clone()])) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				exit(0)
			}
			rt.call_function('deactivate_plugins', [var_plugin.clone(),
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
			exit(0)
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
					rt.get_superglobal('_POST').array_get(rt.new_string('checked')),
				]))
			} else {
				map[string]rt.PhpVal{}
			}
			if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
				var_plugins = rt.call_function('array_filter', [
					rt.create_array_from_native_map(var_plugins),
					rt.new_string('is_plugin_active_for_network'),
				])
			} else {
				var_plugins = rt.call_function('array_filter', [
					rt.create_array_from_native_map(var_plugins),
					rt.new_string('is_plugin_active'),
				])
				var_plugins = rt.call_function('array_diff', [
					rt.create_array_from_native_map(var_plugins),
					rt.call_function('array_filter', [
						rt.create_array_from_native_map(var_plugins),
						rt.new_string('is_plugin_active_for_network'),
					]),
				])
				for var_i, var_plugin_shadow in var_plugins {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
						rt.new_string('deactivate_plugin'),
						var_plugin_shadow.clone(),
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
				exit(0)
			}
			rt.call_function('deactivate_plugins', [
				rt.create_array_from_native_map(var_plugins),
				rt.new_bool(false),
				rt.call_function('is_network_admin', []rt.PhpVal{}),
			])
			mut var_deactivated := map[string]rt.PhpVal{}
			for _, var_plugin_shadow in var_plugins {
				var_deactivated.array_set(var_plugin_shadow,
					rt.call_function('time', []rt.PhpVal{}))
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin',
				[]rt.PhpVal{})))))
			{
				rt.call_function('update_option', [rt.new_string('recently_activated'),
					rt.add(var_deactivated, rt.cast_array(rt.call_function('get_option', [
						rt.new_string('recently_activated'),
					]))),
					rt.new_bool(false)])
			} else {
				rt.call_function('update_site_option', [
					rt.new_string('recently_activated'),
					rt.add(var_deactivated, rt.cast_array(rt.call_function('get_site_option', [
						rt.new_string('recently_activated'),
					]))),
				])
			}
			rt.call_function('wp_redirect', [
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?deactivate-multi=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
				]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete-selected'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('delete_plugins'),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to delete plugins for this site.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [rt.new_string('bulk-plugins')])
			var_plugins = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('checked')) {
				rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_REQUEST').array_get(rt.new_string('checked')),
				]))
			} else {
				map[string]rt.PhpVal{}
			}
			if !rt.is_true(var_plugins) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				exit(0)
			}
			var_plugins = rt.call_function('array_filter', [
				rt.create_array_from_native_map(var_plugins),
				rt.new_string('is_plugin_inactive'),
			])
			if !rt.is_true(var_plugins) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?error=true&main=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				exit(0)
			}
			mut var_invalid_plugin_files := rt.call_function('array_filter', [
				rt.create_array_from_native_map(var_plugins),
				rt.new_string('validate_file'),
			])
			if rt.is_true(var_invalid_plugin_files) {
				rt.call_function('wp_redirect', [
					rt.call_function('self_admin_url', [
						rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
					]),
				])
				exit(0)
			}
			rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/update.php', '3')
			var_parent_file = 'plugins.php'
			if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('verify-delete'))) {
				rt.call_function('wp_enqueue_script', [rt.new_string('jquery')])
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php',
					'4')
				// unsupported statement: Stmt_InlineHTML
				mut var_plugin_info := map[string]rt.PhpVal{}
				mut var_have_non_network_plugins := false
				mut iter_1 := rt.cast_array(var_plugins).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_plugin_shadow := item_1.val
					mut var_plugin_slug := rt.call_function('dirname', [
						var_plugin_shadow.clone()])
					if rt.is_true(rt.identical(rt.new_string('.'), var_plugin_slug)) {
						mut var_data := rt.call_function('get_plugin_data', [
							rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' +
								var_plugin_shadow.str()),
						])
						if rt.is_true(var_data) {
							var_plugin_info.array_set(var_plugin_shadow, var_data.clone())
							var_plugin_info.array_get_mut(var_plugin_shadow).array_set('is_uninstallable', rt.call_function('is_uninstallable_plugin', [
								var_plugin_shadow.clone(),
							]))
							if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_info.array_get(var_plugin_shadow).array_get(rt.new_string('Network')))))) {
								var_have_non_network_plugins = true
							}
						}
					} else {
						mut var_folder_plugins := rt.call_function('get_plugins', [
							rt.new_string('/' + var_plugin_slug.str()),
						])
						if rt.is_true(var_folder_plugins) {
							mut iter_2 := var_folder_plugins.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_data_shadow := item_2.val
								mut var_plugin_file := item_2.key
								var_plugin_info.array_set(var_plugin_file, rt.call_function('_get_plugin_data_markup_translate', [
									var_plugin_file.clone(),
									var_data_shadow.clone(),
								]))
								var_plugin_info.array_get_mut(var_plugin_file).array_set('is_uninstallable', rt.call_function('is_uninstallable_plugin', [
									var_plugin_shadow.clone(),
								]))
								if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_info.array_get(var_plugin_file).array_get(rt.new_string('Network')))))) {
									var_have_non_network_plugins = true
								}
							}
						}
					}
				}
				mut var_plugins_to_delete := var_plugin_info.clone().array_count()
				// unsupported statement: Stmt_InlineHTML
				if 1 == var_plugins_to_delete {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Delete Plugin')])
					// unsupported statement: Stmt_InlineHTML
					if var_have_non_network_plugins
						&& rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
						mut var_maybe_active_plugin := rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('Caution:')])).str() +
							'</strong> ' +(rt.call_function('__', [rt.new_string('This plugin may be active on other sites in the network.')])).str())
						rt.call_function('wp_admin_notice', [
							var_maybe_active_plugin.clone(),
							rt.create_array([
								rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'error' },
								]) },
							])])
					}
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('You are about to remove the following plugin:'),
					])
					// unsupported statement: Stmt_InlineHTML
				} else {
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [rt.new_string('Delete Plugins')])
					// unsupported statement: Stmt_InlineHTML
					if var_have_non_network_plugins
						&& rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
						mut var_maybe_active_plugins := rt.new_string('<strong>' +
							(rt.call_function('__', [rt.new_string('Caution:')])).str() +
							'</strong> ' +(rt.call_function('__', [rt.new_string('These plugins may be active on other sites in the network.')])).str())
						rt.call_function('wp_admin_notice', [
							var_maybe_active_plugins.clone(),
							rt.create_array([
								rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'error' },
								]) },
							])])
					}
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('_e', [
						rt.new_string('You are about to remove the following plugins:'),
					])
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				mut var_data_to_delete := false
				mut iter_3 := var_plugin_info.iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_plugin_shadow := item_3.val
					if rt.is_true(var_plugin_shadow.array_get(rt.new_string('is_uninstallable'))) {
						print('<li>')
						rt.echo_val(rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('%1$s by %2$s (will also <strong>delete its data</strong>)'),
							]),
							rt.new_string('<strong>' +
								(var_plugin_shadow.array_get(rt.new_string('Name'))).str() + '</strong>'),
							rt.new_string('<em>' +
								(var_plugin_shadow.array_get(rt.new_string('AuthorName'))).str() + '</em>'),
						]))
						print('</li>')
						var_data_to_delete = true
					} else {
						print('<li>')
						print(
							(rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s by %2$s'), rt.new_string('plugin')]), rt.new_string('<strong>' + (var_plugin_shadow.array_get(rt.new_string('Name'))).str() + '</strong>'), rt.new_string('<em>' + (var_plugin_shadow.array_get(rt.new_string('AuthorName'))).str())])).str() + '</em>')
						print('</li>')
					}
				}
				// unsupported statement: Stmt_InlineHTML
				if var_data_to_delete {
					rt.call_function('_e', [
						rt.new_string('Are you sure you want to delete these files and data?'),
					])
				} else {
					rt.call_function('_e', [
						rt.new_string('Are you sure you want to delete these files?'),
					])
				}
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_url', [
					rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')),
				]))
				// unsupported statement: Stmt_InlineHTML
				mut iter_4 := rt.cast_array(var_plugins).iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_plugin_shadow := item_4.val
					print('<input type="hidden" name="checked[]" value="' +
						(rt.call_function('esc_attr', [var_plugin_shadow.clone()])).str() + '" />')
				}
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('wp_nonce_field', [rt.new_string('bulk-plugins')])
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('submit_button', [if var_data_to_delete { rt.call_function('__', [
						rt.new_string('Yes, delete these files and data'),
					]) } else { rt.call_function('__', [
						rt.new_string('Yes, delete these files'),
					]) }, rt.new_string(''), rt.new_string('submit'),
					rt.new_bool(false)])
				// unsupported statement: Stmt_InlineHTML
				mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if rt.is_true(var_referer) { rt.call_function('esc_url', [
						var_referer.clone(),
					]) } else { rt.new_string('') })
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('submit_button', [
					rt.call_function('__', [
						rt.new_string('No, return me to the plugin list'),
					]),
					rt.new_string(''),
					rt.new_string('submit'),
					rt.new_bool(false),
				])
				// unsupported statement: Stmt_InlineHTML
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php',
					'4')
				exit(0)
			} else {
				var_plugins_to_delete = var_plugins.len
			}
			mut var_delete_result := rt.call_function('delete_plugins', [
				rt.create_array_from_native_map(var_plugins),
			])
			rt.call_function('update_option', [
				rt.new_string('plugins_delete_result_' + var_user_ID.str()),
				var_delete_result.clone(),
				rt.new_bool(false),
			])
			rt.call_function('wp_redirect', [
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?deleted=${var_plugins_to_delete.str()}&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
				]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear-recent-list'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin',
				[]rt.PhpVal{})))))
			{
				rt.call_function('update_option', [rt.new_string('recently_activated'),
					map[string]rt.PhpVal{}, rt.new_bool(false)])
			} else {
				rt.call_function('update_site_option', [
					rt.new_string('recently_activated'),
					map[string]rt.PhpVal{},
				])
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('resume'))) {
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
				return rt.new_null()
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('resume_plugin'),
				var_plugin.clone(),
			])))))
			{
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to resume this plugin.'),
					]),
				])
			}
			rt.call_function('check_admin_referer', [
				rt.new_string('resume-plugin_' + var_plugin.str()),
			])
			var_result = rt.call_function('resume_plugin', [var_plugin.clone(),
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?error=resuming&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
				])])
			if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
				rt.call_function('wp_die', [var_result.clone()])
			}
			rt.call_function('wp_redirect', [
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?resume=true&plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
				]),
			])
			exit(0)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-auto-update')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-auto-update')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('enable-auto-update-selected')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('disable-auto-update-selected'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')])))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('plugin')]))))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Sorry, you are not allowed to manage plugins automatic updates.'),
					]),
				])
			}
			if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
				rt.call_function('wp_die', [
					rt.call_function('__', [
						rt.new_string('Please connect to your network admin to manage plugins automatic updates.'),
					]),
				])
			}
			var_redirect = rt.call_function('self_admin_url', [
				rt.new_string('plugins.php?plugin_status=${var_status.to_string()}&paged=${var_page.to_string()}&s=${var_s.to_string()}'),
			])
			if rt.is_true(rt.identical(rt.new_string('enable-auto-update'), var_action))
				|| rt.is_true(rt.identical(rt.new_string('disable-auto-update'), var_action)) {
				if !rt.is_true(var_plugin) {
					rt.call_function('wp_redirect', [var_redirect.clone()])
					exit(0)
				}
				rt.call_function('check_admin_referer', [rt.new_string('updates')])
			} else {
				if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('checked'))) {
					rt.call_function('wp_redirect', [var_redirect.clone()])
					exit(0)
				}
				rt.call_function('check_admin_referer', [rt.new_string('bulk-plugins')])
			}
			mut var_auto_updates := rt.cast_array(rt.call_function('get_site_option', [
				rt.new_string('auto_update_plugins'),
				map[string]rt.PhpVal{},
			]))
			if rt.is_true(rt.identical(rt.new_string('enable-auto-update'), var_action)) {
				var_auto_updates.array_push(var_plugin.clone())
				var_auto_updates = rt.call_function('array_unique', [
					var_auto_updates.clone()])
				var_redirect = rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: 'enabled-auto-update', val: 'true' },
					]),
					var_redirect.clone(),
				])
			} else if rt.is_true(rt.identical(rt.new_string('disable-auto-update'), var_action)) {
				var_auto_updates = rt.call_function('array_diff', [
					var_auto_updates.clone(),
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_plugin },
					])])
				var_redirect = rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: 'disabled-auto-update', val: 'true' },
					]),
					var_redirect.clone(),
				])
			} else {
				var_plugins = rt.cast_array(rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('checked')),
				]))
				if rt.is_true(rt.identical(rt.new_string('enable-auto-update-selected'), var_action)) {
					mut var_new_auto_updates := rt.call_function('array_merge', [
						var_auto_updates.clone(),
						rt.create_array_from_native_map(var_plugins),
					])
					var_new_auto_updates = rt.call_function('array_unique', [
						var_new_auto_updates.clone()])
					mut var_query_args := rt.create_array([
						rt.ArrayItem{ key: 'enabled-auto-update-multi', val: 'true' },
					])
				} else {
					var_new_auto_updates = rt.call_function('array_diff', [
						var_auto_updates.clone(), rt.create_array_from_native_map(var_plugins)])
					var_query_args = rt.create_array([
						rt.ArrayItem{ key: 'disabled-auto-update-multi', val: 'true' },
					])
				}
				if rt.is_true(rt.equal(var_new_auto_updates, var_auto_updates)) {
					rt.call_function('wp_redirect', [var_redirect.clone()])
					exit(0)
				}
				var_auto_updates = var_new_auto_updates.clone()
				var_redirect = rt.call_function('add_query_arg', [
					var_query_args.clone(), var_redirect.clone()])
			}
			mut var_all_items := rt.call_function('apply_filters', [
				rt.new_string('all_plugins'),
				rt.call_function('get_plugins', []rt.PhpVal{}),
			])
			var_auto_updates = rt.call_function('array_intersect', [
				var_auto_updates.clone(), rt.func_array_keys(var_all_items.clone())])
			rt.call_function('update_site_option', [rt.new_string('auto_update_plugins'),
				var_auto_updates.clone()])
			rt.call_function('wp_redirect', [var_redirect.clone()])
			exit(0)
		} else {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
				rt.call_function('check_admin_referer', [rt.new_string('bulk-plugins')])
				mut var_screen := rt.get_property(rt.call_function('get_current_screen',
					[]rt.PhpVal{}), 'id')
				mut var_sendback := rt.call_function('wp_get_referer', []rt.PhpVal{})
				var_plugins = if rt.get_superglobal('_POST').array_isset(rt.new_string('checked')) {
					rt.cast_array(rt.call_function('wp_unslash', [
						rt.get_superglobal('_POST').array_get(rt.new_string('checked')),
					]))
				} else {
					map[string]rt.PhpVal{}
				}
				var_sendback = rt.call_function('apply_filters', [
					rt.new_string('handle_bulk_actions-${var_screen.to_string()}'),
					var_sendback.clone(),
					var_action.clone(),
					rt.create_array_from_native_map(var_plugins),
				])
				rt.call_function('wp_safe_redirect', [var_sendback.clone()])
				exit(0)
			}
		}
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('plugin-install')])
	rt.call_function('add_thickbox', []rt.PhpVal{})
	rt.call_function('add_screen_option', [rt.new_string('per_page'),
		rt.create_array([rt.ArrayItem{ key: 'default', val: 999 }])])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Plugins extend and expand the functionality of WordPress. Once a plugin is installed, you may activate it or deactivate it here.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('The search for installed plugins will search for terms in their name, description, or author.')])).str() +
				' <span id="live-search-desc" class="hide-if-no-js">' +
				(rt.call_function('__', [rt.new_string('The search results will be updated as you type.')])).str() +
				'</span></p>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you would like to see more plugins to choose from, click on the &#8220;Add Plugin&#8221; button and you will be able to browse or search for additional plugins from the <a href="%s">WordPress Plugin Directory</a>. Plugins in the WordPress Plugin Directory are designed and developed by third parties, and are compatible with the license WordPress uses. Oh, and they are free!')]), rt.call_function('__', [rt.new_string('https://wordpress.org/plugins/')])])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'compatibility-problems' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Troubleshooting'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('Most of the time, plugins play nicely with the core of WordPress and with other plugins. Sometimes, though, a plugin&#8217;s code will get in the way of another plugin, causing compatibility issues. If your site starts doing strange things, this may be the problem. Try deactivating all your plugins and re-activating them in various combinations until you isolate which one(s) caused the issue.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If something goes wrong with a plugin and you cannot use WordPress, delete or rename that file in the %s directory and it will be automatically deactivated.')]), rt.new_string('<code>' + (rt.get_constant('WP_PLUGIN_DIR')).str() + '</code>')])).str() +
				'</p>' }]),
	])
	mut var_help_sidebar_autoupdates := rt.new_string('')
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_plugins')]))
		&& rt.is_true(rt.call_function('wp_is_auto_update_enabled_for_type', [rt.new_string('plugin')])) {
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'plugins-themes-auto-updates' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Auto-updates'),
				]) },
				rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('Auto-updates can be enabled or disabled for each individual plugin. Plugins with auto-updates enabled will display the estimated date of the next auto-update. Auto-updates depends on the WP-Cron task scheduling system.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Auto-updates are only available for plugins recognized by WordPress.org, or that include a compatible update system.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('Please note: Third-party themes and plugins, or custom code, may override WordPress scheduling.')])).str() +
					'</p>' },
			]),
		])
		var_help_sidebar_autoupdates = rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/plugins-themes-auto-updates/">Documentation on Auto-updates</a>')])).str() +
			'</p>')
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
		rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'plugins-dependencies' },
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Dependencies'),
				]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
					(rt.call_function('__', [rt.new_string('Plugin Dependencies aims to make the process of installing and activating add-ons (dependents) and the plugins they rely on (dependencies) consistent and easy.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('If a required plugin is deleted, a notice will be displayed on the Plugin administration screen informing the user that there is some missing dependencies to install and/or activate. Additionally, each plugin whose dependencies are not met will have an error notice on their plugin row.')])).str() +
					'</p>' + '<p>' +
					(rt.call_function('__', [rt.new_string('If a dependent plugin is missing some dependencies, its activation button will be disabled until the required dependencies are activated.')])).str() +
					'</p>' }]),
		])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/manage-plugins/">Documentation on Managing Plugins</a>')])).str() +
			'</p>' + var_help_sidebar_autoupdates.str() + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter plugins list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Plugins list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Plugins list'),
			]) },
		]),
	])
	var_title = rt.call_function('__', [rt.new_string('Plugins')])
	var_parent_file = 'plugins.php'
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	mut var_invalid := rt.call_function('validate_active_plugins', []rt.PhpVal{})
	if !(!rt.is_true(var_invalid)) {
		mut iter_5 := var_invalid.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_error := item_5.val
			mut var_plugin_file := item_5.key
			mut var_deactivated_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The plugin %1$s has been deactivated due to an error: %2$s'),
				]),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_plugin_file.clone()])).str() + '</code>'),
				rt.call_function('esc_html', [
					rt.call_method(var_error, 'get_error_message', []rt.PhpVal{}),
				]),
			])
			rt.call_function('wp_admin_notice', [var_deactivated_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'error' },
					]) }])])
		}
	}
	mut var_updated_notice_args := {
		'id':                 rt.new_string('message')
		'additional_classes': map[string]rt.PhpVal{}
		'dismissible':        rt.new_bool(true)
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('error')) {
		if rt.get_superglobal('_GET').array_isset(rt.new_string('main')) {
			mut var_errmsg := rt.call_function('__', [
				rt.new_string('You cannot delete a plugin while it is active on the main site.'),
			])
		} else if rt.get_superglobal('_GET').array_isset(rt.new_string('charsout')) {
			var_errmsg = rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('The plugin generated %d character of <strong>unexpected output</strong> during activation.'),
					rt.new_string('The plugin generated %d characters of <strong>unexpected output</strong> during activation.'),
					rt.get_superglobal('_GET').array_get(rt.new_string('charsout')),
				]),
				rt.get_superglobal('_GET').array_get(rt.new_string('charsout')),
			])
			var_errmsg = rt.concat(var_errmsg,
				rt.new_string(' ' +(rt.call_function('__', [rt.new_string('If you notice &#8220;headers already sent&#8221; messages, problems with syndication feeds or other issues, try deactivating or removing this plugin.')])).str()))
		} else if rt.is_true(rt.identical(rt.new_string('resuming'),
			rt.get_superglobal('_GET').array_get(rt.new_string('error'))))
		{
			var_errmsg = rt.call_function('__', [
				rt.new_string('Plugin could not be resumed because it triggered a <strong>fatal error</strong>.'),
			])
		} else {
			var_errmsg = rt.call_function('__', [
				rt.new_string('Plugin could not be activated because it triggered a <strong>fatal error</strong>.'),
			])
		}
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('main')))
			&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('charsout')))
			&& rt.get_superglobal('_GET').array_isset(rt.new_string('_error_nonce'))
			&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_GET').array_get(rt.new_string('_error_nonce')), rt.new_string('plugin-activation-error_' + var_plugin.str())])) {
			mut var_iframe_url := rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'action', val: 'error_scrape' },
					rt.ArrayItem{ key: 'plugin', val: rt.call_function('urlencode', [
						var_plugin.clone(),
					]) }, rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('urlencode', [
						rt.get_superglobal('_GET').array_get(rt.new_string('_error_nonce')),
					]) }]),
				rt.call_function('admin_url', [rt.new_string('plugins.php')]),
			])
			var_errmsg = rt.concat(var_errmsg, rt.new_string(
				'<iframe style="border:0" width="100%" height="70px" src="' +
				(rt.call_function('esc_url', [var_iframe_url.clone()])).str() + '"></iframe>'))
		}
		rt.call_function('wp_admin_notice', [var_errmsg.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) }])])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('deleted')) {
		var_delete_result = rt.call_function('get_option', [
			rt.new_string('plugins_delete_result_' + var_user_ID.str()),
		])
		rt.call_function('delete_option', [
			rt.new_string('plugins_delete_result_' + var_user_ID.str()),
		])
		if rt.is_true(rt.call_function('is_wp_error', [var_delete_result.clone()])) {
			mut var_plugin_not_deleted_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Plugin could not be deleted due to an error: %s'),
				]),
				rt.call_function('esc_html', [
					rt.call_method(var_delete_result, 'get_error_message', []rt.PhpVal{}),
				]),
			])
			rt.call_function('wp_admin_notice', [var_plugin_not_deleted_message.clone(),
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'message' },
					rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'error' },
					]) }, rt.ArrayItem{ key: 'dismissible', val: true }])])
		} else {
			if 1 == rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('deleted'))).to_i64()) {
				mut var_plugins_deleted_message := rt.call_function('__', [
					rt.new_string('The selected plugin has been deleted.'),
				])
			} else {
				var_plugins_deleted_message = rt.call_function('__', [
					rt.new_string('The selected plugins have been deleted.'),
				])
			}
			rt.call_function('wp_admin_notice', [var_plugins_deleted_message.clone(),
				rt.create_array_from_native_map(var_updated_notice_args)])
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('activate')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Plugin activated.')]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('activate-multi')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Selected plugins activated.')]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('deactivate')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Plugin deactivated.')]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('deactivate-multi')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Selected plugins deactivated.')]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.is_true(rt.identical(rt.new_string('update-selected'), var_action)) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('All selected plugins are up to date.'),
			]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('resume')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Plugin resumed.')]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled-auto-update')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [rt.new_string('Plugin will be auto-updated.')]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled-auto-update')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('Plugin will no longer be auto-updated.'),
			]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('enabled-auto-update-multi')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('Selected plugins will be auto-updated.'),
			]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('disabled-auto-update-multi')) {
		rt.call_function('wp_admin_notice', [
			rt.call_function('__', [
				rt.new_string('Selected plugins will no longer be auto-updated.'),
			]),
			rt.create_array_from_native_map(var_updated_notice_args),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_WP_Plugin_Dependencies{}
	mut iife_result_1 := iife_temp_1.display_admin_notice_for_unmet_dependencies()
	mut iife_temp_2 := Class_WP_Plugin_Dependencies{}
	mut iife_result_2 := iife_temp_2.display_admin_notice_for_circular_dependencies()
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		|| rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('self_admin_url', [rt.new_string('plugin-install.php')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html__', [rt.new_string('Add Plugin')]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(rt.new_int(var_s.clone().to_string().len)) {
		print('<span class="subtitle">')
		rt.call_function('printf', [
			rt.call_function('__', [rt.new_string('Search results for: %s')]),
			rt.new_string('<strong>' +
				(rt.call_function('esc_html', [rt.call_function('urldecode', [var_s.clone()])])).str() +
				'</strong>'),
		])
		print('</span>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('pre_current_active_plugins'), var_plugins['all']])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search installed plugins')]),
		rt.new_string('plugin'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_status.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_page.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_request_filesystem_credentials_modal', []rt.PhpVal{})
	rt.call_function('wp_print_admin_notice_templates', []rt.PhpVal{})
	rt.call_function('wp_print_update_row_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
