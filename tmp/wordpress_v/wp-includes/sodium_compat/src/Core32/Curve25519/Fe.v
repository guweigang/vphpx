import rt

struct Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	rt.PhpObjectBase
pub mut:
		container rt.PhpVal = rt.new_array()
		size rt.PhpVal = rt.new_int(10)
}

fn Class_ParagonIE_Sodium_Core32_Curve25519_Fe.fromarray(var_array rt.PhpVal, var_save_indexes rt.PhpVal) rt.PhpVal {
	mut var_array_mutated := var_array
	mut var_count := rt.new_int(rt.new_int(var_array_mutated.dup().array_count()))
	if rt.is_true(var_save_indexes) {
		mut var_keys := rt.func_array_keys(var_array_mutated.dup())
	} else {
		var_keys = rt.call_function('range', [rt.new_int(0), rt.sub(var_count, rt.new_int(1))])
	}
	var_array_mutated = rt.call_function('array_values', [var_array_mutated.dup()])
	mut var_obj := create_paragonie_sodium_core32_curve25519_fe()
	if rt.is_true(var_save_indexes) {
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_count))) { break }
				rt.set_property(var_array_mutated.array_get(var_i), 'overflow', rt.new_int(0))
				var_obj.offsetset(var_keys.array_get(var_i), var_array_mutated.array_get(var_i))
				rt.pre_inc(var_i)
			}
		}
	} else {
		{
			var_i = rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_count))) { break }
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_array_mutated.array_get(var_i), 'ParagonIE_Sodium_Core32_Int32')))))) {
					rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Expected ParagonIE_Sodium_Core32_Int32'))))
				}
				rt.set_property(var_array_mutated.array_get(var_i), 'overflow', rt.new_int(0))
				var_obj.offsetset(var_i.dup(), var_array_mutated.array_get(var_i))
				rt.pre_inc(var_i)
			}
		}
	}
	return mut var_obj
}

fn Class_ParagonIE_Sodium_Core32_Curve25519_Fe.fromintarray(var_array rt.PhpVal, var_save_indexes rt.PhpVal) rt.PhpVal {
	mut var_array_mutated := var_array
	mut var_count := rt.new_int(rt.new_int(var_array_mutated.dup().array_count()))
	if rt.is_true(var_save_indexes) {
		mut var_keys := rt.func_array_keys(var_array_mutated.dup())
	} else {
		var_keys = rt.call_function('range', [rt.new_int(0), rt.sub(var_count, rt.new_int(1))])
	}
	var_array_mutated = rt.call_function('array_values', [var_array_mutated.dup()])
	mut var_set := rt.new_array()
	{
		mut iter_1 := var_array_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_v := item_1.val
			mut var_i := item_1.key
			var_set.array_set(var_i, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Int32{}; return temp.fromint(arg_0) }(var_v.dup()))
		}
	}
	mut var_obj := create_paragonie_sodium_core32_curve25519_fe()
	if rt.is_true(var_save_indexes) {
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_count))) { break }
				rt.set_property(var_set.array_get(var_i), 'overflow', rt.new_int(0))
				var_obj.offsetset(var_keys.array_get(var_i), var_set.array_get(var_i))
				rt.pre_inc(var_i)
			}
		}
	} else {
		{
			var_i = rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_count))) { break }
				rt.set_property(var_set.array_get(var_i), 'overflow', rt.new_int(0))
				var_obj.offsetset(var_i.dup(), var_set.array_get(var_i))
				rt.pre_inc(var_i)
			}
		}
	}
	return mut var_obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_value, 'ParagonIE_Sodium_Core32_Int32')))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Expected an instance of ParagonIE_Sodium_Core32_Int32'))))
	}
	if rt.is_true(rt.new_bool(var_offset.dup().is_null())) {
		this.container.array_push(var_value.dup())
	} else {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Core32_Util{}; return temp.declarescalartype(arg_0, arg_1, arg_2) }(var_offset.dup(), rt.new_string('int'), rt.new_int(1))
		this.container.array_set(// unsupported expression: Expr_Cast_Int, var_value.dup())
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.container.array_isset(var_offset))
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) offsetunset(var_offset rt.PhpVal)  {
	this.container.array_unset(var_offset)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	if !(this.container.array_isset(var_offset)) {
		this.container.array_set(// unsupported expression: Expr_Cast_Int, create_paragonie_sodium_core32_int32())
	}
	mut var_get := this.container.array_get(var_offset)
	return var_get.dup()
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) magic_debuginfo() rt.PhpVal {
	if !rt.is_true(this.container) {
		return rt.new_array()
	}
	mut var_c := [// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int]
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('implode', [rt.new_string(', '), var_c.dup()]) }])
}

struct Class_TypeError {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Int32 {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_core32_curve25519_fe() &Class_ParagonIE_Sodium_Core32_Curve25519_Fe {
	mut obj := &Class_ParagonIE_Sodium_Core32_Curve25519_Fe{
		PhpObjectBase: rt.PhpObjectBase{}
		container: rt.new_array()
		size: rt.new_int(10)
	}
	return obj
}

fn create_typeerror() &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_int32() &Class_ParagonIE_Sodium_Core32_Int32 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Int32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_util() &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fromArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519_Fe.fromarray(dispatch_arg_0, dispatch_arg_1)
		}
		'fromIntArray' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_Core32_Curve25519_Fe.fromintarray(dispatch_arg_0, dispatch_arg_1)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'__debugInfo' {
			return this.magic_debuginfo()
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		'size' { return this.size }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ParagonIE_Sodium_Core32_Curve25519_Fe) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' { this.container = val; return true }
		'size' { this.size = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Int32) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Int32) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_core32_curve25519_fe_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_Core32_Curve25519_Fe'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}
