import rt

fn main() {
	defer {
		rt.shutdown()
	}

	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_client_prefix := rt.new_string('WordPress\\AiClient\\')
		mut var_client_prefix_len := rt.new_int(19)
		mut var_scoped_prefix := rt.new_string('WordPress\\AiClientDependencies\\')
		mut var_scoped_prefix_len := rt.new_int(31)
		mut var_base_dir := rt.new_string(@DIR)
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strncmp', [
			var_class_name.clone(),
			var_client_prefix.clone(),
			var_client_prefix_len.clone(),
		])))
		{
			mut var_relative_class := rt.call_function('substr', [
				var_class_name.clone(), var_client_prefix_len.clone()])
			mut var_file := rt.new_string(var_base_dir.str() + '/src/' +
				(rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.clone()])).str() +
				'.php')
			if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
				rt.include_file(var_file.to_string(), '3')
			}
			return rt.new_null()
		}
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strncmp', [
			var_class_name.clone(),
			var_scoped_prefix.clone(),
			var_scoped_prefix_len.clone(),
		])))
		{
			var_relative_class = rt.call_function('substr', [
				var_class_name.clone(), var_scoped_prefix_len.clone()])
			var_file = rt.new_string(var_base_dir.str() + '/third-party/' +
				(rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.clone()])).str() +
				'.php')
			if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
				rt.include_file(var_file.to_string(), '3')
			}
			return rt.new_null()
		}
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_client_prefix := rt.new_string('WordPress\\AiClient\\')
		mut var_client_prefix_len := rt.new_int(19)
		mut var_scoped_prefix := rt.new_string('WordPress\\AiClientDependencies\\')
		mut var_scoped_prefix_len := rt.new_int(31)
		mut var_base_dir := rt.new_string(@DIR)
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strncmp', [
			var_class_name.clone(),
			var_client_prefix.clone(),
			var_client_prefix_len.clone(),
		])))
		{
			mut var_relative_class := rt.call_function('substr', [
				var_class_name.clone(), var_client_prefix_len.clone()])
			mut var_file := rt.new_string(var_base_dir.str() + '/src/' +
				(rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.clone()])).str() +
				'.php')
			if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
				rt.include_file(var_file.to_string(), '3')
			}
			return rt.new_null()
		}
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strncmp', [
			var_class_name.clone(),
			var_scoped_prefix.clone(),
			var_scoped_prefix_len.clone(),
		])))
		{
			var_relative_class = rt.call_function('substr', [
				var_class_name.clone(), var_scoped_prefix_len.clone()])
			var_file = rt.new_string(var_base_dir.str() + '/third-party/' +
				(rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), var_relative_class.clone()])).str() +
				'.php')
			if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
				rt.include_file(var_file.to_string(), '3')
			}
			return rt.new_null()
		}
		return rt.new_null()
	}
	rt.call_function('spl_autoload_register', [rt.new_closure(closure_1_fn)])
}
