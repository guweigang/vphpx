import rt

struct Class_WP_Block_Bindings_Registry {
	rt.PhpObjectBase
pub mut:
		sources rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
		allowed_source_properties rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Block_Bindings_Registry) register(source_name string, mut var_source_properties Class_array) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.new_string(source_name).is_string()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block bindings source name must be a string.')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[A-Z]+/'), rt.new_string(source_name)])) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block bindings source names must not contain uppercase characters.')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	mut var_name_matcher := rt.new_string(rt.new_string('/^[a-z0-9-]+\\/[a-z0-9-]+$/'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [var_name_matcher.dup(), rt.new_string(source_name)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Block bindings source names must contain a namespace prefix. Example: my-plugin/my-custom-source')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	if rt.is_true(this.is_registered(rt.new_string(source_name))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Block bindings source "%s" already registered.')]), rt.new_string(source_name)]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	if !(var_source_properties.array_isset(rt.new_string('label'))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The $source_properties must contain a "label".')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	if !(var_source_properties.array_isset(rt.new_string('get_value_callback'))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The $source_properties must contain a "get_value_callback".')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_source_properties.array_get('get_value_callback')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The "get_value_callback" parameter must be a valid callback.')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(var_source_properties.array_isset(rt.new_string('uses_context')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_source_properties.array_get('uses_context').is_array()))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The "uses_context" parameter must be an array.')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	if !(!rt.is_true(rt.call_function('array_diff', [rt.func_array_keys(var_source_properties), this.allowed_source_properties]))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The $source_properties array contains invalid properties.')]), rt.new_string('6.5.0')])
		return rt.new_bool(false)
	}
	mut var_source := create_wp_block_bindings_source(rt.new_string(source_name).dup(), var_source_properties.dup())
	this.sources.array_set(source_name, var_source.dup())
	return rt.new_object('WP_Block_Bindings_Source', []string{}, var_source)
}

fn (mut this Class_WP_Block_Bindings_Registry) unregister(source_name string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(rt.new_string(source_name)))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Block binding "%s" not found.')]), rt.new_string(source_name)]), rt.new_string('6.5.0')])
		return false
	}
	mut var_unregistered_source := this.sources.array_get(source_name)
	this.sources.array_unset(rt.new_string(source_name))
	return (var_unregistered_source).to_bool()
}

fn (mut this Class_WP_Block_Bindings_Registry) get_all_registered() rt.PhpVal {
	return this.sources
}

fn (mut this Class_WP_Block_Bindings_Registry) get_registered(source_name string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(rt.new_string(source_name)))))) {
		return rt.new_null()
	}
	return this.sources.array_get(source_name)
}

fn (mut this Class_WP_Block_Bindings_Registry) is_registered(var_source_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!(var_source_name).is_null() && this.sources.array_isset(var_source_name))
}

fn (mut this Class_WP_Block_Bindings_Registry) magic_wakeup()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.sources)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.sources.is_array()))))) {
		rt.throw_exception(rt.new_object('UnexpectedValueException', []string{}, create_unexpectedvalueexception()))
	}
	{
		mut iter_1 := this.sources.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_value, 'WP_Block_Bindings_Source')))))) {
				rt.throw_exception(rt.new_object('UnexpectedValueException', []string{}, create_unexpectedvalueexception()))
			}
		}
	}
}

fn Class_WP_Block_Bindings_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_WP_Block_Bindings_Source {
	rt.PhpObjectBase
}

struct Class_UnexpectedValueException {
	rt.PhpObjectBase
}

fn create_wp_block_bindings_registry() &Class_WP_Block_Bindings_Registry {
	mut obj := &Class_WP_Block_Bindings_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		sources: rt.new_array()
		instance: rt.new_null()
		allowed_source_properties: rt.new_array()
	}
	return obj
}

fn create_wp_block_bindings_source() &Class_WP_Block_Bindings_Source {
	mut obj := &Class_WP_Block_Bindings_Source{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_unexpectedvalueexception() &Class_UnexpectedValueException {
	mut obj := &Class_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Bindings_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.register(dispatch_arg_0, mut dispatch_arg_1)
		}
		'unregister' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.unregister(dispatch_arg_0))
		}
		'get_all_registered' {
			return this.get_all_registered()
		}
		'get_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_registered(dispatch_arg_0)
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_registered(dispatch_arg_0)
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'get_instance' {
			return Class_WP_Block_Bindings_Registry.get_instance()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Bindings_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sources' { return this.sources }
		'instance' { return this.instance }
		'allowed_source_properties' { return this.allowed_source_properties }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Bindings_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sources' { this.sources = val; return true }
		'instance' { this.instance = val; return true }
		'allowed_source_properties' { this.allowed_source_properties = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Block_Bindings_Source) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Bindings_Source) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Bindings_Source) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_block_bindings_registry_php() {
}
