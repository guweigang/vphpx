import rt

struct Class_SimplePie_Registry {
	rt.PhpObjectBase
pub mut:
	default     rt.PhpVal = rt.new_array()
	classes     rt.PhpVal = rt.new_array()
	legacy      rt.PhpVal = rt.new_array()
	legacyTypes rt.PhpVal = rt.new_array()
}

fn (mut this Class_SimplePie_Registry) construct() {
}

fn (mut this Class_SimplePie_Registry) register(type string, var_class rt.PhpVal, legacy bool) bool {
	mut type_mutated := type
	mut var_class_mutated := var_class
	if rt.is_true(rt.new_bool(this.legacyTypes.array_isset(rt.new_string(type_mutated).clone()))) {
		type_mutated = (this.legacyTypes.array_get(rt.new_string(type_mutated))).str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.default.array_isset(rt.new_string(type_mutated).clone())))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		var_class_mutated.clone()])))))
	{
		return false
	}
	mut var_base_class := this.default.array_get(rt.new_string(type_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_subclass_of', [
		var_class_mutated.clone(),
		var_base_class.clone(),
	])))))
	{
		return false
	}
	this.classes.array_set(type_mutated, var_class_mutated.clone())
	if var_legacy {
		this.legacy.array_push(var_class_mutated.clone())
	}
	return true
}

fn (mut this Class_SimplePie_Registry) get_class(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	if rt.is_true(rt.new_bool(this.legacyTypes.array_isset(var_type_mutated.clone()))) {
		var_type_mutated = this.legacyTypes.array_get(var_type_mutated)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.default.array_isset(var_type_mutated.clone())))))) {
		return rt.new_null()
	}
	mut var_class := this.default.array_get(var_type_mutated)
	if rt.is_true(rt.new_bool(this.classes.array_isset(var_type_mutated.clone()))) {
		var_class = this.classes.array_get(var_type_mutated)
	}
	return var_class.clone()
}

fn (mut this Class_SimplePie_Registry) create(var_type rt.PhpVal, mut var_parameters Class_SimplePie_array) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_class := this.get_class(var_type_mutated.clone())
	if rt.is_true(rt.identical(var_class, rt.new_null())) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('%s(): Argument #1 ($type) "%s" not found in class list.'),
			rt.new_string(@METHOD),
			var_type_mutated.clone(),
		]), rt.new_int(1))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [
		var_class.clone(), rt.new_string('__construct')])))))
	{
		mut var_instance := rt.create_object_dynamically(var_class, []rt.PhpVal{})
	} else {
		mut var_reflector := create_simplepie_reflectionclass(var_class.clone())
		var_instance = var_reflector.newinstanceargs(rt.new_object('SimplePie_array', []string{},
			var_parameters))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_instance, 'SimplePie_RegistryAware'))) {
		rt.call_method(var_instance, 'set_registry', [
			rt.new_object('SimplePie_Registry', []string{}, &this),
		])
	} else if rt.is_true(rt.call_function('method_exists', [var_instance.clone(),
		rt.new_string('set_registry')]))
	{
		rt.call_function('trigger_error', [
			rt.call_function('sprintf', [
				rt.new_string('Using the method "set_registry()" without implementing "%s" is deprecated since SimplePie 1.8.0, implement "%s" in "%s".'),
				Class_SimplePie_RegistryAware.class(),
				Class_SimplePie_RegistryAware.class(),
				var_class.clone(),
			]),
			rt.get_constant('E_USER_DEPRECATED'),
		])
		rt.call_method(var_instance, 'set_registry', [
			rt.new_object('SimplePie_Registry', []string{}, &this),
		])
	}
	return var_instance.clone()
}

fn (mut this Class_SimplePie_Registry) call(var_type rt.PhpVal, method string, mut var_parameters Class_SimplePie_array) rt.PhpVal {
	mut var_type_mutated := var_type
	mut var_class := this.get_class(var_type_mutated.clone())
	if rt.is_true(rt.identical(var_class, rt.new_null())) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('%s(): Argument #1 ($type) "%s" not found in class list.'),
			rt.new_string(@METHOD),
			var_type_mutated.clone(),
		]), rt.new_int(1))))
	}
	if rt.is_true(rt.call_function('in_array', [var_class.clone(), this.legacy])) {
		mut switch_val_1 := var_type_mutated
		if rt.is_true(rt.equal(switch_val_1, Class_SimplePie_Cache.class())) {
			if rt.is_true(rt.identical(rt.new_string(method), rt.new_string('get_handler'))) {
				mut var_result := rt.call_function('call_user_func_array', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_class },
						rt.ArrayItem{ key: none, val: 'create' }]),
					var_parameters,
				])
				return var_result.clone()
			}
		}
	}
	mut var_callable := rt.create_array([rt.ArrayItem{ key: none, val: var_class },
		rt.ArrayItem{ key: none, val: method }])
	rt.call_function('assert', [rt.call_function('is_callable', [
		var_callable.clone()]),
		rt.new_string('For PHPstan')])
	var_result = rt.call_function('call_user_func_array', [var_callable.clone(), var_parameters])
	return var_result.clone()
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_SimplePie_ReflectionClass {
	rt.PhpObjectBase
}

fn create_simplepie_registry() &Class_SimplePie_Registry {
	mut obj := &Class_SimplePie_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		default:       rt.new_array()
		classes:       rt.new_array()
		legacy:        rt.new_array()
		legacyTypes:   rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_reflectionclass(_args ...rt.PhpVal) &Class_SimplePie_ReflectionClass {
	mut obj := &Class_SimplePie_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.register(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_class(dispatch_arg_0)
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.create(dispatch_arg_0, mut dispatch_arg_1)
		}
		'call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.call(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'default' { return this.default }
		'classes' { return this.classes }
		'legacy' { return this.legacy }
		'legacyTypes' { return this.legacyTypes }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'default' {
			this.default = val
			return true
		}
		'classes' {
			this.classes = val
			return true
		}
		'legacy' {
			this.legacy = val
			return true
		}
		'legacyTypes' {
			this.legacyTypes = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('SimplePie_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_simplepie_registry()
		return rt.new_object('SimplePie_Registry', []string{}, obj)
	})
	rt.register_class_factory('InvalidArgumentException', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_invalidargumentexception()
		return rt.new_object('InvalidArgumentException', []string{}, obj)
	})
	rt.register_class_factory('SimplePie_ReflectionClass', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_simplepie_reflectionclass()
		return rt.new_object('SimplePie_ReflectionClass', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Registry'),
		rt.new_string('SimplePie_Registry')])
}
