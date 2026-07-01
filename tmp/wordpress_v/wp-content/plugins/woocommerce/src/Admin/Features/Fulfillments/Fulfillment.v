import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
pub mut:
		data rt.PhpVal = rt.new_array()
		meta_snapshot rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) construct(data string)  {
	this.Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data.construct(rt.new_string(data))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(data), 'Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment'))) {
		this.set_id(rt.call_function('absint', [rt.call_method(rt.new_string(data), 'get_id', []rt.PhpVal{})]))
	} else if rt.is_true(rt.new_bool(rt.new_string(data).is_long() || rt.new_string(data).is_double())) {
		this.set_id(rt.call_function('absint', [rt.new_string(data)]))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_string(data).is_array())) && rt.new_string(data).array_isset(rt.new_string('id')))) {
		this.set_id(rt.call_function('absint', [rt.new_string(data).array_get('id')]))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_string(data).is_string())) && !(data == ''))) {
		this.set_id(rt.call_function('absint', [rt.new_string(data)]))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_string(data).is_object())) && !(rt.get_property(rt.new_string(data), 'id')).is_null())) {
		this.set_id(rt.call_function('absint', [rt.get_property(rt.new_string(data), 'id')]))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment')))
	if this.get_id() > 0 {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment', ['Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data'], &this), 'data_store'), 'read', [rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment', ['Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data'], &this)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) snapshot_meta()  {
	this.meta_snapshot = rt.new_array()
	{
		mut iter_1 := this.get_meta_data().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			this.meta_snapshot.array_set(rt.get_property(var_meta, 'key'), rt.get_property(var_meta, 'value'))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_changes() rt.PhpVal {
	mut var_changes := this.Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data.get_changes()
	mut var_current_meta := rt.new_array()
	{
		mut iter_1 := this.get_meta_data().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			var_current_meta.array_set(rt.get_property(var_meta, 'key'), rt.get_property(var_meta, 'value'))
		}
	}
	mut var_meta_changes := rt.new_array()
	{
		mut iter_1 := var_current_meta.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.meta_snapshot.array_isset(var_key.dup())))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_meta_changes.array_set(var_key, var_value.dup())
			}
		}
	}
	{
		mut iter_1 := this.meta_snapshot.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_current_meta.dup().array_isset(var_key.dup())))))) {
				var_meta_changes.array_set(var_key, rt.new_null())
			}
		}
	}
	if !(!rt.is_true(var_meta_changes)) {
		var_changes.array_set('meta_data', var_meta_changes.dup())
	}
	return var_changes.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) apply_changes()  {
	this.Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data.apply_changes()
	this.snapshot_meta()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_id() i64 {
	return (if !(this.data.array_get('id')).is_null() { this.data.array_get('id') } else { rt.new_int(0) }).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_id(var_id rt.PhpVal)  {
	this.data.array_set('id', if rt.is_true(rt.new_bool(var_id.dup().is_long() || var_id.dup().is_double())) { rt.call_function('absint', [var_id.dup()]) } else { rt.new_int(0) })
	this.Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data.set_id(this.data.array_get('id'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_entity_type() string {
	return (this.get_prop(rt.new_string('entity_type'))).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_entity_type(mut var_entity_type Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string)  {
	mut var_entity_type_mutated := var_entity_type
	this.set_prop(rt.new_string('entity_type'), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_?string', []string{}, var_entity_type_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_entity_id() string {
	return (this.get_prop(rt.new_string('entity_id'))).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_entity_id(mut var_entity_id Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string)  {
	mut var_entity_id_mutated := var_entity_id
	this.set_prop(rt.new_string('entity_id'), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_?string', []string{}, var_entity_id_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_status(mut var_status Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string)  {
	mut var_status_mutated := var_status
	mut var_statuses := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{}; return temp.get_fulfillment_statuses() }()
	if !(var_statuses.array_isset(var_status_mutated)) {
		var_status_mutated = rt.new_string(if this.get_is_fulfilled() { rt.new_string('fulfilled') } else { rt.new_string('unfulfilled') })
	}
	this.set_is_fulfilled((if !(var_statuses.array_get(var_status_mutated).array_get('is_fulfilled')).is_null() { var_statuses.array_get(var_status_mutated).array_get('is_fulfilled') } else { rt.new_bool(false) }).to_bool())
	this.set_prop(rt.new_string('status'), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_?string', []string{}, var_status_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_status() string {
	return (this.get_prop(rt.new_string('status'))).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_is_fulfilled(is_fulfilled bool)  {
	this.set_prop(rt.new_string('is_fulfilled'), rt.new_bool(is_fulfilled))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_is_fulfilled() bool {
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) is_locked() bool {
	return rt.is_true(this.get_meta(rt.new_string('_is_locked')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_lock_message() string {
	return (if !(this.get_meta(rt.new_string('_lock_message'))).is_null() { this.get_meta(rt.new_string('_lock_message')) } else { rt.new_string('') }).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_locked(locked bool, message string)  {
	this.update_meta_data(rt.new_string('_is_locked'), rt.new_bool(locked))
	if var_locked {
		this.update_meta_data(rt.new_string('_lock_message'), rt.new_string(message))
	} else {
		this.delete_meta_data(rt.new_string('_lock_message'))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_date_updated() string {
	return (this.get_prop(rt.new_string('date_updated'))).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_date_updated(mut var_date_updated Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string)  {
	this.set_prop(rt.new_string('date_updated'), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_?string', []string{}, var_date_updated))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_date_fulfilled() string {
	return (if rt.is_true(this.meta_exists(rt.new_string('_date_fulfilled'))) { this.get_meta(rt.new_string('_date_fulfilled'), rt.new_bool(true)) } else { rt.new_null() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_date_fulfilled(date_fulfilled string)  {
	this.add_meta_data(rt.new_string('_date_fulfilled'), rt.new_string(date_fulfilled), rt.new_bool(true))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_date_deleted() string {
	return (this.get_prop(rt.new_string('date_deleted'))).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_date_deleted(mut var_date_deleted Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string)  {
	this.set_prop(rt.new_string('date_deleted'), rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_?string', []string{}, var_date_deleted))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_items() rt.PhpVal {
	mut var_items := this.get_meta(rt.new_string('_items'))
	return if rt.is_true(var_items) { var_items } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_items(mut var_items Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array)  {
	mut var_items_mutated := var_items
	this.update_meta_data(rt.new_string('_items'), rt.call_function('array_values', [var_items_mutated.dup()]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_item_count() i64 {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_item := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (rt.add(var_carry, // unsupported expression: Expr_Cast_Int)).to_i64()
	}
	return (rt.call_function('array_reduce', [this.get_items(), rt.new_closure(closure_1_fn), rt.new_int(0)])).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_tracking_number() string {
	mut var_value := this.get_meta(rt.new_string('_tracking_number'), rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_value.dup()]))))) {
		return (rt.new_null()).str()
	}
	var_value = // unsupported expression: Expr_Cast_String
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_value } else { rt.new_null() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_tracking_number(tracking_number string)  {
	this.update_meta_data(rt.new_string('_tracking_number'), rt.new_string(tracking_number))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_shipment_provider() string {
	mut var_value := this.get_meta(rt.new_string('_shipment_provider'), rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_value.dup()]))))) {
		return (rt.new_null()).str()
	}
	var_value = // unsupported expression: Expr_Cast_String
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_value } else { rt.new_null() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_shipment_provider(shipment_provider string)  {
	this.update_meta_data(rt.new_string('_shipment_provider'), rt.new_string(shipment_provider))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_tracking_url() string {
	mut var_value := this.get_meta(rt.new_string('_tracking_url'), rt.new_bool(true))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_value.dup()]))))) {
		return (rt.new_null()).str()
	}
	var_value = // unsupported expression: Expr_Cast_String
	return (if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_value } else { rt.new_null() }).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) set_tracking_url(tracking_url string)  {
	this.update_meta_data(rt.new_string('_tracking_url'), rt.new_string(tracking_url))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_order() rt.PhpVal {
	mut var_entity_type := rt.new_string(this.get_entity_type())
	mut var_entity_id := rt.new_string(this.get_entity_id())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_entity_type)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_entity_id)))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order.class(), var_entity_type)) {
		mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
		if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Order'))) {
			return var_order.dup()
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_raw_data() rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }]), this.data, rt.create_array([rt.ArrayItem{ key: 'meta_data', val: this.get_raw_meta_data() }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) get_raw_meta_data() rt.PhpVal {
	mut var_meta := rt.new_null()
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_meta := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.cast_array(rt.call_method(var_meta, 'get_data', []rt.PhpVal{}))
	}
	mut var_meta := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.cast_array(rt.call_method(var_meta, 'get_data', []rt.PhpVal{}))
	}
	return rt.call_function('array_map', [rt.new_closure(closure_2_fn), this.get_meta_data()])
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment(data string) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		meta_snapshot: rt.new_array()
	}
	obj.construct(data)
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data_store() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentutils() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'snapshot_meta' {
			this.snapshot_meta()
			return rt.new_null()
		}
		'get_changes' {
			return this.get_changes()
		}
		'apply_changes' {
			this.apply_changes()
			return rt.new_null()
		}
		'get_id' {
			return rt.new_int(this.get_id())
		}
		'set_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_id(dispatch_arg_0)
			return rt.new_null()
		}
		'get_entity_type' {
			return rt.new_string(this.get_entity_type())
		}
		'set_entity_type' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_entity_type(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_entity_id' {
			return rt.new_string(this.get_entity_id())
		}
		'set_entity_id' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_entity_id(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_status(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_status' {
			return rt.new_string(this.get_status())
		}
		'set_is_fulfilled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_is_fulfilled(dispatch_arg_0)
			return rt.new_null()
		}
		'get_is_fulfilled' {
			return rt.new_bool(this.get_is_fulfilled())
		}
		'is_locked' {
			return rt.new_bool(this.is_locked())
		}
		'get_lock_message' {
			return rt.new_string(this.get_lock_message())
		}
		'set_locked' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.set_locked(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_date_updated' {
			return rt.new_string(this.get_date_updated())
		}
		'set_date_updated' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_date_updated(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_date_fulfilled' {
			return rt.new_string(this.get_date_fulfilled())
		}
		'set_date_fulfilled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_date_fulfilled(dispatch_arg_0)
			return rt.new_null()
		}
		'get_date_deleted' {
			return rt.new_string(this.get_date_deleted())
		}
		'set_date_deleted' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_date_deleted(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_items' {
			return this.get_items()
		}
		'set_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_items(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_item_count' {
			return rt.new_int(this.get_item_count())
		}
		'get_tracking_number' {
			return rt.new_string(this.get_tracking_number())
		}
		'set_tracking_number' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_tracking_number(dispatch_arg_0)
			return rt.new_null()
		}
		'get_shipment_provider' {
			return rt.new_string(this.get_shipment_provider())
		}
		'set_shipment_provider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_shipment_provider(dispatch_arg_0)
			return rt.new_null()
		}
		'get_tracking_url' {
			return rt.new_string(this.get_tracking_url())
		}
		'set_tracking_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_tracking_url(dispatch_arg_0)
			return rt.new_null()
		}
		'get_order' {
			return this.get_order()
		}
		'get_raw_data' {
			return this.get_raw_data()
		}
		'get_raw_meta_data' {
			return this.get_raw_meta_data()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'meta_snapshot' { return this.meta_snapshot }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' { this.data = val; return true }
		'meta_snapshot' { this.meta_snapshot = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_fulfillment_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
