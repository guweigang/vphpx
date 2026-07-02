import rt
import crypto.md5

fn wp_initial_constants() {
	mut var_wp_version := rt.new_null()
	mut var_current_limit := rt.new_null()
	mut var_current_limit_int := rt.new_null()
	mut var_wp_limit_int := rt.new_null()
	mut var_blog_id := i64(0)
	mut var_develop_src := rt.new_null()
	rt.call_function('define', [rt.new_string('KB_IN_BYTES'),
		rt.new_int(1024)])
	rt.call_function('define', [rt.new_string('MB_IN_BYTES'),
		rt.mul(rt.new_int(1024), rt.get_constant('KB_IN_BYTES'))])
	rt.call_function('define', [rt.new_string('GB_IN_BYTES'),
		rt.mul(rt.new_int(1024), rt.get_constant('MB_IN_BYTES'))])
	rt.call_function('define', [rt.new_string('TB_IN_BYTES'),
		rt.mul(rt.new_int(1024), rt.get_constant('GB_IN_BYTES'))])
	rt.call_function('define', [rt.new_string('PB_IN_BYTES'),
		rt.mul(rt.new_int(1024), rt.get_constant('TB_IN_BYTES'))])
	rt.call_function('define', [rt.new_string('EB_IN_BYTES'),
		rt.mul(rt.new_int(1024), rt.get_constant('PB_IN_BYTES'))])
	rt.call_function('define', [rt.new_string('ZB_IN_BYTES'),
		rt.mul(rt.new_int(1024), rt.get_constant('EB_IN_BYTES'))])
	rt.call_function('define', [rt.new_string('YB_IN_BYTES'),
		rt.mul(rt.new_int(1024), rt.get_constant('ZB_IN_BYTES'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_START_TIMESTAMP'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_START_TIMESTAMP'),
			rt.call_function('microtime', [rt.new_bool(true)])])
	}
	var_current_limit = rt.call_function('ini_get', [rt.new_string('memory_limit')])
	var_current_limit_int = rt.call_function('wp_convert_hr_to_bytes', [
		var_current_limit.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_MEMORY_LIMIT'),
	])))))
	{
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_is_ini_value_changeable', [
			rt.new_string('memory_limit'),
		])))
		{
			rt.call_function('define', [rt.new_string('WP_MEMORY_LIMIT'),
				var_current_limit.clone()])
		} else if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			rt.call_function('define', [rt.new_string('WP_MEMORY_LIMIT'),
				rt.new_string('64M')])
		} else {
			rt.call_function('define', [rt.new_string('WP_MEMORY_LIMIT'),
				rt.new_string('40M')])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_MAX_MEMORY_LIMIT'),
	])))))
	{
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_is_ini_value_changeable', [
			rt.new_string('memory_limit'),
		])))
		{
			rt.call_function('define', [rt.new_string('WP_MAX_MEMORY_LIMIT'),
				var_current_limit.clone()])
		} else if rt.is_true(rt.identical(-1, var_current_limit_int))
			|| rt.is_true(rt.greater(var_current_limit_int, rt.mul(rt.new_int(256), rt.get_constant('MB_IN_BYTES')))) {
			rt.call_function('define', [rt.new_string('WP_MAX_MEMORY_LIMIT'),
				var_current_limit.clone()])
		} else if rt.is_true(rt.greater(rt.call_function('wp_convert_hr_to_bytes', [
			rt.get_constant('WP_MEMORY_LIMIT'),
		]), rt.mul(rt.new_int(256), rt.get_constant('MB_IN_BYTES'))))
		{
			rt.call_function('define', [rt.new_string('WP_MAX_MEMORY_LIMIT'),
				rt.get_constant('WP_MEMORY_LIMIT')])
		} else {
			rt.call_function('define', [rt.new_string('WP_MAX_MEMORY_LIMIT'),
				rt.new_string('256M')])
		}
	}
	var_wp_limit_int = rt.call_function('wp_convert_hr_to_bytes', [
		rt.get_constant('WP_MEMORY_LIMIT'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(-1, var_current_limit_int))))
		&& rt.is_true(rt.identical(-1, var_wp_limit_int))
		|| rt.is_true(rt.greater(var_wp_limit_int, var_current_limit_int)) {
		rt.call_function('ini_set', [rt.new_string('memory_limit'),
			rt.get_constant('WP_MEMORY_LIMIT')])
	}
	if !(!(rt.new_int(var_blog_id)).is_null()) {
		var_blog_id = 1
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CONTENT_DIR'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_CONTENT_DIR'),
			rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-content')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_DEVELOPMENT_MODE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_DEVELOPMENT_MODE'),
			rt.new_string('')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_DEBUG'),
	])))))
	{
		if rt.is_true(rt.call_function('wp_get_development_mode', []rt.PhpVal{}))
			|| rt.is_true(rt.identical(rt.new_string('development'), rt.call_function('wp_get_environment_type', []rt.PhpVal{}))) {
			rt.call_function('define', [rt.new_string('WP_DEBUG'),
				rt.new_bool(true)])
		} else {
			rt.call_function('define', [rt.new_string('WP_DEBUG'),
				rt.new_bool(false)])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_DEBUG_DISPLAY'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_DEBUG_DISPLAY'),
			rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_DEBUG_LOG'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_DEBUG_LOG'),
			rt.new_bool(false)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CACHE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_CACHE'),
			rt.new_bool(false)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SCRIPT_DEBUG'),
	])))))
	{
		if !(!rt.is_true(var_wp_version)) {
			var_develop_src = rt.call_function('str_contains', [
				var_wp_version.clone(), rt.new_string('-src')])
		} else {
			var_develop_src = rt.new_bool(false)
		}
		rt.call_function('define', [rt.new_string('SCRIPT_DEBUG'),
			var_develop_src.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MEDIA_TRASH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MEDIA_TRASH'),
			rt.new_bool(false)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SHORTINIT'),
	])))))
	{
		rt.call_function('define', [rt.new_string('SHORTINIT'),
			rt.new_bool(false)])
	}
	rt.call_function('define', [rt.new_string('WP_FEATURE_BETTER_PASSWORDS'),
		rt.new_bool(true)])
	rt.call_function('define', [rt.new_string('MINUTE_IN_SECONDS'),
		rt.new_int(60)])
	rt.call_function('define', [rt.new_string('HOUR_IN_SECONDS'),
		rt.mul(rt.new_int(60), rt.get_constant('MINUTE_IN_SECONDS'))])
	rt.call_function('define', [rt.new_string('DAY_IN_SECONDS'),
		rt.mul(rt.new_int(24), rt.get_constant('HOUR_IN_SECONDS'))])
	rt.call_function('define', [rt.new_string('WEEK_IN_SECONDS'),
		rt.mul(rt.new_int(7), rt.get_constant('DAY_IN_SECONDS'))])
	rt.call_function('define', [rt.new_string('MONTH_IN_SECONDS'),
		rt.mul(rt.new_int(30), rt.get_constant('DAY_IN_SECONDS'))])
	rt.call_function('define', [rt.new_string('YEAR_IN_SECONDS'),
		rt.mul(rt.new_int(365), rt.get_constant('DAY_IN_SECONDS'))])
}

fn wp_plugin_directory_constants() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CONTENT_URL'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_CONTENT_URL'),
			rt.new_string((rt.call_function('get_option', [rt.new_string('siteurl')])).str() +
				'/wp-content')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_PLUGIN_DIR'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_PLUGIN_DIR'),
			rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/plugins')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_PLUGIN_URL'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_PLUGIN_URL'),
			rt.new_string((rt.get_constant('WP_CONTENT_URL')).str() + '/plugins')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('PLUGINDIR'),
	])))))
	{
		rt.call_function('define', [rt.new_string('PLUGINDIR'),
			rt.new_string('wp-content/plugins')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WPMU_PLUGIN_DIR'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WPMU_PLUGIN_DIR'),
			rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/mu-plugins')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WPMU_PLUGIN_URL'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WPMU_PLUGIN_URL'),
			rt.new_string((rt.get_constant('WP_CONTENT_URL')).str() + '/mu-plugins')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('MUPLUGINDIR'),
	])))))
	{
		rt.call_function('define', [rt.new_string('MUPLUGINDIR'),
			rt.new_string('wp-content/mu-plugins')])
	}
}

fn wp_cookie_constants() {
	mut var_siteurl := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('COOKIEHASH'),
	])))))
	{
		var_siteurl = rt.call_function('get_site_option', [rt.new_string('siteurl')])
		if rt.is_true(var_siteurl) {
			rt.call_function('define', [rt.new_string('COOKIEHASH'),
				rt.new_string(md5.hexhash(var_siteurl.clone().to_string()))])
		} else {
			rt.call_function('define', [rt.new_string('COOKIEHASH'),
				rt.new_string('')])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('USER_COOKIE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('USER_COOKIE'),
			rt.new_string('wordpressuser_' + (rt.get_constant('COOKIEHASH')).str())])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('PASS_COOKIE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('PASS_COOKIE'),
			rt.new_string('wordpresspass_' + (rt.get_constant('COOKIEHASH')).str())])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('AUTH_COOKIE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('AUTH_COOKIE'),
			rt.new_string('wordpress_' + (rt.get_constant('COOKIEHASH')).str())])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SECURE_AUTH_COOKIE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('SECURE_AUTH_COOKIE'),
			rt.new_string('wordpress_sec_' + (rt.get_constant('COOKIEHASH')).str())])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('LOGGED_IN_COOKIE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('LOGGED_IN_COOKIE'),
			rt.new_string('wordpress_logged_in_' + (rt.get_constant('COOKIEHASH')).str())])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('TEST_COOKIE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('TEST_COOKIE'),
			rt.new_string('wordpress_test_cookie')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('COOKIEPATH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('COOKIEPATH'),
			rt.call_function('preg_replace', [rt.new_string('|https?://[^/]+|i'),
				rt.new_string(''),
				rt.new_string(
					(rt.call_function('get_option', [rt.new_string('home')])).str() + '/')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SITECOOKIEPATH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('SITECOOKIEPATH'),
			rt.call_function('preg_replace', [rt.new_string('|https?://[^/]+|i'),
				rt.new_string(''),
				rt.new_string(
					(rt.call_function('get_option', [rt.new_string('siteurl')])).str() + '/')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ADMIN_COOKIE_PATH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('ADMIN_COOKIE_PATH'),
			rt.new_string((rt.get_constant('SITECOOKIEPATH')).str() + 'wp-admin')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('PLUGINS_COOKIE_PATH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('PLUGINS_COOKIE_PATH'),
			rt.call_function('preg_replace', [rt.new_string('|https?://[^/]+|i'),
				rt.new_string(''), rt.get_constant('WP_PLUGIN_URL')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('COOKIE_DOMAIN'),
	])))))
	{
		rt.call_function('define', [rt.new_string('COOKIE_DOMAIN'),
			rt.new_string('')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('RECOVERY_MODE_COOKIE'),
	])))))
	{
		rt.call_function('define', [rt.new_string('RECOVERY_MODE_COOKIE'),
			rt.new_string('wordpress_rec_' + (rt.get_constant('COOKIEHASH')).str())])
	}
}

fn wp_ssl_constants() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('FORCE_SSL_ADMIN'),
	])))))
	{
		if rt.is_true(rt.identical(rt.new_string('https'), rt.call_function('parse_url', [
			rt.call_function('get_option', [rt.new_string('siteurl')]),
			rt.get_constant('PHP_URL_SCHEME'),
		])))
		{
			rt.call_function('define', [rt.new_string('FORCE_SSL_ADMIN'),
				rt.new_bool(true)])
		} else {
			rt.call_function('define', [rt.new_string('FORCE_SSL_ADMIN'),
				rt.new_bool(false)])
		}
	}
	rt.call_function('force_ssl_admin', [rt.get_constant('FORCE_SSL_ADMIN')])
	if rt.is_true(rt.call_function('defined', [rt.new_string('FORCE_SSL_LOGIN')]))
		&& rt.is_true(rt.get_constant('FORCE_SSL_LOGIN')) {
		rt.call_function('force_ssl_admin', [rt.new_bool(true)])
	}
}

fn wp_functionality_constants() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('AUTOSAVE_INTERVAL'),
	])))))
	{
		rt.call_function('define', [rt.new_string('AUTOSAVE_INTERVAL'),
			rt.get_constant('MINUTE_IN_SECONDS')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('EMPTY_TRASH_DAYS'),
	])))))
	{
		rt.call_function('define', [rt.new_string('EMPTY_TRASH_DAYS'),
			rt.new_int(30)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_POST_REVISIONS'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_POST_REVISIONS'),
			rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CRON_LOCK_TIMEOUT'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_CRON_LOCK_TIMEOUT'),
			rt.get_constant('MINUTE_IN_SECONDS')])
	}
}

fn wp_templating_constants() {
	rt.call_function('define', [rt.new_string('TEMPLATEPATH'),
		rt.call_function('get_template_directory', []rt.PhpVal{})])
	rt.call_function('define', [rt.new_string('STYLESHEETPATH'),
		rt.call_function('get_stylesheet_directory', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_DEFAULT_THEME'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_DEFAULT_THEME'),
			rt.new_string('twentytwentyfive')])
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
