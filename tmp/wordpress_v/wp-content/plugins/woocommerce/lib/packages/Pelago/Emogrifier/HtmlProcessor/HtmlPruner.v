import rt

pub fn Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner.display_none_matcher() string {
	return '//*[@style and contains(translate(translate(@style," ",""),"NOE","noe"),"display:none")' + ' and not(@class and contains(concat(" ", normalize-space(@class), " "), " -emogrifier-keep "))]'
}
struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) removeelementswithdisplaynone() rt.PhpVal {
	mut var_elementsWithStyleDisplayNone := rt.call_method(this.getxpath(), 'query', [Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner.display_none_matcher()])
	if rt.is_true(rt.identical(rt.get_property(var_elementsWithStyleDisplayNone, 'length'), rt.new_int(0))) {
		return rt.new_object('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner', []string{}, this)
	}
	{
		mut iter_1 := var_elementsWithStyleDisplayNone.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element := item_1.val
			mut var_parentNode := rt.get_property(var_element, 'parentNode')
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_method(var_parentNode, 'removeChild', [var_element.dup()])
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) removeredundantclasses(mut var_classesToKeep Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_array) rt.PhpVal {
	mut var_elementsWithClassAttribute := rt.call_method(this.getxpath(), 'query', [rt.new_string('//*[@class]')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.removeclassesfromelements(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_DOMNodeList](var_elementsWithClassAttribute), mut var_classesToKeep)
	} else {
		this.removeclassattributefromelements(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_DOMNodeList](var_elementsWithClassAttribute))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner', []string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) removeclassesfromelements(mut var_elements Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_DOMNodeList, mut var_classesToKeep Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_array)  {
	mut var_classesToKeepIntersector := create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_arrayintersector(var_classesToKeep.dup())
	mut var_preg := create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_preg()
	{
		mut iter_1 := var_elements.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element := item_1.val
			mut var_elementClasses := var_preg.split(rt.new_string('/\\s++/'), rt.new_string(rt.call_method(var_element, 'getAttribute', [rt.new_string('class')]).to_string().trim_space()))
			mut var_elementClassesToKeep := var_classesToKeepIntersector.intersectwith(var_elementClasses.dup())
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_method(var_element, 'setAttribute', [rt.new_string('class'), rt.call_function('implode', [rt.new_string(' '), var_elementClassesToKeep.dup()])])
			} else {
				rt.call_method(var_element, 'removeAttribute', [rt.new_string('class')])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) removeclassattributefromelements(mut var_elements Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_DOMNodeList)  {
	{
		mut iter_1 := var_elements.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element := item_1.val
			rt.call_method(var_element, 'removeAttribute', [rt.new_string('class')])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) removeredundantclassesaftercssinlined(mut var_cssInliner Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_preg := create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_preg()
	mut var_classesToKeepAsKeys := rt.new_array()
	{
		mut iter_1 := var_cssInliner.getmatchinguninlinableselectors().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_selector := item_1.val
			var_preg.matchall(rt.new_string('/\\.(-?+[_a-zA-Z][\\w\\-]*+)/'), var_selector.dup(), var_matches.dup())
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	this.removeredundantclasses(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_array](rt.func_array_keys(var_classesToKeepAsKeys.dup())))
	return rt.new_object('Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner', []string{}, this)
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_htmlprocessor_htmlpruner() &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor() &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_arrayintersector() &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_pelago_emogrifier_utilities_preg() &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_Preg{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'removeElementsWithDisplayNone' {
			return this.removeelementswithdisplaynone()
		}
		'removeRedundantClasses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.removeredundantclasses(mut dispatch_arg_0)
		}
		'removeClassesFromElements' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_DOMNodeList](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.removeclassesfromelements(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'removeClassAttributeFromElements' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_DOMNodeList](if args.len > 0 { args[0] } else { rt.new_null() })
			this.removeclassattributefromelements(mut dispatch_arg_0)
			return rt.new_null()
		}
		'removeRedundantClassesAfterCssInlined' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_CssInliner](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.removeredundantclassesaftercssinlined(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_HtmlPruner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Pelago_Emogrifier_Utilities_ArrayIntersector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_pelago_emogrifier_htmlprocessor_htmlpruner_php() {
	// unsupported statement: Stmt_Declare
}
