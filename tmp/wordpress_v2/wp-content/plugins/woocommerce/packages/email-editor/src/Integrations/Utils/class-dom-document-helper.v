import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
pub mut:
	dom rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) construct(html_content string) {
	this.load_html(html_content)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) load_html(html_content string) {
	rt.call_function('libxml_use_internal_errors', [rt.new_bool(true)])
	this.dom = create_automattic_woocommerce_emaileditor_integrations_utils_domdocument()
	if !(html_content == '') {
		rt.call_method(this.dom, 'loadHTML', [
			rt.new_string('<?xml encoding="UTF-8">' + html_content),
			rt.bitwise_or(rt.get_constant('LIBXML_HTML_NOIMPLIED'),
				rt.get_constant('LIBXML_HTML_NODEFDTD')),
		])
	}
	rt.call_function('libxml_clear_errors', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) find_element(tag_name string) rt.PhpVal {
	mut var_elements := rt.call_method(this.dom, 'getElementsByTagName', [
		rt.new_string(tag_name),
	])
	return if rt.is_true(rt.call_method(var_elements, 'item', [
		rt.new_int(0)]))
	{ rt.call_method(var_elements, 'item', [rt.new_int(0)]) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) get_attribute_value(mut var_element Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMElement, attribute string) string {
	mut var_element_mutated := var_element
	return (if rt.is_true(rt.call_method(var_element_mutated, 'hasAttribute', [
		rt.new_string(attribute),
	]))
	{
		rt.call_method(var_element_mutated, 'getAttribute', [
			rt.new_string(attribute)])
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) get_attribute_value_by_tag_name(tag_name string, attribute string) string {
	mut var_element := this.find_element(tag_name)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_element)))) {
		return (rt.new_null()).str()
	}
	return this.get_attribute_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMElement](var_element),
		attribute)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) get_outer_html(mut var_element Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMElement) string {
	mut var_element_mutated := var_element
	return (rt.call_method(this.dom, 'saveHTML', [var_element_mutated])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) get_element_inner_html(mut var_element Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMElement) string {
	mut var_element_mutated := var_element
	mut var_inner_html := rt.new_string('')
	mut var_children := rt.get_property(var_element_mutated, 'childNodes')
	mut iter_1 := var_children.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_child := item_1.val
		var_inner_html = rt.concat(var_inner_html, rt.call_method(this.dom, 'saveHTML', [
			var_child.clone(),
		]))
	}
	return var_inner_html.str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMDocument {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(html_content string) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
		dom:           rt.new_null()
	}
	obj.construct(html_content)
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_domdocument(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'load_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.load_html(dispatch_arg_0)
			return rt.new_null()
		}
		'find_element' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.find_element(dispatch_arg_0)
		}
		'get_attribute_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_attribute_value(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_attribute_value_by_tag_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_attribute_value_by_tag_name(dispatch_arg_0,
				dispatch_arg_1))
		}
		'get_outer_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_outer_html(mut dispatch_arg_0))
		}
		'get_element_inner_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_element_inner_html(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'dom' { return this.dom }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'dom' {
			this.dom = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
