import rt

struct Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster {
	rt.PhpObjectBase
pub mut:
		order_factory rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster) init()  {
	this.order_factory = rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()]), 'get_instance_of', [Class_Automattic_WooCommerce_Internal_WC_Order_Factory.class()])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_save_order_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'initialize_restock_refunded_items' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster) initialize_restock_refunded_items(var_order_id rt.PhpVal, var_items rt.PhpVal)  {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	mut var_order_version := rt.call_method(var_order, 'get_version', []rt.PhpVal{})
	if rt.is_true(rt.call_function('version_compare', [var_order_version.dup(), rt.new_string('5.5'), rt.new_string('>=')])) {
		return rt.new_null()
	}
	if 0 == rt.call_method(var_order, 'get_refunds', []rt.PhpVal{}).array_count() {
		return rt.new_null()
	}
	if var_items.array_isset(rt.new_string('order_item_id')) {
		{
			mut iter_1 := var_items.array_get('order_item_id').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item_id := item_1.val
				mut var_item := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_{"nodeType":"Expr_PropertyFetch","line":57,"var":{"nodeType":"Expr_Variable","line":57,"name":"this"},"name":"order_factory"}{}; return temp.get_order_item(arg_0) }(rt.call_function('absint', [var_item_id.dup()]))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
					continue
				}
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					continue
				}
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					continue
				}
				mut var_refunded_item_quantity := rt.call_function('abs', [rt.call_method(var_order, 'get_qty_refunded_for_item', [rt.call_method(var_item, 'get_id', []rt.PhpVal{})])])
				rt.call_method(var_item, 'add_meta_data', [rt.new_string('_restock_refunded_items'), var_refunded_item_quantity.dup(), rt.new_bool(false)])
				rt.call_method(var_item, 'save', []rt.PhpVal{})
			}
		}
	}
}

struct Class_Automattic_WooCommerce_Internal_{"nodeType":"Expr_PropertyFetch","line":57,"var":{"nodeType":"Expr_Variable","line":57,"name":"this"},"name":"order_factory"} {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restockrefundeditemsadjuster() &Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster{
		PhpObjectBase: rt.PhpObjectBase{}
		order_factory: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_{"nodetype":"expr_propertyfetch","line":57,"var":{"nodetype":"expr_variable","line":57,"name":"this"},"name":"order_factory"}() &Class_Automattic_WooCommerce_Internal_{"nodeType":"Expr_PropertyFetch","line":57,"var":{"nodeType":"Expr_Variable","line":57,"name":"this"},"name":"order_factory"} {
	mut obj := &Class_Automattic_WooCommerce_Internal_{"nodeType":"Expr_PropertyFetch","line":57,"var":{"nodeType":"Expr_Variable","line":57,"name":"this"},"name":"order_factory"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'initialize_restock_refunded_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.initialize_restock_refunded_items(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_factory' { return this.order_factory }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestockRefundedItemsAdjuster) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_factory' { this.order_factory = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_{"nodeType":"Expr_PropertyFetch","line":57,"var":{"nodeType":"Expr_Variable","line":57,"name":"this"},"name":"order_factory"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_{"nodeType":"Expr_PropertyFetch","line":57,"var":{"nodeType":"Expr_Variable","line":57,"name":"this"},"name":"order_factory"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_{"nodeType":"Expr_PropertyFetch","line":57,"var":{"nodeType":"Expr_Variable","line":57,"name":"this"},"name":"order_factory"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restockrefundeditemsadjuster_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
