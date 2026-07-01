import rt

fn wp_register_tinymce_scripts(var_scripts rt.PhpVal, force_uncompressed bool) {
	mut var_tinymce_version := rt.new_null()
	mut var_concatenate_scripts := rt.new_null()
	mut var_compress_scripts := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_suffix := wp_scripts_get_suffix('')
	mut var_dev_suffix := wp_scripts_get_suffix('dev')
	script_concat_settings()
	mut var_compressed := rt.is_true(rt.new_bool(rt.is_true(var_compress_scripts) && rt.is_true(var_concatenate_scripts))) && !(var_force_uncompressed)
	if var_compressed {
		rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce'), (rt.call_function('includes_url', [rt.new_string('js/tinymce/')])).str() + 'wp-tinymce.js', rt.new_array(), var_tinymce_version.dup()])
	} else {
		rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce-root'), (rt.call_function('includes_url', [rt.new_string('js/tinymce/')])).str() + "tinymce${var_dev_suffix.to_string()}.js", rt.new_array(), var_tinymce_version.dup()])
		rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce'), (rt.call_function('includes_url', [rt.new_string('js/tinymce/')])).str() + "plugins/compat3x/plugin${var_dev_suffix.to_string()}.js", rt.create_array([rt.ArrayItem{ key: none, val: 'wp-tinymce-root' }]), var_tinymce_version.dup()])
	}
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-tinymce-lists'), rt.call_function('includes_url', [rt.new_string("js/tinymce/plugins/lists/plugin${var_suffix.to_string()}.js")]), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-tinymce' }]), var_tinymce_version.dup()])
}

fn wp_default_packages_vendor(var_scripts rt.PhpVal) {
	mut var_wp_locale := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_suffix := wp_scripts_get_suffix('')
	mut var_vendor_scripts := { 'react': rt.new_array(), 'react-dom': map[string]rt.PhpVal{}, 'react-jsx-runtime': map[string]rt.PhpVal{}, 'regenerator-runtime': rt.new_array(), 'moment': rt.new_array(), 'lodash': rt.new_array(), 'wp-polyfill-fetch': rt.new_array(), 'wp-polyfill-formdata': rt.new_array(), 'wp-polyfill-node-contains': rt.new_array(), 'wp-polyfill-url': rt.new_array(), 'wp-polyfill-dom-rect': rt.new_array(), 'wp-polyfill-element-closest': rt.new_array(), 'wp-polyfill-object-fit': rt.new_array(), 'wp-polyfill-inert': rt.new_array(), 'wp-polyfill': rt.new_array() }
	mut var_vendor_scripts_versions := rt.create_array([rt.ArrayItem{ key: 'react', val: '18.3.1.1' }, rt.ArrayItem{ key: 'react-dom', val: '18.3.1.1' }, rt.ArrayItem{ key: 'react-jsx-runtime', val: '18.3.1' }, rt.ArrayItem{ key: 'regenerator-runtime', val: '0.14.1' }, rt.ArrayItem{ key: 'moment', val: '2.30.1' }, rt.ArrayItem{ key: 'lodash', val: '4.18.1' }, rt.ArrayItem{ key: 'wp-polyfill-fetch', val: '3.6.20' }, rt.ArrayItem{ key: 'wp-polyfill-formdata', val: '4.0.10' }, rt.ArrayItem{ key: 'wp-polyfill-node-contains', val: '4.8.0' }, rt.ArrayItem{ key: 'wp-polyfill-url', val: '3.6.4' }, rt.ArrayItem{ key: 'wp-polyfill-dom-rect', val: '4.8.0' }, rt.ArrayItem{ key: 'wp-polyfill-element-closest', val: '3.0.2' }, rt.ArrayItem{ key: 'wp-polyfill-object-fit', val: '2.3.5' }, rt.ArrayItem{ key: 'wp-polyfill-inert', val: '3.1.3' }, rt.ArrayItem{ key: 'wp-polyfill', val: '3.15.0' }])
	for var_handle, var_dependencies in var_vendor_scripts {
		rt.call_method(var_scripts, 'add', [rt.new_string(handle), rt.new_string("/wp-includes/js/dist/vendor/${var_handle}${var_suffix.to_string()}.js"), var_dependencies.dup(), var_vendor_scripts_versions.array_get(handle), rt.new_int(1)])
	}
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) && rt.is_true(rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('lodash'), rt.new_string('window.lodash = _.noConflict();')])))
	rt.new_bool(rt.is_true(rt.call_function('did_action', [rt.new_string('init')])) && rt.is_true(rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('moment'), rt.call_function('sprintf', [rt.new_string('moment.updateLocale( \'%s\', %s );'), rt.call_function('esc_js', [rt.call_function('get_user_locale', []rt.PhpVal{})]), rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'months', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'month')]) }, rt.ArrayItem{ key: 'monthsShort', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'month_abbrev')]) }, rt.ArrayItem{ key: 'weekdays', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday')]) }, rt.ArrayItem{ key: 'weekdaysShort', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday_abbrev')]) }, rt.ArrayItem{ key: 'week', val: rt.create_array([rt.ArrayItem{ key: 'dow', val: // unsupported expression: Expr_Cast_Int }]) }, rt.ArrayItem{ key: 'longDateFormat', val: rt.create_array([rt.ArrayItem{ key: 'LT', val: rt.call_function('get_option', [rt.new_string('time_format'), rt.call_function('__', [rt.new_string('g:i a')])]) }, rt.ArrayItem{ key: 'LTS', val: rt.new_null() }, rt.ArrayItem{ key: 'L', val: rt.new_null() }, rt.ArrayItem{ key: 'LL', val: rt.call_function('get_option', [rt.new_string('date_format'), rt.call_function('__', [rt.new_string('F j, Y')])]) }, rt.ArrayItem{ key: 'LLL', val: rt.call_function('__', [rt.new_string('F j, Y g:i a')]) }, rt.ArrayItem{ key: 'LLLL', val: rt.new_null() }]) }]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('after')])))
}

fn wp_register_development_scripts(var_scripts rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('SCRIPT_DEBUG'))))))) || !rt.is_true(rt.get_property(var_scripts, 'registered').array_get('react')))) || rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])))) {
		return rt.new_null()
	}
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-react-refresh-runtime'), rt.new_string('/wp-includes/js/dist/development/react-refresh-runtime.js'), rt.new_array(), rt.new_string('0.14.0')])
	rt.call_method(var_scripts, 'add', [rt.new_string('wp-react-refresh-entry'), rt.new_string('/wp-includes/js/dist/development/react-refresh-entry.js'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-react-refresh-runtime' }]), rt.new_string('0.14.0')])
	rt.get_property(rt.get_property(var_scripts, 'registered').array_get('react'), 'deps').array_push('wp-react-refresh-entry')
}

fn wp_get_script_polyfill(var_scripts rt.PhpVal, var_tests rt.PhpVal) string {
	mut var_polyfill := ''
	{
		mut iter_1 := var_tests.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_handle := item_1.val
			mut var_test := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_scripts, 'registered').array_isset(var_handle.dup())))))) {
				continue
			}
			mut var_src := rt.get_property(rt.get_property(var_scripts, 'registered').array_get(var_handle), 'src')
			mut var_ver := rt.get_property(rt.get_property(var_scripts, 'registered').array_get(var_handle), 'ver')
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), var_src.dup()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_scripts, 'content_url')) && rt.is_true(rt.call_function('str_starts_with', [var_src.dup(), rt.get_property(var_scripts, 'content_url')]))))))))) {
				var_src = rt.new_string(rt.concat(rt.get_property(var_scripts, 'base_url'), var_src))
			}
			if !(!rt.is_true(var_ver)) {
				var_src = rt.call_function('add_query_arg', [rt.new_string('ver'), var_ver.dup(), var_src.dup()])
			}
			var_src = rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('script_loader_src'), var_src.dup(), var_handle.dup()])])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
				continue
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_polyfill
}

fn wp_default_packages_scripts(var_scripts rt.PhpVal) {
	mut var_suffix := if rt.is_true(rt.call_function('defined', [rt.new_string('WP_RUN_CORE_TESTS')])) { rt.new_string('.min') } else { wp_scripts_get_suffix('') }
	mut var_assets_file := rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/assets/script-loader-packages.php')
	mut var_assets := if rt.is_true(rt.call_function('file_exists', [var_assets_file.dup()])) { rt.include_file((var_assets_file).to_string(), '1') } else { rt.new_array() }
	{
		mut iter_1 := var_assets.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_package_data := item_1.val
			mut var_file_name := item_1.key
			mut var_basename := rt.call_function('str_replace', [rt.new_string('.js'), rt.new_string(''), rt.call_function('basename', [var_file_name.dup()])])
			mut var_handle := rt.new_string('wp-' + (var_basename).str())
			mut var_path := "/wp-includes/js/dist/${var_basename.to_string()}${var_suffix.to_string()}.js"
			if !(!rt.is_true(var_package_data.array_get('dependencies'))) {
				mut var_dependencies := var_package_data.array_get('dependencies')
			} else {
				var_dependencies = rt.new_array()
			}
			mut switch_val_1 := var_handle
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-block-library'))) {
				var_dependencies.dup().array_push(rt.new_string('editor'))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-edit-post'))) {
				var_dependencies.dup().array_push(rt.new_string('media-models'))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-preferences'))) {
				var_dependencies.dup().array_push(rt.new_string('wp-preferences-persistence'))
			}
			rt.call_method(var_scripts, 'add', [var_handle.dup(), rt.new_string(var_path).dup(), var_dependencies.dup(), var_package_data.array_get('version'), rt.new_int(1)])
			if !(!rt.is_true(var_package_data.array_get('module_dependencies'))) {
				rt.call_method(var_scripts, 'add_data', [var_handle.dup(), rt.new_string('module_dependencies'), var_package_data.array_get('module_dependencies')])
			}
			if rt.is_true(rt.call_function('in_array', [rt.new_string('wp-i18n'), var_dependencies.dup(), rt.new_bool(true)])) {
				rt.call_method(var_scripts, 'set_translations', [var_handle.dup()])
			}
			if rt.is_true(rt.identical(rt.new_string('wp-i18n'), var_handle)) {
				mut var_ltr := rt.call_function('_x', [rt.new_string('ltr'), rt.new_string('text direction')])
				mut var_script := rt.call_function('sprintf', [rt.new_string('wp.i18n.setLocaleData( { \'text direction\\u0004ltr\': [ \'%s\' ] } );'), var_ltr.dup()])
				rt.call_method(var_scripts, 'add_inline_script', [var_handle.dup(), var_script.dup(), rt.new_string('after')])
			}
		}
	}
}

fn wp_default_packages_inline_scripts(var_scripts rt.PhpVal) {
	mut var_wp_locale := rt.new_null()
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.get_property(var_scripts, 'registered').array_isset(rt.new_string('wp-api-fetch')) {
		rt.get_property(rt.get_property(var_scripts, 'registered').array_get('wp-api-fetch'), 'deps').array_push('wp-hooks')
	}
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-api-fetch'), rt.call_function('sprintf', [rt.new_string('wp.apiFetch.use( wp.apiFetch.createRootURLMiddleware( "%s" ) );'), rt.call_function('sanitize_url', [rt.call_function('get_rest_url', []rt.PhpVal{})])]), rt.new_string('after')])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-api-fetch'), rt.call_function('implode', [rt.new_string('\n'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [rt.new_string('wp.apiFetch.nonceMiddleware = wp.apiFetch.createNonceMiddleware( "%s" );'), if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) { rt.new_string('') } else { rt.call_function('wp_create_nonce', [rt.new_string('wp_rest')]) }]) }, rt.ArrayItem{ key: none, val: 'wp.apiFetch.use( wp.apiFetch.nonceMiddleware );' }, rt.ArrayItem{ key: none, val: 'wp.apiFetch.use( wp.apiFetch.mediaUploadMiddleware );' }, rt.ArrayItem{ key: none, val: rt.call_function('sprintf', [rt.new_string('wp.apiFetch.nonceEndpoint = "%s";'), rt.call_function('admin_url', [rt.new_string('admin-ajax.php?action=rest-nonce')])]) }])]), rt.new_string('after')])
	mut var_meta_key := rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() + 'persisted_preferences')
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_preload_data := rt.call_function('get_user_meta', [var_user_id.dup(), var_meta_key.dup(), rt.new_bool(true)])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-preferences'), rt.call_function('sprintf', [rt.new_string('( function() {\n\t\t\t\tvar serverData = %s;\n\t\t\t\tvar userId = "%d";\n\t\t\t\tvar persistenceLayer = wp.preferencesPersistence.__unstableCreatePersistenceLayer( serverData, userId );\n\t\t\t\tvar preferencesStore = wp.preferences.store;\n\t\t\t\twp.data.dispatch( preferencesStore ).setPersistenceLayer( persistenceLayer );\n\t\t\t} ) ();'), rt.call_function('wp_json_encode', [var_preload_data.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), var_user_id.dup()])])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-data'), rt.call_function('implode', [rt.new_string('\n'), rt.create_array([rt.ArrayItem{ key: none, val: '( function() {' }, rt.ArrayItem{ key: none, val: '\tvar userId = ' + (rt.call_function('get_current_user_id', []rt.PhpVal{})).str() + ';' }, rt.ArrayItem{ key: none, val: '\tvar storageKey = "WP_DATA_USER_" + userId;' }, rt.ArrayItem{ key: none, val: '\twp.data' }, rt.ArrayItem{ key: none, val: '\t\t.use( wp.data.plugins.persistence, { storageKey: storageKey } );' }, rt.ArrayItem{ key: none, val: '} )();' }])])])
	mut var_timezone_string := rt.call_function('get_option', [rt.new_string('timezone_string'), rt.new_string('UTC')])
	mut var_timezone_abbr := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(var_timezone_string)) {
		mut var_timezone_date := create_datetime(rt.new_string('now'), create_datetimezone(var_timezone_string.dup()))
		var_timezone_abbr = var_timezone_date.format(rt.new_string('T'))
	}
	mut var_gmt_offset := rt.call_function('get_option', [rt.new_string('gmt_offset'), rt.new_int(0)])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-date'), rt.call_function('sprintf', [rt.new_string('wp.date.setSettings( %s );'), rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'l10n', val: rt.create_array([rt.ArrayItem{ key: 'locale', val: rt.call_function('get_user_locale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'months', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'month')]) }, rt.ArrayItem{ key: 'monthsShort', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'month_abbrev')]) }, rt.ArrayItem{ key: 'weekdays', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday')]) }, rt.ArrayItem{ key: 'weekdaysShort', val: rt.call_function('array_values', [rt.get_property(var_wp_locale, 'weekday_abbrev')]) }, rt.ArrayItem{ key: 'meridiem', val: // unsupported expression: Expr_Cast_Object }, rt.ArrayItem{ key: 'relative', val: rt.create_array([rt.ArrayItem{ key: 'future', val: rt.call_function('__', [rt.new_string('%s from now')]) }, rt.ArrayItem{ key: 'past', val: rt.call_function('__', [rt.new_string('%s ago')]) }, rt.ArrayItem{ key: 's', val: rt.call_function('__', [rt.new_string('a second')]) }, rt.ArrayItem{ key: 'ss', val: rt.call_function('__', [rt.new_string('%d seconds')]) }, rt.ArrayItem{ key: 'm', val: rt.call_function('__', [rt.new_string('a minute')]) }, rt.ArrayItem{ key: 'mm', val: rt.call_function('__', [rt.new_string('%d minutes')]) }, rt.ArrayItem{ key: 'h', val: rt.call_function('__', [rt.new_string('an hour')]) }, rt.ArrayItem{ key: 'hh', val: rt.call_function('__', [rt.new_string('%d hours')]) }, rt.ArrayItem{ key: 'd', val: rt.call_function('__', [rt.new_string('a day')]) }, rt.ArrayItem{ key: 'dd', val: rt.call_function('__', [rt.new_string('%d days')]) }, rt.ArrayItem{ key: 'M', val: rt.call_function('__', [rt.new_string('a month')]) }, rt.ArrayItem{ key: 'MM', val: rt.call_function('__', [rt.new_string('%d months')]) }, rt.ArrayItem{ key: 'y', val: rt.call_function('__', [rt.new_string('a year')]) }, rt.ArrayItem{ key: 'yy', val: rt.call_function('__', [rt.new_string('%d years')]) }]) }, rt.ArrayItem{ key: 'startOfWeek', val: // unsupported expression: Expr_Cast_Int }]) }, rt.ArrayItem{ key: 'formats', val: rt.create_array([rt.ArrayItem{ key: 'time', val: rt.call_function('get_option', [rt.new_string('time_format'), rt.call_function('__', [rt.new_string('g:i a')])]) }, rt.ArrayItem{ key: 'date', val: rt.call_function('get_option', [rt.new_string('date_format'), rt.call_function('__', [rt.new_string('F j, Y')])]) }, rt.ArrayItem{ key: 'datetime', val: rt.call_function('__', [rt.new_string('F j, Y g:i a')]) }, rt.ArrayItem{ key: 'datetimeAbbreviated', val: rt.call_function('__', [rt.new_string('M j, Y g:i a')]) }]) }, rt.ArrayItem{ key: 'timezone', val: rt.create_array([rt.ArrayItem{ key: 'offset', val: // unsupported expression: Expr_Cast_Double }, rt.ArrayItem{ key: 'offsetFormatted', val: rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '.25' }, rt.ArrayItem{ key: none, val: '.5' }, rt.ArrayItem{ key: none, val: '.75' }]), rt.create_array([rt.ArrayItem{ key: none, val: ':15' }, rt.ArrayItem{ key: none, val: ':30' }, rt.ArrayItem{ key: none, val: ':45' }]), // unsupported expression: Expr_Cast_String]) }, rt.ArrayItem{ key: 'string', val: var_timezone_string }, rt.ArrayItem{ key: 'abbr', val: var_timezone_abbr }]) }]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('after')])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('editor'), rt.new_string('window.wp.oldEditor = window.wp.editor;'), rt.new_string('after')])
	rt.call_method(var_scripts, 'add_inline_script', [rt.new_string('wp-editor'), rt.new_string('Object.assign( window.wp.editor, window.wp.oldEditor );'), rt.new_string('after')])
}

fn wp_tinymce_inline_scripts() {
	mut var_wp_scripts := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_editor_settings := rt.call_function('apply_filters', [rt.new_string('wp_editor_settings'), rt.create_array([rt.ArrayItem{ key: 'tinymce', val: true }]), rt.new_string('classic-block')])
	mut var_tinymce_plugins := rt.create_array([rt.ArrayItem{ key: none, val: 'charmap' }, rt.ArrayItem{ key: none, val: 'colorpicker' }, rt.ArrayItem{ key: none, val: 'hr' }, rt.ArrayItem{ key: none, val: 'lists' }, rt.ArrayItem{ key: none, val: 'media' }, rt.ArrayItem{ key: none, val: 'paste' }, rt.ArrayItem{ key: none, val: 'tabfocus' }, rt.ArrayItem{ key: none, val: 'textcolor' }, rt.ArrayItem{ key: none, val: 'fullscreen' }, rt.ArrayItem{ key: none, val: 'wordpress' }, rt.ArrayItem{ key: none, val: 'wpautoresize' }, rt.ArrayItem{ key: none, val: 'wpeditimage' }, rt.ArrayItem{ key: none, val: 'wpemoji' }, rt.ArrayItem{ key: none, val: 'wpgallery' }, rt.ArrayItem{ key: none, val: 'wplink' }, rt.ArrayItem{ key: none, val: 'wpdialogs' }, rt.ArrayItem{ key: none, val: 'wptextpattern' }, rt.ArrayItem{ key: none, val: 'wpview' }])
	var_tinymce_plugins = rt.call_function('apply_filters', [rt.new_string('tiny_mce_plugins'), var_tinymce_plugins.dup(), rt.new_string('classic-block')])
	var_tinymce_plugins = rt.call_function('array_unique', [var_tinymce_plugins.dup()])
	mut var_disable_captions := false
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('disable_captions'), rt.new_string('')])) {
		var_disable_captions = true
	}
	mut var_toolbar1 := rt.create_array([rt.ArrayItem{ key: none, val: 'formatselect' }, rt.ArrayItem{ key: none, val: 'bold' }, rt.ArrayItem{ key: none, val: 'italic' }, rt.ArrayItem{ key: none, val: 'bullist' }, rt.ArrayItem{ key: none, val: 'numlist' }, rt.ArrayItem{ key: none, val: 'blockquote' }, rt.ArrayItem{ key: none, val: 'alignleft' }, rt.ArrayItem{ key: none, val: 'aligncenter' }, rt.ArrayItem{ key: none, val: 'alignright' }, rt.ArrayItem{ key: none, val: 'link' }, rt.ArrayItem{ key: none, val: 'unlink' }, rt.ArrayItem{ key: none, val: 'wp_more' }, rt.ArrayItem{ key: none, val: 'spellchecker' }, rt.ArrayItem{ key: none, val: 'wp_add_media' }, rt.ArrayItem{ key: none, val: 'wp_adv' }])
	var_toolbar1 = rt.call_function('apply_filters', [rt.new_string('mce_buttons'), var_toolbar1.dup(), rt.new_string('classic-block')])
	mut var_toolbar2 := rt.create_array([rt.ArrayItem{ key: none, val: 'strikethrough' }, rt.ArrayItem{ key: none, val: 'hr' }, rt.ArrayItem{ key: none, val: 'forecolor' }, rt.ArrayItem{ key: none, val: 'pastetext' }, rt.ArrayItem{ key: none, val: 'removeformat' }, rt.ArrayItem{ key: none, val: 'charmap' }, rt.ArrayItem{ key: none, val: 'outdent' }, rt.ArrayItem{ key: none, val: 'indent' }, rt.ArrayItem{ key: none, val: 'undo' }, rt.ArrayItem{ key: none, val: 'redo' }, rt.ArrayItem{ key: none, val: 'wp_help' }])
	var_toolbar2 = rt.call_function('apply_filters', [rt.new_string('mce_buttons_2'), var_toolbar2.dup(), rt.new_string('classic-block')])
	mut var_toolbar3 := rt.call_function('apply_filters', [rt.new_string('mce_buttons_3'), rt.new_array(), rt.new_string('classic-block')])
	mut var_toolbar4 := rt.call_function('apply_filters', [rt.new_string('mce_buttons_4'), rt.new_array(), rt.new_string('classic-block')])
	mut var_external_plugins := rt.call_function('apply_filters', [rt.new_string('mce_external_plugins'), rt.new_array(), rt.new_string('classic-block')])
	mut var_tinymce_settings := rt.create_array([rt.ArrayItem{ key: 'plugins', val: rt.call_function('implode', [rt.new_string(','), var_tinymce_plugins.dup()]) }, rt.ArrayItem{ key: 'toolbar1', val: rt.call_function('implode', [rt.new_string(','), var_toolbar1.dup()]) }, rt.ArrayItem{ key: 'toolbar2', val: rt.call_function('implode', [rt.new_string(','), var_toolbar2.dup()]) }, rt.ArrayItem{ key: 'toolbar3', val: rt.call_function('implode', [rt.new_string(','), var_toolbar3.dup()]) }, rt.ArrayItem{ key: 'toolbar4', val: rt.call_function('implode', [rt.new_string(','), var_toolbar4.dup()]) }, rt.ArrayItem{ key: 'external_plugins', val: rt.call_function('wp_json_encode', [var_external_plugins.dup()]) }, rt.ArrayItem{ key: 'classic_block_editor', val: true }])
	if var_disable_captions {
		var_tinymce_settings.array_set('wpeditimage_disable_captions', true)
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(.array_get())) && rt.is_true(rt.new_bool(.is_array())))) {
		var_tinymce_settings = 
	}
	var_tinymce_settings = 
	
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
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


fn init_registry() {
	rt.register_func('wp_register_tinymce_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return wp_register_tinymce_scripts(arg_0, arg_1)
	})
	rt.register_func('wp_default_packages_vendor', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages_vendor(arg_0)
	})
	rt.register_func('wp_register_development_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_register_development_scripts(arg_0)
	})
	rt.register_func('wp_get_script_polyfill', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(wp_get_script_polyfill(arg_0, arg_1))
	})
	rt.register_func('wp_default_packages_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages_scripts(arg_0)
	})
	rt.register_func('wp_default_packages_inline_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages_inline_scripts(arg_0)
	})
	rt.register_func('wp_tinymce_inline_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_tinymce_inline_scripts()
	})
	rt.register_func('wp_default_packages', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_packages(arg_0)
	})
	rt.register_func('wp_scripts_get_suffix', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return wp_scripts_get_suffix(arg_0)
	})
	rt.register_func('wp_default_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_scripts(arg_0)
	})
	rt.register_func('wp_default_styles', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_default_styles(arg_0)
	})
	rt.register_func('wp_prototype_before_jquery', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_prototype_before_jquery(arg_0)
	})
	rt.register_func('wp_just_in_time_script_localization', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_just_in_time_script_localization()
	})
	rt.register_func('wp_localize_jquery_ui_datepicker', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_localize_jquery_ui_datepicker()
	})
	rt.register_func('wp_localize_community_events', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_localize_community_events()
	})
	rt.register_func('wp_style_loader_src', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(wp_style_loader_src(arg_0, arg_1))
	})
	rt.register_func('print_head_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return print_head_scripts()
	})
	rt.register_func('print_footer_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return print_footer_scripts()
	})
	rt.register_func('_print_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return _print_scripts()
	})
	rt.register_func('wp_print_head_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_print_head_scripts()
	})
	rt.register_func('_wp_footer_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return _wp_footer_scripts()
	})
	rt.register_func('wp_print_footer_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_print_footer_scripts()
	})
	rt.register_func('wp_enqueue_scripts', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_scripts()
	})
	rt.register_func('print_admin_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return print_admin_styles()
	})
	rt.register_func('print_late_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return print_late_styles()
	})
	rt.register_func('_print_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return _print_styles()
	})
	rt.register_func('script_concat_settings', fn(args []rt.PhpVal) rt.PhpVal {
		return script_concat_settings()
	})
	rt.register_func('wp_common_block_scripts_and_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_common_block_scripts_and_styles()
	})
	rt.register_func('wp_filter_out_block_nodes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_filter_out_block_nodes(arg_0)
	})
	rt.register_func('wp_enqueue_global_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_global_styles()
	})
	rt.register_func('wp_should_load_block_editor_scripts_and_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_should_load_block_editor_scripts_and_styles()
	})
	rt.register_func('wp_should_load_separate_core_block_assets', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_should_load_separate_core_block_assets())
	})
	rt.register_func('wp_should_load_block_assets_on_demand', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wp_should_load_block_assets_on_demand())
	})
	rt.register_func('wp_enqueue_registered_block_scripts_and_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_registered_block_scripts_and_styles()
	})
	rt.register_func('enqueue_block_styles_assets', fn(args []rt.PhpVal) rt.PhpVal {
		return enqueue_block_styles_assets()
	})
	rt.register_func('enqueue_editor_block_styles_assets', fn(args []rt.PhpVal) rt.PhpVal {
		return enqueue_editor_block_styles_assets()
	})
	rt.register_func('wp_enqueue_editor_block_directory_assets', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_editor_block_directory_assets()
	})
	rt.register_func('wp_enqueue_editor_format_library_assets', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_editor_format_library_assets()
	})
	rt.register_func('wp_get_script_tag', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wp_get_script_tag(arg_0))
	})
	rt.register_func('wp_print_script_tag', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_print_script_tag(arg_0)
	})
	rt.register_func('wp_get_inline_script_tag', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(wp_get_inline_script_tag(arg_0, arg_1))
	})
	rt.register_func('wp_print_inline_script_tag', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_print_inline_script_tag(arg_0, arg_1)
	})
	rt.register_func('wp_maybe_inline_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_maybe_inline_styles()
	})
	rt.register_func('_wp_normalize_relative_css_links', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _wp_normalize_relative_css_links(arg_0, arg_1)
	})
	rt.register_func('wp_enqueue_global_styles_css_custom_properties', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_global_styles_css_custom_properties()
	})
	rt.register_func('wp_enqueue_block_support_styles', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
		return wp_enqueue_block_support_styles(arg_0, arg_1)
	})
	rt.register_func('wp_enqueue_stored_styles', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_enqueue_stored_styles(arg_0)
	})
	rt.register_func('wp_enqueue_block_style', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_enqueue_block_style(arg_0, arg_1)
	})
	rt.register_func('wp_enqueue_classic_theme_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_classic_theme_styles()
	})
	rt.register_func('wp_enqueue_command_palette_assets', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_enqueue_command_palette_assets()
	})
	rt.register_func('wp_remove_surrounding_empty_script_tags', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_remove_surrounding_empty_script_tags(arg_0)
	})
	rt.register_func('wp_load_classic_theme_block_styles_on_demand', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_load_classic_theme_block_styles_on_demand()
	})
	rt.register_func('wp_hoist_late_printed_styles', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_hoist_late_printed_styles()
	})
	rt.register_func('wp_js_dataset_name', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(wp_js_dataset_name(arg_0))
	})
	rt.register_func('wp_html_custom_data_attribute_name', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return rt.new_string(wp_html_custom_data_attribute_name(arg_0))
	})
	rt.register_class_factory('DateTime', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_datetime()
		return rt.new_object('DateTime', []string{}, obj)
	})
	rt.register_class_factory('DateTimeZone', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_datetimezone()
		return rt.new_object('DateTimeZone', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_script_loader_php() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-dependency.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-dependencies.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-scripts.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.wp-scripts.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-styles.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.wp-styles.php', '3')
}
