import rt

struct Class_SplFixedArray {
	rt.PhpObjectBase
pub mut:
		internalArray rt.PhpVal = rt.new_array()
		size rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_SplFixedArray) construct(size i64)  {
	this.size = rt.new_int(size).dup()
	this.internalArray = rt.new_array()
}

fn (mut this Class_SplFixedArray) count() i64 {
	return this.internalArray.array_count()
}

fn (mut this Class_SplFixedArray) toarray() rt.PhpVal {
	rt.call_function('ksort', [this.internalArray])
	return rt.cast_array(this.internalArray)
}

fn Class_SplFixedArray.fromarray(mut var_array Class_array, save_indexes bool) rt.PhpVal {
	mut var_self := create_splfixedarray(var_array.array_count())
	if var_save_indexes {
		{
			mut iter_1 := var_array.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				var_self.array_set(// unsupported expression: Expr_Cast_Int, var_value.dup())
			}
		}
	} else {
		mut var_i := rt.new_int(rt.new_int(0))
		{
			mut iter_1 := rt.call_function('array_values', [var_array]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				var_self.array_set(var_i, var_value.dup())
				rt.post_inc(var_i)
			}
		}
	}
	return var_self.dup()
}

fn (mut this Class_SplFixedArray) getsize() rt.PhpVal {
	return this.size
}

fn (mut this Class_SplFixedArray) setsize(var_size rt.PhpVal) bool {
	this.size = var_size.dup()
	return true
}

fn (mut this Class_SplFixedArray) offsetexists(var_index rt.PhpVal) bool {
	return this.internalArray.array_isset(// unsupported expression: Expr_Cast_Int)
}

fn (mut this Class_SplFixedArray) offsetget(var_index rt.PhpVal) rt.PhpVal {
	return this.internalArray.array_get(// unsupported expression: Expr_Cast_Int)
}

fn (mut this Class_SplFixedArray) offsetset(var_index rt.PhpVal, var_newval rt.PhpVal)  {
	this.internalArray.array_set(// unsupported expression: Expr_Cast_Int, var_newval.dup())
}

fn (mut this Class_SplFixedArray) offsetunset(var_index rt.PhpVal)  {
	this.internalArray.array_unset(// unsupported expression: Expr_Cast_Int)
}

fn (mut this Class_SplFixedArray) rewind()  {
	rt.call_function('reset', [this.internalArray])
}

fn (mut this Class_SplFixedArray) current() rt.PhpVal {
	return rt.call_function('current', [this.internalArray])
}

fn (mut this Class_SplFixedArray) key() rt.PhpVal {
	return rt.call_function('key', [this.internalArray])
}

fn (mut this Class_SplFixedArray) next()  {
	rt.call_function('next', [this.internalArray])
}

fn (mut this Class_SplFixedArray) valid() bool {
	if !rt.is_true(this.internalArray) {
		return false
	}
	mut var_result := // unsupported expression: Expr_BinaryOp_NotIdentical
	rt.call_function('prev', [this.internalArray])
	return (var_result).to_bool()
}

fn (mut this Class_SplFixedArray) magic_sleep() rt.PhpVal {
	return this.internalArray
}

fn (mut this Class_SplFixedArray) magic_wakeup()  {
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_SplFixedArray) magic_serialize() rt.PhpVal {
	return rt.call_function('array_values', [this.internalArray])
}

fn (mut this Class_SplFixedArray) magic_unserialize(mut var_data Class_array)  {
	mut var_length := rt.new_int(rt.new_int(var_data.array_count()))
	mut var_values := rt.call_function('array_values', [var_data])
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, var_length))) { break }
			this.internalArray.array_set(var_i, var_values.array_get(var_i))
			rt.pre_inc(var_i)
		}
	}
	this.size = var_length.dup()
}

fn create_splfixedarray(size i64) &Class_SplFixedArray {
	mut obj := &Class_SplFixedArray{
		PhpObjectBase: rt.PhpObjectBase{}
		internalArray: rt.new_array()
		size: rt.new_int(0)
	}
	obj.construct(size)
	return obj
}

fn (mut this Class_SplFixedArray) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'count' {
			return rt.new_int(this.count())
		}
		'toArray' {
			return this.toarray()
		}
		'fromArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_SplFixedArray.fromarray(mut dispatch_arg_0, dispatch_arg_1)
		}
		'getSize' {
			return this.getsize()
		}
		'setSize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.setsize(dispatch_arg_0))
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'rewind' {
			this.rewind()
			return rt.new_null()
		}
		'current' {
			return this.current()
		}
		'key' {
			return this.key()
		}
		'next' {
			this.next()
			return rt.new_null()
		}
		'valid' {
			return rt.new_bool(this.valid())
		}
		'__sleep' {
			return this.magic_sleep()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__serialize' {
			return this.magic_serialize()
		}
		'__unserialize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.magic_unserialize(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_SplFixedArray) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internalArray' { return this.internalArray }
		'size' { return this.size }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SplFixedArray) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internalArray' { this.internalArray = val; return true }
		'size' { this.size = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_sodium_compat_src_php52_splfixedarray_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('SplFixedArray')])) {
		return rt.new_null()
	}
}
