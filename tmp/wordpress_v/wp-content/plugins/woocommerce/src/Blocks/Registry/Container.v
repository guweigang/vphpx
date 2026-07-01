import rt

struct Class_Automattic_WooCommerce_Blocks_Registry_Container {
	rt.PhpObjectBase
pub mut:
	registry rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) factory(mut var_instantiation_callback Class_Closure) rt.PhpVal {
	return create_automattic_woocommerce_blocks_registry_factorytype(var_instantiation_callback.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) register(var_id rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	if !rt.is_true(this.registry.array_get(var_id)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Blocks_Registry_SharedType',
			[]string{}, var_value_mutated), 'Automattic_WooCommerce_Blocks_Registry_FactoryType'))))))
		{
			var_value_mutated =
				create_automattic_woocommerce_blocks_registry_sharedtype(var_value_mutated.dup())
		}
		this.registry.array_set(var_id, var_value_mutated.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) get(var_id rt.PhpVal) rt.PhpVal {
	if !(this.registry.array_isset(var_id)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.new_string('Cannot construct an instance of %s because it has not been registered.'),
			var_id.dup(),
		]))))
	}
	return rt.call_method(this.registry.array_get(var_id), 'get', [
		rt.new_object('Automattic_WooCommerce_Blocks_Registry_Container', []string{}, &this),
	])
}

struct Class_Automattic_WooCommerce_Blocks_Registry_FactoryType {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Registry_SharedType {
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

fn create_automattic_woocommerce_blocks_registry_container() &Class_Automattic_WooCommerce_Blocks_Registry_Container {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_Container{
		PhpObjectBase: rt.PhpObjectBase{}
		registry:      rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_registry_factorytype() &Class_Automattic_WooCommerce_Blocks_Registry_FactoryType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_FactoryType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_registry_sharedtype() &Class_Automattic_WooCommerce_Blocks_Registry_SharedType {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Registry_SharedType{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'factory' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Closure](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.factory(mut dispatch_arg_0)
		}
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.register(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registry' { return this.registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registry' {
			this.registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_FactoryType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_FactoryType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_FactoryType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_SharedType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Registry_SharedType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Registry_SharedType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_registry_container_php() {
}
