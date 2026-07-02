import rt

struct Class_WC_Eval_Math {
	rt.PhpObjectBase
}

fn init_static_wc_eval_math() {
	rt.init_static_prop('WC_Eval_Math', 'last_error', rt.new_null())
	rt.init_static_prop('WC_Eval_Math', 'v', rt.create_array([
		rt.ArrayItem{ key: 'e', val: 2.71 },
		rt.ArrayItem{ key: 'pi', val: 3.14 },
	]))
	rt.init_static_prop('WC_Eval_Math', 'f', rt.new_array())
	rt.init_static_prop('WC_Eval_Math', 'vb', rt.create_array([
		rt.ArrayItem{ key: none, val: 'e' },
		rt.ArrayItem{ key: none, val: 'pi' },
	]))
	rt.init_static_prop('WC_Eval_Math', 'fb', rt.new_array())
}

fn Class_WC_Eval_Math.evaluate(var_expr rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_expr_mutated := var_expr
	rt.set_static_prop('WC_Eval_Math', 'last_error', rt.new_null())
	var_expr_mutated = rt.new_string(var_expr_mutated.clone().to_string().trim_space())
	if rt.is_true(rt.equal(rt.call_function('substr', [var_expr_mutated.clone(),
		rt.new_int(-1), rt.new_int(1)]), rt.new_string(';')))
	{
		var_expr_mutated = rt.call_function('substr', [var_expr_mutated.clone(),
			rt.new_int(0), rt.new_int(var_expr_mutated.clone().to_string().len - 1)])
	}
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^\\s*([a-z]\\w*)\\s*=\\s*(.+)$/'),
		var_expr_mutated.clone(),
		rt.create_array_from_list(var_matches),
	]))
	{
		if rt.is_true(rt.call_function('in_array', [var_matches.array_get(rt.new_int(1)),
			rt.get_static_prop('WC_Eval_Math', 'vb')]))
		{
			return (Class_WC_Eval_Math.trigger(rt.new_string((rt.concat(rt.concat(rt.new_string("cannot assign to constant '"),
				var_matches.array_get(rt.new_int(1))), rt.new_string("'"))).str()))).to_bool()
		}
		mut var_tmp :=
			Class_WC_Eval_Math.pfx(Class_WC_Eval_Math.nfx(var_matches.array_get(rt.new_int(2))))
		if rt.is_true(rt.identical(var_tmp, rt.new_bool(false))) {
			return false
		}
		rt.get_static_prop('WC_Eval_Math', 'v').array_set(var_matches.array_get(rt.new_int(1)),
			var_tmp.clone())
		return (rt.get_static_prop('WC_Eval_Math', 'v').array_get(var_matches.array_get(rt.new_int(1)))).to_bool()
	} else if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^\\s*([a-z]\\w*)\\s*\\(\\s*([a-z]\\w*(?:\\s*,\\s*[a-z]\\w*)*)\\s*\\)\\s*=\\s*(.+)$/'),
		var_expr_mutated.clone(),
		rt.create_array_from_list(var_matches),
	]))
	{
		mut var_fnn := var_matches.array_get(rt.new_int(1))
		if rt.is_true(rt.call_function('in_array', [var_matches.array_get(rt.new_int(1)),
			rt.get_static_prop('WC_Eval_Math', 'fb')]))
		{
			return (Class_WC_Eval_Math.trigger(rt.new_string((rt.concat(rt.concat(rt.new_string("cannot redefine built-in function '"),
				var_matches.array_get(rt.new_int(1))), rt.new_string("()'"))).str()))).to_bool()
		}
		mut var_args := rt.call_function('explode', [rt.new_string(','),
			rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
				rt.new_string(''), var_matches.array_get(rt.new_int(2))])])
		mut var_stack := Class_WC_Eval_Math.nfx(var_matches.array_get(rt.new_int(3)))
		if rt.is_true(rt.identical(var_stack, rt.new_bool(false))) {
			return false
		}
		mut var_stack_size := rt.new_int(var_stack.clone().array_count())
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_stack_size))) { break
			 }
			mut var_token := var_stack.array_get(var_i)
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z]\\w*$/'), var_token.clone()]))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_token.clone(), var_args.clone()]))))) {
				if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Eval_Math', 'v').array_isset(var_token.clone()))) {
					var_stack.array_set(var_i,
						rt.get_static_prop('WC_Eval_Math', 'v').array_get(var_token))
				} else {
					return (Class_WC_Eval_Math.trigger(rt.new_string("undefined variable '${var_token.to_string()}' in function definition"))).to_bool()
				}
			}
			rt.post_inc(var_i)
		}
		rt.get_static_prop('WC_Eval_Math', 'f').array_set(var_fnn, rt.create_array([
			rt.ArrayItem{ key: 'args', val: var_args },
			rt.ArrayItem{ key: 'func', val: var_stack },
		]))
		return true
	} else {
		return (Class_WC_Eval_Math.pfx(Class_WC_Eval_Math.nfx(var_expr_mutated.clone()))).to_bool()
	}
	return false
}

fn Class_WC_Eval_Math.nfx(var_expr rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_match := []rt.PhpVal{}
	mut var_expr_mutated := var_expr
	mut var_index := rt.new_int(0)
	mut var_stack := create_wc_eval_math_stack()
	mut var_output := rt.new_array()
	var_expr_mutated = rt.new_string(var_expr_mutated.clone().to_string().trim_space())
	mut var_ops := ['+', '-', '*', '/', '^', '_']
	mut var_ops_r := {
		'+': 0
		'-': 0
		'*': 0
		'/': 0
		'^': 1
	}
	mut var_ops_p := {
		'+': 0
		'-': 0
		'*': 1
		'/': 1
		'_': 1
		'^': 2
	}
	mut var_expecting_op := rt.new_bool(false)
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/[^\\w\\s+*^\\/()\\.,-]/'),
		var_expr_mutated.clone(),
		rt.create_array_from_list(var_matches),
	]))
	{
		return Class_WC_Eval_Math.trigger(rt.new_string((rt.concat(rt.concat(rt.new_string("illegal character '"),
			var_matches.array_get(rt.new_int(0))), rt.new_string("'"))).str()))
	}
	for rt.is_true(rt.new_int(1)) {
		mut var_op := rt.call_function('substr', [var_expr_mutated.clone(),
			var_index.clone(), rt.new_int(1)])
		mut var_ex := rt.call_function('preg_match', [
			rt.new_string('/^([A-Za-z]\\w*\\(?|\\d+(?:\\.\\d*)?|\\.\\d+|\\()/'),
			rt.call_function('substr', [var_expr_mutated.clone(),
				var_index.clone()]),
			rt.create_array_from_list(var_match),
		])
		if rt.is_true(rt.identical(rt.new_string('-'), var_op))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))) {
			rt.call_method(var_stack, 'push', [rt.new_string('_')])
			rt.post_inc(var_index)
		} else if rt.is_true(rt.identical(rt.new_string('_'), var_op)) {
			return Class_WC_Eval_Math.trigger(rt.new_string("illegal character '_'"))
		} else if
			rt.is_true(rt.call_function('in_array', [var_op.clone(), rt.create_array_from_list(var_ops)]))
			|| rt.is_true(var_ex) && rt.is_true(var_expecting_op) {
			if rt.is_true(var_ex) {
				var_op = rt.new_string('*')
				rt.post_dec(var_index)
			}
			mut var_o2 := rt.call_method(var_stack, 'last', []rt.PhpVal{})
			for rt.is_true(rt.greater(rt.get_property(var_stack, 'count'), rt.new_int(0)))
				&& rt.is_true(var_o2)
				&& rt.is_true(rt.call_function('in_array', [var_o2.clone(), rt.create_array_from_list(var_ops)]))
				&& rt.is_true(if rt.is_true(rt.new_int(var_ops_r[var_op])) { rt.new_bool(var_ops_p[var_op] < var_ops_p[var_o2]) } else { rt.new_bool(var_ops_p[var_op] <= var_ops_p[var_o2]) }) {
				var_output << rt.call_method(var_stack, 'pop', []rt.PhpVal{})
			}
			rt.call_method(var_stack, 'push', [var_op.clone()])
			rt.post_inc(var_index)
			var_expecting_op = rt.new_bool(false)
		} else if rt.is_true(rt.identical(rt.new_string(')'), var_op))
			&& rt.is_true(var_expecting_op) {
			var_o2 = rt.call_method(var_stack, 'pop', []rt.PhpVal{})
			for rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_o2, rt.new_string('('))))) {
				if rt.is_true(rt.new_bool(var_o2.clone().is_null())) {
					return Class_WC_Eval_Math.trigger(rt.new_string("unexpected ')'"))
				} else {
					var_output << var_o2.clone()
				}
			}
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^([A-Za-z]\\w*)\\($/'),
				rt.call_method(var_stack, 'last', [rt.new_int(2)]),
				rt.create_array_from_list(var_matches),
			]))
			{
				mut var_fnn := var_matches.array_get(rt.new_int(1))
				mut var_arg_count := rt.call_method(var_stack, 'pop', []rt.PhpVal{})
				var_output << rt.call_method(var_stack, 'pop', []rt.PhpVal{})
				if rt.is_true(rt.call_function('in_array', [var_fnn.clone(),
					rt.get_static_prop('WC_Eval_Math', 'fb')]))
				{
					if rt.is_true(rt.greater(var_arg_count, rt.new_int(1))) {
						return Class_WC_Eval_Math.trigger(rt.new_string('too many arguments (${var_arg_count.to_string()} given, 1 expected)'))
					}
				} else if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Eval_Math', 'f').array_isset(var_fnn.clone()))) {
					if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_int(rt.get_static_prop('WC_Eval_Math',
						'f').array_get(var_fnn).array_get(rt.new_string('args')).array_count()),
						var_arg_count))))
					{
						return Class_WC_Eval_Math.trigger(rt.new_string(
							'wrong number of arguments (${var_arg_count.to_string()} given, ' + rt.get_static_prop('WC_Eval_Math', 'f').array_get(var_fnn).array_get(rt.new_string('args')).array_count().str() +
							' expected)'))
					}
				} else {
					return Class_WC_Eval_Math.trigger(rt.new_string('internal error'))
				}
			}
			rt.post_inc(var_index)
		} else if rt.is_true(rt.identical(rt.new_string(','), var_op))
			&& rt.is_true(var_expecting_op) {
			var_o2 = rt.call_method(var_stack, 'pop', []rt.PhpVal{})
			for rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_o2, rt.new_string('('))))) {
				if rt.is_true(rt.new_bool(var_o2.clone().is_null())) {
					return Class_WC_Eval_Math.trigger(rt.new_string("unexpected ','"))
				} else {
					var_output << var_o2.clone()
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^([A-Za-z]\\w*)\\($/'),
				rt.call_method(var_stack, 'last', [rt.new_int(2)]),
				rt.create_array_from_list(var_matches),
			])))))
			{
				return Class_WC_Eval_Math.trigger(rt.new_string("unexpected ','"))
			}
			rt.call_method(var_stack, 'push', [
				rt.add(rt.call_method(var_stack, 'pop', []rt.PhpVal{}), rt.new_int(1)),
			])
			rt.call_method(var_stack, 'push', [rt.new_string('(')])
			rt.post_inc(var_index)
			var_expecting_op = rt.new_bool(false)
		} else if rt.is_true(rt.identical(rt.new_string('('), var_op))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))) {
			rt.call_method(var_stack, 'push', [rt.new_string('(')])
			rt.post_inc(var_index)
		} else if rt.is_true(var_ex) && rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))) {
			var_expecting_op = rt.new_bool(true)
			mut var_val := var_match.array_get(rt.new_int(1))
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^([A-Za-z]\\w*)\\($/'),
				var_val.clone(),
				rt.create_array_from_list(var_matches),
			]))
			{
				if rt.is_true(rt.call_function('in_array', [var_matches.array_get(rt.new_int(1)), rt.get_static_prop('WC_Eval_Math', 'fb')]))
					|| rt.is_true(rt.new_bool(rt.get_static_prop('WC_Eval_Math', 'f').array_isset(var_matches.array_get(rt.new_int(1))))) {
					rt.call_method(var_stack, 'push', [var_val.clone()])
					rt.call_method(var_stack, 'push', [rt.new_int(1)])
					rt.call_method(var_stack, 'push', [rt.new_string('(')])
					var_expecting_op = rt.new_bool(false)
				} else {
					var_val = var_matches.array_get(rt.new_int(1))
					var_output << var_val.clone()
				}
			} else {
				var_output << var_val.clone()
			}
			var_index = rt.add(var_index, rt.new_int(var_val.clone().to_string().len))
		} else if rt.is_true(rt.identical(rt.new_string(')'), var_op)) {
			return Class_WC_Eval_Math.trigger(rt.new_string("unexpected ')'"))
		} else if
			rt.is_true(rt.call_function('in_array', [var_op.clone(), rt.create_array_from_list(var_ops)]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))) {
			return Class_WC_Eval_Math.trigger(rt.new_string("unexpected operator '${var_op.to_string()}'"))
		} else {
			return Class_WC_Eval_Math.trigger(rt.new_string('an unexpected error occurred'))
		}
		if rt.is_true(rt.equal(rt.new_int(var_expr_mutated.clone().to_string().len), var_index)) {
			if rt.is_true(rt.call_function('in_array', [var_op.clone(),
				rt.create_array_from_list(var_ops)]))
			{
				return Class_WC_Eval_Math.trigger(rt.new_string("operator '${var_op.to_string()}' lacks operand"))
			} else {
				break
			}
		}
		for rt.is_true(rt.equal(rt.call_function('substr', [var_expr_mutated.clone(),
			var_index.clone(), rt.new_int(1)]), rt.new_string(' '))) {
			rt.post_inc(var_index)
		}
	}
	var_op = rt.call_method(var_stack, 'pop', []rt.PhpVal{})
	var_op = rt.call_method(var_stack, 'pop', []rt.PhpVal{})
	for !(var_op.is_null()) {
		if rt.is_true(rt.identical(rt.new_string('('), var_op)) {
			return Class_WC_Eval_Math.trigger(rt.new_string("expecting ')'"))
		}
		var_output << var_op.clone()
	}
	return var_output.clone()
}

fn Class_WC_Eval_Math.pfx(var_tokens rt.PhpVal, var_vars rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.equal(rt.new_bool(false), var_tokens)) {
		return false
	}
	mut var_stack := create_wc_eval_math_stack()
	mut iter_1 := var_tokens.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_token := item_1.val
		if rt.is_true(rt.call_function('in_array', [var_token.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: '+' },
				rt.ArrayItem{ key: none, val: '-' }, rt.ArrayItem{ key: none, val: '*' },
				rt.ArrayItem{ key: none, val: '/' }, rt.ArrayItem{ key: none, val: '^' }])]))
		{
			mut var_op2 := rt.call_method(var_stack, 'pop', []rt.PhpVal{})
			var_op2 = rt.call_method(var_stack, 'pop', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(var_op2.is_null())) {
				return (Class_WC_Eval_Math.trigger(rt.new_string('internal error'))).to_bool()
			}
			mut var_op1 := rt.call_method(var_stack, 'pop', []rt.PhpVal{})
			var_op1 = rt.call_method(var_stack, 'pop', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(var_op1.is_null())) {
				return (Class_WC_Eval_Math.trigger(rt.new_string('internal error'))).to_bool()
			}
			mut switch_val_1 := var_token
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('+'))) {
				rt.call_method(var_stack, 'push', [rt.add(var_op1, var_op2)])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('-'))) {
				rt.call_method(var_stack, 'push', [rt.sub(var_op1, var_op2)])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('*'))) {
				rt.call_method(var_stack, 'push', [rt.mul(var_op1, var_op2)])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('/'))) {
				if rt.is_true(rt.equal(rt.new_int(0), var_op2)) {
					return (Class_WC_Eval_Math.trigger(rt.new_string('division by zero'))).to_bool()
				}
				rt.call_method(var_stack, 'push', [rt.div(var_op1, var_op2)])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('^'))) {
				rt.call_method(var_stack, 'push', [
					rt.call_function('pow', [var_op1.clone(),
						var_op2.clone()]),
				])
			}
		} else if rt.is_true(rt.identical(rt.new_string('_'), var_token)) {
			rt.call_method(var_stack, 'push', [
				rt.mul(-1, rt.call_method(var_stack, 'pop', []rt.PhpVal{})),
			])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^([a-z]\\w*)\\($/'),
			var_token.clone(),
			rt.create_array_from_list(var_matches),
		])))))
		{
			if rt.is_true(rt.new_bool(var_token.clone().is_long() || var_token.clone().is_double())) {
				rt.call_method(var_stack, 'push', [var_token.clone()])
			} else if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Eval_Math', 'v').array_isset(var_token.clone()))) {
				rt.call_method(var_stack, 'push',
					[rt.get_static_prop('WC_Eval_Math', 'v').array_get(var_token)])
			} else if rt.is_true(rt.new_bool(var_vars.clone().array_isset(var_token.clone()))) {
				rt.call_method(var_stack, 'push', [var_vars.array_get(var_token)])
			} else {
				return (Class_WC_Eval_Math.trigger(rt.new_string("undefined variable '${var_token.to_string()}'"))).to_bool()
			}
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_int(1), rt.get_property(var_stack,
		'count')))))
	{
		return (Class_WC_Eval_Math.trigger(rt.new_string('internal error'))).to_bool()
	}
	return (rt.call_method(var_stack, 'pop', []rt.PhpVal{})).to_bool()
}

fn Class_WC_Eval_Math.trigger(var_msg rt.PhpVal) bool {
	rt.set_static_prop('WC_Eval_Math', 'last_error', var_msg.clone())
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('DOING_AJAX'))
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.is_true(rt.new_string('WP_DEBUG'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) && rt.is_true(iife_result_1) {
		print('\nError found in:')
		Class_WC_Eval_Math.debugprintcallingfunction()
		rt.call_function('trigger_error', [var_msg.clone(), rt.get_constant('E_USER_WARNING')])
	}
	return false
}

fn Class_WC_Eval_Math.debugprintcallingfunction() {
	mut var_file := rt.new_string('n/a')
	mut var_func := rt.new_string('n/a')
	mut var_line := rt.new_string('n/a')
	mut var_debugTrace := rt.call_function('debug_backtrace', []rt.PhpVal{})
	if var_debugTrace.array_isset(rt.new_int(1)) {
		var_file = if rt.is_true(var_debugTrace.array_get(rt.new_int(1)).array_get(rt.new_string('file'))) {
			var_debugTrace.array_get(rt.new_int(1)).array_get(rt.new_string('file'))
		} else {
			rt.new_string('n/a')
		}
		var_line = if rt.is_true(var_debugTrace.array_get(rt.new_int(1)).array_get(rt.new_string('line'))) {
			var_debugTrace.array_get(rt.new_int(1)).array_get(rt.new_string('line'))
		} else {
			rt.new_string('n/a')
		}
	}
	if var_debugTrace.array_isset(rt.new_int(2)) {
		var_func = if rt.is_true(var_debugTrace.array_get(rt.new_int(2)).array_get(rt.new_string('function'))) {
			var_debugTrace.array_get(rt.new_int(2)).array_get(rt.new_string('function'))
		} else {
			rt.new_string('n/a')
		}
	}
	print('\n${var_file.to_string()}, ${var_func.to_string()}, ${var_line.to_string()}\n')
}

struct Class_WC_Eval_Math_Stack {
	rt.PhpObjectBase
pub mut:
	stack rt.PhpVal = rt.new_array()
	count rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WC_Eval_Math_Stack) push(var_val rt.PhpVal) {
	mut var_val_mutated := var_val
	this.stack.array_set(this.count, var_val_mutated.clone())
	rt.post_inc(this.count)
}

fn (mut this Class_WC_Eval_Math_Stack) pop() rt.PhpVal {
	if rt.is_true(rt.greater(this.count, rt.new_int(0))) {
		rt.post_dec(this.count)
		return this.stack.array_get(this.count)
	}
	return rt.new_null()
}

fn (mut this Class_WC_Eval_Math_Stack) last(n i64) rt.PhpVal {
	mut var_key := rt.sub(this.count, rt.new_int(n))
	return if rt.is_true(rt.new_bool(this.stack.array_isset(var_key.clone()))) {
		this.stack.array_get(var_key)
	} else {
		rt.new_null()
	}
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_eval_math(_args ...rt.PhpVal) &Class_WC_Eval_Math {
	mut obj := &Class_WC_Eval_Math{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_eval_math_stack(_args ...rt.PhpVal) &Class_WC_Eval_Math_Stack {
	mut obj := &Class_WC_Eval_Math_Stack{
		PhpObjectBase: rt.PhpObjectBase{}
		stack:         rt.new_array()
		count:         rt.new_int(0)
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Eval_Math) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'evaluate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Eval_Math.evaluate(dispatch_arg_0))
		}
		'nfx' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Eval_Math.nfx(dispatch_arg_0)
		}
		'pfx' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Eval_Math.pfx(dispatch_arg_0, dispatch_arg_1))
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Eval_Math.trigger(dispatch_arg_0))
		}
		'debugPrintCallingFunction' {
			Class_WC_Eval_Math.debugprintcallingfunction()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Eval_Math) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Eval_Math) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Eval_Math_Stack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'push' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.push(dispatch_arg_0)
			return rt.new_null()
		}
		'pop' {
			return this.pop()
		}
		'last' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.last(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Eval_Math_Stack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'stack' { return this.stack }
		'count' { return this.count }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Eval_Math_Stack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'stack' {
			this.stack = val
			return true
		}
		'count' {
			this.count = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Eval_Math'),
		rt.new_bool(false),
	])))))
	{
	}
}
