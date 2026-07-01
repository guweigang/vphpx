import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema.identifier() string {
	return 'product-attribute'
}
struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema {
	rt.PhpObjectBase
pub mut:
		title rt.PhpVal = rt.new_string('product_attribute')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema) get_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The attribute taxonomy name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Attribute type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'order', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('How terms in this attribute are sorted by default.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'has_archives', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If this attribute has term archive pages.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'count', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of terms in the attribute taxonomy.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema) get_item_response(var_attribute rt.PhpVal) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'name', val: this.prepare_html_response(rt.get_property(var_attribute, 'name')) }, rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_attribute, 'slug') }, rt.ArrayItem{ key: 'type', val: rt.get_property(var_attribute, 'type') }, rt.ArrayItem{ key: 'order', val: rt.get_property(var_attribute, 'order_by') }, rt.ArrayItem{ key: 'has_archives', val: rt.get_property(var_attribute, 'has_archives') }, rt.ArrayItem{ key: 'count', val: // unsupported expression: Expr_Cast_Int }])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_productattributeschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title: rt.new_string('product_attribute')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductAttributeSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' { this.title = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_productattributeschema_php() {
}
