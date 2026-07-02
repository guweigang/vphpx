import rt

pub fn Class_Plural_Forms.op_chars() string {
	return '|&><!=%?:'
}

pub fn Class_Plural_Forms.num_chars() string {
	return '0123456789'
}

struct Class_Plural_Forms {
	rt.PhpObjectBase
pub mut:
	tokens rt.PhpVal = rt.new_array()
	cache  rt.PhpVal = rt.new_array()
}

fn init_static_plural_forms() {
	rt.init_static_prop('Plural_Forms', 'op_precedence', rt.create_array([
		rt.ArrayItem{ key: '%', val: 6 },
		rt.ArrayItem{ key: '<', val: 5 },
		rt.ArrayItem{ key: '<=', val: 5 },
		rt.ArrayItem{ key: '>', val: 5 },
		rt.ArrayItem{ key: '>=', val: 5 },
		rt.ArrayItem{ key: '==', val: 4 },
		rt.ArrayItem{ key: '!=', val: 4 },
		rt.ArrayItem{ key: '&&', val: 3 },
		rt.ArrayItem{ key: '||', val: 2 },
		rt.ArrayItem{ key: '?:', val: 1 },
		rt.ArrayItem{ key: '?', val: 1 },
		rt.ArrayItem{ key: '(', val: 0 },
		rt.ArrayItem{ key: ')', val: 0 },
	]))
}

fn (mut this Class_Plural_Forms) construct(var_str rt.PhpVal) {
	this.parse(var_str.clone())
}

fn (mut this Class_Plural_Forms) parse(var_str rt.PhpVal) {
	mut var_pos := rt.new_int(0)
	mut var_len := rt.new_int(var_str.clone().to_string().len)
	mut var_output := []rt.PhpVal{}
	mut var_stack := []rt.PhpVal{}
	for rt.is_true(rt.less(var_pos, var_len)) {
		mut var_next := rt.call_function('substr', [var_str.clone(),
			var_pos.clone(), rt.new_int(1)])
		mut switch_val_1 := var_next
		if rt.is_true(rt.equal(switch_val_1, rt.new_string(' ')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('\t'))) {
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('n'))) {
			var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'var' }])
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('('))) {
			var_stack << var_next.clone()
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(')'))) {
			mut var_found := rt.new_bool(false)
			for !(!rt.is_true(var_stack)) {
				mut var_o2 := var_stack[var_stack.len - 1]
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('('), var_o2)))) {
					var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' },
						rt.ArrayItem{ key: none, val: rt.call_function('array_pop', [
							rt.create_array_from_list(var_stack),
						]) }])
					continue
				}
				rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
				var_found = rt.new_bool(true)
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
				rt.throw_exception(rt.new_object('Exception', []string{},
					create_exception(rt.new_string('Mismatched parentheses'))))
			}
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('|')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('&')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('>')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('<')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('!')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('=')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('%')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('?'))) {
			mut var_end_operator := rt.call_function('strspn', [
				var_str.clone(), Class_Plural_Forms.op_chars(),
				var_pos.clone()])
			mut var_operator := rt.call_function('substr', [var_str.clone(),
				var_pos.clone(), var_end_operator.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_static_prop('Plural_Forms',
				'op_precedence').array_isset(var_operator.clone()))))))
			{
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
					rt.new_string('Unknown operator "%s"'),
					var_operator.clone(),
				]))))
			}
			for !(!rt.is_true(var_stack)) {
				var_o2 = var_stack[var_stack.len - 1]
				if rt.is_true(rt.identical(rt.new_string('?:'), var_operator))
					|| rt.is_true(rt.identical(rt.new_string('?'), var_operator)) {
					if rt.is_true(rt.greater_equal(rt.get_static_prop('Plural_Forms',
						'op_precedence').array_get(var_operator), rt.get_static_prop('Plural_Forms',
						'op_precedence').array_get(var_o2)))
					{
					}
				} else if rt.is_true(rt.greater(rt.get_static_prop('Plural_Forms', 'op_precedence').array_get(var_operator), rt.get_static_prop('Plural_Forms',
					'op_precedence').array_get(var_o2)))
				{
				}
				var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' },
					rt.ArrayItem{ key: none, val: rt.call_function('array_pop', [
						rt.create_array_from_list(var_stack),
					]) }])
			}
			var_stack << var_operator.clone()
			var_pos = rt.add(var_pos, var_end_operator)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(':'))) {
			var_found = rt.new_bool(false)
			mut var_s_pos := rt.new_int(var_stack.len - 1)
			for rt.is_true(rt.greater_equal(var_s_pos, rt.new_int(0))) {
				var_o2 = var_stack[var_s_pos]
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('?'), var_o2)))) {
					var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' },
						rt.ArrayItem{ key: none, val: rt.call_function('array_pop', [
							rt.create_array_from_list(var_stack),
						]) }])
					rt.pre_dec(var_s_pos)
					continue
				}
				var_stack[var_s_pos] = rt.new_string('?:')
				var_found = rt.new_bool(true)
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
				rt.throw_exception(rt.new_object('Exception', []string{},
					create_exception(rt.new_string('Missing starting "?" ternary operator'))))
			}
			rt.pre_inc(var_pos)
		} else {
			if rt.is_true(rt.greater_equal(var_next, rt.new_string('0')))
				&& rt.is_true(rt.less_equal(var_next, rt.new_string('9'))) {
				mut var_span := rt.call_function('strspn', [var_str.clone(),
					Class_Plural_Forms.num_chars(), var_pos.clone()])
				var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'value' },
					rt.ArrayItem{ key: none, val: rt.call_function('substr', [
						var_str.clone(), var_pos.clone(), var_span.clone()]).to_i64() }])
				var_pos = rt.add(var_pos, var_span)
			}
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.new_string('Unknown symbol "%s"'),
				var_next.clone(),
			]))))
		}
	}
	for !(!rt.is_true(var_stack)) {
		var_o2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
		if rt.is_true(rt.identical(rt.new_string('('), var_o2))
			|| rt.is_true(rt.identical(rt.new_string(')'), var_o2)) {
			rt.throw_exception(rt.new_object('Exception', []string{},
				create_exception(rt.new_string('Mismatched parentheses'))))
		}
		var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' },
			rt.ArrayItem{ key: none, val: var_o2 }])
	}
	this.tokens = var_output.clone()
}

fn (mut this Class_Plural_Forms) get(var_num rt.PhpVal) rt.PhpVal {
	if this.cache.array_isset(var_num) {
		return this.cache.array_get(var_num)
	}
	this.cache.array_set(var_num, this.execute(var_num.clone()))
	return this.cache.array_get(var_num)
}

fn (mut this Class_Plural_Forms) execute(var_n rt.PhpVal) i64 {
	mut var_stack := []rt.PhpVal{}
	mut var_i := rt.new_int(0)
	mut var_total := rt.new_int(this.tokens.array_count())
	for rt.is_true(rt.less(var_i, var_total)) {
		mut var_next := this.tokens.array_get(var_i)
		rt.pre_inc(var_i)
		if rt.is_true(rt.identical(rt.new_string('var'), var_next.array_get(rt.new_int(0)))) {
			var_stack << var_n.clone()
			continue
		} else if rt.is_true(rt.identical(rt.new_string('value'), var_next.array_get(rt.new_int(0)))) {
			var_stack << var_next.array_get(rt.new_int(1))
			continue
		}
		mut switch_val_2 := var_next.array_get(rt.new_int(1))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('%'))) {
			mut var_v2 := rt.call_function('array_pop', [
				rt.create_array_from_list(var_stack),
			])
			mut var_v1 := rt.call_function('array_pop', [
				rt.create_array_from_list(var_stack),
			])
			var_stack << rt.mod_(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('||'))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.new_bool(rt.is_true(var_v1) || rt.is_true(var_v2))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('&&'))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.new_bool(rt.is_true(var_v1) && rt.is_true(var_v2))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('<'))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.less(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('<='))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.less_equal(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('>'))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.greater(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('>='))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.greater_equal(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('!='))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.new_bool(!rt.is_true(rt.identical(var_v1, var_v2)))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('=='))) {
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << rt.identical(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('?:'))) {
			mut var_v3 := rt.call_function('array_pop', [
				rt.create_array_from_list(var_stack),
			])
			var_v2 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_v1 = rt.call_function('array_pop', [rt.create_array_from_list(var_stack)])
			var_stack << if rt.is_true(var_v1) { var_v2 } else { var_v3 }
		} else {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.new_string('Unknown operator "%s"'),
				var_next.array_get(rt.new_int(1)),
			]))))
		}
	}
	if rt.is_true(rt.new_bool(var_stack.len != 1)) {
		rt.throw_exception(rt.new_object('Exception', []string{},
			create_exception(rt.new_string('Too many values remaining on the stack'))))
	}
	return rt.new_int((var_stack[0]).to_i64())
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

fn create_plural_forms(arg_0 rt.PhpVal) &Class_Plural_Forms {
	mut obj := &Class_Plural_Forms{
		PhpObjectBase: rt.PhpObjectBase{}
		tokens:        rt.new_array()
		cache:         rt.new_array()
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

fn (mut this Class_Plural_Forms) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.parse(dispatch_arg_0)
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'execute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.execute(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Plural_Forms) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tokens' { return this.tokens }
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Plural_Forms) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tokens' {
			this.tokens = val
			return true
		}
		'cache' {
			this.cache = val
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('Plural_Forms'),
		rt.new_bool(false),
	])))))
	{
	}
}
