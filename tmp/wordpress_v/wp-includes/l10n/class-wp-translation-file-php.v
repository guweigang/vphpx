import rt

struct Class_WP_Translation_File_PHP {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Translation_File_PHP) parse_file()  {
	this.dispatch_set_prop('parsed', rt.new_bool(true))
	mut var_result := rt.include_file((rt.get_property(rt.new_object('WP_Translation_File_PHP', ['WP_Translation_File'], &this), 'file')).to_string(), '1')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_result.dup().is_array()))))))) {
		this.dispatch_set_prop('error', rt.new_string('Invalid data'))
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_result.array_isset(rt.new_string('messages')) && rt.is_true(rt.new_bool(var_result.array_get('messages').is_array())))) {
		{
			mut iter_1 := var_result.array_get('messages').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_translation := item_1.val
				mut var_original := item_1.key
				rt.get_property(rt.new_object('WP_Translation_File_PHP', ['WP_Translation_File'], &this), 'entries').array_set(// unsupported expression: Expr_Cast_String, var_translation.dup())
			}
		}
		var_result.array_unset(rt.new_string('messages'))
	}
	this.dispatch_set_prop('headers', rt.call_function('array_change_key_case', [var_result.dup()]))
}

fn (mut this Class_WP_Translation_File_PHP) export() string {
	mut var_data := rt.call_function('array_merge', [rt.get_property(rt.new_object('WP_Translation_File_PHP', ['WP_Translation_File'], &this), 'headers'), rt.create_array([rt.ArrayItem{ key: 'messages', val: rt.get_property(rt.new_object('WP_Translation_File_PHP', ['WP_Translation_File'], &this), 'entries') }])])
	return '<?php' + (rt.get_constant('PHP_EOL')).str() + 'return ' + this.var_export(var_data.dup()) + ';' + (rt.get_constant('PHP_EOL')).str()
}

fn (mut this Class_WP_Translation_File_PHP) var_export(var_value rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
		return (rt.call_function('var_export', [var_value.dup(), rt.new_bool(true)])).str()
	}
	mut var_entries := []rt.PhpVal{}
	mut var_is_list := rt.call_function('array_is_list', [var_value.dup()])
	{
		mut iter_1 := var_value.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_val := item_1.val
			mut var_key := item_1.key
			var_entries << if rt.is_true(var_is_list) { this.var_export(var_val.dup()) } else { (rt.call_function('var_export', [var_key.dup(), rt.new_bool(true)])).str() + '=>' + this.var_export(var_val.dup()) }
		}
	}
	return '[' + (rt.call_function('implode', [rt.new_string(','), var_entries.dup()])).str() + ']'
}

struct Class_WP_Translation_File {
	rt.PhpObjectBase
}

fn create_wp_translation_file_php() &Class_WP_Translation_File_PHP {
	mut obj := &Class_WP_Translation_File_PHP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_translation_file() &Class_WP_Translation_File {
	mut obj := &Class_WP_Translation_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Translation_File_PHP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse_file' {
			this.parse_file()
			return rt.new_null()
		}
		'export' {
			return rt.new_string(this.export())
		}
		'var_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.var_export(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Translation_File_PHP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_File_PHP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Translation_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translation_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_l10n_class_wp_translation_file_php_php() {
}
