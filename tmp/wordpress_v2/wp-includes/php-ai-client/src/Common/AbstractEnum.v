import rt

struct Class_WordPress_AiClient_Common_AbstractEnum {
	rt.PhpObjectBase
pub mut:
	value string
	name  string
}

fn init_static_wordpress_aiclient_common_abstractenum() {
	rt.init_static_prop('WordPress_AiClient_Common_AbstractEnum', 'cache', rt.new_array())
	rt.init_static_prop('WordPress_AiClient_Common_AbstractEnum', 'instances', rt.new_array())
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) construct(value string, name string) {
	this.value = value
	this.name = name
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) magic_get(property string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(property), rt.new_string('value')))
		|| rt.is_true(rt.identical(rt.new_string(property), rt.new_string('name'))) {
		return rt.get_property(rt.new_object('WordPress_AiClient_Common_AbstractEnum', [
			'JsonSerializable',
		], &this), '{"nodeType":"Expr_Variable","line":81,"name":"property"}')
	}
	rt.throw_exception(rt.new_object('BadMethodCallException', []string{}, create_badmethodcallexception(rt.call_function('sprintf', [
		rt.new_string('Property %s::%s does not exist'),
		Class_WordPress_AiClient_Common_static.class(),
		rt.new_string(property),
	]))))
	return rt.new_null()
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) magic_set(property string, var_value rt.PhpVal) {
	rt.throw_exception(rt.new_object('BadMethodCallException', []string{}, create_badmethodcallexception(rt.call_function('sprintf', [
		rt.new_string('Cannot modify property %s::%s - enum properties are read-only'),
		Class_WordPress_AiClient_Common_static.class(),
		rt.new_string(property),
	]))))
}

fn Class_WordPress_AiClient_Common_AbstractEnum.from(value string) rt.PhpVal {
	mut var_instance := Class_WordPress_AiClient_Common_AbstractEnum.tryfrom(value)
	if rt.is_true(rt.identical(var_instance, rt.new_null())) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('%s is not a valid backing value for enum %s'),
			rt.new_string(value),
			Class_WordPress_AiClient_Common_static.class(),
		]))))
	}
	return var_instance.clone()
}

fn Class_WordPress_AiClient_Common_AbstractEnum.tryfrom(value string) rt.PhpVal {
	mut var_constants := Class_WordPress_AiClient_Common_AbstractEnum.getconstants()
	mut iter_1 := var_constants.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_constantValue := item_1.val
		mut var_name := item_1.key
		if rt.is_true(rt.identical(var_constantValue, rt.new_string(value))) {
			return Class_WordPress_AiClient_Common_AbstractEnum.getinstance(var_constantValue.str(),
				var_name.str())
		}
	}
	return rt.new_null()
}

fn Class_WordPress_AiClient_Common_AbstractEnum.cases() rt.PhpVal {
	mut var_cases := rt.new_array()
	mut var_constants := Class_WordPress_AiClient_Common_AbstractEnum.getconstants()
	mut iter_2 := var_constants.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_name := item_2.key
		var_cases.array_push(Class_WordPress_AiClient_Common_AbstractEnum.getinstance(var_value.str(),
			var_name.str()))
	}
	return var_cases.clone()
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) equals(var_other rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(var_other, 'WordPress_AiClient_Common_self'))) {
		return this.is(mut rt.cast_object_ptr[Class_WordPress_AiClient_Common_self](var_other))
	}
	return (rt.identical(this.value, var_other)).to_bool()
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) is(mut var_other Class_WordPress_AiClient_Common_self) bool {
	return (rt.identical(rt.new_object('WordPress_AiClient_Common_AbstractEnum', [
		'JsonSerializable',
	], &this), var_other)).to_bool()
	return false
}

fn Class_WordPress_AiClient_Common_AbstractEnum.getvalues() rt.PhpVal {
	return rt.call_function('array_values', [
		Class_WordPress_AiClient_Common_AbstractEnum.getconstants(),
	])
}

fn Class_WordPress_AiClient_Common_AbstractEnum.isvalidvalue(value string) bool {
	return (rt.call_function('in_array', [rt.new_string(value),
		Class_WordPress_AiClient_Common_AbstractEnum.getvalues(),
		rt.new_bool(true)])).to_bool()
}

fn Class_WordPress_AiClient_Common_AbstractEnum.getinstance(value string, name string) rt.PhpVal {
	mut var_className := Class_WordPress_AiClient_Common_static.class()
	if !(rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'instances').array_isset(var_className)) {
		rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'instances').array_set(var_className,
			rt.new_array())
	}
	if !(rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'instances').array_get(var_className).array_isset(rt.new_string(name))) {
		mut var_instance := rt.create_object_dynamically(var_className, [
			rt.new_string(value),
			rt.new_string(name),
		])
		rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'instances').array_get_mut(var_className).array_set(name,
			var_instance.clone())
	}
	return rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'instances').array_get(var_className).array_get(rt.new_string(name))
}

fn Class_WordPress_AiClient_Common_AbstractEnum.getconstants() rt.PhpVal {
	mut var_className := Class_WordPress_AiClient_Common_static.class()
	if !(rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'cache').array_isset(var_className)) {
		rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'cache').array_set(var_className,
			Class_WordPress_AiClient_Common_AbstractEnum.determineclassenumerations(var_className.str()))
	}
	return rt.get_static_prop('WordPress_AiClient_Common_AbstractEnum', 'cache').array_get(var_className)
}

fn Class_WordPress_AiClient_Common_AbstractEnum.determineclassenumerations(className string) rt.PhpVal {
	mut className_mutated := className
	mut var_reflection := create_reflectionclass(rt.new_string(className_mutated).clone())
	mut var_constants := var_reflection.getconstants()
	mut var_enumConstants := rt.new_array()
	mut iter_3 := var_constants.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_name := item_3.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^[A-Z][A-Z0-9_]*$/'),
			var_name.clone(),
		])))))
		{
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
				[]string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [
				rt.new_string('Invalid enum constant name "%s" in %s. Constants must be UPPER_SNAKE_CASE.'),
				var_name.clone(),
				rt.new_string(className_mutated).clone(),
			]))))
		}
		if !(var_value.clone().is_string()) {
			rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException',
				[]string{}, create_wordpress_aiclient_common_exception_runtimeexception(rt.call_function('sprintf', [
				rt.new_string('Invalid enum value type for constant %s::%s. ' +
					'Only string values are allowed, %s given.'),
				rt.new_string(className_mutated).clone(),
				var_name.clone(),
				rt.call_function('gettype', [var_value.clone()]),
			]))))
		}
		var_enumConstants.array_set(var_name, var_value.clone())
	}
	return var_enumConstants.clone()
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) magic_call(name string, mut var_arguments Class_WordPress_AiClient_Common_array) bool {
	if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(name),
		rt.new_string('is')]))
	{
		mut var_constantName := Class_WordPress_AiClient_Common_AbstractEnum.camelcasetoconstant((rt.call_function('substr', [
			rt.new_string(name),
			rt.new_int(2),
		])).str())
		mut var_constants := Class_WordPress_AiClient_Common_AbstractEnum.getconstants()
		if var_constants.array_isset(var_constantName) {
			return (rt.identical(this.value, var_constants.array_get(var_constantName))).to_bool()
		}
	}
	rt.throw_exception(rt.new_object('BadMethodCallException', []string{}, create_badmethodcallexception(rt.call_function('sprintf', [
		rt.new_string('Method %s::%s does not exist'),
		Class_WordPress_AiClient_Common_static.class(),
		rt.new_string(name),
	]))))
	return false
}

fn Class_WordPress_AiClient_Common_AbstractEnum.magic_callstatic(name string, mut var_arguments Class_WordPress_AiClient_Common_array) rt.PhpVal {
	mut var_constantName := Class_WordPress_AiClient_Common_AbstractEnum.camelcasetoconstant(name)
	mut var_constants := Class_WordPress_AiClient_Common_AbstractEnum.getconstants()
	if var_constants.array_isset(var_constantName) {
		return Class_WordPress_AiClient_Common_AbstractEnum.getinstance((var_constants.array_get(var_constantName)).str(),
			var_constantName.str())
	}
	rt.throw_exception(rt.new_object('BadMethodCallException', []string{}, create_badmethodcallexception(rt.call_function('sprintf', [
		rt.new_string('Method %s::%s does not exist'),
		Class_WordPress_AiClient_Common_static.class(),
		rt.new_string(name),
	]))))
	return rt.new_null()
}

fn Class_WordPress_AiClient_Common_AbstractEnum.camelcasetoconstant(camelCase string) string {
	mut var_snakeCase := rt.call_function('preg_replace', [
		rt.new_string('/([a-z])([A-Z])/'),
		rt.new_string('$1_$2'),
		rt.new_string(camelCase),
	])
	if rt.is_true(rt.identical(var_snakeCase, rt.new_null())) {
		return camelCase.to_upper()
	}
	return var_snakeCase.clone().to_string().to_upper()
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) magic_tostring() string {
	return this.value
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) jsonserialize() string {
	return this.value
}

struct Class_BadMethodCallException {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_ReflectionClass {
	rt.PhpObjectBase
}

struct Class_WordPress_AiClient_Common_Exception_RuntimeException {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_common_abstractenum(value string, name string) &Class_WordPress_AiClient_Common_AbstractEnum {
	mut obj := &Class_WordPress_AiClient_Common_AbstractEnum{
		PhpObjectBase: rt.PhpObjectBase{}
		value:         ''
		name:          ''
	}
	obj.construct(value, name)
	return obj
}

fn create_badmethodcallexception(_args ...rt.PhpVal) &Class_BadMethodCallException {
	mut obj := &Class_BadMethodCallException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_reflectionclass(_args ...rt.PhpVal) &Class_ReflectionClass {
	mut obj := &Class_ReflectionClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_runtimeexception(_args ...rt.PhpVal) &Class_WordPress_AiClient_Common_Exception_RuntimeException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'from' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Common_AbstractEnum.from(dispatch_arg_0)
		}
		'tryFrom' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Common_AbstractEnum.tryfrom(dispatch_arg_0)
		}
		'cases' {
			return Class_WordPress_AiClient_Common_AbstractEnum.cases()
		}
		'equals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.equals(dispatch_arg_0))
		}
		'is' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_self](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is(mut dispatch_arg_0))
		}
		'getValues' {
			return Class_WordPress_AiClient_Common_AbstractEnum.getvalues()
		}
		'isValidValue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WordPress_AiClient_Common_AbstractEnum.isvalidvalue(dispatch_arg_0))
		}
		'getInstance' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Common_AbstractEnum.getinstance(dispatch_arg_0,
				dispatch_arg_1)
		}
		'getConstants' {
			return Class_WordPress_AiClient_Common_AbstractEnum.getconstants()
		}
		'determineClassEnumerations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WordPress_AiClient_Common_AbstractEnum.determineclassenumerations(dispatch_arg_0)
		}
		'__call' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.magic_call(dispatch_arg_0, mut dispatch_arg_1))
		}
		'__callStatic' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WordPress_AiClient_Common_AbstractEnum.magic_callstatic(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'camelCaseToConstant' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WordPress_AiClient_Common_AbstractEnum.camelcasetoconstant(dispatch_arg_0))
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'jsonSerialize' {
			return rt.new_string(this.jsonserialize())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Common_AbstractEnum) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'value' { return rt.new_string(this.value) }
		'name' { return rt.new_string(this.name) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WordPress_AiClient_Common_AbstractEnum) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'value' {
			this.value = val.str()
			return true
		}
		'name' {
			this.name = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_BadMethodCallException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_BadMethodCallException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_BadMethodCallException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ReflectionClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ReflectionClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ReflectionClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WordPress_AiClient_Common_AbstractEnum', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		c_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		obj := create_wordpress_aiclient_common_abstractenum(c_arg_0, c_arg_1)
		return rt.new_object('WordPress_AiClient_Common_AbstractEnum', [
			'JsonSerializable',
		], obj)
	})
	rt.register_class_factory('BadMethodCallException', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_badmethodcallexception()
		return rt.new_object('BadMethodCallException', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClient_Common_Exception_InvalidArgumentException', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclient_common_exception_invalidargumentexception()
		return rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{}, obj)
	})
	rt.register_class_factory('ReflectionClass', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_reflectionclass()
		return rt.new_object('ReflectionClass', []string{}, obj)
	})
	rt.register_class_factory('WordPress_AiClient_Common_Exception_RuntimeException', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wordpress_aiclient_common_exception_runtimeexception()
		return rt.new_object('WordPress_AiClient_Common_Exception_RuntimeException', []string{},
			obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
