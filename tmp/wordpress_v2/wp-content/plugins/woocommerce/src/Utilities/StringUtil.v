import rt

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.starts_with(string string, starts_with string, case_sensitive bool) bool {
	mut string_mutated := string
	mut var_len := rt.new_int(starts_with.len)
	if rt.is_true(rt.greater(var_len, rt.new_int(string_mutated.len))) {
		return false
	}
	string_mutated = (rt.call_function('substr', [rt.new_string(string_mutated).clone(), rt.new_int(0), var_len.clone()])).str()
	if var_case_sensitive {
		return (rt.identical(rt.call_function('strcmp', [rt.new_string(string_mutated).clone(), rt.new_string(starts_with)]), rt.new_int(0))).to_bool()
	}
	return (rt.identical(rt.call_function('strcasecmp', [rt.new_string(string_mutated).clone(), rt.new_string(starts_with)]), rt.new_int(0))).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.ends_with(string string, ends_with string, case_sensitive bool) bool {
	mut string_mutated := string
	mut var_len := rt.new_int(ends_with.len)
	if rt.is_true(rt.greater(var_len, rt.new_int(string_mutated.len))) {
		return false
	}
	string_mutated = (rt.call_function('substr', [rt.new_string(string_mutated).clone(), rt.sub(rt.new_int(0), var_len)])).str()
	if var_case_sensitive {
		return (rt.identical(rt.call_function('strcmp', [rt.new_string(string_mutated).clone(), rt.new_string(ends_with)]), rt.new_int(0))).to_bool()
	}
	return (rt.identical(rt.call_function('strcasecmp', [rt.new_string(string_mutated).clone(), rt.new_string(ends_with)]), rt.new_int(0))).to_bool()
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.contains(string string, contained string, case_sensitive bool) bool {
	mut string_mutated := string
	if var_case_sensitive {
		return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(string_mutated).clone(), rt.new_string(contained)]))))
	} else {
		return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [rt.new_string(string_mutated).clone(), rt.new_string(contained)]))))
	}
	return false
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.plugin_name_from_plugin_file(plugin_file_path string) string {
	return (rt.call_function('basename', [rt.call_function('dirname', [rt.new_string(plugin_file_path)])])).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (rt.call_function('basename', [rt.new_string(plugin_file_path)])).str()
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.is_null_or_empty(mut var_value Class_Automattic_WooCommerce_Utilities_?string) bool {
	return var_value.is_null() || rt.is_true(rt.identical(rt.new_string(''), var_value))
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.is_null_or_whitespace(mut var_value Class_Automattic_WooCommerce_Utilities_?string) bool {
	return var_value.is_null() || rt.is_true(rt.identical(rt.new_string(''), var_value)) || rt.is_true(rt.call_function('ctype_space', [var_value]))
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.to_sql_list(mut var_values Class_Automattic_WooCommerce_Utilities_array) string {
	if !rt.is_true(var_values) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Utilities_InvalidArgumentException', []string{}, create_automattic_woocommerce_utilities_invalidargumentexception((Class_Automattic_WooCommerce_Utilities_StringUtil.class_name_without_namespace(@STRUCT)).str() + '::' + @FN + ': the values array is empty')))
	}
	return '(' + (rt.call_function('implode', [rt.new_string(','), var_values])).str() + ')'
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.class_name_without_namespace(class_name string) rt.PhpVal {
	mut var_result := rt.call_function('substr', [rt.call_function('strrchr', [rt.new_string(class_name), rt.new_string('\\')]), rt.new_int(1)])
	return if rt.is_true(var_result) { var_result } else { rt.new_string(class_name) }
}

fn Class_Automattic_WooCommerce_Utilities_StringUtil.normalize_local_path_slashes(mut var_path Class_Automattic_WooCommerce_Utilities_?string) rt.PhpVal {
	return if var_path.is_null() { rt.new_null() } else { rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '\\' }, rt.ArrayItem{ key: none, val: '/' }]), rt.get_constant('DIRECTORY_SEPARATOR'), var_path]) }
}

struct Class_Automattic_WooCommerce_Utilities_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Utilities_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'starts_with' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_StringUtil.starts_with(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'ends_with' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_StringUtil.ends_with(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'contains' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_StringUtil.contains(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'plugin_name_from_plugin_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_StringUtil.plugin_name_from_plugin_file(dispatch_arg_0))
		}
		'is_null_or_empty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_StringUtil.is_null_or_empty(mut dispatch_arg_0))
		}
		'is_null_or_whitespace' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Utilities_StringUtil.is_null_or_whitespace(mut dispatch_arg_0))
		}
		'to_sql_list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_StringUtil.to_sql_list(mut dispatch_arg_0))
		}
		'class_name_without_namespace' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Utilities_StringUtil.class_name_without_namespace(dispatch_arg_0)
		}
		'normalize_local_path_slashes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Utilities_StringUtil.normalize_local_path_slashes(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
