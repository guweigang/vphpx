import rt

struct Class_WC_Order_Refund_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
	internal_meta_keys rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Refund_Data_Store_CPT) delete(var_order rt.PhpVal, var_args rt.PhpVal) {
	mut var_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return
	}
	mut var_parent_order_id := rt.call_method(var_order, 'get_parent_id', []rt.PhpVal{})
	mut iife_temp_0 := Class_WC_Cache_Helper{}
	mut iife_result_0 := iife_temp_0.get_cache_prefix(rt.new_string('orders'))
	mut var_refund_cache_key := rt.new_string(iife_result_0.str() + 'refund_ids' +
		var_parent_order_id.str())
	rt.call_function('wp_delete_post', [var_id.clone()])
	rt.call_function('wp_cache_delete', [var_refund_cache_key.clone(),
		rt.new_string('orders')])
	rt.call_method(var_order, 'set_id', [rt.new_int(0)])
	rt.call_function('do_action', [rt.new_string('woocommerce_delete_order_refund'),
		var_id.clone()])
}

fn (mut this Class_WC_Order_Refund_Data_Store_CPT) read_order_data(var_refund rt.PhpVal, var_post_object rt.PhpVal) {
	this.Class_Abstract_WC_Order_Data_Store_CPT.read_order_data(var_refund.clone(),
		var_post_object.clone())
	mut var_id := rt.call_method(var_refund, 'get_id', []rt.PhpVal{})
	mut var_post_meta := rt.call_function('get_post_meta', [var_id.clone()])
	mut var_refunded_by := if !(var_post_meta.array_get(rt.new_string('_refunded_by')).array_get(rt.new_int(0))).is_null() {
		var_post_meta.array_get(rt.new_string('_refunded_by')).array_get(rt.new_int(0))
	} else {
		rt.new_null()
	}
	mut var_reason := if !(var_post_meta.array_get(rt.new_string('_refund_reason')).array_get(rt.new_int(0))).is_null() {
		var_post_meta.array_get(rt.new_string('_refund_reason')).array_get(rt.new_int(0))
	} else {
		rt.new_string('')
	}
	rt.call_method(var_refund, 'set_props', [
		rt.create_array([
			rt.ArrayItem{
				key: 'amount'
				val: if !(var_post_meta.array_get(rt.new_string('_refund_amount')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_refund_amount')).array_get(rt.new_int(0))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'refunded_by'
				val: if rt.is_true(rt.call_function('metadata_exists', [
					rt.new_string('post'),
					var_id.clone(),
					rt.new_string('_refunded_by'),
				]))
				{ var_refunded_by } else { rt.call_function('absint', [
						rt.get_property(var_post_object, 'post_author'),
					]) }
			},
			rt.ArrayItem{ key: 'refunded_payment', val: rt.call_function('wc_string_to_bool', [
				if !(var_post_meta.array_get(rt.new_string('_refunded_payment')).array_get(rt.new_int(0))).is_null() {
					var_post_meta.array_get(rt.new_string('_refunded_payment')).array_get(rt.new_int(0))
				} else {
					rt.new_bool(false)
				},
			]) },
			rt.ArrayItem{
				key: 'reason'
				val: if rt.is_true(rt.call_function('metadata_exists', [
					rt.new_string('post'),
					var_id.clone(),
					rt.new_string('_refund_reason'),
				]))
				{ var_reason } else { rt.get_property(var_post_object, 'post_excerpt') }
			},
		]),
	])
}

fn (mut this Class_WC_Order_Refund_Data_Store_CPT) update(var_refund rt.PhpVal) {
	this.Class_Abstract_WC_Order_Data_Store_CPT.update(var_refund.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_update_order_refund'),
		rt.call_method(var_refund, 'get_id', []rt.PhpVal{}), var_refund.clone()])
}

fn (mut this Class_WC_Order_Refund_Data_Store_CPT) update_post_meta(var_refund rt.PhpVal) {
	this.Class_Abstract_WC_Order_Data_Store_CPT.update_post_meta(var_refund.clone())
	mut var_updated_props := []rt.PhpVal{}
	mut var_meta_key_to_props := {
		'_refund_amount':    'amount'
		'_refunded_by':      'refunded_by'
		'_refunded_payment': 'refunded_payment'
		'_refund_reason':    'reason'
	}
	mut var_props_to_update := this.get_props_to_update(var_refund.clone(),
		var_meta_key_to_props.clone())
	mut iter_1 := var_props_to_update.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prop := item_1.val
		mut var_meta_key := item_1.key
		mut var_value := rt.call_method(var_refund, 'get_${var_prop.to_string()}', [
			rt.new_string('edit'),
		])
		rt.call_function('update_post_meta', [
			rt.call_method(var_refund, 'get_id', []rt.PhpVal{}),
			var_meta_key.clone(),
			var_value.clone(),
		])
		var_updated_props << var_prop.clone()
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_refund_object_updated_props'),
		var_refund.clone(),
		rt.create_array_from_list(var_updated_props),
	])
}

fn (mut this Class_WC_Order_Refund_Data_Store_CPT) get_post_title() rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Refund &ndash; %s'),
			rt.new_string('woocommerce')]),
		rt.call_method(create_datetime(rt.new_string('now')), 'format', [
			rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'),
				rt.new_string('Order date parsed by DateTime::format'),
				rt.new_string('woocommerce')])]),
	])
}

struct Class_Abstract_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wc_order_refund_data_store_cpt(_args ...rt.PhpVal) &Class_WC_Order_Refund_Data_Store_CPT {
	mut obj := &Class_WC_Order_Refund_Data_Store_CPT{
		PhpObjectBase:      rt.PhpObjectBase{}
		internal_meta_keys: rt.new_array()
	}
	return obj
}

fn create_abstract_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_Abstract_WC_Order_Data_Store_CPT {
	mut obj := &Class_Abstract_WC_Order_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Refund_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read_order_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.read_order_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_post_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'get_post_title' {
			return this.get_post_title()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Refund_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internal_meta_keys' { return this.internal_meta_keys }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Refund_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Abstract_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
