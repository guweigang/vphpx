import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.unexpectedtoken(expectedValue string, mut var_foundToken Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token) rt.PhpVal {
	return create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_self(rt.call_function('sprintf', [
		rt.new_string('Expected %s, but %s found.'),
		rt.new_string(expectedValue),
		var_foundToken,
	]))
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.pseudoelementfound(pseudoElement string, unexpectedLocation string) rt.PhpVal {
	return create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_self(rt.call_function('sprintf', [
		rt.new_string('Unexpected pseudo-element "::%s" found %s.'),
		rt.new_string(pseudoElement),
		rt.new_string(unexpectedLocation),
	]))
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.unclosedstring(position i64) rt.PhpVal {
	return create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_self(rt.call_function('sprintf', [
		rt.new_string('Unclosed/invalid string at %s.'),
		rt.new_int(position),
	]))
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.nestednot() rt.PhpVal {
	return create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_self(rt.new_string('Got nested ::not().'))
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.stringasfunctionargument() rt.PhpVal {
	return create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_self(rt.new_string('String not allowed as function argument.'))
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_self {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_syntaxerrorexception() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_parseexception() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_self() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'unexpectedToken' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.unexpectedtoken(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'pseudoElementFound' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.pseudoelementfound(dispatch_arg_0,
				dispatch_arg_1)
		}
		'unclosedString' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.unclosedstring(dispatch_arg_0)
		}
		'nestedNot' {
			return Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.nestednot()
		}
		'stringAsFunctionArgument' {
			return Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException.stringasfunctionargument()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_ParseException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_exception_syntaxerrorexception_php() {
}
