import rt

struct Class_Automattic_WooCommerce_Blueprint_ClassExtractor {
	rt.PhpObjectBase
pub mut:
		file_path string
		has_strict_types_declaration bool
		prefix rt.PhpVal = rt.new_string('')
		class_variable_replacements rt.PhpVal = rt.new_array()
		method_variable_replacements rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) construct(file_path string)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(file_path)]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Blueprint_InvalidArgumentException', []string{}, create_automattic_woocommerce_blueprint_invalidargumentexception(rt.new_string("File not found: ${var_file_path}"))))
	}
	this.file_path = file_path
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) with_wp_load() rt.PhpVal {
	// unsupported expression: Expr_AssignOp_Concat
	return rt.new_object('Automattic_WooCommerce_Blueprint_ClassExtractor', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) replace_class_variable(var_variable_name rt.PhpVal, var_new_value rt.PhpVal) rt.PhpVal {
	this.class_variable_replacements.array_set(var_variable_name, var_new_value.dup())
	return rt.new_object('Automattic_WooCommerce_Blueprint_ClassExtractor', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) replace_method_variable(var_method_name rt.PhpVal, var_variable_name rt.PhpVal, var_new_value rt.PhpVal) rt.PhpVal {
	this.method_variable_replacements.array_push(rt.create_array([rt.ArrayItem{ key: 'method', val: var_method_name }, rt.ArrayItem{ key: 'variable', val: var_variable_name }, rt.ArrayItem{ key: 'value', val: var_new_value }]))
	return rt.new_object('Automattic_WooCommerce_Blueprint_ClassExtractor', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) get_code() string {
	mut var_file_content := rt.call_function('file_get_contents', [this.file_path])
	var_file_content = rt.call_function('preg_replace', [rt.new_string('/<\\?php\\s*/'), rt.new_string(''), var_file_content.dup()])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/declare\\s*\\(\\s*strict_types\\s*=\\s*1\\s*\\)\\s*;/'), var_file_content.dup()])) {
		this.has_strict_types_declaration = true
		var_file_content = rt.call_function('preg_replace', [rt.new_string('/declare\\s*\\(\\s*strict_types\\s*=\\s*1\\s*\\)\\s*;/'), rt.new_string(''), var_file_content.dup()])
	}
	var_file_content = rt.call_function('preg_replace', [rt.new_string('/\\/\\*.*?\\*\\/|\\/\\/.*?(?=\\r?\\n)/s'), rt.new_string(''), var_file_content.dup()])
	{
		mut iter_1 := this.class_variable_replacements.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_variable := item_1.key
			var_file_content = this.apply_class_variable_replacement(var_file_content.dup(), var_variable.dup(), var_value.dup())
		}
	}
	{
		mut iter_1 := this.method_variable_replacements.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_replacement := item_1.val
			var_file_content = this.apply_variable_replacement(var_file_content.dup(), var_replacement.array_get('method'), var_replacement.array_get('variable'), var_replacement.array_get('value'))
		}
	}
	return (this.prefix).str() + var_file_content.dup().to_string().trim_space()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) apply_class_variable_replacement(var_file_content rt.PhpVal, var_variable_name rt.PhpVal, var_new_value rt.PhpVal) rt.PhpVal {
	mut var_file_content_mutated := var_file_content
	mut var_replacement_value := rt.call_function('var_export', [var_new_value.dup(), rt.new_bool(true)])
	mut var_pattern := rt.new_string('/(protected|private|public)\\s+\\$' + (rt.call_function('preg_quote', [var_variable_name.dup(), rt.new_string('/')])).str() + '\\s*=\\s*.*?;|' + '(protected|private|public)\\s+\\$' + (rt.call_function('preg_quote', [var_variable_name.dup(), rt.new_string('/')])).str() + '\\s*;?/')
	mut var_replacement := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('$1 $'), var_variable_name), rt.new_string(' = ')), var_replacement_value), rt.new_string(';')))
	return rt.call_function('preg_replace', [var_pattern.dup(), var_replacement.dup(), var_file_content_mutated.dup(), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) apply_variable_replacement(var_file_content rt.PhpVal, var_method_name rt.PhpVal, var_variable_name rt.PhpVal, var_new_value rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_file_content_mutated := var_file_content
	mut var_pattern := rt.new_string('/function\\s+' + (rt.call_function('preg_quote', [var_method_name.dup(), rt.new_string('/')])).str() + '\\s*\\([^)]*\\)\\s*\\{\\s*(.*?)\\s*\\}/s')
	if rt.is_true(rt.call_function('preg_match', [var_pattern.dup(), var_file_content_mutated.dup(), var_matches.dup()])) {
		mut var_method_body := var_matches.array_get(1)
		mut var_new_value_exported := rt.call_function('var_export', [var_new_value.dup(), rt.new_bool(true)])
		mut var_variable_pattern := rt.new_string('/\\$' + (rt.call_function('preg_quote', [var_variable_name.dup(), rt.new_string('/')])).str() + '\\s*=\\s*[^;]+;/')
		mut var_replacement := rt.new_string('$' + (var_variable_name).str() + ' = ' + (var_new_value_exported).str() + ';')
		mut var_updated_method_body := rt.call_function('preg_replace', [var_variable_pattern.dup(), var_replacement.dup(), var_method_body.dup(), rt.new_int(1)])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_file_content_mutated = rt.call_function('str_replace', [var_method_body.dup(), var_updated_method_body.dup(), var_file_content_mutated.dup()])
		}
	}
	return var_file_content_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) has_strict_type_declaration() bool {
	return this.has_strict_types_declaration
}

struct Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_classextractor(file_path string) &Class_Automattic_WooCommerce_Blueprint_ClassExtractor {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_ClassExtractor{
		PhpObjectBase: rt.PhpObjectBase{}
		file_path: ''
		has_strict_types_declaration: false
		prefix: rt.new_string('')
		class_variable_replacements: rt.new_array()
		method_variable_replacements: rt.new_array()
	}
	obj.construct(file_path)
	return obj
}

fn create_automattic_woocommerce_blueprint_invalidargumentexception() &Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'with_wp_load' {
			return this.with_wp_load()
		}
		'replace_class_variable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.replace_class_variable(dispatch_arg_0, dispatch_arg_1)
		}
		'replace_method_variable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.replace_method_variable(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_code' {
			return rt.new_string(this.get_code())
		}
		'apply_class_variable_replacement' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.apply_class_variable_replacement(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'apply_variable_replacement' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.apply_variable_replacement(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'has_strict_type_declaration' {
			return rt.new_bool(this.has_strict_type_declaration())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_ClassExtractor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file_path' { return rt.new_string(this.file_path) }
		'has_strict_types_declaration' { return rt.new_bool(this.has_strict_types_declaration) }
		'prefix' { return this.prefix }
		'class_variable_replacements' { return this.class_variable_replacements }
		'method_variable_replacements' { return this.method_variable_replacements }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_ClassExtractor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'file_path' { this.file_path = (val).str(); return true }
		'has_strict_types_declaration' { this.has_strict_types_declaration = (val).to_bool(); return true }
		'prefix' { this.prefix = val; return true }
		'class_variable_replacements' { this.class_variable_replacements = val; return true }
		'method_variable_replacements' { this.method_variable_replacements = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_classextractor_php() {
}
