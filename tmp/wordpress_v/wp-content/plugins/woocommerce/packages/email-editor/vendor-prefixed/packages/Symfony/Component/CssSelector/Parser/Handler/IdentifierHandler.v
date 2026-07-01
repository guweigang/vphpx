import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler {
	rt.PhpObjectBase
pub mut:
	patterns rt.PhpVal = rt.new_null()
	escaping rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler) construct(mut var_patterns Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns, mut var_escaping Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) {
	this.patterns = var_patterns.dup()
	this.escaping = var_escaping.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler) handle(mut var_reader Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Reader, mut var_stream Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_TokenStream) bool {
	mut var_match := var_reader.findpattern(rt.call_method(this.patterns, 'getIdentifierPattern',
		[]rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_match)))) {
		return false
	}
	mut var_value := rt.call_method(this.escaping, 'escapeUnicode', [
		var_match.array_get(0)])
	var_stream.push(create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_token(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_identifier(),
		var_value.dup(), var_reader.getposition()))
	var_reader.moveforward(rt.new_int(var_match.array_get(0).to_string().len))
	return true
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_handler_identifierhandler(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler{
		PhpObjectBase: rt.PhpObjectBase{}
		patterns:      rt.new_null()
		escaping:      rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_token() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'handle' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Reader](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_TokenStream](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.handle(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'patterns' { return this.patterns }
		'escaping' { return this.escaping }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_IdentifierHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'patterns' {
			this.patterns = val
			return true
		}
		'escaping' {
			this.escaping = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_parser_handler_identifierhandler_php() {
}
