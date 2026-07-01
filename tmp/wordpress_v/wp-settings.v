import rt

const global_const_wpinc = 'wp-includes'
struct Class_WP_Hook {
	rt.PhpObjectBase
}

fn create_wp_hook() &Class_WP_Hook {
	mut obj := &Class_WP_Hook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Hook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Hook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Hook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_version := rt.new_null()
	mut var_wp_db_version := rt.new_null()
	mut var_tinymce_version := rt.new_null()
	mut var_required_php_version := rt.new_null()
	mut var_required_php_extensions := rt.new_null()
	mut var_required_mysql_version := rt.new_null()
	mut var_wp_local_package := rt.new_null()
	mut var_blog_id := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var_table_prefix := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/version.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/compat-utf8.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/compat.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/load.php', '3')
	rt.call_function('wp_check_php_mysql_versions', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-paused-extensions-storage.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-exception.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-fatal-error-handler.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-cookie-service.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-key-service.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-link-service.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-email-service.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/error-protection.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/default-constants.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/plugin.php', '4')
	// unsupported statement: Stmt_Global
	rt.call_function('wp_initial_constants', []rt.PhpVal{})
	rt.call_function('wp_register_fatal_error_handler', []rt.PhpVal{})
	rt.call_function('date_default_timezone_set', [rt.new_string('UTC')])
	rt.call_function('wp_fix_server_vars', []rt.PhpVal{})
	rt.call_function('wp_maintenance', []rt.PhpVal{})
	rt.call_function('timer_start', []rt.PhpVal{})
	rt.call_function('wp_debug_mode', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.get_constant('WP_CACHE')) && rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_loading_advanced_cache_dropin'), rt.new_bool(true)])))) && rt.is_true(rt.call_function('file_exists', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/advanced-cache.php'])))) {
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/advanced-cache.php', '1')
		if rt.is_true(var_wp_filter) {
			mut var_wp_filter := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Hook{}; return temp.build_preinitialized_hooks(arg_0) }(var_wp_filter.dup())
		}
	}
	rt.call_function('wp_set_lang_dir', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-list-util.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-token-map.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/utf8.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/formatting.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/meta.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/functions.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-meta-query.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-matchesmapregex.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-error.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/pomo/mo.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-controller.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translations.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-file.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-file-mo.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-file-php.php', '3')
	// unsupported statement: Stmt_Global
	rt.call_function('require_wp_db', []rt.PhpVal{})
	if !(var_GLOBALS.array_isset(rt.new_string('table_prefix'))) {
		var_GLOBALS.array_set('table_prefix', var_table_prefix.dup())
	}
	rt.call_function('wp_set_wpdb_vars', []rt.PhpVal{})
	rt.call_function('wp_start_object_cache', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/default-filters.php', '3')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-site-query.php', '3')
		rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-network-query.php', '3')
		rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ms-blogs.php', '3')
		rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ms-settings.php', '3')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('MULTISITE')]))))) {
		rt.call_function('define', [rt.new_string('MULTISITE'), rt.new_bool(false)])
	}
	rt.call_function('register_shutdown_function', [rt.new_string('shutdown_action_hook')])
	if rt.is_true(rt.get_constant('SHORTINIT')) {
		return rt.new_bool(false)
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-textdomain-registry.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-locale.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-locale-switcher.php', '4')
	rt.call_function('wp_not_installed', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-walker.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-ajax-response.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/capabilities.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-roles.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-role.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-query.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/query.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-date-query.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/theme.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json-schema.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json-data.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json-resolver.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-duotone.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/global-styles-and-settings.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-templates-registry.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-template-utils.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/theme-templates.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/theme-previews.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/https-detection.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/https-migration.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user-request.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/user.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user-query.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-session-tokens.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user-meta-session-tokens.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/general-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/link-template.php', '3')
	rt.include_file(().str() +  + '/author-template.php', '3')
	rt.include_file( + , '3')
	rt.include_file(, '3')
	
}
