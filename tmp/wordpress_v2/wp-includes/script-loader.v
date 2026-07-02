import rt

fn wp_register_tinymce_scripts(var_scripts rt.PhpVal, force_uncompressed bool) {
	mut var_force_uncompressed := force_uncompressed
	mut var_tinymce_version := rt.new_null()
	mut var_concatenate_scripts := rt.new_null()
	mut var_compress_scripts := rt.new_null()
	mut var_suffix := rt.new_null()
	mut var_dev_suffix := rt.new_null()
	mut var_compressed := false
	var_suffix = wp_scripts_get_suffix('')
	var_dev_suffix = wp_scripts_get_suffix('dev')
	script_concat_settings()
	var_compressed = rt.is_true(var_compress_scripts) && rt.is_true(var_concatenate_scripts)
		&& !var_force_uncompressed
	if var_compressed {
		rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce'),
			rt.new_string(
				(rt.call_function('includes_url', [rt.new_string('js/tinymce/')])).str() +
				'wp-tinymce.js'),
			rt.new_array(), var_tinymce_version.clone()])
	} else {
		rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce-root'),
			rt.new_string(
				(rt.call_function('includes_url', [rt.new_string('js/tinymce/')])).str() +
				'tinymce${var_dev_suffix.to_string()}.js'),
			rt.new_array(), var_tinymce_version.clone()])
		rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce'),
			rt.new_string(
				(rt.call_function('includes_url', [rt.new_string('js/tinymce/')])).str() +
				'plugins/compat3x/plugin${var_dev_suffix.to_string()}.js'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-tinymce-root' },
			]),
			var_tinymce_version.clone()])
	}
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce-lists'),
		rt.call_function('includes_url', [
			rt.new_string('js/tinymce/plugins/lists/plugin${var_suffix.to_string()}.js'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-tinymce' },
		]),
		var_tinymce_version.clone()])
}

fn wp_default_packages_vendor(var_scripts rt.PhpVal) {
	mut var_wp_locale := rt.new_null()
	mut var_suffix := rt.new_null()
	mut var_vendor_scripts := map[string]rt.PhpVal{}
	mut var_vendor_scripts_versions := rt.new_null()
	mut var_dependencies := rt.new_null()
	mut var_handle := rt.new_null()
	var_suffix = wp_scripts_get_suffix('')
	var_vendor_scripts = {
		'react':                       rt.new_array()
		'react-dom':                   map[string]rt.PhpVal{}
		'react-jsx-runtime':           map[string]rt.PhpVal{}
		'regenerator-runtime':         rt.new_array()
		'moment':                      rt.new_array()
		'lodash':                      rt.new_array()
		'wp-polyfill-fetch':           rt.new_array()
		'wp-polyfill-formdata':        rt.new_array()
		'wp-polyfill-node-contains':   rt.new_array()
		'wp-polyfill-url':             rt.new_array()
		'wp-polyfill-dom-rect':        rt.new_array()
		'wp-polyfill-element-closest': rt.new_array()
		'wp-polyfill-object-fit':      rt.new_array()
		'wp-polyfill-inert':           rt.new_array()
		'wp-polyfill':                 rt.new_array()
	}
	var_vendor_scripts_versions = rt.create_array([
		rt.ArrayItem{ key: 'react', val: '18.3.1.1' },
		rt.ArrayItem{ key: 'react-dom', val: '18.3.1.1' },
		rt.ArrayItem{ key: 'react-jsx-runtime', val: '18.3.1' },
		rt.ArrayItem{ key: 'regenerator-runtime', val: '0.14.1' },
		rt.ArrayItem{ key: 'moment', val: '2.30.1' },
		rt.ArrayItem{ key: 'lodash', val: '4.18.1' },
		rt.ArrayItem{ key: 'wp-polyfill-fetch', val: '3.6.20' },
		rt.ArrayItem{ key: 'wp-polyfill-formdata', val: '4.0.10' },
		rt.ArrayItem{ key: 'wp-polyfill-node-contains', val: '4.8.0' },
		rt.ArrayItem{ key: 'wp-polyfill-url', val: '3.6.4' },
		rt.ArrayItem{ key: 'wp-polyfill-dom-rect', val: '4.8.0' },
		rt.ArrayItem{ key: 'wp-polyfill-element-closest', val: '3.0.2' },
		rt.ArrayItem{ key: 'wp-polyfill-object-fit', val: '2.3.5' },
		rt.ArrayItem{ key: 'wp-polyfill-inert', val: '3.1.3' },
		rt.ArrayItem{ key: 'wp-polyfill', val: '3.15.0' },
	])
	for var_handle_shadow, var_dependencies_shadow in var_vendor_scripts {
		rt.call_method(var_scripts, 'add', [rt.new_string(var_handle_shadow.str()).clone(),
			rt.new_string('/wp-includes/js/dist/vendor/${var_handle.to_string()}${var_suffix.to_string()}.js'),
			var_dependencies_shadow.clone(), var_vendor_scripts_versions.array_get(rt.new_string(var_handle_shadow.str())),
			rt.new_int(1)])
	}
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('lodash'), rt.new_string('window.lodash = _.noConflict();')])))
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('moment'), rt.call_function('sprintf', [rt.new_string("moment.updateLocale( '%s', %s );"), rt.call_function('esc_js', [rt.call_function('get_user_locale', []rt.PhpVal{})]), rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{
		key: 'months'
		val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'month')])
	}, rt.ArrayItem{
		key: 'monthsShort'
		val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'month_abbrev')])
	}, rt.ArrayItem{
		key: 'weekdays'
		val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday')])
	}, rt.ArrayItem{
		key: 'weekdaysShort'
		val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday_abbrev')])
	}, rt.ArrayItem{ key: 'week', val: rt.create_array([rt.ArrayItem{
		key: 'dow'
		val: rt.new_int((rt.call_function('get_option', [rt.new_string('start_of_week'), rt.new_int(0)])).to_i64())
	}]) }, rt.ArrayItem{ key: 'longDateFormat', val: rt.create_array([rt.ArrayItem{
		key: 'LT'
		val: rt.call_function('get_option', [rt.new_string('time_format'), rt.call_function('__', [rt.new_string('g:i a')])])
	}, rt.ArrayItem{ key: 'LTS', val: rt.new_null() }, rt.ArrayItem{ key: 'L', val: rt.new_null() }, rt.ArrayItem{
		key: 'LL'
		val: rt.call_function('get_option', [rt.new_string('date_format'), rt.call_function('__', [rt.new_string('F j, Y')])])
	}, rt.ArrayItem{ key: 'LLL', val: rt.call_function('__', [rt.new_string('F j, Y g:i a')]) }, rt.ArrayItem{
		key: 'LLLL'
		val: rt.new_null()
	}]) }]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('after')])))
}

fn wp_register_development_scripts(var_scripts rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('SCRIPT_DEBUG')))))
		|| !rt.is_true(rt.get_property(var_scripts, 'registered').array_get(rt.new_string('react')))
		|| rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])) {
		return
	}
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-react-refresh-runtime'),
		rt.new_string('/wp-includes/js/dist/development/react-refresh-runtime.js'),
		rt.new_array(), rt.new_string('0.14.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-react-refresh-entry'),
		rt.new_string('/wp-includes/js/dist/development/react-refresh-entry.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-react-refresh-runtime' }]),
		rt.new_string('0.14.0')])
	rt.get_property(rt.get_property(var_scripts, 'registered').array_get(rt.new_string('react')),
		'deps').array_push('wp-react-refresh-entry')
}

fn wp_get_script_polyfill(var_scripts rt.PhpVal, var_tests rt.PhpVal) string {
	mut var_polyfill := ''
	mut var_handle := rt.new_null()
	mut var_test := rt.new_null()
	mut var_src := rt.new_null()
	mut var_ver := rt.new_null()
	var_polyfill = ''
	mut iter_1 := var_tests.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_handle_shadow := item_1.val
		mut var_test_shadow := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_scripts,
			'registered').array_isset(var_handle_shadow.clone()))))))
		{
			continue
		}
		var_src = rt.get_property(rt.get_property(var_scripts, 'registered').array_get(var_handle_shadow),
			'src')
		var_ver = rt.get_property(rt.get_property(var_scripts, 'registered').array_get(var_handle_shadow),
			'ver')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), var_src.clone()])))))
			&& !(rt.is_true(rt.get_property(var_scripts, 'content_url'))
			&& rt.is_true(rt.call_function('str_starts_with', [var_src.clone(), rt.get_property(var_scripts, 'content_url')]))) {
			var_src =
				rt.new_string((rt.get_property(var_scripts, 'base_url')).str() + var_src.str())
		}
		if !(!rt.is_true(var_ver)) {
			var_src = rt.call_function('add_query_arg', [rt.new_string('ver'),
				var_ver.clone(), var_src.clone()])
		}
		var_src = rt.call_function('esc_url', [
			rt.call_function('apply_filters', [rt.new_string('script_loader_src'),
				var_src.clone(), var_handle_shadow.clone()]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
			continue
		}
		var_polyfill = var_polyfill + '( ' + var_test_shadow.str() + ' ) || ' +
			'document.write( \'<script src="' + var_src.str() + '"></scr\' + \'ipt>\' );'
	}
	return var_polyfill
}

fn wp_default_packages_scripts(var_scripts rt.PhpVal) {
	mut var_suffix := rt.new_null()
	mut var_assets_file := rt.new_null()
	mut var_assets := rt.new_null()
	mut var_package_data := map[string]rt.PhpVal{}
	mut var_file_name := rt.new_null()
	mut var_basename := rt.new_null()
	mut var_handle := rt.new_null()
	mut var_path := ''
	mut var_dependencies := rt.new_null()
	mut var_ltr := rt.new_null()
	mut var_script := rt.new_null()
	var_suffix = if rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_RUN_CORE_TESTS'),
	]))
	{ rt.new_string('.min') } else { wp_scripts_get_suffix('') }
	var_assets_file = rt.new_string(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/assets/script-loader-packages.php')
	var_assets = if rt.is_true(rt.call_function('file_exists', [
		var_assets_file.clone()]))
	{ rt.include_file(var_assets_file.to_string(), '1') } else { rt.new_array() }
	mut iter_2 := var_assets.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_package_data_shadow := item_2.val
		mut var_file_name_shadow := item_2.key
		var_basename = rt.call_function('str_replace', [rt.new_string('.js'),
			rt.new_string(''), rt.call_function('basename', [var_file_name_shadow.clone()])])
		var_handle = rt.new_string('wp-' + var_basename.str())
		var_path = '/wp-includes/js/dist/${var_basename.to_string()}${var_suffix.to_string()}.js'
		if !(!rt.is_true(var_package_data_shadow['dependencies'])) {
			var_dependencies = var_package_data_shadow['dependencies']
		} else {
			var_dependencies = rt.new_array()
		}
		mut switch_val_1 := var_handle
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-block-library'))) {
			var_dependencies.clone().array_push(rt.new_string('editor'))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-edit-post'))) {
			var_dependencies.clone().array_push(rt.new_string('media-models'))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-preferences'))) {
			var_dependencies.clone().array_push(rt.new_string('wp-preferences-persistence'))
		}
		rt.call_method(var_scripts, 'add', [var_handle.clone(),
			rt.new_string(var_path.str()).clone(), var_dependencies.clone(), var_package_data_shadow['version'],
			rt.new_int(1)])
		if !(!rt.is_true(var_package_data_shadow['module_dependencies'])) {
			rt.call_method(var_scripts, 'add_data', [var_handle.clone(),
				rt.new_string('module_dependencies'), var_package_data_shadow['module_dependencies']])
		}
		if rt.is_true(rt.call_function('in_array', [rt.new_string('wp-i18n'),
			var_dependencies.clone(), rt.new_bool(true)]))
		{
			rt.call_method(var_scripts, 'set_translations', [
				var_handle.clone()])
		}
		if rt.is_true(rt.identical(rt.new_string('wp-i18n'), var_handle)) {
			var_ltr = rt.call_function('_x', [rt.new_string('ltr'),
				rt.new_string('text direction')])
			var_script = rt.call_function('sprintf', [
				rt.new_string("wp.i18n.setLocaleData( { 'text direction\\u0004ltr': [ '%s' ] } );"),
				var_ltr.clone(),
			])
			rt.call_method(var_scripts, 'add_inline_script', [
				var_handle.clone(), var_script.clone(), rt.new_string('after')])
		}
	}
}

fn wp_default_packages_inline_scripts(var_scripts rt.PhpVal) {
	mut var_wp_locale := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_meta_key := rt.new_null()
	mut var_user_id := rt.new_null()
	mut var_preload_data := rt.new_null()
	mut var_timezone_string := rt.new_null()
	mut var_timezone_abbr := rt.new_null()
	mut var_timezone_date := rt.new_null()
	mut var_gmt_offset := rt.new_null()
	if rt.get_property(var_scripts, 'registered').array_isset(rt.new_string('wp-api-fetch')) {
		rt.get_property(rt.get_property(var_scripts, 'registered').array_get(rt.new_string('wp-api-fetch')),
			'deps').array_push('wp-hooks')
	}
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-api-fetch'),
		rt.call_function('sprintf', [
			rt.new_string('wp.apiFetch.use( wp.apiFetch.createRootURLMiddleware( "%s" ) );'),
			rt.call_function('sanitize_url', [
				rt.call_function('get_rest_url', []rt.PhpVal{}),
			]),
		]),
		rt.new_string('after')])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-api-fetch'),
		rt.call_function('implode', [rt.new_string('\n'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
					rt.new_string('wp.apiFetch.nonceMiddleware = wp.apiFetch.createNonceMiddleware( "%s" );'),
					if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) { rt.new_string('') } else { rt.call_function('wp_create_nonce', [
							rt.new_string('wp_rest'),
						]) },
				]) },
				rt.ArrayItem{ key: none, val: 'wp.apiFetch.use( wp.apiFetch.nonceMiddleware );' },
				rt.ArrayItem{
					key: none
					val: 'wp.apiFetch.use( wp.apiFetch.mediaUploadMiddleware );'
				},
				rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [
					rt.new_string('wp.apiFetch.nonceEndpoint = "%s";'),
					rt.call_function('admin_url', [
						rt.new_string('admin-ajax.php?action=rest-nonce'),
					]),
				]) },
			])]),
		rt.new_string('after')])
	var_meta_key = rt.new_string(
		(rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'persisted_preferences')
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	var_preload_data = rt.call_function('get_user_meta', [var_user_id.clone(),
		var_meta_key.clone(), rt.new_bool(true)])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-preferences'),
		rt.call_function('sprintf', [
			rt.new_string('( function() {\n\t\t\t\tvar serverData = %s;\n\t\t\t\tvar userId = "%d";\n\t\t\t\tvar persistenceLayer = wp.preferencesPersistence.__unstableCreatePersistenceLayer( serverData, userId );\n\t\t\t\tvar preferencesStore = wp.preferences.store;\n\t\t\t\twp.data.dispatch( preferencesStore ).setPersistenceLayer( persistenceLayer );\n\t\t\t} ) ();'),
			rt.call_function('wp_json_encode', [var_preload_data.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
			var_user_id.clone(),
		])])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-data'),
		rt.call_function('implode', [rt.new_string('\n'),
			rt.create_array([rt.ArrayItem{ key: none, val: '( function() {' },
				rt.ArrayItem{ key: none, val: '\tvar userId = ' +
					(rt.call_function('get_current_user_id', []rt.PhpVal{})).str() + ';' },
				rt.ArrayItem{ key: none, val: '\tvar storageKey = "WP_DATA_USER_" + userId;' },
				rt.ArrayItem{ key: none, val: '\twp.data' }, rt.ArrayItem{
					key: none
					val: '\t\t.use( wp.data.plugins.persistence, { storageKey: storageKey } );'
				}, rt.ArrayItem{ key: none, val: '} )();' }])])])
	var_timezone_string = rt.call_function('get_option', [
		rt.new_string('timezone_string'),
		rt.new_string('UTC'),
	])
	var_timezone_abbr = rt.new_string('')
	if !(!rt.is_true(var_timezone_string)) {
		var_timezone_date = create_datetime(rt.new_string('now'),
			create_datetimezone(var_timezone_string.clone()))
		var_timezone_abbr = var_timezone_date.format(rt.new_string('T'))
	}
	var_gmt_offset = rt.call_function('get_option', [rt.new_string('gmt_offset'),
		rt.new_int(0)])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-date'),
		rt.call_function('sprintf', [rt.new_string('wp.date.setSettings( %s );'),
			rt.call_function('wp_json_encode', [
				rt.create_array([
					rt.ArrayItem{ key: 'l10n', val: rt.create_array([
						rt.ArrayItem{ key: 'locale', val: rt.call_function('get_user_locale',
							[]rt.PhpVal{}) },
						rt.ArrayItem{ key: 'months', val: rt.call_function('array_values', [
							rt.get_property(var_wp_locale, 'month'),
						]) },
						rt.ArrayItem{ key: 'monthsShort', val: rt.call_function('array_values', [
							rt.get_property(var_wp_locale, 'month_abbrev'),
						]) },
						rt.ArrayItem{ key: 'weekdays', val: rt.call_function('array_values', [
							rt.get_property(var_wp_locale, 'weekday'),
						]) },
						rt.ArrayItem{ key: 'weekdaysShort', val: rt.call_function('array_values', [
							rt.get_property(var_wp_locale, 'weekday_abbrev'),
						]) },
						rt.ArrayItem{ key: 'meridiem', val: rt.array_to_object(rt.get_property(var_wp_locale,
							'meridiem')) },
						rt.ArrayItem{ key: 'relative', val: rt.create_array([
							rt.ArrayItem{ key: 'future', val: rt.call_function('__', [
								rt.new_string('%s from now'),
							]) },
							rt.ArrayItem{ key: 'past', val: rt.call_function('__', [
								rt.new_string('%s ago'),
							]) },
							rt.ArrayItem{ key: 's', val: rt.call_function('__', [
								rt.new_string('a second'),
							]) },
							rt.ArrayItem{ key: 'ss', val: rt.call_function('__', [
								rt.new_string('%d seconds'),
							]) },
							rt.ArrayItem{ key: 'm', val: rt.call_function('__', [
								rt.new_string('a minute'),
							]) },
							rt.ArrayItem{ key: 'mm', val: rt.call_function('__', [
								rt.new_string('%d minutes'),
							]) },
							rt.ArrayItem{ key: 'h', val: rt.call_function('__', [
								rt.new_string('an hour'),
							]) },
							rt.ArrayItem{ key: 'hh', val: rt.call_function('__', [
								rt.new_string('%d hours'),
							]) },
							rt.ArrayItem{ key: 'd', val: rt.call_function('__', [
								rt.new_string('a day'),
							]) },
							rt.ArrayItem{ key: 'dd', val: rt.call_function('__', [
								rt.new_string('%d days'),
							]) },
							rt.ArrayItem{ key: 'M', val: rt.call_function('__', [
								rt.new_string('a month'),
							]) },
							rt.ArrayItem{ key: 'MM', val: rt.call_function('__', [
								rt.new_string('%d months'),
							]) },
							rt.ArrayItem{ key: 'y', val: rt.call_function('__', [
								rt.new_string('a year'),
							]) },
							rt.ArrayItem{ key: 'yy', val: rt.call_function('__', [
								rt.new_string('%d years'),
							]) },
						]) },
						rt.ArrayItem{ key: 'startOfWeek', val: rt.new_int((rt.call_function('get_option', [
							rt.new_string('start_of_week'),
							rt.new_int(0),
						])).to_i64()) },
					]) },
					rt.ArrayItem{ key: 'formats', val: rt.create_array([
						rt.ArrayItem{ key: 'time', val: rt.call_function('get_option', [
							rt.new_string('time_format'),
							rt.call_function('__', [
								rt.new_string('g:i a'),
							]),
						]) },
						rt.ArrayItem{ key: 'date', val: rt.call_function('get_option', [
							rt.new_string('date_format'),
							rt.call_function('__', [
								rt.new_string('F j, Y'),
							]),
						]) },
						rt.ArrayItem{ key: 'datetime', val: rt.call_function('__', [
							rt.new_string('F j, Y g:i a'),
						]) },
						rt.ArrayItem{ key: 'datetimeAbbreviated', val: rt.call_function('__', [
							rt.new_string('M j, Y g:i a'),
						]) },
					]) },
					rt.ArrayItem{ key: 'timezone', val: rt.create_array([
						rt.ArrayItem{ key: 'offset', val: rt.new_float(var_gmt_offset.to_f64()) },
						rt.ArrayItem{ key: 'offsetFormatted', val: rt.call_function('str_replace', [
							rt.create_array([
								rt.ArrayItem{ key: none, val: '.25' },
								rt.ArrayItem{ key: none, val: '.5' },
								rt.ArrayItem{ key: none, val: '.75' },
							]),
							rt.create_array([
								rt.ArrayItem{ key: none, val: ':15' },
								rt.ArrayItem{ key: none, val: ':30' },
								rt.ArrayItem{ key: none, val: ':45' },
							]),
							rt.new_string(var_gmt_offset.str()),
						]) },
						rt.ArrayItem{ key: 'string', val: var_timezone_string },
						rt.ArrayItem{ key: 'abbr', val: var_timezone_abbr },
					]) },
				]),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			])]),
		rt.new_string('after')])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('editor'),
		rt.new_string('window.wp.oldEditor = window.wp.editor;'),
		rt.new_string('after')])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-editor'),
		rt.new_string('Object.assign( window.wp.editor, window.wp.oldEditor );'),
		rt.new_string('after')])
}

fn wp_tinymce_inline_scripts() {
	mut var_wp_scripts := rt.new_null()
	mut var_editor_settings := rt.new_null()
	mut var_tinymce_plugins := rt.new_null()
	mut var_disable_captions := false
	mut var_toolbar1 := rt.new_null()
	mut var_toolbar2 := rt.new_null()
	mut var_toolbar3 := rt.new_null()
	mut var_toolbar4 := rt.new_null()
	mut var_external_plugins := rt.new_null()
	mut var_tinymce_settings := rt.new_null()
	mut var_init_obj := rt.new_null()
	mut var_value := []rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_val := ''
	mut var_script := rt.new_null()
	var_editor_settings = rt.call_function('apply_filters', [
		rt.new_string('wp_editor_settings'),
		rt.create_array([rt.ArrayItem{ key: 'tinymce', val: true }]),
		rt.new_string('classic-block'),
	])
	var_tinymce_plugins = rt.create_array([rt.ArrayItem{ key: none, val: 'charmap' },
		rt.ArrayItem{ key: none, val: 'colorpicker' }, rt.ArrayItem{ key: none, val: 'hr' },
		rt.ArrayItem{ key: none, val: 'lists' }, rt.ArrayItem{ key: none, val: 'media' },
		rt.ArrayItem{ key: none, val: 'paste' }, rt.ArrayItem{ key: none, val: 'tabfocus' },
		rt.ArrayItem{ key: none, val: 'textcolor' }, rt.ArrayItem{ key: none, val: 'fullscreen' },
		rt.ArrayItem{ key: none, val: 'wordpress' }, rt.ArrayItem{ key: none, val: 'wpautoresize' },
		rt.ArrayItem{ key: none, val: 'wpeditimage' }, rt.ArrayItem{ key: none, val: 'wpemoji' },
		rt.ArrayItem{ key: none, val: 'wpgallery' }, rt.ArrayItem{ key: none, val: 'wplink' },
		rt.ArrayItem{ key: none, val: 'wpdialogs' }, rt.ArrayItem{ key: none, val: 'wptextpattern' },
		rt.ArrayItem{ key: none, val: 'wpview' }])
	var_tinymce_plugins = rt.call_function('apply_filters', [
		rt.new_string('tiny_mce_plugins'),
		var_tinymce_plugins.clone(),
		rt.new_string('classic-block'),
	])
	var_tinymce_plugins = rt.call_function('array_unique', [var_tinymce_plugins.clone()])
	var_disable_captions = false
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('disable_captions'),
		rt.new_string('')]))
	{
		var_disable_captions = true
	}
	var_toolbar1 = rt.create_array([rt.ArrayItem{ key: none, val: 'formatselect' },
		rt.ArrayItem{ key: none, val: 'bold' }, rt.ArrayItem{ key: none, val: 'italic' },
		rt.ArrayItem{ key: none, val: 'bullist' }, rt.ArrayItem{ key: none, val: 'numlist' },
		rt.ArrayItem{ key: none, val: 'blockquote' }, rt.ArrayItem{ key: none, val: 'alignleft' },
		rt.ArrayItem{ key: none, val: 'aligncenter' }, rt.ArrayItem{ key: none, val: 'alignright' },
		rt.ArrayItem{ key: none, val: 'link' }, rt.ArrayItem{ key: none, val: 'unlink' },
		rt.ArrayItem{ key: none, val: 'wp_more' }, rt.ArrayItem{ key: none, val: 'spellchecker' },
		rt.ArrayItem{ key: none, val: 'wp_add_media' }, rt.ArrayItem{ key: none, val: 'wp_adv' }])
	var_toolbar1 = rt.call_function('apply_filters', [rt.new_string('mce_buttons'),
		var_toolbar1.clone(), rt.new_string('classic-block')])
	var_toolbar2 = rt.create_array([rt.ArrayItem{ key: none, val: 'strikethrough' },
		rt.ArrayItem{ key: none, val: 'hr' }, rt.ArrayItem{ key: none, val: 'forecolor' },
		rt.ArrayItem{ key: none, val: 'pastetext' }, rt.ArrayItem{ key: none, val: 'removeformat' },
		rt.ArrayItem{ key: none, val: 'charmap' }, rt.ArrayItem{ key: none, val: 'outdent' },
		rt.ArrayItem{ key: none, val: 'indent' }, rt.ArrayItem{ key: none, val: 'undo' },
		rt.ArrayItem{ key: none, val: 'redo' }, rt.ArrayItem{ key: none, val: 'wp_help' }])
	var_toolbar2 = rt.call_function('apply_filters', [rt.new_string('mce_buttons_2'),
		var_toolbar2.clone(), rt.new_string('classic-block')])
	var_toolbar3 = rt.call_function('apply_filters', [rt.new_string('mce_buttons_3'),
		rt.new_array(), rt.new_string('classic-block')])
	var_toolbar4 = rt.call_function('apply_filters', [rt.new_string('mce_buttons_4'),
		rt.new_array(), rt.new_string('classic-block')])
	var_external_plugins = rt.call_function('apply_filters', [
		rt.new_string('mce_external_plugins'),
		rt.new_array(),
		rt.new_string('classic-block'),
	])
	var_tinymce_settings = rt.create_array([
		rt.ArrayItem{ key: 'plugins', val: rt.call_function('implode', [
			rt.new_string(','),
			var_tinymce_plugins.clone(),
		]) },
		rt.ArrayItem{ key: 'toolbar1', val: rt.call_function('implode', [
			rt.new_string(','),
			var_toolbar1.clone(),
		]) },
		rt.ArrayItem{ key: 'toolbar2', val: rt.call_function('implode', [
			rt.new_string(','),
			var_toolbar2.clone(),
		]) },
		rt.ArrayItem{ key: 'toolbar3', val: rt.call_function('implode', [
			rt.new_string(','),
			var_toolbar3.clone(),
		]) },
		rt.ArrayItem{ key: 'toolbar4', val: rt.call_function('implode', [
			rt.new_string(','),
			var_toolbar4.clone(),
		]) },
		rt.ArrayItem{ key: 'external_plugins', val: rt.call_function('wp_json_encode', [
			var_external_plugins.clone(),
		]) },
		rt.ArrayItem{ key: 'classic_block_editor', val: true },
	])
	if var_disable_captions {
		var_tinymce_settings.array_set('wpeditimage_disable_captions', true)
	}
	if !(!rt.is_true(var_editor_settings.array_get(rt.new_string('tinymce'))))
		&& var_editor_settings.array_get(rt.new_string('tinymce')).is_array() {
		var_tinymce_settings = rt.call_function('array_merge', [
			var_tinymce_settings.clone(), var_editor_settings.array_get(rt.new_string('tinymce'))])
	}
	var_tinymce_settings = rt.call_function('apply_filters', [
		rt.new_string('tiny_mce_before_init'),
		var_tinymce_settings.clone(),
		rt.new_string('classic-block'),
	])
	var_init_obj = rt.new_string('')
	mut iter_3 := var_tinymce_settings.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value_shadow := item_3.val
		mut var_key_shadow := item_3.key
		if rt.is_true(rt.new_bool(var_value_shadow.clone().is_bool())) {
			var_val = if rt.is_true(var_value_shadow) { 'true' } else { 'false' }
			var_init_obj = rt.concat(var_init_obj, rt.new_string(var_key_shadow.str() + ':' +
				var_val + ','))
			continue
		} else if !(!rt.is_true(var_value_shadow)) && var_value_shadow.clone().is_string()
			&& ((rt.is_true(rt.identical(rt.new_string('{'), var_value_shadow[0]))
			&& rt.is_true(rt.identical(rt.new_string('}'), var_value_shadow[var_value_shadow.clone().to_string().len - 1])))
			|| (rt.is_true(rt.identical(rt.new_string('['), var_value_shadow[0]))
			&& rt.is_true(rt.identical(rt.new_string(']'), var_value_shadow[var_value_shadow.clone().to_string().len - 1]))))
			|| rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\(?function ?\\(/'), var_value_shadow.clone()])) {
			var_init_obj = rt.concat(var_init_obj, rt.new_string(var_key_shadow.str() + ':' +
				var_value_shadow.str() + ','))
			continue
		}
		var_init_obj = rt.concat(var_init_obj, rt.new_string(var_key_shadow.str() + ':"' +
			var_value_shadow.str() + '",'))
	}
	var_init_obj = rt.new_string('{' + var_init_obj.clone().to_string().trim_space() + '}')
	var_script = rt.new_string('window.wpEditorL10n = {\n\t\ttinymce: {\n\t\t\tbaseURL: ' +
		(rt.call_function('wp_json_encode', [rt.call_function('includes_url', [rt.new_string('js/tinymce')]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
		',\n\t\t\tsuffix: ' +
		if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '""' } else { '".min"' } +
		',\n\t\t\tsettings: ' + var_init_obj.str() + ',\n\t\t}\n\t}')
	rt.call_method(var_wp_scripts, 'add_inline_script', [
		rt.new_string('wp-block-library'),
		var_script.clone(),
		rt.new_string('before'),
	])
}

fn wp_default_packages(var_scripts rt.PhpVal) {
	wp_default_packages_vendor(var_scripts.clone())
	wp_register_development_scripts(var_scripts.clone())
	wp_register_tinymce_scripts(var_scripts.clone(), false)
	wp_default_packages_scripts(var_scripts.clone())
	if rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) {
		wp_default_packages_inline_scripts(var_scripts.clone())
	}
}

fn wp_scripts_get_suffix(type string) rt.PhpVal {
	mut var_type := type
	mut var_wp_version := rt.new_null()
	mut var_develop_src := rt.new_null()
	mut var_suffix := ''
	mut var_dev_suffix := ''
	mut var_suffixes := map[string]rt.PhpVal{}
	if rt.is_true(rt.identical(rt.new_null(), var_suffixes)) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php',
			'3')
		var_develop_src = rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
			var_wp_version.clone(),
			rt.new_string('-src'),
		]))))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('SCRIPT_DEBUG'),
		])))))
		{
			rt.call_function('define', [rt.new_string('SCRIPT_DEBUG'),
				var_develop_src.clone()])
		}
		var_suffix = if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
		var_dev_suffix = if rt.is_true(var_develop_src) { '' } else { '.min' }
		var_suffixes = {
			'suffix':     rt.new_string(var_suffix.str())
			'dev_suffix': rt.new_string(var_dev_suffix.str())
		}
	}
	if rt.is_true(rt.identical(rt.new_string('dev'), rt.new_string(type))) {
		return var_suffixes['dev_suffix']
	}
	return var_suffixes['suffix']
}

fn wp_default_scripts(var_scripts rt.PhpVal) {
	mut var_suffix := rt.new_null()
	mut var_dev_suffix := rt.new_null()
	mut var_guessurl := rt.new_null()
	mut var_guessed_url := false
	mut var_bulk_action_observer_ids := map[string]rt.PhpVal{}
	mut var_uploader_l10n := map[string]rt.PhpVal{}
	mut var_handle := rt.new_null()
	mut var_mejs_settings := map[string]rt.PhpVal{}
	mut var_user_id := rt.new_null()
	var_suffix = wp_scripts_get_suffix('')
	var_dev_suffix = wp_scripts_get_suffix('dev')
	var_guessurl = rt.call_function('site_url', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_guessurl)))) {
		var_guessed_url = true
		var_guessurl = rt.call_function('wp_guess_url', []rt.PhpVal{})
	}
	rt.set_property(var_scripts, 'base_url', var_guessurl.clone())
	rt.set_property(var_scripts, 'content_url', if rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CONTENT_URL'),
	]))
	{ rt.get_constant('WP_CONTENT_URL') } else { rt.new_string('') })
	rt.set_property(var_scripts, 'default_version', rt.call_function('get_bloginfo', [
		rt.new_string('version'),
	]))
	rt.set_property(var_scripts, 'default_dirs', rt.create_array([
		rt.ArrayItem{ key: none, val: '/wp-admin/js/' },
		rt.ArrayItem{ key: none, val: '/wp-includes/js/' },
	]))
	rt.call_method(var_scripts, 'add', [rt.new_string('utils'),
		rt.new_string('/wp-includes/js/utils${var_suffix.to_string()}.js')])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('utils'), rt.new_string('userSettings'), rt.create_array([rt.ArrayItem{
		key: 'url'
		val: (rt.get_constant('SITECOOKIEPATH')).str()
	}, rt.ArrayItem{ key: 'uid', val: (rt.call_function('get_current_user_id', []rt.PhpVal{})).str() }, rt.ArrayItem{
		key: 'time'
		val: (rt.call_function('time', []rt.PhpVal{})).str()
	}, rt.ArrayItem{
		key: 'secure'
		val: (rt.identical(rt.new_string('https'), rt.call_function('parse_url', [rt.call_function('site_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_SCHEME')]))).str()
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('common'),
		rt.new_string('/wp-admin/js/common${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'hoverIntent' }, rt.ArrayItem{ key: none, val: 'utils' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('common')])
	var_bulk_action_observer_ids = {
		'bulk_action': 'action'
		'changeit':    'new_role'
	}
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('common'), rt.new_string('bulkActionObserverIds'), rt.call_function('apply_filters', [rt.new_string('bulk_action_observer_ids'), rt.create_array_from_native_map(var_bulk_action_observer_ids)])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-sanitize'),
		rt.new_string('/wp-includes/js/wp-sanitize${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('sack'),
		rt.new_string('/wp-includes/js/tw-sack${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('1.6.1'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('quicktags'),
		rt.new_string('/wp-includes/js/quicktags${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('quicktags'), rt.new_string('quicktagsL10n'), rt.create_array([rt.ArrayItem{
		key: 'closeAllOpenTags'
		val: rt.call_function('__', [rt.new_string('Close all open tags')])
	}, rt.ArrayItem{ key: 'closeTags', val: rt.call_function('__', [rt.new_string('close tags')]) }, rt.ArrayItem{
		key: 'enterURL'
		val: rt.call_function('__', [rt.new_string('Enter the URL')])
	}, rt.ArrayItem{
		key: 'enterImageURL'
		val: rt.call_function('__', [rt.new_string('Enter the URL of the image')])
	}, rt.ArrayItem{
		key: 'enterImageDescription'
		val: rt.call_function('__', [rt.new_string('Enter a description of the image')])
	}, rt.ArrayItem{
		key: 'textdirection'
		val: rt.call_function('__', [rt.new_string('text direction')])
	}, rt.ArrayItem{
		key: 'toggleTextdirection'
		val: rt.call_function('__', [rt.new_string('Toggle Editor Text Direction')])
	}, rt.ArrayItem{
		key: 'dfw'
		val: rt.call_function('__', [rt.new_string('Distraction-free writing mode')])
	}, rt.ArrayItem{ key: 'strong', val: rt.call_function('__', [rt.new_string('Bold')]) }, rt.ArrayItem{
		key: 'strongClose'
		val: rt.call_function('__', [rt.new_string('Close bold tag')])
	}, rt.ArrayItem{ key: 'em', val: rt.call_function('__', [rt.new_string('Italic')]) }, rt.ArrayItem{
		key: 'emClose'
		val: rt.call_function('__', [rt.new_string('Close italic tag')])
	}, rt.ArrayItem{ key: 'link', val: rt.call_function('__', [rt.new_string('Insert link')]) }, rt.ArrayItem{
		key: 'blockquote'
		val: rt.call_function('__', [rt.new_string('Blockquote')])
	}, rt.ArrayItem{
		key: 'blockquoteClose'
		val: rt.call_function('__', [rt.new_string('Close blockquote tag')])
	}, rt.ArrayItem{
		key: 'del'
		val: rt.call_function('__', [rt.new_string('Deleted text (strikethrough)')])
	}, rt.ArrayItem{
		key: 'delClose'
		val: rt.call_function('__', [rt.new_string('Close deleted text tag')])
	}, rt.ArrayItem{ key: 'ins', val: rt.call_function('__', [rt.new_string('Inserted text')]) }, rt.ArrayItem{
		key: 'insClose'
		val: rt.call_function('__', [rt.new_string('Close inserted text tag')])
	}, rt.ArrayItem{ key: 'image', val: rt.call_function('__', [rt.new_string('Insert image')]) }, rt.ArrayItem{
		key: 'ul'
		val: rt.call_function('__', [rt.new_string('Bulleted list')])
	}, rt.ArrayItem{
		key: 'ulClose'
		val: rt.call_function('__', [rt.new_string('Close bulleted list tag')])
	}, rt.ArrayItem{ key: 'ol', val: rt.call_function('__', [rt.new_string('Numbered list')]) }, rt.ArrayItem{
		key: 'olClose'
		val: rt.call_function('__', [rt.new_string('Close numbered list tag')])
	}, rt.ArrayItem{ key: 'li', val: rt.call_function('__', [rt.new_string('List item')]) }, rt.ArrayItem{
		key: 'liClose'
		val: rt.call_function('__', [rt.new_string('Close list item tag')])
	}, rt.ArrayItem{ key: 'code', val: rt.call_function('__', [rt.new_string('Code')]) }, rt.ArrayItem{
		key: 'codeClose'
		val: rt.call_function('__', [rt.new_string('Close code tag')])
	}, rt.ArrayItem{
		key: 'more'
		val: rt.call_function('__', [rt.new_string('Insert Read More tag')])
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('colorpicker'),
		rt.new_string('/wp-includes/js/colorpicker${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'prototype' }]),
		rt.new_string('3517m')])
	rt.call_method(var_scripts, 'add', [rt.new_string('editor'),
		rt.new_string('/wp-admin/js/editor${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'utils' },
			rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('clipboard'),
		rt.new_string('/wp-includes/js/clipboard${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('2.0.11'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-ajax-response'),
		rt.new_string('/wp-includes/js/wp-ajax-response${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('wp-ajax-response'), rt.new_string('wpAjax'), rt.create_array([rt.ArrayItem{
		key: 'noPerm'
		val: rt.call_function('__', [rt.new_string('Sorry, you are not allowed to do that.')])
	}, rt.ArrayItem{
		key: 'broken'
		val: rt.call_function('__', [rt.new_string('An error occurred while processing your request. Please try again later.')])
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-api-request'),
		rt.new_string('/wp-includes/js/api-request${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('wp-api-request'), rt.new_string('wpApiSettings'), rt.create_array([rt.ArrayItem{
		key: 'root'
		val: rt.call_function('sanitize_url', [rt.call_function('get_rest_url', []rt.PhpVal{})])
	}, rt.ArrayItem{
		key: 'nonce'
		val: if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) { rt.new_string('') } else { rt.call_function('wp_create_nonce', [rt.new_string('wp_rest')]) }
	}, rt.ArrayItem{ key: 'versionString', val: 'wp/v2/' }])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-pointer'),
		rt.new_string('/wp-includes/js/wp-pointer${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('wp-pointer')])
	rt.call_method(var_scripts, 'add', [rt.new_string('autosave'),
		rt.new_string('/wp-includes/js/autosave${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'heartbeat' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('heartbeat'),
		rt.new_string('/wp-includes/js/heartbeat${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('heartbeat'), rt.new_string('heartbeatSettings'), rt.call_function('apply_filters', [rt.new_string('heartbeat_settings'), rt.new_array()])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-auth-check'),
		rt.new_string('/wp-includes/js/wp-auth-check${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'heartbeat' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('wp-auth-check')])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-lists'),
		rt.new_string('/wp-includes/js/wp-lists${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-ajax-response' },
			rt.ArrayItem{ key: none, val: 'jquery-color' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('site-icon'),
		rt.new_string('/wp-admin/js/site-icon.js'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'jquery' },
		]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('site-icon')])
	rt.call_method(var_scripts, 'add', [rt.new_string('prototype'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/prototype/1.7.1.0/prototype.js'),
		rt.new_array(), rt.new_string('1.7.1')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous-root'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/scriptaculous/1.9.0/scriptaculous.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'prototype' }]),
		rt.new_string('1.9.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous-builder'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/scriptaculous/1.9.0/builder.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'scriptaculous-root' }]),
		rt.new_string('1.9.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous-dragdrop'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/scriptaculous/1.9.0/dragdrop.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'scriptaculous-builder' },
			rt.ArrayItem{ key: none, val: 'scriptaculous-effects' }]),
		rt.new_string('1.9.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous-effects'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/scriptaculous/1.9.0/effects.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'scriptaculous-root' }]),
		rt.new_string('1.9.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous-slider'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/scriptaculous/1.9.0/slider.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'scriptaculous-effects' }]),
		rt.new_string('1.9.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous-sound'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/scriptaculous/1.9.0/sound.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'scriptaculous-root' }]),
		rt.new_string('1.9.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous-controls'),
		rt.new_string('https://ajax.googleapis.com/ajax/libs/scriptaculous/1.9.0/controls.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'scriptaculous-root' }]),
		rt.new_string('1.9.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('scriptaculous'),
		rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'scriptaculous-dragdrop' },
			rt.ArrayItem{ key: none, val: 'scriptaculous-slider' },
			rt.ArrayItem{ key: none, val: 'scriptaculous-controls' },
		])])
	rt.call_method(var_scripts, 'add', [rt.new_string('cropper'),
		rt.new_string('/wp-includes/js/crop/cropper.js'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'scriptaculous-dragdrop' },
		])])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery'),
		rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'jquery-core' },
			rt.ArrayItem{ key: none, val: 'jquery-migrate' },
		]),
		rt.new_string('3.7.1')])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-core'),
		rt.new_string('/wp-includes/js/jquery/jquery${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('3.7.1')])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-migrate'),
		rt.new_string('/wp-includes/js/jquery/jquery-migrate${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('3.4.1')])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-core'),
		rt.new_string('/wp-includes/js/jquery/ui/core${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-core'),
		rt.new_string('/wp-includes/js/jquery/ui/effect${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-blind'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-blind${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-bounce'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-bounce${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-clip'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-clip${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-drop'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-drop${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-explode'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-explode${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-fade'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-fade${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-fold'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-fold${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-highlight'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-highlight${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-puff'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-puff${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' },
			rt.ArrayItem{ key: none, val: 'jquery-effects-scale' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-pulsate'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-pulsate${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-scale'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-scale${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' },
			rt.ArrayItem{ key: none, val: 'jquery-effects-size' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-shake'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-shake${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-size'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-size${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-slide'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-slide${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-effects-transfer'),
		rt.new_string('/wp-includes/js/jquery/ui/effect-transfer${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-effects-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-accordion'),
		rt.new_string('/wp-includes/js/jquery/ui/accordion${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-autocomplete'),
		rt.new_string('/wp-includes/js/jquery/ui/autocomplete${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-menu' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-button'),
		rt.new_string('/wp-includes/js/jquery/ui/button${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-controlgroup' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-checkboxradio' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-datepicker'),
		rt.new_string('/wp-includes/js/jquery/ui/datepicker${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-dialog'),
		rt.new_string('/wp-includes/js/jquery/ui/dialog${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-resizable' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-draggable' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-button' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-menu'),
		rt.new_string('/wp-includes/js/jquery/ui/menu${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-mouse'),
		rt.new_string('/wp-includes/js/jquery/ui/mouse${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-progressbar'),
		rt.new_string('/wp-includes/js/jquery/ui/progressbar${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-selectmenu'),
		rt.new_string('/wp-includes/js/jquery/ui/selectmenu${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-menu' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-slider'),
		rt.new_string('/wp-includes/js/jquery/ui/slider${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-mouse' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-spinner'),
		rt.new_string('/wp-includes/js/jquery/ui/spinner${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-button' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-tabs'),
		rt.new_string('/wp-includes/js/jquery/ui/tabs${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-tooltip'),
		rt.new_string('/wp-includes/js/jquery/ui/tooltip${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-checkboxradio'),
		rt.new_string('/wp-includes/js/jquery/ui/checkboxradio${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-controlgroup'),
		rt.new_string('/wp-includes/js/jquery/ui/controlgroup${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-draggable'),
		rt.new_string('/wp-includes/js/jquery/ui/draggable${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-mouse' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-droppable'),
		rt.new_string('/wp-includes/js/jquery/ui/droppable${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-draggable' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-resizable'),
		rt.new_string('/wp-includes/js/jquery/ui/resizable${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-mouse' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-selectable'),
		rt.new_string('/wp-includes/js/jquery/ui/selectable${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-mouse' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-sortable'),
		rt.new_string('/wp-includes/js/jquery/ui/sortable${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-mouse' }]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-position'),
		rt.new_bool(false), rt.create_array([
			rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
		]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-ui-widget'),
		rt.new_bool(false), rt.create_array([
			rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
		]),
		rt.new_string('1.13.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-form'),
		rt.new_string('/wp-includes/js/jquery/jquery.form${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('4.3.0'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-color'),
		rt.new_string('/wp-includes/js/jquery/jquery.color.min.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('3.0.0'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('schedule'),
		rt.new_string('/wp-includes/js/jquery/jquery.schedule.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('20m'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-query'),
		rt.new_string('/wp-includes/js/jquery/jquery.query.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('2.2.3'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-serialize-object'),
		rt.new_string('/wp-includes/js/jquery/jquery.serialize-object.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('0.2-wp'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-hotkeys'),
		rt.new_string('/wp-includes/js/jquery/jquery.hotkeys${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('0.0.2m'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-table-hotkeys'),
		rt.new_string('/wp-includes/js/jquery/jquery.table-hotkeys${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'jquery-hotkeys' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-touch-punch'),
		rt.new_string('/wp-includes/js/jquery/jquery.ui.touch-punch.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-mouse' }]),
		rt.new_string('0.2.2'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('suggest'),
		rt.new_string('/wp-includes/js/jquery/suggest${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('1.1-20110113'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('imagesloaded'),
		rt.new_string('/wp-includes/js/imagesloaded.min.js'),
		rt.new_array(), rt.new_string('5.0.0'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('masonry'),
		rt.new_string('/wp-includes/js/masonry.min.js'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'imagesloaded' },
		]),
		rt.new_string('4.2.2'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('jquery-masonry'),
		rt.new_string('/wp-includes/js/jquery/jquery.masonry.min.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'masonry' }]),
		rt.new_string('3.1.2b'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('thickbox'),
		rt.new_string('/wp-includes/js/thickbox/thickbox.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('3.1-20121105'), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('thickbox'), rt.new_string('thickboxL10n'), rt.create_array([rt.ArrayItem{
		key: 'next'
		val: rt.call_function('__', [rt.new_string('Next &gt;')])
	}, rt.ArrayItem{ key: 'prev', val: rt.call_function('__', [rt.new_string('&lt; Prev')]) }, rt.ArrayItem{
		key: 'image'
		val: rt.call_function('__', [rt.new_string('Image')])
	}, rt.ArrayItem{ key: 'of', val: rt.call_function('__', [rt.new_string('of')]) }, rt.ArrayItem{
		key: 'close'
		val: rt.call_function('__', [rt.new_string('Close')])
	}, rt.ArrayItem{
		key: 'noiframes'
		val: rt.call_function('__', [rt.new_string('This feature requires inline frames. You have iframes disabled or your browser does not support them.')])
	}, rt.ArrayItem{
		key: 'loadingAnimation'
		val: rt.call_function('includes_url', [rt.new_string('js/thickbox/loadingAnimation.gif')])
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('jcrop'),
		rt.new_string('/wp-includes/js/jcrop/jquery.Jcrop.min.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('0.9.15')])
	var_uploader_l10n = {
		'queue_limit_exceeded':      rt.call_function('__', [
			rt.new_string('You have attempted to queue too many files.'),
		])
		'file_exceeds_size_limit':   rt.call_function('__', [
			rt.new_string('%s exceeds the maximum upload size for this site.'),
		])
		'zero_byte_file':            rt.call_function('__', [
			rt.new_string('This file is empty. Please try another.'),
		])
		'invalid_filetype':          rt.call_function('__', [
			rt.new_string('This file cannot be processed by the web server.'),
		])
		'not_an_image':              rt.call_function('__', [
			rt.new_string('This file is not an image. Please try another.'),
		])
		'image_memory_exceeded':     rt.call_function('__', [
			rt.new_string('Memory exceeded. Please try another smaller file.'),
		])
		'image_dimensions_exceeded': rt.call_function('__', [
			rt.new_string('This is larger than the maximum size. Please try another.'),
		])
		'default_error':             rt.call_function('__', [
			rt.new_string('An error occurred in the upload. Please try again later.'),
		])
		'missing_upload_url':        rt.call_function('__', [
			rt.new_string('There was a configuration error. Please contact the server administrator.'),
		])
		'upload_limit_exceeded':     rt.call_function('__', [
			rt.new_string('You may only upload 1 file.'),
		])
		'http_error':                rt.call_function('__', [
			rt.new_string('Unexpected response from the server. The file may have been uploaded successfully. Check in the Media Library or reload the page.'),
		])
		'http_error_image':          rt.call_function('__', [
			rt.new_string('The server cannot process the image. This can happen if the server is busy or does not have enough resources to complete the task. Uploading a smaller image may help. Suggested maximum size is 2560 pixels.'),
		])
		'upload_failed':             rt.call_function('__', [
			rt.new_string('Upload failed.'),
		])
		'big_upload_failed':         rt.call_function('__', [
			rt.new_string('Please try uploading this file with the %1$sbrowser uploader%2$s.'),
		])
		'big_upload_queued':         rt.call_function('__', [
			rt.new_string('%s exceeds the maximum upload size for the multi-file uploader when used in your browser.'),
		])
		'io_error':                  rt.call_function('__', [
			rt.new_string('IO error.')])
		'security_error':            rt.call_function('__', [
			rt.new_string('Security error.'),
		])
		'file_cancelled':            rt.call_function('__', [
			rt.new_string('File canceled.'),
		])
		'upload_stopped':            rt.call_function('__', [
			rt.new_string('Upload stopped.'),
		])
		'dismiss':                   rt.call_function('__', [
			rt.new_string('Dismiss')])
		'crunching':                 rt.call_function('__', [
			rt.new_string('Crunching&hellip;'),
		])
		'deleted':                   rt.call_function('__', [
			rt.new_string('moved to the Trash.'),
		])
		'error_uploading':           rt.call_function('__', [
			rt.new_string('&#8220;%s&#8221; has failed to upload.'),
		])
		'unsupported_image':         rt.call_function('__', [
			rt.new_string('This image cannot be displayed in a web browser. For best results convert it to JPEG before uploading.'),
		])
		'noneditable_image':         rt.call_function('__', [
			rt.new_string('The web server cannot generate responsive image sizes for this image. Convert it to JPEG or PNG before uploading.'),
		])
		'file_url_copied':           rt.call_function('__', [
			rt.new_string('The file URL has been copied to your clipboard'),
		])
	}
	rt.call_method(var_scripts, 'add', [rt.new_string('moxiejs'),
		rt.new_string('/wp-includes/js/plupload/moxie${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('1.3.5.1')])
	rt.call_method(var_scripts, 'add', [rt.new_string('plupload'),
		rt.new_string('/wp-includes/js/plupload/plupload${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'moxiejs' }]),
		rt.new_string('2.1.9')])
	mut iter_4 := rt.create_array([rt.ArrayItem{ key: none, val: 'all' },
		rt.ArrayItem{ key: none, val: 'html5' }, rt.ArrayItem{ key: none, val: 'flash' },
		rt.ArrayItem{ key: none, val: 'silverlight' }, rt.ArrayItem{ key: none, val: 'html4' }]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_handle_shadow := item_4.val
		rt.call_method(var_scripts, 'add', [
			rt.new_string('plupload-${var_handle.to_string()}'),
			rt.new_bool(false),
			rt.create_array([rt.ArrayItem{ key: none, val: 'plupload' }]),
			rt.new_string('2.1.1'),
		])
	}
	rt.call_method(var_scripts, 'add', [rt.new_string('plupload-handlers'),
		rt.new_string('/wp-includes/js/plupload/handlers${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'clipboard' },
			rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'plupload' },
			rt.ArrayItem{ key: none, val: 'underscore' }, rt.ArrayItem{ key: none, val: 'wp-a11y' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' }])])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('plupload-handlers'), rt.new_string('pluploadL10n'), rt.create_array_from_native_map(var_uploader_l10n)])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-plupload'),
		rt.new_string('/wp-includes/js/plupload/wp-plupload${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'plupload' },
			rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'media-models' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('wp-plupload'), rt.new_string('pluploadL10n'), rt.create_array_from_native_map(var_uploader_l10n)])))
	rt.call_method(var_scripts, 'add', [rt.new_string('comment-reply'),
		rt.new_string('/wp-includes/js/comment-reply${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_bool(false), rt.new_int(1)])
	if rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) {
		rt.call_method(var_scripts, 'add_data', [rt.new_string('comment-reply'),
			rt.new_string('strategy'), rt.new_string('async')])
		rt.call_method(var_scripts, 'add_data', [rt.new_string('comment-reply'),
			rt.new_string('fetchpriority'), rt.new_string('low')])
	}
	rt.call_method(var_scripts, 'add', [rt.new_string('json2'),
		rt.new_string('/wp-includes/js/json2${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('2015-05-03')])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'add_data', [rt.new_string('json2'), rt.new_string('conditional'), rt.new_string('_required-conditional-dependency_')])))
	rt.call_method(var_scripts, 'add', [rt.new_string('underscore'),
		rt.new_string('/wp-includes/js/underscore${var_dev_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('1.13.8'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('backbone'),
		rt.new_string('/wp-includes/js/backbone${var_dev_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'underscore' },
			rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('1.6.1'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-util'),
		rt.new_string('/wp-includes/js/wp-util${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'underscore' },
			rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('wp-util'), rt.new_string('_wpUtilSettings'), rt.create_array([rt.ArrayItem{
		key: 'ajax'
		val: rt.create_array([rt.ArrayItem{
			key: 'url'
			val: rt.call_function('admin_url', [rt.new_string('admin-ajax.php'), rt.new_string('relative')])
		}])
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-backbone'),
		rt.new_string('/wp-includes/js/wp-backbone${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'backbone' },
			rt.ArrayItem{ key: none, val: 'wp-util' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('revisions'),
		rt.new_string('/wp-admin/js/revisions${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-backbone' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-slider' },
			rt.ArrayItem{ key: none, val: 'hoverIntent' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('imgareaselect'),
		rt.new_string('/wp-includes/js/imgareaselect/jquery.imgareaselect${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('mediaelement'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'mediaelement-core' },
			rt.ArrayItem{ key: none, val: 'mediaelement-migrate' }]),
		rt.new_string('4.2.17'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('mediaelement-core'),
		rt.new_string('/wp-includes/js/mediaelement/mediaelement-and-player${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('4.2.17'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('mediaelement-migrate'),
		rt.new_string('/wp-includes/js/mediaelement/mediaelement-migrate${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('mediaelement-core'), rt.call_function('sprintf', [rt.new_string('var mejsL10n = %s;'), rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{
		key: 'language'
		val: rt.call_function('strtok', [rt.call_function('determine_locale', []rt.PhpVal{}), rt.new_string('_-')]).to_string().to_lower()
	}, rt.ArrayItem{ key: 'strings', val: rt.create_array([rt.ArrayItem{
		key: 'mejs.download-file'
		val: rt.call_function('__', [rt.new_string('Download File')])
	}, rt.ArrayItem{
		key: 'mejs.install-flash'
		val: rt.call_function('__', [rt.new_string('You are using a browser that does not have Flash player enabled or installed. Please turn on your Flash player plugin or download the latest version from https://get.adobe.com/flashplayer/')])
	}, rt.ArrayItem{
		key: 'mejs.fullscreen'
		val: rt.call_function('__', [rt.new_string('Fullscreen')])
	}, rt.ArrayItem{ key: 'mejs.play', val: rt.call_function('__', [rt.new_string('Play')]) }, rt.ArrayItem{
		key: 'mejs.pause'
		val: rt.call_function('__', [rt.new_string('Pause')])
	}, rt.ArrayItem{
		key: 'mejs.time-slider'
		val: rt.call_function('__', [rt.new_string('Time Slider')])
	}, rt.ArrayItem{
		key: 'mejs.time-help-text'
		val: rt.call_function('__', [rt.new_string('Use Left/Right Arrow keys to advance one second, Up/Down arrows to advance ten seconds.')])
	}, rt.ArrayItem{
		key: 'mejs.live-broadcast'
		val: rt.call_function('__', [rt.new_string('Live Broadcast')])
	}, rt.ArrayItem{
		key: 'mejs.volume-help-text'
		val: rt.call_function('__', [rt.new_string('Use Up/Down Arrow keys to increase or decrease volume.')])
	}, rt.ArrayItem{ key: 'mejs.unmute', val: rt.call_function('__', [rt.new_string('Unmute')]) }, rt.ArrayItem{
		key: 'mejs.mute'
		val: rt.call_function('__', [rt.new_string('Mute')])
	}, rt.ArrayItem{
		key: 'mejs.volume-slider'
		val: rt.call_function('__', [rt.new_string('Volume Slider')])
	}, rt.ArrayItem{
		key: 'mejs.video-player'
		val: rt.call_function('__', [rt.new_string('Video Player')])
	}, rt.ArrayItem{
		key: 'mejs.audio-player'
		val: rt.call_function('__', [rt.new_string('Audio Player')])
	}, rt.ArrayItem{
		key: 'mejs.captions-subtitles'
		val: rt.call_function('__', [rt.new_string('Captions/Subtitles')])
	}, rt.ArrayItem{
		key: 'mejs.captions-chapters'
		val: rt.call_function('__', [rt.new_string('Chapters')])
	}, rt.ArrayItem{ key: 'mejs.none', val: rt.call_function('__', [rt.new_string('None')]) }, rt.ArrayItem{
		key: 'mejs.afrikaans'
		val: rt.call_function('__', [rt.new_string('Afrikaans')])
	}, rt.ArrayItem{ key: 'mejs.albanian', val: rt.call_function('__', [rt.new_string('Albanian')]) }, rt.ArrayItem{
		key: 'mejs.arabic'
		val: rt.call_function('__', [rt.new_string('Arabic')])
	}, rt.ArrayItem{
		key: 'mejs.belarusian'
		val: rt.call_function('__', [rt.new_string('Belarusian')])
	}, rt.ArrayItem{
		key: 'mejs.bulgarian'
		val: rt.call_function('__', [rt.new_string('Bulgarian')])
	}, rt.ArrayItem{ key: 'mejs.catalan', val: rt.call_function('__', [rt.new_string('Catalan')]) }, rt.ArrayItem{
		key: 'mejs.chinese'
		val: rt.call_function('__', [rt.new_string('Chinese')])
	}, rt.ArrayItem{
		key: 'mejs.chinese-simplified'
		val: rt.call_function('__', [rt.new_string('Chinese (Simplified)')])
	}, rt.ArrayItem{
		key: 'mejs.chinese-traditional'
		val: rt.call_function('__', [rt.new_string('Chinese (Traditional)')])
	}, rt.ArrayItem{ key: 'mejs.croatian', val: rt.call_function('__', [rt.new_string('Croatian')]) }, rt.ArrayItem{
		key: 'mejs.czech'
		val: rt.call_function('__', [rt.new_string('Czech')])
	}, rt.ArrayItem{ key: 'mejs.danish', val: rt.call_function('__', [rt.new_string('Danish')]) }, rt.ArrayItem{
		key: 'mejs.dutch'
		val: rt.call_function('__', [rt.new_string('Dutch')])
	}, rt.ArrayItem{ key: 'mejs.english', val: rt.call_function('__', [rt.new_string('English')]) }, rt.ArrayItem{
		key: 'mejs.estonian'
		val: rt.call_function('__', [rt.new_string('Estonian')])
	}, rt.ArrayItem{ key: 'mejs.filipino', val: rt.call_function('__', [rt.new_string('Filipino')]) }, rt.ArrayItem{
		key: 'mejs.finnish'
		val: rt.call_function('__', [rt.new_string('Finnish')])
	}, rt.ArrayItem{ key: 'mejs.french', val: rt.call_function('__', [rt.new_string('French')]) }, rt.ArrayItem{
		key: 'mejs.galician'
		val: rt.call_function('__', [rt.new_string('Galician')])
	}, rt.ArrayItem{ key: 'mejs.german', val: rt.call_function('__', [rt.new_string('German')]) }, rt.ArrayItem{
		key: 'mejs.greek'
		val: rt.call_function('__', [rt.new_string('Greek')])
	}, rt.ArrayItem{
		key: 'mejs.haitian-creole'
		val: rt.call_function('__', [rt.new_string('Haitian Creole')])
	}, rt.ArrayItem{ key: 'mejs.hebrew', val: rt.call_function('__', [rt.new_string('Hebrew')]) }, rt.ArrayItem{
		key: 'mejs.hindi'
		val: rt.call_function('__', [rt.new_string('Hindi')])
	}, rt.ArrayItem{
		key: 'mejs.hungarian'
		val: rt.call_function('__', [rt.new_string('Hungarian')])
	}, rt.ArrayItem{
		key: 'mejs.icelandic'
		val: rt.call_function('__', [rt.new_string('Icelandic')])
	}, rt.ArrayItem{
		key: 'mejs.indonesian'
		val: rt.call_function('__', [rt.new_string('Indonesian')])
	}, rt.ArrayItem{ key: 'mejs.irish', val: rt.call_function('__', [rt.new_string('Irish')]) }, rt.ArrayItem{
		key: 'mejs.italian'
		val: rt.call_function('__', [rt.new_string('Italian')])
	}, rt.ArrayItem{ key: 'mejs.japanese', val: rt.call_function('__', [rt.new_string('Japanese')]) }, rt.ArrayItem{
		key: 'mejs.korean'
		val: rt.call_function('__', [rt.new_string('Korean')])
	}, rt.ArrayItem{ key: 'mejs.latvian', val: rt.call_function('__', [rt.new_string('Latvian')]) }, rt.ArrayItem{
		key: 'mejs.lithuanian'
		val: rt.call_function('__', [rt.new_string('Lithuanian')])
	}, rt.ArrayItem{
		key: 'mejs.macedonian'
		val: rt.call_function('__', [rt.new_string('Macedonian')])
	}, rt.ArrayItem{ key: 'mejs.malay', val: rt.call_function('__', [rt.new_string('Malay')]) }, rt.ArrayItem{
		key: 'mejs.maltese'
		val: rt.call_function('__', [rt.new_string('Maltese')])
	}, rt.ArrayItem{
		key: 'mejs.norwegian'
		val: rt.call_function('__', [rt.new_string('Norwegian')])
	}, rt.ArrayItem{ key: 'mejs.persian', val: rt.call_function('__', [rt.new_string('Persian')]) }, rt.ArrayItem{
		key: 'mejs.polish'
		val: rt.call_function('__', [rt.new_string('Polish')])
	}, rt.ArrayItem{
		key: 'mejs.portuguese'
		val: rt.call_function('__', [rt.new_string('Portuguese')])
	}, rt.ArrayItem{ key: 'mejs.romanian', val: rt.call_function('__', [rt.new_string('Romanian')]) }, rt.ArrayItem{
		key: 'mejs.russian'
		val: rt.call_function('__', [rt.new_string('Russian')])
	}, rt.ArrayItem{ key: 'mejs.serbian', val: rt.call_function('__', [rt.new_string('Serbian')]) }, rt.ArrayItem{
		key: 'mejs.slovak'
		val: rt.call_function('__', [rt.new_string('Slovak')])
	}, rt.ArrayItem{
		key: 'mejs.slovenian'
		val: rt.call_function('__', [rt.new_string('Slovenian')])
	}, rt.ArrayItem{ key: 'mejs.spanish', val: rt.call_function('__', [rt.new_string('Spanish')]) }, rt.ArrayItem{
		key: 'mejs.swahili'
		val: rt.call_function('__', [rt.new_string('Swahili')])
	}, rt.ArrayItem{ key: 'mejs.swedish', val: rt.call_function('__', [rt.new_string('Swedish')]) }, rt.ArrayItem{
		key: 'mejs.tagalog'
		val: rt.call_function('__', [rt.new_string('Tagalog')])
	}, rt.ArrayItem{ key: 'mejs.thai', val: rt.call_function('__', [rt.new_string('Thai')]) }, rt.ArrayItem{
		key: 'mejs.turkish'
		val: rt.call_function('__', [rt.new_string('Turkish')])
	}, rt.ArrayItem{
		key: 'mejs.ukrainian'
		val: rt.call_function('__', [rt.new_string('Ukrainian')])
	}, rt.ArrayItem{
		key: 'mejs.vietnamese'
		val: rt.call_function('__', [rt.new_string('Vietnamese')])
	}, rt.ArrayItem{ key: 'mejs.welsh', val: rt.call_function('__', [rt.new_string('Welsh')]) }, rt.ArrayItem{
		key: 'mejs.yiddish'
		val: rt.call_function('__', [rt.new_string('Yiddish')])
	}]) }]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('before')])))
	rt.call_method(var_scripts, 'add', [rt.new_string('mediaelement-vimeo'),
		rt.new_string('/wp-includes/js/mediaelement/renderers/vimeo.min.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'mediaelement' }]),
		rt.new_string('4.2.17'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-mediaelement'),
		rt.new_string('/wp-includes/js/mediaelement/wp-mediaelement${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'mediaelement' }]),
		rt.new_bool(false), rt.new_int(1)])
	var_mejs_settings = {
		'pluginPath':            rt.call_function('includes_url', [
			rt.new_string('js/mediaelement/'),
			rt.new_string('relative'),
		])
		'classPrefix':           rt.new_string('mejs-')
		'stretching':            rt.new_string('responsive')
		'audioShortcodeLibrary': rt.call_function('apply_filters', [
			rt.new_string('wp_audio_shortcode_library'),
			rt.new_string('mediaelement'),
		])
		'videoShortcodeLibrary': rt.call_function('apply_filters', [
			rt.new_string('wp_video_shortcode_library'),
			rt.new_string('mediaelement'),
		])
	}
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('mediaelement'), rt.new_string('_wpmejsSettings'), rt.call_function('apply_filters', [rt.new_string('mejs_settings'), rt.create_array_from_native_map(var_mejs_settings)])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-codemirror'),
		rt.new_string('/wp-includes/js/codemirror/codemirror.min.js'),
		rt.new_array(), rt.new_string('5.65.20')])
	rt.call_method(var_scripts, 'add', [rt.new_string('csslint'),
		rt.new_string('/wp-includes/js/codemirror/csslint.js'),
		rt.new_array(), rt.new_string('1.0.5')])
	rt.call_method(var_scripts, 'add', [rt.new_string('esprima'),
		rt.new_string('/wp-includes/js/codemirror/esprima.js'),
		rt.new_array(), rt.new_string('4.0.1')])
	rt.call_method(var_scripts, 'add', [rt.new_string('jshint'),
		rt.new_string('/wp-includes/js/codemirror/fakejshint.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'esprima' }]),
		rt.new_string('2.9.5')])
	rt.call_method(var_scripts, 'add', [rt.new_string('jsonlint'),
		rt.new_string('/wp-includes/js/codemirror/jsonlint.js'),
		rt.new_array(), rt.new_string('1.6.3')])
	rt.call_method(var_scripts, 'add', [rt.new_string('htmlhint'),
		rt.new_string('/wp-includes/js/codemirror/htmlhint.js'),
		rt.new_array(), rt.new_string('1.8.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('htmlhint-kses'),
		rt.new_string('/wp-includes/js/codemirror/htmlhint-kses.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'htmlhint' }])])
	rt.call_method(var_scripts, 'add', [rt.new_string('code-editor'),
		rt.new_string('/wp-admin/js/code-editor${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-codemirror' }, rt.ArrayItem{
				key: none
				val: 'underscore'
			}])])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-theme-plugin-editor'),
		rt.new_string('/wp-admin/js/theme-plugin-editor${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'common' },
			rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'wp-sanitize' },
			rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{ key: none, val: 'underscore' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [
		rt.new_string('wp-theme-plugin-editor'),
	])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-playlist'),
		rt.new_string('/wp-includes/js/mediaelement/wp-playlist${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-util' },
			rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'mediaelement' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('zxcvbn-async'),
		rt.new_string('/wp-includes/js/zxcvbn-async${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_string('1.0')])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('zxcvbn-async'), rt.new_string('_zxcvbnSettings'), rt.create_array([rt.ArrayItem{
		key: 'src'
		val: if !var_guessed_url { rt.call_function('includes_url', [rt.new_string('/js/zxcvbn.min.js')]) } else { (rt.get_property(var_scripts, 'base_url')).str() + '/wp-includes/js/zxcvbn.min.js' }
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('password-strength-meter'),
		rt.new_string('/wp-admin/js/password-strength-meter${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'zxcvbn-async' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('password-strength-meter'), rt.new_string('pwsL10n'), rt.create_array([rt.ArrayItem{
		key: 'unknown'
		val: rt.call_function('_x', [rt.new_string('Password strength unknown'), rt.new_string('password strength')])
	}, rt.ArrayItem{
		key: 'short'
		val: rt.call_function('_x', [rt.new_string('Very weak'), rt.new_string('password strength')])
	}, rt.ArrayItem{
		key: 'bad'
		val: rt.call_function('_x', [rt.new_string('Weak'), rt.new_string('password strength')])
	}, rt.ArrayItem{
		key: 'good'
		val: rt.call_function('_x', [rt.new_string('Medium'), rt.new_string('password strength')])
	}, rt.ArrayItem{
		key: 'strong'
		val: rt.call_function('_x', [rt.new_string('Strong'), rt.new_string('password strength')])
	}, rt.ArrayItem{
		key: 'mismatch'
		val: rt.call_function('_x', [rt.new_string('Mismatch'), rt.new_string('password mismatch')])
	}])])))
	rt.call_method(var_scripts, 'set_translations', [
		rt.new_string('password-strength-meter'),
	])
	rt.call_method(var_scripts, 'add', [rt.new_string('password-toggle'),
		rt.new_string('/wp-admin/js/password-toggle${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('password-toggle')])
	rt.call_method(var_scripts, 'add', [rt.new_string('application-passwords'),
		rt.new_string('/wp-admin/js/application-passwords${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{
				key: none
				val: 'wp-api-request'
			}, rt.ArrayItem{ key: none, val: 'wp-date' }, rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [
		rt.new_string('application-passwords'),
	])
	rt.call_method(var_scripts, 'add', [rt.new_string('auth-app'),
		rt.new_string('/wp-admin/js/auth-app${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-api-request' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' }, rt.ArrayItem{ key: none, val: 'wp-hooks' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('auth-app')])
	rt.call_method(var_scripts, 'add', [rt.new_string('user-profile'),
		rt.new_string('/wp-admin/js/user-profile${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'clipboard' },
			rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{
				key: none
				val: 'password-strength-meter'
			}, rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('user-profile')])
	var_user_id = rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('user_id')) {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('user_id'))).to_i64())
	} else {
		0
	})
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('user-profile'), rt.new_string('userProfileL10n'), rt.create_array([rt.ArrayItem{
		key: 'user_id'
		val: var_user_id
	}, rt.ArrayItem{
		key: 'nonce'
		val: if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) { rt.new_string('') } else { rt.call_function('wp_create_nonce', [rt.new_string('reset-password-for-' + var_user_id.str())]) }
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('language-chooser'),
		rt.new_string('/wp-admin/js/language-chooser${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('user-suggest'),
		rt.new_string('/wp-admin/js/user-suggest${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-autocomplete' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('admin-bar'),
		rt.new_string('/wp-includes/js/admin-bar${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'hoverintent-js' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('wplink'),
		rt.new_string('/wp-includes/js/wplink${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'common' },
			rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-a11y' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('wplink')])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('wplink'), rt.new_string('wpLinkL10n'), rt.create_array([rt.ArrayItem{
		key: 'title'
		val: rt.call_function('__', [rt.new_string('Insert/edit link')])
	}, rt.ArrayItem{ key: 'update', val: rt.call_function('__', [rt.new_string('Update')]) }, rt.ArrayItem{
		key: 'save'
		val: rt.call_function('__', [rt.new_string('Add Link')])
	}, rt.ArrayItem{ key: 'noTitle', val: rt.call_function('__', [rt.new_string('(no title)')]) }, rt.ArrayItem{
		key: 'noMatchesFound'
		val: rt.call_function('__', [rt.new_string('No results found.')])
	}, rt.ArrayItem{
		key: 'linkSelected'
		val: rt.call_function('__', [rt.new_string('Link selected.')])
	}, rt.ArrayItem{
		key: 'linkInserted'
		val: rt.call_function('__', [rt.new_string('Link inserted.')])
	}, rt.ArrayItem{
		key: 'minInputLength'
		val: rt.new_int((rt.call_function('_x', [rt.new_string('3'), rt.new_string('minimum input length for searching post links')])).to_i64())
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wpdialogs'),
		rt.new_string('/wp-includes/js/wpdialog${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-dialog' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('word-count'),
		rt.new_string('/wp-admin/js/word-count${var_suffix.to_string()}.js'),
		rt.new_array(), rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('media-upload'),
		rt.new_string('/wp-admin/js/media-upload${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'thickbox' },
			rt.ArrayItem{ key: none, val: 'shortcode' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('hoverIntent'),
		rt.new_string('/wp-includes/js/hoverIntent${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_string('1.10.2'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('hoverintent-js'),
		rt.new_string('/wp-includes/js/hoverintent-js.min.js'),
		rt.new_array(), rt.new_string('2.2.1'), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-base'),
		rt.new_string('/wp-includes/js/customize-base${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'underscore' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-loader'),
		rt.new_string('/wp-includes/js/customize-loader${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'customize-base' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-preview'),
		rt.new_string('/wp-includes/js/customize-preview${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-a11y' },
			rt.ArrayItem{ key: none, val: 'customize-base' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-models'),
		rt.new_string('/wp-includes/js/customize-models.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'underscore' },
			rt.ArrayItem{ key: none, val: 'backbone' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-views'),
		rt.new_string('/wp-includes/js/customize-views.js'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'underscore' },
			rt.ArrayItem{ key: none, val: 'imgareaselect' },
			rt.ArrayItem{ key: none, val: 'customize-models' },
			rt.ArrayItem{ key: none, val: 'media-editor' },
			rt.ArrayItem{ key: none, val: 'media-views' },
		]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-controls'),
		rt.new_string('/wp-admin/js/customize-controls${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'customize-base' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{ key: none, val: 'wp-util' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-core' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('customize-controls'), rt.new_string('_wpCustomizeControlsL10n'), rt.create_array([rt.ArrayItem{
		key: 'activate'
		val: rt.call_function('__', [rt.new_string('Activate &amp; Publish')])
	}, rt.ArrayItem{ key: 'save', val: rt.call_function('__', [rt.new_string('Save &amp; Publish')]) }, rt.ArrayItem{
		key: 'publish'
		val: rt.call_function('__', [rt.new_string('Publish')])
	}, rt.ArrayItem{ key: 'published', val: rt.call_function('__', [rt.new_string('Published')]) }, rt.ArrayItem{
		key: 'saveDraft'
		val: rt.call_function('__', [rt.new_string('Save Draft')])
	}, rt.ArrayItem{ key: 'draftSaved', val: rt.call_function('__', [rt.new_string('Draft Saved')]) }, rt.ArrayItem{
		key: 'updating'
		val: rt.call_function('__', [rt.new_string('Updating')])
	}, rt.ArrayItem{
		key: 'schedule'
		val: rt.call_function('_x', [rt.new_string('Schedule'), rt.new_string('customizer changeset action/button label')])
	}, rt.ArrayItem{
		key: 'scheduled'
		val: rt.call_function('_x', [rt.new_string('Scheduled'), rt.new_string('customizer changeset status')])
	}, rt.ArrayItem{ key: 'invalid', val: rt.call_function('__', [rt.new_string('Invalid')]) }, rt.ArrayItem{
		key: 'saveBeforeShare'
		val: rt.call_function('__', [rt.new_string('Please save your changes in order to share the preview.')])
	}, rt.ArrayItem{
		key: 'futureDateError'
		val: rt.call_function('__', [rt.new_string('You must supply a future date to schedule.')])
	}, rt.ArrayItem{
		key: 'saveAlert'
		val: rt.call_function('__', [rt.new_string('The changes you made will be lost if you navigate away from this page.')])
	}, rt.ArrayItem{ key: 'saved', val: rt.call_function('__', [rt.new_string('Saved')]) }, rt.ArrayItem{
		key: 'cancel'
		val: rt.call_function('__', [rt.new_string('Cancel')])
	}, rt.ArrayItem{ key: 'close', val: rt.call_function('__', [rt.new_string('Close')]) }, rt.ArrayItem{
		key: 'action'
		val: rt.call_function('__', [rt.new_string('Action')])
	}, rt.ArrayItem{
		key: 'discardChanges'
		val: rt.call_function('__', [rt.new_string('Discard changes')])
	}, rt.ArrayItem{
		key: 'cheatin'
		val: rt.call_function('__', [rt.new_string('An error occurred. Please try again later.')])
	}, rt.ArrayItem{
		key: 'notAllowedHeading'
		val: rt.call_function('__', [rt.new_string('You need a higher level of permission.')])
	}, rt.ArrayItem{
		key: 'notAllowed'
		val: rt.call_function('__', [rt.new_string('Sorry, you are not allowed to customize this site.')])
	}, rt.ArrayItem{
		key: 'previewIframeTitle'
		val: rt.call_function('__', [rt.new_string('Site Preview')])
	}, rt.ArrayItem{
		key: 'loginIframeTitle'
		val: rt.call_function('__', [rt.new_string('Session expired')])
	}, rt.ArrayItem{
		key: 'collapseSidebar'
		val: rt.call_function('_x', [rt.new_string('Hide Controls'), rt.new_string('label for hide controls button without length constraints')])
	}, rt.ArrayItem{
		key: 'expandSidebar'
		val: rt.call_function('_x', [rt.new_string('Show Controls'), rt.new_string('label for hide controls button without length constraints')])
	}, rt.ArrayItem{
		key: 'untitledBlogName'
		val: rt.call_function('__', [rt.new_string('(Untitled)')])
	}, rt.ArrayItem{
		key: 'unknownRequestFail'
		val: rt.call_function('__', [rt.new_string('Looks like something&#8217;s gone wrong. Wait a couple seconds, and then try again.')])
	}, rt.ArrayItem{
		key: 'themeDownloading'
		val: rt.call_function('__', [rt.new_string('Downloading your new theme&hellip;')])
	}, rt.ArrayItem{
		key: 'themePreviewWait'
		val: rt.call_function('__', [rt.new_string('Setting up your live preview. This may take a bit.')])
	}, rt.ArrayItem{
		key: 'revertingChanges'
		val: rt.call_function('__', [rt.new_string('Reverting unpublished changes&hellip;')])
	}, rt.ArrayItem{
		key: 'trashConfirm'
		val: rt.call_function('__', [rt.new_string('Are you sure you want to discard your unpublished changes?')])
	}, rt.ArrayItem{
		key: 'takenOverMessage'
		val: rt.call_function('__', [rt.new_string('%s has taken over and is currently customizing.')])
	}, rt.ArrayItem{
		key: 'autosaveNotice'
		val: rt.call_function('__', [rt.new_string('There is a more recent autosave of your changes than the one you are previewing. <a href="%s">Restore the autosave</a>')])
	}, rt.ArrayItem{
		key: 'videoHeaderNotice'
		val: rt.call_function('__', [rt.new_string('This theme does not support video headers on this page. Navigate to the front page or another page that supports video headers.')])
	}, rt.ArrayItem{
		key: 'allowedFiles'
		val: rt.call_function('__', [rt.new_string('Allowed Files')])
	}, rt.ArrayItem{ key: 'customCssError', val: rt.create_array([rt.ArrayItem{
		key: 'singular'
		val: rt.call_function('_n', [rt.new_string('There is %d error which must be fixed before you can save.'), rt.new_string('There are %d errors which must be fixed before you can save.'), rt.new_int(1)])
	}, rt.ArrayItem{
		key: 'plural'
		val: rt.call_function('_n', [rt.new_string('There is %d error which must be fixed before you can save.'), rt.new_string('There are %d errors which must be fixed before you can save.'), rt.new_int(2)])
	}]) }, rt.ArrayItem{
		key: 'pageOnFrontError'
		val: rt.call_function('__', [rt.new_string('Homepage and posts page must be different.')])
	}, rt.ArrayItem{ key: 'saveBlockedError', val: rt.create_array([rt.ArrayItem{
		key: 'singular'
		val: rt.call_function('_n', [rt.new_string('Unable to save due to %s invalid setting.'), rt.new_string('Unable to save due to %s invalid settings.'), rt.new_int(1)])
	}, rt.ArrayItem{
		key: 'plural'
		val: rt.call_function('_n', [rt.new_string('Unable to save due to %s invalid setting.'), rt.new_string('Unable to save due to %s invalid settings.'), rt.new_int(2)])
	}]) }, rt.ArrayItem{
		key: 'scheduleDescription'
		val: rt.call_function('__', [rt.new_string('Schedule your customization changes to publish ("go live") at a future date.')])
	}, rt.ArrayItem{
		key: 'themePreviewUnavailable'
		val: rt.call_function('__', [rt.new_string('Sorry, you cannot preview new themes when you have changes scheduled or saved as a draft. Please publish your changes, or wait until they publish to preview new themes.')])
	}, rt.ArrayItem{
		key: 'themeInstallUnavailable'
		val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('You will not be able to install new themes from here yet since your install requires SFTP credentials. For now, please <a href="%s">add themes in the admin</a>.')]), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('theme-install.php')])])])
	}, rt.ArrayItem{
		key: 'publishSettings'
		val: rt.call_function('__', [rt.new_string('Publish Settings')])
	}, rt.ArrayItem{
		key: 'invalidDate'
		val: rt.call_function('__', [rt.new_string('Invalid date.')])
	}, rt.ArrayItem{
		key: 'invalidValue'
		val: rt.call_function('__', [rt.new_string('Invalid value.')])
	}, rt.ArrayItem{
		key: 'blockThemeNotification'
		val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Hurray! Your theme supports site editing with blocks. <a href="%1$s">Tell me more</a>. %2$s')]), rt.call_function('__', [rt.new_string('https://wordpress.org/documentation/article/site-editor/')]), rt.call_function('sprintf', [rt.new_string('<button type="button" data-action="%1$s" class="button switch-to-editor">%2$s</button>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('site-editor.php')])]), rt.call_function('__', [rt.new_string('Use Site Editor')])])])
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-selective-refresh'),
		rt.new_string('/wp-includes/js/customize-selective-refresh${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{
				key: none
				val: 'customize-preview'
			}]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-widgets'),
		rt.new_string('/wp-admin/js/customize-widgets${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
			rt.ArrayItem{ key: none, val: 'jquery-ui-droppable' },
			rt.ArrayItem{ key: none, val: 'wp-backbone' }, rt.ArrayItem{
				key: none
				val: 'customize-controls'
			}]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-preview-widgets'),
		rt.new_string('/wp-includes/js/customize-preview-widgets${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{
				key: none
				val: 'customize-preview'
			}, rt.ArrayItem{ key: none, val: 'customize-selective-refresh' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-nav-menus'),
		rt.new_string('/wp-admin/js/customize-nav-menus${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-backbone' }, rt.ArrayItem{
				key: none
				val: 'customize-controls'
			}, rt.ArrayItem{ key: none, val: 'accordion' }, rt.ArrayItem{ key: none, val: 'nav-menu' },
			rt.ArrayItem{ key: none, val: 'wp-sanitize' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('customize-preview-nav-menus'),
		rt.new_string('/wp-includes/js/customize-preview-nav-menus${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{
				key: none
				val: 'customize-preview'
			}, rt.ArrayItem{ key: none, val: 'customize-selective-refresh' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-custom-header'),
		rt.new_string('/wp-includes/js/wp-custom-header${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('accordion'),
		rt.new_string('/wp-admin/js/accordion${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('shortcode'),
		rt.new_string('/wp-includes/js/shortcode${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'underscore' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('media-models'),
		rt.new_string('/wp-includes/js/media-models${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-backbone' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('media-models'), rt.new_string('_wpMediaModelsL10n'), rt.create_array([rt.ArrayItem{
		key: 'settings'
		val: rt.create_array([rt.ArrayItem{
			key: 'ajaxurl'
			val: rt.call_function('admin_url', [rt.new_string('admin-ajax.php'), rt.new_string('relative')])
		}, rt.ArrayItem{ key: 'post', val: rt.create_array([rt.ArrayItem{ key: 'id', val: 0 }]) }])
	}])])))
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-embed'),
		rt.new_string('/wp-includes/js/wp-embed${var_suffix.to_string()}.js')])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_scripts, 'add_data', [rt.new_string('wp-embed'), rt.new_string('strategy'), rt.new_string('defer')])))
	rt.call_method(var_scripts, 'add', [rt.new_string('media-views'),
		rt.new_string('/wp-includes/js/media-views${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'utils' },
			rt.ArrayItem{ key: none, val: 'media-models' }, rt.ArrayItem{
				key: none
				val: 'wp-plupload'
			}, rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
			rt.ArrayItem{ key: none, val: 'wp-mediaelement' },
			rt.ArrayItem{ key: none, val: 'wp-api-request' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{ key: none, val: 'clipboard' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('media-views')])
	rt.call_method(var_scripts, 'add', [rt.new_string('media-editor'),
		rt.new_string('/wp-includes/js/media-editor${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'shortcode' },
			rt.ArrayItem{ key: none, val: 'media-views' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'set_translations', [rt.new_string('media-editor')])
	rt.call_method(var_scripts, 'add', [rt.new_string('media-audiovideo'),
		rt.new_string('/wp-includes/js/media-audiovideo${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'media-editor' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('mce-view'),
		rt.new_string('/wp-includes/js/mce-view${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'shortcode' },
			rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'media-views' },
			rt.ArrayItem{ key: none, val: 'media-audiovideo' }]),
		rt.new_bool(false), rt.new_int(1)])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-api'),
		rt.new_string('/wp-includes/js/wp-api${var_suffix.to_string()}.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
			rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'underscore' },
			rt.ArrayItem{ key: none, val: 'wp-api-request' }]),
		rt.new_bool(false), rt.new_int(1)])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_method(var_scripts, 'add', [rt.new_string('admin-tags'),
			rt.new_string('/wp-admin/js/tags${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-ajax-response' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('admin-tags')])
		rt.call_method(var_scripts, 'add', [rt.new_string('admin-comments'),
			rt.new_string('/wp-admin/js/edit-comments${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wp-lists' },
				rt.ArrayItem{ key: none, val: 'quicktags' }, rt.ArrayItem{
					key: none
					val: 'jquery-query'
				}, rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('admin-comments')])
		rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
			&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('admin-comments'), rt.new_string('adminCommentsSettings'), rt.create_array([rt.ArrayItem{
			key: 'hotkeys_highlight_first'
			val: rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('hotkeys_highlight_first')))
		}, rt.ArrayItem{
			key: 'hotkeys_highlight_last'
			val: rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('hotkeys_highlight_last')))
		}])])))
		rt.call_method(var_scripts, 'add', [rt.new_string('xfn'),
			rt.new_string('/wp-admin/js/xfn${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('postbox'),
			rt.new_string('/wp-admin/js/postbox${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('postbox')])
		rt.call_method(var_scripts, 'add', [rt.new_string('tags-box'),
			rt.new_string('/wp-admin/js/tags-box${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'tags-suggest' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('tags-box')])
		rt.call_method(var_scripts, 'add', [rt.new_string('tags-suggest'),
			rt.new_string('/wp-admin/js/tags-suggest${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'common' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-autocomplete' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{ key: none, val: 'wp-i18n' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('tags-suggest')])
		rt.call_method(var_scripts, 'add', [rt.new_string('post'),
			rt.new_string('/wp-admin/js/post${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'suggest' },
				rt.ArrayItem{ key: none, val: 'wp-lists' }, rt.ArrayItem{ key: none, val: 'postbox' },
				rt.ArrayItem{ key: none, val: 'tags-box' }, rt.ArrayItem{
					key: none
					val: 'underscore'
				}, rt.ArrayItem{ key: none, val: 'word-count' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{
					key: none
					val: 'wp-sanitize'
				}, rt.ArrayItem{ key: none, val: 'clipboard' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('post')])
		rt.call_method(var_scripts, 'add', [rt.new_string('editor-expand'),
			rt.new_string('/wp-admin/js/editor-expand${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'underscore' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('link'),
			rt.new_string('/wp-admin/js/link${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wp-lists' },
				rt.ArrayItem{ key: none, val: 'postbox' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('comment'),
			rt.new_string('/wp-admin/js/comment${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'postbox' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('comment')])
		rt.call_method(var_scripts, 'add', [rt.new_string('admin-gallery'),
			rt.new_string('/wp-admin/js/gallery${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' }])])
		rt.call_method(var_scripts, 'add', [rt.new_string('admin-widgets'),
			rt.new_string('/wp-admin/js/widgets${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-draggable' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-droppable' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('admin-widgets')])
		rt.call_method(var_scripts, 'add', [rt.new_string('media-widgets'),
			rt.new_string('/wp-admin/js/widgets/media-widgets${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'media-models' },
				rt.ArrayItem{ key: none, val: 'media-views' },
				rt.ArrayItem{ key: none, val: 'wp-api-request' }])])
		rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('media-widgets'),
			rt.new_string('wp.mediaWidgets.init();'), rt.new_string('after')])
		rt.call_method(var_scripts, 'add', [rt.new_string('media-audio-widget'),
			rt.new_string('/wp-admin/js/widgets/media-audio-widget${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'media-widgets' },
				rt.ArrayItem{ key: none, val: 'media-audiovideo' }])])
		rt.call_method(var_scripts, 'add', [rt.new_string('media-image-widget'),
			rt.new_string('/wp-admin/js/widgets/media-image-widget${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'media-widgets' }])])
		rt.call_method(var_scripts, 'add', [rt.new_string('media-gallery-widget'),
			rt.new_string('/wp-admin/js/widgets/media-gallery-widget${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'media-widgets' }])])
		rt.call_method(var_scripts, 'add', [rt.new_string('media-video-widget'),
			rt.new_string('/wp-admin/js/widgets/media-video-widget${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'media-widgets' },
				rt.ArrayItem{ key: none, val: 'media-audiovideo' },
				rt.ArrayItem{ key: none, val: 'wp-api-request' }])])
		rt.call_method(var_scripts, 'add', [rt.new_string('text-widgets'),
			rt.new_string('/wp-admin/js/widgets/text-widgets${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'editor' },
				rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'wp-a11y' }])])
		rt.call_method(var_scripts, 'add', [rt.new_string('custom-html-widgets'),
			rt.new_string('/wp-admin/js/widgets/custom-html-widgets${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'backbone' }, rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }])])
		rt.call_method(var_scripts, 'add', [rt.new_string('theme'),
			rt.new_string('/wp-admin/js/theme${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wp-backbone' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{
					key: none
					val: 'customize-base'
				}]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('inline-edit-post'),
			rt.new_string('/wp-admin/js/inline-edit-post${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'tags-suggest' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [
			rt.new_string('inline-edit-post'),
		])
		rt.call_method(var_scripts, 'add', [rt.new_string('inline-edit-tax'),
			rt.new_string('/wp-admin/js/inline-edit-tax${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [
			rt.new_string('inline-edit-tax'),
		])
		rt.call_method(var_scripts, 'add', [rt.new_string('plugin-install'),
			rt.new_string('/wp-admin/js/plugin-install${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
				rt.ArrayItem{ key: none, val: 'thickbox' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('plugin-install')])
		rt.call_method(var_scripts, 'add', [rt.new_string('site-health'),
			rt.new_string('/wp-admin/js/site-health${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'clipboard' },
				rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{
					key: none
					val: 'wp-api-request'
				}, rt.ArrayItem{ key: none, val: 'wp-url' }, rt.ArrayItem{ key: none, val: 'wp-i18n' },
				rt.ArrayItem{ key: none, val: 'wp-hooks' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('site-health')])
		rt.call_method(var_scripts, 'add', [rt.new_string('privacy-tools'),
			rt.new_string('/wp-admin/js/privacy-tools${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('privacy-tools')])
		rt.call_method(var_scripts, 'add', [rt.new_string('updates'),
			rt.new_string('/wp-admin/js/updates${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'common' },
				rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'wp-util' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }, rt.ArrayItem{
					key: none
					val: 'wp-sanitize'
				}, rt.ArrayItem{ key: none, val: 'wp-i18n' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('updates')])
		rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
			&& rt.is_true(rt.call_method(var_scripts, 'localize', [rt.new_string('updates'), rt.new_string('_wpUpdatesSettings'), rt.create_array([rt.ArrayItem{
			key: 'ajax_nonce'
			val: if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) { rt.new_string('') } else { rt.call_function('wp_create_nonce', [rt.new_string('updates')]) }
		}])])))
		rt.call_method(var_scripts, 'add', [rt.new_string('farbtastic'),
			rt.new_string('/wp-admin/js/farbtastic.js'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]),
			rt.new_string('1.2')])
		rt.call_method(var_scripts, 'add', [rt.new_string('iris'),
			rt.new_string('/wp-admin/js/iris.min.js'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery-ui-draggable' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-slider' },
				rt.ArrayItem{ key: none, val: 'jquery-touch-punch' },
			]),
			rt.new_string('1.1.1'), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('wp-color-picker'),
			rt.new_string('/wp-admin/js/color-picker${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'iris' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [
			rt.new_string('wp-color-picker'),
		])
		rt.call_method(var_scripts, 'add', [rt.new_string('dashboard'),
			rt.new_string('/wp-admin/js/dashboard${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'common' },
				rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{
					key: none
					val: 'admin-comments'
				}, rt.ArrayItem{ key: none, val: 'postbox' },
				rt.ArrayItem{ key: none, val: 'wp-util' }, rt.ArrayItem{ key: none, val: 'wp-a11y' },
				rt.ArrayItem{ key: none, val: 'wp-date' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('dashboard')])
		rt.call_method(var_scripts, 'add', [rt.new_string('list-revisions'),
			rt.new_string('/wp-includes/js/wp-list-revisions${var_suffix.to_string()}.js')])
		rt.call_method(var_scripts, 'add', [rt.new_string('media-grid'),
			rt.new_string('/wp-includes/js/media-grid${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'media-editor' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('media'),
			rt.new_string('/wp-admin/js/media${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'clipboard' }, rt.ArrayItem{ key: none, val: 'wp-i18n' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('media')])
		rt.call_method(var_scripts, 'add', [rt.new_string('image-edit'),
			rt.new_string('/wp-admin/js/image-edit${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-core' },
				rt.ArrayItem{ key: none, val: 'imgareaselect' },
				rt.ArrayItem{ key: none, val: 'wp-a11y' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('image-edit')])
		rt.call_method(var_scripts, 'add', [rt.new_string('set-post-thumbnail'),
			rt.new_string('/wp-admin/js/set-post-thumbnail${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'set_translations', [
			rt.new_string('set-post-thumbnail'),
		])
		rt.call_method(var_scripts, 'add', [rt.new_string('nav-menu'),
			rt.new_string('/wp-admin/js/nav-menu${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery-ui-sortable' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-draggable' },
				rt.ArrayItem{ key: none, val: 'jquery-ui-droppable' },
				rt.ArrayItem{ key: none, val: 'wp-lists' }, rt.ArrayItem{ key: none, val: 'postbox' },
				rt.ArrayItem{ key: none, val: 'underscore' }])])
		rt.call_method(var_scripts, 'set_translations', [rt.new_string('nav-menu')])
		rt.call_method(var_scripts, 'add', [rt.new_string('custom-header'),
			rt.new_string('/wp-admin/js/custom-header.js'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery-masonry' },
			]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('custom-background'),
			rt.new_string('/wp-admin/js/custom-background${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'wp-color-picker' },
				rt.ArrayItem{ key: none, val: 'media-views' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('media-gallery'),
			rt.new_string('/wp-admin/js/media-gallery${var_suffix.to_string()}.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
			rt.new_bool(false), rt.new_int(1)])
		rt.call_method(var_scripts, 'add', [rt.new_string('svg-painter'),
			rt.new_string('/wp-admin/js/svg-painter.js'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'jquery' },
			]),
			rt.new_bool(false), rt.new_int(1)])
	}
}

fn wp_default_styles(var_styles rt.PhpVal) {
	mut var_editor_styles := rt.new_null()
	mut var_wp_version := rt.new_null()
	mut var_guessurl := rt.new_null()
	mut var_open_sans_font_url := ''
	mut var_subsets := ''
	mut var_subset := rt.new_null()
	mut var_suffix := ''
	mut var_skip_link_style_path := rt.new_null()
	mut var_fonts_url := rt.new_null()
	mut var_font_family := rt.new_null()
	mut var_block_library_theme_path := rt.new_null()
	mut var_classic_theme_styles_path := rt.new_null()
	mut var_wp_edit_blocks_dependencies := []rt.PhpVal{}
	mut var_package_styles := map[string]rt.PhpVal{}
	mut var_dependencies := rt.new_null()
	mut var_package := rt.new_null()
	mut var_handle := rt.new_null()
	mut var_path := ''
	mut var_rtl_styles := []rt.PhpVal{}
	mut var_rtl_style := rt.new_null()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/version.php', '3')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('SCRIPT_DEBUG'),
	])))))
	{
		rt.call_function('define', [rt.new_string('SCRIPT_DEBUG'),
			rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
				var_wp_version.clone(),
				rt.new_string('-src'),
			]))))])
	}
	var_guessurl = rt.call_function('site_url', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_guessurl)))) {
		var_guessurl = rt.call_function('wp_guess_url', []rt.PhpVal{})
	}
	rt.set_property(var_styles, 'base_url', var_guessurl.clone())
	rt.set_property(var_styles, 'content_url', if rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_CONTENT_URL'),
	]))
	{ rt.get_constant('WP_CONTENT_URL') } else { rt.new_string('') })
	rt.set_property(var_styles, 'default_version', rt.call_function('get_bloginfo', [
		rt.new_string('version'),
	]))
	rt.set_property(var_styles, 'text_direction', if
		rt.is_true(rt.call_function('function_exists', [rt.new_string('is_rtl')]))
		&& rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		'rtl'
	} else {
		'ltr'
	})
	rt.set_property(var_styles, 'default_dirs', rt.create_array([
		rt.ArrayItem{ key: none, val: '/wp-admin/' },
		rt.ArrayItem{ key: none, val: '/wp-includes/css/' },
	]))
	var_open_sans_font_url = ''
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('off'), rt.call_function('_x', [
		rt.new_string('on'),
		rt.new_string('Open Sans font: on or off'),
	])))))
	{
		var_subsets = 'latin,latin-ext'
		var_subset = rt.call_function('_x', [rt.new_string('no-subset'),
			rt.new_string('Open Sans font: add new subset (greek, cyrillic, vietnamese)')])
		if rt.is_true(rt.identical(rt.new_string('cyrillic'), var_subset)) {
			var_subsets = var_subsets + ',cyrillic,cyrillic-ext'
		} else if rt.is_true(rt.identical(rt.new_string('greek'), var_subset)) {
			var_subsets = var_subsets + ',greek,greek-ext'
		} else if rt.is_true(rt.identical(rt.new_string('vietnamese'), var_subset)) {
			var_subsets = var_subsets + ',vietnamese'
		}
		var_open_sans_font_url = 'https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,300,400,600&subset=${var_subsets}&display=fallback'
	}
	rt.call_method(var_styles, 'add', [rt.new_string('colors'),
		rt.new_bool(true),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-admin' },
			rt.ArrayItem{ key: none, val: 'buttons' }])])
	var_suffix = if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
	rt.call_method(var_styles, 'add', [rt.new_string('common'),
		rt.new_string('/wp-admin/css/common${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('forms'),
		rt.new_string('/wp-admin/css/forms${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('admin-menu'),
		rt.new_string('/wp-admin/css/admin-menu${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('dashboard'),
		rt.new_string('/wp-admin/css/dashboard${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('list-tables'),
		rt.new_string('/wp-admin/css/list-tables${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('edit'),
		rt.new_string('/wp-admin/css/edit${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('revisions'),
		rt.new_string('/wp-admin/css/revisions${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('media'),
		rt.new_string('/wp-admin/css/media${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('themes'),
		rt.new_string('/wp-admin/css/themes${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('about'),
		rt.new_string('/wp-admin/css/about${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('nav-menus'),
		rt.new_string('/wp-admin/css/nav-menus${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('widgets'),
		rt.new_string('/wp-admin/css/widgets${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-pointer' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('site-icon'),
		rt.new_string('/wp-admin/css/site-icon${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('l10n'),
		rt.new_string('/wp-admin/css/l10n${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('code-editor'),
		rt.new_string('/wp-admin/css/code-editor${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-codemirror' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('site-health'),
		rt.new_string('/wp-admin/css/site-health${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-admin'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' },
			rt.ArrayItem{ key: none, val: 'common' }, rt.ArrayItem{ key: none, val: 'forms' },
			rt.ArrayItem{ key: none, val: 'admin-menu' }, rt.ArrayItem{ key: none, val: 'dashboard' },
			rt.ArrayItem{ key: none, val: 'list-tables' }, rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'revisions' }, rt.ArrayItem{ key: none, val: 'media' },
			rt.ArrayItem{ key: none, val: 'themes' }, rt.ArrayItem{ key: none, val: 'about' },
			rt.ArrayItem{ key: none, val: 'nav-menus' }, rt.ArrayItem{ key: none, val: 'widgets' },
			rt.ArrayItem{ key: none, val: 'site-icon' }, rt.ArrayItem{ key: none, val: 'l10n' },
			rt.ArrayItem{ key: none, val: 'wp-base-styles' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('login'),
		rt.new_string('/wp-admin/css/login${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' },
			rt.ArrayItem{ key: none, val: 'buttons' }, rt.ArrayItem{ key: none, val: 'forms' },
			rt.ArrayItem{ key: none, val: 'l10n' }, rt.ArrayItem{ key: none, val: 'wp-base-styles' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('install'),
		rt.new_string('/wp-admin/css/install${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' },
			rt.ArrayItem{ key: none, val: 'buttons' }, rt.ArrayItem{ key: none, val: 'forms' },
			rt.ArrayItem{ key: none, val: 'l10n' }, rt.ArrayItem{ key: none, val: 'wp-base-styles' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-color-picker'),
		rt.new_string('/wp-admin/css/color-picker${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('customize-controls'),
		rt.new_string('/wp-admin/css/customize-controls${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-admin' },
			rt.ArrayItem{ key: none, val: 'colors' }, rt.ArrayItem{ key: none, val: 'imgareaselect' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('customize-widgets'),
		rt.new_string('/wp-admin/css/customize-widgets${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-admin' },
			rt.ArrayItem{ key: none, val: 'colors' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('customize-nav-menus'),
		rt.new_string('/wp-admin/css/customize-nav-menus${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-admin' },
			rt.ArrayItem{ key: none, val: 'colors' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('buttons'),
		rt.new_string('/wp-includes/css/buttons${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('dashicons'),
		rt.new_string('/wp-includes/css/dashicons${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('admin-bar'),
		rt.new_string('/wp-includes/css/admin-bar${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-auth-check'),
		rt.new_string('/wp-includes/css/wp-auth-check${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('editor-buttons'),
		rt.new_string('/wp-includes/css/editor${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('media-views'),
		rt.new_string('/wp-includes/css/media-views${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'buttons' },
			rt.ArrayItem{ key: none, val: 'dashicons' }, rt.ArrayItem{
				key: none
				val: 'wp-mediaelement'
			}])])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-pointer'),
		rt.new_string('/wp-includes/css/wp-pointer${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('customize-preview'),
		rt.new_string('/wp-includes/css/customize-preview${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-empty-template-alert'),
		rt.new_string('/wp-includes/css/wp-empty-template-alert${var_suffix}.css')])
	var_skip_link_style_path = rt.new_string(
		(rt.get_constant('WPINC')).str() + '/css/wp-block-template-skip-link${var_suffix}.css')
	rt.call_method(var_styles, 'add', [rt.new_string('wp-block-template-skip-link'),
		rt.new_string('/${var_skip_link_style_path.to_string()}')])
	rt.call_method(var_styles, 'add_data', [rt.new_string('wp-block-template-skip-link'),
		rt.new_string('path'),
		rt.new_string(
			(rt.get_constant('ABSPATH')).str() + var_skip_link_style_path.str())])
	rt.call_method(var_styles, 'add', [rt.new_string('imgareaselect'),
		rt.new_string('/wp-includes/js/imgareaselect/imgareaselect.css'),
		rt.new_array(), rt.new_string('0.9.8')])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-jquery-ui-dialog'),
		rt.new_string('/wp-includes/css/jquery-ui-dialog${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('mediaelement'),
		rt.new_string('/wp-includes/js/mediaelement/mediaelementplayer-legacy.min.css'),
		rt.new_array(), rt.new_string('4.2.17')])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-mediaelement'),
		rt.new_string('/wp-includes/js/mediaelement/wp-mediaelement${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'mediaelement' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('thickbox'),
		rt.new_string('/wp-includes/js/thickbox/thickbox.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dashicons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-codemirror'),
		rt.new_string('/wp-includes/js/codemirror/codemirror.min.css'),
		rt.new_array(), rt.new_string('5.65.20')])
	rt.call_method(var_styles, 'add', [rt.new_string('deprecated-media'),
		rt.new_string('/wp-admin/css/deprecated-media${var_suffix}.css')])
	rt.call_method(var_styles, 'add', [rt.new_string('farbtastic'),
		rt.new_string('/wp-admin/css/farbtastic${var_suffix}.css'),
		rt.new_array(), rt.new_string('1.3u1')])
	rt.call_method(var_styles, 'add', [rt.new_string('jcrop'),
		rt.new_string('/wp-includes/js/jcrop/jquery.Jcrop.min.css'),
		rt.new_array(), rt.new_string('0.9.15')])
	rt.call_method(var_styles, 'add', [rt.new_string('colors-fresh'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-admin' },
			rt.ArrayItem{ key: none, val: 'buttons' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('open-sans'),
		rt.new_string(var_open_sans_font_url.str()).clone()])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-embed-template-ie'),
		rt.new_bool(false)])
	rt.call_method(var_styles, 'add_data', [rt.new_string('wp-embed-template-ie'),
		rt.new_string('conditional'), rt.new_string('_required-conditional-dependency_')])
	var_fonts_url = rt.new_string('')
	var_font_family = rt.call_function('_x', [
		rt.new_string('Noto Serif:400,400i,700,700i'),
		rt.new_string('Google Font Name and Variants'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('off'), var_font_family)))) {
		var_fonts_url = rt.new_string('https://fonts.googleapis.com/css?family=' +
			(rt.call_function('urlencode', [var_font_family.clone()])).str())
	}
	rt.call_method(var_styles, 'add', [rt.new_string('wp-editor-font'),
		var_fonts_url.clone()])
	var_block_library_theme_path = rt.new_string(
		(rt.get_constant('WPINC')).str() + '/css/dist/block-library/theme${var_suffix}.css')
	rt.call_method(var_styles, 'add', [rt.new_string('wp-block-library-theme'),
		rt.new_string('/${var_block_library_theme_path.to_string()}')])
	rt.call_method(var_styles, 'add_data', [rt.new_string('wp-block-library-theme'),
		rt.new_string('path'),
		rt.new_string(
			(rt.get_constant('ABSPATH')).str() + var_block_library_theme_path.str())])
	var_classic_theme_styles_path = rt.new_string(
		(rt.get_constant('WPINC')).str() + '/css/classic-themes${var_suffix}.css')
	rt.call_method(var_styles, 'add', [rt.new_string('classic-theme-styles'),
		rt.new_string('/${var_classic_theme_styles_path.to_string()}')])
	rt.call_method(var_styles, 'add_data', [rt.new_string('classic-theme-styles'),
		rt.new_string('path'),
		rt.new_string(
			(rt.get_constant('ABSPATH')).str() + var_classic_theme_styles_path.str())])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-reset-editor-styles'),
		rt.new_string('/wp-includes/css/dist/block-library/reset${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'common' },
			rt.ArrayItem{ key: none, val: 'forms' }])])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-editor-classic-layout-styles'),
		rt.new_string('/wp-includes/css/dist/edit-post/classic${var_suffix}.css'),
		rt.new_array()])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-block-editor-content'),
		rt.new_string('/wp-includes/css/dist/block-editor/content${var_suffix}.css'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-components' }])])
	var_wp_edit_blocks_dependencies = ['wp-base-styles', 'wp-components', 'wp-reset-editor-styles',
		'wp-block-library', 'wp-block-editor-content']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json',
		[]rt.PhpVal{})))))
	{
		var_wp_edit_blocks_dependencies << 'wp-editor-classic-layout-styles'
	}
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wp-block-styles')]))
		&& !(var_editor_styles.clone().is_array())
		|| var_editor_styles.clone().array_count() == 0 {
		var_wp_edit_blocks_dependencies << 'wp-block-library-theme'
	}
	rt.call_method(var_styles, 'add', [rt.new_string('wp-edit-blocks'),
		rt.new_string('/wp-includes/css/dist/block-library/editor${var_suffix}.css'),
		rt.create_array_from_list(var_wp_edit_blocks_dependencies)])
	rt.call_method(var_styles, 'add', [rt.new_string('wp-view-transitions-admin'),
		rt.new_bool(false)])
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')]))
		&& rt.is_true(rt.call_method(var_styles, 'add_inline_style', [rt.new_string('wp-view-transitions-admin'), rt.call_function('wp_get_view_transitions_admin_css', []rt.PhpVal{})])))
	var_package_styles = {
		'block-editor':         map[string]rt.PhpVal{}
		'block-library':        rt.new_array()
		'block-directory':      rt.new_array()
		'base-styles':          rt.new_array()
		'components':           rt.new_array()
		'commands':             map[string]rt.PhpVal{}
		'edit-post':            map[string]rt.PhpVal{}
		'editor':               map[string]rt.PhpVal{}
		'format-library':       rt.new_array()
		'list-reusable-blocks': map[string]rt.PhpVal{}
		'reusable-blocks':      map[string]rt.PhpVal{}
		'patterns':             map[string]rt.PhpVal{}
		'preferences':          map[string]rt.PhpVal{}
		'nux':                  map[string]rt.PhpVal{}
		'widgets':              map[string]rt.PhpVal{}
		'edit-widgets':         map[string]rt.PhpVal{}
		'customize-widgets':    map[string]rt.PhpVal{}
		'edit-site':            map[string]rt.PhpVal{}
	}
	for var_package_shadow, var_dependencies_shadow in var_package_styles {
		var_handle = rt.new_string('wp-' + (rt.new_string(var_package_shadow.str())).str())
		var_path = '/wp-includes/css/dist/${var_package.to_string()}/style${var_suffix}.css'
		if rt.is_true(rt.identical(rt.new_string('block-library'), rt.new_string(var_package_shadow.str())))
			&& wp_should_load_separate_core_block_assets() {
			var_path = '/wp-includes/css/dist/${var_package.to_string()}/common${var_suffix}.css'
		}
		if rt.is_true(rt.identical(rt.new_string('base-styles'),
			rt.new_string(var_package_shadow.str())))
		{
			var_path = '/wp-includes/css/dist/base-styles/admin-schemes${var_suffix}.css'
		}
		rt.call_method(var_styles, 'add', [var_handle.clone(),
			rt.new_string(var_path.str()).clone(), var_dependencies_shadow.clone()])
		rt.call_method(var_styles, 'add_data', [var_handle.clone(),
			rt.new_string('path'), rt.new_string((rt.get_constant('ABSPATH')).str() + var_path)])
	}
	var_rtl_styles = ['common', 'forms', 'admin-menu', 'dashboard', 'list-tables', 'edit',
		'revisions', 'media', 'themes', 'about', 'nav-menus', 'widgets', 'site-icon', 'l10n',
		'install', 'wp-color-picker', 'customize-controls', 'customize-widgets',
		'customize-nav-menus', 'customize-preview', 'login', 'site-health', 'wp-empty-template-alert',
		'buttons', 'admin-bar', 'wp-auth-check', 'editor-buttons', 'media-views', 'wp-pointer',
		'wp-jquery-ui-dialog', 'wp-block-template-skip-link', 'wp-reset-editor-styles',
		'wp-editor-classic-layout-styles', 'wp-block-library-theme', 'wp-edit-blocks',
		'wp-block-editor', 'wp-block-library', 'wp-block-directory', 'wp-commands', 'wp-components',
		'wp-customize-widgets', 'wp-edit-post', 'wp-edit-site', 'wp-edit-widgets', 'wp-editor',
		'wp-format-library', 'wp-list-reusable-blocks', 'wp-reusable-blocks', 'wp-patterns', 'wp-nux',
		'wp-widgets', 'deprecated-media', 'farbtastic']
	for var_rtl_style_shadow in var_rtl_styles {
		rt.call_method(var_styles, 'add_data', [rt.new_string(var_rtl_style_shadow.str()).clone(),
			rt.new_string('rtl'), rt.new_string('replace')])
		if var_suffix.len > 0 && var_suffix != '0' {
			rt.call_method(var_styles, 'add_data', [rt.new_string(var_rtl_style_shadow.str()).clone(),
				rt.new_string('suffix'), rt.new_string(var_suffix.str()).clone()])
		}
	}
}

fn wp_prototype_before_jquery(var_js_array rt.PhpVal) rt.PhpVal {
	mut var_prototype := rt.new_null()
	mut var_jquery := rt.new_null()
	var_prototype = rt.call_function('array_search', [rt.new_string('prototype'),
		var_js_array.clone(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_prototype)) {
		return var_js_array.clone()
	}
	var_jquery = rt.call_function('array_search', [rt.new_string('jquery'),
		var_js_array.clone(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_jquery)) {
		return var_js_array.clone()
	}
	if rt.is_true(rt.less(var_prototype, var_jquery)) {
		return var_js_array.clone()
	}
	var_js_array.array_unset(var_prototype)
	rt.call_function('array_splice', [var_js_array.clone(), var_jquery.clone(),
		rt.new_int(0), rt.new_string('prototype')])
	return var_js_array.clone()
}

fn wp_just_in_time_script_localization() {
	mut var_GLOBALS := rt.new_null()
	rt.call_function('wp_localize_script', [rt.new_string('autosave'),
		rt.new_string('autosaveL10n'),
		rt.create_array([
			rt.ArrayItem{ key: 'autosaveInterval', val: rt.get_constant('AUTOSAVE_INTERVAL') },
			rt.ArrayItem{ key: 'blog_id', val: rt.call_function('get_current_blog_id',
				[]rt.PhpVal{}) },
		])])
	rt.call_function('wp_localize_script', [rt.new_string('mce-view'),
		rt.new_string('mceViewL10n'),
		rt.create_array([
			rt.ArrayItem{
				key: 'shortcodes'
				val: if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('shortcode_tags')))) {
					rt.func_array_keys(var_GLOBALS.array_get(rt.new_string('shortcode_tags')))
				} else {
					rt.new_array()
				}
			},
		])])
	rt.call_function('wp_localize_script', [rt.new_string('word-count'),
		rt.new_string('wordCountL10n'),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: rt.call_function('wp_get_word_count_type',
				[]rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'shortcodes'
				val: if !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('shortcode_tags')))) {
					rt.func_array_keys(var_GLOBALS.array_get(rt.new_string('shortcode_tags')))
				} else {
					rt.new_array()
				}
			},
		])])
}

fn wp_localize_jquery_ui_datepicker() {
	mut var_wp_locale := rt.new_null()
	mut var_datepicker_date_format := rt.new_null()
	mut var_datepicker_defaults := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
		rt.new_string('jquery-ui-datepicker'),
		rt.new_string('enqueued'),
	])))))
	{
		return
	}
	var_datepicker_date_format = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'd' },
			rt.ArrayItem{ key: none, val: 'j' }, rt.ArrayItem{ key: none, val: 'l' },
			rt.ArrayItem{ key: none, val: 'z' }, rt.ArrayItem{ key: none, val: 'F' },
			rt.ArrayItem{ key: none, val: 'M' }, rt.ArrayItem{ key: none, val: 'n' },
			rt.ArrayItem{ key: none, val: 'm' }, rt.ArrayItem{ key: none, val: 'Y' },
			rt.ArrayItem{ key: none, val: 'y' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'dd' },
			rt.ArrayItem{ key: none, val: 'd' }, rt.ArrayItem{ key: none, val: 'DD' },
			rt.ArrayItem{ key: none, val: 'o' }, rt.ArrayItem{ key: none, val: 'MM' },
			rt.ArrayItem{ key: none, val: 'M' }, rt.ArrayItem{ key: none, val: 'm' },
			rt.ArrayItem{ key: none, val: 'mm' }, rt.ArrayItem{ key: none, val: 'yy' },
			rt.ArrayItem{ key: none, val: 'y' }]),
		rt.call_function('get_option', [rt.new_string('date_format')]),
	])
	var_datepicker_defaults = rt.call_function('wp_json_encode', [
		rt.create_array([
			rt.ArrayItem{ key: 'closeText', val: rt.call_function('__', [
				rt.new_string('Close'),
			]) },
			rt.ArrayItem{ key: 'currentText', val: rt.call_function('__', [
				rt.new_string('Today'),
			]) },
			rt.ArrayItem{ key: 'monthNames', val: rt.call_function('array_values', [
				rt.get_property(var_wp_locale, 'month'),
			]) },
			rt.ArrayItem{ key: 'monthNamesShort', val: rt.call_function('array_values', [
				rt.get_property(var_wp_locale, 'month_abbrev'),
			]) },
			rt.ArrayItem{ key: 'nextText', val: rt.call_function('_x', [
				rt.new_string('Next'),
				rt.new_string('datepicker: navigate to next month'),
			]) },
			rt.ArrayItem{ key: 'prevText', val: rt.call_function('_x', [
				rt.new_string('Previous'),
				rt.new_string('datepicker: navigate to previous month'),
			]) },
			rt.ArrayItem{ key: 'dayNames', val: rt.call_function('array_values', [
				rt.get_property(var_wp_locale, 'weekday'),
			]) },
			rt.ArrayItem{ key: 'dayNamesShort', val: rt.call_function('array_values', [
				rt.get_property(var_wp_locale, 'weekday_abbrev'),
			]) },
			rt.ArrayItem{ key: 'dayNamesMin', val: rt.call_function('array_values', [
				rt.get_property(var_wp_locale, 'weekday_initial'),
			]) },
			rt.ArrayItem{ key: 'dateFormat', val: var_datepicker_date_format },
			rt.ArrayItem{ key: 'firstDay', val: rt.call_function('absint', [
				rt.call_function('get_option', [rt.new_string('start_of_week')]),
			]) },
			rt.ArrayItem{ key: 'isRTL', val: rt.call_method(var_wp_locale, 'is_rtl', []rt.PhpVal{}) },
		]),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES')),
	])
	rt.call_function('wp_add_inline_script', [rt.new_string('jquery-ui-datepicker'),
		rt.new_string('jQuery(function(jQuery){jQuery.datepicker.setDefaults(${var_datepicker_defaults.to_string()});});')])
}

fn wp_localize_community_events() {
	mut var_user_id := rt.new_null()
	mut var_saved_location := rt.new_null()
	mut var_saved_ip_address := rt.new_null()
	mut var_current_ip_address := rt.new_null()
	mut var_events_client := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
		rt.new_string('dashboard'),
	])))))
	{
		return
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-community-events.php', '4')
	var_user_id = rt.call_function('get_current_user_id', []rt.PhpVal{})
	var_saved_location = rt.call_function('get_user_option', [
		rt.new_string('community-events-location'),
		var_user_id.clone(),
	])
	var_saved_ip_address = if !(var_saved_location.array_get(rt.new_string('ip'))).is_null() {
		var_saved_location.array_get(rt.new_string('ip'))
	} else {
		rt.new_bool(false)
	}
	mut iife_temp_0 := Class_WP_Community_Events{}
	mut iife_result_0 := iife_temp_0.get_unsafe_client_ip()
	var_current_ip_address = iife_result_0
	if rt.is_true(var_saved_ip_address) && rt.is_true(var_current_ip_address)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_ip_address, var_saved_ip_address)))) {
		var_saved_location.array_set('ip', var_current_ip_address.clone())
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('community-events-location'), var_saved_location.clone()])
	}
	var_events_client = create_wp_community_events(var_user_id.clone(), var_saved_location.clone())
	rt.call_function('wp_localize_script', [rt.new_string('dashboard'),
		rt.new_string('communityEventsData'),
		rt.create_array([
			rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('community_events'),
			]) },
			rt.ArrayItem{ key: 'cache', val: var_events_client.get_cached_events() },
			rt.ArrayItem{ key: 'time_format', val: rt.call_function('get_option', [
				rt.new_string('time_format'),
			]) },
		])])
}

fn wp_style_loader_src(var_src rt.PhpVal, var_handle rt.PhpVal) bool {
	mut var__wp_admin_css_colors := rt.new_null()
	mut var_qv := rt.new_null()
	mut var_color := rt.new_null()
	mut var_url := rt.new_null()
	mut var_parsed := rt.new_null()
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return (rt.call_function('preg_replace', [rt.new_string('#^wp-admin/#'),
			rt.new_string('./'), var_src.clone()])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('colors'), var_handle)) {
		var_color = rt.call_function('get_user_option', [rt.new_string('admin_color')])
		if !rt.is_true(var_color) || !(var__wp_admin_css_colors.array_isset(var_color)) {
			var_color = rt.new_string('modern')
		}
		var_color = if !(var__wp_admin_css_colors.array_get(var_color)).is_null() {
			var__wp_admin_css_colors.array_get(var_color)
		} else {
			rt.new_null()
		}
		var_url = if !(rt.get_property(var_color, 'url')).is_null() {
			rt.get_property(var_color, 'url')
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) {
			return false
		}
		var_parsed = rt.call_function('parse_url', [var_src.clone()])
		if var_parsed.array_isset(rt.new_string('query'))
			&& rt.is_true(var_parsed.array_get(rt.new_string('query'))) {
			rt.call_function('wp_parse_str', [var_parsed.array_get(rt.new_string('query')),
				var_qv.clone()])
			var_url = rt.call_function('add_query_arg', [var_qv.clone(),
				var_url.clone()])
		}
		return var_url.to_bool()
	}
	return var_src.to_bool()
}

fn print_head_scripts() rt.PhpVal {
	mut var_concatenate_scripts := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('wp_print_scripts'),
	])))))
	{
		rt.call_function('do_action', [rt.new_string('wp_print_scripts')])
	}
	var_wp_scripts = rt.call_function('wp_scripts', []rt.PhpVal{})
	script_concat_settings()
	rt.set_property(var_wp_scripts, 'do_concat', var_concatenate_scripts.clone())
	rt.call_method(var_wp_scripts, 'do_head_items', []rt.PhpVal{})
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('print_head_scripts'),
		rt.new_bool(true)]))
	{
		_print_scripts()
	}
	rt.call_method(var_wp_scripts, 'reset', []rt.PhpVal{})
	return rt.get_property(var_wp_scripts, 'done')
}

fn print_footer_scripts() rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	mut var_concatenate_scripts := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'WP_Scripts')))))) {
		return rt.new_array()
	}
	script_concat_settings()
	rt.set_property(var_wp_scripts, 'do_concat', var_concatenate_scripts.clone())
	rt.call_method(var_wp_scripts, 'do_footer_items', []rt.PhpVal{})
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('print_footer_scripts'),
		rt.new_bool(true),
	]))
	{
		_print_scripts()
	}
	rt.call_method(var_wp_scripts, 'reset', []rt.PhpVal{})
	return rt.get_property(var_wp_scripts, 'done')
}

fn _print_scripts() {
	mut var_wp_scripts := rt.new_null()
	mut var_compress_scripts := rt.new_null()
	mut var_zip := rt.new_null()
	mut var_concat := rt.new_null()
	mut var_concatenated := ''
	mut var_chunk := rt.new_null()
	mut var_key := rt.new_null()
	mut var_src := rt.new_null()
	var_zip = rt.new_int(if rt.is_true(var_compress_scripts) { 1 } else { 0 })
	if rt.is_true(var_zip)
		&& rt.is_true(rt.call_function('defined', [rt.new_string('ENFORCE_GZIP')]))
		&& rt.is_true(rt.get_constant('ENFORCE_GZIP')) {
		var_zip = rt.new_string('gzip')
	}
	var_concat = rt.new_string(rt.get_property(var_wp_scripts, 'concat').to_string().trim_space())
	if rt.is_true(var_concat) {
		if !(!rt.is_true(rt.get_property(var_wp_scripts, 'print_code'))) {
			print('\n<script>\n')
			rt.echo_val(rt.get_property(var_wp_scripts, 'print_code'))
			rt.echo_val(rt.call_function('sprintf', [
				rt.new_string('\n//# sourceURL=%s\n'),
				rt.call_function('rawurlencode', [
					rt.new_string('js-inline-concat-' + var_concat.str()),
				]),
			]))
			print('</script>\n')
		}
		var_concat = rt.call_function('str_split', [var_concat.clone(),
			rt.new_int(128)])
		var_concatenated = ''
		mut iter_5 := var_concat.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_chunk_shadow := item_5.val
			mut var_key_shadow := item_5.key
			var_concatenated = var_concatenated +
				'&load%5Bchunk_${var_key.to_string()}%5D=${var_chunk.to_string()}'
		}
		var_src = rt.new_string((rt.get_property(var_wp_scripts, 'base_url')).str() +
			'/wp-admin/load-scripts.php?c=${var_zip.to_string()}' + var_concatenated + '&ver=' +
			(rt.get_property(var_wp_scripts, 'default_version')).str())
		print("<script src='" + (rt.call_function('esc_attr', [var_src.clone()])).str() +
			"'></script>\n")
	}
	if !(!rt.is_true(rt.get_property(var_wp_scripts, 'print_html'))) {
		rt.echo_val(rt.get_property(var_wp_scripts, 'print_html'))
	}
}

fn wp_print_head_scripts() rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [
		rt.new_string('wp_print_scripts'),
	])))))
	{
		rt.call_function('do_action', [rt.new_string('wp_print_scripts')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'WP_Scripts')))))) {
		return rt.new_array()
	}
	return print_head_scripts()
}

fn _wp_footer_scripts() {
	print_late_styles()
	print_footer_scripts()
}

fn wp_print_footer_scripts() {
	rt.call_function('do_action', [rt.new_string('wp_print_footer_scripts')])
}

fn wp_enqueue_scripts() {
	rt.call_function('do_action', [rt.new_string('wp_enqueue_scripts')])
}

fn print_admin_styles() rt.PhpVal {
	mut var_concatenate_scripts := rt.new_null()
	mut var_wp_styles := rt.new_null()
	var_wp_styles = rt.call_function('wp_styles', []rt.PhpVal{})
	script_concat_settings()
	rt.set_property(var_wp_styles, 'do_concat', var_concatenate_scripts.clone())
	rt.call_method(var_wp_styles, 'do_items', [rt.new_bool(false)])
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('print_admin_styles'),
		rt.new_bool(true)]))
	{
		_print_styles()
	}
	rt.call_method(var_wp_styles, 'reset', []rt.PhpVal{})
	return rt.get_property(var_wp_styles, 'done')
}

fn print_late_styles() rt.PhpVal {
	mut var_wp_styles := rt.new_null()
	mut var_concatenate_scripts := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_styles, 'WP_Styles')))))) {
		return rt.new_null()
	}
	script_concat_settings()
	rt.set_property(var_wp_styles, 'do_concat', var_concatenate_scripts.clone())
	rt.call_method(var_wp_styles, 'do_footer_items', []rt.PhpVal{})
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('print_late_styles'),
		rt.new_bool(true)]))
	{
		_print_styles()
	}
	rt.call_method(var_wp_styles, 'reset', []rt.PhpVal{})
	return rt.get_property(var_wp_styles, 'done')
}

fn _print_styles() {
	mut var_compress_css := rt.new_null()
	mut var_wp_styles := rt.new_null()
	mut var_zip := rt.new_null()
	mut var_concat := rt.new_null()
	mut var_dir := rt.new_null()
	mut var_ver := rt.new_null()
	mut var_concat_source_url := rt.new_null()
	mut var_concatenated := ''
	mut var_chunk := rt.new_null()
	mut var_key := rt.new_null()
	mut var_href := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_style_tag_contents := rt.new_null()
	var_wp_styles = rt.call_function('wp_styles', []rt.PhpVal{})
	var_zip = rt.new_int(if rt.is_true(var_compress_css) { 1 } else { 0 })
	if rt.is_true(var_zip)
		&& rt.is_true(rt.call_function('defined', [rt.new_string('ENFORCE_GZIP')]))
		&& rt.is_true(rt.get_constant('ENFORCE_GZIP')) {
		var_zip = rt.new_string('gzip')
	}
	var_concat = rt.new_string(rt.get_property(var_wp_styles, 'concat').to_string().trim_space())
	if rt.is_true(var_concat) {
		var_dir = rt.get_property(var_wp_styles, 'text_direction')
		var_ver = rt.get_property(var_wp_styles, 'default_version')
		var_concat_source_url = rt.new_string('css-inline-concat-' + var_concat.str())
		var_concat = rt.call_function('str_split', [var_concat.clone(),
			rt.new_int(128)])
		var_concatenated = ''
		mut iter_6 := var_concat.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_chunk_shadow := item_6.val
			mut var_key_shadow := item_6.key
			var_concatenated = var_concatenated +
				'&load%5Bchunk_${var_key.to_string()}%5D=${var_chunk.to_string()}'
		}
		var_href = rt.new_string((rt.get_property(var_wp_styles, 'base_url')).str() +
			'/wp-admin/load-styles.php?c=${var_zip.to_string()}&dir=${var_dir.to_string()}' +
			var_concatenated + '&ver=' + var_ver.str())
		print("<link rel='stylesheet' href='" +
			(rt.call_function('esc_attr', [var_href.clone()])).str() + "' media='all' />\n")
		if !(!rt.is_true(rt.get_property(var_wp_styles, 'print_code'))) {
			var_processor = create_wp_html_tag_processor(rt.new_string('<style></style>'))
			var_processor.next_tag()
			var_style_tag_contents = rt.new_string((
				rt.concat(rt.concat(rt.new_string('\n'), rt.get_property(var_wp_styles, 'print_code')), rt.new_string('\n')) +(rt.call_function('sprintf', [rt.new_string('/*# sourceURL=%s */\n'), rt.call_function('rawurlencode', [var_concat_source_url.clone()])])).str()).str())
			var_processor.set_modifiable_text(var_style_tag_contents.clone())
			print(rt.concat(var_processor.get_updated_html(), rt.new_string('\n')))
		}
	}
	if !(!rt.is_true(rt.get_property(var_wp_styles, 'print_html'))) {
		rt.echo_val(rt.get_property(var_wp_styles, 'print_html'))
	}
}

fn script_concat_settings() {
	mut var_compressed_output := false
	mut var_can_compress_scripts := false
	mut var_concatenate_scripts := rt.new_null()
	mut var_compress_scripts := rt.new_null()
	mut var_compress_css := rt.new_null()
	var_compressed_output =
		rt.is_true(rt.call_function('ini_get', [rt.new_string('zlib.output_compression')]))
		|| rt.is_true(rt.identical(rt.new_string('ob_gzhandler'), rt.call_function('ini_get', [rt.new_string('output_handler')])))
	var_can_compress_scripts =
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('get_site_option', [rt.new_string('can_compress_scripts')]))
	if !(!var_concatenate_scripts.is_null()) {
		var_concatenate_scripts = if rt.is_true(rt.call_function('defined', [
			rt.new_string('CONCATENATE_SCRIPTS'),
		]))
		{ rt.get_constant('CONCATENATE_SCRIPTS') } else { rt.new_bool(true) }
		if (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('login_init')]))))))
			|| (rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
			&& rt.is_true(rt.get_constant('SCRIPT_DEBUG'))) {
			var_concatenate_scripts = rt.new_bool(false)
		}
	}
	if !(!var_compress_scripts.is_null()) {
		var_compress_scripts = if rt.is_true(rt.call_function('defined', [
			rt.new_string('COMPRESS_SCRIPTS'),
		]))
		{ rt.get_constant('COMPRESS_SCRIPTS') } else { rt.new_bool(true) }
		if rt.is_true(var_compress_scripts) && !var_can_compress_scripts || var_compressed_output {
			var_compress_scripts = rt.new_bool(false)
		}
	}
	if !(!var_compress_css.is_null()) {
		var_compress_css = if rt.is_true(rt.call_function('defined', [
			rt.new_string('COMPRESS_CSS'),
		]))
		{ rt.get_constant('COMPRESS_CSS') } else { rt.new_bool(true) }
		if rt.is_true(var_compress_css) && !var_can_compress_scripts || var_compressed_output {
			var_compress_css = rt.new_bool(false)
		}
	}
}

fn wp_common_block_scripts_and_styles() {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(wp_should_load_block_editor_scripts_and_styles())))) {
		return
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-library')])
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wp-block-styles')]))
		&& !(wp_should_load_separate_core_block_assets()) {
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-library-theme')])
	}
	rt.call_function('do_action', [rt.new_string('enqueue_block_assets')])
}

fn wp_filter_out_block_nodes(var_nodes rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string('blocks'),
			var_node.array_get(rt.new_string('path')),
			rt.new_bool(true),
		]))))
	}
	return rt.call_function('array_filter', [var_nodes.clone(),
		rt.new_closure(closure_2_fn), rt.get_constant('ARRAY_FILTER_USE_BOTH')])
}

fn wp_enqueue_global_styles() {
	mut var_assets_on_demand := rt.new_null()
	mut var_is_block_theme := rt.new_null()
	mut var_is_classic_theme := false
	mut var_stylesheet := rt.new_null()
	mut var_custom_css := rt.new_null()
	mut var_before_milestone := ''
	mut var_after_milestone := ''
	var_assets_on_demand = rt.new_bool(wp_should_load_block_assets_on_demand())
	var_is_block_theme = rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	var_is_classic_theme = !(rt.is_true(var_is_block_theme))
	if rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_footer')]))
		&& rt.is_true(var_is_block_theme)
		|| (var_is_classic_theme && rt.is_true(rt.new_bool(!(rt.is_true(var_assets_on_demand))))) {
		return
	}
	if var_is_classic_theme
		&& rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_enqueue_scripts')]))
		&& rt.is_true(var_assets_on_demand) {
		if rt.is_true(rt.call_function('has_action', [
			rt.new_string('wp_template_enhancement_output_buffer_started'),
			rt.new_string('wp_hoist_late_printed_styles'),
		]))
		{
			rt.call_function('wp_register_style', [
				rt.new_string('wp-global-styles-placeholder'),
				rt.new_bool(false),
			])
			rt.call_function('wp_add_inline_style', [
				rt.new_string('wp-global-styles-placeholder'),
				rt.new_string(':root { --wp-internal-comment: "Placeholder for wp_hoist_late_printed_styles() to replace with the global-styles printed at wp_footer." }'),
			])
			rt.call_function('wp_enqueue_style', [
				rt.new_string('wp-global-styles-placeholder'),
			])
		}
		return
	}
	rt.call_function('add_filter', [rt.new_string('wp_theme_json_get_style_nodes'),
		rt.new_string('wp_filter_out_block_nodes')])
	var_stylesheet = rt.call_function('wp_get_global_stylesheet', []rt.PhpVal{})
	if rt.is_true(var_is_block_theme) {
		rt.call_function('remove_action', [rt.new_string('wp_head'),
			rt.new_string('wp_custom_css_cb'), rt.new_int(101)])
		var_custom_css =
			rt.new_string(rt.call_function('wp_get_custom_css', []rt.PhpVal{}).to_string().trim_space())
		if rt.is_true(var_custom_css)
			|| rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
			if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
				var_before_milestone = '/*BEGIN_CUSTOMIZER_CUSTOM_CSS*/'
				var_after_milestone = '/*END_CUSTOMIZER_CUSTOM_CSS*/'
				var_custom_css = rt.call_function('str_replace', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_before_milestone },
						rt.ArrayItem{ key: none, val: var_after_milestone },
					]),
					rt.new_string(''),
					var_custom_css.clone(),
				])
				var_custom_css = rt.new_string((var_before_milestone + '\n' + var_custom_css.str() +
					'\n' + var_after_milestone).str())
			}
			var_custom_css = rt.new_string('\n' + var_custom_css.str())
		}
		var_stylesheet = rt.concat(var_stylesheet, var_custom_css)
		var_stylesheet = rt.concat(var_stylesheet, rt.call_function('wp_get_global_stylesheet', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'custom-css' }]),
		]))
	}
	if !rt.is_true(var_stylesheet) {
		return
	}
	rt.call_function('wp_register_style', [rt.new_string('global-styles'),
		rt.new_bool(false)])
	rt.call_function('wp_add_inline_style', [rt.new_string('global-styles'),
		var_stylesheet.clone()])
	rt.call_function('wp_enqueue_style', [rt.new_string('global-styles')])
	rt.call_function('wp_add_global_styles_for_blocks', []rt.PhpVal{})
}

fn wp_should_load_block_editor_scripts_and_styles() rt.PhpVal {
	mut var_current_screen := rt.new_null()
	mut var_is_block_editor_screen := false
	var_is_block_editor_screen =
		rt.is_true(rt.new_bool(rt.instance_of(var_current_screen, 'WP_Screen')))
		&& rt.is_true(rt.call_method(var_current_screen, 'is_block_editor', []rt.PhpVal{}))
	return rt.call_function('apply_filters', [
		rt.new_string('should_load_block_editor_scripts_and_styles'),
		rt.new_bool(var_is_block_editor_screen).clone(),
	])
}

fn wp_should_load_separate_core_block_assets() bool {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_feed', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_is_rest_endpoint', []rt.PhpVal{})) {
		return false
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('should_load_separate_core_block_assets'),
		rt.new_bool(false),
	])).to_bool()
}

fn wp_should_load_block_assets_on_demand() bool {
	mut var_load_assets_on_demand := false
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_feed', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('wp_is_rest_endpoint', []rt.PhpVal{})) {
		return false
	}
	var_load_assets_on_demand = wp_should_load_separate_core_block_assets()
	return (rt.call_function('apply_filters', [
		rt.new_string('should_load_block_assets_on_demand'),
		rt.new_bool(var_load_assets_on_demand).clone(),
	])).to_bool()
}

fn wp_enqueue_registered_block_scripts_and_styles() {
	mut var_load_editor_scripts_and_styles := false
	mut var_block_registry := rt.new_null()
	mut var_block_type := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_style_handle := rt.new_null()
	mut var_script_handle := rt.new_null()
	mut var_editor_style_handle := rt.new_null()
	mut var_editor_script_handle := rt.new_null()
	if rt.is_true(rt.new_bool(wp_should_load_block_assets_on_demand())) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('has_action', [rt.new_string('wp_template_enhancement_output_buffer_started'), rt.new_string('wp_hoist_late_printed_styles')])) {
			rt.call_function('wp_register_style', [
				rt.new_string('wp-block-styles-placeholder'),
				rt.new_bool(false),
			])
			rt.call_function('wp_add_inline_style', [
				rt.new_string('wp-block-styles-placeholder'),
				rt.new_string(':root { --wp-internal-comment: "Placeholder for wp_hoist_late_printed_styles() to replace with the block styles printed at wp_footer." }'),
			])
			rt.call_function('wp_enqueue_style', [
				rt.new_string('wp-block-styles-placeholder'),
			])
		}
		return
	}
	var_load_editor_scripts_and_styles = rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		&& rt.is_true(wp_should_load_block_editor_scripts_and_styles())
	mut iife_temp_2 := Class_WP_Block_Type_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	var_block_registry = iife_result_2
	mut iter_7 := rt.call_method(var_block_registry, 'get_all_registered', []rt.PhpVal{}).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_block_type_shadow := item_7.val
		mut var_block_name_shadow := item_7.key
		mut iter_8 := rt.get_property(var_block_type_shadow, 'style_handles').iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_style_handle_shadow := item_8.val
			rt.call_function('wp_enqueue_style', [var_style_handle_shadow.clone()])
		}
		mut iter_9 := rt.get_property(var_block_type_shadow, 'script_handles').iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_script_handle_shadow := item_9.val
			rt.call_function('wp_enqueue_script', [var_script_handle_shadow.clone()])
		}
		if var_load_editor_scripts_and_styles {
			mut iter_10 := rt.get_property(var_block_type_shadow, 'editor_style_handles').iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_editor_style_handle_shadow := item_10.val
				rt.call_function('wp_enqueue_style', [var_editor_style_handle_shadow.clone()])
			}
			mut iter_11 :=
				rt.get_property(var_block_type_shadow, 'editor_script_handles').iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_editor_script_handle_shadow := item_11.val
				rt.call_function('wp_enqueue_script', [var_editor_script_handle_shadow.clone()])
			}
		}
	}
}

fn enqueue_block_styles_assets() {
	mut var_wp_styles := rt.new_null()
	mut var_block_styles := rt.new_null()
	mut var_styles := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_style_properties := map[string]rt.PhpVal{}
	mut var_handle := rt.new_null()
	mut var_block_stylesheet_handle := rt.new_null()
	mut iife_temp_3 := Class_WP_Block_Styles_Registry{}
	mut iife_result_3 := iife_temp_3.get_instance()
	var_block_styles = rt.call_method(iife_result_3, 'get_all_registered', []rt.PhpVal{})
	mut iter_12 := var_block_styles.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_styles_shadow := item_12.val
		mut var_block_name_shadow := item_12.key
		mut iter_13 := var_styles_shadow.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_style_properties_shadow := item_13.val
			if var_style_properties_shadow.array_isset(rt.new_string('style_handle')) {
				if rt.is_true(rt.new_bool(wp_should_load_block_assets_on_demand())) {
					closure_5_fn := fn [var_block_name, var_style_properties] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						mut var_html := if args.len > 0 { args[0].clone() } else { rt.new_null() }
						mut var_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
						if rt.is_true(rt.identical(var_block.array_get(rt.new_string('blockName')),
							var_block_name_shadow))
						{
							rt.call_function('wp_enqueue_style',
								[var_style_properties_shadow['style_handle']])
						}
						return
					}
					rt.call_function('add_filter', [rt.new_string('render_block'),
						rt.new_closure(closure_5_fn), rt.new_int(10),
						rt.new_int(2)])
				} else {
					rt.call_function('wp_enqueue_style',
						[var_style_properties_shadow['style_handle']])
				}
			}
			if var_style_properties_shadow.array_isset(rt.new_string('inline_style')) {
				var_handle = rt.new_string('wp-block-library')
				if rt.is_true(rt.new_bool(wp_should_load_block_assets_on_demand())) {
					var_block_stylesheet_handle = rt.call_function('generate_block_asset_handle', [
						var_block_name_shadow.clone(),
						rt.new_string('style'),
					])
					if rt.get_property(var_wp_styles, 'registered').array_isset(var_block_stylesheet_handle) {
						var_handle = var_block_stylesheet_handle.clone()
					}
				}
				rt.call_function('wp_add_inline_style',
					[var_handle.clone(), var_style_properties_shadow['inline_style']])
			}
		}
	}
}

fn enqueue_editor_block_styles_assets() {
	mut var_block_styles := rt.new_null()
	mut var_register_script_lines := []rt.PhpVal{}
	mut var_styles := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_style_properties := map[string]rt.PhpVal{}
	mut var_block_style := map[string]rt.PhpVal{}
	mut var_inline_script := rt.new_null()
	mut iife_temp_5 := Class_WP_Block_Styles_Registry{}
	mut iife_result_5 := iife_temp_5.get_instance()
	var_block_styles = rt.call_method(iife_result_5, 'get_all_registered', []rt.PhpVal{})
	var_register_script_lines = [rt.new_string('( function() {')]
	mut iter_14 := var_block_styles.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_styles_shadow := item_14.val
		mut var_block_name_shadow := item_14.key
		mut iter_15 := var_styles_shadow.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_style_properties_shadow := item_15.val
			var_block_style = {
				'name':  var_style_properties_shadow['name']
				'label': var_style_properties_shadow['label']
			}
			if var_style_properties_shadow.array_isset(rt.new_string('is_default')) {
				var_block_style['isDefault'] = var_style_properties_shadow['is_default']
			}
			var_register_script_lines << rt.call_function('sprintf', [
				rt.new_string("\twp.blocks.registerBlockStyle( '%s', %s );"),
				var_block_name_shadow.clone(),
				rt.call_function('wp_json_encode', [
					rt.create_array_from_native_map(var_block_style),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES')),
				]),
			])
		}
	}
	var_register_script_lines << rt.new_string('} )();')
	var_inline_script = rt.call_function('implode', [rt.new_string('\n'),
		rt.create_array_from_list(var_register_script_lines)])
	rt.call_function('wp_register_script', [rt.new_string('wp-block-styles'),
		rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-blocks' }]),
		rt.new_bool(true), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-block-styles'),
		var_inline_script.clone()])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-block-styles')])
}

fn wp_enqueue_editor_block_directory_assets() {
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-block-directory')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-directory')])
}

fn wp_enqueue_editor_format_library_assets() {
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-format-library')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-format-library')])
}

fn wp_get_script_tag(var_attributes_arg rt.PhpVal) string {
	mut var_attributes := var_attributes_arg
	mut var_processor := rt.new_null()
	mut var_value := []rt.PhpVal{}
	mut var_name := rt.new_null()
	var_attributes = rt.call_function('apply_filters', [
		rt.new_string('wp_script_attributes'),
		var_attributes.clone(),
	])
	var_processor = create_wp_html_tag_processor(rt.new_string('<script></script>'))
	var_processor.next_tag()
	mut iter_16 := var_attributes.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_value_shadow := item_16.val
		mut var_name_shadow := item_16.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
			var_processor.get_attribute(var_name_shadow.clone())))))
		{
			continue
		}
		var_processor.set_attribute(var_name_shadow.clone(), if !var_value_shadow.is_null() {
			var_value_shadow
		} else {
			rt.new_bool(true)
		})
	}
	return rt.concat(var_processor.get_updated_html(), rt.new_string('\n'))
}

fn wp_print_script_tag(var_attributes rt.PhpVal) {
	print(wp_get_script_tag(var_attributes.clone()))
}

fn wp_get_inline_script_tag(var_data_arg rt.PhpVal, var_attributes_arg rt.PhpVal) string {
	mut var_data := var_data_arg
	mut var_attributes := var_attributes_arg
	mut var_processor := rt.new_null()
	mut var_value := []rt.PhpVal{}
	mut var_name := rt.new_null()
	var_data = rt.new_string('\n' + var_data.clone().to_string().trim_space() + '\n')
	var_attributes = rt.call_function('apply_filters', [
		rt.new_string('wp_inline_script_attributes'),
		var_attributes.clone(),
		var_data.clone(),
	])
	var_processor = create_wp_html_tag_processor(rt.new_string('<script></script>'))
	var_processor.next_tag()
	mut iter_17 := var_attributes.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_value_shadow := item_17.val
		mut var_name_shadow := item_17.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
			var_processor.get_attribute(var_name_shadow.clone())))))
		{
			continue
		}
		var_processor.set_attribute(var_name_shadow.clone(), if !var_value_shadow.is_null() {
			var_value_shadow
		} else {
			rt.new_bool(true)
		})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_processor.set_modifiable_text(var_data.clone()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [rt.new_string('Unable to set inline script data.')]),
			rt.new_string('7.0.0')])
		return ''
	}
	return rt.concat(var_processor.get_updated_html(), rt.new_string('\n'))
}

fn wp_print_inline_script_tag(var_data rt.PhpVal, var_attributes rt.PhpVal) {
	print(wp_get_inline_script_tag(var_data.clone(), var_attributes.clone()))
}

fn wp_maybe_inline_styles() {
	mut var_wp_styles := rt.new_null()
	mut var_total_inline_limit := rt.new_null()
	mut var_styles := rt.new_null()
	mut var_handle := rt.new_null()
	mut var_src := rt.new_null()
	mut var_path := rt.new_null()
	mut var_size := rt.new_null()
	mut var_total_inline_size := i64(0)
	mut var_style := map[string]rt.PhpVal{}
	var_total_inline_limit = rt.new_int(40000)
	var_total_inline_limit = rt.call_function('apply_filters', [
		rt.new_string('styles_inline_size_limit'),
		var_total_inline_limit.clone(),
	])
	var_styles = rt.new_array()
	mut iter_18 := rt.get_property(var_wp_styles, 'queue').iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_handle_shadow := item_18.val
		if !(rt.get_property(var_wp_styles, 'registered').array_isset(var_handle_shadow)) {
			continue
		}
		var_src = rt.get_property(rt.get_property(var_wp_styles, 'registered').array_get(var_handle_shadow),
			'src')
		var_path = rt.call_method(var_wp_styles, 'get_data', [
			var_handle_shadow.clone(), rt.new_string('path')])
		if rt.is_true(var_path) && rt.is_true(var_src) {
			var_size = rt.call_function('wp_filesize', [var_path.clone()])
			if rt.is_true(rt.identical(rt.new_int(0), var_size))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_path.clone()]))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Unable to read the "%1$s" key with value "%2$s" for stylesheet "%3$s".'),
						]),
						rt.new_string('path'),
						rt.call_function('esc_html', [
							var_path.clone(),
						]),
						rt.call_function('esc_html', [
							var_handle_shadow.clone(),
						]),
					]),
					rt.new_string('7.0.0')])
				continue
			}
			var_styles.array_push(rt.create_array([
				rt.ArrayItem{ key: 'handle', val: var_handle_shadow },
				rt.ArrayItem{ key: 'src', val: var_src },
				rt.ArrayItem{ key: 'path', val: var_path },
				rt.ArrayItem{ key: 'size', val: var_size },
			]))
		}
	}
	if !(!rt.is_true(var_styles)) {
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return
		}
		rt.call_function('usort', [var_styles.clone(), rt.new_closure(closure_7_fn)])
		var_total_inline_size = 0
		mut iter_19 := var_styles.iterator()
		for {
			item_19 := iter_19.next() or { break }
			mut var_style_shadow := item_19.val
			if rt.is_true(rt.greater(rt.add(rt.new_int(var_total_inline_size),
				var_style_shadow['size']), var_total_inline_limit))
			{
				break
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [
				var_style_shadow['path'],
			])))))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Unable to read the "%1$s" key with value "%2$s" for stylesheet "%3$s".'),
						]),
						rt.new_string('path'),
						rt.call_function('esc_html', [
							var_style_shadow['path'],
						]),
						rt.call_function('esc_html', [
							var_style_shadow['handle'],
						]),
					]),
					rt.new_string('7.0.0')])
				continue
			}
			var_style_shadow['css'] = rt.call_function('file_get_contents',
				[var_style_shadow['path']])
			var_style_shadow['css'] = _wp_normalize_relative_css_links(var_style_shadow['css'],
				var_style_shadow['src'])
			rt.call_method(var_wp_styles, 'add_data', [var_style_shadow['handle'],
				rt.new_string('inlined_src'), var_style_shadow['src']])
			rt.set_property(rt.get_property(var_wp_styles, 'registered').array_get(var_style_shadow['handle']),
				'src', rt.new_bool(false))
			if !rt.is_true(rt.get_property(rt.get_property(var_wp_styles, 'registered').array_get(var_style_shadow['handle']),
				'extra').array_get(rt.new_string('after'))) {
				rt.get_property(rt.get_property(var_wp_styles, 'registered').array_get(var_style_shadow['handle']),
					'extra').array_set('after', rt.new_array())
			}
			rt.call_function('array_unshift', [rt.get_property(rt.get_property(var_wp_styles,
				'registered').array_get(var_style_shadow['handle']), 'extra').array_get(rt.new_string('after')),
				var_style_shadow['css']])
			var_total_inline_size = var_total_inline_size +
				rt.new_int((var_style_shadow['size']).to_i64())
		}
	}
}

fn _wp_normalize_relative_css_links(var_css rt.PhpVal, var_stylesheet_url rt.PhpVal) rt.PhpVal {
	closure_8_fn := fn [var_stylesheet_url] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_matches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_prefix := rt.new_null()
		mut list_tmp_1 := var_matches
		var_prefix = list_tmp_1.array_get(1)
		mut var_url := list_tmp_1.array_get(2)
		if rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('http:')]))
			|| rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('https:')]))
			|| rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('/')]))
			|| rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('#')]))
			|| rt.is_true(rt.call_function('str_starts_with', [var_url.clone(), rt.new_string('data:')])) {
			return var_matches.array_get(rt.new_int(0))
		}
		mut var_absolute_url := rt.new_string(
			(rt.call_function('dirname', [var_stylesheet_url.clone()])).str() + '/' + var_url.str())
		var_absolute_url = rt.call_function('str_replace', [rt.new_string('/./'),
			rt.new_string('/'), var_absolute_url.clone()])
		var_url = rt.call_function('wp_make_link_relative', [
			var_absolute_url.clone()])
		return rt.new_string(var_prefix.str() + var_url.str())
	}
	return rt.call_function('preg_replace_callback', [
		rt.new_string('#(url\\s*\\(\\s*[\'"]?\\s*)([^\'"\\)]+)#'),
		rt.new_closure(closure_8_fn),
		var_css.clone(),
	])
}

fn wp_enqueue_global_styles_css_custom_properties() {
	rt.call_function('wp_register_style', [
		rt.new_string('global-styles-css-custom-properties'),
		rt.new_bool(false),
	])
	rt.call_function('wp_add_inline_style', [
		rt.new_string('global-styles-css-custom-properties'),
		rt.call_function('wp_get_global_stylesheet', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'variables' }]),
		]),
	])
	rt.call_function('wp_enqueue_style', [
		rt.new_string('global-styles-css-custom-properties'),
	])
}

fn wp_enqueue_block_support_styles(var_style rt.PhpVal, priority i64) {
	mut var_priority := priority
	mut var_action_hook_name := ''
	var_action_hook_name = 'wp_footer'
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_action_hook_name = 'wp_head'
	}
	closure_9_fn := fn [var_style] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_processor := create_wp_html_tag_processor(rt.new_string('<style></style>'))
		var_processor.next_tag()
		var_processor.set_modifiable_text(var_style.clone())
		print(rt.concat(var_processor.get_updated_html(), rt.new_string('\n')))
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string(var_action_hook_name.str()).clone(),
		rt.new_closure(closure_9_fn), rt.new_int(priority)])
}

fn wp_enqueue_stored_styles(var_options rt.PhpVal) {
	mut var_is_block_theme := rt.new_null()
	mut var_is_classic_theme := false
	mut var_core_styles_keys := []rt.PhpVal{}
	mut var_compiled_core_stylesheet := ''
	mut var_style_tag_id := ''
	mut var_should_prettify := false
	mut var_style_key := rt.new_null()
	mut var_additional_stores := rt.new_null()
	mut var_store_name := rt.new_null()
	mut var_styles := rt.new_null()
	mut var_key := ''
	var_is_block_theme = rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	var_is_classic_theme = !(rt.is_true(var_is_block_theme))
	if (rt.is_true(var_is_block_theme)
		&& rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_footer')])))
		|| (var_is_classic_theme
		&& rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_enqueue_scripts')]))) {
		return
	}
	var_core_styles_keys = ['block-supports']
	var_compiled_core_stylesheet = ''
	var_style_tag_id = 'core'
	var_should_prettify = (if var_options.array_isset(rt.new_string('prettify')) {
		rt.identical(rt.new_bool(true), var_options.array_get(rt.new_string('prettify')))
	} else {
		rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
			&& rt.is_true(rt.get_constant('SCRIPT_DEBUG')))
	}).to_bool()
	for var_style_key_shadow in var_core_styles_keys {
		if var_should_prettify {
			var_compiled_core_stylesheet = var_compiled_core_stylesheet +
				'/**\n * Core styles: ${var_style_key.to_string()}\n */\n'
		}
		var_style_tag_id = var_style_tag_id + '-' +
			(rt.new_string(var_style_key_shadow.str())).str()
		var_compiled_core_stylesheet = var_compiled_core_stylesheet +(rt.call_function('wp_style_engine_get_stylesheet_from_context', [rt.new_string(var_style_key_shadow.str()).clone(), var_options.clone()])).str()
	}
	if !(var_compiled_core_stylesheet == '') {
		rt.call_function('wp_register_style', [rt.new_string(var_style_tag_id.str()).clone(),
			rt.new_bool(false)])
		rt.call_function('wp_add_inline_style', [rt.new_string(var_style_tag_id.str()).clone(),
			rt.new_string(var_compiled_core_stylesheet.str()).clone()])
		rt.call_function('wp_enqueue_style', [rt.new_string(var_style_tag_id.str()).clone()])
	}
	mut iife_temp_9 := Class_WP_Style_Engine_CSS_Rules_Store{}
	mut iife_result_9 := iife_temp_9.get_stores()
	var_additional_stores = iife_result_9
	mut iter_20 := rt.func_array_keys(var_additional_stores.clone()).iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_store_name_shadow := item_20.val
		if rt.is_true(rt.call_function('in_array', [var_store_name_shadow.clone(),
			rt.create_array_from_list(var_core_styles_keys), rt.new_bool(true)]))
		{
			continue
		}
		var_styles = rt.call_function('wp_style_engine_get_stylesheet_from_context', [
			var_store_name_shadow.clone(),
			var_options.clone(),
		])
		if !(!rt.is_true(var_styles)) {
			var_key = 'wp-style-engine-${var_store_name.to_string()}'
			rt.call_function('wp_register_style', [rt.new_string(var_key.str()).clone(),
				rt.new_bool(false)])
			rt.call_function('wp_add_inline_style', [rt.new_string(var_key.str()).clone(),
				var_styles.clone()])
			rt.call_function('wp_enqueue_style', [rt.new_string(var_key.str()).clone()])
		}
	}
}

fn wp_enqueue_block_style(var_block_name rt.PhpVal, var_args_arg rt.PhpVal) {
	mut var_args := var_args_arg
	mut var_callback := rt.new_null()
	mut var_hook := ''
	mut var_callback_separate := rt.new_null()
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'handle', val: '' },
			rt.ArrayItem{ key: 'src', val: '' }, rt.ArrayItem{ key: 'deps', val: rt.new_array() },
			rt.ArrayItem{ key: 'ver', val: false }, rt.ArrayItem{ key: 'media', val: 'all' }])])
	closure_11_fn := fn [var_args] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_content := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(!rt.is_true(var_args.array_get(rt.new_string('src')))) {
			rt.call_function('wp_register_style', [var_args.array_get(rt.new_string('handle')),
				var_args.array_get(rt.new_string('src')), var_args.array_get(rt.new_string('deps')),
				var_args.array_get(rt.new_string('ver')), var_args.array_get(rt.new_string('media'))])
		}
		if var_args.array_isset(rt.new_string('path')) {
			rt.call_function('wp_style_add_data', [var_args.array_get(rt.new_string('handle')),
				rt.new_string('path'), var_args.array_get(rt.new_string('path'))])
			mut var_rtl_file_path := rt.call_function('str_replace', [
				rt.new_string('.css'),
				rt.new_string('-rtl.css'),
				var_args.array_get(rt.new_string('path')),
			])
			if rt.is_true(rt.call_function('file_exists', [var_rtl_file_path.clone()])) {
				rt.call_function('wp_style_add_data', [
					var_args.array_get(rt.new_string('handle')),
					rt.new_string('rtl'),
					rt.new_string('replace'),
				])
				if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
					rt.call_function('wp_style_add_data', [
						var_args.array_get(rt.new_string('handle')),
						rt.new_string('path'),
						var_rtl_file_path.clone(),
					])
				}
			}
		}
		rt.call_function('wp_enqueue_style', [var_args.array_get(rt.new_string('handle'))])
		return
	}
	var_callback = rt.new_closure(closure_11_fn)
	var_hook = if rt.is_true(rt.call_function('did_action', [
		rt.new_string('wp_enqueue_scripts'),
	]))
	{ 'wp_footer' } else { 'wp_enqueue_scripts' }
	if rt.is_true(rt.new_bool(wp_should_load_block_assets_on_demand())) {
		closure_12_fn := fn [var_block_name, var_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_content := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			if !(!rt.is_true(var_block.array_get(rt.new_string('blockName'))))
				&& rt.is_true(rt.identical(var_block_name, var_block.array_get(rt.new_string('blockName')))) {
				return
			}
			return
		}
		var_callback_separate = rt.new_closure(closure_12_fn)
		rt.call_function('add_filter', [rt.new_string('render_block'),
			var_callback_separate.clone(), rt.new_int(10), rt.new_int(2)])
		return
	}
	rt.call_function('add_filter', [rt.new_string(var_hook.str()).clone(),
		var_callback.clone()])
	rt.call_function('add_action', [rt.new_string('enqueue_block_assets'),
		var_callback.clone()])
}

fn wp_enqueue_classic_theme_styles() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json',
		[]rt.PhpVal{})))))
	{
		rt.call_function('wp_enqueue_style', [rt.new_string('classic-theme-styles')])
	}
}

fn wp_enqueue_command_palette_assets() {
	mut var_menu := rt.new_null()
	mut var_submenu := rt.new_null()
	mut var_command_palette_settings := map[string]rt.PhpVal{}
	mut var_extract_root_text := rt.new_null()
	mut var_menu_commands := []rt.PhpVal{}
	mut var_menu_item := []rt.PhpVal{}
	mut var_menu_label := rt.new_null()
	mut var_menu_url := rt.new_null()
	mut var_menu_slug := rt.new_null()
	mut var_submenu_item := []rt.PhpVal{}
	mut var_submenu_label := rt.new_null()
	mut var_submenu_url := rt.new_null()
	mut var_submenu_slug := rt.new_null()
	var_command_palette_settings = {
		'is_network_admin': rt.call_function('is_network_admin', []rt.PhpVal{})
	}
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_label := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string(''), var_label)) {
			return
		}
		mut var_processor := create_wp_html_tag_processor(var_label.clone())
		mut var_text_parts := rt.new_array()
		mut var_depth := rt.new_int(0)
		for rt.is_true(var_processor.next_token()) {
			mut var_token_type := var_processor.get_token_type()
			if rt.is_true(rt.identical(rt.new_string('#text'), var_token_type)) {
				if rt.is_true(rt.identical(rt.new_int(0), var_depth)) {
					var_text_parts.array_push(var_processor.get_modifiable_text())
				}
				continue
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('#tag'),
				var_token_type))))
			{
				continue
			}
			if rt.is_true(var_processor.is_tag_closer()) {
				if rt.is_true(rt.greater(var_depth, rt.new_int(0))) {
					rt.pre_dec(var_depth)
				}
				continue
			}
			mut var_token_name := var_processor.get_tag()
			mut iife_temp_13 := Class_WP_HTML_Processor{}
			mut iife_result_13 := iife_temp_13.is_void(var_token_name.clone())
			if rt.is_true(var_token_name) && rt.is_true(rt.new_bool(!(rt.is_true(iife_result_13)))) {
				rt.pre_inc(var_depth)
			}
		}
		return
	}
	var_extract_root_text = rt.new_closure(closure_14_fn)
	if rt.is_true(var_menu) {
		var_menu_commands = rt.new_array()
		mut iter_21 := var_menu.iterator()
		for {
			item_21 := iter_21.next() or { break }
			mut var_menu_item_shadow := item_21.val
			if !rt.is_true(var_menu_item_shadow[0])
				|| !(var_menu_item_shadow[0].is_string())
				|| (!(!rt.is_true(var_menu_item_shadow[1]))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_menu_item_shadow[1]])))))) {
				continue
			}
			var_menu_label = rt.call_callable(var_extract_root_text, [var_menu_item_shadow[0]])
			var_menu_url = rt.new_string('')
			var_menu_slug = var_menu_item_shadow[2]
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.php($|\\?)/'), var_menu_slug.clone()]))
				|| rt.is_true(rt.call_function('wp_http_validate_url', [var_menu_slug.clone()])) {
				var_menu_url = var_menu_slug.clone()
			} else if !(!rt.is_true(rt.call_function('menu_page_url', [
				var_menu_slug.clone(), rt.new_bool(false)]))) {
				mut iife_temp_14 := Class_WP_HTML_Decoder{}
				mut iife_result_14 := iife_temp_14.decode_attribute(rt.call_function('menu_page_url', [
					var_menu_slug.clone(),
					rt.new_bool(false),
				]))
				var_menu_url = iife_result_14
			}
			if rt.is_true(var_menu_url) {
				var_menu_commands << rt.create_array([
					rt.ArrayItem{ key: 'label', val: var_menu_label },
					rt.ArrayItem{ key: 'url', val: var_menu_url },
					rt.ArrayItem{ key: 'name', val: var_menu_slug },
				])
			}
			if rt.is_true(rt.new_bool(var_submenu.clone().array_isset(var_menu_slug.clone()))) {
				mut iter_22 := var_submenu.array_get(var_menu_slug).iterator()
				for {
					item_22 := iter_22.next() or { break }
					mut var_submenu_item_shadow := item_22.val
					if !rt.is_true(var_submenu_item_shadow[0])
						|| (!(!rt.is_true(var_submenu_item_shadow[1]))
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_submenu_item_shadow[1]])))))) {
						continue
					}
					var_submenu_label = rt.call_callable(var_extract_root_text,
						[var_submenu_item_shadow[0]])
					var_submenu_url = rt.new_string('')
					var_submenu_slug = var_submenu_item_shadow[2]
					if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\.php($|\\?)/'), var_submenu_slug.clone()]))
						|| rt.is_true(rt.call_function('wp_http_validate_url', [var_submenu_slug.clone()])) {
						var_submenu_url = var_submenu_slug.clone()
					} else if !(!rt.is_true(rt.call_function('menu_page_url', [
						var_submenu_slug.clone(),
						rt.new_bool(false),
					]))) {
						mut iife_temp_15 := Class_WP_HTML_Decoder{}
						mut iife_result_15 := iife_temp_15.decode_attribute(rt.call_function('menu_page_url', [
							var_submenu_slug.clone(),
							rt.new_bool(false),
						]))
						var_submenu_url = iife_result_15
					}
					if rt.is_true(var_submenu_url) {
						var_menu_commands << rt.create_array([
							rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
								rt.call_function('__', [rt.new_string('%1$s > %2$s')]),
								var_menu_label.clone(),
								var_submenu_label.clone(),
							]) },
							rt.ArrayItem{ key: 'url', val: var_submenu_url },
							rt.ArrayItem{ key: 'name', val: var_menu_slug.str() + '-' +
								(var_submenu_item_shadow[2]).str() },
						])
					}
				}
			}
		}
		var_command_palette_settings['menu_commands'] = var_menu_commands.clone()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-commands')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-commands')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-core-commands')])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-core-commands'),
		rt.call_function('sprintf', [
			rt.new_string('wp.coreCommands.initializeCommandPalette( %s );'),
			rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_command_palette_settings),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])])
}

fn wp_remove_surrounding_empty_script_tags(var_contents_arg rt.PhpVal) rt.PhpVal {
	mut var_contents := var_contents_arg
	mut var_opener := ''
	mut var_closer := ''
	mut var_error_message := rt.new_null()
	var_contents = var_contents.trim_space()
	var_opener = '<SCRIPT>'
	var_closer = '</SCRIPT>'
	if var_contents.len > var_opener.len + var_closer.len
		&& rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [rt.new_string(var_contents.str()).clone(), rt.new_int(0), rt.new_int(var_opener.len)]).to_string().to_upper()), rt.new_string(var_opener.str())))
		&& rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [rt.new_string(var_contents.str()).clone(), rt.new_int(-var_closer.len)]).to_string().to_upper()), rt.new_string(var_closer.str()))) {
		return rt.call_function('substr', [rt.new_string(var_contents.str()).clone(),
			rt.new_int(var_opener.len), rt.new_int(-var_closer.len)])
	} else {
		var_error_message = rt.call_function('__', [
			rt.new_string('Expected string to start with script tag (without attributes) and end with script tag, with optional whitespace.'),
		])
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			var_error_message.clone(), rt.new_string('6.4')])
		return rt.call_function('sprintf', [rt.new_string('console.error(%s)'),
			rt.call_function('wp_json_encode', [
				rt.new_string(
					(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Function %s used incorrectly in PHP.')]), rt.new_string('wp_remove_surrounding_empty_script_tags()')])).str() +
					' ' + var_error_message.str()),
			])])
	}
	return rt.new_null()
}

fn wp_load_classic_theme_block_styles_on_demand() {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('wp_should_output_buffer_template_for_enhancement'),
		rt.new_string('__return_true'),
		rt.new_int(0),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_output_buffer_template_for_enhancement',
		[]rt.PhpVal{})))))
	{
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('should_load_separate_core_block_assets'),
		rt.new_string('__return_true'),
		rt.new_int(0),
	])
	if !(wp_should_load_separate_core_block_assets()) {
		return
	}
	rt.call_function('add_filter', [rt.new_string('should_load_block_assets_on_demand'),
		rt.new_string('__return_true'), rt.new_int(0)])
	if !(wp_should_load_block_assets_on_demand()) {
		return
	}
	rt.call_function('add_action', [
		rt.new_string('wp_template_enhancement_output_buffer_started'),
		rt.new_string('wp_hoist_late_printed_styles'),
	])
}

fn wp_hoist_late_printed_styles() {
	mut var_placeholder := rt.new_null()
	mut var_dependency := rt.new_null()
	mut var_printed_core_block_styles := ''
	mut var_printed_other_block_styles := ''
	mut var_printed_global_styles := ''
	mut var_printed_late_styles := ''
	mut var_capture_late_styles := rt.new_null()
	mut var_wp_print_footer_scripts_priority := rt.new_null()
	if rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})) {
		return
	}
	var_placeholder = rt.call_function('sprintf', [rt.new_string('/*%s*/'),
		rt.call_function('uniqid', [
			rt.new_string('wp_block_styles_on_demand_placeholder:'),
		])])
	var_dependency = rt.call_method(rt.call_function('wp_styles', []rt.PhpVal{}), 'query', [
		rt.new_string('wp-block-library'),
		rt.new_string('registered'),
	])
	if rt.is_true(var_dependency) {
		if !(rt.get_property(var_dependency, 'extra').array_isset(rt.new_string('after'))) {
			rt.call_function('wp_add_inline_style', [rt.new_string('wp-block-library'),
				var_placeholder.clone()])
		} else {
			rt.call_function('array_unshift', [rt.get_property(var_dependency, 'extra').array_get(rt.new_string('after')),
				var_placeholder.clone()])
		}
	}
	var_printed_core_block_styles = ''
	var_printed_other_block_styles = ''
	var_printed_global_styles = ''
	var_printed_late_styles = ''
	closure_18_fn := fn [mut var_printed_core_block_styles, mut var_printed_other_block_styles, mut var_printed_global_styles, mut var_printed_late_styles] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_all_core_block_style_handles := rt.new_array()
		mut var_all_other_block_style_handles := rt.new_array()
		mut iife_temp_17 := Class_WP_Block_Type_Registry{}
		mut iife_result_17 := iife_temp_17.get_instance()
		mut iter_23 :=
			rt.call_method(iife_result_17, 'get_all_registered', []rt.PhpVal{}).iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_block_type := item_23.val
			if rt.is_true(rt.call_function('str_starts_with', [
				rt.get_property(var_block_type, 'name'),
				rt.new_string('core/'),
			]))
			{
				mut iter_24 := rt.get_property(var_block_type, 'style_handles').iterator()
				for {
					item_24 := iter_24.next() or { break }
					mut var_style_handle := item_24.val
					var_all_core_block_style_handles.array_push(var_style_handle.clone())
				}
			} else {
				mut iter_25 := rt.get_property(var_block_type, 'style_handles').iterator()
				for {
					item_25 := iter_25.next() or { break }
					mut var_style_handle := item_25.val
					var_all_other_block_style_handles.array_push(var_style_handle.clone())
				}
			}
		}
		mut var_enqueued_core_block_styles := rt.call_function('array_values', [
			rt.call_function('array_intersect', [var_all_core_block_style_handles.clone(),
				rt.get_property(rt.call_function('wp_styles', []rt.PhpVal{}), 'queue')]),
		])
		if var_enqueued_core_block_styles.clone().array_count() > 0 {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_method(rt.call_function('wp_styles', []rt.PhpVal{}), 'do_items', [
				var_enqueued_core_block_styles.clone(),
			])
			var_printed_core_block_styles = (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
		}
		mut var_enqueued_other_block_styles := rt.call_function('array_values', [
			rt.call_function('array_intersect', [var_all_other_block_style_handles.clone(),
				rt.get_property(rt.call_function('wp_styles', []rt.PhpVal{}), 'queue')]),
		])
		if var_enqueued_other_block_styles.clone().array_count() > 0 {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_method(rt.call_function('wp_styles', []rt.PhpVal{}), 'do_items', [
				var_enqueued_other_block_styles.clone(),
			])
			var_printed_other_block_styles = (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
		}
		if rt.is_true(rt.call_function('wp_style_is', [rt.new_string('global-styles')])) {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_method(rt.call_function('wp_styles', []rt.PhpVal{}), 'do_items', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'global-styles' }]),
			])
			var_printed_global_styles = (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_method(rt.call_function('wp_styles', []rt.PhpVal{}), 'do_footer_items',
			[]rt.PhpVal{})
		var_printed_late_styles = (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
		return rt.new_null()
	}
	var_capture_late_styles = rt.new_closure(closure_18_fn)
	var_wp_print_footer_scripts_priority = rt.call_function('has_action', [
		rt.new_string('wp_print_footer_scripts'),
		rt.new_string('_wp_footer_scripts'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_wp_print_footer_scripts_priority))
		|| rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_action', [rt.new_string('wp_footer'), rt.new_string('wp_print_footer_scripts')]))) {
		rt.call_function('add_action', [rt.new_string('wp_footer'),
			var_capture_late_styles.clone(), rt.new_int(20)])
	} else {
		rt.call_function('remove_action', [rt.new_string('wp_print_footer_scripts'),
			rt.new_string('_wp_footer_scripts'), var_wp_print_footer_scripts_priority.clone()])
		closure_19_fn := fn [var_capture_late_styles] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_callable(var_capture_late_styles, []rt.PhpVal{})
			print_footer_scripts()
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
			rt.new_closure(closure_19_fn), var_wp_print_footer_scripts_priority.clone()])
	}
	closure_20_fn := fn [var_placeholder, mut var_printed_core_block_styles, mut var_printed_other_block_styles, mut var_printed_global_styles, mut var_printed_late_styles] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_buffer := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_processor := rt.create_object_dynamically(rt.new_null(), [
			var_buffer.clone()])
		for rt.is_true(var_processor.next_tag(rt.create_array([rt.ArrayItem, {
			key: 'tag_closers'
			val: 'visit'
		}]))) {
			if rt.is_true(rt.identical(rt.new_string('STYLE'), var_processor.get_tag()))
				&& rt.is_true(rt.identical(rt.new_string('wp-global-styles-placeholder-inline-css'), var_processor.get_attribute(rt.new_string('id')))) {
				var_processor.set_bookmark(rt.new_string('wp_global_styles_placeholder'))
			} else if rt.is_true(rt.identical(rt.new_string('STYLE'), var_processor.get_tag()))
				&& rt.is_true(rt.identical(rt.new_string('wp-block-styles-placeholder-inline-css'), var_processor.get_attribute(rt.new_string('id')))) {
				var_processor.set_bookmark(rt.new_string('wp_block_styles_placeholder'))
			} else if rt.is_true(rt.identical(rt.new_string('STYLE'), var_processor.get_tag()))
				&& rt.is_true(rt.identical(rt.new_string('wp-block-library-inline-css'), var_processor.get_attribute(rt.new_string('id')))) {
				var_processor.set_bookmark(rt.new_string('wp_block_library'))
			} else if rt.is_true(rt.identical(rt.new_string('HEAD'), var_processor.get_tag()))
				&& rt.is_true(var_processor.is_tag_closer()) {
				var_processor.set_bookmark(rt.new_string('head_end'))
				break
			}
		}
		if rt.is_true(var_processor.has_bookmark(rt.new_string('wp_global_styles_placeholder'))) {
			var_processor.seek(rt.new_string('wp_global_styles_placeholder'))
			var_processor.replace(rt.new_string(var_printed_global_styles.str()))
			var_printed_global_styles = ''
		}
		if rt.is_true(var_processor.has_bookmark(rt.new_string('wp_block_library'))) {
			var_processor.seek(rt.new_string('wp_block_library'))
			mut var_css_text := var_processor.get_modifiable_text()
			mut var_css_text_around_placeholder := rt.call_function('explode', [
				var_placeholder.clone(),
				var_css_text.clone(),
				rt.new_int(2),
			])
			mut var_extra_inline_styles := rt.new_string('')
			if var_css_text_around_placeholder.clone().array_count() == 2 {
				var_css_text = var_css_text_around_placeholder.array_get(rt.new_int(0))
				if rt.is_true(rt.new_bool('' != var_css_text.clone().to_string().trim_space())) {
					mut var_inlined_src := rt.call_method(rt.call_function('wp_styles',
						[]rt.PhpVal{}), 'get_data', [rt.new_string('wp-block-library'),
						rt.new_string('inlined_src')])
					if rt.is_true(var_inlined_src) {
						var_css_text = rt.concat(var_css_text, rt.call_function('sprintf', [
							rt.new_string('\n/*# sourceURL=%s */\n'),
							rt.call_function('esc_url_raw', [
								var_inlined_src.clone()]),
						]))
					}
				}
				var_extra_inline_styles = var_css_text_around_placeholder.array_get(rt.new_int(1))
			}
			if rt.is_true(rt.identical(rt.new_string(''),
				rt.new_string(var_css_text.clone().to_string().trim_space())))
			{
				var_processor.remove()
			} else {
				var_processor.set_modifiable_text(var_css_text.clone())
			}
			mut var_inserted_after := rt.new_string(var_printed_core_block_styles.str()).clone()
			var_printed_core_block_styles = ''
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
				rt.new_string(':^\\s*(/\\*# sourceURL=\\S+? \\*/\\s*)?$:s'),
				var_extra_inline_styles.clone(),
			])))))
			{
				mut var_style_processor :=
					create_wp_html_tag_processor(rt.new_string('<style></style>'))
				rt.call_method(var_style_processor, 'next_tag', []rt.PhpVal{})
				rt.call_method(var_style_processor, 'set_attribute', [
					rt.new_string('id'),
					rt.new_string('wp-block-library-inline-css-extra'),
				])
				rt.call_method(var_style_processor, 'set_modifiable_text', [
					var_extra_inline_styles.clone()])
				var_inserted_after = rt.concat(var_inserted_after, rt.concat(rt.call_method(var_style_processor,
					'get_updated_html', []rt.PhpVal{}), rt.new_string('\n')))
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
				var_inserted_after))))
			{
				var_processor.insert_after(rt.new_string('\n' + var_inserted_after.str()))
			}
		}
		if rt.is_true(var_processor.has_bookmark(rt.new_string('wp_block_styles_placeholder'))) {
			var_processor.seek(rt.new_string('wp_block_styles_placeholder'))
			if rt.is_true(rt.new_bool('' != rt.new_string(var_printed_other_block_styles.str()))) {
				var_processor.replace(rt.new_string('\n' +
					rt.new_string(var_printed_other_block_styles.str())))
			} else {
				var_processor.remove()
			}
			var_printed_other_block_styles = ''
		}
		mut var_remaining_styles := rt.new_string(var_printed_core_block_styles.str()) +
			rt.new_string(var_printed_other_block_styles.str()) +
			rt.new_string(var_printed_global_styles.str()) +
			rt.new_string(var_printed_late_styles.str())
		if rt.is_true(var_remaining_styles)
			&& rt.is_true(var_processor.has_bookmark(rt.new_string('head_end'))) {
			var_processor.seek(rt.new_string('head_end'))
			var_processor.insert_before(rt.new_string(var_remaining_styles.str() + '\n'))
		}
		return
	}
	rt.call_function('add_filter', [
		rt.new_string('wp_template_enhancement_output_buffer'),
		rt.new_closure(closure_20_fn),
	])
}

fn wp_js_dataset_name(html_attribute_name string) string {
	mut var_html_attribute_name := html_attribute_name
	mut var_end := i64(0)
	mut var_custom_name := ''
	mut var_at := rt.new_null()
	mut var_was_at := rt.new_null()
	mut var_next_dash_at := rt.new_null()
	mut var_c := rt.new_null()
	mut var_prefix := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [
		rt.new_string(html_attribute_name),
		rt.new_string('data-'),
		rt.new_int(0),
		rt.new_int(5),
		rt.new_bool(true),
	])))))
	{
		return (rt.new_null()).str()
	}
	var_end = html_attribute_name.len
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_end - 5, rt.call_function('strcspn', [
		rt.new_string(html_attribute_name),
		rt.new_string('=/> \t\r\n'),
		rt.new_int(5),
	])))))
	{
		return (rt.new_null()).str()
	}
	var_custom_name = ''
	var_at = rt.new_int(5)
	var_was_at = var_at.clone()
	for rt.is_true(rt.less(var_at, rt.new_int(var_end))) {
		var_next_dash_at = rt.call_function('strpos', [
			rt.new_string(html_attribute_name),
			rt.new_string('-'),
			var_at.clone(),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_next_dash_at))
			|| rt.is_true(rt.identical(var_next_dash_at, var_end - 1)) {
			break
		}
		var_c =
			rt.new_string(html_attribute_name).array_get(rt.add(var_next_dash_at, rt.new_int(1)))
		if (rt.is_true(rt.greater_equal(var_c, rt.new_string('A')))
			&& rt.is_true(rt.less_equal(var_c, rt.new_string('Z'))))
			|| (rt.is_true(rt.greater_equal(var_c, rt.new_string('a')))
			&& rt.is_true(rt.less_equal(var_c, rt.new_string('z')))) {
			var_prefix = rt.call_function('substr', [rt.new_string(html_attribute_name),
				var_was_at.clone(), rt.sub(var_next_dash_at, var_was_at)])
			var_custom_name = var_custom_name + var_prefix.clone().to_string().to_lower()
			var_custom_name = var_custom_name + var_c.clone().to_string().to_upper()
			var_at = rt.add(var_next_dash_at, rt.new_int(2))
			var_was_at = var_at.clone()
			continue
		}
		var_at = rt.add(var_next_dash_at, rt.new_int(1))
	}
	return if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_custom_name.str()))) {
		rt.call_function('substr', [rt.new_string(html_attribute_name),
			rt.new_int(5)]).to_string().to_lower()
	} else {
		var_custom_name +
			rt.call_function('substr', [rt.new_string(html_attribute_name), var_was_at.clone()]).to_string().to_lower()
	}
}

fn wp_html_custom_data_attribute_name(js_dataset_name string) string {
	mut var_js_dataset_name := js_dataset_name
	mut var_end := i64(0)
	mut var_html_name := ''
	mut var_at := rt.new_null()
	mut var_was_at := rt.new_null()
	mut var_next_upper_after := rt.new_null()
	mut var_next_upper_at := rt.new_null()
	mut var_prefix := rt.new_null()
	var_end = js_dataset_name.len
	if 0 == var_end {
		return 'data-'
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strcspn', [
		rt.new_string(js_dataset_name),
		rt.new_string('=/> \t\r\n'),
	]), rt.new_int(var_end)))))
	{
		return (rt.new_null()).str()
	}
	var_html_name = 'data-'
	var_at = rt.new_int(0)
	var_was_at = var_at.clone()
	for rt.is_true(rt.less(var_at, rt.new_int(var_end))) {
		var_next_upper_after = rt.call_function('strcspn', [
			rt.new_string(js_dataset_name),
			rt.new_string('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
			var_at.clone(),
		])
		var_next_upper_at = rt.add(var_at, var_next_upper_after)
		if rt.is_true(rt.greater_equal(var_next_upper_at, rt.new_int(var_end))) {
			break
		}
		var_prefix = rt.call_function('substr', [rt.new_string(js_dataset_name),
			var_was_at.clone(), rt.sub(var_next_upper_at, var_was_at)])
		var_html_name = var_html_name + var_prefix.clone().to_string().to_lower()
		var_html_name = var_html_name + '-' +
			rt.new_string(js_dataset_name).array_get(var_next_upper_at).to_string().to_lower()
		var_at = rt.add(var_next_upper_at, rt.new_int(1))
		var_was_at = var_at.clone()
	}
	if rt.is_true(rt.less(var_was_at, rt.new_int(var_end))) {
		var_html_name = var_html_name +
			rt.call_function('substr', [rt.new_string(js_dataset_name), var_was_at.clone()]).to_string().to_lower()
	}
	return var_html_name
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_WP_Community_Events {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_Styles_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Style_Engine_CSS_Rules_Store {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Processor {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Decoder {
	rt.PhpObjectBase
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone(_args ...rt.PhpVal) &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_community_events(_args ...rt.PhpVal) &Class_WP_Community_Events {
	mut obj := &Class_WP_Community_Events{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_styles_registry(_args ...rt.PhpVal) &Class_WP_Block_Styles_Registry {
	mut obj := &Class_WP_Block_Styles_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_style_engine_css_rules_store(_args ...rt.PhpVal) &Class_WP_Style_Engine_CSS_Rules_Store {
	mut obj := &Class_WP_Style_Engine_CSS_Rules_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_processor(_args ...rt.PhpVal) &Class_WP_HTML_Processor {
	mut obj := &Class_WP_HTML_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_decoder(_args ...rt.PhpVal) &Class_WP_HTML_Decoder {
	mut obj := &Class_WP_HTML_Decoder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Community_Events) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Community_Events) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Community_Events) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Styles_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Style_Engine_CSS_Rules_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Style_Engine_CSS_Rules_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Decoder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Decoder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Decoder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_func('wp_register_tinymce_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return wp_register_tinymce_scripts(arg_0, arg_1)
	})
	rt.register_func('wp_default_packages_vendor', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages_vendor(arg_0)
	})
	rt.register_func('wp_register_development_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_register_development_scripts(arg_0)
	})
	rt.register_func('wp_get_script_polyfill', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(wp_get_script_polyfill(arg_0, arg_1))
	})
	rt.register_func('wp_default_packages_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages_scripts(arg_0)
	})
	rt.register_func('wp_default_packages_inline_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages_inline_scripts(arg_0)
	})
	rt.register_func('wp_tinymce_inline_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_tinymce_inline_scripts()
	})
	rt.register_func('wp_default_packages', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages(arg_0)
	})
	rt.register_func('wp_scripts_get_suffix', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return wp_scripts_get_suffix(arg_0)
	})
	rt.register_func('wp_default_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_scripts(arg_0)
	})
	rt.register_func('wp_default_styles', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_styles(arg_0)
	})
	rt.register_func('wp_prototype_before_jquery', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_prototype_before_jquery(arg_0)
	})
	rt.register_func('wp_just_in_time_script_localization', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_just_in_time_script_localization()
	})
	rt.register_func('wp_localize_jquery_ui_datepicker', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_localize_jquery_ui_datepicker()
	})
	rt.register_func('wp_localize_community_events', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_localize_community_events()
	})
	rt.register_func('wp_style_loader_src', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(wp_style_loader_src(arg_0, arg_1))
	})
	rt.register_func('print_head_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return print_head_scripts()
	})
	rt.register_func('print_footer_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return print_footer_scripts()
	})
	rt.register_func('_print_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return _print_scripts()
	})
	rt.register_func('wp_print_head_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_print_head_scripts()
	})
	rt.register_func('_wp_footer_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return _wp_footer_scripts()
	})
	rt.register_func('wp_print_footer_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_print_footer_scripts()
	})
	rt.register_func('wp_enqueue_scripts', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_scripts()
	})
	rt.register_func('print_admin_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return print_admin_styles()
	})
	rt.register_func('print_late_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return print_late_styles()
	})
	rt.register_func('_print_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return _print_styles()
	})
	rt.register_func('script_concat_settings', fn (args []rt.PhpVal) rt.PhpVal {
		return script_concat_settings()
	})
	rt.register_func('wp_common_block_scripts_and_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_common_block_scripts_and_styles()
	})
	rt.register_func('wp_filter_out_block_nodes', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_filter_out_block_nodes(arg_0)
	})
	rt.register_func('wp_enqueue_global_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_global_styles()
	})
	rt.register_func('wp_should_load_block_editor_scripts_and_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_should_load_block_editor_scripts_and_styles()
	})
	rt.register_func('wp_should_load_separate_core_block_assets', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_should_load_separate_core_block_assets())
	})
	rt.register_func('wp_should_load_block_assets_on_demand', fn (args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_should_load_block_assets_on_demand())
	})
	rt.register_func('wp_enqueue_registered_block_scripts_and_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_registered_block_scripts_and_styles()
	})
	rt.register_func('enqueue_block_styles_assets', fn (args []rt.PhpVal) rt.PhpVal {
		return enqueue_block_styles_assets()
	})
	rt.register_func('enqueue_editor_block_styles_assets', fn (args []rt.PhpVal) rt.PhpVal {
		return enqueue_editor_block_styles_assets()
	})
	rt.register_func('wp_enqueue_editor_block_directory_assets', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_editor_block_directory_assets()
	})
	rt.register_func('wp_enqueue_editor_format_library_assets', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_editor_format_library_assets()
	})
	rt.register_func('wp_get_script_tag', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wp_get_script_tag(arg_0))
	})
	rt.register_func('wp_print_script_tag', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_print_script_tag(arg_0)
	})
	rt.register_func('wp_get_inline_script_tag', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(wp_get_inline_script_tag(arg_0, arg_1))
	})
	rt.register_func('wp_print_inline_script_tag', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_print_inline_script_tag(arg_0, arg_1)
	})
	rt.register_func('wp_maybe_inline_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_maybe_inline_styles()
	})
	rt.register_func('_wp_normalize_relative_css_links', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _wp_normalize_relative_css_links(arg_0, arg_1)
	})
	rt.register_func('wp_enqueue_global_styles_css_custom_properties', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_global_styles_css_custom_properties()
	})
	rt.register_func('wp_enqueue_block_support_styles', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return wp_enqueue_block_support_styles(arg_0, arg_1)
	})
	rt.register_func('wp_enqueue_stored_styles', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_enqueue_stored_styles(arg_0)
	})
	rt.register_func('wp_enqueue_block_style', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_enqueue_block_style(arg_0, arg_1)
	})
	rt.register_func('wp_enqueue_classic_theme_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_classic_theme_styles()
	})
	rt.register_func('wp_enqueue_command_palette_assets', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_command_palette_assets()
	})
	rt.register_func('wp_remove_surrounding_empty_script_tags', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_remove_surrounding_empty_script_tags(arg_0)
	})
	rt.register_func('wp_load_classic_theme_block_styles_on_demand', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_load_classic_theme_block_styles_on_demand()
	})
	rt.register_func('wp_hoist_late_printed_styles', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_hoist_late_printed_styles()
	})
	rt.register_func('wp_js_dataset_name', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(wp_js_dataset_name(arg_0))
	})
	rt.register_func('wp_html_custom_data_attribute_name', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(wp_html_custom_data_attribute_name(arg_0))
	})
	rt.register_class_factory('DateTime', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_datetime()
		return rt.new_object('DateTime', []string{}, obj)
	})
	rt.register_class_factory('DateTimeZone', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_datetimezone()
		return rt.new_object('DateTimeZone', []string{}, obj)
	})
	rt.register_class_factory('WP_Community_Events', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_community_events()
		return rt.new_object('WP_Community_Events', []string{}, obj)
	})
	rt.register_class_factory('WP_HTML_Tag_Processor', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_html_tag_processor()
		return rt.new_object('WP_HTML_Tag_Processor', []string{}, obj)
	})
	rt.register_class_factory('WP_Block_Type_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_type_registry()
		return rt.new_object('WP_Block_Type_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Block_Styles_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_styles_registry()
		return rt.new_object('WP_Block_Styles_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Style_Engine_CSS_Rules_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_style_engine_css_rules_store()
		return rt.new_object('WP_Style_Engine_CSS_Rules_Store', []string{}, obj)
	})
	rt.register_class_factory('WP_HTML_Processor', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_html_processor()
		return rt.new_object('WP_HTML_Processor', []string{}, obj)
	})
	rt.register_class_factory('WP_HTML_Decoder', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_html_decoder()
		return rt.new_object('WP_HTML_Decoder', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-dependency.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-dependencies.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-scripts.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.wp-scripts.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-styles.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.wp-styles.php',
		'3')
}
