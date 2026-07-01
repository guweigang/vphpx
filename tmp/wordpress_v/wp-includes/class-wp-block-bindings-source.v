import rt

struct Class_WP_Block_Bindings_Source {
	rt.PhpObjectBase
pub mut:
	name               string
	label              rt.PhpVal = rt.new_null()
	get_value_callback rt.PhpVal = rt.new_null()
	uses_context       rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Bindings_Source) construct(name string, mut var_source_properties Class_array) {
	this.name = name
	{
		mut iter_1 := var_source_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property_value := item_1.val
			mut var_property_name := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":68,"name":"property_name"}',
				var_property_value.dup())
		}
	}
}

fn (mut this Class_WP_Block_Bindings_Source) get_value(mut var_source_args Class_array, var_block_instance rt.PhpVal, attribute_name string) rt.PhpVal {
	mut var_value := rt.call_function('call_user_func_array', [this.get_value_callback,
		rt.create_array([rt.ArrayItem{ key: none, val: var_source_args },
			rt.ArrayItem{ key: none, val: var_block_instance },
			rt.ArrayItem{ key: none, val: attribute_name }])])
	return rt.call_function('apply_filters', [
		rt.new_string('block_bindings_source_value'),
		var_value.dup(),
		this.name,
		var_source_args,
		var_block_instance.dup(),
		rt.new_string(attribute_name),
	])
}

fn (mut this Class_WP_Block_Bindings_Source) magic_wakeup() {
	rt.throw_exception(rt.new_object('LogicException', []string{}, create_logicexception(@STRUCT +
		' should never be unserialized')))
}

struct Class_LogicException {
	rt.PhpObjectBase
}

fn create_wp_block_bindings_source(name string, arg_1 rt.PhpVal) &Class_WP_Block_Bindings_Source {
	mut obj := &Class_WP_Block_Bindings_Source{
		PhpObjectBase:      rt.PhpObjectBase{}
		name:               ''
		label:              rt.new_null()
		get_value_callback: rt.new_null()
		uses_context:       rt.new_null()
	}
	obj.construct(name, arg_1)
	return obj
}

fn create_logicexception() &Class_LogicException {
	mut obj := &Class_LogicException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Bindings_Source) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_value(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Block_Bindings_Source) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return rt.new_string(this.name) }
		'label' { return this.label }
		'get_value_callback' { return this.get_value_callback }
		'uses_context' { return this.uses_context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Bindings_Source) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val.str()
			return true
		}
		'label' {
			this.label = val
			return true
		}
		'get_value_callback' {
			this.get_value_callback = val
			return true
		}
		'uses_context' {
			this.uses_context = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_LogicException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_LogicException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_LogicException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_class_wp_block_bindings_source_php() {
}
