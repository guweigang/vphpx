import rt



pub fn init_wp_includes_sodium_compat_lib_namespaced_php() {
	rt.include_file((rt.call_function('dirname', [rt.call_function('dirname', [rt.new_string(@FILE)])])).str() + '/autoload.php', '4')
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(50300))) {
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.identical(var_class.array_get(0), rt.new_string('\\'))) {
		var_class = rt.call_function('substr', [var_class.dup(), rt.new_int(1)])
	}
	mut var_namespace := rt.new_string(rt.new_string('ParagonIE\\Sodium'))
	mut var_len := rt.new_int(rt.new_int(var_namespace.dup().to_string().len))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_bool(false)
	}
	mut var_relative_class := rt.call_function('substr', [var_class.dup(), var_len.dup()])
	mut var_file := rt.new_string((rt.call_function('dirname', [rt.call_function('dirname', [rt.new_string(@FILE)])])).str() + '/namespaced/' + (rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.dup()])).str() + '.php')
	if rt.is_true(rt.call_function('file_exists', [var_file.dup()])) {
		rt.include_file((var_file).to_string(), '4')
		return rt.new_bool(true)
	}
	return rt.new_bool(false)
	}
	mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.identical(var_class.array_get(0), rt.new_string('\\'))) {
		var_class = rt.call_function('substr', [var_class.dup(), rt.new_int(1)])
	}
	mut var_namespace := rt.new_string(rt.new_string('ParagonIE\\Sodium'))
	mut var_len := rt.new_int(rt.new_int(var_namespace.dup().to_string().len))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_bool(false)
	}
	mut var_relative_class := rt.call_function('substr', [var_class.dup(), var_len.dup()])
	mut var_file := rt.new_string((rt.call_function('dirname', [rt.call_function('dirname', [rt.new_string(@FILE)])])).str() + '/namespaced/' + (rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.dup()])).str() + '.php')
	if rt.is_true(rt.call_function('file_exists', [var_file.dup()])) {
		rt.include_file((var_file).to_string(), '4')
		return rt.new_bool(true)
	}
	return rt.new_bool(false)
	}
	rt.call_function('spl_autoload_register', [rt.new_closure(closure_1_fn)])
}
