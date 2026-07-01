import rt

struct Class_WC_Widget {
	rt.PhpObjectBase
pub mut:
		widget_cssclass rt.PhpVal = rt.new_null()
		widget_description rt.PhpVal = rt.new_null()
		widget_id rt.PhpVal = rt.new_null()
		widget_name rt.PhpVal = rt.new_null()
		settings rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Widget) construct()  {
	mut var_widget_ops := { 'classname': this.widget_cssclass, 'description': this.widget_description, 'customize_selective_refresh': rt.new_bool(true), 'show_instance_in_rest': rt.new_bool(true) }
	this.Class_WP_Widget.construct(this.widget_id, this.widget_name, var_widget_ops.dup())
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget', ['WP_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'flush_widget_cache' }])])
	rt.call_function('add_action', [rt.new_string('deleted_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget', ['WP_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'flush_widget_cache' }])])
	rt.call_function('add_action', [rt.new_string('switch_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget', ['WP_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'flush_widget_cache' }])])
}

fn (mut this Class_WC_Widget) get_cached_widget(var_args rt.PhpVal) bool {
	if !rt.is_true(var_args.array_get('widget_id')) {
		return false
	}
	mut var_cache := rt.call_function('wp_cache_get', [this.get_widget_id_for_cache(this.widget_id, ''), rt.new_string('widget')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache.dup().is_array()))))) {
		var_cache = rt.new_array()
	}
	if var_cache.array_isset(this.get_widget_id_for_cache(var_args.array_get('widget_id'), '')) {
		rt.echo_val(var_cache.array_get(this.get_widget_id_for_cache(var_args.array_get('widget_id'), '')))
		return true
	}
	return false
}

fn (mut this Class_WC_Widget) cache_widget(var_args rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_args.array_get('widget_id')) {
		return var_content.dup()
	}
	mut var_cache := rt.call_function('wp_cache_get', [this.get_widget_id_for_cache(this.widget_id, ''), rt.new_string('widget')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache.dup().is_array()))))) {
		var_cache = rt.new_array()
	}
	var_cache.array_set(this.get_widget_id_for_cache(var_args.array_get('widget_id'), ''), var_content.dup())
	rt.call_function('wp_cache_set', [this.get_widget_id_for_cache(this.widget_id, ''), var_cache.dup(), rt.new_string('widget')])
	return var_content.dup()
}

fn (mut this Class_WC_Widget) flush_widget_cache()  {
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'https' }, rt.ArrayItem{ key: none, val: 'http' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_scheme := item_1.val
			rt.call_function('wp_cache_delete', [this.get_widget_id_for_cache(this.widget_id, (var_scheme).str()), rt.new_string('widget')])
		}
	}
}

fn (mut this Class_WC_Widget) get_instance_title(var_instance rt.PhpVal) string {
	mut var_instance_mutated := var_instance
	if var_instance_mutated.array_isset(rt.new_string('title')) {
		return (var_instance_mutated.array_get('title')).str()
	}
	if !(this.settings).is_null() && this.settings.array_isset(rt.new_string('title')) && this.settings.array_get('title').array_isset(rt.new_string('std')) {
		return (this.settings.array_get('title').array_get('std')).str()
	}
	return ''
}

fn (mut this Class_WC_Widget) widget_start(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	rt.echo_val(var_args.array_get('before_widget'))
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'), this.get_instance_title(var_instance_mutated.dup()), var_instance_mutated.dup(), rt.get_property(rt.new_object('WC_Widget', ['WP_Widget'], &this), 'id_base')])
	if rt.is_true(var_title) {
		print((var_args.array_get('before_title')).str() + (var_title).str() + (var_args.array_get('after_title')).str())
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_WC_Widget) widget_end(var_args rt.PhpVal)  {
	rt.echo_val(var_args.array_get('after_widget'))
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Widget) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := var_old_instance
	if !rt.is_true(this.settings) {
		return var_instance.dup()
	}
	{
		mut iter_1 := this.settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			mut var_key := item_1.key
			if !(var_setting.array_isset(rt.new_string('type'))) {
				continue
			}
			mut switch_val_1 := var_setting.array_get('type')
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('number'))) {
				var_instance.array_set(var_key, rt.call_function('absint', [var_new_instance.array_get(var_key)]))
				if rt.is_true(rt.new_bool(var_setting.array_isset(rt.new_string('min')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_instance.array_set(var_key, rt.call_function('max', [var_instance.array_get(var_key), var_setting.array_get('min')]))
				}
				if rt.is_true(rt.new_bool(var_setting.array_isset(rt.new_string('max')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_instance.array_set(var_key, rt.call_function('min', [var_instance.array_get(var_key), var_setting.array_get('max')]))
				}
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('textarea'))) {
				var_instance.array_set(var_key, rt.call_function('wp_kses', [rt.new_string(rt.call_function('wp_unslash', [var_new_instance.array_get(var_key)]).to_string().trim_space()), rt.call_function('wp_kses_allowed_html', [rt.new_string('post')])]))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkbox'))) {
				var_instance.array_set(var_key, if !rt.is_true(var_new_instance.array_get(var_key)) { 0 } else { 1 })
			} else {
				var_instance.array_set(var_key, if var_new_instance.array_isset(var_key) { rt.call_function('sanitize_text_field', [var_new_instance.array_get(var_key)]) } else { var_setting.array_get('std') })
			}
			var_instance.array_set(var_key, rt.call_function('apply_filters', [rt.new_string('woocommerce_widget_settings_sanitize_option'), var_instance.array_get(var_key), var_new_instance.dup(), var_key.dup(), var_setting.dup()]))
		}
	}
	this.flush_widget_cache()
	return var_instance.dup()
}

fn (mut this Class_WC_Widget) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	if !rt.is_true(this.settings) {
		return rt.new_null()
	}
	{
		mut iter_1 := this.settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			mut var_key := item_1.key
			mut var_class := if var_setting.array_isset(rt.new_string('class')) { var_setting.array_get('class') } else { rt.new_string('') }
			mut var_value := if var_instance_mutated.array_isset(var_key) { var_instance_mutated.array_get(var_key) } else { var_setting.array_get('std') }
			mut switch_val_2 := var_setting.array_get('type')
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('text'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [var_setting.array_get('label')]))
				// unsupported statement: Stmt_InlineHTML
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_class.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_value.dup()]))
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('number'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_setting.array_get('label'))
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_class.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_setting.array_get('step')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_setting.array_get('min')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_setting.array_get('max')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_value.dup()]))
				// unsupported statement: Stmt_InlineHTML
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('select'))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_setting.array_get('label'))
				// unsupported statement: Stmt_Nop
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_class.dup()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.dup())]))
				// unsupported statement: Stmt_InlineHTML
				{
					mut iter_2 := var_setting.array_get('options').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_option_value := item_2.val
						mut var_option_key := item_2.key
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val()
					}
				}
			} else if rt.is_true(rt.equal(switch_val_2, )) {
			} else if rt.is_true(rt.equal(switch_val_2, )) {
			} else {
			}
		}
	}
}

fn (mut this Class_WC_Widget) get_current_page_url() rt.PhpVal {
}

fn (mut this Class_WC_Widget) get_widget_id_for_cache(var_widget_id rt.PhpVal, scheme string) rt.PhpVal {
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wc_widget() &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
		widget_cssclass: rt.new_null()
		widget_description: rt.new_null()
		widget_id: rt.new_null()
		widget_name: rt.new_null()
		settings: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_widget() &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_cached_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_cached_widget(dispatch_arg_0))
		}
		'cache_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.cache_widget(dispatch_arg_0, dispatch_arg_1)
		}
		'flush_widget_cache' {
			this.flush_widget_cache()
			return rt.new_null()
		}
		'get_instance_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_instance_title(dispatch_arg_0))
		}
		'widget_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget_start(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'widget_end' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.widget_end(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		'get_current_page_url' {
			return this.get_current_page_url()
		}
		'get_widget_id_for_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_widget_id_for_cache(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'widget_cssclass' { return this.widget_cssclass }
		'widget_description' { return this.widget_description }
		'widget_id' { return this.widget_id }
		'widget_name' { return this.widget_name }
		'settings' { return this.settings }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'widget_cssclass' { this.widget_cssclass = val; return true }
		'widget_description' { this.widget_description = val; return true }
		'widget_id' { this.widget_id = val; return true }
		'widget_name' { this.widget_name = val; return true }
		'settings' { this.settings = val; return true }
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




pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_widget_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
