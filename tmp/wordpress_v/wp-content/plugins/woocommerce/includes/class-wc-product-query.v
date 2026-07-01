import rt

struct Class_WC_Product_Query {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Product_Query) get_default_query_vars() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_WC_Object_Query.get_default_query_vars(), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.draft() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.private() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }]) }, rt.ArrayItem{ key: 'type', val: rt.call_function('array_merge', [rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{}))]) }, rt.ArrayItem{ key: 'limit', val: rt.call_function('get_option', [rt.new_string('posts_per_page')]) }, rt.ArrayItem{ key: 'include', val: rt.new_array() }, rt.ArrayItem{ key: 'date_created', val: '' }, rt.ArrayItem{ key: 'date_modified', val: '' }, rt.ArrayItem{ key: 'featured', val: '' }, rt.ArrayItem{ key: 'visibility', val: '' }, rt.ArrayItem{ key: 'sku', val: '' }, rt.ArrayItem{ key: 'price', val: '' }, rt.ArrayItem{ key: 'regular_price', val: '' }, rt.ArrayItem{ key: 'sale_price', val: '' }, rt.ArrayItem{ key: 'date_on_sale_from', val: '' }, rt.ArrayItem{ key: 'date_on_sale_to', val: '' }, rt.ArrayItem{ key: 'total_sales', val: '' }, rt.ArrayItem{ key: 'tax_status', val: '' }, rt.ArrayItem{ key: 'tax_class', val: '' }, rt.ArrayItem{ key: 'manage_stock', val: '' }, rt.ArrayItem{ key: 'stock_quantity', val: '' }, rt.ArrayItem{ key: 'stock_status', val: '' }, rt.ArrayItem{ key: 'backorders', val: '' }, rt.ArrayItem{ key: 'low_stock_amount', val: '' }, rt.ArrayItem{ key: 'sold_individually', val: '' }, rt.ArrayItem{ key: 'weight', val: '' }, rt.ArrayItem{ key: 'length', val: '' }, rt.ArrayItem{ key: 'width', val: '' }, rt.ArrayItem{ key: 'height', val: '' }, rt.ArrayItem{ key: 'reviews_allowed', val: '' }, rt.ArrayItem{ key: 'virtual', val: '' }, rt.ArrayItem{ key: 'downloadable', val: '' }, rt.ArrayItem{ key: 'category', val: rt.new_array() }, rt.ArrayItem{ key: 'tag', val: rt.new_array() }, rt.ArrayItem{ key: 'shipping_class', val: rt.new_array() }, rt.ArrayItem{ key: 'download_limit', val: '' }, rt.ArrayItem{ key: 'download_expiry', val: '' }, rt.ArrayItem{ key: 'average_rating', val: '' }, rt.ArrayItem{ key: 'review_count', val: '' }])])
}

fn (mut this Class_WC_Product_Query) get_products() rt.PhpVal {
	mut var_args := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_object_query_args'), this.get_query_vars()])
	mut var_results := rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product')), 'query', [var_args.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_object_query'), var_results.dup(), var_args.dup()])
}

struct Class_WC_Object_Query {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_product_query() &Class_WC_Product_Query {
	mut obj := &Class_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_object_query() &Class_WC_Object_Query {
	mut obj := &Class_WC_Object_Query{
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

fn (mut this Class_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_products' {
			return this.get_products()
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Object_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Object_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Object_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_product_query_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
