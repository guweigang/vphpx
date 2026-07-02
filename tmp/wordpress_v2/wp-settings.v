import rt

const global_const_wpinc = 'wp-includes'

struct Class_WP_Hook {
	rt.PhpObjectBase
}

struct Class_WP_Embed {
	rt.PhpObjectBase
}

struct Class_WP_Textdomain_Registry {
	rt.PhpObjectBase
}

struct Class_WP_AI_Client_Discovery_Strategy {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_AiClient {
	rt.PhpObjectBase
}

struct Class_WP_AI_Client_Cache {
	rt.PhpObjectBase
}

struct Class_WP_AI_Client_Event_Dispatcher {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Rewrite {
	rt.PhpObjectBase
}

struct Class_WP {
	rt.PhpObjectBase
}

struct Class_WP_Widget_Factory {
	rt.PhpObjectBase
}

struct Class_WP_Roles {
	rt.PhpObjectBase
}

struct Class_WP_Locale {
	rt.PhpObjectBase
}

struct Class_WP_Locale_Switcher {
	rt.PhpObjectBase
}

struct Class_WP_Site_Health {
	rt.PhpObjectBase
}

fn create_wp_hook(_args ...rt.PhpVal) &Class_WP_Hook {
	mut obj := &Class_WP_Hook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_embed(_args ...rt.PhpVal) &Class_WP_Embed {
	mut obj := &Class_WP_Embed{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_textdomain_registry(_args ...rt.PhpVal) &Class_WP_Textdomain_Registry {
	mut obj := &Class_WP_Textdomain_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ai_client_discovery_strategy(_args ...rt.PhpVal) &Class_WP_AI_Client_Discovery_Strategy {
	mut obj := &Class_WP_AI_Client_Discovery_Strategy{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_aiclient(_args ...rt.PhpVal) &Class_WordPress_AiClient_AiClient {
	mut obj := &Class_WordPress_AiClient_AiClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ai_client_cache(_args ...rt.PhpVal) &Class_WP_AI_Client_Cache {
	mut obj := &Class_WP_AI_Client_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_ai_client_event_dispatcher(_args ...rt.PhpVal) &Class_WP_AI_Client_Event_Dispatcher {
	mut obj := &Class_WP_AI_Client_Event_Dispatcher{
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

fn create_wp_rewrite(_args ...rt.PhpVal) &Class_WP_Rewrite {
	mut obj := &Class_WP_Rewrite{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp(_args ...rt.PhpVal) &Class_WP {
	mut obj := &Class_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_widget_factory(_args ...rt.PhpVal) &Class_WP_Widget_Factory {
	mut obj := &Class_WP_Widget_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_roles(_args ...rt.PhpVal) &Class_WP_Roles {
	mut obj := &Class_WP_Roles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_locale(_args ...rt.PhpVal) &Class_WP_Locale {
	mut obj := &Class_WP_Locale{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_locale_switcher(_args ...rt.PhpVal) &Class_WP_Locale_Switcher {
	mut obj := &Class_WP_Locale_Switcher{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_health(_args ...rt.PhpVal) &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
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

fn (mut this Class_WP_Embed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Embed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Embed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Textdomain_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Textdomain_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Textdomain_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_AI_Client_Discovery_Strategy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_AI_Client_Discovery_Strategy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Discovery_Strategy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_AiClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_AiClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_AiClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_AI_Client_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_AI_Client_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_AI_Client_Event_Dispatcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_AI_Client_Event_Dispatcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_AI_Client_Event_Dispatcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Rewrite) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Rewrite) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Rewrite) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Widget_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Roles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Roles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Roles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Locale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Locale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Locale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Locale_Switcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Locale_Switcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Locale_Switcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/version.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/compat-utf8.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/compat.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/load.php', '3')
	rt.call_function('wp_check_php_mysql_versions', []rt.PhpVal{})
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-paused-extensions-storage.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-exception.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-fatal-error-handler.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-cookie-service.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-key-service.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-link-service.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode-email-service.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-recovery-mode.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/error-protection.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/default-constants.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/plugin.php', '4')
	rt.call_function('wp_initial_constants', []rt.PhpVal{})
	rt.call_function('wp_register_fatal_error_handler', []rt.PhpVal{})
	rt.call_function('date_default_timezone_set', [rt.new_string('UTC')])
	rt.call_function('wp_fix_server_vars', []rt.PhpVal{})
	rt.call_function('wp_maintenance', []rt.PhpVal{})
	rt.call_function('timer_start', []rt.PhpVal{})
	rt.call_function('wp_debug_mode', []rt.PhpVal{})
	if rt.is_true(rt.get_constant('WP_CACHE'))
		&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_loading_advanced_cache_dropin'), rt.new_bool(true)]))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/advanced-cache.php')])) {
		rt.include_file((rt.get_constant('WP_CONTENT_DIR')).str() + '/advanced-cache.php', '1')
		if rt.is_true(var_wp_filter) {
			mut iife_temp_0 := Class_WP_Hook{}
			mut iife_result_0 := iife_temp_0.build_preinitialized_hooks(var_wp_filter.clone())
			mut var_wp_filter := iife_result_0
		}
	}
	rt.call_function('wp_set_lang_dir', []rt.PhpVal{})
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-list-util.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-token-map.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/utf8.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/formatting.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/meta.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/functions.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-meta-query.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-matchesmapregex.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-error.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/pomo/mo.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translations.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-file.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-file-mo.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n/class-wp-translation-file-php.php',
		'3')
	rt.call_function('require_wp_db', []rt.PhpVal{})
	if !(var_GLOBALS.array_isset(rt.new_string('table_prefix'))) {
		var_GLOBALS.array_set('table_prefix', var_table_prefix.clone())
	}
	rt.call_function('wp_set_wpdb_vars', []rt.PhpVal{})
	rt.call_function('wp_start_object_cache', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/default-filters.php',
		'3')
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-site-query.php',
			'3')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-network-query.php',
			'3')
		rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ms-blogs.php',
			'3')
		rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ms-settings.php',
			'3')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MULTISITE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MULTISITE'),
			rt.new_bool(false)])
	}
	rt.call_function('register_shutdown_function', [
		rt.new_string('shutdown_action_hook'),
	])
	if rt.is_true(rt.get_constant('SHORTINIT')) {
		return rt.new_bool(false)
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/l10n.php', '4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-textdomain-registry.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-locale.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-locale-switcher.php',
		'4')
	rt.call_function('wp_not_installed', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-walker.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-ajax-response.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/capabilities.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-roles.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-role.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-query.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/query.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-date-query.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/theme.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json-schema.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json-data.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json-resolver.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-duotone.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/global-styles-and-settings.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-template.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-templates-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-template-utils.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-template.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/theme-templates.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/theme-previews.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/https-detection.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/https-migration.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user-request.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/user.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user-query.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-session-tokens.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-user-meta-session-tokens.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/general-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/link-template.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/author-template.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/robots-template.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/post.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-walker-page.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-walker-page-dropdown.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-post-type.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-post.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/post-template.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/revision.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/post-formats.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/post-thumbnail-template.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/category.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-walker-category.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-walker-category-dropdown.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/category-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/comment.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-comment.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-comment-query.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-walker-comment.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/comment-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rewrite.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-rewrite.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/feed.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/bookmark.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/bookmark-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/kses.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/cron.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/deprecated.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/script-loader.php',
		'3')
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/build/routes.php'),
	]))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/build/routes.php', '3')
	}
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/build/pages.php'),
	]))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/build/pages.php',
			'3')
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/taxonomy.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-taxonomy.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-term.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-term-query.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-tax-query.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/update.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/canonical.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/shortcodes.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/embed.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-embed.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-oembed.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-oembed-controller.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/media.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/http.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/html5-named-character-references.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-attribute-token.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-span.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-doctype-info.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-text-replacement.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-decoder.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-tag-processor.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-unsupported-exception.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-active-formatting-elements.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-open-elements.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-token.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-stack-event.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-processor-state.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/html-api/class-wp-html-processor.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-processor.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-streams.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-curl.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-proxy.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-cookie.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-encoding.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-response.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-requests-response.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-http-requests-hooks.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/php-ai-client/autoload.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ai-client/adapters/class-wp-ai-client-http-client.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ai-client/adapters/class-wp-ai-client-cache.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ai-client/adapters/class-wp-ai-client-discovery-strategy.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ai-client/adapters/class-wp-ai-client-event-dispatcher.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ai-client/class-wp-ai-client-ability-function-resolver.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ai-client/class-wp-ai-client-prompt-builder.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ai-client.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-connector-registry.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/connectors.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-icons-registry.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/widgets.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-widget.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-widget-factory.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/nav-menu-template.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/nav-menu.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/admin-bar.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-application-passwords.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/abilities-api/class-wp-ability-category.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/abilities-api/class-wp-ability-categories-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/abilities-api/class-wp-ability.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/abilities-api/class-wp-abilities-registry.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/abilities-api.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/abilities.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/class-wp-rest-server.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/class-wp-rest-response.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/class-wp-rest-request.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-posts-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-attachments-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-global-styles-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-post-types-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-post-statuses-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-revisions-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-global-styles-revisions-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-template-revisions-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-autosaves-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-template-autosaves-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-taxonomies-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-terms-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-menu-items-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-menus-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-menu-locations-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-users-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-comments-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-search-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-blocks-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-block-types-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-block-renderer-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-settings-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-themes-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-plugins-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-block-directory-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-edit-site-export-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-pattern-directory-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-block-patterns-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-block-pattern-categories-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-application-passwords-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-site-health-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-sidebars-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-widget-types-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-widgets-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-templates-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-url-details-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-navigation-fallback-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-font-families-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-font-faces-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-font-collections-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-icons-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-abilities-v1-categories-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-abilities-v1-list-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/endpoints/class-wp-rest-abilities-v1-run-controller.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/fields/class-wp-rest-meta-fields.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/fields/class-wp-rest-comment-meta-fields.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/fields/class-wp-rest-post-meta-fields.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/fields/class-wp-rest-term-meta-fields.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/fields/class-wp-rest-user-meta-fields.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/search/class-wp-rest-search-handler.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/search/class-wp-rest-post-search-handler.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/search/class-wp-rest-term-search-handler.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/rest-api/search/class-wp-rest-post-format-search-handler.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/class-wp-sitemaps.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/class-wp-sitemaps-index.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/class-wp-sitemaps-provider.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/class-wp-sitemaps-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/class-wp-sitemaps-renderer.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/class-wp-sitemaps-stylesheet.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/providers/class-wp-sitemaps-posts.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/providers/class-wp-sitemaps-taxonomies.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/sitemaps/providers/class-wp-sitemaps-users.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-bindings-source.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-bindings-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-editor-context.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-type.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-pattern-categories-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-patterns-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-styles-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-type-registry.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-list.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-metadata-registry.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-parser-block.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-parser-frame.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-parser.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-classic-to-block-menu-converter.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-navigation-fallback.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-bindings.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-bindings/pattern-overrides.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-bindings/post-data.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-bindings/post-meta.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-bindings/term-data.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/blocks.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/blocks/index.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-editor.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-patterns.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-block-supports.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/utils.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/align.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/auto-register.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/custom-classname.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/generated-classname.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/settings.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/elements.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/colors.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/typography.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/border.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/layout.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/position.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/spacing.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/dimensions.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/duotone.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/shadow.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/background.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/block-style-variations.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/aria-label.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/anchor.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/block-visibility.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/block-supports/custom-css.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/style-engine.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/style-engine/class-wp-style-engine.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/style-engine/class-wp-style-engine-css-declarations.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/style-engine/class-wp-style-engine-css-rule.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/style-engine/class-wp-style-engine-css-rules-store.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/style-engine/class-wp-style-engine-processor.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/fonts/class-wp-font-face-resolver.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/fonts/class-wp-font-collection.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/fonts/class-wp-font-face.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/fonts/class-wp-font-library.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/fonts/class-wp-font-utils.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/fonts.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-script-modules.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/script-modules.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/interactivity-api/class-wp-interactivity-api.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/interactivity-api/class-wp-interactivity-api-directives-processor.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/interactivity-api/interactivity-api.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-plugin-dependencies.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-url-pattern-prefixer.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-speculation-rules.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/speculative-loading.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/view-transitions.php', '3')
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('wp_script_modules', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: 'add_hooks' },
		])])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('wp_interactivity', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: 'add_hooks' },
		])])
	var_GLOBALS.array_set('wp_embed', create_wp_embed())
	var_GLOBALS.array_set('wp_textdomain_registry', create_wp_textdomain_registry())
	rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_textdomain_registry')), 'init',
		[]rt.PhpVal{})
	mut iife_temp_1 := Class_WP_AI_Client_Discovery_Strategy{}
	mut iife_result_1 := iife_temp_1.init()
	mut iife_temp_2 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_2 := iife_temp_2.setcache(create_wp_ai_client_cache())
	mut iife_temp_3 := Class_WordPress_AiClient_AiClient{}
	mut iife_result_3 := iife_temp_3.seteventdispatcher(create_wp_ai_client_event_dispatcher())
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ms-functions.php', '3')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ms-default-filters.php',
			'3')
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/ms-deprecated.php', '3')
	}
	rt.call_function('wp_plugin_directory_constants', []rt.PhpVal{})
	var_GLOBALS.array_set('wp_plugin_paths', rt.new_array())
	mut iter_1 := rt.call_function('wp_get_mu_plugins', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_mu_plugin := item_1.val
		mut var__wp_plugin_file := var_mu_plugin.clone()
		rt.include_file(var_mu_plugin.to_string(), '2')
		var_mu_plugin = var__wp_plugin_file.clone()
		rt.call_function('do_action', [rt.new_string('mu_plugin_loaded'),
			var_mu_plugin.clone()])
	}
	var_mu_plugin = rt.new_null()
	var__wp_plugin_file = rt.new_null()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut iter_2 := rt.call_function('wp_get_active_network_plugins', []rt.PhpVal{}).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_network_plugin := item_2.val
			rt.call_function('wp_register_plugin_realpath', [
				var_network_plugin.clone()])
			mut var__wp_plugin_file := var_network_plugin.clone()
			rt.include_file(var_network_plugin.to_string(), '2')
			var_network_plugin = var__wp_plugin_file.clone()
			rt.call_function('do_action', [rt.new_string('network_plugin_loaded'),
				var_network_plugin.clone()])
		}
		var_network_plugin = rt.new_null()
		var__wp_plugin_file = rt.new_null()
	}
	rt.call_function('do_action', [rt.new_string('muplugins_loaded')])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		rt.call_function('ms_cookie_constants', []rt.PhpVal{})
	}
	rt.call_function('wp_cookie_constants', []rt.PhpVal{})
	rt.call_function('wp_ssl_constants', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/vars.php', '3')
	rt.call_function('create_initial_taxonomies', []rt.PhpVal{})
	rt.call_function('create_initial_post_types', []rt.PhpVal{})
	rt.call_function('wp_start_scraping_edited_file_errors', []rt.PhpVal{})
	rt.call_function('register_theme_directory', [
		rt.call_function('get_theme_root', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('wp_is_fatal_error_handler_enabled', []rt.PhpVal{})) {
		rt.call_method(rt.call_function('wp_recovery_mode', []rt.PhpVal{}), 'initialize',
			[]rt.PhpVal{})
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut iter_3 := rt.call_function('wp_get_active_and_valid_plugins', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin := item_3.val
		rt.call_function('wp_register_plugin_realpath', [var_plugin.clone()])
		mut var_plugin_data := rt.call_function('get_plugin_data', [
			var_plugin.clone(), rt.new_bool(false), rt.new_bool(false)])
		mut var_textdomain := var_plugin_data.array_get(rt.new_string('TextDomain'))
		if rt.is_true(var_textdomain) {
			if rt.is_true(var_plugin_data.array_get(rt.new_string('DomainPath'))) {
				rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_textdomain_registry')),
					'set_custom_path', [var_textdomain.clone(),
					rt.new_string((rt.call_function('dirname', [var_plugin.clone()])).str() +
						(var_plugin_data.array_get(rt.new_string('DomainPath'))).str())])
			} else {
				rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_textdomain_registry')),
					'set_custom_path', [var_textdomain.clone(),
					rt.call_function('dirname', [var_plugin.clone()])])
			}
		}
		mut var__wp_plugin_file := var_plugin.clone()
		rt.include_file(var_plugin.to_string(), '2')
		var_plugin = var__wp_plugin_file.clone()
		rt.call_function('do_action', [rt.new_string('plugin_loaded'),
			var_plugin.clone()])
	}
	var_plugin = rt.new_null()
	var__wp_plugin_file = rt.new_null()
	var_plugin_data = rt.new_null()
	var_textdomain = rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/pluggable.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/pluggable-deprecated.php', '3')
	rt.call_function('wp_set_internal_encoding', []rt.PhpVal{})
	if rt.is_true(rt.get_constant('WP_CACHE'))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_postload')])) {
		rt.call_function('wp_cache_postload', []rt.PhpVal{})
	}
	rt.call_function('do_action', [rt.new_string('plugins_loaded')])
	rt.call_function('wp_functionality_constants', []rt.PhpVal{})
	rt.call_function('wp_magic_quotes', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('sanitize_comment_cookies')])
	var_GLOBALS.array_set('wp_the_query', create_wp_query())
	var_GLOBALS.array_set('wp_query', var_GLOBALS.array_get(rt.new_string('wp_the_query')))
	var_GLOBALS.array_set('wp_rewrite', create_wp_rewrite())
	var_GLOBALS.array_set('wp', create_wp())
	var_GLOBALS.array_set('wp_widget_factory', create_wp_widget_factory())
	var_GLOBALS.array_set('wp_roles', create_wp_roles())
	rt.call_function('do_action', [rt.new_string('setup_theme')])
	rt.call_function('wp_templating_constants', []rt.PhpVal{})
	rt.call_function('wp_set_template_globals', []rt.PhpVal{})
	rt.call_function('load_default_textdomain', []rt.PhpVal{})
	mut var_locale := rt.call_function('get_locale', []rt.PhpVal{})
	mut var_locale_file := rt.new_string(
		(rt.get_constant('WP_LANG_DIR')).str() + '/${var_locale.to_string()}.php')
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_locale.clone()])))
		&& rt.is_true(rt.call_function('is_readable', [var_locale_file.clone()])) {
		rt.include_file(var_locale_file.to_string(), '3')
	}
	var_locale_file = rt.new_null()
	var_GLOBALS.array_set('wp_locale', create_wp_locale())
	var_GLOBALS.array_set('wp_locale_switcher', create_wp_locale_switcher())
	rt.call_method(var_GLOBALS.array_get(rt.new_string('wp_locale_switcher')), 'init',
		[]rt.PhpVal{})
	mut iter_4 := rt.call_function('wp_get_active_and_valid_themes', []rt.PhpVal{}).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_theme := item_4.val
		mut var_wp_theme := rt.call_function('wp_get_theme', [
			rt.call_function('basename', [var_theme.clone()]),
		])
		rt.call_method(var_wp_theme, 'load_textdomain', []rt.PhpVal{})
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string(var_theme.str() + '/functions.php'),
		]))
		{
			rt.include_file(var_theme.str() + '/functions.php', '1')
		}
	}
	var_theme = rt.new_null()
	var_wp_theme = rt.new_null()
	rt.call_function('do_action', [rt.new_string('after_setup_theme')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Site_Health'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health.php', '4')
	}
	mut iife_temp_4 := Class_WP_Site_Health{}
	mut iife_result_4 := iife_temp_4.get_instance()
	rt.call_method(var_GLOBALS.array_get(rt.new_string('wp')), 'init', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('init')])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_file := rt.call_function('ms_site_check', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), var_file)))) {
			rt.include_file(var_file.to_string(), '3')
			exit(0)
		}
		var_file = rt.new_null()
	}
	rt.call_function('do_action', [rt.new_string('wp_loaded')])
}
