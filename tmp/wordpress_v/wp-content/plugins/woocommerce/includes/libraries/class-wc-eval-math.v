import rt

struct Class_WC_Eval_Math {
	rt.PhpObjectBase
pub mut:
			last_error rt.PhpVal = rt.new_null()
			v rt.PhpVal = rt.new_array()
			f rt.PhpVal = rt.new_array()
			vb rt.PhpVal = rt.new_array()
			fb rt.PhpVal = rt.new_array()
}

fn Class_WC_Eval_Math.evaluate(var_expr rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_expr_mutated := var_expr
	// unsupported assign target: Expr_StaticPropertyFetch
	var_expr_mutated = rt.new_string(rt.new_string(var_expr_mutated.dup().to_string().trim_space()))
	if rt.is_true(rt.equal(rt.call_function('substr', [var_expr_mutated.dup(), // unsupported expression: Expr_UnaryMinus, rt.new_int(1)]), rt.new_string(';'))) {
		var_expr_mutated = rt.call_function('substr', [var_expr_mutated.dup(), rt.new_int(0), var_expr_mutated.dup().to_string().len - 1])
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*([a-z]\\w*)\\s*=\\s*(.+)$/'), var_expr_mutated.dup(), var_matches.dup()])) {
		if rt.is_true(rt.call_function('in_array', [var_matches.array_get(1), // unsupported expression: Expr_StaticPropertyFetch])) {
			return (Class_WC_Eval_Math.trigger(rt.new_string(rt.concat(rt.concat(rt.new_string('cannot assign to constant \''), var_matches.array_get(1)), rt.new_string('\''))))).to_bool()
		}
		if rt.is_true(rt.identical(mut var_tmp := Class_WC_Eval_Math.pfx(Class_WC_Eval_Math.nfx(var_matches.array_get(2))), rt.new_bool(false))) {
			return false
			// unsupported statement: Stmt_Nop
		}
		// unsupported expression: Expr_StaticPropertyFetch.array_set(var_matches.array_get(1), var_tmp.dup())
		return (// unsupported expression: Expr_StaticPropertyFetch.array_get(var_matches.array_get(1))).to_bool()
		// unsupported statement: Stmt_Nop
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*([a-z]\\w*)\\s*\\(\\s*([a-z]\\w*(?:\\s*,\\s*[a-z]\\w*)*)\\s*\\)\\s*=\\s*(.+)$/'), var_expr_mutated.dup(), var_matches.dup()])) {
		mut var_fnn := var_matches.array_get(1)
		if rt.is_true(rt.call_function('in_array', [var_matches.array_get(1), // unsupported expression: Expr_StaticPropertyFetch])) {
			return (Class_WC_Eval_Math.trigger(rt.new_string(rt.concat(rt.concat(rt.new_string('cannot redefine built-in function \''), var_matches.array_get(1)), rt.new_string('()\''))))).to_bool()
		}
		mut var_args := rt.call_function('explode', [rt.new_string(','), rt.call_function('preg_replace', [rt.new_string('/\\s+/'), rt.new_string(''), var_matches.array_get(2)])])
		if rt.is_true(rt.identical(mut var_stack := Class_WC_Eval_Math.nfx(var_matches.array_get(3)), rt.new_bool(false))) {
			return false
			// unsupported statement: Stmt_Nop
		}
		mut var_stack_size := rt.new_int(rt.new_int(var_stack.dup().array_count()))
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_stack_size))) { break }
				mut var_token := var_stack.array_get(var_i)
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z]\\w*$/'), var_token.dup()])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_token.dup(), var_args.dup()]))))))) {
					if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_token.dup()))) {
						var_stack.array_set(var_i, // unsupported expression: Expr_StaticPropertyFetch.array_get(var_token))
					} else {
						return (Class_WC_Eval_Math.trigger(rt.new_string("undefined variable '${var_token.to_string()}' in function definition"))).to_bool()
					}
				}
				rt.post_inc(var_i)
			}
		}
		// unsupported expression: Expr_StaticPropertyFetch.array_set(var_fnn, rt.create_array([rt.ArrayItem{ key: 'args', val: var_args }, rt.ArrayItem{ key: 'func', val: var_stack }]))
		return true
		// unsupported statement: Stmt_Nop
	} else {
		return (Class_WC_Eval_Math.pfx(Class_WC_Eval_Math.nfx(var_expr_mutated.dup()))).to_bool()
		// unsupported statement: Stmt_Nop
	}
	return false
}

fn Class_WC_Eval_Math.nfx(var_expr rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_match := []rt.PhpVal{}
	mut var_expr_mutated := var_expr
	mut var_index := rt.new_int(rt.new_int(0))
	mut var_stack := create_wc_eval_math_stack()
	mut var_output := []rt.PhpVal{}
	var_expr_mutated = rt.new_string(rt.new_string(var_expr_mutated.dup().to_string().trim_space()))
	mut var_ops := ['+', '-', '*', '/', '^', '_']
	mut var_ops_r := { '+': 0, '-': 0, '*': 0, '/': 0, '^': 1 }
	mut var_ops_p := { '+': 0, '-': 0, '*': 1, '/': 1, '_': 1, '^': 2 }
	mut var_expecting_op := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[^\\w\\s+*^\\/()\\.,-]/'), var_expr_mutated.dup(), var_matches.dup()])) {
		return Class_WC_Eval_Math.trigger(rt.new_string(rt.concat(rt.concat(rt.new_string('illegal character \''), var_matches.array_get(0)), rt.new_string('\''))))
	}
	for rt.is_true(rt.new_int(1)) {
		mut var_op := rt.call_function('substr', [var_expr_mutated.dup(), var_index.dup(), rt.new_int(1)])
		mut var_ex := rt.call_function('preg_match', [rt.new_string('/^([A-Za-z]\\w*\\(?|\\d+(?:\\.\\d*)?|\\.\\d+|\\()/'), rt.call_function('substr', [var_expr_mutated.dup(), var_index.dup()]), var_match.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('-'), var_op)) && rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))))) {
			rt.call_method(var_stack, 'push', [rt.new_string('_')])
			rt.post_inc(var_index)
		} else if rt.is_true(rt.identical(rt.new_string('_'), var_op)) {
			return Class_WC_Eval_Math.trigger(rt.new_string('illegal character \'_\''))
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_op.dup(), var_ops.dup()])) || rt.is_true(var_ex))) && rt.is_true(var_expecting_op))) {
			if rt.is_true(var_ex) {
				var_op = rt.new_string(rt.new_string('*'))
				rt.post_dec(var_index)
				// unsupported statement: Stmt_Nop
			}
			for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.get_property(var_stack, 'count'), rt.new_int(0))) && rt.is_true(mut var_o2 := rt.call_method(var_stack, 'last', []rt.PhpVal{})))) && rt.is_true(rt.call_function('in_array', [var_o2.dup(), var_ops.dup()])))) && rt.is_true(if rt.is_true(var_ops_r.array_get(var_op)) { rt.new_bool(var_ops_p[var_op] < var_ops_p[var_o2]) } else { rt.new_bool(var_ops_p[var_op] <= var_ops_p[var_o2]) }))) {
				var_output << rt.call_method(var_stack, 'pop', []rt.PhpVal{})
				// unsupported statement: Stmt_Nop
			}
			rt.call_method(var_stack, 'push', [var_op.dup()])
			rt.post_inc(var_index)
			var_expecting_op = rt.new_bool(rt.new_bool(false))
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(')'), var_op)) && rt.is_true(var_expecting_op))) {
			for rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
				if rt.is_true(rt.new_bool(var_o2.dup().is_null())) {
					return Class_WC_Eval_Math.trigger(rt.new_string('unexpected \')\''))
				} else {
					var_output << var_o2.dup()
				}
			}
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^([A-Za-z]\\w*)\\($/'), rt.call_method(var_stack, 'last', [rt.new_int(2)]), var_matches.dup()])) {
				mut var_fnn := var_matches.array_get(1)
				mut var_arg_count := rt.call_method(var_stack, 'pop', []rt.PhpVal{})
				var_output << rt.call_method(var_stack, 'pop', []rt.PhpVal{})
				if rt.is_true(rt.call_function('in_array', [var_fnn.dup(), // unsupported expression: Expr_StaticPropertyFetch])) {
					if rt.is_true(rt.greater(var_arg_count, rt.new_int(1))) {
						return Class_WC_Eval_Math.trigger(rt.new_string("too many arguments (${var_arg_count.to_string()} given, 1 expected)"))
					}
				} else if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_fnn.dup()))) {
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
						return Class_WC_Eval_Math.trigger(rt.new_string("wrong number of arguments (${var_arg_count.to_string()} given, " + // unsupported expression: Expr_StaticPropertyFetch.array_get(var_fnn).array_get('args').array_count().str() + ' expected)'))
					}
				} else {
					return Class_WC_Eval_Math.trigger(rt.new_string('internal error'))
				}
			}
			rt.post_inc(var_index)
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(','), var_op)) && rt.is_true(var_expecting_op))) {
			for rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
				if rt.is_true(rt.new_bool(var_o2.dup().is_null())) {
					return Class_WC_Eval_Math.trigger(rt.new_string('unexpected \',\''))
					// unsupported statement: Stmt_Nop
				} else {
					var_output << var_o2.dup()
					// unsupported statement: Stmt_Nop
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^([A-Za-z]\\w*)\\($/'), rt.call_method(var_stack, 'last', [rt.new_int(2)]), var_matches.dup()]))))) {
				return Class_WC_Eval_Math.trigger(rt.new_string('unexpected \',\''))
			}
			rt.call_method(var_stack, 'push', [rt.add(rt.call_method(var_stack, 'pop', []rt.PhpVal{}), rt.new_int(1))])
			rt.call_method(var_stack, 'push', [rt.new_string('(')])
			rt.post_inc(var_index)
			var_expecting_op = rt.new_bool(rt.new_bool(false))
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('('), var_op)) && rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))))) {
			rt.call_method(var_stack, 'push', [rt.new_string('(')])
			rt.post_inc(var_index)
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.new_bool(rt.is_true(var_ex) && rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))))) {
			var_expecting_op = rt.new_bool(rt.new_bool(true))
			mut var_val := var_match.array_get(1)
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^([A-Za-z]\\w*)\\($/'), var_val.dup(), var_matches.dup()])) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_matches.array_get(1), // unsupported expression: Expr_StaticPropertyFetch])) || rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_matches.array_get(1)))))) {
					rt.call_method(var_stack, 'push', [var_val.dup()])
					rt.call_method(var_stack, 'push', [rt.new_int(1)])
					rt.call_method(var_stack, 'push', [rt.new_string('(')])
					var_expecting_op = rt.new_bool(rt.new_bool(false))
				} else {
					var_val = var_matches.array_get(1)
					var_output << var_val.dup()
				}
			} else {
				var_output << var_val.dup()
			}
			// unsupported expression: Expr_AssignOp_Plus
			// unsupported statement: Stmt_Nop
		} else if rt.is_true(rt.identical(rt.new_string(')'), var_op)) {
			return Class_WC_Eval_Math.trigger(rt.new_string('unexpected \')\''))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_op.dup(), var_ops.dup()])) && rt.is_true(rt.new_bool(!(rt.is_true(var_expecting_op)))))) {
			return Class_WC_Eval_Math.trigger(rt.new_string("unexpected operator '${var_op.to_string()}'"))
		} else {
			return Class_WC_Eval_Math.trigger(rt.new_string('an unexpected error occurred'))
		}
		if rt.is_true(rt.equal(rt.new_int(var_expr_mutated.dup().to_string().len), var_index)) {
			if rt.is_true(rt.call_function('in_array', [var_op.dup(), var_ops.dup()])) {
				return Class_WC_Eval_Math.trigger(rt.new_string("operator '${var_op.to_string()}' lacks operand"))
			} else {
				break
			}
		}
		for rt.is_true(rt.equal(rt.call_function('substr', [var_expr_mutated.dup(), var_index.dup(), rt.new_int(1)]), rt.new_string(' '))) {
			rt.post_inc(var_index)
			// unsupported statement: Stmt_Nop
		}
	}
	for rt.is_true() {
	}
}

fn Class_WC_Eval_Math.pfx(var_tokens rt.PhpVal, var_vars rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
}

fn Class_WC_Eval_Math.trigger(var_msg rt.PhpVal) bool {
}

fn Class_WC_Eval_Math.debugprintcallingfunction()  {
}

struct Class_WC_Eval_Math_Stack {
	rt.PhpObjectBase
}

fn create_wc_eval_math() &Class_WC_Eval_Math {
	mut obj := &Class_WC_Eval_Math{
		PhpObjectBase: rt.PhpObjectBase{}
		last_error: rt.new_null()
		v: rt.new_array()
		f: rt.new_array()
		vb: rt.new_array()
		fb: rt.new_array()
	}
	return obj
}

fn create_wc_eval_math_stack() &Class_WC_Eval_Math_Stack {
	mut obj := &Class_WC_Eval_Math_Stack{
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
		else { return none }
	}
}

fn (this &Class_WC_Eval_Math) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'last_error' { return this.last_error }
		'v' { return this.v }
		'f' { return this.f }
		'vb' { return this.vb }
		'fb' { return this.fb }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Eval_Math) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'last_error' { this.last_error = val; return true }
		'v' { this.v = val; return true }
		'f' { this.f = val; return true }
		'vb' { this.vb = val; return true }
		'fb' { this.fb = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Eval_Math_Stack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Eval_Math_Stack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Eval_Math_Stack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_libraries_class_wc_eval_math_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Eval_Math'), rt.new_bool(false)]))))) {
	}
}
