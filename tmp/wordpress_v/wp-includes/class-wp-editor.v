import rt

struct Class__WP_Editors {
	rt.PhpObjectBase
pub mut:
		mce_locale rt.PhpVal = rt.new_null()
		mce_settings rt.PhpVal = rt.new_array()
		qt_settings rt.PhpVal = rt.new_array()
		plugins rt.PhpVal = rt.new_array()
		qt_buttons rt.PhpVal = rt.new_array()
		ext_plugins rt.PhpVal = rt.new_null()
		baseurl rt.PhpVal = rt.new_null()
		first_init rt.PhpVal = rt.new_null()
		this_tinymce rt.PhpVal = rt.new_bool(false)
		this_quicktags rt.PhpVal = rt.new_bool(false)
		has_tinymce rt.PhpVal = rt.new_bool(false)
		has_quicktags rt.PhpVal = rt.new_bool(false)
		has_medialib rt.PhpVal = rt.new_bool(false)
		editor_buttons_css rt.PhpVal = rt.new_bool(true)
		drag_drop_upload rt.PhpVal = rt.new_bool(false)
		translation rt.PhpVal = rt.new_null()
		tinymce_scripts_printed rt.PhpVal = rt.new_bool(false)
		link_dialog_printed rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class__WP_Editors) construct()  {
}

fn Class__WP_Editors.parse_settings(var_editor_id rt.PhpVal, var_settings rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	var_settings_mutated = rt.call_function('apply_filters', [rt.new_string('wp_editor_settings'), var_settings_mutated.dup(), var_editor_id.dup()])
	mut var_set := rt.call_function('wp_parse_args', [var_settings_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'wpautop', val: !(rt.is_true(rt.call_function('has_blocks', []rt.PhpVal{}))) }, rt.ArrayItem{ key: 'media_buttons', val: true }, rt.ArrayItem{ key: 'default_editor', val: '' }, rt.ArrayItem{ key: 'drag_drop_upload', val: false }, rt.ArrayItem{ key: 'textarea_name', val: var_editor_id }, rt.ArrayItem{ key: 'textarea_rows', val: 20 }, rt.ArrayItem{ key: 'tabindex', val: '' }, rt.ArrayItem{ key: 'tabfocus_elements', val: ':prev,:next' }, rt.ArrayItem{ key: 'editor_css', val: '' }, rt.ArrayItem{ key: 'editor_class', val: '' }, rt.ArrayItem{ key: 'teeny', val: false }, rt.ArrayItem{ key: '_content_editor_dfw', val: false }, rt.ArrayItem{ key: 'tinymce', val: true }, rt.ArrayItem{ key: 'quicktags', val: true }])])
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		if rt.is_true(rt.call_function('str_contains', [var_editor_id.dup(), rt.new_string('[')])) {
			// unsupported assign target: Expr_StaticPropertyFetch
			rt.call_function('_deprecated_argument', [rt.new_string('wp_editor()'), rt.new_string('3.9.0'), rt.new_string('TinyMCE editor IDs cannot have brackets.')])
		}
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if !rt.is_true(var_set.array_get('editor_height')) {
		return var_set.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('content'), var_editor_id)) && !rt.is_true(var_set.array_get('tinymce').array_get('wp_autoresize_on')))) {
		mut var_cookie := // unsupported expression: Expr_Cast_Int
		if rt.is_true(var_cookie) {
			var_set.array_set('editor_height', var_cookie.dup())
		}
	}
	if rt.is_true(rt.less(var_set.array_get('editor_height'), rt.new_int(50))) {
		var_set.array_set('editor_height', 50)
	} else if rt.is_true(rt.greater(var_set.array_get('editor_height'), rt.new_int(5000))) {
		var_set.array_set('editor_height', 5000)
	}
	return var_set.dup()
}

fn Class__WP_Editors.editor(var_content rt.PhpVal, var_editor_id rt.PhpVal, var_settings rt.PhpVal)  {
	mut var_GLOBALS := rt.new_null()
	mut var_content_mutated := var_content
	mut var_settings_mutated := var_settings
	mut var_set := Class__WP_Editors.parse_settings(var_editor_id.dup(), var_settings_mutated.dup())
	mut var_editor_class := rt.new_string(' class="' + (rt.call_function('esc_attr', [var_set.array_get('editor_class')])).str() + ' wp-editor-area'.trim_space() + '"')
	mut var_tabindex := rt.new_string(if rt.is_true(var_set.array_get('tabindex')) { ' tabindex="' + (// unsupported expression: Expr_Cast_Int).str() + '"' } else { rt.new_string('') })
	mut var_default_editor := rt.new_string(rt.new_string('html'))
	mut var_buttons := rt.new_string(rt.new_string(''))
	mut var_autocomplete := rt.new_string(rt.new_string(''))
	mut var_editor_id_attr := rt.call_function('esc_attr', [var_editor_id.dup()])
	if rt.is_true(var_set.array_get('drag_drop_upload')) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if !(!rt.is_true(var_set.array_get('editor_height'))) {
		mut var_height := rt.new_string(' style="height: ' + (// unsupported expression: Expr_Cast_Int).str() + 'px"')
	} else {
		var_height = rt.new_string(' rows="' + (// unsupported expression: Expr_Cast_Int).str() + '"')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_files')]))))) {
		var_set.array_set('media_buttons', false)
	}
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		var_autocomplete = rt.new_string(rt.new_string(' autocomplete="off"'))
		if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
			var_default_editor = if rt.is_true(var_set.array_get('default_editor')) { var_set.array_get('default_editor') } else { rt.call_function('wp_default_editor', []rt.PhpVal{}) }
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_default_editor = rt.new_string(rt.new_string('tinymce'))
			}
			mut var_tmce_active := rt.new_string(if rt.is_true(rt.identical(rt.new_string('html'), var_default_editor)) { rt.new_string(' aria-pressed="true"') } else { rt.new_string('') })
			mut var_html_active := rt.new_string(if rt.is_true(rt.identical(rt.new_string('html'), var_default_editor)) { rt.new_string('') } else { rt.new_string(' aria-pressed="true"') })
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			var_default_editor = rt.new_string(rt.new_string('tinymce'))
		}
	}
	mut var_switch_class := rt.new_string(if rt.is_true(rt.identical(rt.new_string('html'), var_default_editor)) { rt.new_string('html-active') } else { rt.new_string('tmce-active') })
	mut var_wrap_class := rt.new_string('wp-core-ui wp-editor-wrap ' + (var_switch_class).str())
	if rt.is_true(var_set.array_get('_content_editor_dfw')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	print('<div id="wp-' + (var_editor_id_attr).str() + '-wrap" class="' + (var_wrap_class).str() + '">')
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		rt.call_function('wp_print_styles', [rt.new_string('editor-buttons')])
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if !(!rt.is_true(var_set.array_get('editor_css'))) {
		print((var_set.array_get('editor_css')).str() + '\n')
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_buttons)) || rt.is_true(var_set.array_get('media_buttons')))) {
		print('<div id="wp-' + (var_editor_id_attr).str() + '-editor-tools" class="wp-editor-tools hide-if-no-js">')
		if rt.is_true(var_set.array_get('media_buttons')) {
			// unsupported assign target: Expr_StaticPropertyFetch
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('media_buttons')]))))) {
				rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '3')
			}
			print('<div id="wp-' + (var_editor_id_attr).str() + '-media-buttons" class="wp-media-buttons">')
			rt.call_function('do_action', [rt.new_string('media_buttons'), var_editor_id.dup()])
			print('</div>\n')
		}
		print('<div class="wp-editor-tabs">' + (var_buttons).str() + '</div>\n')
		print('</div>\n')
	}
	mut var_quicktags_toolbar := rt.new_string(rt.new_string(''))
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('content'), var_editor_id)) && !(!rt.is_true(var_GLOBALS.array_get('current_screen'))))) && rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_GLOBALS.array_get('current_screen'), 'base'))))) {
			mut var_toolbar_id := rt.new_string(rt.new_string('ed_toolbar'))
		} else {
			var_toolbar_id = rt.new_string('qt_' + (var_editor_id_attr).str() + '_toolbar')
		}
		var_quicktags_toolbar = rt.new_string('<div id="' + (var_toolbar_id).str() + '" class="quicktags-toolbar hide-if-no-js"></div>')
	}
	mut var_the_editor := rt.call_function('apply_filters', [rt.new_string('the_editor'), '<div id="wp-' + (var_editor_id_attr).str() + '-editor-container" class="wp-editor-container">' + (var_quicktags_toolbar).str() + '<textarea' + (var_editor_class).str() + (var_height).str() + (var_tabindex).str() + (var_autocomplete).str() + ' cols="40" name="' + (rt.call_function('esc_attr', [var_set.array_get('textarea_name')])).str() + '" ' + 'id="' + (var_editor_id_attr).str() + '">%s</textarea></div>'])
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		rt.call_function('add_filter', [rt.new_string('the_editor_content'), rt.new_string('format_for_editor'), rt.new_int(10), rt.new_int(2)])
	}
	var_content_mutated = rt.call_function('apply_filters', [rt.new_string('the_editor_content'), var_content_mutated.dup(), var_default_editor.dup()])
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		rt.call_function('remove_filter', [rt.new_string('the_editor_content'), rt.new_string('format_for_editor')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('html'), var_default_editor)) && rt.is_true(rt.call_function('has_filter', [rt.new_string('htmledit_pre')])))) {
		var_content_mutated = rt.call_function('apply_filters_deprecated', [rt.new_string('htmledit_pre'), rt.create_array([rt.ArrayItem{ key: none, val: var_content_mutated }]), rt.new_string('4.3.0'), rt.new_string('format_for_editor')])
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('tinymce'), var_default_editor)) && rt.is_true(rt.call_function('has_filter', [rt.new_string('richedit_pre')])))) {
		var_content_mutated = rt.call_function('apply_filters_deprecated', [rt.new_string('richedit_pre'), rt.create_array([rt.ArrayItem{ key: none, val: var_content_mutated }]), rt.new_string('4.3.0'), rt.new_string('format_for_editor')])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_content_mutated = rt.call_function('preg_replace', [rt.new_string('%</textarea%i'), rt.new_string('&lt;/textarea'), var_content_mutated.dup()])
	}
	rt.call_function('printf', [var_the_editor.dup(), var_content_mutated.dup()])
	print('\n</div>\n\n')
	Class__WP_Editors.editor_settings(var_editor_id.dup(), var_set.dup())
}

fn Class__WP_Editors.editor_settings(var_editor_id rt.PhpVal, var_set rt.PhpVal)  {
	mut var_set_mutated := var_set
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
			rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'editor_js' }]), rt.new_int(50)])
			rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'force_uncompressed_tinymce' }]), rt.new_int(1)])
			rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }]), rt.new_int(1)])
		} else {
			rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'editor_js' }]), rt.new_int(50)])
			rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'force_uncompressed_tinymce' }]), rt.new_int(1)])
			rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }]), rt.new_int(1)])
		}
	}
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		mut var_qt_init := rt.create_array([rt.ArrayItem{ key: 'id', val: var_editor_id }, rt.ArrayItem{ key: 'buttons', val: '' }])
		if rt.is_true(rt.new_bool(var_set_mutated.array_get('quicktags').is_array())) {
			var_qt_init = rt.call_function('array_merge', [var_qt_init.dup(), var_set_mutated.array_get('quicktags')])
		}
		if !rt.is_true(var_qt_init.array_get('buttons')) {
			var_qt_init.array_set('buttons', 'strong,em,link,block,del,ins,img,ul,ol,li,code,more,close')
		}
		if rt.is_true(var_set_mutated.array_get('_content_editor_dfw')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		var_qt_init = rt.call_function('apply_filters', [rt.new_string('quicktags_settings'), var_qt_init.dup(), var_editor_id.dup()])
		// unsupported expression: Expr_StaticPropertyFetch.array_set(var_editor_id, var_qt_init.dup())
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
			mut var_baseurl := Class__WP_Editors.get_baseurl()
			mut var_mce_locale := Class__WP_Editors.get_mce_locale()
			mut var_ext_plugins := rt.new_string(rt.new_string(''))
			if rt.is_true(var_set_mutated.array_get('teeny')) {
				mut var_plugins := rt.call_function('apply_filters', [rt.new_string('teeny_mce_plugins'), rt.create_array([rt.ArrayItem{ key: none, val: 'colorpicker' }, rt.ArrayItem{ key: none, val: 'lists' }, rt.ArrayItem{ key: none, val: 'fullscreen' }, rt.ArrayItem{ key: none, val: 'image' }, rt.ArrayItem{ key: none, val: 'wordpress' }, rt.ArrayItem{ key: none, val: 'wpeditimage' }, rt.ArrayItem{ key: none, val: 'wplink' }]), var_editor_id.dup()])
			} else {
				mut var_mce_external_plugins := rt.call_function('apply_filters', [rt.new_string('mce_external_plugins'), rt.new_array(), var_editor_id.dup()])
				var_plugins = rt.create_array([rt.ArrayItem{ key: none, val: 'charmap' }, rt.ArrayItem{ key: none, val: 'colorpicker' }, rt.ArrayItem{ key: none, val: 'hr' }, rt.ArrayItem{ key: none, val: 'lists' }, rt.ArrayItem{ key: none, val: 'media' }, rt.ArrayItem{ key: none, val: 'paste' }, rt.ArrayItem{ key: none, val: 'tabfocus' }, rt.ArrayItem{ key: none, val: 'textcolor' }, rt.ArrayItem{ key: none, val: 'fullscreen' }, rt.ArrayItem{ key: none, val: 'wordpress' }, rt.ArrayItem{ key: none, val: 'wpautoresize' }, rt.ArrayItem{ key: none, val: 'wpeditimage' }, rt.ArrayItem{ key: none, val: 'wpemoji' }, rt.ArrayItem{ key: none, val: 'wpgallery' }, rt.ArrayItem{ key: none, val: 'wplink' }, rt.ArrayItem{ key: none, val: 'wpdialogs' }, rt.ArrayItem{ key: none, val: 'wptextpattern' }, rt.ArrayItem{ key: none, val: 'wpview' }])
				if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
					var_plugins.array_push('image')
				}
				var_plugins = rt.call_function('array_unique', [rt.call_function('apply_filters', [rt.new_string('tiny_mce_plugins'), var_plugins.dup(), var_editor_id.dup()])])
				mut var_key := rt.call_function('array_search', [rt.new_string('spellchecker'), var_plugins.dup(), rt.new_bool(true)])
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_plugins.array_unset(var_key)
				}
				if !(!rt.is_true(var_mce_external_plugins)) {
					mut var_mce_external_languages := rt.call_function('apply_filters', [rt.new_string('mce_external_languages'), rt.new_array(), var_editor_id.dup()])
					mut var_loaded_langs := rt.new_array()
					mut var_strings := rt.new_string(rt.new_string(''))
					if !(!rt.is_true(var_mce_external_languages)) {
						{
							mut iter_1 := var_mce_external_languages.iterator()
							for {
								item_1 := iter_1.next() or { break }
								mut var_path := item_1.val
								mut var_name := item_1.key
								if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_file', [var_path.dup()])) && rt.is_true(rt.call_function('is_readable', [var_path.dup()])))) {
									rt.include_file((var_path).to_string(), '2')
									// unsupported expression: Expr_AssignOp_Concat
									 << .dup()
								}
							}
						}
					}
					{
						mut iter_1 := var_mce_external_plugins.iterator()
						for {
							item_1 := iter_1.next() or { break }
							mut var_url := item_1.val
							mut var_name := item_1.key
							if rt.is_true(rt.call_function('in_array', [.dup(), .dup(), ])) {
								.array_unset()
							}
							
						}
					}
				}
			}
			// unsupported assign target: Expr_StaticPropertyFetch
			
		}
		if rt.is_true() {
		} else {
		}
		
	}
	// unsupported statement: Stmt_Nop
}

fn Class__WP_Editors._parse_init(var_init rt.PhpVal) string {
}

fn Class__WP_Editors.enqueue_scripts(default_scripts bool)  {
}

fn Class__WP_Editors.enqueue_default_editor()  {
}

fn Class__WP_Editors.print_default_editor_scripts()  {
}

fn Class__WP_Editors.get_mce_locale() rt.PhpVal {
}

fn Class__WP_Editors.get_baseurl() rt.PhpVal {
}

fn Class__WP_Editors.default_settings() rt.PhpVal {
	mut var_tinymce_version := rt.new_null()
}

fn Class__WP_Editors.get_translation() rt.PhpVal {
}

fn Class__WP_Editors.wp_mce_translation(mce_locale string, json_only bool) string {
	mut mce_locale_mutated := mce_locale
}

fn Class__WP_Editors.force_uncompressed_tinymce()  {
}

fn Class__WP_Editors.print_tinymce_scripts()  {
	mut var_concatenate_scripts := rt.new_null()
}

fn Class__WP_Editors.editor_js()  {
	mut var_tinymce_version := rt.new_null()
}

fn Class__WP_Editors.wp_fullscreen_html()  {
}

fn Class__WP_Editors.wp_link_query(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn Class__WP_Editors.wp_link_dialog()  {
}

fn create__wp_editors() &Class__WP_Editors {
	mut obj := &Class__WP_Editors{
		PhpObjectBase: rt.PhpObjectBase{}
		mce_locale: rt.new_null()
		mce_settings: rt.new_array()
		qt_settings: rt.new_array()
		plugins: rt.new_array()
		qt_buttons: rt.new_array()
		ext_plugins: rt.new_null()
		baseurl: rt.new_null()
		first_init: rt.new_null()
		this_tinymce: rt.new_bool(false)
		this_quicktags: rt.new_bool(false)
		has_tinymce: rt.new_bool(false)
		has_quicktags: rt.new_bool(false)
		has_medialib: rt.new_bool(false)
		editor_buttons_css: rt.new_bool(true)
		drag_drop_upload: rt.new_bool(false)
		translation: rt.new_null()
		tinymce_scripts_printed: rt.new_bool(false)
		link_dialog_printed: rt.new_bool(false)
	}
	obj.construct()
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
			return rt.new_string(Class__WP_Editors.wp_mce_translation(dispatch_arg_0, dispatch_arg_1))
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
		else { return none }
	}
}

fn (this &Class__WP_Editors) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'mce_locale' { return this.mce_locale }
		'mce_settings' { return this.mce_settings }
		'qt_settings' { return this.qt_settings }
		'plugins' { return this.plugins }
		'qt_buttons' { return this.qt_buttons }
		'ext_plugins' { return this.ext_plugins }
		'baseurl' { return this.baseurl }
		'first_init' { return this.first_init }
		'this_tinymce' { return this.this_tinymce }
		'this_quicktags' { return this.this_quicktags }
		'has_tinymce' { return this.has_tinymce }
		'has_quicktags' { return this.has_quicktags }
		'has_medialib' { return this.has_medialib }
		'editor_buttons_css' { return this.editor_buttons_css }
		'drag_drop_upload' { return this.drag_drop_upload }
		'translation' { return this.translation }
		'tinymce_scripts_printed' { return this.tinymce_scripts_printed }
		'link_dialog_printed' { return this.link_dialog_printed }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class__WP_Editors) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'mce_locale' { this.mce_locale = val; return true }
		'mce_settings' { this.mce_settings = val; return true }
		'qt_settings' { this.qt_settings = val; return true }
		'plugins' { this.plugins = val; return true }
		'qt_buttons' { this.qt_buttons = val; return true }
		'ext_plugins' { this.ext_plugins = val; return true }
		'baseurl' { this.baseurl = val; return true }
		'first_init' { this.first_init = val; return true }
		'this_tinymce' { this.this_tinymce = val; return true }
		'this_quicktags' { this.this_quicktags = val; return true }
		'has_tinymce' { this.has_tinymce = val; return true }
		'has_quicktags' { this.has_quicktags = val; return true }
		'has_medialib' { this.has_medialib = val; return true }
		'editor_buttons_css' { this.editor_buttons_css = val; return true }
		'drag_drop_upload' { this.drag_drop_upload = val; return true }
		'translation' { this.translation = val; return true }
		'tinymce_scripts_printed' { this.tinymce_scripts_printed = val; return true }
		'link_dialog_printed' { this.link_dialog_printed = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_editor_php() {
}
