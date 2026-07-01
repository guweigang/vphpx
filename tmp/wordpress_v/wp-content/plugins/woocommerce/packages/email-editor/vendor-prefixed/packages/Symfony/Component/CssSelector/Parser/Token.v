import rt

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_file_end() string {
	return 'eof'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_delimiter() string {
	return 'delimiter'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_whitespace() string {
	return 'whitespace'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_identifier() string {
	return 'identifier'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_hash() string {
	return 'hash'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_number() string {
	return 'number'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_string() string {
	return 'string'
}
struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token {
	rt.PhpObjectBase
pub mut:
		prop_type rt.PhpVal = rt.new_null()
		value rt.PhpVal = rt.new_null()
		position rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) construct(mut var_type Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_?string, mut var_value Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_?string, mut var_position Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_?int)  {
	this.prop_type = var_type.dup()
	this.value = var_value.dup()
	this.position = var_position.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) gettype() i64 {
	return (this.prop_type).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) getvalue() string {
	return (this.value).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) getposition() i64 {
	return (this.position).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) isfileend() bool {
	return (rt.identical(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_file_end(), this.prop_type)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) isdelimiter(mut var_values Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_array) bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	if !rt.is_true(var_values) {
		return true
	}
	return (rt.call_function('in_array', [this.value, var_values])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) iswhitespace() bool {
	return (rt.identical(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_whitespace(), this.prop_type)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) isidentifier() bool {
	return (rt.identical(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_identifier(), this.prop_type)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) ishash() bool {
	return (rt.identical(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_hash(), this.prop_type)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) isnumber() bool {
	return (rt.identical(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_number(), this.prop_type)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) isstring() bool {
	return (rt.identical(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_string(), this.prop_type)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) magic_tostring() string {
	if rt.is_true(this.value) {
		return (rt.call_function('sprintf', [rt.new_string('<%s "%s" at %s>'), this.prop_type, this.value, this.position])).str()
	}
	return (rt.call_function('sprintf', [rt.new_string('<%s at %s>'), this.prop_type, this.position])).str()
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_token(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type: rt.new_null()
		value: rt.new_null()
		position: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'getType' {
			return rt.new_int(this.gettype())
		}
		'getValue' {
			return rt.new_string(this.getvalue())
		}
		'getPosition' {
			return rt.new_int(this.getposition())
		}
		'isFileEnd' {
			return rt.new_bool(this.isfileend())
		}
		'isDelimiter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.isdelimiter(mut dispatch_arg_0))
		}
		'isWhitespace' {
			return rt.new_bool(this.iswhitespace())
		}
		'isIdentifier' {
			return rt.new_bool(this.isidentifier())
		}
		'isHash' {
			return rt.new_bool(this.ishash())
		}
		'isNumber' {
			return rt.new_bool(this.isnumber())
		}
		'isString' {
			return rt.new_bool(this.isstring())
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'value' { return this.value }
		'position' { return this.position }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' { this.prop_type = val; return true }
		'value' { this.value = val; return true }
		'position' { this.position = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_parser_token_php() {
}
