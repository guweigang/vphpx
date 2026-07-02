import rt

struct Class_WP_Widget_Media {
	rt.PhpObjectBase
pub mut:
	l10n       rt.PhpVal = rt.new_array()
	registered bool
}

fn init_static_wp_widget_media() {
	rt.init_static_prop('WP_Widget_Media', 'default_description', rt.new_string(''))
	rt.init_static_prop('WP_Widget_Media', 'l10n_defaults', rt.new_array())
}

fn (mut this Class_WP_Widget_Media) construct(var_id_base rt.PhpVal, var_name rt.PhpVal, var_widget_options rt.PhpVal, var_control_options rt.PhpVal) {
	mut var_widget_opts := rt.call_function('wp_parse_args', [
		var_widget_options.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'description', val: Class_WP_Widget_Media.get_default_description() },
			rt.ArrayItem{ key: 'customize_selective_refresh', val: true },
			rt.ArrayItem{ key: 'show_instance_in_rest', val: true },
			rt.ArrayItem{ key: 'mime_type', val: '' },
		])])
	mut var_control_opts := rt.call_function('wp_parse_args', [
		var_control_options.clone(), rt.new_array()])
	this.l10n = rt.call_function('array_merge', [
		Class_WP_Widget_Media.get_l10n_defaults(),
		rt.call_function('array_filter', [this.l10n]),
	])
	this.Class_WP_Widget.construct(var_id_base.clone(), var_name.clone(), var_widget_opts.clone(),
		var_control_opts.clone())
}

fn (mut this Class_WP_Widget_Media) _register_one(var_number rt.PhpVal) {
	this.Class_WP_Widget._register_one(var_number.clone())
	if this.registered {
		return
	}
	this.registered = true
	rt.call_function('add_action', [rt.new_string('admin_print_scripts-widgets.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_admin_scripts' },
		])])
	if rt.is_true(this.is_preview()) {
		rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', [
					'WP_Widget',
				], &this) },
				rt.ArrayItem{ key: none, val: 'enqueue_preview_scripts' },
			])])
	}
	rt.call_function('add_action', [rt.new_string('admin_footer-widgets.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'render_control_template_scripts' },
		])])
	rt.call_function('add_filter', [rt.new_string('display_media_states'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', [
				'WP_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'display_media_state' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WP_Widget_Media) get_instance_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: 'attachment_id', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'default', val: 0 },
			rt.ArrayItem{ key: 'minimum', val: 0 },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Attachment post ID'),
			]) },
			rt.ArrayItem{ key: 'media_prop', val: 'id' },
		]) },
		rt.ArrayItem{ key: 'url', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'format', val: 'uri' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('URL to the media file'),
			]) },
		]) },
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Title for the widget'),
			]) },
			rt.ArrayItem{ key: 'should_preview_update', val: false },
		]) },
	])
	var_schema = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('widget_'), rt.get_property(rt.new_object('WP_Widget_Media', [
			'WP_Widget',
		], &this), 'id_base')), rt.new_string('_instance_schema')),
		var_schema.clone(),
		rt.new_object('WP_Widget_Media', [
			'WP_Widget',
		], &this),
	])
	return var_schema.clone()
}

fn (mut this Class_WP_Widget_Media) is_attachment_with_mime_type(var_attachment rt.PhpVal, var_mime_type rt.PhpVal) bool {
	mut var_attachment_mutated := var_attachment
	if !rt.is_true(var_attachment_mutated) {
		return false
	}
	var_attachment_mutated = rt.call_function('get_post', [var_attachment_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment_mutated)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_attachment_mutated,
		'post_type')))))
	{
		return false
	}
	return (rt.call_function('wp_attachment_is', [var_mime_type.clone(),
		var_attachment_mutated.clone()])).to_bool()
}

fn (mut this Class_WP_Widget_Media) sanitize_token_list(var_tokens rt.PhpVal) rt.PhpVal {
	mut var_tokens_mutated := var_tokens
	if rt.is_true(rt.new_bool(var_tokens_mutated.clone().is_string())) {
		var_tokens_mutated = rt.call_function('preg_split', [
			rt.new_string('/\\s+/'), rt.new_string(var_tokens_mutated.clone().to_string().trim_space())])
	}
	var_tokens_mutated = rt.call_function('array_map', [
		rt.new_string('sanitize_html_class'),
		var_tokens_mutated.clone(),
	])
	var_tokens_mutated = rt.call_function('array_filter', [var_tokens_mutated.clone()])
	return rt.call_function('implode', [rt.new_string(' '), var_tokens_mutated.clone()])
}

fn (mut this Class_WP_Widget_Media) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [
		var_instance_mutated.clone(),
		rt.call_function('wp_list_pluck', [
			this.get_instance_schema(),
			rt.new_string('default'),
		])])
	if !(this.has_content(var_instance_mutated.clone())) {
		return
	}
	rt.echo_val(var_args.array_get(rt.new_string('before_widget')))
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_instance_mutated.array_get(rt.new_string('title')),
		var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WP_Widget_Media', [
			'WP_Widget',
		], &this), 'id_base')])
	if rt.is_true(var_title) {
		print((var_args.array_get(rt.new_string('before_title'))).str() + var_title.str() +
			(var_args.array_get(rt.new_string('after_title'))).str())
	}
	var_instance_mutated = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('widget_'), rt.get_property(rt.new_object('WP_Widget_Media', [
			'WP_Widget',
		], &this), 'id_base')), rt.new_string('_instance')),
		var_instance_mutated.clone(),
		var_args.clone(),
		rt.new_object('WP_Widget_Media', [
			'WP_Widget',
		], &this),
	])
	this.render_media(var_instance_mutated.clone())
	rt.echo_val(var_args.array_get(rt.new_string('after_widget')))
}

fn (mut this Class_WP_Widget_Media) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_old_instance_mutated := var_old_instance
	mut var_schema := this.get_instance_schema()
	mut iter_1 := var_schema.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field_schema := item_1.val
		mut var_field := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_new_instance.clone().array_isset(var_field.clone())))))) {
			continue
		}
		mut var_value := var_new_instance.array_get(var_field)
		if rt.is_true(rt.identical(rt.new_string('boolean'), var_field_schema.array_get(rt.new_string('type'))))
			&& rt.is_true(rt.identical(rt.new_string(''), var_value)) {
			var_value = rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('rest_validate_value_from_schema', [
			var_value.clone(),
			var_field_schema.clone(),
			var_field.clone(),
		])))))
		{
			continue
		}
		var_value = rt.call_function('rest_sanitize_value_from_schema', [
			var_value.clone(), var_field_schema.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
			continue
		}
		if var_field_schema.array_isset(rt.new_string('sanitize_callback')) {
			var_value = rt.call_function('call_user_func', [
				var_field_schema.array_get(rt.new_string('sanitize_callback')),
				var_value.clone(),
			])
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
			continue
		}
		var_old_instance_mutated.array_set(var_field, var_value.clone())
	}
	return var_old_instance_mutated.clone()
}

fn (mut this Class_WP_Widget_Media) render_media(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
}

fn (mut this Class_WP_Widget_Media) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_instance_schema := this.get_instance_schema()
	var_instance_mutated = rt.call_function('wp_array_slice_assoc', [
		rt.call_function('wp_parse_args', [rt.cast_array(var_instance_mutated),
			rt.call_function('wp_list_pluck', [var_instance_schema.clone(),
				rt.new_string('default')])]),
		rt.func_array_keys(var_instance_schema.clone()),
	])
	mut iter_2 := var_instance_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_name := item_2.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_name.clone())]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_name.clone())]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [if var_value.clone().is_array() { rt.call_function('implode', [
				rt.new_string(','),
				var_value.clone(),
			]) } else { var_value.str() }]))
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WP_Widget_Media) display_media_state(var_states rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_states_mutated := var_states
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_mutated)))) {
		var_post_mutated = rt.call_function('get_post', []rt.PhpVal{})
	}
	mut var_use_count := rt.new_int(0)
	mut iter_3 := this.get_settings().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_instance := item_3.val
		if var_instance.array_isset(rt.new_string('attachment_id'))
			&& rt.is_true(rt.identical(var_instance.array_get(rt.new_string('attachment_id')), rt.get_property(var_post_mutated, 'ID'))) {
			rt.pre_inc(var_use_count)
		}
	}
	if rt.is_true(rt.identical(rt.new_int(1), var_use_count)) {
		var_states_mutated.array_push(this.l10n.array_get(rt.new_string('media_library_state_single')))
	} else if rt.is_true(rt.greater(var_use_count, rt.new_int(0))) {
		var_states_mutated.array_push(rt.call_function('sprintf', [
			rt.call_function('translate_nooped_plural', [
				this.l10n.array_get(rt.new_string('media_library_state_multi')),
				var_use_count.clone(),
			]),
			rt.call_function('number_format_i18n', [
				var_use_count.clone(),
			]),
		]))
	}
	return var_states_mutated.clone()
}

fn (mut this Class_WP_Widget_Media) enqueue_preview_scripts() {
}

fn (mut this Class_WP_Widget_Media) enqueue_admin_scripts() {
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('media-widgets')])
}

fn (mut this Class_WP_Widget_Media) render_control_template_scripts() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WP_Widget_Media', ['WP_Widget'], &this), 'id_base'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WP_Widget_Media', ['WP_Widget'], &this), 'id_base'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [this.l10n.array_get(rt.new_string('add_media'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [this.l10n.array_get(rt.new_string('edit_media'))]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(this.l10n.array_get(rt.new_string('replace_media')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			this.l10n.array_get(rt.new_string('replace_media')),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WP_Widget_Media.reset_default_labels() {
	rt.set_static_prop('WP_Widget_Media', 'default_description', rt.new_string(''))
	rt.set_static_prop('WP_Widget_Media', 'l10n_defaults', rt.new_array())
}

fn (mut this Class_WP_Widget_Media) has_content(var_instance rt.PhpVal) bool {
	mut var_instance_mutated := var_instance
	return rt.is_true(var_instance_mutated.array_get(rt.new_string('attachment_id')))
		&& rt.is_true(rt.identical(rt.new_string('attachment'), rt.call_function('get_post_type', [var_instance_mutated.array_get(rt.new_string('attachment_id'))])))
		|| rt.is_true(var_instance_mutated.array_get(rt.new_string('url')))
}

fn Class_WP_Widget_Media.get_default_description() rt.PhpVal {
	if rt.is_true(rt.get_static_prop('WP_Widget_Media', 'default_description')) {
		return rt.get_static_prop('WP_Widget_Media', 'default_description')
	}
	rt.set_static_prop('WP_Widget_Media', 'default_description', rt.call_function('__', [
		rt.new_string('A media item.'),
	]))
	return rt.get_static_prop('WP_Widget_Media', 'default_description')
}

fn Class_WP_Widget_Media.get_l10n_defaults() rt.PhpVal {
	if !(!rt.is_true(rt.get_static_prop('WP_Widget_Media', 'l10n_defaults'))) {
		return rt.get_static_prop('WP_Widget_Media', 'l10n_defaults')
	}
	rt.set_static_prop('WP_Widget_Media', 'l10n_defaults', rt.create_array([
		rt.ArrayItem{ key: 'no_media_selected', val: rt.call_function('__', [
			rt.new_string('No media selected'),
		]) },
		rt.ArrayItem{ key: 'add_media', val: rt.call_function('_x', [
			rt.new_string('Add Media'),
			rt.new_string('label for button in the media widget'),
		]) },
		rt.ArrayItem{ key: 'replace_media', val: rt.call_function('_x', [
			rt.new_string('Replace Media'),
			rt.new_string('label for button in the media widget; should preferably not be longer than ~13 characters long'),
		]) },
		rt.ArrayItem{ key: 'edit_media', val: rt.call_function('_x', [
			rt.new_string('Edit Media'),
			rt.new_string('label for button in the media widget; should preferably not be longer than ~13 characters long'),
		]) },
		rt.ArrayItem{ key: 'add_to_widget', val: rt.call_function('__', [
			rt.new_string('Add to Widget'),
		]) },
		rt.ArrayItem{ key: 'missing_attachment', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('That file cannot be found. Check your <a href="%s">media library</a> and make sure it was not deleted.'),
			]),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('upload.php')]),
			]),
		]) },
		rt.ArrayItem{ key: 'media_library_state_multi', val: rt.call_function('_n_noop', [
			rt.new_string('Media Widget (%d)'),
			rt.new_string('Media Widget (%d)'),
		]) },
		rt.ArrayItem{ key: 'media_library_state_single', val: rt.call_function('__', [
			rt.new_string('Media Widget'),
		]) },
		rt.ArrayItem{ key: 'unsupported_file_type', val: rt.call_function('__', [
			rt.new_string('Looks like this is not the correct kind of file. Please link to an appropriate file instead.'),
		]) },
	]))
	return rt.get_static_prop('WP_Widget_Media', 'l10n_defaults')
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_media(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WP_Widget_Media {
	mut obj := &Class_WP_Widget_Media{
		PhpObjectBase: rt.PhpObjectBase{}
		l10n:          rt.new_array()
		registered:    false
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_wp_widget(_args ...rt.PhpVal) &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Media) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'_register_one' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._register_one(dispatch_arg_0)
			return rt.new_null()
		}
		'get_instance_schema' {
			return this.get_instance_schema()
		}
		'is_attachment_with_mime_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_attachment_with_mime_type(dispatch_arg_0, dispatch_arg_1))
		}
		'sanitize_token_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_token_list(dispatch_arg_0)
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
		'render_media' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.render_media(dispatch_arg_0)
			return rt.new_null()
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		'display_media_state' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.display_media_state(dispatch_arg_0, dispatch_arg_1)
		}
		'enqueue_preview_scripts' {
			this.enqueue_preview_scripts()
			return rt.new_null()
		}
		'enqueue_admin_scripts' {
			this.enqueue_admin_scripts()
			return rt.new_null()
		}
		'render_control_template_scripts' {
			this.render_control_template_scripts()
			return rt.new_null()
		}
		'reset_default_labels' {
			Class_WP_Widget_Media.reset_default_labels()
			return rt.new_null()
		}
		'has_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_content(dispatch_arg_0))
		}
		'get_default_description' {
			return Class_WP_Widget_Media.get_default_description()
		}
		'get_l10n_defaults' {
			return Class_WP_Widget_Media.get_l10n_defaults()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Media) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'l10n' { return this.l10n }
		'registered' { return rt.new_bool(this.registered) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Media) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'l10n' {
			this.l10n = val
			return true
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
