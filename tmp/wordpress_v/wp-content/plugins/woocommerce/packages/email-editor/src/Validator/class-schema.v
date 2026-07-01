import rt

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	rt.PhpObjectBase
pub mut:
		schema rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) nullable() rt.PhpVal {
	mut var_type := if !(this.schema.array_get('type')).is_null() { this.schema.array_get('type') } else { rt.create_array([rt.ArrayItem{ key: none, val: 'null' }]) }
	return this.update_schema_property('type', if rt.is_true(rt.new_bool(var_type.dup().is_array())) { var_type } else { rt.create_array([rt.ArrayItem{ key: none, val: var_type }, rt.ArrayItem{ key: none, val: 'null' }]) })
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) non_nullable() rt.PhpVal {
	mut var_type := if !(this.schema.array_get('type')).is_null() { this.schema.array_get('type') } else { rt.new_null() }
	return if rt.is_true(rt.identical(rt.new_null(), var_type)) { this.unset_schema_property('type') } else { this.update_schema_property('type', if rt.is_true(rt.new_bool(var_type.dup().is_array())) { var_type.array_get(0) } else { var_type }) }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) required() rt.PhpVal {
	return this.update_schema_property('required', rt.new_bool(true))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) optional() rt.PhpVal {
	return this.unset_schema_property('required')
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) title(title string) rt.PhpVal {
	return this.update_schema_property('title', rt.new_string(title))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) description(description string) rt.PhpVal {
	return this.update_schema_property('description', rt.new_string(description))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) default(var_default_value rt.PhpVal) rt.PhpVal {
	return this.update_schema_property('default', var_default_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) field(name string, var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array', [rt.new_string(name), this.get_reserved_keywords(), rt.new_bool(true)])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Validator_Exception', []string{}, create_automattic_woocommerce_emaileditor_validator_exception(rt.call_function('esc_html', [rt.new_string("Field name '${var_name}' is reserved")]))))
	}
	return this.update_schema_property(name, var_value.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) to_array() rt.PhpVal {
	return this.schema
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) to_string() string {
	mut var_json := rt.call_function('wp_json_encode', [this.schema, rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_UNESCAPED_UNICODE'), rt.get_constant('JSON_UNESCAPED_SLASHES')), rt.get_constant('JSON_PRESERVE_ZERO_FRACTION'))])
	mut var_error := rt.call_function('json_last_error', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_error) || rt.is_true(rt.identical(rt.new_bool(false), var_json)))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Validator_Exception', []string{}, create_automattic_woocommerce_emaileditor_validator_exception(rt.call_function('esc_html', [rt.call_function('json_last_error_msg', []rt.PhpVal{})]), rt.new_int(0))))
	}
	return (var_json).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) update_schema_property(name string, var_value rt.PhpVal) rt.PhpVal {
	mut var_clone := // unsupported expression: Expr_Clone
	rt.get_property(var_clone, 'schema').array_set(name, var_value.dup())
	return var_clone.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) unset_schema_property(name string) rt.PhpVal {
	mut var_clone := // unsupported expression: Expr_Clone
	rt.get_property(var_clone, 'schema').array_unset(rt.new_string(name))
	return var_clone.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) get_reserved_keywords() rt.PhpVal {
	return rt.call_function('rest_get_allowed_schema_keywords', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) validate_pattern(pattern string)  {
	mut var_escaped := rt.call_function('str_replace', [rt.new_string('#'), rt.new_string('\\#'), rt.new_string(pattern)])
	mut var_regex := rt.new_string(rt.new_string("#${var_escaped.to_string()}#u"))
	if rt.is_true(rt.identical(rt.call_function('preg_match', [var_regex.dup(), rt.new_string('')]), rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Validator_Exception', []string{}, create_automattic_woocommerce_emaileditor_validator_exception(rt.call_function('esc_html', [rt.new_string("Invalid regular expression '${var_regex.to_string()}'")]))))
	}
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_validator_schema() &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
		schema: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_exception() &Class_Automattic_WooCommerce_EmailEditor_Validator_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'nullable' {
			return this.nullable()
		}
		'non_nullable' {
			return this.non_nullable()
		}
		'required' {
			return this.required()
		}
		'optional' {
			return this.optional()
		}
		'title' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.title(dispatch_arg_0)
		}
		'description' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.description(dispatch_arg_0)
		}
		'default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.default(dispatch_arg_0)
		}
		'field' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.field(dispatch_arg_0, dispatch_arg_1)
		}
		'to_array' {
			return this.to_array()
		}
		'to_string' {
			return rt.new_string(this.to_string())
		}
		'update_schema_property' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_schema_property(dispatch_arg_0, dispatch_arg_1)
		}
		'unset_schema_property' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.unset_schema_property(dispatch_arg_0)
		}
		'get_reserved_keywords' {
			return this.get_reserved_keywords()
		}
		'validate_pattern' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.validate_pattern(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schema' { return this.schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schema' { this.schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_validator_class_schema_php() {
	// unsupported statement: Stmt_Declare
}
