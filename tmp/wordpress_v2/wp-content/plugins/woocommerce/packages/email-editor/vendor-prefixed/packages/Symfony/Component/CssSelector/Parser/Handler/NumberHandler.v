import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler {
	rt.PhpObjectBase
pub mut:
	patterns rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler) construct(mut var_patterns Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns) {
	this.patterns = var_patterns
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler) handle(mut var_reader Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Reader, mut var_stream Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_TokenStream) bool {
	mut var_match := var_reader.findpattern(rt.call_method(this.patterns, 'getNumberPattern',
		[]rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_match)))) {
		return false
	}
	var_stream.push(create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_token(Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token.type_number(),
		var_match.array_get(rt.new_int(0)), var_reader.getposition()))
	var_reader.moveforward(rt.new_int(var_match.array_get(rt.new_int(0)).to_string().len))
	return true
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_handler_numberhandler(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler{
		PhpObjectBase: rt.PhpObjectBase{}
		patterns:      rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_token(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Token{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'patterns' { return this.patterns }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Handler_NumberHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'patterns' {
			this.patterns = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
