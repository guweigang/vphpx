import rt

struct Class_WP_Widget_Text {
	rt.PhpObjectBase
pub mut:
	registered bool
}

fn (mut this Class_WP_Widget_Text) construct() {
	mut var_widget_ops := {
		'classname':                   rt.new_string('widget_text')
		'description':                 rt.call_function('__', [
			rt.new_string('Arbitrary text.'),
		])
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	mut var_control_ops := {
		'width':  400
		'height': 350
	}
	this.Class_WP_Widget.construct(rt.new_string('text'), rt.call_function('__', [
		rt.new_string('Text'),
	]), var_widget_ops.clone(), var_control_ops.clone())
}

fn (mut this Class_WP_Widget_Text) _register_one(var_number rt.PhpVal) {
	this.Class_WP_Widget._register_one(var_number.clone())
	if this.registered {
		return
	}
	this.registered = true
	if rt.is_true(this.is_preview()) {
		rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Text', [
					'WP_Widget',
				], &this) },
				rt.ArrayItem{ key: none, val: 'enqueue_preview_scripts' },
			])])
	}
	rt.call_function('add_action', [rt.new_string('admin_print_scripts-widgets.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Text', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_admin_scripts' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_footer-widgets.php'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Widget_Text' },
			rt.ArrayItem{ key: none, val: 'render_control_template_scripts' }])])
}

fn (mut this Class_WP_Widget_Text) is_legacy_instance(var_instance rt.PhpVal) bool {
	mut var_instance_mutated := var_instance
	if var_instance_mutated.array_isset(rt.new_string('visual')) {
		return !(rt.is_true(var_instance_mutated.array_get(rt.new_string('visual'))))
	}
	if var_instance_mutated.array_isset(rt.new_string('filter'))
		&& rt.is_true(rt.identical(rt.new_string('content'), var_instance_mutated.array_get(rt.new_string('filter')))) {
		return false
	}
	if !rt.is_true(var_instance_mutated.array_get(rt.new_string('text'))) {
		return false
	}
	mut var_wpautop :=
		rt.new_bool(!(!rt.is_true(var_instance_mutated.array_get(rt.new_string('filter')))))
	mut var_has_line_breaks := rt.call_function('str_contains', [
		rt.new_string(var_instance_mutated.array_get(rt.new_string('text')).to_string().trim_space()),
		rt.new_string('\n'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wpautop)))) && rt.is_true(var_has_line_breaks) {
		return true
	}
	if rt.is_true(rt.call_function('str_contains', [var_instance_mutated.array_get(rt.new_string('text')),
		rt.new_string('<!--')]))
	{
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('DOMDocument'),
	])))))
	{
		return true
	}
	mut var_doc := create_domdocument()
	mut var_errors := rt.call_function('libxml_use_internal_errors', [
		rt.new_bool(true)])
	var_doc.loadhtml(rt.call_function('sprintf', [
		rt.new_string('<!DOCTYPE html><html><head><meta charset="%s"></head><body>%s</body></html>'),
		rt.call_function('esc_attr', [
			rt.call_function('get_bloginfo', [rt.new_string('charset')]),
		]),
		var_instance_mutated.array_get(rt.new_string('text')),
	]))
	rt.call_function('libxml_use_internal_errors', [var_errors.clone()])
	mut var_body := rt.call_method(var_doc.getelementsbytagname(rt.new_string('body')), 'item', [
		rt.new_int(0),
	])
	mut var_safe_elements_attributes := {
		'strong':  map[string]rt.PhpVal{}
		'em':      map[string]rt.PhpVal{}
		'b':       map[string]rt.PhpVal{}
		'i':       map[string]rt.PhpVal{}
		'u':       map[string]rt.PhpVal{}
		's':       map[string]rt.PhpVal{}
		'ul':      map[string]rt.PhpVal{}
		'ol':      map[string]rt.PhpVal{}
		'li':      map[string]rt.PhpVal{}
		'hr':      map[string]rt.PhpVal{}
		'abbr':    map[string]rt.PhpVal{}
		'acronym': map[string]rt.PhpVal{}
		'code':    map[string]rt.PhpVal{}
		'dfn':     map[string]rt.PhpVal{}
		'a':       {
			'href': rt.new_bool(true)
		}
		'img':     {
			'src': rt.new_bool(true)
			'alt': rt.new_bool(true)
		}
	}
	mut var_safe_empty_elements := ['img', 'hr', 'iframe']
	mut iter_1 := rt.call_method(var_body, 'getElementsByTagName', [
		rt.new_string('*')]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_element := item_1.val
		mut var_tag_name :=
			rt.new_string(rt.get_property(var_element, 'nodeName').to_string().to_lower())
		if !(var_safe_elements_attributes.array_isset(var_tag_name)) {
			return true
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_tag_name.clone(), rt.create_array_from_list(var_safe_empty_elements), rt.new_bool(true)])))))
			&& rt.is_true(rt.identical(rt.new_string(''), rt.new_string(rt.get_property(var_element, 'textContent').to_string().trim_space()))) {
			return true
		}
		mut iter_2 := rt.get_property(var_element, 'attributes').iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_attribute := item_2.val
			mut var_attribute_name :=
				rt.new_string(rt.get_property(var_attribute, 'nodeName').to_string().to_lower())
			if !(var_safe_elements_attributes[var_tag_name].array_isset(var_attribute_name)) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_Widget_Text) _filter_gallery_shortcode_attrs(var_attrs rt.PhpVal) rt.PhpVal {
	mut var_attrs_mutated := var_attrs
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})))))
		&& !rt.is_true(var_attrs_mutated.array_get(rt.new_string('id')))
		&& !rt.is_true(var_attrs_mutated.array_get(rt.new_string('include'))) {
		var_attrs_mutated.array_set('id', -1)
	}
	return var_attrs_mutated.clone()
}

fn (mut this Class_WP_Widget_Text) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_post := rt.get_superglobal('post')
	mut var_title := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('title')))) {
		var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		rt.new_string('')
	}
	var_title = rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_title.clone(), var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WP_Widget_Text', [
			'WP_Widget',
		], &this), 'id_base')])
	mut var_text := if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('text')))) {
		var_instance_mutated.array_get(rt.new_string('text'))
	} else {
		rt.new_string('')
	}
	mut var_is_visual_text_widget := rt.new_bool(
		!(!rt.is_true(var_instance_mutated.array_get(rt.new_string('visual'))))
		&& !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('filter')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_visual_text_widget)))) {
		var_is_visual_text_widget = rt.new_bool(
			var_instance_mutated.array_isset(rt.new_string('filter'))
			&& rt.is_true(rt.identical(rt.new_string('content'), var_instance_mutated.array_get(rt.new_string('filter')))))
	}
	if rt.is_true(var_is_visual_text_widget) {
		var_instance_mutated.array_set('filter', true)
		var_instance_mutated.array_set('visual', true)
	}
	mut var_widget_text_do_shortcode_priority := rt.call_function('has_filter', [
		rt.new_string('widget_text'),
		rt.new_string('do_shortcode'),
	])
	mut var_should_suspend_legacy_shortcode_support := rt.new_bool(
		rt.is_true(var_is_visual_text_widget)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_widget_text_do_shortcode_priority)))))
	if rt.is_true(var_should_suspend_legacy_shortcode_support) {
		rt.call_function('remove_filter', [rt.new_string('widget_text'),
			rt.new_string('do_shortcode'), var_widget_text_do_shortcode_priority.clone()])
	}
	mut var_original_post := var_post.clone()
	if rt.is_true(rt.call_function('is_singular', []rt.PhpVal{})) {
		var_post = rt.call_function('get_queried_object', []rt.PhpVal{})
	} else {
		var_post = rt.new_null()
	}
	rt.call_function('add_filter', [rt.new_string('shortcode_atts_gallery'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Text', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: '_filter_gallery_shortcode_attrs' },
		])])
	var_text = rt.call_function('apply_filters', [rt.new_string('widget_text'),
		var_text.clone(), var_instance_mutated.clone(),
		rt.new_object('WP_Widget_Text', [
			'WP_Widget',
		], &this)])
	if rt.is_true(var_is_visual_text_widget) {
		var_text = rt.call_function('apply_filters', [
			rt.new_string('widget_text_content'),
			var_text.clone(),
			var_instance_mutated.clone(),
			rt.new_object('WP_Widget_Text', ['WP_Widget'], &this),
		])
	} else {
		if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('filter')))) {
			var_text = rt.call_function('wpautop', [var_text.clone()])
		}
		if rt.is_true(rt.call_function('has_filter', [rt.new_string('widget_text_content'), rt.new_string('do_shortcode')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_widget_text_do_shortcode_priority)))) {
			if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('filter')))) {
				var_text = rt.call_function('shortcode_unautop', [
					var_text.clone()])
			}
			var_text = rt.call_function('do_shortcode', [var_text.clone()])
		}
	}
	var_post = var_original_post.clone()
	rt.call_function('remove_filter', [rt.new_string('shortcode_atts_gallery'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Text', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: '_filter_gallery_shortcode_attrs' },
		])])
	if rt.is_true(var_should_suspend_legacy_shortcode_support) {
		rt.call_function('add_filter', [rt.new_string('widget_text'),
			rt.new_string('do_shortcode'), var_widget_text_do_shortcode_priority.clone()])
	}
	rt.echo_val(var_args.array_get(rt.new_string('before_widget')))
	if !(!rt.is_true(var_title)) {
		print((var_args.array_get(rt.new_string('before_title'))).str() + var_title.str() +
			(var_args.array_get(rt.new_string('after_title'))).str())
	}
	var_text = rt.call_function('preg_replace_callback', [
		rt.new_string('#<(video|iframe|object|embed)\\s[^>]*>#i'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Text', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'inject_video_max_width_style' },
		]),
		var_text.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_text)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_args.array_get(rt.new_string('after_widget')))
}

fn (mut this Class_WP_Widget_Text) inject_video_max_width_style(var_matches rt.PhpVal) rt.PhpVal {
	mut var_html := var_matches.array_get(rt.new_int(0))
	var_html = rt.call_function('preg_replace', [rt.new_string('/\\sheight="\\d+"/'),
		rt.new_string(''), var_html.clone()])
	var_html = rt.call_function('preg_replace', [rt.new_string('/\\swidth="\\d+"/'),
		rt.new_string(''), var_html.clone()])
	var_html = rt.call_function('preg_replace', [
		rt.new_string('/(?<=width:)\\s*\\d+px(?=;?)/'),
		rt.new_string('100%'),
		var_html.clone(),
	])
	return var_html.clone()
}

fn (mut this Class_WP_Widget_Text) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_new_instance_mutated := var_new_instance
	var_new_instance_mutated = rt.call_function('wp_parse_args', [
		var_new_instance_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'text', val: '' },
			rt.ArrayItem{ key: 'filter', val: false },
			rt.ArrayItem{ key: 'visual', val: rt.new_null() },
		])])
	mut var_instance := var_old_instance
	var_instance.array_set('title', rt.call_function('sanitize_text_field', [
		var_new_instance_mutated.array_get(rt.new_string('title')),
	]))
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		var_instance.array_set('text', var_new_instance_mutated.array_get(rt.new_string('text')))
	} else {
		var_instance.array_set('text', rt.call_function('wp_kses_post', [
			var_new_instance_mutated.array_get(rt.new_string('text')),
		]))
	}
	var_instance.array_set('filter',
		!(!rt.is_true(var_new_instance_mutated.array_get(rt.new_string('filter')))))
	if var_old_instance.array_isset(rt.new_string('filter'))
		&& rt.is_true(rt.identical(rt.new_string('content'), var_old_instance.array_get(rt.new_string('filter')))) {
		var_instance.array_set('visual', true)
	}
	if rt.is_true(rt.identical(rt.new_string('content'),
		var_new_instance_mutated.array_get(rt.new_string('filter'))))
	{
		var_instance.array_set('visual', true)
	}
	if var_new_instance_mutated.array_isset(rt.new_string('visual')) {
		var_instance.array_set('visual',
			!(!rt.is_true(var_new_instance_mutated.array_get(rt.new_string('visual')))))
	}
	if !(!rt.is_true(var_instance.array_get(rt.new_string('visual')))) {
		var_instance.array_set('filter', true)
	}
	return var_instance.clone()
}

fn (mut this Class_WP_Widget_Text) enqueue_preview_scripts() {
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/media.php', '4')
	rt.call_function('wp_playlist_scripts', [rt.new_string('audio')])
	rt.call_function('wp_playlist_scripts', [rt.new_string('video')])
}

fn (mut this Class_WP_Widget_Text) enqueue_admin_scripts() {
	rt.call_function('wp_enqueue_editor', []rt.PhpVal{})
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('text-widgets')])
	rt.call_function('wp_add_inline_script', [rt.new_string('text-widgets'),
		rt.call_function('sprintf', [rt.new_string('wp.textWidgets.idBases.push( %s );'),
			rt.call_function('wp_json_encode', [
				rt.get_property(rt.new_object('WP_Widget_Text', ['WP_Widget'], &this), 'id_base'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			])])])
	rt.call_function('wp_add_inline_script', [rt.new_string('text-widgets'),
		rt.new_string('wp.textWidgets.init();'), rt.new_string('after')])
}

fn (mut this Class_WP_Widget_Text) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		rt.cast_array(var_instance_mutated),
		rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'text', val: '' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	if !(this.is_legacy_instance(var_instance_mutated.clone())) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('user_can_richedit', []rt.PhpVal{})) {
			rt.call_function('add_filter', [rt.new_string('the_editor_content'),
				rt.new_string('format_for_editor'), rt.new_int(10),
				rt.new_int(2)])
			mut var_default_editor := rt.new_string('tinymce')
		} else {
			var_default_editor = rt.new_string('html')
		}
		mut var_text := rt.call_function('apply_filters', [
			rt.new_string('the_editor_content'),
			var_instance_mutated.array_get(rt.new_string('text')),
			var_default_editor.clone(),
		])
		if rt.is_true(rt.call_function('user_can_richedit', []rt.PhpVal{})) {
			rt.call_function('remove_filter', [rt.new_string('the_editor_content'),
				rt.new_string('format_for_editor')])
		}
		mut var_escaped_text := rt.call_function('preg_replace', [
			rt.new_string('#</textarea#i'),
			rt.new_string('&lt;/textarea'),
			var_text.clone(),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('title')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('title')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr',
			[var_instance_mutated.array_get(rt.new_string('title'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('text')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('text')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_escaped_text)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('filter')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('filter')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('visual')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('visual')))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('visual')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('visual')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('title')))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Title:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('title')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('title')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr',
			[var_instance_mutated.array_get(rt.new_string('title'))]))
		// unsupported statement: Stmt_InlineHTML
		if !(var_instance_mutated.array_isset(rt.new_string('visual'))) {
			mut var_widget_info_message := rt.call_function('__', [
				rt.new_string('This widget may contain code that may work better in the &#8220;Custom HTML&#8221; widget. How about trying that widget instead?'),
			])
		} else {
			var_widget_info_message = rt.call_function('__', [
				rt.new_string('This widget may have contained code that may work better in the &#8220;Custom HTML&#8221; widget. If you have not yet, how about trying that widget instead?'),
			])
		}
		rt.call_function('wp_admin_notice', [var_widget_info_message.clone(),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'notice-alt' },
					rt.ArrayItem{ key: none, val: 'inline' },
				]) }])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('text')))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Content:')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('text')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('text')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea', [
			var_instance_mutated.array_get(rt.new_string('text')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('filter')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_name(rt.new_string('filter')))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [
			rt.new_bool(!(!rt.is_true(var_instance_mutated.array_get(rt.new_string('filter'))))),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(this.get_field_id(rt.new_string('filter')))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Automatically add paragraphs')])
		// unsupported statement: Stmt_InlineHTML
	}
}

fn Class_WP_Widget_Text.render_control_template_scripts() {
	mut var_dismissed_pointers := rt.call_function('explode', [
		rt.new_string(','),
		rt.new_string((rt.call_function('get_user_meta', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('dismissed_wp_pointers'),
			rt.new_bool(true),
		])).str())])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('text_widget_custom_html'),
		var_dismissed_pointers.clone(),
		rt.new_bool(true),
	])))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('New Custom HTML Widget')])
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Did you know there is a &#8220;Custom HTML&#8221; widget now? You can find it by pressing the &#8220;<a class="add-widget" href="#">Add a Widget</a>&#8221; button and searching for &#8220;HTML&#8221;. Check it out to add some custom code to your site!'),
			])
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('_e', [
				rt.new_string('Did you know there is a &#8220;Custom HTML&#8221; widget now? You can find it by scanning the list of available widgets on this screen. Check it out to add some custom code to your site!'),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Dismiss')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('text_widget_paste_html'),
		var_dismissed_pointers.clone(),
		rt.new_bool(true),
	])))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Did you just paste HTML?')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('Hey there, looks like you just pasted HTML into the &#8220;Visual&#8221; tab of the Text widget. You may want to paste your code into the &#8220;Code&#8221; tab instead. Alternately, try out the new &#8220;Custom HTML&#8221; widget!'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Dismiss')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Content:')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

struct Class_DOMDocument {
	rt.PhpObjectBase
}

fn create_wp_widget_text() &Class_WP_Widget_Text {
	mut obj := &Class_WP_Widget_Text{
		PhpObjectBase: rt.PhpObjectBase{}
		registered:    false
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

fn create_domdocument(_args ...rt.PhpVal) &Class_DOMDocument {
	mut obj := &Class_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Text) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'is_legacy_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_legacy_instance(dispatch_arg_0))
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
		'inject_video_max_width_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.inject_video_max_width_style(dispatch_arg_0)
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'enqueue_preview_scripts' {
			this.enqueue_preview_scripts()
			return rt.new_null()
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
			Class_WP_Widget_Text.render_control_template_scripts()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Text) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered' { return rt.new_bool(this.registered) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Text) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered' {
			this.registered = val.to_bool()
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

fn (mut this Class_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
