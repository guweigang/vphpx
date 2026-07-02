import rt

fn translations_api(type string, var_args rt.PhpVal) rt.PhpVal {
	mut var_type := type
	mut var_res := rt.new_null()
	mut var_url := rt.new_null()
	mut var_http_url := rt.new_null()
	mut var_ssl := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	mut var_request := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(type),
		rt.create_array([rt.ArrayItem{ key: none, val: 'plugins' },
			rt.ArrayItem{ key: none, val: 'themes' }, rt.ArrayItem{ key: none, val: 'core' }]),
		rt.new_bool(true),
	])))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_type'), rt.call_function('__', [
			rt.new_string('Invalid translation type.'),
		])))
	}
	var_res = rt.call_function('apply_filters', [rt.new_string('translations_api'),
		rt.new_bool(false), rt.new_string(type), rt.create_array_from_native_map(var_args)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_res)) {
		var_url = rt.new_string('http://api.wordpress.org/translations/' + type + '/1.0/')
		var_http_url = var_url.clone()
		var_ssl = rt.call_function('wp_http_supports', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
		])
		if rt.is_true(var_ssl) {
			var_url = rt.call_function('set_url_scheme', [var_url.clone(),
				rt.new_string('https')])
		}
		var_options = {
			'timeout': rt.new_int(3)
			'body':    {
				'wp_version': rt.call_function('wp_get_wp_version', []rt.PhpVal{})
				'locale':     rt.call_function('get_locale', []rt.PhpVal{})
				'version':    var_args.array_get(rt.new_string('version'))
			}
		}
		if rt.is_true(rt.new_bool('core' != type)) {
			var_options.array_get_mut('body').array_set('slug',
				var_args.array_get(rt.new_string('slug')))
		}
		var_request = rt.call_function('wp_remote_post', [var_url.clone(),
			rt.create_array_from_native_map(var_options)])
		if rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
			rt.call_function('wp_trigger_error', [rt.new_string(@FN),
				rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() +
					' ' +(rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str()),
				if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))
					|| rt.is_true(rt.get_constant('WP_DEBUG')) {
					rt.get_constant('E_USER_WARNING')
				} else {
					rt.get_constant('E_USER_NOTICE')
				}])
			var_request = rt.call_function('wp_remote_post', [
				var_http_url.clone(), rt.create_array_from_native_map(var_options)])
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_request.clone()])) {
			var_res = create_wp_error(rt.new_string('translations_api_failed'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/support/forums/'),
				]),
			]), rt.call_method(var_request, 'get_error_message', []rt.PhpVal{}))
		} else {
			var_res = rt.call_function('json_decode', [
				rt.call_function('wp_remote_retrieve_body', [
					var_request.clone()]),
				rt.new_bool(true),
			])
			if !(var_res.clone().is_object()) && !(var_res.clone().is_array()) {
				var_res = create_wp_error(rt.new_string('translations_api_failed'), rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
					]),
					rt.call_function('__', [
						rt.new_string('https://wordpress.org/support/forums/'),
					]),
				]), rt.call_function('wp_remote_retrieve_body', [
					var_request.clone()]))
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('translations_api_result'),
		var_res.clone(), rt.new_string(type), rt.create_array_from_native_map(var_args)])
}

fn wp_get_available_translations() rt.PhpVal {
	mut var_translations := rt.new_null()
	mut var_api := rt.new_null()
	mut var_translation := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		var_translations = rt.call_function('get_site_transient', [
			rt.new_string('available_translations'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_translations)))) {
			return var_translations.clone()
		}
	}
	var_api = translations_api('core', rt.create_array([
		rt.ArrayItem{ key: 'version', val: rt.call_function('wp_get_wp_version', []rt.PhpVal{}) },
	]))
	if rt.is_true(rt.call_function('is_wp_error', [var_api.clone()]))
		|| !rt.is_true(var_api.array_get(rt.new_string('translations'))) {
		return rt.new_array()
	}
	var_translations = rt.new_array()
	mut iter_1 := var_api.array_get(rt.new_string('translations')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_translation_shadow := item_1.val
		var_translations.array_set(var_translation_shadow.array_get(rt.new_string('language')),
			var_translation_shadow.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_INSTALLING'),
	])))))
	{
		rt.call_function('set_site_transient', [rt.new_string('available_translations'),
			var_translations.clone(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return var_translations.clone()
}

fn wp_install_language_form(var_languages rt.PhpVal) {
	mut var_wp_local_package := rt.new_null()
	mut var_installed_languages := rt.new_null()
	mut var_language := rt.new_null()
	var_installed_languages = rt.call_function('get_available_languages', []rt.PhpVal{})
	print("<label class='screen-reader-text' for='language'>Select a default language</label>\n")
	print("<select size='14' name='language' id='language'>\n")
	print('<option value="" lang="en" selected="selected" data-continue="Continue" data-installed="1">English (United States)</option>')
	print('\n')
	if !(!rt.is_true(var_wp_local_package)) && var_languages.array_isset(var_wp_local_package) {
		if var_languages.array_isset(var_wp_local_package) {
			var_language = var_languages.array_get(var_wp_local_package)
			rt.call_function('printf', [
				rt.new_string('<option value="%s" lang="%s" data-continue="%s"%s>%s</option>' + '\n'),
				rt.call_function('esc_attr', [var_language.array_get(rt.new_string('language'))]),
				rt.call_function('esc_attr', [
					rt.call_function('current', [var_language.array_get(rt.new_string('iso'))]),
				]),
				rt.call_function('esc_attr', [
					if rt.is_true(var_language.array_get(rt.new_string('strings')).array_get(rt.new_string('continue'))) {
						var_language.array_get(rt.new_string('strings')).array_get(rt.new_string('continue'))
					} else {
						rt.new_string('Continue')
					},
				]),
				rt.new_string((if rt.is_true(rt.call_function('in_array', [
					var_language.array_get(rt.new_string('language')),
					var_installed_languages.clone(),
					rt.new_bool(true),
				]))
				{ ' data-installed="1"' } else { '' }).str()),
				rt.call_function('esc_html', [
					var_language.array_get(rt.new_string('native_name')),
				]),
			])
			var_languages.array_unset(var_wp_local_package)
		}
	}
	mut iter_2 := var_languages.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_language_shadow := item_2.val
		rt.call_function('printf', [
			rt.new_string('<option value="%s" lang="%s" data-continue="%s"%s>%s</option>' + '\n'),
			rt.call_function('esc_attr', [var_language_shadow.array_get(rt.new_string('language'))]),
			rt.call_function('esc_attr', [
				rt.call_function('current', [var_language_shadow.array_get(rt.new_string('iso'))]),
			]),
			rt.call_function('esc_attr', [
				if rt.is_true(var_language_shadow.array_get(rt.new_string('strings')).array_get(rt.new_string('continue'))) {
					var_language_shadow.array_get(rt.new_string('strings')).array_get(rt.new_string('continue'))
				} else {
					rt.new_string('Continue')
				},
			]),
			rt.new_string((if rt.is_true(rt.call_function('in_array', [
				var_language_shadow.array_get(rt.new_string('language')),
				var_installed_languages.clone(),
				rt.new_bool(true),
			]))
			{ ' data-installed="1"' } else { '' }).str()),
			rt.call_function('esc_html', [
				var_language_shadow.array_get(rt.new_string('native_name')),
			]),
		])
	}
	print('</select>\n')
	print('<p class="step"><span class="spinner"></span><input id="language-continue" type="submit" class="button button-primary button-large" value="Continue" /></p>')
}

fn wp_download_language_pack(var_download rt.PhpVal) bool {
	mut var_translations := rt.new_null()
	mut var_translation := rt.new_null()
	mut var_translation_to_load := false
	mut var_skin := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_result := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [var_download.clone(),
		rt.call_function('get_available_languages', []rt.PhpVal{}),
		rt.new_bool(true)]))
	{
		return var_download.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [
		rt.new_string('download_language_pack'),
	])))))
	{
		return false
	}
	var_translations = wp_get_available_translations()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_translations)))) {
		return false
	}
	mut iter_3 := var_translations.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_translation_shadow := item_3.val
		if rt.is_true(rt.identical(var_translation_shadow.array_get(rt.new_string('language')),
			var_download))
		{
			var_translation_to_load = true
			break
		}
	}
	if !var_translation_to_load {
		return false
	}
	var_translation = rt.array_to_object(var_translation)
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	var_skin = create_automatic_upgrader_skin()
	var_upgrader = create_language_pack_upgrader(var_skin)
	rt.set_property(var_translation, 'type', rt.new_string('core'))
	var_result = var_upgrader.upgrade(var_translation.clone(), rt.create_array([
		rt.ArrayItem{ key: 'clear_update_cache', val: false },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		return false
	}
	return (rt.get_property(var_translation, 'language')).to_bool()
}

fn wp_can_install_language_pack() bool {
	mut var_skin := rt.new_null()
	mut var_upgrader := rt.new_null()
	mut var_check := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_file_mod_allowed', [
		rt.new_string('can_install_language_pack'),
	])))))
	{
		return false
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	var_skin = create_automatic_upgrader_skin()
	var_upgrader = create_language_pack_upgrader(var_skin)
	var_upgrader.init()
	var_check = var_upgrader.fs_connect(rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_CONTENT_DIR') },
		rt.ArrayItem{ key: none, val: rt.get_constant('WP_LANG_DIR') },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_check))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_check.clone()])) {
		return false
	}
	return true
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Language_Pack_Upgrader {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automatic_upgrader_skin(_args ...rt.PhpVal) &Class_Automatic_Upgrader_Skin {
	mut obj := &Class_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader(_args ...rt.PhpVal) &Class_Language_Pack_Upgrader {
	mut obj := &Class_Language_Pack_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Language_Pack_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
