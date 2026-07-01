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
			op_precedence rt.PhpVal = rt.new_array()
			tokens rt.PhpVal = rt.new_array()
			cache rt.PhpVal = rt.new_array()
}

fn (mut this Class_Plural_Forms) construct(var_str rt.PhpVal)  {
	this.parse(var_str.dup())
}

fn (mut this Class_Plural_Forms) parse(var_str rt.PhpVal)  {
	mut var_pos := rt.new_int(rt.new_int(0))
	mut var_len := rt.new_int(rt.new_int(var_str.dup().to_string().len))
	mut var_output := []rt.PhpVal{}
	mut var_stack := []rt.PhpVal{}
	for rt.is_true(rt.less(var_pos, var_len)) {
		mut var_next := rt.call_function('substr', [var_str.dup(), var_pos.dup(), rt.new_int(1)])
		mut switch_val_1 := var_next
		if rt.is_true(rt.equal(switch_val_1, rt.new_string(' '))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('\t'))) {
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('n'))) {
			var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'var' }])
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('('))) {
			var_stack << var_next.dup()
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(')'))) {
			mut var_found := rt.new_bool(rt.new_bool(false))
			for !(!rt.is_true(var_stack)) {
				mut var_o2 := var_stack.array_get(var_stack.len - 1)
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' }, rt.ArrayItem{ key: none, val: rt.call_function('array_pop', [var_stack.dup()]) }])
					continue
				}
				rt.call_function('array_pop', [var_stack.dup()])
				var_found = rt.new_bool(rt.new_bool(true))
				break
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Mismatched parentheses'))))
			}
			rt.pre_inc(var_pos)
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('|'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('&'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('>'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('<'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('!'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('='))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('%'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('?'))) {
			mut var_end_operator := rt.call_function('strspn', [var_str.dup(), Class_Plural_Forms.op_chars(), var_pos.dup()])
			mut var_operator := rt.call_function('substr', [var_str.dup(), var_pos.dup(), var_end_operator.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_operator.dup())))))) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.new_string('Unknown operator "%s"'), var_operator.dup()]))))
			}
			for !(!rt.is_true(var_stack)) {
				var_o2 = var_stack.array_get(var_stack.len - 1)
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('?:'), var_operator)) || rt.is_true(rt.identical(rt.new_string('?'), var_operator)))) {
					if rt.is_true(rt.greater_equal(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_operator), // unsupported expression: Expr_StaticPropertyFetch.array_get(var_o2))) {
						break
					}
				} else if rt.is_true(rt.greater(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_operator), // unsupported expression: Expr_StaticPropertyFetch.array_get(var_o2))) {
					break
				}
				var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' }, rt.ArrayItem{ key: none, val: rt.call_function('array_pop', [var_stack.dup()]) }])
			}
			var_stack << var_operator.dup()
			// unsupported expression: Expr_AssignOp_Plus
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(':'))) {
			var_found = rt.new_bool(rt.new_bool(false))
			mut var_s_pos := rt.new_int(var_stack.len - 1)
			for rt.is_true(rt.greater_equal(var_s_pos, rt.new_int(0))) {
				var_o2 = var_stack.array_get(var_s_pos)
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' }, rt.ArrayItem{ key: none, val: rt.call_function('array_pop', [var_stack.dup()]) }])
					rt.pre_dec(var_s_pos)
					continue
				}
				var_stack[var_s_pos] = rt.new_string('?:')
				var_found = rt.new_bool(rt.new_bool(true))
				break
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
				rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Missing starting "?" ternary operator'))))
			}
			rt.pre_inc(var_pos)
		} else {
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_next, rt.new_string('0'))) && rt.is_true(rt.less_equal(var_next, rt.new_string('9'))))) {
				mut var_span := rt.call_function('strspn', [var_str.dup(), Class_Plural_Forms.num_chars(), var_pos.dup()])
				var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'value' }, rt.ArrayItem{ key: none, val: rt.call_function('substr', [var_str.dup(), var_pos.dup(), var_span.dup()]).to_i64() }])
				// unsupported expression: Expr_AssignOp_Plus
				break
			}
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [rt.new_string('Unknown symbol "%s"'), var_next.dup()]))))
		}
	}
	for !(!rt.is_true(var_stack)) {
		var_o2 = rt.call_function('array_pop', [var_stack.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('('), var_o2)) || rt.is_true(rt.identical(rt.new_string(')'), var_o2)))) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Mismatched parentheses'))))
		}
		var_output << rt.create_array([rt.ArrayItem{ key: none, val: 'op' }, rt.ArrayItem{ key: none, val: var_o2 }])
	}
	this.tokens = var_output.dup()
}

fn (mut this Class_Plural_Forms) get(var_num rt.PhpVal) rt.PhpVal {
	if this.cache.array_isset(var_num) {
		return this.cache.array_get(var_num)
	}
	this.cache.array_set(var_num, this.execute(var_num.dup()))
	return this.cache.array_get(var_num)
}

fn (mut this Class_Plural_Forms) execute(var_n rt.PhpVal) rt.PhpVal {
	mut var_stack := []rt.PhpVal{}
	mut var_i := rt.new_int(rt.new_int(0))
	mut var_total := rt.new_int(rt.new_int(this.tokens.array_count()))
	for rt.is_true(rt.less(var_i, var_total)) {
		mut var_next := this.tokens.array_get(var_i)
		rt.pre_inc(var_i)
		if rt.is_true(rt.identical(rt.new_string('var'), var_next.array_get(0))) {
			var_stack << var_n.dup()
			continue
		} else if rt.is_true(rt.identical(rt.new_string('value'), var_next.array_get(0))) {
			var_stack << var_next.array_get(1)
			continue
		}
		mut switch_val_2 := var_next.array_get(1)
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('%'))) {
			mut var_v2 := rt.call_function('array_pop', [var_stack.dup()])
			mut var_v1 := rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.mod_(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('||'))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.new_bool(rt.is_true(var_v1) || rt.is_true(var_v2))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('&&'))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.new_bool(rt.is_true(var_v1) && rt.is_true(var_v2))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('<'))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.less(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('<='))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.less_equal(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('>'))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.greater(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('>='))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.greater_equal(var_v1, var_v2)
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('!='))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << // unsupported expression: Expr_BinaryOp_NotIdentical
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('=='))) {
			var_v2 = rt.call_function('array_pop', [var_stack.dup()])
			var_v1 = rt.call_function('array_pop', [var_stack.dup()])
			var_stack << rt.identical(, )
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('?:'))) {
			mut var_v3 := 
			
		} else {
		}
	}
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
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
		op_precedence: rt.new_array()
		tokens: rt.new_array()
		cache: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
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
			return this.execute(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Plural_Forms) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'op_precedence' { return this.op_precedence }
		'tokens' { return this.tokens }
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Plural_Forms) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'op_precedence' { this.op_precedence = val; return true }
		'tokens' { this.tokens = val; return true }
		'cache' { this.cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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
		else { return none }
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
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_pomo_plural_forms_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Plural_Forms'), rt.new_bool(false)]))))) {
	}
}
