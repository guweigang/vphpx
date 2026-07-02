import rt

struct Class_WP_Customize_Partial {
	rt.PhpObjectBase
pub mut:
	component           rt.PhpVal = rt.new_null()
	id                  rt.PhpVal = rt.new_null()
	id_data             rt.PhpVal = rt.new_array()
	prop_type           rt.PhpVal = rt.new_string('default')
	selector            rt.PhpVal = rt.new_null()
	settings            rt.PhpVal = rt.new_null()
	primary_setting     rt.PhpVal = rt.new_null()
	capability          rt.PhpVal = rt.new_null()
	render_callback     rt.PhpVal = rt.new_null()
	container_inclusive rt.PhpVal = rt.new_bool(false)
	fallback_refresh    rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_WP_Customize_Partial) construct(mut var_component Class_WP_Customize_Selective_Refresh, var_id rt.PhpVal, var_args rt.PhpVal) {
	mut var_keys := rt.func_array_keys(rt.call_function('get_object_vars', [
		rt.new_object('WP_Customize_Partial', []string{}, &this),
	]))
	mut iter_1 := var_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if var_args.array_isset(var_key) {
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":165,"name":"key"}',
				var_args.array_get(var_key))
		}
	}
	this.component = var_component
	this.id = var_id.clone()
	this.id_data.array_set('keys', rt.call_function('preg_split', [
		rt.new_string('/\\[/'),
		rt.call_function('str_replace', [rt.new_string(']'), rt.new_string(''), this.id]),
	]))
	this.id_data.array_set('base', rt.call_function('array_shift', [
		this.id_data.array_get(rt.new_string('keys')),
	]))
	if !rt.is_true(this.render_callback) {
		this.render_callback = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Partial', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_callback' },
		])
	}
	if !(!(this.settings).is_null()) {
		this.settings = rt.create_array([rt.ArrayItem{ key: none, val: var_id }])
	} else if rt.is_true(rt.new_bool(this.settings.is_string())) {
		this.settings = rt.create_array([rt.ArrayItem{ key: none, val: this.settings }])
	}
	if !rt.is_true(this.primary_setting) {
		this.primary_setting = rt.call_function('current', [this.settings])
	}
}

fn (mut this Class_WP_Customize_Partial) id_data() rt.PhpVal {
	return this.id_data
}

fn (mut this Class_WP_Customize_Partial) render(var_container_context rt.PhpVal) rt.PhpVal {
	mut var_partial := rt.new_object('WP_Customize_Partial', []string{}, &this)
	mut var_rendered := rt.new_bool(false)
	if !(!rt.is_true(this.render_callback)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		mut var_return_render := rt.call_function('call_user_func', [this.render_callback,
			rt.new_object('WP_Customize_Partial', []string{}, &this),
			var_container_context.clone()])
		mut var_ob_render := rt.call_function('ob_get_clean', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_return_render))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_ob_render)))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
				rt.call_function('__', [
					rt.new_string('Partial render must echo the content or return the content string (or array), but not both.'),
				]),
				rt.new_string('4.5.0')])
		}
		var_rendered = if !var_return_render.is_null() { var_return_render } else { var_ob_render }
	}
	var_rendered = rt.call_function('apply_filters', [
		rt.new_string('customize_partial_render'),
		var_rendered.clone(),
		var_partial.clone(),
		var_container_context.clone(),
	])
	var_rendered = rt.call_function('apply_filters', [
		rt.concat(rt.new_string('customize_partial_render_'), rt.get_property(var_partial, 'id')),
		var_rendered.clone(),
		var_partial.clone(),
		var_container_context.clone(),
	])
	return var_rendered.clone()
}

fn (mut this Class_WP_Customize_Partial) render_callback(mut var_partial Class_WP_Customize_Partial, var_context rt.PhpVal) bool {
	mut var_partial_mutated := var_partial
	mut var_context_mutated := var_context
	var_partial_mutated = rt.new_null()
	var_context_mutated = rt.new_null()
	return false
}

fn (mut this Class_WP_Customize_Partial) json() rt.PhpVal {
	mut var_exports := {
		'settings':           this.settings
		'primarySetting':     this.primary_setting
		'selector':           this.selector
		'type':               this.prop_type
		'fallbackRefresh':    this.fallback_refresh
		'containerInclusive': this.container_inclusive
	}
	return var_exports.clone()
}

fn (mut this Class_WP_Customize_Partial) check_capabilities() bool {
	if !(!rt.is_true(this.capability))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [this.capability]))))) {
		return false
	}
	mut iter_2 := this.settings.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_setting_id := item_2.val
		mut var_setting := rt.call_method(rt.get_property(this.component, 'manager'),
			'get_setting', [var_setting_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_setting))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_setting, 'check_capabilities', []rt.PhpVal{}))))) {
			return false
		}
	}
	return true
}

fn create_wp_customize_partial(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Partial {
	mut obj := &Class_WP_Customize_Partial{
		PhpObjectBase:       rt.PhpObjectBase{}
		component:           rt.new_null()
		id:                  rt.new_null()
		id_data:             rt.new_array()
		prop_type:           rt.new_string('default')
		selector:            rt.new_null()
		settings:            rt.new_null()
		primary_setting:     rt.new_null()
		capability:          rt.new_null()
		render_callback:     rt.new_null()
		container_inclusive: rt.new_bool(false)
		fallback_refresh:    rt.new_bool(true)
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_WP_Customize_Partial) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Customize_Selective_Refresh](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'id_data' {
			return this.id_data()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		'render_callback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Customize_Partial](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.render_callback(mut dispatch_arg_0, dispatch_arg_1))
		}
		'json' {
			return this.json()
		}
		'check_capabilities' {
			return rt.new_bool(this.check_capabilities())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Partial) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'component' { return this.component }
		'id' { return this.id }
		'id_data' { return this.id_data }
		'type' { return this.prop_type }
		'selector' { return this.selector }
		'settings' { return this.settings }
		'primary_setting' { return this.primary_setting }
		'capability' { return this.capability }
		'render_callback' { return this.render_callback }
		'container_inclusive' { return this.container_inclusive }
		'fallback_refresh' { return this.fallback_refresh }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Partial) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'component' {
			this.component = val
			return true
		}
		'id' {
			this.id = val
			return true
		}
		'id_data' {
			this.id_data = val
			return true
		}
		'type' {
			this.prop_type = val
			return true
		}
		'selector' {
			this.selector = val
			return true
		}
		'settings' {
			this.settings = val
			return true
		}
		'primary_setting' {
			this.primary_setting = val
			return true
		}
		'capability' {
			this.capability = val
			return true
		}
		'render_callback' {
			this.render_callback = val
			return true
		}
		'container_inclusive' {
			this.container_inclusive = val
			return true
		}
		'fallback_refresh' {
			this.fallback_refresh = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
