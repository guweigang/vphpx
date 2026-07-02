import rt

struct Class_IXR_Value {
	rt.PhpObjectBase
pub mut:
	data      rt.PhpVal = rt.new_null()
	prop_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Value) construct(var_data rt.PhpVal, type bool) {
	mut type_mutated := type
	this.data = var_data.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(type_mutated))))) {
		type_mutated = this.calculatetype()
	}
	this.prop_type = rt.new_bool(type_mutated).clone()
	if rt.is_true(rt.equal(rt.new_bool(type_mutated), rt.new_string('struct'))) {
		mut iter_1 := this.data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			this.data.array_set(var_key, create_ixr_value(var_value, false))
		}
	}
	if rt.is_true(rt.equal(rt.new_bool(type_mutated), rt.new_string('array'))) {
		mut var_i := rt.new_int(0)
		mut var_j := rt.new_int(this.data.array_count())
		for {
			if !(rt.is_true(rt.less(var_i, var_j))) { break
			 }
			this.data.array_set(var_i, create_ixr_value(this.data.array_get(var_i), false))
			rt.post_inc(var_i)
		}
	}
}

fn (mut this Class_IXR_Value) ixr_value(var_data rt.PhpVal, type bool) {
	mut type_mutated := type
	mut iife_temp_0 := Class_IXR_Value{}
	iife_temp_0.construct(var_data.to_bool(), rt.new_bool(type_mutated))
	rt.new_null()
}

fn (mut this Class_IXR_Value) calculatetype() string {
	if rt.is_true(rt.identical(this.data, rt.new_bool(true)))
		|| rt.is_true(rt.identical(this.data, rt.new_bool(false))) {
		return 'boolean'
	}
	if rt.is_true(rt.new_bool(this.data.is_long())) {
		return 'int'
	}
	if rt.is_true(rt.new_bool(this.data.is_double())) {
		return 'double'
	}
	if this.data.is_object()
		&& rt.is_true(rt.call_function('is_a', [this.data, rt.new_string('IXR_Date')])) {
		return 'date'
	}
	if this.data.is_object()
		&& rt.is_true(rt.call_function('is_a', [this.data, rt.new_string('IXR_Base64')])) {
		return 'base64'
	}
	if rt.is_true(rt.new_bool(this.data.is_object())) {
		this.data = rt.call_function('get_object_vars', [this.data])
		return 'struct'
	}
	if !(this.data.is_array()) {
		return 'string'
	}
	if this.isstruct(this.data) {
		return 'struct'
	} else {
		return 'array'
	}
	return ''
}

fn (mut this Class_IXR_Value) getxml() rt.PhpVal {
	mut switch_val_1 := this.prop_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('boolean'))) {
		return rt.new_string('<boolean>' + if rt.is_true(this.data) { '1' } else { '0' } +
			'</boolean>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('int'))) {
		return rt.new_string('<int>' + (this.data).str() + '</int>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('double'))) {
		return rt.new_string('<double>' + (this.data).str() + '</double>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('string'))) {
		return rt.new_string('<string>' +
			(rt.call_function('htmlspecialchars', [this.data])).str() + '</string>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('array'))) {
		mut var_return := rt.new_string('<array><data>' + '\n')
		mut iter_2 := this.data.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_item := item_2.val
			var_return = rt.concat(var_return, rt.new_string('  <value>' +
				(rt.call_method(var_item, 'getXml', []rt.PhpVal{})).str() + '</value>\n'))
		}
		var_return = rt.concat(var_return, rt.new_string('</data></array>'))
		return var_return.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('struct'))) {
		var_return = rt.new_string('<struct>' + '\n')
		mut iter_3 := this.data.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			mut var_name := item_3.key
			var_name = rt.call_function('htmlspecialchars', [
				var_name.clone()])
			var_return = rt.concat(var_return,
				rt.new_string('  <member><name>${var_name.to_string()}</name><value>'))
			var_return = rt.concat(var_return, rt.new_string(
				(rt.call_method(var_value, 'getXml', []rt.PhpVal{})).str() + '</value></member>\n'))
		}
		var_return = rt.concat(var_return, rt.new_string('</struct>'))
		return var_return.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('date')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('base64'))) {
		return rt.call_method(this.data, 'getXml', []rt.PhpVal{})
	}
	return rt.new_bool(false)
}

fn (mut this Class_IXR_Value) isstruct(var_array rt.PhpVal) bool {
	mut var_expected := rt.new_int(0)
	mut iter_4 := var_array.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		if rt.is_true(rt.new_bool(var_key.str() != var_expected.str())) {
			return true
		}
		rt.post_inc(var_expected)
	}
	return false
}

fn create_ixr_value(type bool, arg_1 rt.PhpVal) &Class_IXR_Value {
	mut obj := &Class_IXR_Value{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_null()
		prop_type:     rt.new_null()
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
			return this.getxml()
		}
		'isStruct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.isstruct(dispatch_arg_0))
		}
		else {
			return none
		}
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
		'data' {
			this.data = val
			return true
		}
		'type' {
			this.prop_type = val
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
