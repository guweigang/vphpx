import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Translations {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_admin_translations() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Translations', 'instance',
		rt.new_null())
	rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_Translations', 'plugin_domain',
		rt.new_string('woocommerce'))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Translations.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Translations',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_Translations', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_self',
			[]string{}, create_automattic_woocommerce_internal_admin_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Translations', 'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) construct() {
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Translations',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'potentially_load_translation_script_file' },
		]),
		rt.new_int(15)])
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Translations',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'combine_translation_chunk_files' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_activated_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Translations',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'potentially_generate_translation_strings' },
		])])
	rt.call_function('add_action', [rt.new_string('activated_plugin'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Translations',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'potentially_generate_translation_strings' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) get_combined_translation_filename(var_domain rt.PhpVal, var_locale rt.PhpVal) rt.PhpVal {
	mut var_locale_mutated := var_locale
	mut var_filename := rt.new_string(
		(rt.call_function('implode', [rt.new_string('-'), rt.create_array([rt.ArrayItem{
		key: none
		val: var_domain
	}, rt.ArrayItem{ key: none, val: var_locale_mutated }, rt.ArrayItem{
		key: none
		val: rt.get_constant('WC_ADMIN_APP')
	}])])).str() +
		'.json')
	return var_filename.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) combine_official_translation_chunks(var_json_i18n_filenames rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_json_i18n_filenames_mutated := var_json_i18n_filenames
	mut var_combined_translation_data := rt.new_array()
	mut iter_1 := var_json_i18n_filenames_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_json_filename := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_readable', [
			var_json_filename.clone(),
		])))))
		{
			continue
		}
		mut var_file_contents := rt.call_method(var_wp_filesystem, 'get_contents', [
			var_json_filename.clone(),
		])
		mut var_chunk_data := rt.call_function('json_decode', [
			var_file_contents.clone(), rt.new_bool(true)])
		if !rt.is_true(var_chunk_data) {
			continue
		}
		if !(var_chunk_data.array_get(rt.new_string('comment')).array_isset(rt.new_string('reference'))) {
			continue
		}
		mut var_reference_file :=
			var_chunk_data.array_get(rt.new_string('comment')).array_get(rt.new_string('reference'))
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_reference_file.clone(), rt.new_string((rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + 'app/index.js')])))
			&& rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_reference_file.clone(), rt.new_string((rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + 'chunks/')]))) {
			continue
		}
		if !rt.is_true(var_combined_translation_data) {
			var_combined_translation_data = var_chunk_data.clone()
		} else {
			var_combined_translation_data.array_get_mut('locale_data').array_set('messages', rt.call_function('array_merge', [
				var_combined_translation_data.array_get(rt.new_string('locale_data')).array_get(rt.new_string('messages')),
				var_chunk_data.array_get(rt.new_string('locale_data')).array_get(rt.new_string('messages')),
			]))
		}
	}
	var_combined_translation_data.array_unset(rt.new_string('comment'))
	return var_combined_translation_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) combine_user_translation_chunks(var_json_i18n_filenames rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_json_i18n_filenames_mutated := var_json_i18n_filenames
	mut var_combined_translation_data := rt.new_array()
	mut iter_2 := var_json_i18n_filenames_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_json_filename := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_readable', [
			var_json_filename.clone(),
		])))))
		{
			continue
		}
		mut var_file_contents := rt.call_method(var_wp_filesystem, 'get_contents', [
			var_json_filename.clone(),
		])
		mut var_chunk_data := rt.call_function('json_decode', [
			var_file_contents.clone(), rt.new_bool(true)])
		if !rt.is_true(var_chunk_data) {
			continue
		}
		mut var_reference_file := var_chunk_data.array_get(rt.new_string('source'))
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_reference_file.clone(), rt.new_string((rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + 'app/index.js')])))
			&& rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_reference_file.clone(), rt.new_string((rt.get_constant('WC_ADMIN_DIST_JS_FOLDER')).str() + 'chunks/')]))) {
			continue
		}
		if !rt.is_true(var_combined_translation_data) {
			var_combined_translation_data = var_chunk_data.clone()
		} else {
			var_combined_translation_data.array_get_mut('locale_data').array_set('woocommerce', rt.call_function('array_merge', [
				var_combined_translation_data.array_get(rt.new_string('locale_data')).array_get(rt.new_string('woocommerce')),
				var_chunk_data.array_get(rt.new_string('locale_data')).array_get(rt.new_string('woocommerce')),
			]))
		}
	}
	var_combined_translation_data.array_unset(rt.new_string('source'))
	return var_combined_translation_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) get_translation_chunk_data(var_lang_dir rt.PhpVal, var_domain rt.PhpVal, var_locale rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_lang_dir_mutated := var_lang_dir
	mut var_locale_mutated := var_locale
	mut var_json_i18n_filenames := rt.call_function('glob', [
		rt.new_string(var_lang_dir_mutated.str() + var_domain.str() + '-' +
			var_locale_mutated.str() + '-*.json'),
	])
	mut var_combined_translation_data := rt.new_array()
	if rt.is_true(rt.identical(rt.new_bool(false), var_json_i18n_filenames)) {
		return var_combined_translation_data.clone()
	}
	mut var_format_determine_file := rt.call_function('reset', [
		var_json_i18n_filenames.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_readable', [
		var_format_determine_file.clone(),
	])))))
	{
		return var_combined_translation_data.clone()
	}
	mut var_file_contents := rt.call_method(var_wp_filesystem, 'get_contents', [
		var_format_determine_file.clone(),
	])
	mut var_format_determine_data := rt.call_function('json_decode', [
		var_file_contents.clone(), rt.new_bool(true)])
	if !rt.is_true(var_format_determine_data) {
		return var_combined_translation_data.clone()
	}
	if var_format_determine_data.array_isset(rt.new_string('comment')) {
		return this.combine_official_translation_chunks(var_json_i18n_filenames.clone())
	} else if var_format_determine_data.array_isset(rt.new_string('source')) {
		return this.combine_user_translation_chunks(var_json_i18n_filenames.clone())
	} else {
		return var_combined_translation_data.clone()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) build_and_save_translations(var_language_dir rt.PhpVal, var_plugin_domain rt.PhpVal, var_locale rt.PhpVal) {
	mut var_wp_filesystem := rt.new_null()
	mut var_language_dir_mutated := var_language_dir
	mut var_locale_mutated := var_locale
	mut var_translations_from_chunks := this.get_translation_chunk_data(var_language_dir_mutated.clone(),
		var_plugin_domain.clone(), var_locale_mutated.clone())
	if !rt.is_true(var_translations_from_chunks) {
		return
	}
	mut var_cache_filename := this.get_combined_translation_filename(var_plugin_domain.clone(),
		var_locale_mutated.clone())
	mut var_chunk_translations_json := rt.call_function('wp_json_encode', [
		var_translations_from_chunks.clone()])
	rt.call_method(var_wp_filesystem, 'put_contents', [
		rt.new_string(var_language_dir_mutated.str() + var_cache_filename.str()),
		var_chunk_translations_json.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) generate_translation_strings() {
	mut var_locale := rt.call_function('determine_locale', []rt.PhpVal{})
	mut var_lang_dir := rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/')
	if rt.is_true(rt.identical(rt.new_string('en_US'), var_locale)) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_filesystem_method'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	}
	mut var_access_type := rt.call_function('get_filesystem_method', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('direct'), var_access_type)) {
		rt.call_function('WP_Filesystem', []rt.PhpVal{})
		this.build_and_save_translations(var_lang_dir.clone(), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Translations',
			'plugin_domain'), var_locale.clone())
	} else {
		return
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) potentially_load_translation_script_file() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_0 := iife_temp_0.is_admin_or_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	rt.call_function('add_filter', [rt.new_string('load_script_translation_file'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Translations',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'load_script_translation_file' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) load_script_translation_file(var_file rt.PhpVal, var_handle rt.PhpVal, var_domain rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('WC_ADMIN_APP'), var_handle)))) {
		return var_file.str()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Translations',
		'plugin_domain'), var_domain))))
	{
		return var_file.str()
	}
	mut var_locale := rt.call_function('determine_locale', []rt.PhpVal{})
	mut var_cache_filename := this.get_combined_translation_filename(var_domain.clone(),
		var_locale.clone())
	return (rt.get_constant('WP_LANG_DIR')).str() + '/plugins/' + var_cache_filename.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) potentially_generate_translation_strings(var_filename rt.PhpVal) {
	mut var_filename_mutated := var_filename
	mut var_activated_plugin_domain := rt.call_function('explode', [
		rt.new_string('/'), var_filename_mutated.clone()]).array_get(rt.new_int(0))
	if rt.is_true(rt.identical(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Translations',
		'plugin_domain'), var_activated_plugin_domain))
	{
		this.generate_translation_strings()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) combine_translation_chunk_files(var_instance rt.PhpVal, var_hook_extra rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_instance.clone(), rt.new_string('Language_Pack_Upgrader')])))))
		|| !(var_hook_extra.array_isset(rt.new_string('translations')))
		|| !(var_hook_extra.array_get(rt.new_string('translations')).is_array()) {
		return
	}
	mut var_locales := rt.new_array()
	mut var_language_dir := rt.new_string((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/')
	mut iter_3 := var_hook_extra.array_get(rt.new_string('translations')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_translation := item_3.val
		if rt.is_true(rt.identical(rt.new_string('plugin'), var_translation.array_get(rt.new_string('type'))))
			&& rt.is_true(rt.identical(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Translations', 'plugin_domain'), var_translation.array_get(rt.new_string('slug')))) {
			var_locales.array_push(var_translation.array_get(rt.new_string('language')))
		}
	}
	mut iter_4 := var_locales.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_locale := item_4.val
		this.build_and_save_translations(var_language_dir.clone(), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_Translations',
			'plugin_domain'), var_locale.clone())
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_translations() &Class_Automattic_WooCommerce_Internal_Admin_Translations {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Translations.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_combined_translation_filename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_combined_translation_filename(dispatch_arg_0, dispatch_arg_1)
		}
		'combine_official_translation_chunks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.combine_official_translation_chunks(dispatch_arg_0)
		}
		'combine_user_translation_chunks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.combine_user_translation_chunks(dispatch_arg_0)
		}
		'get_translation_chunk_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_translation_chunk_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'build_and_save_translations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.build_and_save_translations(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'generate_translation_strings' {
			this.generate_translation_strings()
			return rt.new_null()
		}
		'potentially_load_translation_script_file' {
			this.potentially_load_translation_script_file()
			return rt.new_null()
		}
		'load_script_translation_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.load_script_translation_file(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'potentially_generate_translation_strings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.potentially_generate_translation_strings(dispatch_arg_0)
			return rt.new_null()
		}
		'combine_translation_chunk_files' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.combine_translation_chunk_files(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
