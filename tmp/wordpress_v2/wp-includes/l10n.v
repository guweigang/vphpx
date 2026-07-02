import rt
import crypto.md5

fn get_locale() rt.PhpVal {
	mut var_wp_local_package := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_ms_locale := rt.new_null()
	mut var_db_locale := rt.new_null()
	if !var_locale.is_null() {
		return rt.call_function('apply_filters', [rt.new_string('locale'),
			var_locale.clone()])
	}
	if !var_wp_local_package.is_null() {
		var_locale = var_wp_local_package
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPLANG')])) {
		var_locale = rt.get_constant('WPLANG')
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
			var_ms_locale = rt.call_function('get_site_option', [
				rt.new_string('WPLANG')])
		} else {
			var_ms_locale = rt.call_function('get_option', [rt.new_string('WPLANG')])
			if rt.is_true(rt.identical(rt.new_bool(false), var_ms_locale)) {
				var_ms_locale = rt.call_function('get_site_option', [
					rt.new_string('WPLANG'),
				])
			}
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_ms_locale)))) {
			var_locale = var_ms_locale.clone()
		}
	} else {
		var_db_locale = rt.call_function('get_option', [rt.new_string('WPLANG')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_db_locale)))) {
			var_locale = var_db_locale.clone()
		}
	}
	if !rt.is_true(var_locale) {
		var_locale = rt.new_string('en_US')
	}
	return rt.call_function('apply_filters', [rt.new_string('locale'),
		var_locale.clone()])
}

fn get_user_locale(user i64) rt.PhpVal {
	mut var_user := user
	mut var_user_object := rt.new_null()
	mut var_locale := rt.new_null()
	var_user_object = rt.new_bool(false)
	if 0 == user
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_get_current_user')])) {
		var_user_object = rt.call_function('wp_get_current_user', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(user), 'WP_User'))) {
		var_user_object = rt.new_int(user)
	} else if var_user != 0 && rt.new_int(user).is_long() || rt.new_int(user).is_double() {
		var_user_object = rt.call_function('get_user_by', [rt.new_string('id'),
			rt.new_int(user)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_object)))) {
		return get_locale()
	}
	var_locale = rt.get_property(var_user_object, 'locale')
	return if rt.is_true(var_locale) { var_locale } else { get_locale() }
}

fn determine_locale() rt.PhpVal {
	mut var_GLOBALS := rt.new_null()
	mut var_determined_locale := rt.new_null()
	var_determined_locale = rt.call_function('apply_filters', [
		rt.new_string('pre_determine_locale'),
		rt.new_null(),
	])
	if rt.is_true(var_determined_locale) && var_determined_locale.clone().is_string() {
		return var_determined_locale.clone()
	}
	if var_GLOBALS.array_isset(rt.new_string('pagenow'))
		&& rt.is_true(rt.identical(rt.new_string('wp-login.php'), var_GLOBALS.array_get(rt.new_string('pagenow'))))
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wp_lang'))))
		|| !(!rt.is_true(rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp_lang')))) {
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('wp_lang')))) {
			var_determined_locale = rt.call_function('sanitize_locale_name', [
				rt.get_superglobal('_GET').array_get(rt.new_string('wp_lang')),
			])
		} else {
			var_determined_locale = rt.call_function('sanitize_locale_name', [
				rt.get_superglobal('_COOKIE').array_get(rt.new_string('wp_lang')),
			])
		}
	} else if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| (rt.get_superglobal('_GET').array_isset(rt.new_string('_locale'))
		&& rt.is_true(rt.identical(rt.new_string('user'), rt.get_superglobal('_GET').array_get(rt.new_string('_locale'))))
		&& rt.is_true(rt.call_function('wp_is_json_request', []rt.PhpVal{}))) {
		var_determined_locale = get_user_locale(0)
	} else if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('language'))))
		|| var_GLOBALS.array_isset(rt.new_string('wp_local_package'))
		&& rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('language')))) {
			var_determined_locale = rt.call_function('sanitize_locale_name', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('language')),
			])
		} else {
			var_determined_locale = var_GLOBALS.array_get(rt.new_string('wp_local_package'))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_determined_locale)))) {
		var_determined_locale = get_locale()
	}
	return rt.call_function('apply_filters', [rt.new_string('determine_locale'),
		var_determined_locale.clone()])
}

fn translate(var_text rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	mut var_translations := rt.new_null()
	mut var_translation := rt.new_null()
	var_translations = get_translations_for_domain(rt.new_string(domain))
	var_translation = rt.call_method(var_translations, 'translate', [
		var_text.clone()])
	var_translation = rt.call_function('apply_filters', [rt.new_string('gettext'),
		var_translation.clone(), var_text.clone(), rt.new_string(domain)])
	var_translation = rt.call_function('apply_filters', [
		rt.new_string('gettext_${var_domain}'),
		var_translation.clone(),
		var_text.clone(),
		rt.new_string(domain),
	])
	return var_translation.clone()
}

fn before_last_bar(var_text rt.PhpVal) rt.PhpVal {
	mut var_last_bar := rt.new_null()
	var_last_bar = rt.call_function('strrpos', [var_text.clone(),
		rt.new_string('|')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_last_bar)) {
		return var_text.clone()
	} else {
		return rt.call_function('substr', [var_text.clone(), rt.new_int(0),
			var_last_bar.clone()])
	}
	return rt.new_null()
}

fn translate_with_gettext_context(var_text rt.PhpVal, var_context rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	mut var_translations := rt.new_null()
	mut var_translation := rt.new_null()
	var_translations = get_translations_for_domain(rt.new_string(domain))
	var_translation = rt.call_method(var_translations, 'translate', [
		var_text.clone(), var_context.clone()])
	var_translation = rt.call_function('apply_filters', [
		rt.new_string('gettext_with_context'),
		var_translation.clone(),
		var_text.clone(),
		var_context.clone(),
		rt.new_string(domain),
	])
	var_translation = rt.call_function('apply_filters', [
		rt.new_string('gettext_with_context_${var_domain}'),
		var_translation.clone(),
		var_text.clone(),
		var_context.clone(),
		rt.new_string(domain),
	])
	return var_translation.clone()
}

fn __(text string, domain string) rt.PhpVal {
	mut var_text := text
	mut var_domain := domain
	return translate(rt.new_string(text), domain)
}

fn esc_attr__(var_text rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	return rt.call_function('esc_attr', [translate(var_text.clone(), domain)])
}

fn esc_html__(var_text rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	return rt.call_function('esc_html', [translate(var_text.clone(), domain)])
}

fn _e(var_text rt.PhpVal, domain string) {
	mut var_domain := domain
	rt.echo_val(translate(var_text.clone(), domain))
}

fn esc_attr_e(var_text rt.PhpVal, domain string) {
	mut var_domain := domain
	rt.echo_val(rt.call_function('esc_attr', [translate(var_text.clone(), domain)]))
}

fn esc_html_e(var_text rt.PhpVal, domain string) {
	mut var_domain := domain
	rt.echo_val(rt.call_function('esc_html', [translate(var_text.clone(), domain)]))
}

fn _x(text string, context string, domain string) rt.PhpVal {
	mut var_text := text
	mut var_context := context
	mut var_domain := domain
	return translate_with_gettext_context(rt.new_string(text), rt.new_string(context), domain)
}

fn _ex(var_text rt.PhpVal, var_context rt.PhpVal, domain string) {
	mut var_domain := domain
	rt.echo_val(_x(var_text.clone(), var_context.clone(), domain))
}

fn esc_attr_x(text string, context string, domain string) rt.PhpVal {
	mut var_text := text
	mut var_context := context
	mut var_domain := domain
	return rt.call_function('esc_attr', [
		translate_with_gettext_context(rt.new_string(text), rt.new_string(context), domain),
	])
}

fn esc_html_x(var_text rt.PhpVal, var_context rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	return rt.call_function('esc_html', [
		translate_with_gettext_context(var_text.clone(), var_context.clone(), domain),
	])
}

fn _n(var_single rt.PhpVal, var_plural rt.PhpVal, var_number rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	mut var_translations := rt.new_null()
	mut var_translation := rt.new_null()
	var_translations = get_translations_for_domain(rt.new_string(domain))
	var_translation = rt.call_method(var_translations, 'translate_plural', [
		var_single.clone(), var_plural.clone(), var_number.clone()])
	var_translation = rt.call_function('apply_filters', [rt.new_string('ngettext'),
		var_translation.clone(), var_single.clone(), var_plural.clone(),
		var_number.clone(), rt.new_string(domain)])
	var_translation = rt.call_function('apply_filters', [
		rt.new_string('ngettext_${var_domain}'),
		var_translation.clone(),
		var_single.clone(),
		var_plural.clone(),
		var_number.clone(),
		rt.new_string(domain),
	])
	return var_translation.clone()
}

fn _nx(var_single rt.PhpVal, var_plural rt.PhpVal, var_number rt.PhpVal, var_context rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	mut var_translations := rt.new_null()
	mut var_translation := rt.new_null()
	var_translations = get_translations_for_domain(rt.new_string(domain))
	var_translation = rt.call_method(var_translations, 'translate_plural', [
		var_single.clone(), var_plural.clone(), var_number.clone(),
		var_context.clone()])
	var_translation = rt.call_function('apply_filters', [
		rt.new_string('ngettext_with_context'),
		var_translation.clone(),
		var_single.clone(),
		var_plural.clone(),
		var_number.clone(),
		var_context.clone(),
		rt.new_string(domain),
	])
	var_translation = rt.call_function('apply_filters', [
		rt.new_string('ngettext_with_context_${var_domain}'),
		var_translation.clone(),
		var_single.clone(),
		var_plural.clone(),
		var_number.clone(),
		var_context.clone(),
		rt.new_string(domain),
	])
	return var_translation.clone()
}

fn _n_noop(var_singular rt.PhpVal, var_plural rt.PhpVal, var_domain rt.PhpVal) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 0, val: var_singular },
		rt.ArrayItem{ key: 1, val: var_plural }, rt.ArrayItem{ key: 'singular', val: var_singular },
		rt.ArrayItem{ key: 'plural', val: var_plural }, rt.ArrayItem{
			key: 'context'
			val: rt.new_null()
		}, rt.ArrayItem{ key: 'domain', val: var_domain }])
}

fn _nx_noop(var_singular rt.PhpVal, var_plural rt.PhpVal, var_context rt.PhpVal, var_domain rt.PhpVal) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 0, val: var_singular },
		rt.ArrayItem{ key: 1, val: var_plural }, rt.ArrayItem{ key: 2, val: var_context },
		rt.ArrayItem{ key: 'singular', val: var_singular }, rt.ArrayItem{
			key: 'plural'
			val: var_plural
		}, rt.ArrayItem{ key: 'context', val: var_context }, rt.ArrayItem{
			key: 'domain'
			val: var_domain
		}])
}

fn translate_nooped_plural(var_nooped_plural rt.PhpVal, var_count rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	if rt.is_true(var_nooped_plural.array_get(rt.new_string('domain'))) {
		var_domain = (var_nooped_plural['domain']).str()
	}
	if rt.is_true(var_nooped_plural.array_get(rt.new_string('context'))) {
		return _nx(var_nooped_plural.array_get(rt.new_string('singular')),
			var_nooped_plural.array_get(rt.new_string('plural')), var_count.clone(),
			var_nooped_plural.array_get(rt.new_string('context')), var_domain)
	} else {
		return _n(var_nooped_plural.array_get(rt.new_string('singular')),
			var_nooped_plural.array_get(rt.new_string('plural')), var_count.clone(), var_domain)
	}
	return rt.new_null()
}

fn load_textdomain(var_domain rt.PhpVal, var_mofile_arg rt.PhpVal, var_locale_arg rt.PhpVal) bool {
	mut var_mofile := var_mofile_arg
	mut var_locale := var_locale_arg
	mut var_l10n := rt.new_null()
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_l10n_unloaded := rt.new_null()
	mut var_loaded := rt.new_null()
	mut var_plugin_override := rt.new_null()
	mut var_i18n_controller := rt.new_null()
	mut var_preferred_format := rt.new_null()
	mut var_translation_files := []rt.PhpVal{}
	mut var_file := rt.new_null()
	mut var_success := rt.new_null()
	var_l10n_unloaded = rt.cast_array(var_l10n_unloaded)
	if !(var_domain.clone().is_string()) {
		return false
	}
	var_loaded = rt.call_function('apply_filters', [rt.new_string('pre_load_textdomain'),
		rt.new_null(), var_domain.clone(), var_mofile.clone(),
		var_locale.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_loaded)))) {
		if rt.is_true(rt.identical(rt.new_bool(true), var_loaded)) {
			var_l10n_unloaded.array_unset(var_domain)
		}
		return var_loaded.to_bool()
	}
	var_plugin_override = rt.call_function('apply_filters', [
		rt.new_string('override_load_textdomain'),
		rt.new_bool(false),
		var_domain.clone(),
		var_mofile.clone(),
		var_locale.clone(),
	])
	if rt.is_true(rt.identical(rt.new_bool(true), var_plugin_override.to_bool())) {
		var_l10n_unloaded.array_unset(var_domain)
		return true
	}
	rt.call_function('do_action', [rt.new_string('load_textdomain'),
		var_domain.clone(), var_mofile.clone()])
	var_mofile = rt.call_function('apply_filters', [
		rt.new_string('load_textdomain_mofile'),
		var_mofile.clone(),
		var_domain.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_locale)))) {
		var_locale = determine_locale()
	}
	mut iife_temp_0 := Class_WP_Translation_Controller{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_i18n_controller = iife_result_0
	rt.call_method(var_i18n_controller, 'set_locale', [var_locale.clone()])
	var_preferred_format = rt.call_function('apply_filters', [
		rt.new_string('translation_file_format'),
		rt.new_string('php'),
		var_domain.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_preferred_format.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'php' },
			rt.ArrayItem{ key: none, val: 'mo' },
		]),
		rt.new_bool(true)])))))
	{
		var_preferred_format = rt.new_string('php')
	}
	var_translation_files = []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('mo'), var_preferred_format)))) {
		var_translation_files << rt.call_function('substr_replace', [
			var_mofile.clone(), rt.new_string('.l10n.${var_preferred_format.to_string()}'),
			rt.new_int(-'.mo'.len)])
	}
	var_translation_files << var_mofile.clone()
	for var_file_shadow in var_translation_files {
		var_file_shadow = rt.new_string((rt.call_function('apply_filters', [
			rt.new_string('load_translation_file'),
			var_file_shadow.clone(),
			var_domain.clone(),
			var_locale.clone(),
		])).str())
		var_success = rt.call_method(var_i18n_controller, 'load_file', [
			var_file_shadow.clone(), var_domain.clone(), var_locale.clone()])
		if rt.is_true(var_success) {
			if var_l10n.array_isset(var_domain)
				&& rt.is_true(rt.new_bool(rt.instance_of(var_l10n.array_get(var_domain), 'MO'))) {
				rt.call_method(var_i18n_controller, 'load_file', [
					rt.call_method(var_l10n.array_get(var_domain), 'get_filename', []rt.PhpVal{}),
					var_domain.clone(),
					var_locale.clone(),
				])
			}
			var_l10n.array_unset(var_domain)
			var_l10n.array_set(var_domain, create_wp_translations(var_i18n_controller.clone(),
				var_domain.clone()))
			rt.call_method(var_wp_textdomain_registry, 'set', [
				var_domain.clone(), var_locale.clone(),
				rt.call_function('dirname', [
					var_file_shadow.clone(),
				])])
			return true
		}
	}
	return false
}

fn unload_textdomain(domain string, reloadable bool) bool {
	mut var_domain := domain
	mut var_reloadable := reloadable
	mut var_l10n := rt.new_null()
	mut var_l10n_unloaded := rt.new_null()
	mut var_plugin_override := rt.new_null()
	var_l10n_unloaded = rt.cast_array(var_l10n_unloaded)
	var_plugin_override = rt.call_function('apply_filters', [
		rt.new_string('override_unload_textdomain'),
		rt.new_bool(false),
		rt.new_string(var_domain.str()),
		rt.new_bool(reloadable),
	])
	if rt.is_true(var_plugin_override) {
		if !var_reloadable {
			var_l10n_unloaded.array_set(var_domain, true)
		}
		return true
	}
	rt.call_function('do_action', [rt.new_string('unload_textdomain'),
		rt.new_string(var_domain.str()), rt.new_bool(reloadable)])
	if !var_reloadable {
		mut iife_temp_1 := Class_WP_Translation_Controller{}
		mut iife_result_1 := iife_temp_1.get_instance()
		rt.call_method(iife_result_1, 'unload_textdomain', [
			rt.new_string(var_domain.str()),
		])
	}
	if var_l10n.array_isset(rt.new_string(var_domain.str())) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_l10n.array_get(rt.new_string(var_domain.str())),
			'NOOP_Translations')))
		{
			var_l10n.array_unset(rt.new_string(var_domain.str()))
			return false
		}
		var_l10n.array_unset(rt.new_string(var_domain.str()))
		if !var_reloadable {
			var_l10n_unloaded.array_set(var_domain, true)
		}
		return true
	}
	return false
}

fn load_default_textdomain(var_locale_arg rt.PhpVal) bool {
	mut var_locale := var_locale_arg
	mut var_return := false
	if rt.is_true(rt.identical(rt.new_null(), var_locale)) {
		var_locale = determine_locale()
	}
	rt.new_bool(unload_textdomain('default', true))
	var_return = load_textdomain('default',

		(rt.get_constant('WP_LANG_DIR')).str() + '/${var_locale.to_string()}.mo',
		var_locale.clone())
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		|| (rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING_NETWORK')]))
		&& rt.is_true(rt.get_constant('WP_INSTALLING_NETWORK')))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/admin-${var_locale.to_string()}.mo')]))))) {
		rt.new_bool(load_textdomain(rt.new_string('default'), rt.new_string(
			(rt.get_constant('WP_LANG_DIR')).str() + '/ms-${var_locale.to_string()}.mo'),
			var_locale.clone()))
		return var_return
	}
	if (rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))
		|| (rt.is_true(rt.call_function('defined', [rt.new_string('WP_REPAIRING')]))
		&& rt.is_true(rt.get_constant('WP_REPAIRING'))))
		|| rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_maybe_auto_update')])) {
		rt.new_bool(load_textdomain(rt.new_string('default'), rt.new_string(
			(rt.get_constant('WP_LANG_DIR')).str() + '/admin-${var_locale.to_string()}.mo'),
			var_locale.clone()))
	}
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))
		|| (rt.is_true(rt.call_function('defined', [rt.new_string('WP_INSTALLING_NETWORK')]))
		&& rt.is_true(rt.get_constant('WP_INSTALLING_NETWORK'))) {
		rt.new_bool(load_textdomain(rt.new_string('default'), rt.new_string(
			(rt.get_constant('WP_LANG_DIR')).str() + '/admin-network-${var_locale.to_string()}.mo'),
			var_locale.clone()))
	}
	return var_return
}

fn load_plugin_textdomain(var_domain rt.PhpVal, deprecated bool, plugin_rel_path bool) bool {
	mut var_deprecated := deprecated
	mut var_plugin_rel_path := plugin_rel_path
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_l10n := rt.new_null()
	mut var_path := rt.new_null()
	if !(var_domain.clone().is_string()) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
		rt.new_bool(plugin_rel_path)))))
	{
		var_path = rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' +
			rt.new_bool(plugin_rel_path).to_string().trim_space())
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
		rt.new_bool(deprecated)))))
	{
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.7.0')])
		var_path = rt.new_string(
			(rt.get_constant('ABSPATH')).str() + rt.new_bool(deprecated).to_string().trim_space())
	} else {
		var_path = rt.get_constant('WP_PLUGIN_DIR')
	}
	rt.call_method(var_wp_textdomain_registry, 'set_custom_path', [
		var_domain.clone(), var_path.clone()])
	if var_l10n.array_isset(var_domain)
		&& rt.is_true(rt.new_bool(rt.instance_of(var_l10n.array_get(var_domain), 'NOOP_Translations'))) {
		var_l10n.array_unset(var_domain)
	}
	return true
}

fn load_muplugin_textdomain(var_domain rt.PhpVal, mu_plugin_rel_path string) bool {
	mut var_mu_plugin_rel_path := mu_plugin_rel_path
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_l10n := rt.new_null()
	mut var_path := rt.new_null()
	if !(var_domain.clone().is_string()) {
		return false
	}
	var_path = rt.new_string(
		(rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/' + mu_plugin_rel_path.trim_left(' \t\n\r'))
	rt.call_method(var_wp_textdomain_registry, 'set_custom_path', [
		var_domain.clone(), var_path.clone()])
	if var_l10n.array_isset(var_domain)
		&& rt.is_true(rt.new_bool(rt.instance_of(var_l10n.array_get(var_domain), 'NOOP_Translations'))) {
		var_l10n.array_unset(var_domain)
	}
	return true
}

fn load_theme_textdomain(var_domain rt.PhpVal, path bool) bool {
	mut var_path := path
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_l10n := rt.new_null()
	if !(var_domain.clone().is_string()) {
		return false
	}
	if !var_path {
		var_path = (rt.call_function('get_template_directory', []rt.PhpVal{})).to_bool()
	}
	rt.call_method(var_wp_textdomain_registry, 'set_custom_path', [
		var_domain.clone(), rt.new_bool(var_path)])
	if var_l10n.array_isset(var_domain)
		&& rt.is_true(rt.new_bool(rt.instance_of(var_l10n.array_get(var_domain), 'NOOP_Translations'))) {
		var_l10n.array_unset(var_domain)
	}
	return true
}

fn load_child_theme_textdomain(var_domain rt.PhpVal, path bool) bool {
	mut var_path := path
	if !var_path {
		var_path = (rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).to_bool()
	}
	return load_theme_textdomain(var_domain.clone(), var_path)
}

fn load_script_textdomain(var_handle rt.PhpVal, domain string, path string) bool {
	mut var_domain := domain
	mut var_path := path
	mut var_wp_scripts := rt.new_null()
	mut var_src := rt.new_null()
	var_wp_scripts = rt.call_function('wp_scripts', []rt.PhpVal{})
	if !(rt.get_property(var_wp_scripts, 'registered').array_isset(var_handle)) {
		return false
	}
	var_src = rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_handle),
		'src')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), var_src.clone()])))))
		&& !(rt.is_true(rt.get_property(var_wp_scripts, 'content_url'))
		&& rt.is_true(rt.call_function('str_starts_with', [var_src.clone(), rt.get_property(var_wp_scripts, 'content_url')]))) {
		var_src = rt.new_string((rt.get_property(var_wp_scripts, 'base_url')).str() + var_src.str())
	}
	return (_load_script_textdomain_from_src(var_handle.clone(), var_src.clone(), var_domain,
		var_path, false)).to_bool()
}

fn load_script_module_textdomain(id string, domain string, path string) bool {
	mut var_id := id
	mut var_domain := domain
	mut var_path := path
	mut var_module := rt.new_null()
	mut var_src := rt.new_null()
	var_module = rt.call_method(rt.call_function('wp_script_modules', []rt.PhpVal{}),
		'get_registered', [rt.new_string(id)])
	if rt.is_true(rt.identical(rt.new_null(), var_module)) {
		return false
	}
	var_src = var_module.array_get(rt.new_string('src'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('|^(https?:)?//|'),
		var_src.clone(),
	])))))
	{
		var_src = rt.call_function('site_url', [var_src.clone()])
	}
	return (_load_script_textdomain_from_src(id, var_src.clone(), var_domain, var_path, true)).to_bool()
}

fn _load_script_textdomain_from_src(handle string, src string, domain string, path string, is_module bool) rt.PhpVal {
	mut var_handle := handle
	mut var_src := src
	mut var_domain := domain
	mut var_path := path
	mut var_is_module := is_module
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_file_base := rt.new_null()
	mut var_handle_filename := rt.new_null()
	mut var_translations := rt.new_null()
	mut var_relative := rt.new_null()
	mut var_languages_path := rt.new_null()
	mut var_src_url := rt.new_null()
	mut var_content_url := rt.new_null()
	mut var_plugins_url := rt.new_null()
	mut var_site_url := rt.new_null()
	mut var_theme_root := rt.new_null()
	mut var_theme_dir := rt.new_null()
	mut var_dirname := ''
	mut var_md5_filename := rt.new_null()
	var_locale = determine_locale()
	if !(var_path.len > 0 && var_path != '0') {
		var_path = (rt.call_method(var_wp_textdomain_registry, 'get', [
			rt.new_string(var_domain.str()),
			var_locale.clone(),
		])).str()
	}
	if var_path.len > 0 && var_path != '0' {
		var_path = (rt.call_function('untrailingslashit', [
			rt.new_string(var_path.str()),
		])).str()
	}
	var_file_base = if rt.is_true(rt.identical(rt.new_string('default'),
		rt.new_string(var_domain.str())))
	{
		var_locale
	} else {
		var_domain + '-' + var_locale.str()
	}
	var_handle_filename = rt.new_string(var_file_base.str() + '-' + handle + '.json')
	if var_path.len > 0 && var_path != '0' {
		var_translations = rt.new_bool(load_script_translations(rt.new_string(var_path + '/' +
			var_handle_filename.str()), rt.new_string(handle), rt.new_string(var_domain.str())))
		if rt.is_true(var_translations) {
			return var_translations.clone()
		}
	}
	var_relative = rt.new_bool(false)
	var_languages_path = rt.get_constant('WP_LANG_DIR')
	var_src_url = rt.call_function('wp_parse_url', [rt.new_string(src)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src_url)))) {
		return rt.new_bool(load_script_translations(false, handle, var_domain))
	}
	rt.new_null()
	var_content_url = rt.call_function('wp_parse_url', [
		rt.call_function('content_url', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_content_url)))) {
		return rt.new_bool(load_script_translations(false, handle, var_domain))
	}
	var_plugins_url = rt.call_function('wp_parse_url', [
		rt.call_function('plugins_url', []rt.PhpVal{}),
	])
	var_site_url = rt.call_function('wp_parse_url', [
		rt.call_function('site_url', []rt.PhpVal{}),
	])
	var_theme_root = rt.call_function('get_theme_root', []rt.PhpVal{})
	if !(var_content_url.array_isset(rt.new_string('path')))
		|| rt.is_true(rt.call_function('str_starts_with', [var_src_url.array_get(rt.new_string('path')), var_content_url.array_get(rt.new_string('path'))]))
		&& !(var_src_url.array_isset(rt.new_string('host')))
		|| !(var_content_url.array_isset(rt.new_string('host')))
		|| rt.is_true(rt.identical(var_src_url.array_get(rt.new_string('host')), var_content_url.array_get(rt.new_string('host')))) {
		if var_content_url.array_isset(rt.new_string('path')) {
			var_relative = rt.call_function('substr', [
				var_src_url.array_get(rt.new_string('path')),
				rt.new_int(var_content_url.array_get(rt.new_string('path')).to_string().len),
			])
		} else {
			var_relative = var_src_url.array_get(rt.new_string('path'))
		}
		var_relative = rt.new_string(var_relative.clone().to_string().trim_space())
		var_relative = rt.call_function('explode', [rt.new_string('/'),
			var_relative.clone()])
		var_theme_dir = rt.call_function('array_slice', [
			rt.call_function('explode', [rt.new_string('/'), var_theme_root.clone()]),
			rt.new_int(-1),
		])
		var_dirname = if rt.is_true(rt.identical(var_theme_dir.array_get(rt.new_int(0)),
			var_relative.array_get(rt.new_int(0))))
		{
			'themes'
		} else {
			'plugins'
		}
		var_languages_path = rt.new_string(
			(rt.get_constant('WP_LANG_DIR')).str() + '/' + var_dirname)
		var_relative = rt.call_function('array_slice', [var_relative.clone(),
			rt.new_int(2)])
		var_relative = rt.call_function('implode', [rt.new_string('/'),
			var_relative.clone()])
	} else if !(var_plugins_url.array_isset(rt.new_string('path')))
		|| rt.is_true(rt.call_function('str_starts_with', [var_src_url.array_get(rt.new_string('path')), var_plugins_url.array_get(rt.new_string('path'))]))
		&& !(var_src_url.array_isset(rt.new_string('host')))
		|| !(var_plugins_url.array_isset(rt.new_string('host')))
		|| rt.is_true(rt.identical(var_src_url.array_get(rt.new_string('host')), var_plugins_url.array_get(rt.new_string('host')))) {
		if var_plugins_url.array_isset(rt.new_string('path')) {
			var_relative = rt.call_function('substr', [
				var_src_url.array_get(rt.new_string('path')),
				rt.new_int(var_plugins_url.array_get(rt.new_string('path')).to_string().len),
			])
		} else {
			var_relative = var_src_url.array_get(rt.new_string('path'))
		}
		var_relative = rt.new_string(var_relative.clone().to_string().trim_space())
		var_relative = rt.call_function('explode', [rt.new_string('/'),
			var_relative.clone()])
		var_languages_path = rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins')
		var_relative = rt.call_function('array_slice', [var_relative.clone(),
			rt.new_int(1)])
		var_relative = rt.call_function('implode', [rt.new_string('/'),
			var_relative.clone()])
	} else if !(var_src_url.array_isset(rt.new_string('host')))
		|| !(var_site_url.array_isset(rt.new_string('host')))
		|| rt.is_true(rt.identical(var_src_url.array_get(rt.new_string('host')), var_site_url.array_get(rt.new_string('host')))) {
		if !(var_site_url.array_isset(rt.new_string('path'))) {
			var_relative =
				rt.new_string(var_src_url.array_get(rt.new_string('path')).to_string().trim_space())
		} else if rt.is_true(rt.call_function('str_starts_with', [
			var_src_url.array_get(rt.new_string('path')),
			rt.call_function('trailingslashit', [var_site_url.array_get(rt.new_string('path'))]),
		]))
		{
			var_relative = rt.call_function('substr', [
				var_src_url.array_get(rt.new_string('path')),
				rt.new_int(var_site_url.array_get(rt.new_string('path')).to_string().len),
			])
			var_relative = rt.new_string(var_relative.clone().to_string().trim_space())
		}
	}
	var_relative = rt.call_function('apply_filters', [
		rt.new_string('load_script_textdomain_relative_path'),
		var_relative.clone(),
		rt.new_string(src),
		rt.new_bool(is_module),
	])
	if !(var_relative.clone().is_string()) {
		return rt.new_bool(load_script_translations(false, handle, var_domain))
	}
	if rt.is_true(rt.call_function('str_ends_with', [var_relative.clone(),
		rt.new_string('.min.js')]))
	{
		var_relative = rt.new_string(
			(rt.call_function('substr', [var_relative.clone(), rt.new_int(0), rt.new_int(-7)])).str() +
			'.js')
	}
	var_md5_filename = rt.new_string(var_file_base.str() + '-' +
		md5.hexhash(var_relative.clone().to_string()) + '.json')
	if var_path.len > 0 && var_path != '0' {
		var_translations = rt.new_bool(load_script_translations(rt.new_string(var_path + '/' +
			var_md5_filename.str()), rt.new_string(handle), rt.new_string(var_domain.str())))
		if rt.is_true(var_translations) {
			return var_translations.clone()
		}
	}
	var_translations = rt.new_bool(load_script_translations(rt.new_string(
		var_languages_path.str() + '/' + var_md5_filename.str()), rt.new_string(handle),
		rt.new_string(var_domain.str())))
	if rt.is_true(var_translations) {
		return var_translations.clone()
	}
	return rt.new_bool(load_script_translations(false, handle, var_domain))
}

fn load_script_translations(var_file_arg rt.PhpVal, var_handle rt.PhpVal, var_domain rt.PhpVal) bool {
	mut var_file := var_file_arg
	mut var_translations := rt.new_null()
	var_translations = rt.call_function('apply_filters', [
		rt.new_string('pre_load_script_translations'),
		rt.new_null(),
		var_file.clone(),
		var_handle.clone(),
		var_domain.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_translations)))) {
		return var_translations.to_bool()
	}
	var_file = rt.call_function('apply_filters', [
		rt.new_string('load_script_translation_file'),
		var_file.clone(),
		var_handle.clone(),
		var_domain.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_file.clone()]))))) {
		return false
	}
	var_translations = rt.call_function('file_get_contents', [
		var_file.clone()])
	return (rt.call_function('apply_filters', [rt.new_string('load_script_translations'),
		var_translations.clone(), var_file.clone(), var_handle.clone(),
		var_domain.clone()])).to_bool()
}

fn _load_textdomain_just_in_time(var_domain rt.PhpVal) bool {
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_l10n_unloaded := rt.new_null()
	mut var_locale := rt.new_null()
	mut var_path := rt.new_null()
	mut var_template_directory := rt.new_null()
	mut var_stylesheet_directory := rt.new_null()
	mut var_mofile := ''
	var_l10n_unloaded = rt.cast_array(var_l10n_unloaded)
	if rt.is_true(rt.identical(rt.new_string('default'), var_domain))
		|| var_l10n_unloaded.array_isset(var_domain) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_textdomain_registry, 'has', [
		var_domain.clone(),
	])))))
	{
		return false
	}
	var_locale = determine_locale()
	var_path = rt.call_method(var_wp_textdomain_registry, 'get', [
		var_domain.clone(), var_locale.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_path)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('after_setup_theme')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('after_setup_theme')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				__('Translation loading for the %1$s domain was triggered too early. This is usually an indicator for some code in the plugin or theme running too early. Translations should be loaded at the %2$s action or later.',
					''),
				rt.new_string('<code>' + var_domain.str() + '</code>'),
				rt.new_string('<code>init</code>'),
			]),
			rt.new_string('6.7.0')])
	}
	var_template_directory = rt.call_function('trailingslashit', [
		rt.call_function('get_template_directory', []rt.PhpVal{}),
	])
	var_stylesheet_directory = rt.call_function('trailingslashit', [
		rt.call_function('get_stylesheet_directory', []rt.PhpVal{}),
	])
	if rt.is_true(rt.call_function('str_starts_with', [var_path.clone(), var_template_directory.clone()]))
		|| rt.is_true(rt.call_function('str_starts_with', [var_path.clone(), var_stylesheet_directory.clone()])) {
		var_mofile = '${var_path.to_string()}${var_locale.to_string()}.mo'
	} else {
		var_mofile = '${var_path.to_string()}${var_domain.to_string()}-${var_locale.to_string()}.mo'
	}
	return load_textdomain(var_domain.clone(), var_mofile, var_locale.clone())
}

fn get_translations_for_domain(var_domain rt.PhpVal) rt.PhpVal {
	mut var_l10n := rt.new_null()
	mut var_noop_translations := rt.new_null()
	if var_l10n.array_isset(var_domain)
		|| (_load_textdomain_just_in_time(var_domain.clone()) && var_l10n.array_isset(var_domain)) {
		return mut rt.cast_object_ptr[Class_NOOP_Translations](var_l10n.array_get(var_domain))
	}
	if rt.is_true(rt.identical(rt.new_null(), var_noop_translations)) {
		var_noop_translations = create_noop_translations()
	}
	var_l10n.array_get(var_domain) = var_noop_translations
	return mut var_noop_translations
}

fn is_textdomain_loaded(var_domain rt.PhpVal) bool {
	mut var_l10n := rt.new_null()
	return var_l10n.array_isset(var_domain)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_l10n.array_get(var_domain), 'NOOP_Translations'))))))
}

fn translate_user_role(var_name rt.PhpVal, domain string) rt.PhpVal {
	mut var_domain := domain
	return translate_with_gettext_context(before_last_bar(var_name.clone()),
		rt.new_string('User role'), var_domain)
}

fn get_available_languages(var_dir rt.PhpVal) rt.PhpVal {
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_languages := []rt.PhpVal{}
	mut var_path := rt.new_null()
	mut var_lang_files := rt.new_null()
	mut var_lang_file := rt.new_null()
	var_languages = []rt.PhpVal{}
	var_path = if !var_dir.is_null() { var_dir } else { rt.get_constant('WP_LANG_DIR') }
	var_lang_files = rt.call_method(var_wp_textdomain_registry, 'get_language_files_from_path', [
		var_path.clone(),
	])
	if rt.is_true(var_lang_files) {
		mut iter_1 := var_lang_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_lang_file_shadow := item_1.val
			var_lang_file_shadow = rt.call_function('basename', [
				var_lang_file_shadow.clone(), rt.new_string('.mo')])
			var_lang_file_shadow = rt.call_function('basename', [
				var_lang_file_shadow.clone(), rt.new_string('.l10n.php')])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_lang_file_shadow.clone(), rt.new_string('continents-cities')])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_lang_file_shadow.clone(), rt.new_string('ms-')])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_lang_file_shadow.clone(), rt.new_string('admin-')]))))) {
				var_languages << var_lang_file_shadow.clone()
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('get_available_languages'),
		rt.call_function('array_unique', [rt.create_array_from_list(var_languages)]),
		var_dir.clone()])
}

fn wp_get_installed_translations(var_type rt.PhpVal) rt.PhpVal {
	mut var_wp_textdomain_registry := rt.new_null()
	mut var_match := rt.new_null()
	mut var_language := map[string]rt.PhpVal{}
	mut var_dir := rt.new_null()
	mut var_files := rt.new_null()
	mut var_language_data := rt.new_null()
	mut var_file := rt.new_null()
	mut var_textdomain := ''
	mut var_pofile := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('themes'), var_type))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugins'), var_type))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core'), var_type)))) {
		return []rt.PhpVal{}
	}
	var_dir = if rt.is_true(rt.identical(rt.new_string('core'), var_type)) {
		rt.get_constant('WP_LANG_DIR')
	} else {
		(rt.get_constant('WP_LANG_DIR')).str() + '/${var_type.to_string()}'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [
		var_dir.clone()])))))
	{
		return []rt.PhpVal{}
	}
	var_files = rt.call_method(var_wp_textdomain_registry, 'get_language_files_from_path', [
		var_dir.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_files)))) {
		return []rt.PhpVal{}
	}
	var_language_data = []rt.PhpVal{}
	mut iter_2 := var_files.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_file_shadow := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/(?:(.+)-)?([a-z]{2,3}(?:_[A-Z]{2})?(?:_[a-z0-9]+)?)\\.(?:mo|l10n\\.php)/'),
			rt.call_function('basename', [var_file_shadow.clone()]),
			var_match.clone(),
		])))))
		{
			continue
		}
		mut list_tmp_1 := var_match
		var_textdomain = list_tmp_1.array_get(1)
		var_language = list_tmp_1.array_get(2)
		if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_textdomain.str()))) {
			var_textdomain = 'default'
		}
		if rt.is_true(rt.call_function('str_ends_with', [var_file_shadow.clone(),
			rt.new_string('.mo')]))
		{
			var_pofile = rt.call_function('substr_replace', [
				var_file_shadow.clone(), rt.new_string('.po'),
				rt.new_int(-'.mo'.len)])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
				var_pofile.clone(),
			])))))
			{
				continue
			}
			var_language_data.array_get_mut(var_textdomain).array_set(var_language,
				wp_get_pomo_file_data(var_pofile.clone()))
		} else {
			var_pofile = rt.call_function('substr_replace', [
				var_file_shadow.clone(), rt.new_string('.po'),
				rt.new_int(-'.l10n.php'.len)])
			if rt.is_true(rt.call_function('file_exists', [var_pofile.clone()])) {
				continue
			}
			var_language_data.array_get_mut(var_textdomain).array_set(var_language,
				wp_get_l10n_php_file_data(var_file_shadow.clone()))
		}
	}
	return var_language_data.clone()
}

fn wp_get_pomo_file_data(var_po_file rt.PhpVal) rt.PhpVal {
	mut var_headers := rt.new_null()
	mut var_value := rt.new_null()
	mut var_header := rt.new_null()
	var_headers = rt.call_function('get_file_data', [var_po_file.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'POT-Creation-Date', val: '"POT-Creation-Date' },
			rt.ArrayItem{ key: 'PO-Revision-Date', val: '"PO-Revision-Date' },
			rt.ArrayItem{ key: 'Project-Id-Version', val: '"Project-Id-Version' },
			rt.ArrayItem{ key: 'X-Generator', val: '"X-Generator' },
		])])
	mut iter_3 := var_headers.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value_shadow := item_3.val
		mut var_header_shadow := item_3.key
		var_headers.array_set(var_header_shadow, rt.call_function('preg_replace', [
			rt.new_string('~(\\\\n)?"$~'),
			rt.new_string(''),
			var_value_shadow.clone(),
		]))
	}
	return var_headers.clone()
}

fn wp_get_l10n_php_file_data(var_php_file rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_null()
	mut var_headers := rt.new_null()
	mut var_result := rt.new_null()
	mut var_php_header := rt.new_null()
	mut var_po_header := rt.new_null()
	var_data = rt.cast_array(rt.include_file(var_php_file.to_string(), '1'))
	var_data.array_unset(rt.new_string('messages'))
	var_headers = rt.create_array([
		rt.ArrayItem{ key: 'POT-Creation-Date', val: 'pot-creation-date' },
		rt.ArrayItem{ key: 'PO-Revision-Date', val: 'po-revision-date' },
		rt.ArrayItem{ key: 'Project-Id-Version', val: 'project-id-version' },
		rt.ArrayItem{ key: 'X-Generator', val: 'x-generator' },
	])
	var_result = rt.create_array([rt.ArrayItem{ key: 'POT-Creation-Date', val: '' },
		rt.ArrayItem{ key: 'PO-Revision-Date', val: '' }, rt.ArrayItem{
			key: 'Project-Id-Version'
			val: ''
		}, rt.ArrayItem{ key: 'X-Generator', val: '' }])
	mut iter_4 := var_headers.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_php_header_shadow := item_4.val
		mut var_po_header_shadow := item_4.key
		if var_data.array_isset(var_php_header_shadow) {
			var_result.array_set(var_po_header_shadow, var_data.array_get(var_php_header_shadow))
		}
	}
	return var_result.clone()
}

fn wp_dropdown_languages(var_args rt.PhpVal) rt.PhpVal {
	mut var_parsed_args := rt.new_null()
	mut var_translations := rt.new_null()
	mut var_languages := []rt.PhpVal{}
	mut var_locale := rt.new_null()
	mut var_translation := rt.new_null()
	mut var_translations_available := false
	mut var_structure := []rt.PhpVal{}
	mut var_value := ''
	mut var_language := map[string]rt.PhpVal{}
	mut var_output := rt.new_null()
	var_parsed_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'locale' },
			rt.ArrayItem{ key: 'name', val: 'locale' }, rt.ArrayItem{
				key: 'languages'
				val: []rt.PhpVal{}
			}, rt.ArrayItem{ key: 'translations', val: []rt.PhpVal{} },
			rt.ArrayItem{ key: 'selected', val: '' }, rt.ArrayItem{ key: 'echo', val: 1 },
			rt.ArrayItem{ key: 'show_available_translations', val: true },
			rt.ArrayItem{ key: 'show_option_site_default', val: false },
			rt.ArrayItem{ key: 'show_option_en_us', val: true },
			rt.ArrayItem{ key: 'explicit_option_en_us', val: false }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('id'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('name')))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('en_US'), var_parsed_args.array_get(rt.new_string('selected'))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_args.array_get(rt.new_string('explicit_option_en_us')))))) {
		var_parsed_args.array_set('selected', '')
	}
	var_translations = var_parsed_args.array_get(rt.new_string('translations'))
	if !rt.is_true(var_translations) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/translation-install.php', '4')
		var_translations = rt.call_function('wp_get_available_translations', []rt.PhpVal{})
	}
	var_languages = []rt.PhpVal{}
	mut iter_5 := var_parsed_args.array_get(rt.new_string('languages')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_locale_shadow := item_5.val
		if var_translations.array_isset(var_locale_shadow) {
			var_translation = var_translations.array_get(var_locale_shadow)
			var_languages << rt.create_array([
				rt.ArrayItem{
					key: 'language'
					val: var_translation.array_get(rt.new_string('language'))
				},
				rt.ArrayItem{
					key: 'native_name'
					val: var_translation.array_get(rt.new_string('native_name'))
				},
				rt.ArrayItem{ key: 'lang', val: rt.call_function('current', [
					var_translation.array_get(rt.new_string('iso')),
				]) },
			])
			var_translations.array_unset(var_locale_shadow)
		} else {
			var_languages << rt.create_array([
				rt.ArrayItem{ key: 'language', val: var_locale_shadow },
				rt.ArrayItem{ key: 'native_name', val: var_locale_shadow },
				rt.ArrayItem{ key: 'lang', val: '' },
			])
		}
	}
	var_translations_available = !(!rt.is_true(var_translations))
		&& rt.is_true(var_parsed_args.array_get(rt.new_string('show_available_translations')))
	var_structure = []rt.PhpVal{}
	if var_translations_available {
		var_structure << '<optgroup label="' + (esc_attr_x('Installed', 'translations', '')).str() +
			'">'
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('show_option_site_default'))) {
		var_structure << rt.call_function('sprintf', [
			rt.new_string('<option value="site-default" data-installed="1"%s>%s</option>'),
			rt.call_function('selected', [rt.new_string('site-default'),
				var_parsed_args.array_get(rt.new_string('selected')),
				rt.new_bool(false)]),
			_x('Site Default', 'default site language', ''),
		])
	}
	if rt.is_true(var_parsed_args.array_get(rt.new_string('show_option_en_us'))) {
		var_value = if rt.is_true(var_parsed_args.array_get(rt.new_string('explicit_option_en_us'))) {
			'en_US'
		} else {
			''
		}
		var_structure << rt.call_function('sprintf', [
			rt.new_string('<option value="%s" lang="en" data-installed="1"%s>English (United States)</option>'),
			rt.call_function('esc_attr', [rt.new_string(var_value.str()).clone()]),
			rt.call_function('selected', [rt.new_string(''), var_parsed_args.array_get(rt.new_string('selected')),
				rt.new_bool(false)]),
		])
	}
	for var_language_shadow in var_languages {
		var_structure << rt.call_function('sprintf', [
			rt.new_string('<option value="%s" lang="%s"%s data-installed="1">%s</option>'),
			rt.call_function('esc_attr', [var_language_shadow['language']]),
			rt.call_function('esc_attr', [var_language_shadow['lang']]),
			rt.call_function('selected', [var_language_shadow['language'],
				var_parsed_args.array_get(rt.new_string('selected')),
				rt.new_bool(false)]),
			rt.call_function('esc_html', [var_language_shadow['native_name']]),
		])
	}
	if var_translations_available {
		var_structure << rt.new_string('</optgroup>')
	}
	if var_translations_available {
		var_structure << '<optgroup label="' + (esc_attr_x('Available', 'translations', '')).str() +
			'">'
		mut iter_6 := var_translations.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_translation_shadow := item_6.val
			var_structure << rt.call_function('sprintf', [
				rt.new_string('<option value="%s" lang="%s"%s>%s</option>'),
				rt.call_function('esc_attr',
					[var_translation_shadow.array_get(rt.new_string('language'))]),
				rt.call_function('esc_attr', [
					rt.call_function('current',
						[var_translation_shadow.array_get(rt.new_string('iso'))]),
				]),
				rt.call_function('selected', [
					var_translation_shadow.array_get(rt.new_string('language')),
					var_parsed_args.array_get(rt.new_string('selected')),
					rt.new_bool(false),
				]),
				rt.call_function('esc_html', [
					var_translation_shadow.array_get(rt.new_string('native_name')),
				]),
			])
		}
		var_structure << rt.new_string('</optgroup>')
	}
	var_output = rt.call_function('sprintf', [
		rt.new_string('<select name="%s" id="%s">'),
		rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('name'))]),
		rt.call_function('esc_attr', [var_parsed_args.array_get(rt.new_string('id'))]),
	])
	var_output = rt.concat(var_output, rt.call_function('implode', [
		rt.new_string('\n'), rt.create_array_from_list(var_structure)]))
	var_output = rt.concat(var_output, rt.new_string('</select>'))
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		rt.echo_val(var_output)
	}
	return var_output.clone()
}

fn is_rtl() bool {
	mut var_wp_locale := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_locale, 'WP_Locale')))))) {
		return false
	}
	return (rt.call_method(var_wp_locale, 'is_rtl', []rt.PhpVal{})).to_bool()
}

fn switch_to_locale(var_locale rt.PhpVal) bool {
	mut var_wp_locale_switcher := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_locale_switcher)))) {
		return false
	}
	return (rt.call_method(var_wp_locale_switcher, 'switch_to_locale', [
		var_locale.clone()])).to_bool()
}

fn switch_to_user_locale(var_user_id rt.PhpVal) bool {
	mut var_wp_locale_switcher := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_locale_switcher)))) {
		return false
	}
	return (rt.call_method(var_wp_locale_switcher, 'switch_to_user_locale', [
		var_user_id.clone()])).to_bool()
}

fn restore_previous_locale() bool {
	mut var_wp_locale_switcher := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_locale_switcher)))) {
		return false
	}
	return (rt.call_method(var_wp_locale_switcher, 'restore_previous_locale', []rt.PhpVal{})).to_bool()
}

fn restore_current_locale() bool {
	mut var_wp_locale_switcher := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_locale_switcher)))) {
		return false
	}
	return (rt.call_method(var_wp_locale_switcher, 'restore_current_locale', []rt.PhpVal{})).to_bool()
}

fn is_locale_switched() rt.PhpVal {
	mut var_wp_locale_switcher := rt.new_null()
	return rt.call_method(var_wp_locale_switcher, 'is_switched', []rt.PhpVal{})
}

fn translate_settings_using_i18n_schema(var_i18n_schema rt.PhpVal, var_settings rt.PhpVal, var_textdomain rt.PhpVal) rt.PhpVal {
	mut var_translated_settings := rt.new_null()
	mut var_value := rt.new_null()
	mut var_group_key := ''
	mut var_key := rt.new_null()
	if !rt.is_true(var_i18n_schema) || !rt.is_true(var_settings) || !rt.is_true(var_textdomain) {
		return var_settings.clone()
	}
	if rt.create_array_from_list(var_i18n_schema).is_string() && var_settings.clone().is_string() {
		return translate_with_gettext_context(var_settings.clone(),
			rt.create_array_from_list(var_i18n_schema), var_textdomain.clone())
	}
	if rt.create_array_from_list(var_i18n_schema).is_array() && var_settings.clone().is_array() {
		var_translated_settings = []rt.PhpVal{}
		mut iter_7 := var_settings.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_value_shadow := item_7.val
			var_translated_settings.array_push(translate_settings_using_i18n_schema(var_i18n_schema.array_get(rt.new_int(0)),
				var_value_shadow.clone(), var_textdomain.clone()))
		}
		return var_translated_settings.clone()
	}
	if rt.create_array_from_list(var_i18n_schema).is_object() && var_settings.clone().is_array() {
		var_group_key = '*'
		var_translated_settings = []rt.PhpVal{}
		mut iter_8 := var_settings.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_value_shadow := item_8.val
			mut var_key_shadow := item_8.key
			if !(rt.get_property(var_i18n_schema,
				'{"nodeType":"Expr_Variable","line":2018,"name":"key"}')).is_null() {
				var_translated_settings.array_set(var_key_shadow, translate_settings_using_i18n_schema(rt.get_property(var_i18n_schema,
					'{"nodeType":"Expr_Variable","line":2019,"name":"key"}'),
					var_value_shadow.clone(), var_textdomain.clone()))
			} else if !(rt.get_property(var_i18n_schema,
				'{"nodeType":"Expr_Variable","line":2020,"name":"group_key"}')).is_null() {
				var_translated_settings.array_set(var_key_shadow, translate_settings_using_i18n_schema(rt.get_property(var_i18n_schema,
					'{"nodeType":"Expr_Variable","line":2021,"name":"group_key"}'),
					var_value_shadow.clone(), var_textdomain.clone()))
			} else {
				var_translated_settings.array_set(var_key_shadow, var_value_shadow.clone())
			}
		}
		return var_translated_settings.clone()
	}
	return var_settings.clone()
}

fn wp_get_list_item_separator() rt.PhpVal {
	mut var_wp_locale := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_locale, 'WP_Locale')))))) {
		return __(', ', '')
	}
	return rt.call_method(var_wp_locale, 'get_list_item_separator', []rt.PhpVal{})
}

fn wp_get_word_count_type() string {
	mut var_wp_locale := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_locale, 'WP_Locale')))))) {
		return 'words'
	}
	return (rt.call_method(var_wp_locale, 'get_word_count_type', []rt.PhpVal{})).str()
}

fn has_translation(singular string, textdomain string, var_locale rt.PhpVal) bool {
	mut var_singular := singular
	mut var_textdomain := textdomain
	mut iife_temp_2 := Class_WP_Translation_Controller{}
	mut iife_result_2 := iife_temp_2.get_instance()
	return (rt.call_method(iife_result_2, 'has_translation', [
		rt.new_string(singular), rt.new_string(textdomain), var_locale.clone()])).to_bool()
}

struct Class_WP_Translation_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Translations {
	rt.PhpObjectBase
}

struct Class_NOOP_Translations {
	rt.PhpObjectBase
}

fn create_wp_translation_controller(_args ...rt.PhpVal) &Class_WP_Translation_Controller {
	mut obj := &Class_WP_Translation_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_translations(_args ...rt.PhpVal) &Class_WP_Translations {
	mut obj := &Class_WP_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_noop_translations(_args ...rt.PhpVal) &Class_NOOP_Translations {
	mut obj := &Class_NOOP_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Translation_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translation_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_NOOP_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_NOOP_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_NOOP_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
