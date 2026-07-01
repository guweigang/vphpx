import rt

struct Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput {
	rt.PhpObjectBase
pub mut:
	slug              rt.PhpVal = rt.new_null()
	sku               rt.PhpVal = rt.new_null()
	description       rt.PhpVal = rt.new_null()
	short_description rt.PhpVal = rt.new_null()
	status            rt.PhpVal = rt.new_null()
	product_type      rt.PhpVal = rt.new_null()
	regular_price     rt.PhpVal = rt.new_null()
	sale_price        rt.PhpVal = rt.new_null()
	manage_stock      rt.PhpVal = rt.new_null()
	stock_quantity    rt.PhpVal = rt.new_null()
	dimensions        rt.PhpVal = rt.new_null()
}

fn create_automattic_woocommerce_api_inputtypes_products_baseproductinput() &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput {
	mut obj := &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput{
		PhpObjectBase:     rt.PhpObjectBase{}
		slug:              rt.new_null()
		sku:               rt.new_null()
		description:       rt.new_null()
		short_description: rt.new_null()
		status:            rt.new_null()
		product_type:      rt.new_null()
		regular_price:     rt.new_null()
		sale_price:        rt.new_null()
		manage_stock:      rt.new_null()
		stock_quantity:    rt.new_null()
		dimensions:        rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'slug' { return this.slug }
		'sku' { return this.sku }
		'description' { return this.description }
		'short_description' { return this.short_description }
		'status' { return this.status }
		'product_type' { return this.product_type }
		'regular_price' { return this.regular_price }
		'sale_price' { return this.sale_price }
		'manage_stock' { return this.manage_stock }
		'stock_quantity' { return this.stock_quantity }
		'dimensions' { return this.dimensions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Api_InputTypes_Products_BaseProductInput) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'slug' {
			this.slug = val
			return true
		}
		'sku' {
			this.sku = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'short_description' {
			this.short_description = val
			return true
		}
		'status' {
			this.status = val
			return true
		}
		'product_type' {
			this.product_type = val
			return true
		}
		'regular_price' {
			this.regular_price = val
			return true
		}
		'sale_price' {
			this.sale_price = val
			return true
		}
		'manage_stock' {
			this.manage_stock = val
			return true
		}
		'stock_quantity' {
			this.stock_quantity = val
			return true
		}
		'dimensions' {
			this.dimensions = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_api_inputtypes_products_baseproductinput_php() {
	// unsupported statement: Stmt_Declare
}
