import rt

struct Class_WC_Product_Grouped {
	rt.PhpObjectBase
pub mut:
		extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Grouped) get_type() rt.PhpVal {
	return Class_Automattic_WooCommerce_Enums_ProductType.grouped()
}

fn (mut this Class_WC_Product_Grouped) add_to_cart_text() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_text'), rt.call_function('__', [rt.new_string('View products'), rt.new_string('woocommerce')]), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Grouped) add_to_cart_description() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_add_to_cart_description'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('View products in the &ldquo;%s&rdquo; group'), rt.new_string('woocommerce')]), this.get_name()]), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Grouped) is_on_sale(context string) rt.PhpVal {
	mut var_children := this.get_primed_visible_children(context)
	mut var_on_sale := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_children.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_child, 'is_purchasable', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_child, 'has_child', []rt.PhpVal{}))))))) && rt.is_true(rt.call_method(var_child, 'is_on_sale', []rt.PhpVal{})))) {
				var_on_sale = rt.new_bool(rt.new_bool(true))
				break
			}
		}
	}
	return if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) { rt.call_function('apply_filters', [rt.new_string('woocommerce_product_is_on_sale'), var_on_sale.dup(), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this)]) } else { var_on_sale }
}

fn (mut this Class_WC_Product_Grouped) is_purchasable() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_is_purchasable'), rt.new_bool(false), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Grouped) get_price_html(price string) rt.PhpVal {
	mut price_mutated := price
	mut var_tax_display_mode := rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')])
	mut var_child_prices := []rt.PhpVal{}
	mut var_children := this.get_primed_visible_children('')
	{
		mut iter_1 := var_children.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child := item_1.val
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_child_prices << if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display_mode)) { rt.call_function('wc_get_price_including_tax', [var_child.dup()]) } else { rt.call_function('wc_get_price_excluding_tax', [var_child.dup()]) }
			}
		}
	}
	if !(!rt.is_true(var_child_prices)) {
		mut var_min_price := rt.call_function('min', [var_child_prices.dup()])
		mut var_max_price := rt.call_function('max', [var_child_prices.dup()])
	} else {
		var_min_price = rt.new_string(rt.new_string(''))
		var_max_price = rt.new_string(rt.new_string(''))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			price_mutated = (rt.call_function('wc_format_price_range', [var_min_price.dup(), var_max_price.dup()])).str()
		} else {
			price_mutated = (rt.call_function('wc_price', [var_min_price.dup()])).str()
		}
		mut var_is_free := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_min_price)) && rt.is_true(rt.identical(rt.new_int(0), var_max_price))))
		if rt.is_true(var_is_free) {
			price_mutated = (rt.call_function('apply_filters', [rt.new_string('woocommerce_grouped_free_price_html'), rt.call_function('__', [rt.new_string('Free!'), rt.new_string('woocommerce')]), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this)])).str()
		} else {
			price_mutated = (rt.call_function('apply_filters', [rt.new_string('woocommerce_grouped_price_html'), price_mutated + (this.get_price_suffix()).str(), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this), var_child_prices.dup()])).str()
		}
	} else {
		price_mutated = (rt.call_function('apply_filters', [rt.new_string('woocommerce_grouped_empty_price_html'), rt.new_string(''), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this)])).str()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_price_html'), rt.new_string(price_mutated).dup(), rt.new_object('WC_Product_Grouped', ['WC_Product'], &this)])
}

fn (mut this Class_WC_Product_Grouped) get_children(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('children'), rt.new_string(context))
}

fn (mut this Class_WC_Product_Grouped) get_visible_children() rt.PhpVal {
	return this.get_primed_visible_children('')
}

fn (mut this Class_WC_Product_Grouped) get_min_price() string {
	mut var_children := this.get_primed_visible_children('')
	mut var_prices := rt.call_function('array_map', [rt.new_string('wc_get_price_to_display'), var_children.dup()])
	if !rt.is_true(var_prices) {
		return ''
	}
	return (rt.call_function('wc_format_decimal', [rt.call_function('min', [var_prices.dup()])])).str()
}

fn (mut this Class_WC_Product_Grouped) get_max_price() string {
	mut var_children := this.get_primed_visible_children('')
	mut var_prices := rt.call_function('array_map', [rt.new_string('wc_get_price_to_display'), var_children.dup()])
	if !rt.is_true(var_prices) {
		return ''
	}
	return (rt.call_function('wc_format_decimal', [rt.call_function('max', [var_prices.dup()])])).str()
}

fn (mut this Class_WC_Product_Grouped) get_primed_visible_children(context string) rt.PhpVal {
	mut var_child_ids := this.get_children(context)
	if !(!rt.is_true(var_child_ids)) {
		rt.call_function('_prime_post_caches', [var_child_ids.dup()])
	}
	mut var_children := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_child_ids.dup()]), rt.new_string('wc_products_array_filter_visible_grouped')])
	return var_children.dup()
}

fn (mut this Class_WC_Product_Grouped) set_children(var_children rt.PhpVal)  {
	mut var_children_mutated := var_children
	this.set_prop(rt.new_string('children'), rt.call_function('array_filter', [rt.call_function('wp_parse_id_list', [rt.cast_array(var_children_mutated)])]))
}

fn Class_WC_Product_Grouped.sync(var_product rt.PhpVal, save bool) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product_mutated.dup(), rt.new_string('WC_Product')]))))) {
		var_product_mutated = rt.call_function('wc_get_product', [var_product_mutated.dup()])
	}
	if rt.is_true(rt.call_function('is_a', [var_product_mutated.dup(), rt.new_string('WC_Product_Grouped')])) {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product-' + (rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{})).str()))
		rt.call_method(var_data_store, 'sync_price', [var_product_mutated.dup()])
		if var_save {
			rt.call_method(var_product_mutated, 'save', []rt.PhpVal{})
		}
	}
	return var_product_mutated.dup()
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_product_grouped() &Class_WC_Product_Grouped {
	mut obj := &Class_WC_Product_Grouped{
		PhpObjectBase: rt.PhpObjectBase{}
		extra_data: rt.new_array()
	}
	return obj
}

fn create_wc_product() &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Grouped) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_type' {
			return this.get_type()
		}
		'add_to_cart_text' {
			return this.add_to_cart_text()
		}
		'add_to_cart_description' {
			return this.add_to_cart_description()
		}
		'is_on_sale' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.is_on_sale(dispatch_arg_0)
		}
		'is_purchasable' {
			return this.is_purchasable()
		}
		'get_price_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_price_html(dispatch_arg_0)
		}
		'get_children' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_children(dispatch_arg_0)
		}
		'get_visible_children' {
			return this.get_visible_children()
		}
		'get_min_price' {
			return rt.new_string(this.get_min_price())
		}
		'get_max_price' {
			return rt.new_string(this.get_max_price())
		}
		'get_primed_visible_children' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_primed_visible_children(dispatch_arg_0)
		}
		'set_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_children(dispatch_arg_0)
			return rt.new_null()
		}
		'sync' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Product_Grouped.sync(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Grouped) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Grouped) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'extra_data' { this.extra_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_product_grouped_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
