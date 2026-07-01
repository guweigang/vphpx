import rt

struct Class_Automattic_WooCommerce_Blueprint_Util {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blueprint_Util.ensure_wp_content_path(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	var_path_mutated = rt.call_function('realpath', [var_path_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_path_mutated)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_InvalidArgumentException', []string{}, create_automattic_woocommerce_blueprint_invalidargumentexception(rt.new_string("Invalid path: ${var_path.to_string()}"))))
	}
	return var_path_mutated.dup()
}

fn Class_Automattic_WooCommerce_Blueprint_Util.array_to_insert_sql(var_row rt.PhpVal, var_table rt.PhpVal, type string) rt.PhpVal {
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(var_row) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_row.dup().is_array()))))))) {
		return rt.new_bool(false)
		// unsupported statement: Stmt_Nop
	}
	mut var_allowed_types := rt.create_array([rt.ArrayItem{ key: none, val: 'insert' }, rt.ArrayItem{ key: none, val: 'insert ignore' }, rt.ArrayItem{ key: none, val: 'replace into' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(type), var_allowed_types.dup(), rt.new_bool(true)]))))) {
		return rt.new_bool(false)
		// unsupported statement: Stmt_Nop
	}
	mut var_columns := rt.new_string('`' + (rt.call_function('implode', [rt.new_string('`, `'), rt.func_array_keys(var_row.dup())])).str() + '`')
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return '\'' + (rt.call_function('addslashes', [var_value.dup()])).str() + '\''
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return '\'' + (rt.call_function('addslashes', [var_value.dup()])).str() + '\''
	}
	mut var_escaped_values := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_row.dup()])
	mut var_values := rt.call_function('implode', [rt.new_string(', '), var_escaped_values.dup()])
	return rt.new_string("${var_type} `${var_table.to_string()}` (${var_columns.to_string()}) VALUES (${var_values.to_string()});")
}

fn Class_Automattic_WooCommerce_Blueprint_Util.snake_to_camel(var_string_to_convert rt.PhpVal) rt.PhpVal {
	mut var_words := rt.call_function('explode', [rt.new_string('_'), var_string_to_convert.dup()])
	var_words = rt.call_function('array_map', [rt.new_string('ucfirst'), var_words.dup()])
	return rt.call_function('implode', [rt.new_string(''), var_words.dup()])
}

fn Class_Automattic_WooCommerce_Blueprint_Util.array_flatten(var_array_to_flatten rt.PhpVal) rt.PhpVal {
	return create_recursiveiteratoriterator(create_recursivearrayiterator(var_array_to_flatten.dup()))
}

fn Class_Automattic_WooCommerce_Blueprint_Util.camel_to_snake(var_input rt.PhpVal) string {
	mut var_pattern := rt.new_string(rt.new_string('/([a-z])([A-Z])/'))
	mut var_replacement := rt.new_string(rt.new_string('$1_$2'))
	mut var_snake := rt.call_function('preg_replace', [var_pattern.dup(), var_replacement.dup(), var_input.dup()])
	var_snake = rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('_'), var_snake.dup()])
	return var_snake.dup().to_string().to_lower()
}

fn Class_Automattic_WooCommerce_Blueprint_Util.index_array(var_array rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_array()
	{
		mut iter_1 := var_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			mut var_new_key := rt.call_callable(var_callback, [var_key.dup(), var_value.dup()])
			var_result.array_set(var_new_key, var_value.dup())
		}
	}
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Blueprint_Util.is_valid_wp_plugin_slug(var_slug rt.PhpVal) bool {
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z0-9-]+$/'), var_slug.dup()])) {
		return true
	}
	return false
}

fn Class_Automattic_WooCommerce_Blueprint_Util.delete_dir(var_dir_path rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_dir_path.dup()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_InvalidArgumentException', []string{}, create_automattic_woocommerce_blueprint_invalidargumentexception(rt.new_string("${var_dir_path.to_string()} must be a directory"))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_files := rt.call_function('glob', [(var_dir_path).str() + '*', rt.get_constant('GLOB_MARK')])
	{
		mut iter_1 := var_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_file := item_1.val
			if rt.is_true(rt.call_function('is_dir', [var_file.dup()])) {
				Class_Automattic_WooCommerce_Blueprint_Util.delete_dir(var_file.dup())
			} else {
				rt.call_function('unlink', [var_file.dup()])
			}
		}
	}
	rt.call_function('rmdir', [var_dir_path.dup()])
}

struct Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_RecursiveIteratorIterator {
	rt.PhpObjectBase
}

struct Class_RecursiveArrayIterator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_util() &Class_Automattic_WooCommerce_Blueprint_Util {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_invalidargumentexception() &Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursiveiteratoriterator() &Class_RecursiveIteratorIterator {
	mut obj := &Class_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursivearrayiterator() &Class_RecursiveArrayIterator {
	mut obj := &Class_RecursiveArrayIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'ensure_wp_content_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blueprint_Util.ensure_wp_content_path(dispatch_arg_0)
		}
		'array_to_insert_sql' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blueprint_Util.array_to_insert_sql(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'snake_to_camel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blueprint_Util.snake_to_camel(dispatch_arg_0)
		}
		'array_flatten' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blueprint_Util.array_flatten(dispatch_arg_0)
		}
		'camel_to_snake' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Blueprint_Util.camel_to_snake(dispatch_arg_0))
		}
		'index_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blueprint_Util.index_array(dispatch_arg_0, dispatch_arg_1)
		}
		'is_valid_wp_plugin_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blueprint_Util.is_valid_wp_plugin_slug(dispatch_arg_0))
		}
		'delete_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Blueprint_Util.delete_dir(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RecursiveIteratorIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveIteratorIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RecursiveArrayIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveArrayIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveArrayIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_util_php() {
}
