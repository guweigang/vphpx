import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70000))) {
		return rt.new_null()
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_namespace := rt.new_string('ParagonIE_Sodium_')
		mut var_len := rt.new_int(var_namespace.clone().to_string().len)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strncmp', [
			var_namespace.clone(),
			var_class.clone(),
			var_len.clone(),
		]), rt.new_int(0)))))
		{
			return rt.new_bool(false)
		}
		mut var_relative_class := rt.call_function('substr', [
			var_class.clone(), var_len.clone()])
		mut var_file := rt.new_string((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/src/' +
			(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('/'), var_relative_class.clone()])).str() +
			'.php')
		if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
			rt.include_file(var_file.to_string(), '4')
			return rt.new_bool(true)
		}
		return rt.new_bool(false)
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_namespace := rt.new_string('ParagonIE_Sodium_')
		mut var_len := rt.new_int(var_namespace.clone().to_string().len)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strncmp', [
			var_namespace.clone(),
			var_class.clone(),
			var_len.clone(),
		]), rt.new_int(0)))))
		{
			return rt.new_bool(false)
		}
		mut var_relative_class := rt.call_function('substr', [
			var_class.clone(), var_len.clone()])
		mut var_file := rt.new_string((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/src/' +
			(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('/'), var_relative_class.clone()])).str() +
			'.php')
		if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
			rt.include_file(var_file.to_string(), '4')
			return rt.new_bool(true)
		}
		return rt.new_bool(false)
	}
	rt.call_function('spl_autoload_register', [rt.new_closure(closure_1_fn)])
}
