import rt

struct Class_WC_Product_External {
	rt.PhpObjectBase
pub mut:
	extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_External) get_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_Enums_ProductType.external()
}

fn (mut this Class_WC_Product_External) get_product_url(context string) rt.PhpVal {
	return rt.call_function('esc_url_raw', [
		this.get_prop(rt.new_string('product_url'), rt.new_string(context)),
	])
}

fn (mut this Class_WC_Product_External) get_button_text(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('button_text'), rt.new_string(context))
}

fn (mut this Class_WC_Product_External) set_product_url(var_product_url rt.PhpVal) {
	this.set_prop(rt.new_string('product_url'), rt.call_function('htmlspecialchars_decode', [
		var_product_url.clone(),
	]))
}

fn (mut this Class_WC_Product_External) set_button_text(var_button_text rt.PhpVal) {
	this.set_prop(rt.new_string('button_text'), var_button_text.clone())
}

fn (mut this Class_WC_Product_External) set_manage_stock(var_manage_stock rt.PhpVal) {
	this.set_prop(rt.new_string('manage_stock'), rt.new_bool(false))
	if rt.is_true(rt.identical(rt.new_bool(true), var_manage_stock)) {
		this.error(rt.new_string('product_external_invalid_manage_stock'), rt.call_function('__', [
			rt.new_string('External products cannot be stock managed.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Product_External) set_stock_status(stock_status string) {
	this.set_prop(rt.new_string('stock_status'),
		Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock(),
		rt.new_string(stock_status)))))
	{
		this.error(rt.new_string('product_external_invalid_stock_status'), rt.call_function('__', [
			rt.new_string('External products cannot be stock managed.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Product_External) set_backorders(var_backorders rt.PhpVal) {
	this.set_prop(rt.new_string('backorders'), rt.new_string('no'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('no'), var_backorders)))) {
		this.error(rt.new_string('product_external_invalid_backorders'), rt.call_function('__', [
			rt.new_string('External products cannot be backordered.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Product_External) is_purchasable() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_purchasable'),
		rt.new_bool(false),
		rt.new_object('WC_Product_External', ['WC_Product'], &this),
	])
}

fn (mut this Class_WC_Product_External) add_to_cart_url() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_add_to_cart_url'),
		this.get_product_url(''),
		rt.new_object('WC_Product_External', ['WC_Product'], &this),
	])
}

fn (mut this Class_WC_Product_External) single_add_to_cart_text() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_single_add_to_cart_text'),
		if rt.is_true(this.get_button_text('')) { this.get_button_text('') } else { rt.call_function('_x', [
				rt.new_string('Buy product'),
				rt.new_string('placeholder'),
				rt.new_string('woocommerce'),
			]) },
		rt.new_object('WC_Product_External', [
			'WC_Product',
		], &this),
	])
}

fn (mut this Class_WC_Product_External) add_to_cart_text() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_add_to_cart_text'),
		if rt.is_true(this.get_button_text('')) { this.get_button_text('') } else { rt.call_function('_x', [
				rt.new_string('Buy product'),
				rt.new_string('placeholder'),
				rt.new_string('woocommerce'),
			]) },
		rt.new_object('WC_Product_External', [
			'WC_Product',
		], &this),
	])
}

fn (mut this Class_WC_Product_External) add_to_cart_description() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_add_to_cart_description'),
		if rt.is_true(this.get_button_text('')) { this.get_button_text('') } else { rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Buy &ldquo;%s&rdquo;'),
					rt.new_string('woocommerce')]),
				this.get_name(),
			]) },
		rt.new_object('WC_Product_External', [
			'WC_Product',
		], &this),
	])
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

fn create_wc_product_external(_args ...rt.PhpVal) &Class_WC_Product_External {
	mut obj := &Class_WC_Product_External{
		PhpObjectBase: rt.PhpObjectBase{}
		extra_data:    rt.new_array()
	}
	return obj
}

fn create_wc_product(_args ...rt.PhpVal) &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_External) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_type' {
			return this.get_type()
		}
		'get_product_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_product_url(dispatch_arg_0)
		}
		'get_button_text' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_button_text(dispatch_arg_0)
		}
		'set_product_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_url(dispatch_arg_0)
			return rt.new_null()
		}
		'set_button_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_button_text(dispatch_arg_0)
			return rt.new_null()
		}
		'set_manage_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_manage_stock(dispatch_arg_0)
			return rt.new_null()
		}
		'set_stock_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_stock_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_backorders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_backorders(dispatch_arg_0)
			return rt.new_null()
		}
		'is_purchasable' {
			return this.is_purchasable()
		}
		'add_to_cart_url' {
			return this.add_to_cart_url()
		}
		'single_add_to_cart_text' {
			return this.single_add_to_cart_text()
		}
		'add_to_cart_text' {
			return this.add_to_cart_text()
		}
		'add_to_cart_description' {
			return this.add_to_cart_description()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_External) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_External) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'extra_data' {
			this.extra_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
