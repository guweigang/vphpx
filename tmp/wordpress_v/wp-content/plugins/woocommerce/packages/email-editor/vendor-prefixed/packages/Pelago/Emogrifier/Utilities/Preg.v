import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	rt.PhpObjectBase
pub mut:
		throwExceptions rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) throwexceptions(throw bool) rt.PhpVal {
	this.throwExceptions = rt.new_bool(throw).dup()
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) replace(var_pattern rt.PhpVal, var_replacement rt.PhpVal, subject string, limit i64, mut var_count Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?int) string {
	mut var_result := rt.call_function('preg_replace', [var_pattern.dup(), var_replacement.dup(), rt.new_string(subject), rt.new_int(limit), var_count])
	if rt.is_true(rt.identical(var_result, rt.new_null())) {
		this.logorthrowpreglasterror()
		var_result = rt.new_string(rt.new_string(subject))
	}
	return (var_result).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) replacecallback(var_pattern rt.PhpVal, mut var_callback Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_callable, subject string, limit i64, mut var_count Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?int) string {
	mut var_result := rt.call_function('preg_replace_callback', [var_pattern.dup(), var_callback, rt.new_string(subject), rt.new_int(limit), var_count])
	if rt.is_true(rt.identical(var_result, rt.new_null())) {
		this.logorthrowpreglasterror()
		var_result = rt.new_string(rt.new_string(subject))
	}
	return (var_result).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) split(pattern string, subject string, limit i64, flags i64) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException', []string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_runtimeexception(rt.new_string('PREG_SPLIT_OFFSET_CAPTURE is not supported by Preg::split'), rt.new_int(1726506348))))
	}
	mut var_result := rt.call_function('preg_split', [rt.new_string(pattern), rt.new_string(subject), rt.new_int(limit), rt.new_int(flags)])
	if rt.is_true(rt.identical(var_result, rt.new_bool(false))) {
		this.logorthrowpreglasterror()
		var_result = rt.create_array([rt.ArrayItem{ key: none, val: subject }])
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) match(pattern string, subject string, mut var_matches Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?array) i64 {
	mut var_matches_mutated := var_matches
	mut var_result := rt.call_function('preg_match', [rt.new_string(pattern), rt.new_string(subject), var_matches_mutated.dup()])
	if rt.is_true(rt.identical(var_result, rt.new_bool(false))) {
		this.logorthrowpreglasterror()
		var_result = rt.new_int(rt.new_int(0))
		var_matches_mutated = rt.new_array()
	}
	return (var_result).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) matchall(pattern string, subject string, mut var_matches Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?array) i64 {
	mut var_matches_mutated := var_matches
	mut var_result := rt.call_function('preg_match_all', [rt.new_string(pattern), rt.new_string(subject), var_matches_mutated.dup()])
	if rt.is_true(rt.identical(var_result, rt.new_bool(false))) {
		this.logorthrowpreglasterror()
		var_result = rt.new_int(rt.new_int(0))
		var_matches_mutated = rt.call_function('array_fill', [rt.new_int(0), rt.add(rt.call_function('substr_count', [rt.new_string(pattern), rt.new_string('(')]), rt.new_int(1)), rt.new_array()])
	}
	return (var_result).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) logorthrowpreglasterror()  {
	mut var_pcreConstants := rt.call_function('get_defined_constants', [rt.new_bool(true)]).array_get('pcre')
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.call_function('substr', [var_key.dup(), // unsupported expression: Expr_UnaryMinus]), rt.new_string('_ERROR'))
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.call_function('substr', [var_key.dup(), // unsupported expression: Expr_UnaryMinus]), rt.new_string('_ERROR'))
	}
	mut var_pcreErrorConstantNames := rt.call_function('array_flip', [rt.call_function('array_filter', [var_pcreConstants.dup(), rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])])
	mut var_pregLastError := rt.call_function('preg_last_error', []rt.PhpVal{})
	mut var_message := rt.new_string('PCRE regex execution error `' + (// unsupported expression: Expr_Cast_String).str() + '`')
	if rt.is_true(this.throwExceptions) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException', []string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_runtimeexception(var_message.dup(), rt.new_int(1592870147))))
	}
	rt.call_function('trigger_error', [var_message.dup()])
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg{
		PhpObjectBase: rt.PhpObjectBase{}
		throwExceptions: rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_runtimeexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'throwExceptions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.throwexceptions(dispatch_arg_0)
		}
		'replace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?int](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.replace(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'replaceCallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?int](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.replacecallback(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'split' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return this.split(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'match' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_int(this.match(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'matchAll' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_int(this.matchall(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'logOrThrowPregLastError' {
			this.logorthrowpreglasterror()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'throwExceptions' { return this.throwExceptions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'throwExceptions' { this.throwExceptions = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_pelago_emogrifier_utilities_preg_php() {
	// unsupported statement: Stmt_Declare
}
