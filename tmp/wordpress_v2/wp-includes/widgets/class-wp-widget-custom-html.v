import rt

struct Class_WP_Widget_Custom_HTML {
	rt.PhpObjectBase
pub mut:
	registered       bool
	default_instance rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Widget_Custom_HTML) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_custom_html')
		'description':                 rt.call_function('__', [
			rt.new_string('Arbitrary HTML code.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	mut var_control_ops := {
		'width':  400
		'height': 350
	}
	this.Class_WP_Widget.construct(rt.new_string('custom_html'), rt.call_function('__', [
		rt.new_string('Custom HTML'),
	]), var_widget_ops.clone(), var_control_ops.clone())
}

fn (mut this Class_WP_Widget_Custom_HTML) _register_one(var_number rt.PhpVal) {
	this.Class_WP_Widget._register_one(var_number.clone())
	if this.registered {
		return
	}
	this.registered = true
	rt.call_function('add_action', [rt.new_string('admin_print_scripts-widgets.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Custom_HTML', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_admin_scripts' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_footer-widgets.php'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Widget_Custom_HTML' },
			rt.ArrayItem{ key: none, val: 'render_control_template_scripts' }])])
	rt.call_function('add_action', [rt.new_string('admin_head-widgets.php'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Widget_Custom_HTML' },
			rt.ArrayItem{ key: none, val: 'add_help_text' }])])
}

fn (mut this Class_WP_Widget_Custom_HTML) _filter_gallery_shortcode_attrs(var_attrs rt.PhpVal) rt.PhpVal {
	mut var_attrs_mutated := var_attrs
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})))))
		&& !rt.is_true(var_attrs_mutated.array_get(rt.new_string('id')))
		&& !rt.is_true(var_attrs_mutated.array_get(rt.new_string('include'))) {
		var_attrs_mutated.array_set('id', -1)
	}
	return var_attrs_mutated.clone()
}

fn (mut this Class_WP_Widget_Custom_HTML) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_instance_mutated := var_instance
	mut var_post := rt.get_superglobal('post')
	mut var_original_post := var_post.clone()
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
		var_post = rt.call_function('get_queried_object', []rt.PhpVal{})
	} else {
		var_post = rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('shortcode_atts_gallery'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Custom_HTML', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: '_filter_gallery_shortcode_attrs' },
		])])
	var_instance_mutated = rt.call_function('array_merge',
		[this.default_instance, var_instance_mutated.clone()])
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_instance_mutated.array_get(rt.new_string('title')),
		var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WP_Widget_Custom_HTML', [
			'WP_Widget',
		], &this), 'id_base')])
	mut var_simulated_text_widget_instance := rt.call_function('array_merge', [
		var_instance_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: 'text'
				val: if !(var_instance_mutated.array_get(rt.new_string('content'))).is_null() {
					var_instance_mutated.array_get(rt.new_string('content'))
				} else {
					rt.new_string('')
				}
			},
			rt.ArrayItem{ key: 'filter', val: false },
			rt.ArrayItem{ key: 'visual', val: false },
		]),
	])
	var_simulated_text_widget_instance.array_unset(rt.new_string('content'))
	mut var_content := rt.call_function('apply_filters', [rt.new_string('widget_text'),
		var_instance_mutated.array_get(rt.new_string('content')),
		var_simulated_text_widget_instance.clone(),
		rt.new_object('WP_Widget_Custom_HTML', [
			'WP_Widget',
		], &this)])
	var_content = rt.call_function('apply_filters', [
		rt.new_string('widget_custom_html_content'),
		var_content.clone(),
		var_instance_mutated.clone(),
		rt.new_object('WP_Widget_Custom_HTML', ['WP_Widget'], &this),
	])
	var_post = var_original_post.clone()
	rt.call_function('remove_filter', [rt.new_string('shortcode_atts_gallery'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Custom_HTML', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: '_filter_gallery_shortcode_attrs' },
		])])
	var_args_mutated.array_set('before_widget', rt.call_function('preg_replace', [
		rt.new_string('/(?<=\\sclass=["\'])/'),
		rt.new_string('widget_text '),
		var_args_mutated.array_get(rt.new_string('before_widget')),
	]))
	rt.echo_val(var_args_mutated.array_get(rt.new_string('before_widget')))
	if !(!rt.is_true(var_title)) {
		print((var_args_mutated.array_get(rt.new_string('before_title'))).str() + var_title.str() +
			(var_args_mutated.array_get(rt.new_string('after_title'))).str())
	}
	print('<div class="textwidget custom-html-widget">')
	rt.echo_val(var_content)
	print('</div>')
	rt.echo_val(var_args_mutated.array_get(rt.new_string('after_widget')))
}

fn (mut this Class_WP_Widget_Custom_HTML) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := rt.call_function('array_merge',
		[this.default_instance, var_old_instance.clone()])
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [
		var_new_instance.array_get(rt.new_string('title')),
	]))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		var_instance.array_set('content', var_new_instance.array_get(rt.new_string('content')))
	} else {
		var_instance.array_set('content', rt.call_function('wp_kses_post', [
			var_new_instance.array_get(rt.new_string('content')),
		]))
	}
	return var_instance.clone()
}

fn (mut this Class_WP_Widget_Custom_HTML) enqueue_admin_scripts() {
	mut var_settings := rt.call_function('wp_enqueue_code_editor', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'text/html' },
			rt.ArrayItem{ key: 'codemirror', val: rt.create_array([
				rt.ArrayItem{ key: 'indentUnit', val: 2 },
				rt.ArrayItem{ key: 'tabSize', val: 2 },
			]) }]),
	])
	rt.call_function('wp_enqueue_script', [rt.new_string('custom-html-widgets')])
	rt.call_function('wp_add_inline_script', [rt.new_string('custom-html-widgets'),
		rt.call_function('sprintf', [
			rt.new_string('wp.customHtmlWidgets.idBases.push( %s );'),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Custom_HTML', ['WP_Widget'], &this),
					'id_base'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		])])
	if !rt.is_true(var_settings) {
		var_settings = rt.create_array([rt.ArrayItem{ key: 'disabled', val: true }])
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('custom-html-widgets'),
		rt.call_function('sprintf', [rt.new_string('wp.customHtmlWidgets.init( %s );'),
			rt.call_function('wp_json_encode', [var_settings.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))])]),
		rt.new_string('after')])
	mut var_l10n := {
		'errorNotice': {
			'singular': rt.call_function('_n', [
				rt.new_string('There is %d error which must be fixed before you can save.'),
				rt.new_string('There are %d errors which must be fixed before you can save.'),
				rt.new_int(1),
			])
			'plural':   rt.call_function('_n', [
				rt.new_string('There is %d error which must be fixed before you can save.'),
				rt.new_string('There are %d errors which must be fixed before you can save.'),
				rt.new_int(2),
			])
		}
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('custom-html-widgets'),
		rt.call_function('sprintf', [
			rt.new_string('jQuery.extend( wp.customHtmlWidgets.l10n, %s );'),
			rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_l10n),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		]),
		rt.new_string('after')])
}

fn (mut this Class_WP_Widget_Custom_HTML) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_instance_mutated),
		this.default_instance,
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_instance_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('content')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('content')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea',
		[var_instance_mutated.array_get(rt.new_string('content'))]))
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WP_Widget_Custom_HTML.render_control_template_scripts() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Content:')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('unfiltered_html'),
	])))))
	{
		// unsupported statement: Stmt_InlineHTML
		mut var_probably_unsafe_html := ['script', 'iframe', 'form', 'input', 'style']
		mut var_allowed_html := rt.call_function('wp_kses_allowed_html', [
			rt.new_string('post'),
		])
		mut var_disallowed_html := rt.call_function('array_diff', [
			rt.create_array_from_list(var_probably_unsafe_html),
			rt.func_array_keys(var_allowed_html.clone()),
		])
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(var_disallowed_html)) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Some HTML tags are not permitted, including:'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string('</code>, <code>'),
				var_disallowed_html.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WP_Widget_Custom_HTML.add_help_text() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_content := rt.new_string('<p>')
	var_content = rt.concat(var_content, rt.call_function('__', [
		rt.new_string('Use the Custom HTML widget to add arbitrary HTML code to your widget areas.'),
	]))
	var_content = rt.concat(var_content, rt.new_string('</p>'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('false'), rt.get_property(rt.call_function('wp_get_current_user',
		[]rt.PhpVal{}), 'syntax_highlighting')))))
	{
		var_content = rt.concat(var_content, rt.new_string('<p>'))
		var_content = rt.concat(var_content, rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The edit field automatically highlights code syntax. You can disable this in your <a href="%1$s" %2$s>user profile%3$s</a> to work in plain text mode.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('get_edit_profile_url', []rt.PhpVal{}),
			]),
			rt.new_string('class="external-link" target="_blank"'),
			rt.call_function('sprintf', [
				rt.new_string('<span class="screen-reader-text"> %s</span>'),
				rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
			]),
		]))
		var_content = rt.concat(var_content, rt.new_string('</p>'))
		var_content = rt.concat(var_content, rt.new_string('<p id="editor-keyboard-trap-help-1">' +
			(rt.call_function('__', [rt.new_string('When using a keyboard to navigate:')])).str() +
			'</p>'))
		var_content = rt.concat(var_content, rt.new_string('<ul>'))
		var_content = rt.concat(var_content, rt.new_string(
			'<li id="editor-keyboard-trap-help-2">' +
			(rt.call_function('__', [rt.new_string('In the editing area, the Tab key enters a tab character.')])).str() +
			'</li>'))
		var_content = rt.concat(var_content, rt.new_string(
			'<li id="editor-keyboard-trap-help-3">' +
			(rt.call_function('__', [rt.new_string('To move away from this area, press the Esc key followed by the Tab key.')])).str() +
			'</li>'))
		var_content = rt.concat(var_content, rt.new_string(
			'<li id="editor-keyboard-trap-help-4">' +
			(rt.call_function('__', [rt.new_string('Screen reader users: when in forms mode, you may need to press the Esc key twice.')])).str() +
			'</li>'))
		var_content = rt.concat(var_content, rt.new_string('</ul>'))
	}
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'custom_html_widget' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Custom HTML Widget'),
			]) }, rt.ArrayItem{ key: 'content', val: var_content }]),
	])
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_custom_html() &Class_WP_Widget_Custom_HTML {
	mut obj := &Class_WP_Widget_Custom_HTML{
		PhpObjectBase:    rt.PhpObjectBase{}
		registered:       false
		default_instance: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_widget(_args ...rt.PhpVal) &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Custom_HTML) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'_register_one' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._register_one(dispatch_arg_0)
			return rt.new_null()
		}
		'_filter_gallery_shortcode_attrs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._filter_gallery_shortcode_attrs(dispatch_arg_0)
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'enqueue_admin_scripts' {
			this.enqueue_admin_scripts()
			return rt.new_null()
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		'render_control_template_scripts' {
			Class_WP_Widget_Custom_HTML.render_control_template_scripts()
			return rt.new_null()
		}
		'add_help_text' {
			Class_WP_Widget_Custom_HTML.add_help_text()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Custom_HTML) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered' { return rt.new_bool(this.registered) }
		'default_instance' { return this.default_instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Custom_HTML) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered' {
			this.registered = val.to_bool()
			return true
		}
		'default_instance' {
			this.default_instance = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
