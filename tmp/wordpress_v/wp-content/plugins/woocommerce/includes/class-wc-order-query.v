import rt

struct Class_WC_Order_Query {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Order_Query) get_default_query_vars() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_WC_Object_Query.get_default_query_vars(), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.func_array_keys(rt.call_function('wc_get_order_statuses', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'type', val: rt.call_function('wc_get_order_types', [rt.new_string('view-orders')]) }, rt.ArrayItem{ key: 'currency', val: '' }, rt.ArrayItem{ key: 'version', val: '' }, rt.ArrayItem{ key: 'prices_include_tax', val: '' }, rt.ArrayItem{ key: 'date_created', val: '' }, rt.ArrayItem{ key: 'date_modified', val: '' }, rt.ArrayItem{ key: 'date_completed', val: '' }, rt.ArrayItem{ key: 'date_paid', val: '' }, rt.ArrayItem{ key: 'discount_total', val: '' }, rt.ArrayItem{ key: 'discount_tax', val: '' }, rt.ArrayItem{ key: 'shipping_total', val: '' }, rt.ArrayItem{ key: 'shipping_tax', val: '' }, rt.ArrayItem{ key: 'cart_tax', val: '' }, rt.ArrayItem{ key: 'total', val: '' }, rt.ArrayItem{ key: 'total_tax', val: '' }, rt.ArrayItem{ key: 'customer', val: '' }, rt.ArrayItem{ key: 'customer_id', val: '' }, rt.ArrayItem{ key: 'order_key', val: '' }, rt.ArrayItem{ key: 'billing_first_name', val: '' }, rt.ArrayItem{ key: 'billing_last_name', val: '' }, rt.ArrayItem{ key: 'billing_company', val: '' }, rt.ArrayItem{ key: 'billing_address_1', val: '' }, rt.ArrayItem{ key: 'billing_address_2', val: '' }, rt.ArrayItem{ key: 'billing_city', val: '' }, rt.ArrayItem{ key: 'billing_state', val: '' }, rt.ArrayItem{ key: 'billing_postcode', val: '' }, rt.ArrayItem{ key: 'billing_country', val: '' }, rt.ArrayItem{ key: 'billing_email', val: '' }, rt.ArrayItem{ key: 'billing_phone', val: '' }, rt.ArrayItem{ key: 'shipping_first_name', val: '' }, rt.ArrayItem{ key: 'shipping_last_name', val: '' }, rt.ArrayItem{ key: 'shipping_company', val: '' }, rt.ArrayItem{ key: 'shipping_address_1', val: '' }, rt.ArrayItem{ key: 'shipping_address_2', val: '' }, rt.ArrayItem{ key: 'shipping_city', val: '' }, rt.ArrayItem{ key: 'shipping_state', val: '' }, rt.ArrayItem{ key: 'shipping_postcode', val: '' }, rt.ArrayItem{ key: 'shipping_country', val: '' }, rt.ArrayItem{ key: 'shipping_phone', val: '' }, rt.ArrayItem{ key: 'payment_method', val: '' }, rt.ArrayItem{ key: 'payment_method_title', val: '' }, rt.ArrayItem{ key: 'transaction_id', val: '' }, rt.ArrayItem{ key: 'customer_ip_address', val: '' }, rt.ArrayItem{ key: 'customer_user_agent', val: '' }, rt.ArrayItem{ key: 'created_via', val: '' }, rt.ArrayItem{ key: 'customer_note', val: '' }])])
}

fn (mut this Class_WC_Order_Query) get_orders() rt.PhpVal {
	mut var_args := rt.call_function('apply_filters', [rt.new_string('woocommerce_order_query_args'), this.get_query_vars()])
	mut var_results := rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order')), 'query', [var_args.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_query'), var_results.dup(), var_args.dup()])
}

struct Class_WC_Object_Query {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_order_query() &Class_WC_Order_Query {
	mut obj := &Class_WC_Order_Query{
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

fn (mut this Class_WC_Order_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_default_query_vars' {
			return this.get_default_query_vars()
		}
		'get_orders' {
			return this.get_orders()
		}
		else { return none }
	}
}

fn (this &Class_WC_Order_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_order_query_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
