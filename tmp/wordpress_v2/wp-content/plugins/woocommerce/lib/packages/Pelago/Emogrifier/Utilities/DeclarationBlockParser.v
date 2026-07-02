import rt

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_vendor_pelago_emogrifier_utilities_declarationblockparser() {
	rt.init_static_prop('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser',
		'cache', rt.new_array())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) normalizepropertyname(name string) string {
	if rt.is_true(rt.identical(rt.call_function('substr', [rt.new_string(name),
		rt.new_int(0), rt.new_int(2)]), rt.new_string('--')))
	{
		return name
	} else {
		return name.to_lower()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) parse(declarationBlock string) rt.PhpVal {
	if rt.get_static_prop('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser',
		'cache').array_isset(rt.new_string(declarationBlock))
	{
		return rt.get_static_prop('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser',
			'cache').array_get(rt.new_string(declarationBlock))
	}
	mut var_preg := create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_preg()
	mut var_declarations := var_preg.split(rt.new_string('/;(?!base64|charset)/'),
		rt.new_string(declarationBlock))
	mut var_properties := rt.new_array()
	mut iter_1 := var_declarations.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_declaration := item_1.val
		mut var_matches := rt.new_array()
		if rt.is_true(rt.identical(var_preg.match(rt.new_string('/^([A-Za-z\\-]+)\\s*:\\s*(.+)$/s'),
			rt.new_string((var_declaration.clone().to_string().trim_space()).str()),
			var_matches.clone()), rt.new_int(0)))
		{
			continue
		}
		mut var_propertyName := var_matches.array_get(rt.new_int(1))
		if rt.is_true(rt.identical(var_propertyName, rt.new_string(''))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_UnexpectedValueException',
				[]string{}, create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_unexpectedvalueexception(rt.new_string('An empty property name was encountered.'),
				rt.new_int(1727046409))))
		}
		mut var_propertyValue := var_matches.array_get(rt.new_int(2))
		var_properties.array_set(this.normalizepropertyname(var_propertyName.str()),
			var_propertyValue.clone())
	}
	rt.get_static_prop('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser',
		'cache').array_set(declarationBlock, var_properties.clone())
	return var_properties.clone()
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_UnexpectedValueException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_declarationblockparser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_preg(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_unexpectedvalueexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_UnexpectedValueException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'normalizePropertyName' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalizepropertyname(dispatch_arg_0))
		}
		'parse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
