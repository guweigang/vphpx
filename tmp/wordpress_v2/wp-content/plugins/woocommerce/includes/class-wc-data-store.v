import rt

struct Class_WC_Data_Store {
	rt.PhpObjectBase
pub mut:
	instance           rt.PhpVal = rt.new_null()
	stores             rt.PhpVal = rt.new_array()
	current_class_name rt.PhpVal = rt.new_string('')
	object_type        rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Data_Store) construct(var_object_type rt.PhpVal) {
	mut var_object_type_mutated := var_object_type
	this.object_type = var_object_type_mutated.clone()
	this.stores = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_data_stores'),
		this.stores,
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.stores.array_isset(var_object_type_mutated.clone())))))) {
		mut var_pieces := rt.call_function('explode', [rt.new_string('-'),
			var_object_type_mutated.clone()])
		var_object_type_mutated = var_pieces.array_get(rt.new_int(0))
	}
	if rt.is_true(rt.new_bool(this.stores.array_isset(var_object_type_mutated.clone()))) {
		mut var_store := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_' + var_object_type_mutated.str() + '_data_store'),
			this.stores.array_get(var_object_type_mutated),
		])
		if rt.is_true(rt.new_bool(var_store.clone().is_object())) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_store,
				'WC_Object_Data_Store_Interface'))))))
			{
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
					rt.new_string('Invalid data store.'),
					rt.new_string('woocommerce'),
				]))))
			}
			this.current_class_name = rt.call_function('get_class', [
				var_store.clone()])
			this.instance = var_store.clone()
		} else {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
				var_store.clone(),
			])))))
			{
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
					rt.new_string('Invalid data store.'),
					rt.new_string('woocommerce'),
				]))))
			}
			this.current_class_name = var_store.clone()
			this.instance = rt.create_object_dynamically(var_store, []rt.PhpVal{})
		}
	} else {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid data store.'),
			rt.new_string('woocommerce'),
		]))))
	}
}

fn (mut this Class_WC_Data_Store) magic_sleep() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'object_type' }])
}

fn (mut this Class_WC_Data_Store) magic_wakeup() {
	this.construct(this.object_type)
}

fn Class_WC_Data_Store.load(var_object_type rt.PhpVal) rt.PhpVal {
	mut var_object_type_mutated := var_object_type
	return rt.new_object('WC_Data_Store', []string{},
		create_wc_data_store(var_object_type_mutated.clone()))
}

fn (mut this Class_WC_Data_Store) get_current_class_name() rt.PhpVal {
	return this.current_class_name
}

fn (mut this Class_WC_Data_Store) read(var_data rt.PhpVal) {
	rt.call_method(this.instance, 'read', [var_data.clone()])
}

fn (mut this Class_WC_Data_Store) read_multiple(var_objects rt.PhpVal) {
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.instance },
			rt.ArrayItem{ key: none, val: 'read_multiple' }]),
	]))
	{
		rt.call_method(this.instance, 'read_multiple', [var_objects.clone()])
	} else {
		mut iter_1 := var_objects.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_obj := item_1.val
			this.read(var_obj.clone())
		}
	}
}

fn (mut this Class_WC_Data_Store) create(var_data rt.PhpVal) {
	rt.call_method(this.instance, 'create', [var_data.clone()])
}

fn (mut this Class_WC_Data_Store) update(var_data rt.PhpVal) {
	rt.call_method(this.instance, 'update', [var_data.clone()])
}

fn (mut this Class_WC_Data_Store) delete(var_data rt.PhpVal, var_args rt.PhpVal) {
	rt.call_method(this.instance, 'delete', [var_data.clone(),
		var_args.clone()])
}

fn (mut this Class_WC_Data_Store) magic_call(var_method rt.PhpVal, var_parameters rt.PhpVal) rt.PhpVal {
	mut var_parameters_mutated := var_parameters
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.instance },
			rt.ArrayItem{ key: none, val: var_method }]),
	]))
	{
		mut var_object := rt.call_function('array_shift', [var_parameters_mutated.clone()])
		var_parameters_mutated = rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_object }]),
			var_parameters_mutated.clone(),
		])
		return rt.call_method(this.instance, var_method, [var_parameters_mutated.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Data_Store) has_callable(method string) bool {
	return (rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.instance },
			rt.ArrayItem{ key: none, val: method }]),
	])).to_bool()
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

fn create_wc_data_store(arg_0 rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase:      rt.PhpObjectBase{}
		instance:           rt.new_null()
		stores:             rt.new_array()
		current_class_name: rt.new_string('')
		object_type:        rt.new_string('')
	}
	obj.construct(arg_0)
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

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__sleep' {
			return this.magic_sleep()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'load' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Data_Store.load(dispatch_arg_0)
		}
		'get_current_class_name' {
			return this.get_current_class_name()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'read_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_multiple(dispatch_arg_0)
			return rt.new_null()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.magic_call(dispatch_arg_0, dispatch_arg_1)
		}
		'has_callable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_callable(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'stores' { return this.stores }
		'current_class_name' { return this.current_class_name }
		'object_type' { return this.object_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' {
			this.instance = val
			return true
		}
		'stores' {
			this.stores = val
			return true
		}
		'current_class_name' {
			this.current_class_name = val
			return true
		}
		'object_type' {
			this.object_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn init_registry() {
	rt.register_class_factory('WC_Data_Store', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_wc_data_store(c_arg_0)
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
