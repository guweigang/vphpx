import rt

struct Class__WP_Editors {
	rt.PhpObjectBase
}

fn init_static__wp_editors() {
	rt.init_static_prop('_WP_Editors', 'mce_locale', rt.new_null())
	rt.init_static_prop('_WP_Editors', 'mce_settings', rt.new_array())
	rt.init_static_prop('_WP_Editors', 'qt_settings', rt.new_array())
	rt.init_static_prop('_WP_Editors', 'plugins', rt.new_array())
	rt.init_static_prop('_WP_Editors', 'qt_buttons', rt.new_array())
	rt.init_static_prop('_WP_Editors', 'ext_plugins', rt.new_null())
	rt.init_static_prop('_WP_Editors', 'baseurl', rt.new_null())
	rt.init_static_prop('_WP_Editors', 'first_init', rt.new_null())
	rt.init_static_prop('_WP_Editors', 'this_tinymce', rt.new_bool(false))
	rt.init_static_prop('_WP_Editors', 'this_quicktags', rt.new_bool(false))
	rt.init_static_prop('_WP_Editors', 'has_tinymce', rt.new_bool(false))
	rt.init_static_prop('_WP_Editors', 'has_quicktags', rt.new_bool(false))
	rt.init_static_prop('_WP_Editors', 'has_medialib', rt.new_bool(false))
	rt.init_static_prop('_WP_Editors', 'editor_buttons_css', rt.new_bool(true))
	rt.init_static_prop('_WP_Editors', 'drag_drop_upload', rt.new_bool(false))
	rt.init_static_prop('_WP_Editors', 'translation', rt.new_null())
	rt.init_static_prop('_WP_Editors', 'tinymce_scripts_printed', rt.new_bool(false))
	rt.init_static_prop('_WP_Editors', 'link_dialog_printed', rt.new_bool(false))
}

fn (mut this Class__WP_Editors) construct() {
}

fn Class__WP_Editors.parse_settings(var_editor_id rt.PhpVal, var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	var_settings_mutated = rt.call_function('apply_filters', [
		rt.new_string('wp_editor_settings'),
		var_settings_mutated.clone(),
		var_editor_id.clone(),
	])
	mut var_set := rt.call_function('wp_parse_args', [var_settings_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'wpautop', val: !(rt.is_true(rt.call_function('has_blocks',
				[]rt.PhpVal{}))) },
			rt.ArrayItem{ key: 'media_buttons', val: true },
			rt.ArrayItem{ key: 'default_editor', val: '' },
			rt.ArrayItem{ key: 'drag_drop_upload', val: false },
			rt.ArrayItem{ key: 'textarea_name', val: var_editor_id },
			rt.ArrayItem{ key: 'textarea_rows', val: 20 },
			rt.ArrayItem{ key: 'tabindex', val: '' },
			rt.ArrayItem{ key: 'tabfocus_elements', val: ':prev,:next' },
			rt.ArrayItem{ key: 'editor_css', val: '' },
			rt.ArrayItem{ key: 'editor_class', val: '' },
			rt.ArrayItem{ key: 'teeny', val: false },
			rt.ArrayItem{ key: '_content_editor_dfw', val: false },
			rt.ArrayItem{ key: 'tinymce', val: true },
			rt.ArrayItem{ key: 'quicktags', val: true },
		])])
	rt.set_static_prop('_WP_Editors', 'this_tinymce', rt.new_bool(
		rt.is_true(var_set.array_get(rt.new_string('tinymce')))
		&& rt.is_true(rt.call_function('user_can_richedit', []rt.PhpVal{}))))
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_tinymce')) {
		if rt.is_true(rt.call_function('str_contains', [var_editor_id.clone(),
			rt.new_string('[')]))
		{
			rt.set_static_prop('_WP_Editors', 'this_tinymce', rt.new_bool(false))
			rt.call_function('_deprecated_argument', [rt.new_string('wp_editor()'),
				rt.new_string('3.9.0'), rt.new_string('TinyMCE editor IDs cannot have brackets.')])
		}
	}
	rt.set_static_prop('_WP_Editors', 'this_quicktags',
		(var_set.array_get(rt.new_string('quicktags'))).to_bool())
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_tinymce')) {
		rt.set_static_prop('_WP_Editors', 'has_tinymce', rt.new_bool(true))
	}
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_quicktags')) {
		rt.set_static_prop('_WP_Editors', 'has_quicktags', rt.new_bool(true))
	}
	if !rt.is_true(var_set.array_get(rt.new_string('editor_height'))) {
		return var_set.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('content'), var_editor_id))
		&& !rt.is_true(var_set.array_get(rt.new_string('tinymce')).array_get(rt.new_string('wp_autoresize_on'))) {
		mut var_cookie := rt.new_int((rt.call_function('get_user_setting', [
			rt.new_string('ed_size'),
		])).to_i64())
		if rt.is_true(var_cookie) {
			var_set.array_set('editor_height', var_cookie.clone())
		}
	}
	if rt.is_true(rt.less(var_set.array_get(rt.new_string('editor_height')), rt.new_int(50))) {
		var_set.array_set('editor_height', 50)
	} else if rt.is_true(rt.greater(var_set.array_get(rt.new_string('editor_height')),
		rt.new_int(5000)))
	{
		var_set.array_set('editor_height', 5000)
	}
	return var_set.clone()
}

fn Class__WP_Editors.editor(var_content rt.PhpVal, var_editor_id rt.PhpVal, var_settings rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	mut var_content_mutated := var_content
	mut var_settings_mutated := var_settings
	mut var_set := Class__WP_Editors.parse_settings(var_editor_id.clone(),
		var_settings_mutated.clone())
	mut var_editor_class := rt.new_string(' class="' +
		(rt.call_function('esc_attr', [var_set.array_get(rt.new_string('editor_class'))])).str() +
		' wp-editor-area'.trim_space() + '"')
	mut var_tabindex := rt.new_string((if rt.is_true(var_set.array_get(rt.new_string('tabindex'))) {
		' tabindex="' + rt.new_int((var_set.array_get(rt.new_string('tabindex'))).to_i64()).str() +
			'"'
	} else {
		''
	}).str())
	mut var_default_editor := rt.new_string('html')
	mut var_buttons := rt.new_string('')
	mut var_autocomplete := rt.new_string('')
	mut var_editor_id_attr := rt.call_function('esc_attr', [var_editor_id.clone()])
	if rt.is_true(var_set.array_get(rt.new_string('drag_drop_upload'))) {
		rt.set_static_prop('_WP_Editors', 'drag_drop_upload', rt.new_bool(true))
	}
	if !(!rt.is_true(var_set.array_get(rt.new_string('editor_height')))) {
		mut var_height := rt.new_string(' style="height: ' +
			rt.new_int((var_set.array_get(rt.new_string('editor_height'))).to_i64()).str() + 'px"')
	} else {
		var_height = rt.new_string(' rows="' +
			rt.new_int((var_set.array_get(rt.new_string('textarea_rows'))).to_i64()).str() + '"')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('upload_files'),
	])))))
	{
		var_set.array_set('media_buttons', false)
	}
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_tinymce')) {
		var_autocomplete = rt.new_string(' autocomplete="off"')
		if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_quicktags')) {
			var_default_editor = if rt.is_true(var_set.array_get(rt.new_string('default_editor'))) {
				var_set.array_get(rt.new_string('default_editor'))
			} else {
				rt.call_function('wp_default_editor', []rt.PhpVal{})
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('html'),
				var_default_editor))))
			{
				var_default_editor = rt.new_string('tinymce')
			}
			mut var_tmce_active := rt.new_string((if rt.is_true(rt.identical(rt.new_string('html'),
				var_default_editor))
			{
				' aria-pressed="true"'
			} else {
				''
			}).str())
			mut var_html_active := rt.new_string((if rt.is_true(rt.identical(rt.new_string('html'),
				var_default_editor))
			{
				''
			} else {
				' aria-pressed="true"'
			}).str())
			var_buttons = rt.concat(var_buttons, rt.new_string('<button type="button" id="' +
				var_editor_id_attr.str() + '-tmce"' + var_html_active.str() +
				' class="wp-switch-editor switch-tmce"' + ' data-wp-editor-id="' +
				var_editor_id_attr.str() + '">' +
				(rt.call_function('_x', [rt.new_string('Visual'), rt.new_string('Name for the Visual editor tab')])).str() +
				'</button>\n'))
			var_buttons = rt.concat(var_buttons, rt.new_string('<button type="button" id="' +
				var_editor_id_attr.str() + '-html"' + var_tmce_active.str() +
				' class="wp-switch-editor switch-html"' + ' data-wp-editor-id="' +
				var_editor_id_attr.str() + '">' +
				(rt.call_function('_x', [rt.new_string('Code'), rt.new_string('Name for the Code editor tab (formerly Text)')])).str() +
				'</button>\n'))
		} else {
			var_default_editor = rt.new_string('tinymce')
		}
	}
	mut var_switch_class := rt.new_string((if rt.is_true(rt.identical(rt.new_string('html'),
		var_default_editor))
	{
		'html-active'
	} else {
		'tmce-active'
	}).str())
	mut var_wrap_class := rt.new_string('wp-core-ui wp-editor-wrap ' + var_switch_class.str())
	if rt.is_true(var_set.array_get(rt.new_string('_content_editor_dfw'))) {
		var_wrap_class = rt.concat(var_wrap_class, rt.new_string(' has-dfw'))
	}
	print('<div id="wp-' + var_editor_id_attr.str() + '-wrap" class="' + var_wrap_class.str() + '">')
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'editor_buttons_css')) {
		rt.call_function('wp_print_styles', [rt.new_string('editor-buttons')])
		rt.set_static_prop('_WP_Editors', 'editor_buttons_css', rt.new_bool(false))
	}
	if !(!rt.is_true(var_set.array_get(rt.new_string('editor_css')))) {
		print((var_set.array_get(rt.new_string('editor_css'))).str() + '\n')
	}
	if !(!rt.is_true(var_buttons)) || rt.is_true(var_set.array_get(rt.new_string('media_buttons'))) {
		print('<div id="wp-' + var_editor_id_attr.str() +
			'-editor-tools" class="wp-editor-tools hide-if-no-js">')
		if rt.is_true(var_set.array_get(rt.new_string('media_buttons'))) {
			rt.set_static_prop('_WP_Editors', 'has_medialib', rt.new_bool(true))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
				rt.new_string('media_buttons'),
			])))))
			{
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php',
					'3')
			}
			print('<div id="wp-' + var_editor_id_attr.str() +
				'-media-buttons" class="wp-media-buttons">')
			rt.call_function('do_action', [rt.new_string('media_buttons'),
				var_editor_id.clone()])
			print('</div>\n')
		}
		print('<div class="wp-editor-tabs">' + var_buttons.str() + '</div>\n')
		print('</div>\n')
	}
	mut var_quicktags_toolbar := rt.new_string('')
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_quicktags')) {
		if rt.is_true(rt.identical(rt.new_string('content'), var_editor_id))
			&& !(!rt.is_true(var_GLOBALS.array_get(rt.new_string('current_screen'))))
			&& rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_GLOBALS.array_get(rt.new_string('current_screen')), 'base'))) {
			mut var_toolbar_id := rt.new_string('ed_toolbar')
		} else {
			var_toolbar_id = rt.new_string('qt_' + var_editor_id_attr.str() + '_toolbar')
		}
		var_quicktags_toolbar = rt.new_string('<div id="' + var_toolbar_id.str() +
			'" class="quicktags-toolbar hide-if-no-js"></div>')
	}
	mut var_the_editor := rt.call_function('apply_filters', [
		rt.new_string('the_editor'),
		rt.new_string('<div id="wp-' + var_editor_id_attr.str() +
			'-editor-container" class="wp-editor-container">' + var_quicktags_toolbar.str() +
			'<textarea' + var_editor_class.str() + var_height.str() + var_tabindex.str() +
			var_autocomplete.str() + ' cols="40" name="' +
			(rt.call_function('esc_attr', [var_set.array_get(rt.new_string('textarea_name'))])).str() +
			'" ' + 'id="' + var_editor_id_attr.str() + '">%s</textarea></div>')])
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_tinymce')) {
		rt.call_function('add_filter', [rt.new_string('the_editor_content'),
			rt.new_string('format_for_editor'), rt.new_int(10),
			rt.new_int(2)])
	}
	var_content_mutated = rt.call_function('apply_filters', [
		rt.new_string('the_editor_content'),
		var_content_mutated.clone(),
		var_default_editor.clone(),
	])
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_tinymce')) {
		rt.call_function('remove_filter', [rt.new_string('the_editor_content'),
			rt.new_string('format_for_editor')])
	}
	if rt.is_true(rt.identical(rt.new_string('html'), var_default_editor))
		&& rt.is_true(rt.call_function('has_filter', [rt.new_string('htmledit_pre')])) {
		var_content_mutated = rt.call_function('apply_filters_deprecated', [
			rt.new_string('htmledit_pre'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_content_mutated }]),
			rt.new_string('4.3.0'),
			rt.new_string('format_for_editor'),
		])
	} else if rt.is_true(rt.identical(rt.new_string('tinymce'), var_default_editor))
		&& rt.is_true(rt.call_function('has_filter', [rt.new_string('richedit_pre')])) {
		var_content_mutated = rt.call_function('apply_filters_deprecated', [
			rt.new_string('richedit_pre'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_content_mutated }]),
			rt.new_string('4.3.0'),
			rt.new_string('format_for_editor'),
		])
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		var_content_mutated.clone(),
		rt.new_string('textarea'),
	])))))
	{
		var_content_mutated = rt.call_function('preg_replace', [
			rt.new_string('%</textarea%i'),
			rt.new_string('&lt;/textarea'),
			var_content_mutated.clone(),
		])
	}
	rt.call_function('printf', [var_the_editor.clone(), var_content_mutated.clone()])
	print('\n</div>\n\n')
	Class__WP_Editors.editor_settings(var_editor_id.clone(), var_set.clone())
}

fn Class__WP_Editors.editor_settings(var_editor_id rt.PhpVal, var_set rt.PhpVal) {
	mut var_set_mutated := var_set
	if !rt.is_true(rt.get_static_prop('_WP_Editors', 'first_init')) {
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'editor_js' }]),
				rt.new_int(50)])
			rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'force_uncompressed_tinymce' }]),
				rt.new_int(1)])
			rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'enqueue_scripts' }]),
				rt.new_int(1)])
		} else {
			rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'editor_js' }]),
				rt.new_int(50)])
			rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'force_uncompressed_tinymce' }]),
				rt.new_int(1)])
			rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
				rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
					rt.ArrayItem{ key: none, val: 'enqueue_scripts' }]),
				rt.new_int(1)])
		}
	}
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_quicktags')) {
		mut var_qt_init := rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_editor_id },
			rt.ArrayItem{ key: 'buttons', val: '' },
		])
		if rt.is_true(rt.new_bool(var_set_mutated.array_get(rt.new_string('quicktags')).is_array())) {
			var_qt_init = rt.call_function('array_merge', [var_qt_init.clone(),
				var_set_mutated.array_get(rt.new_string('quicktags'))])
		}
		if !rt.is_true(var_qt_init.array_get(rt.new_string('buttons'))) {
			var_qt_init.array_set('buttons',
				'strong,em,link,block,del,ins,img,ul,ol,li,code,more,close')
		}
		if rt.is_true(var_set_mutated.array_get(rt.new_string('_content_editor_dfw'))) {
			var_qt_init.array_get(rt.new_string('buttons')) = rt.concat(var_qt_init.array_get(rt.new_string('buttons')),
				rt.new_string(',dfw'))
		}
		var_qt_init = rt.call_function('apply_filters', [
			rt.new_string('quicktags_settings'),
			var_qt_init.clone(),
			var_editor_id.clone(),
		])
		rt.get_static_prop('_WP_Editors', 'qt_settings').array_set(var_editor_id,
			var_qt_init.clone())
		rt.set_static_prop('_WP_Editors', 'qt_buttons', rt.call_function('array_merge', [
			rt.get_static_prop('_WP_Editors', 'qt_buttons'),
			rt.call_function('explode',
				[rt.new_string(','), var_qt_init.array_get(rt.new_string('buttons'))]),
		]))
	}
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'this_tinymce')) {
		if !rt.is_true(rt.get_static_prop('_WP_Editors', 'first_init')) {
			mut var_baseurl := Class__WP_Editors.get_baseurl()
			mut var_mce_locale := Class__WP_Editors.get_mce_locale()
			mut var_ext_plugins := rt.new_string('')
			if rt.is_true(var_set_mutated.array_get(rt.new_string('teeny'))) {
				mut var_plugins := rt.call_function('apply_filters', [
					rt.new_string('teeny_mce_plugins'),
					rt.create_array([rt.ArrayItem{ key: none, val: 'colorpicker' },
						rt.ArrayItem{ key: none, val: 'lists' },
						rt.ArrayItem{ key: none, val: 'fullscreen' },
						rt.ArrayItem{ key: none, val: 'image' },
						rt.ArrayItem{ key: none, val: 'wordpress' },
						rt.ArrayItem{ key: none, val: 'wpeditimage' },
						rt.ArrayItem{ key: none, val: 'wplink' }]),
					var_editor_id.clone(),
				])
			} else {
				mut var_mce_external_plugins := rt.call_function('apply_filters', [
					rt.new_string('mce_external_plugins'),
					rt.new_array(),
					var_editor_id.clone(),
				])
				var_plugins = rt.create_array([rt.ArrayItem{ key: none, val: 'charmap' },
					rt.ArrayItem{ key: none, val: 'colorpicker' },
					rt.ArrayItem{ key: none, val: 'hr' }, rt.ArrayItem{ key: none, val: 'lists' },
					rt.ArrayItem{ key: none, val: 'media' }, rt.ArrayItem{ key: none, val: 'paste' },
					rt.ArrayItem{ key: none, val: 'tabfocus' },
					rt.ArrayItem{ key: none, val: 'textcolor' },
					rt.ArrayItem{ key: none, val: 'fullscreen' },
					rt.ArrayItem{ key: none, val: 'wordpress' },
					rt.ArrayItem{ key: none, val: 'wpautoresize' },
					rt.ArrayItem{ key: none, val: 'wpeditimage' },
					rt.ArrayItem{ key: none, val: 'wpemoji' },
					rt.ArrayItem{ key: none, val: 'wpgallery' },
					rt.ArrayItem{ key: none, val: 'wplink' },
					rt.ArrayItem{ key: none, val: 'wpdialogs' },
					rt.ArrayItem{ key: none, val: 'wptextpattern' },
					rt.ArrayItem{ key: none, val: 'wpview' }])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('_WP_Editors',
					'has_medialib')))))
				{
					var_plugins.array_push('image')
				}
				var_plugins = rt.call_function('array_unique', [
					rt.call_function('apply_filters', [rt.new_string('tiny_mce_plugins'),
						var_plugins.clone(), var_editor_id.clone()]),
				])
				mut var_key := rt.call_function('array_search', [
					rt.new_string('spellchecker'),
					var_plugins.clone(),
					rt.new_bool(true),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_key)))) {
					var_plugins.array_unset(var_key)
				}
				if !(!rt.is_true(var_mce_external_plugins)) {
					mut var_mce_external_languages := rt.call_function('apply_filters', [
						rt.new_string('mce_external_languages'),
						rt.new_array(),
						var_editor_id.clone(),
					])
					mut var_loaded_langs := rt.new_array()
					mut var_strings := rt.new_string('')
					if !(!rt.is_true(var_mce_external_languages)) {
						mut iter_1 := var_mce_external_languages.iterator()
						for {
							item_1 := iter_1.next() or { break }
							mut var_path := item_1.val
							mut var_name := item_1.key
							if rt.is_true(rt.call_function('is_file', [var_path.clone()]))
								&& rt.is_true(rt.call_function('is_readable', [var_path.clone()])) {
								rt.include_file(var_path.to_string(), '2')
								var_ext_plugins = rt.concat(var_ext_plugins, rt.new_string(
									var_strings.str() + '\n'))
								var_loaded_langs << var_name.clone()
							}
						}
					}
					mut iter_2 := var_mce_external_plugins.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_url := item_2.val
						mut var_name := item_2.key
						if rt.is_true(rt.call_function('in_array', [
							var_name.clone(), var_plugins.clone(),
							rt.new_bool(true)]))
						{
							var_mce_external_plugins.array_unset(var_name)
							continue
						}
						var_url = rt.call_function('set_url_scheme', [
							var_url.clone()])
						var_mce_external_plugins.array_set(var_name, var_url.clone())
						mut var_plugurl := rt.call_function('dirname', [
							var_url.clone()])
						var_strings = rt.new_string('')
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
							var_name.clone(),
							rt.create_array_from_list(var_loaded_langs),
							rt.new_bool(true),
						])))))
						{
							mut var_path := rt.call_function('str_replace', [
								rt.call_function('content_url', []rt.PhpVal{}),
								rt.new_string(''),
								var_plugurl.clone(),
							])
							var_path = rt.call_function('realpath', [
								rt.new_string(
									(rt.get_constant('WP_CONTENT_DIR')).str() + var_path.str() +
									'/langs/'),
							])
							if rt.is_true(rt.new_bool(!(rt.is_true(var_path)))) {
								continue
							}
							var_path = rt.call_function('trailingslashit', [
								var_path.clone()])
							if rt.is_true(rt.call_function('is_file', [
								rt.new_string(var_path.str() + var_mce_locale.str() + '.js'),
							]))
							{
								var_strings = rt.concat(var_strings, rt.new_string(
									(rt.call_function('file_get_contents', [rt.new_string(var_path.str() +
									var_mce_locale.str() + '.js')])).str() + '\n'))
							}
							if rt.is_true(rt.call_function('is_file', [
								rt.new_string(var_path.str() + var_mce_locale.str() + '_dlg.js'),
							]))
							{
								var_strings = rt.concat(var_strings, rt.new_string(
									(rt.call_function('file_get_contents', [rt.new_string(var_path.str() +
									var_mce_locale.str() + '_dlg.js')])).str() + '\n'))
							}
							if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('en'), var_mce_locale))))
								&& !rt.is_true(var_strings) {
								if rt.is_true(rt.call_function('is_file', [
									rt.new_string(var_path.str() + 'en.js'),
								]))
								{
									mut var_str1 := rt.call_function('file_get_contents', [
										rt.new_string(var_path.str() + 'en.js'),
									])
									var_strings = rt.concat(var_strings, rt.new_string(
										(rt.call_function('preg_replace', [rt.new_string('/([\'"])en\\./'), rt.new_string('$1' + var_mce_locale.str() +
										'.'), var_str1.clone(), rt.new_int(1)])).str() + '\n'))
								}
								if rt.is_true(rt.call_function('is_file', [
									rt.new_string(var_path.str() + 'en_dlg.js'),
								]))
								{
									mut var_str2 := rt.call_function('file_get_contents', [
										rt.new_string(var_path.str() + 'en_dlg.js'),
									])
									var_strings = rt.concat(var_strings, rt.new_string(
										(rt.call_function('preg_replace', [rt.new_string('/([\'"])en\\./'), rt.new_string('$1' + var_mce_locale.str() +
										'.'), var_str2.clone(), rt.new_int(1)])).str() + '\n'))
								}
							}
							if !(!rt.is_true(var_strings)) {
								var_ext_plugins = rt.concat(var_ext_plugins, rt.new_string('\n' +
									var_strings.str() + '\n'))
							}
						}
						var_ext_plugins = rt.concat(var_ext_plugins, rt.new_string(
							'tinyMCEPreInit.load_ext("' + var_plugurl.str() + '", "' +
							var_mce_locale.str() + '");' + '\n'))
					}
				}
			}
			rt.set_static_prop('_WP_Editors', 'plugins', var_plugins.clone())
			rt.set_static_prop('_WP_Editors', 'ext_plugins', var_ext_plugins.clone())
			mut var_settings := Class__WP_Editors.default_settings()
			var_settings.array_set('plugins', rt.call_function('implode', [
				rt.new_string(','),
				var_plugins.clone(),
			]))
			if !(!rt.is_true(var_mce_external_plugins)) {
				var_settings.array_set('external_plugins', rt.call_function('wp_json_encode', [
					var_mce_external_plugins.clone(),
				]))
			}
			if rt.is_true(rt.call_function('apply_filters', [
				rt.new_string('disable_captions'),
				rt.new_string(''),
			]))
			{
				var_settings.array_set('wpeditimage_disable_captions', true)
			}
			mut var_mce_css := var_settings.array_get(rt.new_string('content_css'))
			if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
				mut var_editor_styles := rt.call_function('get_editor_stylesheets', []rt.PhpVal{})
				if !(!rt.is_true(var_editor_styles)) {
					mut iter_3 := var_editor_styles.iterator()
					for {
						item_3 := iter_3.next() or { break }
						mut var_url := item_3.val
						mut var_key_shadow := item_3.key
						if rt.is_true(rt.call_function('str_contains', [
							var_url.clone(), rt.new_string(',')]))
						{
							var_editor_styles.array_set(var_key_shadow, rt.call_function('str_replace', [
								rt.new_string(','),
								rt.new_string('%2C'),
								var_url.clone(),
							]))
						}
					}
					var_mce_css = rt.concat(var_mce_css,
						rt.new_string(',' +(rt.call_function('implode', [rt.new_string(','), var_editor_styles.clone()])).str()))
				}
			}
			var_mce_css = rt.new_string(rt.call_function('apply_filters', [
				rt.new_string('mce_css'),
				var_mce_css.clone(),
			]).to_string().trim_space())
			if !(!rt.is_true(var_mce_css)) {
				var_settings.array_set('content_css', var_mce_css.clone())
			} else {
				var_settings.array_unset(rt.new_string('content_css'))
			}
			rt.set_static_prop('_WP_Editors', 'first_init', var_settings.clone())
		}
		if rt.is_true(var_set_mutated.array_get(rt.new_string('teeny'))) {
			mut var_mce_buttons := rt.create_array([
				rt.ArrayItem{ key: none, val: 'bold' },
				rt.ArrayItem{ key: none, val: 'italic' },
				rt.ArrayItem{ key: none, val: 'underline' },
				rt.ArrayItem{ key: none, val: 'blockquote' },
				rt.ArrayItem{ key: none, val: 'strikethrough' },
				rt.ArrayItem{ key: none, val: 'bullist' },
				rt.ArrayItem{ key: none, val: 'numlist' },
				rt.ArrayItem{ key: none, val: 'alignleft' },
				rt.ArrayItem{ key: none, val: 'aligncenter' },
				rt.ArrayItem{ key: none, val: 'alignright' },
				rt.ArrayItem{ key: none, val: 'undo' },
				rt.ArrayItem{ key: none, val: 'redo' },
				rt.ArrayItem{ key: none, val: 'link' },
				rt.ArrayItem{ key: none, val: 'fullscreen' },
			])
			var_mce_buttons = rt.call_function('apply_filters', [
				rt.new_string('teeny_mce_buttons'),
				var_mce_buttons.clone(),
				var_editor_id.clone(),
			])
			mut var_mce_buttons_2 := rt.new_array()
			mut var_mce_buttons_3 := rt.new_array()
			mut var_mce_buttons_4 := rt.new_array()
		} else {
			var_mce_buttons = rt.create_array([
				rt.ArrayItem{ key: none, val: 'formatselect' },
				rt.ArrayItem{ key: none, val: 'bold' },
				rt.ArrayItem{ key: none, val: 'italic' },
				rt.ArrayItem{ key: none, val: 'bullist' },
				rt.ArrayItem{ key: none, val: 'numlist' },
				rt.ArrayItem{ key: none, val: 'blockquote' },
				rt.ArrayItem{ key: none, val: 'alignleft' },
				rt.ArrayItem{ key: none, val: 'aligncenter' },
				rt.ArrayItem{ key: none, val: 'alignright' },
				rt.ArrayItem{ key: none, val: 'link' },
				rt.ArrayItem{ key: none, val: 'wp_more' },
				rt.ArrayItem{ key: none, val: 'spellchecker' },
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) {
				if rt.is_true(var_set_mutated.array_get(rt.new_string('_content_editor_dfw'))) {
					var_mce_buttons.array_push('wp_adv')
					var_mce_buttons.array_push('dfw')
				} else {
					var_mce_buttons.array_push('fullscreen')
					var_mce_buttons.array_push('wp_adv')
				}
			} else {
				var_mce_buttons.array_push('wp_adv')
			}
			var_mce_buttons = rt.call_function('apply_filters', [
				rt.new_string('mce_buttons'),
				var_mce_buttons.clone(),
				var_editor_id.clone(),
			])
			var_mce_buttons_2 = rt.create_array([
				rt.ArrayItem{ key: none, val: 'strikethrough' },
				rt.ArrayItem{ key: none, val: 'hr' },
				rt.ArrayItem{ key: none, val: 'forecolor' },
				rt.ArrayItem{ key: none, val: 'pastetext' },
				rt.ArrayItem{ key: none, val: 'removeformat' },
				rt.ArrayItem{ key: none, val: 'charmap' },
				rt.ArrayItem{ key: none, val: 'outdent' },
				rt.ArrayItem{ key: none, val: 'indent' },
				rt.ArrayItem{ key: none, val: 'undo' },
				rt.ArrayItem{ key: none, val: 'redo' },
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{}))))) {
				var_mce_buttons_2.array_push('wp_help')
			}
			var_mce_buttons_2 = rt.call_function('apply_filters', [
				rt.new_string('mce_buttons_2'),
				var_mce_buttons_2.clone(),
				var_editor_id.clone(),
			])
			var_mce_buttons_3 = rt.call_function('apply_filters', [
				rt.new_string('mce_buttons_3'),
				rt.new_array(),
				var_editor_id.clone(),
			])
			var_mce_buttons_4 = rt.call_function('apply_filters', [
				rt.new_string('mce_buttons_4'),
				rt.new_array(),
				var_editor_id.clone(),
			])
		}
		mut var_body_class := var_editor_id
		mut var_post := rt.call_function('get_post', []rt.PhpVal{})
		if rt.is_true(var_post) {
			var_body_class = rt.concat(var_body_class, rt.new_string(' post-type-' +
				(rt.call_function('sanitize_html_class', [rt.get_property(var_post, 'post_type')])).str() +
				' post-status-' +(rt.call_function('sanitize_html_class', [rt.get_property(var_post, 'post_status')])).str()))
			if rt.is_true(rt.call_function('post_type_supports', [
				rt.get_property(var_post, 'post_type'),
				rt.new_string('post-formats'),
			]))
			{
				mut var_post_format := rt.call_function('get_post_format', [
					var_post.clone()])
				if rt.is_true(var_post_format)
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_format.clone()]))))) {
					var_body_class = rt.concat(var_body_class, rt.new_string(' post-format-' +
						(rt.call_function('sanitize_html_class', [var_post_format.clone()])).str()))
				} else {
					var_body_class = rt.concat(var_body_class,
						rt.new_string(' post-format-standard'))
				}
			}
			mut var_page_template := rt.call_function('get_page_template_slug', [
				var_post.clone(),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
				var_page_template))))
			{
				var_page_template = if !rt.is_true(var_page_template) { rt.new_string('default') } else { rt.call_function('str_replace', [
						rt.new_string('.'),
						rt.new_string('-'),
						rt.call_function('basename', [var_page_template.clone(),
							rt.new_string('.php')]),
					]) }
				var_body_class = rt.concat(var_body_class, rt.new_string(' page-template-' +
					(rt.call_function('sanitize_html_class', [var_page_template.clone()])).str()))
			}
		}
		var_body_class = rt.concat(var_body_class,
			rt.new_string(' locale-' +(rt.call_function('sanitize_html_class', [rt.new_string(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.call_function('get_user_locale', []rt.PhpVal{})]).to_string().to_lower())])).str()))
		if !(!rt.is_true(var_set_mutated.array_get(rt.new_string('tinymce')).array_get(rt.new_string('body_class')))) {
			var_body_class = rt.concat(var_body_class,
				rt.new_string(' ' +(var_set_mutated.array_get(rt.new_string('tinymce')).array_get(rt.new_string('body_class'))).str()))
			var_set_mutated.array_get(rt.new_string('tinymce')).array_unset(rt.new_string('body_class'))
		}
		mut var_mce_init := rt.create_array([
			rt.ArrayItem{ key: 'selector', val: '#${var_editor_id.to_string()}' },
			rt.ArrayItem{
				key: 'wpautop'
				val: (var_set_mutated.array_get(rt.new_string('wpautop'))).to_bool()
			},
			rt.ArrayItem{
				key: 'indent'
				val: !(rt.is_true(var_set_mutated.array_get(rt.new_string('wpautop'))))
			},
			rt.ArrayItem{ key: 'toolbar1', val: rt.call_function('implode', [
				rt.new_string(','),
				var_mce_buttons.clone(),
			]) },
			rt.ArrayItem{ key: 'toolbar2', val: rt.call_function('implode', [
				rt.new_string(','),
				var_mce_buttons_2.clone(),
			]) },
			rt.ArrayItem{ key: 'toolbar3', val: rt.call_function('implode', [
				rt.new_string(','),
				var_mce_buttons_3.clone(),
			]) },
			rt.ArrayItem{ key: 'toolbar4', val: rt.call_function('implode', [
				rt.new_string(','),
				var_mce_buttons_4.clone(),
			]) },
			rt.ArrayItem{
				key: 'tabfocus_elements'
				val: var_set_mutated.array_get(rt.new_string('tabfocus_elements'))
			},
			rt.ArrayItem{ key: 'body_class', val: var_body_class },
		])
		var_mce_init = rt.call_function('array_merge', [
			rt.get_static_prop('_WP_Editors', 'first_init'),
			var_mce_init.clone(),
		])
		if rt.is_true(rt.new_bool(var_set_mutated.array_get(rt.new_string('tinymce')).is_array())) {
			var_mce_init = rt.call_function('array_merge', [var_mce_init.clone(),
				var_set_mutated.array_get(rt.new_string('tinymce'))])
		}
		if rt.is_true(var_set_mutated.array_get(rt.new_string('teeny'))) {
			var_mce_init = rt.call_function('apply_filters', [
				rt.new_string('teeny_mce_before_init'),
				var_mce_init.clone(),
				var_editor_id.clone(),
			])
		} else {
			var_mce_init = rt.call_function('apply_filters', [
				rt.new_string('tiny_mce_before_init'),
				var_mce_init.clone(),
				var_editor_id.clone(),
			])
		}
		if !rt.is_true(var_mce_init.array_get(rt.new_string('toolbar3')))
			&& !(!rt.is_true(var_mce_init.array_get(rt.new_string('toolbar4')))) {
			var_mce_init.array_set('toolbar3', var_mce_init.array_get(rt.new_string('toolbar4')))
			var_mce_init.array_set('toolbar4', '')
		}
		rt.get_static_prop('_WP_Editors', 'mce_settings').array_set(var_editor_id,
			var_mce_init.clone())
	}
}

fn Class__WP_Editors._parse_init(var_init rt.PhpVal) string {
	mut var_options := rt.new_string('')
	mut iter_4 := var_init.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		if rt.is_true(rt.new_bool(var_value.clone().is_bool())) {
			mut var_val :=
				rt.new_string((if rt.is_true(var_value) { 'true' } else { 'false' }).str())
			var_options = rt.concat(var_options, rt.new_string(var_key.str() + ':' + var_val.str() +
				','))
			continue
		} else if !(!rt.is_true(var_value)) && var_value.clone().is_string()
			&& ((rt.is_true(rt.identical(rt.new_string('{'), var_value.array_get(rt.new_int(0))))
			&& rt.is_true(rt.identical(rt.new_string('}'), var_value.array_get(rt.new_int(var_value.clone().to_string().len - 1)))))
			|| (rt.is_true(rt.identical(rt.new_string('['), var_value.array_get(rt.new_int(0))))
			&& rt.is_true(rt.identical(rt.new_string(']'), var_value.array_get(rt.new_int(var_value.clone().to_string().len - 1))))))
			|| rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\(?function ?\\(/'), var_value.clone()])) {
			var_options = rt.concat(var_options, rt.new_string(var_key.str() + ':' +
				var_value.str() + ','))
			continue
		}
		var_options = rt.concat(var_options, rt.new_string(var_key.str() + ':"' + var_value.str() +
			'",'))
	}
	return '{' + var_options.clone().to_string().trim_space() + '}'
}

fn Class__WP_Editors.enqueue_scripts(default_scripts bool) {
	if var_default_scripts || rt.is_true(rt.get_static_prop('_WP_Editors', 'has_tinymce')) {
		rt.call_function('wp_enqueue_script', [rt.new_string('editor')])
	}
	if var_default_scripts || rt.is_true(rt.get_static_prop('_WP_Editors', 'has_quicktags')) {
		rt.call_function('wp_enqueue_script', [rt.new_string('quicktags')])
		rt.call_function('wp_enqueue_style', [rt.new_string('buttons')])
	}
	if var_default_scripts
		|| rt.is_true(rt.call_function('in_array', [rt.new_string('wplink'), rt.get_static_prop('_WP_Editors', 'plugins'), rt.new_bool(true)]))
		|| rt.is_true(rt.call_function('in_array', [rt.new_string('link'), rt.get_static_prop('_WP_Editors', 'qt_buttons'), rt.new_bool(true)])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wplink')])
		rt.call_function('wp_enqueue_script', [rt.new_string('jquery-ui-autocomplete')])
	}
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'has_medialib')) {
		rt.call_function('add_thickbox', []rt.PhpVal{})
		rt.call_function('wp_enqueue_script', [rt.new_string('media-upload')])
		rt.call_function('wp_enqueue_script', [rt.new_string('wp-embed')])
	} else if var_default_scripts {
		rt.call_function('wp_enqueue_script', [rt.new_string('media-upload')])
	}
	rt.call_function('do_action', [rt.new_string('wp_enqueue_editor'),
		rt.create_array([
			rt.ArrayItem{ key: 'tinymce', val: var_default_scripts
				|| rt.is_true(rt.get_static_prop('_WP_Editors', 'has_tinymce')) },
			rt.ArrayItem{ key: 'quicktags', val: var_default_scripts
				|| rt.is_true(rt.get_static_prop('_WP_Editors', 'has_quicktags')) },
		])])
}

fn Class__WP_Editors.enqueue_default_editor() {
	if rt.is_true(rt.call_function('did_action', [rt.new_string('wp_enqueue_editor')])) {
		return
	}
	Class__WP_Editors.enqueue_scripts(true)
	rt.call_function('wp_enqueue_style', [rt.new_string('editor-buttons')])
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'force_uncompressed_tinymce' }]),
			rt.new_int(1)])
		rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'print_default_editor_scripts' }]),
			rt.new_int(45)])
	} else {
		rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'force_uncompressed_tinymce' }]),
			rt.new_int(1)])
		rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'print_default_editor_scripts' }]),
			rt.new_int(45)])
	}
}

fn Class__WP_Editors.print_default_editor_scripts() {
	mut var_user_can_richedit := rt.call_function('user_can_richedit', []rt.PhpVal{})
	if rt.is_true(var_user_can_richedit) {
		mut var_settings := Class__WP_Editors.default_settings()
		var_settings.array_set('toolbar1', 'bold,italic,bullist,numlist,link')
		var_settings.array_set('wpautop', false)
		var_settings.array_set('indent', true)
		var_settings.array_set('elementpath', false)
		if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
			var_settings.array_set('directionality', 'rtl')
		}
		var_settings.array_set('plugins', rt.call_function('implode', [
			rt.new_string(','),
			rt.create_array([rt.ArrayItem{ key: none, val: 'charmap' },
				rt.ArrayItem{ key: none, val: 'colorpicker' },
				rt.ArrayItem{ key: none, val: 'hr' }, rt.ArrayItem{ key: none, val: 'lists' },
				rt.ArrayItem{ key: none, val: 'paste' }, rt.ArrayItem{ key: none, val: 'tabfocus' },
				rt.ArrayItem{ key: none, val: 'textcolor' }, rt.ArrayItem{
					key: none
					val: 'fullscreen'
				}, rt.ArrayItem{ key: none, val: 'wordpress' },
				rt.ArrayItem{ key: none, val: 'wpautoresize' },
				rt.ArrayItem{ key: none, val: 'wpeditimage' },
				rt.ArrayItem{ key: none, val: 'wpemoji' }, rt.ArrayItem{ key: none, val: 'wpgallery' },
				rt.ArrayItem{ key: none, val: 'wplink' }, rt.ArrayItem{
					key: none
					val: 'wptextpattern'
				}]),
		]))
		var_settings = Class__WP_Editors._parse_init(var_settings.clone())
	} else {
		var_settings = rt.new_string('{}')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_settings)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_user_can_richedit) {
		mut var_suffix := rt.new_string((if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) {
			''
		} else {
			'.min'
		}).str())
		mut var_baseurl := Class__WP_Editors.get_baseurl()
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_baseurl)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_suffix)
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_user_can_richedit) {
		Class__WP_Editors.print_tinymce_scripts()
	}
	rt.call_function('do_action', [rt.new_string('print_default_editor_scripts')])
	Class__WP_Editors.wp_link_dialog()
}

fn Class__WP_Editors.get_mce_locale() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('_WP_Editors', 'mce_locale')) {
		mut var_mce_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
		rt.set_static_prop('_WP_Editors', 'mce_locale', if !rt.is_true(var_mce_locale) { 'en' } else { rt.call_function('substr', [
				var_mce_locale.clone(),
				rt.new_int(0),
				rt.new_int(2),
			]).to_string().to_lower() })
	}
	return rt.get_static_prop('_WP_Editors', 'mce_locale')
}

fn Class__WP_Editors.get_baseurl() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('_WP_Editors', 'baseurl')) {
		rt.set_static_prop('_WP_Editors', 'baseurl', rt.call_function('includes_url', [
			rt.new_string('js/tinymce'),
		]))
	}
	return rt.get_static_prop('_WP_Editors', 'baseurl')
}

fn Class__WP_Editors.default_settings() rt.PhpVal {
	mut var_tinymce_version := rt.new_null()
	mut var_shortcut_labels := rt.new_array()
	mut iter_5 := Class__WP_Editors.get_translation().iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value := item_5.val
		mut var_name := item_5.key
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_shortcut_labels.array_set(var_name, var_value.array_get(rt.new_int(1)))
		}
	}
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'theme', val: 'modern' },
		rt.ArrayItem{ key: 'skin', val: 'lightgray' }, rt.ArrayItem{
			key: 'language'
			val: Class__WP_Editors.get_mce_locale()
		}, rt.ArrayItem{ key: 'formats', val: '{' + 'alignleft: [' +
			'{selector: "p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li", styles: {textAlign:"left"}},' +
			'{selector: "img,table,dl.wp-caption", classes: "alignleft"}' + '],' +
			'aligncenter: [' +
			'{selector: "p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li", styles: {textAlign:"center"}},' +
			'{selector: "img,table,dl.wp-caption", classes: "aligncenter"}' + '],' +
			'alignright: [' +
			'{selector: "p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li", styles: {textAlign:"right"}},' +
			'{selector: "img,table,dl.wp-caption", classes: "alignright"}' + '],' +
			'strikethrough: {inline: "del"}' + '}' }, rt.ArrayItem{ key: 'relative_urls', val: false },
		rt.ArrayItem{ key: 'remove_script_host', val: false },
		rt.ArrayItem{ key: 'convert_urls', val: false }, rt.ArrayItem{
			key: 'browser_spellcheck'
			val: true
		}, rt.ArrayItem{ key: 'fix_list_elements', val: true },
		rt.ArrayItem{ key: 'entities', val: '38,amp,60,lt,62,gt' },
		rt.ArrayItem{ key: 'entity_encoding', val: 'raw' }, rt.ArrayItem{
			key: 'keep_styles'
			val: false
		}, rt.ArrayItem{ key: 'cache_suffix', val: 'wp-mce-' + var_tinymce_version.str() },
		rt.ArrayItem{ key: 'resize', val: 'vertical' }, rt.ArrayItem{ key: 'menubar', val: false },
		rt.ArrayItem{ key: 'branding', val: false }, rt.ArrayItem{
			key: 'preview_styles'
			val: 'font-family font-size font-weight font-style text-decoration text-transform'
		}, rt.ArrayItem{ key: 'end_container_on_empty_block', val: true },
		rt.ArrayItem{ key: 'wpeditimage_html5_captions', val: true },
		rt.ArrayItem{ key: 'wp_lang_attr', val: rt.call_function('get_bloginfo', [
			rt.new_string('language'),
		]) }, rt.ArrayItem{ key: 'wp_shortcut_labels', val: rt.call_function('wp_json_encode', [
			var_shortcut_labels.clone(),
		]) }])
	mut var_suffix := rt.new_string((if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) {
		''
	} else {
		'.min'
	}).str())
	mut var_version := rt.new_string('ver=' +
		(rt.call_function('get_bloginfo', [rt.new_string('version')])).str())
	var_settings.array_set('content_css',
		(rt.call_function('includes_url', [rt.new_string('css/dashicons${var_suffix.to_string()}.css?${var_version.to_string()}')])).str() +
		',' +(rt.call_function('includes_url', [rt.new_string('js/tinymce/skins/wordpress/wp-content.css?${var_version.to_string()}')])).str())
	return var_settings.clone()
}

fn Class__WP_Editors.get_translation() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('_WP_Editors', 'translation')) {
		rt.set_static_prop('_WP_Editors', 'translation', rt.create_array([
			rt.ArrayItem{ key: 'New document', val: rt.call_function('__', [
				rt.new_string('New document'),
			]) },
			rt.ArrayItem{ key: 'Formats', val: rt.call_function('_x', [
				rt.new_string('Formats'),
				rt.new_string('TinyMCE'),
			]) },
			rt.ArrayItem{ key: 'Headings', val: rt.call_function('_x', [
				rt.new_string('Headings'),
				rt.new_string('TinyMCE'),
			]) },
			rt.ArrayItem{ key: 'Heading 1', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Heading 1'),
				]) },
				rt.ArrayItem{ key: none, val: 'access1' },
			]) },
			rt.ArrayItem{ key: 'Heading 2', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Heading 2'),
				]) },
				rt.ArrayItem{ key: none, val: 'access2' },
			]) },
			rt.ArrayItem{ key: 'Heading 3', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Heading 3'),
				]) },
				rt.ArrayItem{ key: none, val: 'access3' },
			]) },
			rt.ArrayItem{ key: 'Heading 4', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Heading 4'),
				]) },
				rt.ArrayItem{ key: none, val: 'access4' },
			]) },
			rt.ArrayItem{ key: 'Heading 5', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Heading 5'),
				]) },
				rt.ArrayItem{ key: none, val: 'access5' },
			]) },
			rt.ArrayItem{ key: 'Heading 6', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Heading 6'),
				]) },
				rt.ArrayItem{ key: none, val: 'access6' },
			]) },
			rt.ArrayItem{ key: 'Blocks', val: rt.call_function('_x', [
				rt.new_string('Blocks'),
				rt.new_string('TinyMCE'),
			]) },
			rt.ArrayItem{ key: 'Paragraph', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Paragraph'),
				]) },
				rt.ArrayItem{ key: none, val: 'access7' },
			]) },
			rt.ArrayItem{ key: 'Blockquote', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Blockquote'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessQ' },
			]) },
			rt.ArrayItem{ key: 'Div', val: rt.call_function('_x', [
				rt.new_string('Div'),
				rt.new_string('HTML tag'),
			]) },
			rt.ArrayItem{ key: 'Pre', val: rt.call_function('_x', [
				rt.new_string('Pre'),
				rt.new_string('HTML tag'),
			]) },
			rt.ArrayItem{ key: 'Preformatted', val: rt.call_function('_x', [
				rt.new_string('Preformatted'),
				rt.new_string('HTML tag'),
			]) },
			rt.ArrayItem{ key: 'Address', val: rt.call_function('_x', [
				rt.new_string('Address'),
				rt.new_string('HTML tag'),
			]) },
			rt.ArrayItem{ key: 'Inline', val: rt.call_function('_x', [
				rt.new_string('Inline'),
				rt.new_string('HTML elements'),
			]) },
			rt.ArrayItem{ key: 'Underline', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Underline'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaU' },
			]) },
			rt.ArrayItem{ key: 'Strikethrough', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Strikethrough'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessD' },
			]) },
			rt.ArrayItem{ key: 'Subscript', val: rt.call_function('__', [
				rt.new_string('Subscript'),
			]) },
			rt.ArrayItem{ key: 'Superscript', val: rt.call_function('__', [
				rt.new_string('Superscript'),
			]) },
			rt.ArrayItem{ key: 'Clear formatting', val: rt.call_function('__', [
				rt.new_string('Clear formatting'),
			]) },
			rt.ArrayItem{ key: 'Bold', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Bold'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaB' },
			]) },
			rt.ArrayItem{ key: 'Italic', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Italic'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaI' },
			]) },
			rt.ArrayItem{ key: 'Code', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Code'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessX' },
			]) },
			rt.ArrayItem{ key: 'Source code', val: rt.call_function('__', [
				rt.new_string('Source code'),
			]) },
			rt.ArrayItem{ key: 'Font Family', val: rt.call_function('__', [
				rt.new_string('Font Family'),
			]) },
			rt.ArrayItem{ key: 'Font Sizes', val: rt.call_function('__', [
				rt.new_string('Font Sizes'),
			]) },
			rt.ArrayItem{ key: 'Align center', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Align center'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessC' },
			]) },
			rt.ArrayItem{ key: 'Align right', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Align right'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessR' },
			]) },
			rt.ArrayItem{ key: 'Align left', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Align left'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessL' },
			]) },
			rt.ArrayItem{ key: 'Justify', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Justify'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessJ' },
			]) },
			rt.ArrayItem{ key: 'Increase indent', val: rt.call_function('__', [
				rt.new_string('Increase indent'),
			]) },
			rt.ArrayItem{ key: 'Decrease indent', val: rt.call_function('__', [
				rt.new_string('Decrease indent'),
			]) },
			rt.ArrayItem{ key: 'Cut', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Cut'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaX' },
			]) },
			rt.ArrayItem{ key: 'Copy', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Copy'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaC' },
			]) },
			rt.ArrayItem{ key: 'Paste', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Paste'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaV' },
			]) },
			rt.ArrayItem{ key: 'Select all', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Select all'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaA' },
			]) },
			rt.ArrayItem{ key: 'Undo', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Undo'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaZ' },
			]) },
			rt.ArrayItem{ key: 'Redo', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Redo'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaY' },
			]) },
			rt.ArrayItem{ key: 'Ok', val: rt.call_function('__', [
				rt.new_string('OK'),
			]) },
			rt.ArrayItem{ key: 'Cancel', val: rt.call_function('__', [
				rt.new_string('Cancel'),
			]) },
			rt.ArrayItem{ key: 'Close', val: rt.call_function('__', [
				rt.new_string('Close'),
			]) },
			rt.ArrayItem{ key: 'Visual aids', val: rt.call_function('__', [
				rt.new_string('Visual aids'),
			]) },
			rt.ArrayItem{ key: 'Bullet list', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Bulleted list'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessU' },
			]) },
			rt.ArrayItem{ key: 'Numbered list', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Numbered list'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessO' },
			]) },
			rt.ArrayItem{ key: 'Square', val: rt.call_function('_x', [
				rt.new_string('Square'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Default', val: rt.call_function('_x', [
				rt.new_string('Default'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Circle', val: rt.call_function('_x', [
				rt.new_string('Circle'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Disc', val: rt.call_function('_x', [
				rt.new_string('Disc'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Lower Greek', val: rt.call_function('_x', [
				rt.new_string('Lower Greek'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Lower Alpha', val: rt.call_function('_x', [
				rt.new_string('Lower Alpha'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Upper Alpha', val: rt.call_function('_x', [
				rt.new_string('Upper Alpha'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Upper Roman', val: rt.call_function('_x', [
				rt.new_string('Upper Roman'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Lower Roman', val: rt.call_function('_x', [
				rt.new_string('Lower Roman'),
				rt.new_string('list style'),
			]) },
			rt.ArrayItem{ key: 'Name', val: rt.call_function('_x', [
				rt.new_string('Name'),
				rt.new_string('Name of link anchor (TinyMCE)'),
			]) },
			rt.ArrayItem{ key: 'Anchor', val: rt.call_function('_x', [
				rt.new_string('Anchor'),
				rt.new_string('Link anchor (TinyMCE)'),
			]) },
			rt.ArrayItem{ key: 'Anchors', val: rt.call_function('_x', [
				rt.new_string('Anchors'),
				rt.new_string('Link anchors (TinyMCE)'),
			]) },
			rt.ArrayItem{
				key: 'Id should start with a letter, followed only by letters, numbers, dashes, dots, colons or underscores.'
				val: rt.call_function('__', [
					rt.new_string('Id should start with a letter, followed only by letters, numbers, dashes, dots, colons or underscores.'),
				])
			},
			rt.ArrayItem{ key: 'Id', val: rt.call_function('_x', [
				rt.new_string('Id'),
				rt.new_string('Id for link anchor (TinyMCE)'),
			]) },
			rt.ArrayItem{ key: 'Document properties', val: rt.call_function('__', [
				rt.new_string('Document properties'),
			]) },
			rt.ArrayItem{ key: 'Robots', val: rt.call_function('__', [
				rt.new_string('Robots'),
			]) },
			rt.ArrayItem{ key: 'Title', val: rt.call_function('__', [
				rt.new_string('Title'),
			]) },
			rt.ArrayItem{ key: 'Keywords', val: rt.call_function('__', [
				rt.new_string('Keywords'),
			]) },
			rt.ArrayItem{ key: 'Encoding', val: rt.call_function('__', [
				rt.new_string('Encoding'),
			]) },
			rt.ArrayItem{ key: 'Description', val: rt.call_function('__', [
				rt.new_string('Description'),
			]) },
			rt.ArrayItem{ key: 'Author', val: rt.call_function('__', [
				rt.new_string('Author'),
			]) },
			rt.ArrayItem{ key: 'Image', val: rt.call_function('__', [
				rt.new_string('Image'),
			]) },
			rt.ArrayItem{ key: 'Insert/edit image', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Insert/edit image'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessM' },
			]) },
			rt.ArrayItem{ key: 'General', val: rt.call_function('__', [
				rt.new_string('General'),
			]) },
			rt.ArrayItem{ key: 'Advanced', val: rt.call_function('__', [
				rt.new_string('Advanced'),
			]) },
			rt.ArrayItem{ key: 'Source', val: rt.call_function('__', [
				rt.new_string('Source'),
			]) },
			rt.ArrayItem{ key: 'Border', val: rt.call_function('__', [
				rt.new_string('Border'),
			]) },
			rt.ArrayItem{ key: 'Constrain proportions', val: rt.call_function('__', [
				rt.new_string('Constrain proportions'),
			]) },
			rt.ArrayItem{ key: 'Vertical space', val: rt.call_function('__', [
				rt.new_string('Vertical space'),
			]) },
			rt.ArrayItem{ key: 'Image description', val: rt.call_function('__', [
				rt.new_string('Image description'),
			]) },
			rt.ArrayItem{ key: 'Style', val: rt.call_function('__', [
				rt.new_string('Style'),
			]) },
			rt.ArrayItem{ key: 'Dimensions', val: rt.call_function('__', [
				rt.new_string('Dimensions'),
			]) },
			rt.ArrayItem{ key: 'Insert image', val: rt.call_function('__', [
				rt.new_string('Insert image'),
			]) },
			rt.ArrayItem{ key: 'Date/time', val: rt.call_function('__', [
				rt.new_string('Date/time'),
			]) },
			rt.ArrayItem{ key: 'Insert date/time', val: rt.call_function('__', [
				rt.new_string('Insert date/time'),
			]) },
			rt.ArrayItem{ key: 'Table of Contents', val: rt.call_function('__', [
				rt.new_string('Table of Contents'),
			]) },
			rt.ArrayItem{ key: 'Insert/Edit code sample', val: rt.call_function('__', [
				rt.new_string('Insert/edit code sample'),
			]) },
			rt.ArrayItem{ key: 'Language', val: rt.call_function('__', [
				rt.new_string('Language'),
			]) },
			rt.ArrayItem{ key: 'Media', val: rt.call_function('__', [
				rt.new_string('Media'),
			]) },
			rt.ArrayItem{ key: 'Insert/edit media', val: rt.call_function('__', [
				rt.new_string('Insert/edit media'),
			]) },
			rt.ArrayItem{ key: 'Poster', val: rt.call_function('__', [
				rt.new_string('Poster'),
			]) },
			rt.ArrayItem{ key: 'Alternative source', val: rt.call_function('__', [
				rt.new_string('Alternative source'),
			]) },
			rt.ArrayItem{ key: 'Paste your embed code below:', val: rt.call_function('__', [
				rt.new_string('Paste your embed code below:'),
			]) },
			rt.ArrayItem{ key: 'Insert video', val: rt.call_function('__', [
				rt.new_string('Insert video'),
			]) },
			rt.ArrayItem{ key: 'Embed', val: rt.call_function('__', [
				rt.new_string('Embed'),
			]) },
			rt.ArrayItem{ key: 'Special character', val: rt.call_function('__', [
				rt.new_string('Special character'),
			]) },
			rt.ArrayItem{ key: 'Right to left', val: rt.call_function('_x', [
				rt.new_string('Right to left'),
				rt.new_string('editor button'),
			]) },
			rt.ArrayItem{ key: 'Left to right', val: rt.call_function('_x', [
				rt.new_string('Left to right'),
				rt.new_string('editor button'),
			]) },
			rt.ArrayItem{ key: 'Emoticons', val: rt.call_function('__', [
				rt.new_string('Emoticons'),
			]) },
			rt.ArrayItem{ key: 'Nonbreaking space', val: rt.call_function('__', [
				rt.new_string('Nonbreaking space'),
			]) },
			rt.ArrayItem{ key: 'Page break', val: rt.call_function('__', [
				rt.new_string('Page break'),
			]) },
			rt.ArrayItem{ key: 'Paste as text', val: rt.call_function('__', [
				rt.new_string('Paste as text'),
			]) },
			rt.ArrayItem{ key: 'Preview', val: rt.call_function('_x', [
				rt.new_string('Preview'),
				rt.new_string('verb'),
			]) },
			rt.ArrayItem{ key: 'Print', val: rt.call_function('__', [
				rt.new_string('Print'),
			]) },
			rt.ArrayItem{ key: 'Save', val: rt.call_function('__', [
				rt.new_string('Save'),
			]) },
			rt.ArrayItem{ key: 'Fullscreen', val: rt.call_function('__', [
				rt.new_string('Fullscreen'),
			]) },
			rt.ArrayItem{ key: 'Horizontal line', val: rt.call_function('__', [
				rt.new_string('Horizontal line'),
			]) },
			rt.ArrayItem{ key: 'Horizontal space', val: rt.call_function('__', [
				rt.new_string('Horizontal space'),
			]) },
			rt.ArrayItem{ key: 'Restore last draft', val: rt.call_function('__', [
				rt.new_string('Restore last draft'),
			]) },
			rt.ArrayItem{ key: 'Insert/edit link', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Insert/edit link'),
				]) },
				rt.ArrayItem{ key: none, val: 'metaK' },
			]) },
			rt.ArrayItem{ key: 'Remove link', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Remove link'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessS' },
			]) },
			rt.ArrayItem{ key: 'Link', val: rt.call_function('__', [
				rt.new_string('Link'),
			]) },
			rt.ArrayItem{ key: 'Insert link', val: rt.call_function('__', [
				rt.new_string('Insert link'),
			]) },
			rt.ArrayItem{ key: 'Target', val: rt.call_function('__', [
				rt.new_string('Target'),
			]) },
			rt.ArrayItem{ key: 'New window', val: rt.call_function('__', [
				rt.new_string('New window'),
			]) },
			rt.ArrayItem{ key: 'Text to display', val: rt.call_function('__', [
				rt.new_string('Text to display'),
			]) },
			rt.ArrayItem{ key: 'Url', val: rt.call_function('__', [
				rt.new_string('URL'),
			]) },
			rt.ArrayItem{
				key: 'The URL you entered seems to be an email address. Do you want to add the required mailto: prefix?'
				val: rt.call_function('__', [
					rt.new_string('The URL you entered seems to be an email address. Do you want to add the required mailto: prefix?'),
				])
			},
			rt.ArrayItem{
				key: 'The URL you entered seems to be an external link. Do you want to add the required http:// prefix?'
				val: rt.call_function('__', [
					rt.new_string('The URL you entered seems to be an external link. Do you want to add the required http:// prefix?'),
				])
			},
			rt.ArrayItem{ key: 'Color', val: rt.call_function('__', [
				rt.new_string('Color'),
			]) },
			rt.ArrayItem{ key: 'Custom color', val: rt.call_function('__', [
				rt.new_string('Custom color'),
			]) },
			rt.ArrayItem{ key: 'Custom...', val: rt.call_function('_x', [
				rt.new_string('Custom...'),
				rt.new_string('label for custom color'),
			]) },
			rt.ArrayItem{ key: 'No color', val: rt.call_function('__', [
				rt.new_string('No color'),
			]) },
			rt.ArrayItem{ key: 'R', val: rt.call_function('_x', [
				rt.new_string('R'),
				rt.new_string('Short for red in RGB'),
			]) },
			rt.ArrayItem{ key: 'G', val: rt.call_function('_x', [
				rt.new_string('G'),
				rt.new_string('Short for green in RGB'),
			]) },
			rt.ArrayItem{ key: 'B', val: rt.call_function('_x', [
				rt.new_string('B'),
				rt.new_string('Short for blue in RGB'),
			]) },
			rt.ArrayItem{ key: 'Could not find the specified string.', val: rt.call_function('__', [
				rt.new_string('Could not find the specified string.'),
			]) },
			rt.ArrayItem{ key: 'Replace', val: rt.call_function('_x', [
				rt.new_string('Replace'),
				rt.new_string('find/replace'),
			]) },
			rt.ArrayItem{ key: 'Next', val: rt.call_function('_x', [
				rt.new_string('Next'),
				rt.new_string('find/replace'),
			]) },
			rt.ArrayItem{ key: 'Prev', val: rt.call_function('_x', [
				rt.new_string('Prev'),
				rt.new_string('find/replace'),
			]) },
			rt.ArrayItem{ key: 'Whole words', val: rt.call_function('_x', [
				rt.new_string('Whole words'),
				rt.new_string('find/replace'),
			]) },
			rt.ArrayItem{ key: 'Find and replace', val: rt.call_function('__', [
				rt.new_string('Find and replace'),
			]) },
			rt.ArrayItem{ key: 'Replace with', val: rt.call_function('_x', [
				rt.new_string('Replace with'),
				rt.new_string('find/replace'),
			]) },
			rt.ArrayItem{ key: 'Find', val: rt.call_function('_x', [
				rt.new_string('Find'),
				rt.new_string('find/replace'),
			]) },
			rt.ArrayItem{ key: 'Replace all', val: rt.call_function('_x', [
				rt.new_string('Replace all'),
				rt.new_string('find/replace'),
			]) },
			rt.ArrayItem{ key: 'Match case', val: rt.call_function('__', [
				rt.new_string('Match case'),
			]) },
			rt.ArrayItem{ key: 'Spellcheck', val: rt.call_function('__', [
				rt.new_string('Check Spelling'),
			]) },
			rt.ArrayItem{ key: 'Finish', val: rt.call_function('_x', [
				rt.new_string('Finish'),
				rt.new_string('spellcheck'),
			]) },
			rt.ArrayItem{ key: 'Ignore all', val: rt.call_function('_x', [
				rt.new_string('Ignore all'),
				rt.new_string('spellcheck'),
			]) },
			rt.ArrayItem{ key: 'Ignore', val: rt.call_function('_x', [
				rt.new_string('Ignore'),
				rt.new_string('spellcheck'),
			]) },
			rt.ArrayItem{ key: 'Add to Dictionary', val: rt.call_function('__', [
				rt.new_string('Add to Dictionary'),
			]) },
			rt.ArrayItem{ key: 'Insert table', val: rt.call_function('__', [
				rt.new_string('Insert table'),
			]) },
			rt.ArrayItem{ key: 'Delete table', val: rt.call_function('__', [
				rt.new_string('Delete table'),
			]) },
			rt.ArrayItem{ key: 'Table properties', val: rt.call_function('__', [
				rt.new_string('Table properties'),
			]) },
			rt.ArrayItem{ key: 'Row properties', val: rt.call_function('__', [
				rt.new_string('Table row properties'),
			]) },
			rt.ArrayItem{ key: 'Cell properties', val: rt.call_function('__', [
				rt.new_string('Table cell properties'),
			]) },
			rt.ArrayItem{ key: 'Border color', val: rt.call_function('__', [
				rt.new_string('Border color'),
			]) },
			rt.ArrayItem{ key: 'Row', val: rt.call_function('__', [
				rt.new_string('Row'),
			]) },
			rt.ArrayItem{ key: 'Rows', val: rt.call_function('__', [
				rt.new_string('Rows'),
			]) },
			rt.ArrayItem{ key: 'Column', val: rt.call_function('__', [
				rt.new_string('Column'),
			]) },
			rt.ArrayItem{ key: 'Cols', val: rt.call_function('__', [
				rt.new_string('Columns'),
			]) },
			rt.ArrayItem{ key: 'Cell', val: rt.call_function('_x', [
				rt.new_string('Cell'),
				rt.new_string('table cell'),
			]) },
			rt.ArrayItem{ key: 'Header cell', val: rt.call_function('__', [
				rt.new_string('Header cell'),
			]) },
			rt.ArrayItem{ key: 'Header', val: rt.call_function('_x', [
				rt.new_string('Header'),
				rt.new_string('table header'),
			]) },
			rt.ArrayItem{ key: 'Body', val: rt.call_function('_x', [
				rt.new_string('Body'),
				rt.new_string('table body'),
			]) },
			rt.ArrayItem{ key: 'Footer', val: rt.call_function('_x', [
				rt.new_string('Footer'),
				rt.new_string('table footer'),
			]) },
			rt.ArrayItem{ key: 'Insert row before', val: rt.call_function('__', [
				rt.new_string('Insert row before'),
			]) },
			rt.ArrayItem{ key: 'Insert row after', val: rt.call_function('__', [
				rt.new_string('Insert row after'),
			]) },
			rt.ArrayItem{ key: 'Insert column before', val: rt.call_function('__', [
				rt.new_string('Insert column before'),
			]) },
			rt.ArrayItem{ key: 'Insert column after', val: rt.call_function('__', [
				rt.new_string('Insert column after'),
			]) },
			rt.ArrayItem{ key: 'Paste row before', val: rt.call_function('__', [
				rt.new_string('Paste table row before'),
			]) },
			rt.ArrayItem{ key: 'Paste row after', val: rt.call_function('__', [
				rt.new_string('Paste table row after'),
			]) },
			rt.ArrayItem{ key: 'Delete row', val: rt.call_function('__', [
				rt.new_string('Delete row'),
			]) },
			rt.ArrayItem{ key: 'Delete column', val: rt.call_function('__', [
				rt.new_string('Delete column'),
			]) },
			rt.ArrayItem{ key: 'Cut row', val: rt.call_function('__', [
				rt.new_string('Cut table row'),
			]) },
			rt.ArrayItem{ key: 'Copy row', val: rt.call_function('__', [
				rt.new_string('Copy table row'),
			]) },
			rt.ArrayItem{ key: 'Merge cells', val: rt.call_function('__', [
				rt.new_string('Merge table cells'),
			]) },
			rt.ArrayItem{ key: 'Split cell', val: rt.call_function('__', [
				rt.new_string('Split table cell'),
			]) },
			rt.ArrayItem{ key: 'Height', val: rt.call_function('__', [
				rt.new_string('Height'),
			]) },
			rt.ArrayItem{ key: 'Width', val: rt.call_function('__', [
				rt.new_string('Width'),
			]) },
			rt.ArrayItem{ key: 'Caption', val: rt.call_function('__', [
				rt.new_string('Caption'),
			]) },
			rt.ArrayItem{ key: 'Alignment', val: rt.call_function('__', [
				rt.new_string('Alignment'),
			]) },
			rt.ArrayItem{ key: 'H Align', val: rt.call_function('_x', [
				rt.new_string('H Align'),
				rt.new_string('horizontal table cell alignment'),
			]) },
			rt.ArrayItem{ key: 'Left', val: rt.call_function('__', [
				rt.new_string('Left'),
			]) },
			rt.ArrayItem{ key: 'Center', val: rt.call_function('__', [
				rt.new_string('Center'),
			]) },
			rt.ArrayItem{ key: 'Right', val: rt.call_function('__', [
				rt.new_string('Right'),
			]) },
			rt.ArrayItem{ key: 'None', val: rt.call_function('_x', [
				rt.new_string('None'),
				rt.new_string('table cell alignment attribute'),
			]) },
			rt.ArrayItem{ key: 'V Align', val: rt.call_function('_x', [
				rt.new_string('V Align'),
				rt.new_string('vertical table cell alignment'),
			]) },
			rt.ArrayItem{ key: 'Top', val: rt.call_function('__', [
				rt.new_string('Top'),
			]) },
			rt.ArrayItem{ key: 'Middle', val: rt.call_function('__', [
				rt.new_string('Middle'),
			]) },
			rt.ArrayItem{ key: 'Bottom', val: rt.call_function('__', [
				rt.new_string('Bottom'),
			]) },
			rt.ArrayItem{ key: 'Row group', val: rt.call_function('__', [
				rt.new_string('Row group'),
			]) },
			rt.ArrayItem{ key: 'Column group', val: rt.call_function('__', [
				rt.new_string('Column group'),
			]) },
			rt.ArrayItem{ key: 'Row type', val: rt.call_function('__', [
				rt.new_string('Row type'),
			]) },
			rt.ArrayItem{ key: 'Cell type', val: rt.call_function('__', [
				rt.new_string('Cell type'),
			]) },
			rt.ArrayItem{ key: 'Cell padding', val: rt.call_function('__', [
				rt.new_string('Cell padding'),
			]) },
			rt.ArrayItem{ key: 'Cell spacing', val: rt.call_function('__', [
				rt.new_string('Cell spacing'),
			]) },
			rt.ArrayItem{ key: 'Scope', val: rt.call_function('_x', [
				rt.new_string('Scope'),
				rt.new_string('table cell scope attribute'),
			]) },
			rt.ArrayItem{ key: 'Insert template', val: rt.call_function('_x', [
				rt.new_string('Insert template'),
				rt.new_string('TinyMCE'),
			]) },
			rt.ArrayItem{ key: 'Templates', val: rt.call_function('_x', [
				rt.new_string('Templates'),
				rt.new_string('TinyMCE'),
			]) },
			rt.ArrayItem{ key: 'Background color', val: rt.call_function('__', [
				rt.new_string('Background color'),
			]) },
			rt.ArrayItem{ key: 'Text color', val: rt.call_function('__', [
				rt.new_string('Text color'),
			]) },
			rt.ArrayItem{ key: 'Show blocks', val: rt.call_function('_x', [
				rt.new_string('Show blocks'),
				rt.new_string('editor button'),
			]) },
			rt.ArrayItem{ key: 'Show invisible characters', val: rt.call_function('__', [
				rt.new_string('Show invisible characters'),
			]) },
			rt.ArrayItem{ key: 'Words: {0}', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Words: %s'),
				]),
				rt.new_string('{0}'),
			]) },
			rt.ArrayItem{
				key: 'Paste is now in plain text mode. Contents will now be pasted as plain text until you toggle this option off.'
				val:
					(rt.call_function('__', [rt.new_string('Paste is now in plain text mode. Contents will now be pasted as plain text until you toggle this option off.')])).str() +
					'\n\n' +(rt.call_function('__', [rt.new_string('If you are looking to paste rich content from Microsoft Word, try turning this option off. The editor will clean up text pasted from Word automatically.')])).str()
			},
			rt.ArrayItem{
				key: 'Rich Text Area. Press ALT-F9 for menu. Press ALT-F10 for toolbar. Press ALT-0 for help'
				val: rt.call_function('__', [
					rt.new_string('Rich Text Area. Press Alt-Shift-H for help.'),
				])
			},
			rt.ArrayItem{ key: 'Rich Text Area. Press Control-Option-H for help.', val: rt.call_function('__', [
				rt.new_string('Rich Text Area. Press Control-Option-H for help.'),
			]) },
			rt.ArrayItem{ key: 'You have unsaved changes are you sure you want to navigate away?', val: rt.call_function('__', [
				rt.new_string('The changes you made will be lost if you navigate away from this page.'),
			]) },
			rt.ArrayItem{
				key: "Your browser doesn't support direct access to the clipboard. Please use the Ctrl+X/C/V keyboard shortcuts instead."
				val: rt.call_function('__', [
					rt.new_string('Your browser does not support direct access to the clipboard. Please use keyboard shortcuts or your browser&#8217;s edit menu instead.'),
				])
			},
			rt.ArrayItem{ key: 'Insert', val: rt.call_function('_x', [
				rt.new_string('Insert'),
				rt.new_string('TinyMCE menu'),
			]) },
			rt.ArrayItem{ key: 'File', val: rt.call_function('_x', [
				rt.new_string('File'),
				rt.new_string('TinyMCE menu'),
			]) },
			rt.ArrayItem{ key: 'Edit', val: rt.call_function('_x', [
				rt.new_string('Edit'),
				rt.new_string('TinyMCE menu'),
			]) },
			rt.ArrayItem{ key: 'Tools', val: rt.call_function('_x', [
				rt.new_string('Tools'),
				rt.new_string('TinyMCE menu'),
			]) },
			rt.ArrayItem{ key: 'View', val: rt.call_function('_x', [
				rt.new_string('View'),
				rt.new_string('TinyMCE menu'),
			]) },
			rt.ArrayItem{ key: 'Table', val: rt.call_function('_x', [
				rt.new_string('Table'),
				rt.new_string('TinyMCE menu'),
			]) },
			rt.ArrayItem{ key: 'Format', val: rt.call_function('_x', [
				rt.new_string('Format'),
				rt.new_string('TinyMCE menu'),
			]) },
			rt.ArrayItem{ key: 'Toolbar Toggle', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Toolbar Toggle'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessZ' },
			]) },
			rt.ArrayItem{ key: 'Insert Read More tag', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Insert Read More tag'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessT' },
			]) },
			rt.ArrayItem{ key: 'Insert Page Break tag', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Insert Page Break tag'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessP' },
			]) },
			rt.ArrayItem{ key: 'Read more...', val: rt.call_function('__', [
				rt.new_string('Read more...'),
			]) },
			rt.ArrayItem{ key: 'Distraction-free writing mode', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Distraction-free writing mode'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessW' },
			]) },
			rt.ArrayItem{ key: 'No alignment', val: rt.call_function('__', [
				rt.new_string('No alignment'),
			]) },
			rt.ArrayItem{ key: 'Remove', val: rt.call_function('__', [
				rt.new_string('Remove'),
			]) },
			rt.ArrayItem{ key: 'Edit|button', val: rt.call_function('__', [
				rt.new_string('Edit'),
			]) },
			rt.ArrayItem{ key: 'Paste URL or type to search', val: rt.call_function('__', [
				rt.new_string('Paste URL or type to search'),
			]) },
			rt.ArrayItem{ key: 'Apply', val: rt.call_function('__', [
				rt.new_string('Apply'),
			]) },
			rt.ArrayItem{ key: 'Link options', val: rt.call_function('__', [
				rt.new_string('Link options'),
			]) },
			rt.ArrayItem{ key: 'Visual', val: rt.call_function('_x', [
				rt.new_string('Visual'),
				rt.new_string('Name for the Visual editor tab'),
			]) },
			rt.ArrayItem{ key: 'Code|tab', val: rt.call_function('_x', [
				rt.new_string('Code'),
				rt.new_string('Name for the Code editor tab (formerly Text)'),
			]) },
			rt.ArrayItem{ key: 'Add Media', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Add Media'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessM' },
			]) },
			rt.ArrayItem{ key: 'Keyboard Shortcuts', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('Keyboard Shortcuts'),
				]) },
				rt.ArrayItem{ key: none, val: 'accessH' },
			]) },
			rt.ArrayItem{ key: 'Classic Block Keyboard Shortcuts', val: rt.call_function('__', [
				rt.new_string('Classic Block Keyboard Shortcuts'),
			]) },
			rt.ArrayItem{ key: 'Default shortcuts,', val: rt.call_function('__', [
				rt.new_string('Default shortcuts,'),
			]) },
			rt.ArrayItem{ key: 'Additional shortcuts,', val: rt.call_function('__', [
				rt.new_string('Additional shortcuts,'),
			]) },
			rt.ArrayItem{ key: 'Focus shortcuts:', val: rt.call_function('__', [
				rt.new_string('Focus shortcuts:'),
			]) },
			rt.ArrayItem{ key: 'Inline toolbar (when an image, link or preview is selected)', val: rt.call_function('__', [
				rt.new_string('Inline toolbar (when an image, link or preview is selected)'),
			]) },
			rt.ArrayItem{ key: 'Editor menu (when enabled)', val: rt.call_function('__', [
				rt.new_string('Editor menu (when enabled)'),
			]) },
			rt.ArrayItem{ key: 'Editor toolbar', val: rt.call_function('__', [
				rt.new_string('Editor toolbar'),
			]) },
			rt.ArrayItem{ key: 'Elements path', val: rt.call_function('__', [
				rt.new_string('Elements path'),
			]) },
			rt.ArrayItem{ key: 'Ctrl + Alt + letter:', val: rt.call_function('__', [
				rt.new_string('Ctrl + Alt + letter:'),
			]) },
			rt.ArrayItem{ key: 'Shift + Alt + letter:', val: rt.call_function('__', [
				rt.new_string('Shift + Alt + letter:'),
			]) },
			rt.ArrayItem{ key: 'Cmd + letter:', val: rt.call_function('__', [
				rt.new_string('Cmd + letter:'),
			]) },
			rt.ArrayItem{ key: 'Ctrl + letter:', val: rt.call_function('__', [
				rt.new_string('Ctrl + letter:'),
			]) },
			rt.ArrayItem{ key: 'Letter', val: rt.call_function('__', [
				rt.new_string('Letter'),
			]) },
			rt.ArrayItem{ key: 'Action', val: rt.call_function('__', [
				rt.new_string('Action'),
			]) },
			rt.ArrayItem{
				key: 'Warning: the link has been inserted but may have errors. Please test it.'
				val: rt.call_function('__', [
					rt.new_string('Warning: the link has been inserted but may have errors. Please test it.'),
				])
			},
			rt.ArrayItem{
				key: 'To move focus to other buttons use Tab or the arrow keys. To return focus to the editor press Escape or use one of the buttons.'
				val: rt.call_function('__', [
					rt.new_string('To move focus to other buttons use Tab or the arrow keys. To return focus to the editor press Escape or use one of the buttons.'),
				])
			},
			rt.ArrayItem{
				key: 'When starting a new paragraph with one of these formatting shortcuts followed by a space, the formatting will be applied automatically. Press Backspace or Escape to undo.'
				val: rt.call_function('__', [
					rt.new_string('When starting a new paragraph with one of these formatting shortcuts followed by a space, the formatting will be applied automatically. Press Backspace or Escape to undo.'),
				])
			},
			rt.ArrayItem{
				key: 'The following formatting shortcuts are replaced when pressing Enter. Press Escape or the Undo button to undo.'
				val: rt.call_function('__', [
					rt.new_string('The following formatting shortcuts are replaced when pressing Enter. Press Escape or the Undo button to undo.'),
				])
			},
			rt.ArrayItem{
				key: 'The next group of formatting shortcuts are applied as you type or when you insert them around plain text in the same paragraph. Press Escape or the Undo button to undo.'
				val: rt.call_function('__', [
					rt.new_string('The next group of formatting shortcuts are applied as you type or when you insert them around plain text in the same paragraph. Press Escape or the Undo button to undo.'),
				])
			},
		]))
	}
	return rt.get_static_prop('_WP_Editors', 'translation')
}

fn Class__WP_Editors.wp_mce_translation(mce_locale string, json_only bool) string {
	mut mce_locale_mutated := mce_locale
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(mce_locale_mutated))))) {
		mce_locale_mutated = (Class__WP_Editors.get_mce_locale()).str()
	}
	mut var_mce_translation := Class__WP_Editors.get_translation()
	mut iter_6 := var_mce_translation.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_name := item_6.key
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			var_mce_translation.array_set(var_name, var_value.array_get(rt.new_int(0)))
		}
	}
	var_mce_translation = rt.call_function('apply_filters', [
		rt.new_string('wp_mce_translation'),
		var_mce_translation.clone(),
		rt.new_string(mce_locale_mutated).clone(),
	])
	mut iter_7 := var_mce_translation.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		mut var_key := item_7.key
		if rt.is_true(rt.identical(var_key, var_value)) {
			var_mce_translation.array_unset(var_key)
			continue
		}
		if rt.is_true(rt.call_function('str_contains', [var_value.clone(),
			rt.new_string('&')]))
		{
			var_mce_translation.array_set(var_key, rt.call_function('html_entity_decode', [
				var_value.clone(),
				rt.get_constant('ENT_QUOTES'),
				rt.new_string('UTF-8'),
			]))
		}
	}
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_mce_translation.array_set('_dir', 'rtl')
	}
	if var_json_only {
		return (rt.call_function('wp_json_encode', [var_mce_translation.clone()])).str()
	}
	mut var_baseurl := Class__WP_Editors.get_baseurl()
	return "tinymce.addI18n( '${var_mce_locale.to_string()}', " +
		(rt.call_function('wp_json_encode', [var_mce_translation.clone()])).str() + ');\n' +
		"tinymce.ScriptLoader.markDone( '${var_baseurl.to_string()}/langs/${var_mce_locale.to_string()}.js' );\n"
}

fn Class__WP_Editors.force_uncompressed_tinymce() {
	mut var_has_custom_theme := rt.new_bool(false)
	mut iter_8 := rt.get_static_prop('_WP_Editors', 'mce_settings').iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_init := item_8.val
		if !(!rt.is_true(var_init.array_get(rt.new_string('theme_url')))) {
			var_has_custom_theme = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_custom_theme)))) {
		return
	}
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	rt.call_method(var_wp_scripts, 'remove', [rt.new_string('wp-tinymce')])
	rt.call_function('wp_register_tinymce_scripts', [var_wp_scripts.clone(),
		rt.new_bool(true)])
}

fn Class__WP_Editors.print_tinymce_scripts() {
	mut var_concatenate_scripts := rt.new_null()
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'tinymce_scripts_printed')) {
		return
	}
	rt.set_static_prop('_WP_Editors', 'tinymce_scripts_printed', rt.new_bool(true))
	if !(!var_concatenate_scripts.is_null()) {
		rt.call_function('script_concat_settings', []rt.PhpVal{})
	}
	rt.call_function('wp_print_scripts', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-tinymce' }]),
	])
	print('<script>\n' + (Class__WP_Editors.wp_mce_translation()).str() + '</script>\n')
}

fn Class__WP_Editors.editor_js() {
	mut var_tinymce_version := rt.new_null()
	mut var_tmce_on :=
		rt.new_bool(!(!rt.is_true(rt.get_static_prop('_WP_Editors', 'mce_settings'))))
	mut var_mce_init := rt.new_string('')
	mut var_qt_init := rt.new_string('')
	if rt.is_true(var_tmce_on) {
		mut iter_9 := rt.get_static_prop('_WP_Editors', 'mce_settings').iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_init := item_9.val
			mut var_editor_id := item_9.key
			mut var_options := Class__WP_Editors._parse_init(var_init.clone())
			var_mce_init = rt.concat(var_mce_init,
				rt.new_string("'${var_editor_id.to_string()}':${var_options.to_string()},"))
		}
		var_mce_init = rt.new_string('{' + var_mce_init.clone().to_string().trim_space() + '}')
	} else {
		var_mce_init = rt.new_string('{}')
	}
	if !(!rt.is_true(rt.get_static_prop('_WP_Editors', 'qt_settings'))) {
		mut iter_10 := rt.get_static_prop('_WP_Editors', 'qt_settings').iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_init := item_10.val
			mut var_editor_id := item_10.key
			mut var_options := Class__WP_Editors._parse_init(var_init.clone())
			var_qt_init = rt.concat(var_qt_init,
				rt.new_string("'${var_editor_id.to_string()}':${var_options.to_string()},"))
		}
		var_qt_init = rt.new_string('{' + var_qt_init.clone().to_string().trim_space() + '}')
	} else {
		var_qt_init = rt.new_string('{}')
	}
	mut var_ref := {
		'plugins':  rt.call_function('implode', [rt.new_string(','),
			rt.get_static_prop('_WP_Editors', 'plugins')])
		'theme':    rt.new_string('modern')
		'language': rt.get_static_prop('_WP_Editors', 'mce_locale')
	}
	mut var_suffix := rt.new_string((if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) {
		''
	} else {
		'.min'
	}).str())
	mut var_baseurl := Class__WP_Editors.get_baseurl()
	mut var_version := rt.new_string('ver=' + var_tinymce_version.str())
	rt.call_function('do_action', [rt.new_string('before_wp_tiny_mce'),
		rt.get_static_prop('_WP_Editors', 'mce_settings')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_baseurl)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_suffix)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'drag_drop_upload')) {
		print('dragDropUpload: true,')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_mce_init)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_qt_init)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(Class__WP_Editors._parse_init(var_ref.clone()))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_tmce_on) {
		Class__WP_Editors.print_tinymce_scripts()
		if rt.is_true(rt.get_static_prop('_WP_Editors', 'ext_plugins')) {
			print("<script src='${var_baseurl.to_string()}/langs/wp-langs-en.js?${var_version.to_string()}'></script>\n")
		}
	}
	rt.call_function('do_action', [rt.new_string('wp_tiny_mce_init'),
		rt.get_static_prop('_WP_Editors', 'mce_settings')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'ext_plugins')) {
		print((rt.get_static_prop('_WP_Editors', 'ext_plugins')).str() + '\n')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		print('var ajaxurl = "' +
			(rt.call_function('admin_url', [rt.new_string('admin-ajax.php'), rt.new_string('relative')])).str() +
			'";')
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('in_array', [rt.new_string('wplink'), rt.get_static_prop('_WP_Editors', 'plugins'), rt.new_bool(true)]))
		|| rt.is_true(rt.call_function('in_array', [rt.new_string('link'), rt.get_static_prop('_WP_Editors', 'qt_buttons'), rt.new_bool(true)])) {
		Class__WP_Editors.wp_link_dialog()
	}
	rt.call_function('do_action', [rt.new_string('after_wp_tiny_mce'),
		rt.get_static_prop('_WP_Editors', 'mce_settings')])
}

fn Class__WP_Editors.wp_fullscreen_html() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.3.0')])
}

fn Class__WP_Editors.wp_link_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_pts := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
		rt.new_string('objects'),
	])
	mut var_pt_names := rt.func_array_keys(var_pts.clone())
	mut var_query := rt.create_array([
		rt.ArrayItem{ key: 'post_type', val: var_pt_names },
		rt.ArrayItem{ key: 'suppress_filters', val: true },
		rt.ArrayItem{ key: 'update_post_term_cache', val: false },
		rt.ArrayItem{ key: 'update_post_meta_cache', val: false },
		rt.ArrayItem{ key: 'post_status', val: 'publish' },
		rt.ArrayItem{ key: 'posts_per_page', val: 20 },
	])
	var_args_mutated.array_set('pagenum', if var_args_mutated.array_isset(rt.new_string('pagenum')) { rt.call_function('absint', [
			var_args_mutated.array_get(rt.new_string('pagenum')),
		]) } else { rt.new_int(1) })
	if var_args_mutated.array_isset(rt.new_string('s')) {
		var_query.array_set('s', var_args_mutated.array_get(rt.new_string('s')))
	}
	var_query.array_set('offset', if rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('pagenum')),
		rt.new_int(1)))
	{
		rt.mul(var_query.array_get(rt.new_string('posts_per_page')), rt.sub(var_args_mutated.array_get(rt.new_string('pagenum')),
			rt.new_int(1)))
	} else {
		rt.new_int(0)
	})
	var_query = rt.call_function('apply_filters', [rt.new_string('wp_link_query_args'),
		var_query.clone()])
	mut var_get_posts := create_wp_query()
	mut var_posts := var_get_posts.query(var_query.clone())
	mut var_results := rt.new_array()
	mut iter_11 := var_posts.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_post := item_11.val
		if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_post, 'post_type'))) {
			mut var_info := rt.call_function('mysql2date', [
				rt.call_function('__', [rt.new_string('Y/m/d')]),
				rt.get_property(var_post, 'post_date'),
			])
		} else {
			var_info = rt.get_property(rt.get_property(var_pts.array_get(rt.get_property(var_post,
				'post_type')), 'labels'), 'singular_name')
		}
		var_results.array_push(rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.get_property(var_post, 'ID') },
			rt.ArrayItem{ key: 'title', val: rt.call_function('esc_html', [
				rt.call_function('strip_tags', [
					rt.call_function('get_the_title', [var_post.clone()]),
				]),
			]).to_string().trim_space() },
			rt.ArrayItem{ key: 'permalink', val: rt.call_function('get_permalink', [
				rt.get_property(var_post, 'ID'),
			]) },
			rt.ArrayItem{ key: 'info', val: var_info },
		]))
	}
	var_results = rt.call_function('apply_filters', [rt.new_string('wp_link_query'),
		var_results.clone(), var_query.clone()])
	return if !(!rt.is_true(var_results)) { var_results } else { rt.new_bool(false) }
}

fn Class__WP_Editors.wp_link_dialog() {
	if rt.is_true(rt.get_static_prop('_WP_Editors', 'link_dialog_printed')) {
		return
	}
	rt.set_static_prop('_WP_Editors', 'link_dialog_printed', rt.new_bool(true))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('internal-linking'),
		rt.new_string('_ajax_linking_nonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Insert/edit link')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Enter the destination URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link Text')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Open link in a new tab')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Or link to existing content')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('No search term specified. Showing recent items.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('Search or use up and down arrow keys to select an item.'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Cancel')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add Link')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create__wp_editors() &Class__WP_Editors {
	mut obj := &Class__WP_Editors{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class__WP_Editors) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'parse_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class__WP_Editors.parse_settings(dispatch_arg_0, dispatch_arg_1)
		}
		'editor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class__WP_Editors.editor(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'editor_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class__WP_Editors.editor_settings(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_parse_init' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class__WP_Editors._parse_init(dispatch_arg_0))
		}
		'enqueue_scripts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			Class__WP_Editors.enqueue_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue_default_editor' {
			Class__WP_Editors.enqueue_default_editor()
			return rt.new_null()
		}
		'print_default_editor_scripts' {
			Class__WP_Editors.print_default_editor_scripts()
			return rt.new_null()
		}
		'get_mce_locale' {
			return Class__WP_Editors.get_mce_locale()
		}
		'get_baseurl' {
			return Class__WP_Editors.get_baseurl()
		}
		'default_settings' {
			return Class__WP_Editors.default_settings()
		}
		'get_translation' {
			return Class__WP_Editors.get_translation()
		}
		'wp_mce_translation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class__WP_Editors.wp_mce_translation(dispatch_arg_0,
				dispatch_arg_1))
		}
		'force_uncompressed_tinymce' {
			Class__WP_Editors.force_uncompressed_tinymce()
			return rt.new_null()
		}
		'print_tinymce_scripts' {
			Class__WP_Editors.print_tinymce_scripts()
			return rt.new_null()
		}
		'editor_js' {
			Class__WP_Editors.editor_js()
			return rt.new_null()
		}
		'wp_fullscreen_html' {
			Class__WP_Editors.wp_fullscreen_html()
			return rt.new_null()
		}
		'wp_link_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class__WP_Editors.wp_link_query(dispatch_arg_0)
		}
		'wp_link_dialog' {
			Class__WP_Editors.wp_link_dialog()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class__WP_Editors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class__WP_Editors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
