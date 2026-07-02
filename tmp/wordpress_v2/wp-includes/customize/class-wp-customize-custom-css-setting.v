import rt

struct Class_WP_Customize_Custom_CSS_Setting {
	rt.PhpObjectBase
pub mut:
	prop_type  rt.PhpVal = rt.new_string('custom_css')
	transport  rt.PhpVal = rt.new_string('postMessage')
	capability rt.PhpVal = rt.new_string('edit_css')
	stylesheet rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	this.Class_WP_Customize_Setting.construct(var_manager.clone(), var_id.clone(), var_args.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('custom_css'), rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', [
		'WP_Customize_Setting',
	], &this), 'id_data').array_get(rt.new_string('base'))))))
	{
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('Expected custom_css id_base.'))))
	}
	if rt.is_true(rt.new_bool(1 != rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', ['WP_Customize_Setting'], &this), 'id_data').array_get(rt.new_string('keys')).array_count()))
		|| !rt.is_true(rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', ['WP_Customize_Setting'], &this), 'id_data').array_get(rt.new_string('keys')).array_get(rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('Expected single stylesheet key.'))))
	}
	this.stylesheet = rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', [
		'WP_Customize_Setting',
	], &this), 'id_data').array_get(rt.new_string('keys')).array_get(rt.new_int(0))
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) preview() bool {
	if rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', [
		'WP_Customize_Setting',
	], &this), 'is_previewed')
	{
		return false
	}
	this.dispatch_set_prop('is_previewed', rt.new_bool(true))
	rt.call_function('add_filter', [rt.new_string('wp_get_custom_css'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Custom_CSS_Setting', [
				'WP_Customize_Setting',
			], &this) },
			rt.ArrayItem{ key: none, val: 'filter_previewed_wp_get_custom_css' },
		]),
		rt.new_int(9), rt.new_int(2)])
	return true
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) filter_previewed_wp_get_custom_css(var_css rt.PhpVal, var_stylesheet rt.PhpVal) rt.PhpVal {
	mut var_css_mutated := var_css
	if rt.is_true(rt.identical(var_stylesheet, this.stylesheet)) {
		mut var_customized_value := this.post_value(rt.new_null())
		if !(var_customized_value.clone().is_null()) {
			var_css_mutated = var_customized_value.clone()
		}
	}
	return var_css_mutated.clone()
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) value() rt.PhpVal {
	if rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', [
		'WP_Customize_Setting',
	], &this), 'is_previewed')
	{
		mut var_post_value := this.post_value(rt.new_null())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_post_value)))) {
			return var_post_value.clone()
		}
	}
	mut var_id_base := rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', [
		'WP_Customize_Setting',
	], &this), 'id_data').array_get(rt.new_string('base'))
	mut var_value := rt.new_string('')
	mut var_post := rt.call_function('wp_get_custom_css_post', [this.stylesheet])
	if rt.is_true(var_post) {
		var_value = rt.get_property(var_post, 'post_content')
	}
	if !rt.is_true(var_value) {
		var_value = rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', [
			'WP_Customize_Setting',
		], &this), 'default')
	}
	var_value = rt.call_function('apply_filters', [
		rt.new_string('customize_value_${var_id_base.to_string()}'),
		var_value.clone(),
		rt.new_object('WP_Customize_Custom_CSS_Setting', ['WP_Customize_Setting'], &this),
	])
	return var_value.clone()
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) validate(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_css := var_value_mutated.clone()
	mut var_validity := create_wp_error()
	mut var_length := rt.new_int(var_css.clone().to_string().len)
	mut var_at := rt.call_function('strcspn', [var_css.clone(),
		rt.new_string('<')])
	for {
		if !(rt.is_true(rt.less(var_at, var_length))) { break
		 }
		mut var_remaining_strlen := rt.sub(var_length, var_at)
		mut var_possible_style_close_tag := rt.identical(rt.new_int(0), rt.call_function('substr_compare', [
			var_css.clone(),
			rt.new_string('</style'),
			var_at.clone(),
			rt.call_function('min', [rt.new_int(7), var_remaining_strlen.clone()]),
			rt.new_bool(true),
		]))
		if rt.is_true(var_possible_style_close_tag) {
			if rt.is_true(rt.less(var_remaining_strlen, rt.new_int(8))) {
				rt.call_method(var_validity, 'add', [rt.new_string('illegal_markup'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('The CSS must not end in "%s".'),
						]),
						rt.call_function('esc_html', [
							rt.call_function('substr', [var_css.clone(),
								var_at.clone()]),
						]),
					])])
				break
			}
			if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('strspn', [
				var_css.clone(),
				rt.new_string(' \t\r\n/>'),
				rt.add(var_at, rt.new_int(7)),
				rt.new_int(1),
			])))
			{
				rt.call_method(var_validity, 'add', [rt.new_string('illegal_markup'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('The CSS must not contain "%s".'),
						]),
						rt.call_function('esc_html', [
							rt.call_function('substr', [var_css.clone(),
								var_at.clone(), rt.new_int(8)]),
						]),
					])])
				break
			}
		}
		var_at = rt.add(var_at, rt.call_function('strcspn', [
			var_css.clone(), rt.new_string('<'), rt.pre_inc(var_at)]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_validity, 'has_errors', []rt.PhpVal{}))))) {
		var_validity = this.Class_WP_Customize_Setting.validate(var_css.clone())
	}
	return var_validity.clone()
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) update(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	mut var_css := var_value_mutated.clone()
	if !rt.is_true(var_css) {
		var_css = rt.new_string('')
	}
	mut var_r := rt.call_function('wp_update_custom_css_post', [
		var_css.clone(), rt.create_array([
			rt.ArrayItem{ key: 'stylesheet', val: this.stylesheet },
		])])
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		return false
	}
	mut var_post_id := rt.get_property(var_r, 'ID')
	if rt.is_true(rt.identical(rt.call_method(rt.get_property(rt.new_object('WP_Customize_Custom_CSS_Setting', [
		'WP_Customize_Setting',
	], &this), 'manager'), 'get_stylesheet', []rt.PhpVal{}), this.stylesheet))
	{
		rt.call_function('set_theme_mod', [rt.new_string('custom_css_post_id'),
			var_post_id.clone()])
	}
	return var_post_id.to_bool()
}

struct Class_WP_Customize_Setting {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_customize_custom_css_setting(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Custom_CSS_Setting {
	mut obj := &Class_WP_Customize_Custom_CSS_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('custom_css')
		transport:     rt.new_string('postMessage')
		capability:    rt.new_string('edit_css')
		stylesheet:    rt.new_string('')
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_setting(_args ...rt.PhpVal) &Class_WP_Customize_Setting {
	mut obj := &Class_WP_Customize_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'preview' {
			return rt.new_bool(this.preview())
		}
		'filter_previewed_wp_get_custom_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_previewed_wp_get_custom_css(dispatch_arg_0, dispatch_arg_1)
		}
		'value' {
			return this.value()
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate(dispatch_arg_0)
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Custom_CSS_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'transport' { return this.transport }
		'capability' { return this.capability }
		'stylesheet' { return this.stylesheet }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'transport' {
			this.transport = val
			return true
		}
		'capability' {
			this.capability = val
			return true
		}
		'stylesheet' {
			this.stylesheet = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
