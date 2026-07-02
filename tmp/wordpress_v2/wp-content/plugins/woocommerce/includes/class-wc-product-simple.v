import rt

struct Class_WC_Product_Simple {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Product_Simple) construct(product i64) {
	rt.get_property(rt.new_object('WC_Product_Simple', ['WC_Product'], &this), 'supports').array_push('ajax_add_to_cart')
	this.Class_WC_Product.construct(rt.new_int(product))
}

fn (mut this Class_WC_Product_Simple) get_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_Enums_ProductType.simple()
}

fn (mut this Class_WC_Product_Simple) add_to_cart_url() rt.PhpVal {
	mut var_url := if rt.is_true(this.is_purchasable()) && rt.is_true(this.is_in_stock()) { rt.call_function('remove_query_arg', [
			rt.new_string('added-to-cart'),
			rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: this.get_id() }]),
				if (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_feed')]))
					&& rt.is_true(rt.call_function('is_feed', []rt.PhpVal{})))
					|| (rt.is_true(rt.call_function('function_exists', [rt.new_string('is_404')]))
					&& rt.is_true(rt.call_function('is_404', []rt.PhpVal{}))) {
					this.get_permalink()
				} else {
					rt.new_bool(false)
				},
			]),
		])
	 } else { this.get_permalink()
	 }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_add_to_cart_url'),
		var_url.clone(),
		rt.new_object('WC_Product_Simple', ['WC_Product'], &this),
	])
}

fn (mut this Class_WC_Product_Simple) add_to_cart_text() rt.PhpVal {
	mut var_text := if rt.is_true(this.is_purchasable()) && rt.is_true(this.is_in_stock()) { rt.call_function('__', [
			rt.new_string('Add to cart'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [rt.new_string('Read more'),
			rt.new_string('woocommerce')]) }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_add_to_cart_text'),
		var_text.clone(),
		rt.new_object('WC_Product_Simple', ['WC_Product'], &this),
	])
}

fn (mut this Class_WC_Product_Simple) add_to_cart_description() rt.PhpVal {
	mut var_text := if rt.is_true(this.is_purchasable()) && rt.is_true(this.is_in_stock()) { rt.call_function('__', [
			rt.new_string('Add to cart: &ldquo;%s&rdquo;'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Read more about &ldquo;%s&rdquo;'),
			rt.new_string('woocommerce'),
		]) }
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_add_to_cart_description'),
		rt.call_function('sprintf', [var_text.clone(), this.get_name()]),
		rt.new_object('WC_Product_Simple', ['WC_Product'], &this),
	])
}

fn (mut this Class_WC_Product_Simple) add_to_cart_success_message() rt.PhpVal {
	mut var_text := rt.new_string('')
	if rt.is_true(this.is_purchasable()) && rt.is_true(this.is_in_stock()) {
		var_text = rt.call_function('__', [
			rt.new_string('&ldquo;%s&rdquo; has been added to your cart'),
			rt.new_string('woocommerce'),
		])
		var_text = rt.call_function('sprintf', [var_text.clone(),
			this.get_name()])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_add_to_cart_success_message'),
		var_text.clone(),
		rt.new_object('WC_Product_Simple', ['WC_Product'], &this),
	])
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

fn create_wc_product_simple(product i64) &Class_WC_Product_Simple {
	mut obj := &Class_WC_Product_Simple{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(product)
	return obj
}

fn create_wc_product(_args ...rt.PhpVal) &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Simple) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_type' {
			return this.get_type()
		}
		'add_to_cart_url' {
			return this.add_to_cart_url()
		}
		'add_to_cart_text' {
			return this.add_to_cart_text()
		}
		'add_to_cart_description' {
			return this.add_to_cart_description()
		}
		'add_to_cart_success_message' {
			return this.add_to_cart_success_message()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_Simple) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Simple) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
