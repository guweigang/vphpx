import rt

struct Class_IXR_Value {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Value) construct(var_data rt.PhpVal, type bool)  {
	mut type_mutated := type
	this.data = var_data.dup()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(type_mutated))))) {
		type_mutated = this.calculatetype()
	}
	this.prop_type = rt.new_bool(type_mutated).dup()
	if rt.is_true(rt.equal(rt.new_bool(type_mutated), rt.new_string('struct'))) {
		{
			mut iter_1 := this.data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				this.data.array_set(var_key, create_ixr_value(var_value, false))
			}
		}
	}
	if rt.is_true(rt.equal(rt.new_bool(type_mutated), rt.new_string('array'))) {
		{
			mut var_i := rt.new_int(rt.new_int(0))
			mut var_j := rt.new_int(rt.new_int(this.data.array_count()))
			for {
				if !(rt.is_true(rt.less(var_i, var_j))) { break }
				this.data.array_set(var_i, create_ixr_value(this.data.array_get(var_i), false))
				rt.post_inc(var_i)
			}
		}
	}
}

fn (mut this Class_IXR_Value) ixr_value(var_data rt.PhpVal, type bool)  {
	mut type_mutated := type
	fn (arg_0 bool, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_IXR_Value{}; temp.construct(arg_0, arg_1); return rt.new_null() }((var_data).to_bool(), rt.new_bool(type_mutated))
}

fn (mut this Class_IXR_Value) calculatetype() string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.data, rt.new_bool(true))) || rt.is_true(rt.identical(this.data, rt.new_bool(false))))) {
		return 'boolean'
	}
	if rt.is_true(rt.new_bool(this.data.is_long())) {
		return 'int'
	}
	if rt.is_true(rt.new_bool(this.data.is_double())) {
		return 'double'
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.data.is_object())) && rt.is_true(rt.call_function('is_a', [this.data, rt.new_string('IXR_Date')])))) {
		return 'date'
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.data.is_object())) && rt.is_true(rt.call_function('is_a', [this.data, rt.new_string('IXR_Base64')])))) {
		return 'base64'
	}
	if rt.is_true(rt.new_bool(this.data.is_object())) {
		this.data = rt.call_function('get_object_vars', [this.data])
		return 'struct'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.data.is_array()))))) {
		return 'string'
	}
	if this.isstruct(this.data) {
		return 'struct'
	} else {
		return 'array'
	}
	return ''
}

fn (mut this Class_IXR_Value) getxml() bool {
	mut switch_val_1 := this.prop_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean'))) {
		return '<boolean>' + if rt.is_true(this.data) { '1' } else { '0' } + '</boolean>'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('int'))) {
		return '<int>' + (this.data).str() + '</int>'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('double'))) {
		return '<double>' + (this.data).str() + '</double>'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('string'))) {
		return '<string>' + (rt.call_function('htmlspecialchars', [this.data])).str() + '</string>'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('array'))) {
		mut var_return := rt.new_string('<array><data>' + '\n')
		{
			mut iter_1 := this.data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		// unsupported expression: Expr_AssignOp_Concat
		return (var_return).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('struct'))) {
		var_return = rt.new_string('<struct>' + '\n')
		{
			mut iter_1 := this.data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_name := item_1.key
				var_name = rt.call_function('htmlspecialchars', [var_name.dup()])
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		// unsupported expression: Expr_AssignOp_Concat
		return (var_return).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('base64'))) {
		return (rt.call_method(this.data, 'getXml', []rt.PhpVal{})).to_bool()
	}
	return false
}

fn (mut this Class_IXR_Value) isstruct(var_array rt.PhpVal) bool {
	mut var_expected := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return true
			}
			rt.post_inc(var_expected)
		}
	}
	return false
}

fn create_ixr_value(type bool, arg_1 rt.PhpVal) &Class_IXR_Value {
	mut obj := &Class_IXR_Value{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_null()
		prop_type: rt.new_null()
	}
	obj.construct(type, arg_1)
	return obj
}

fn (mut this Class_IXR_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'IXR_Value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.ixr_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'calculateType' {
			return rt.new_string(this.calculatetype())
		}
		'getXml' {
			return rt.new_bool(this.getxml())
		}
		'isStruct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.isstruct(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_IXR_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'type' { this.prop_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_ixr_class_ixr_value_php() {
}
