import rt

struct Class_Automattic_WooCommerce_Blueprint_Util {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blueprint_Util.ensure_wp_content_path(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	var_path_mutated = rt.call_function('realpath', [var_path_mutated.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_path_mutated))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_path_mutated.clone(), rt.get_constant('WP_CONTENT_DIR')]), rt.new_int(0))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_InvalidArgumentException',
			[]string{},
			create_automattic_woocommerce_blueprint_invalidargumentexception(rt.new_string('Invalid path: ${var_path.to_string()}'))))
	}
	return var_path_mutated.clone()
}

fn Class_Automattic_WooCommerce_Blueprint_Util.array_to_insert_sql(var_row rt.PhpVal, var_table rt.PhpVal, type string) rt.PhpVal {
	mut var_value := rt.new_null()
	if !rt.is_true(var_row) || !(var_row.clone().is_array()) {
		return rt.new_bool(false)
	}
	mut var_allowed_types := rt.create_array([rt.ArrayItem{ key: none, val: 'insert' },
		rt.ArrayItem{ key: none, val: 'insert ignore' }, rt.ArrayItem{
			key: none
			val: 'replace into'
		}])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(type),
		var_allowed_types.clone(),
		rt.new_bool(true),
	])))))
	{
		return rt.new_bool(false)
	}
	mut var_columns := rt.new_string('`' +
		(rt.call_function('implode', [rt.new_string('`, `'), rt.func_array_keys(var_row.clone())])).str() +
		'`')
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return "'" + (rt.call_function('addslashes', [var_value.clone()])).str() + "'"
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return "'" + (rt.call_function('addslashes', [var_value.clone()])).str() + "'"
	}
	mut var_escaped_values := rt.call_function('array_map', [
		rt.new_closure(closure_1_fn),
		var_row.clone(),
	])
	mut var_values := rt.call_function('implode', [rt.new_string(', '),
		var_escaped_values.clone()])
	return rt.new_string('${var_type} `${var_table.to_string()}` (${var_columns.to_string()}) VALUES (${var_values.to_string()});')
}

fn Class_Automattic_WooCommerce_Blueprint_Util.snake_to_camel(var_string_to_convert rt.PhpVal) rt.PhpVal {
	mut var_words := rt.call_function('explode', [rt.new_string('_'),
		var_string_to_convert.clone()])
	var_words = rt.call_function('array_map', [rt.new_string('ucfirst'),
		var_words.clone()])
	return rt.call_function('implode', [rt.new_string(''), var_words.clone()])
}

fn Class_Automattic_WooCommerce_Blueprint_Util.array_flatten(var_array_to_flatten rt.PhpVal) rt.PhpVal {
	return rt.new_object('RecursiveIteratorIterator', []string{},
		create_recursiveiteratoriterator(create_recursivearrayiterator(var_array_to_flatten.clone())))
}

fn Class_Automattic_WooCommerce_Blueprint_Util.camel_to_snake(var_input rt.PhpVal) string {
	mut var_pattern := rt.new_string('/([a-z])([A-Z])/')
	mut var_replacement := rt.new_string('$1_$2')
	mut var_snake := rt.call_function('preg_replace', [var_pattern.clone(),
		var_replacement.clone(), var_input.clone()])
	var_snake = rt.call_function('str_replace', [rt.new_string(' '),
		rt.new_string('_'), var_snake.clone()])
	return var_snake.clone().to_string().to_lower()
}

fn Class_Automattic_WooCommerce_Blueprint_Util.index_array(var_array rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_array()
	mut iter_1 := var_array.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		mut var_new_key := rt.call_callable(var_callback, [var_key.clone(),
			var_value.clone()])
		var_result.array_set(var_new_key, var_value.clone())
	}
	return var_result.clone()
}

fn Class_Automattic_WooCommerce_Blueprint_Util.is_valid_wp_plugin_slug(var_slug rt.PhpVal) bool {
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z0-9-]+$/'),
		var_slug.clone()]))
	{
		return true
	}
	return false
}

fn Class_Automattic_WooCommerce_Blueprint_Util.delete_dir(var_dir_path rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [
		var_dir_path.clone()])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_InvalidArgumentException',
			[]string{},
			create_automattic_woocommerce_blueprint_invalidargumentexception(rt.new_string('${var_dir_path.to_string()} must be a directory'))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [
		var_dir_path.clone(),
		rt.new_int(var_dir_path.clone().to_string().len - 1),
		rt.new_int(1),
	]), rt.new_string('/')))))
	{
		var_dir_path = rt.concat(var_dir_path, rt.new_string('/'))
	}
	mut var_files := rt.call_function('glob', [rt.new_string(var_dir_path.str() + '*'),
		rt.get_constant('GLOB_MARK')])
	mut iter_2 := var_files.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_file := item_2.val
		if rt.is_true(rt.call_function('is_dir', [var_file.clone()])) {
			Class_Automattic_WooCommerce_Blueprint_Util.delete_dir(var_file.clone())
		} else {
			rt.call_function('unlink', [var_file.clone()])
		}
	}
	rt.call_function('rmdir', [var_dir_path.clone()])
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

fn create_automattic_woocommerce_blueprint_util(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Util {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursiveiteratoriterator(_args ...rt.PhpVal) &Class_RecursiveIteratorIterator {
	mut obj := &Class_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursivearrayiterator(_args ...rt.PhpVal) &Class_RecursiveArrayIterator {
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
			return Class_Automattic_WooCommerce_Blueprint_Util.array_to_insert_sql(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
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
			return Class_Automattic_WooCommerce_Blueprint_Util.index_array(dispatch_arg_0,
				dispatch_arg_1)
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
