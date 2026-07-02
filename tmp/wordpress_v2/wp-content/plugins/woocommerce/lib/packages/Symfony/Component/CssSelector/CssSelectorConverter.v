import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter {
	rt.PhpObjectBase
pub mut:
	translator rt.PhpVal = rt.new_null()
	cache      rt.PhpVal = rt.new_null()
}

fn init_static_automattic_woocommerce_vendor_symfony_component_cssselector_cssselectorconverter() {
	rt.init_static_prop('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter',
		'xmlCache', rt.new_array())
	rt.init_static_prop('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter',
		'htmlCache', rt.new_array())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter) construct(html bool) {
	this.translator =
		create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_translator()
	if var_html {
		rt.call_method(this.translator, 'registerExtension', [
			create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_extension_htmlextension(this.translator),
		])
		this.cache = rt.get_static_prop('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter',
			'htmlCache')
	} else {
		this.cache = rt.get_static_prop('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter',
			'xmlCache')
	}
	rt.call_method(rt.call_method(rt.call_method(rt.call_method(this.translator,
		'registerParserShortcut', [
		create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_emptystringparser(),
	]), 'registerParserShortcut', [
		create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_elementparser(),
	]), 'registerParserShortcut', [
		create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_classparser(),
	]), 'registerParserShortcut', [
		create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_hashparser(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter) toxpath(cssExpr string, prefix string) rt.PhpVal {
	return if !(this.cache.array_get(rt.new_string(prefix)).array_get(rt.new_string(cssExpr))).is_null() { this.cache.array_get(rt.new_string(prefix)).array_get(rt.new_string(cssExpr)) } else { this.cache.array_get_mut(prefix).array_set(cssExpr, rt.call_method(this.translator, 'cssToXPath', [
			rt.new_string(cssExpr),
			rt.new_string(prefix),
		])) }
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ClassParser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_HashParser {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_cssselectorconverter(html bool) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter{
		PhpObjectBase: rt.PhpObjectBase{}
		translator:    rt.new_null()
		cache:         rt.new_null()
	}
	obj.construct(html)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_translator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_xpath_extension_htmlextension(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_emptystringparser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_elementparser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_classparser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ClassParser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ClassParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_shortcut_hashparser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_HashParser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_HashParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'toXPath' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.toxpath(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'translator' { return this.translator }
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_CssSelectorConverter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'translator' {
			this.translator = val
			return true
		}
		'cache' {
			this.cache = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Translator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_XPath_Extension_HtmlExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_EmptyStringParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ElementParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ClassParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ClassParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_ClassParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_HashParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_HashParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Shortcut_HashParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
