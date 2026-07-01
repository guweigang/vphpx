import rt

struct Class_WP_Widget_Media {
	rt.PhpObjectBase
pub mut:
		l10n rt.PhpVal = rt.new_array()
		registered bool
		default_description rt.PhpVal = rt.new_string('')
		l10n_defaults rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Widget_Media) construct(var_id_base rt.PhpVal, var_name rt.PhpVal, var_widget_options rt.PhpVal, var_control_options rt.PhpVal)  {
	mut var_widget_opts := rt.call_function('wp_parse_args', [var_widget_options.dup(), rt.create_array([rt.ArrayItem{ key: 'description', val: Class_WP_Widget_Media.get_default_description() }, rt.ArrayItem{ key: 'customize_selective_refresh', val: true }, rt.ArrayItem{ key: 'show_instance_in_rest', val: true }, rt.ArrayItem{ key: 'mime_type', val: '' }])])
	mut var_control_opts := rt.call_function('wp_parse_args', [var_control_options.dup(), rt.new_array()])
	this.l10n = rt.call_function('array_merge', [Class_WP_Widget_Media.get_l10n_defaults(), rt.call_function('array_filter', [this.l10n])])
	this.Class_WP_Widget.construct(var_id_base.dup(), var_name.dup(), var_widget_opts.dup(), var_control_opts.dup())
}

fn (mut this Class_WP_Widget_Media) _register_one(var_number rt.PhpVal)  {
	this.Class_WP_Widget._register_one(var_number.dup())
	if rt.is_true(this.registered) {
		return rt.new_null()
	}
	this.registered = true
	rt.call_function('add_action', [rt.new_string('admin_print_scripts-widgets.php'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', ['WP_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_admin_scripts' }])])
	if rt.is_true(this.is_preview()) {
		rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', ['WP_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'enqueue_preview_scripts' }])])
	}
	rt.call_function('add_action', [rt.new_string('admin_footer-widgets.php'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', ['WP_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'render_control_template_scripts' }])])
	rt.call_function('add_filter', [rt.new_string('display_media_states'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Media', ['WP_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'display_media_state' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WP_Widget_Media) get_instance_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'attachment_id', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 0 }, rt.ArrayItem{ key: 'minimum', val: 0 }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attachment post ID')]) }, rt.ArrayItem{ key: 'media_prop', val: 'id' }]) }, rt.ArrayItem{ key: 'url', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('URL to the media file')]) }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Title for the widget')]) }, rt.ArrayItem{ key: 'should_preview_update', val: false }]) }])
	var_schema = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('widget_'), rt.get_property(rt.new_object('WP_Widget_Media', ['WP_Widget'], &this), 'id_base')), rt.new_string('_instance_schema')), var_schema.dup(), rt.new_object('WP_Widget_Media', ['WP_Widget'], &this)])
	return var_schema.dup()
}

fn (mut this Class_WP_Widget_Media) is_attachment_with_mime_type(var_attachment rt.PhpVal, var_mime_type rt.PhpVal) bool {
	mut var_attachment_mutated := var_attachment
	if !rt.is_true(var_attachment_mutated) {
		return false
	}
	var_attachment_mutated = rt.call_function('get_post', [var_attachment_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment_mutated)))) {
		return false
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	return (rt.call_function('wp_attachment_is', [var_mime_type.dup(), var_attachment_mutated.dup()])).to_bool()
}

fn (mut this Class_WP_Widget_Media) sanitize_token_list(var_tokens rt.PhpVal) rt.PhpVal {
	mut var_tokens_mutated := var_tokens
	if rt.is_true(rt.new_bool(var_tokens_mutated.dup().is_string())) {
		var_tokens_mutated = rt.call_function('preg_split', [rt.new_string('/\\s+/'), rt.new_string(var_tokens_mutated.dup().to_string().trim_space())])
	}
	var_tokens_mutated = rt.call_function('array_map', [rt.new_string('sanitize_html_class'), var_tokens_mutated.dup()])
	var_tokens_mutated = rt.call_function('array_filter', [var_tokens_mutated.dup()])
	return rt.call_function('implode', [rt.new_string(' '), var_tokens_mutated.dup()])
}

fn (mut this Class_WP_Widget_Media) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [var_instance_mutated.dup(), rt.call_function('wp_list_pluck', [this.get_instance_schema(), rt.new_string('default')])])
	if !(this.has_content(var_instance_mutated.dup())) {
		return rt.new_null()
	}
	rt.echo_val(var_args.array_get('before_widget'))
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'), var_instance_mutated.array_get('title'), var_instance_mutated.dup(), rt.get_property(rt.new_object('WP_Widget_Media', ['WP_Widget'], &this), 'id_base')])
	if rt.is_true(var_title) {
		print((var_args.array_get('before_title')).str() + (var_title).str() + (var_args.array_get('after_title')).str())
	}
	var_instance_mutated = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('widget_'), rt.get_property(rt.new_object('WP_Widget_Media', ['WP_Widget'], &this), 'id_base')), rt.new_string('_instance')), var_instance_mutated.dup(), var_args.dup(), rt.new_object('WP_Widget_Media', ['WP_Widget'], &this)])
	this.render_media(var_instance_mutated.dup())
	rt.echo_val(var_args.array_get('after_widget'))
}

fn (mut this Class_WP_Widget_Media) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_old_instance_mutated := var_old_instance
	mut var_schema := this.get_instance_schema()
	{
		mut iter_1 := var_schema.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field_schema := item_1.val
			mut var_field := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_new_instance.dup().array_isset(var_field.dup())))))) {
				continue
			}
			mut var_value := var_new_instance.array_get(var_field)
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('boolean'), var_field_schema.array_get('type'))) && rt.is_true(rt.identical(rt.new_string(''), var_value)))) {
				var_value = rt.new_bool(rt.new_bool(false))
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			var_value = rt.call_function('rest_sanitize_value_from_schema', [var_value.dup(), var_field_schema.dup()])
			if rt.is_true(rt.call_function('is_wp_error', [var_value.dup()])) {
				continue
				// unsupported statement: Stmt_Nop
			}
			if var_field_schema.array_isset(rt.new_string('sanitize_callback')) {
				var_value = rt.call_function('call_user_func', [var_field_schema.array_get('sanitize_callback'), var_value.dup()])
			}
			if rt.is_true(rt.call_function('is_wp_error', [var_value.dup()])) {
				continue
			}
			var_old_instance_mutated.array_set(var_field, var_value.dup())
		}
	}
	return var_old_instance_mutated.dup()
}

fn (mut this Class_WP_Widget_Media) render_media(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
}

fn (mut this Class_WP_Widget_Media) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	mut var_instance_schema := this.get_instance_schema()
	var_instance_mutated = rt.call_function('wp_array_slice_assoc', [rt.call_function('wp_parse_args', [rt.cast_array(var_instance_mutated), rt.call_function('wp_list_pluck', [var_instance_schema.dup(), rt.new_string('default')])]), rt.func_array_keys(var_instance_schema.dup())])
	{
		mut iter_1 := var_instance_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_name := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_name.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_name.dup())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_name.dup())]))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [if rt.is_true(rt.new_bool(var_value.dup().is_array())) { rt.call_function('implode', [rt.new_string(','), var_value.dup()]) } else { // unsupported expression: Expr_Cast_String }]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
}

fn (mut this Class_WP_Widget_Media) display_media_state(var_states rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_states_mutated := var_states
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_mutated)))) {
		var_post_mutated = rt.call_function('get_post', []rt.PhpVal{})
	}
	mut var_use_count := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := this.get_settings().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_instance := item_1.val
			if rt.is_true(rt.new_bool(var_instance.array_isset(rt.new_string('attachment_id')) && rt.is_true(rt.identical(var_instance.array_get('attachment_id'), rt.get_property(var_post_mutated, 'ID'))))) {
				rt.pre_inc(var_use_count)
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_int(1), var_use_count)) {
		var_states_mutated.array_push(this.l10n.array_get('media_library_state_single'))
	} else if rt.is_true(rt.greater(var_use_count, rt.new_int(0))) {
		var_states_mutated.array_push(rt.call_function('sprintf', [rt.call_function('translate_nooped_plural', [this.l10n.array_get('media_library_state_multi'), var_use_count.dup()]), rt.call_function('number_format_i18n', [var_use_count.dup()])]))
	}
	return var_states_mutated.dup()
}

fn (mut this Class_WP_Widget_Media) enqueue_preview_scripts()  {
}

fn (mut this Class_WP_Widget_Media) enqueue_admin_scripts()  {
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
	rt.call_function('wp_enqueue_script', [rt.new_string('media-widgets')])
}

fn (mut this Class_WP_Widget_Media) render_control_template_scripts()  {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WP_Widget_Media', ['WP_Widget'], &this), 'id_base')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WP_Widget_Media', ['WP_Widget'], &this), 'id_base')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [this.l10n.array_get('add_media')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [this.l10n.array_get('edit_media')]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(this.l10n.array_get('replace_media'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [this.l10n.array_get('replace_media')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WP_Widget_Media.reset_default_labels()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn (mut this Class_WP_Widget_Media) has_content(var_instance rt.PhpVal) bool {
	mut var_instance_mutated := var_instance
	return rt.is_true(rt.new_bool(rt.is_true(var_instance_mutated.array_get('attachment_id')) && rt.is_true(rt.identical(rt.new_string('attachment'), rt.call_function('get_post_type', [var_instance_mutated.array_get('attachment_id')]))))) || rt.is_true(var_instance_mutated.array_get('url'))
}

fn Class_WP_Widget_Media.get_default_description() rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WP_Widget_Media.get_l10n_defaults() rt.PhpVal {
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_media(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WP_Widget_Media {
	mut obj := &Class_WP_Widget_Media{
		PhpObjectBase: rt.PhpObjectBase{}
		l10n: rt.new_array()
		registered: false
		default_description: rt.new_string('')
		l10n_defaults: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_wp_widget() &Class_WP_Widget {
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
		else { return none }
	}
}

fn (this &Class_WP_Widget_Media) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'l10n' { return this.l10n }
		'registered' { return rt.new_bool(this.registered) }
		'default_description' { return this.default_description }
		'l10n_defaults' { return this.l10n_defaults }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Media) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'l10n' { this.l10n = val; return true }
		'registered' { this.registered = (val).to_bool(); return true }
		'default_description' { this.default_description = val; return true }
		'l10n_defaults' { this.l10n_defaults = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_widgets_class_wp_widget_media_php() {
}
