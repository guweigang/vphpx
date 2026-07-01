import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_modal_opened(source string, order_id i64)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_modal_opened'), rt.create_array([rt.ArrayItem{ key: 'source', val: source }, rt.ArrayItem{ key: 'order_id', val: order_id }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_creation(source string, initial_status string, fulfillment_type string, item_count i64, total_quantity i64, notification_sent bool)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_created'), rt.create_array([rt.ArrayItem{ key: 'source', val: source }, rt.ArrayItem{ key: 'initial_status', val: initial_status }, rt.ArrayItem{ key: 'fulfillment_type', val: fulfillment_type }, rt.ArrayItem{ key: 'item_count', val: item_count }, rt.ArrayItem{ key: 'total_quantity', val: total_quantity }, rt.ArrayItem{ key: 'notification_sent', val: notification_sent }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_update(source string, fulfillment_id i64, original_status string, mut var_changed_fields Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array, notification_sent bool)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_updated'), rt.create_array([rt.ArrayItem{ key: 'source', val: source }, rt.ArrayItem{ key: 'fulfillment_id', val: fulfillment_id }, rt.ArrayItem{ key: 'original_status', val: original_status }, rt.ArrayItem{ key: 'changed_fields', val: var_changed_fields }, rt.ArrayItem{ key: 'notification_sent', val: notification_sent }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_deletion(source string, fulfillment_id i64, status_at_deletion string, notification_sent bool)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_deleted'), rt.create_array([rt.ArrayItem{ key: 'source', val: source }, rt.ArrayItem{ key: 'fulfillment_id', val: fulfillment_id }, rt.ArrayItem{ key: 'status_at_deletion', val: status_at_deletion }, rt.ArrayItem{ key: 'notification_sent', val: notification_sent }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_tracking_added(fulfillment_id i64, entry_method string, provider_name string, is_custom_provider bool)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_tracking_added'), rt.create_array([rt.ArrayItem{ key: 'fulfillment_id', val: fulfillment_id }, rt.ArrayItem{ key: 'entry_method', val: entry_method }, rt.ArrayItem{ key: 'provider_name', val: provider_name }, rt.ArrayItem{ key: 'is_custom_provider', val: is_custom_provider }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_tracking_lookup_attempt(lookup_status string, provider_identified string, url_generated bool)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_tracking_lookup_attempted'), rt.create_array([rt.ArrayItem{ key: 'lookup_status', val: lookup_status }, rt.ArrayItem{ key: 'provider_identified', val: provider_identified }, rt.ArrayItem{ key: 'url_generated', val: url_generated }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_bulk_action_used(action string, order_count i64)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_bulk_action_used'), rt.create_array([rt.ArrayItem{ key: 'action', val: action }, rt.ArrayItem{ key: 'order_count', val: order_count }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_filter_used(filter_by string, filter_value string)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_filter_used'), rt.create_array([rt.ArrayItem{ key: 'filter_by', val: filter_by }, rt.ArrayItem{ key: 'filter_value', val: filter_value }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_notification_sent(trigger_action string, fulfillment_id i64, order_id i64)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_notification_sent'), rt.create_array([rt.ArrayItem{ key: 'trigger_action', val: trigger_action }, rt.ArrayItem{ key: 'fulfillment_id', val: fulfillment_id }, rt.ArrayItem{ key: 'order_id', val: order_id }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_email_template_customized(template_name string)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_email_template_customized'), rt.create_array([rt.ArrayItem{ key: 'template_name', val: template_name }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_validation_error(action_attempted string, error_code string, source string)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('fulfillment_validation_error'), rt.create_array([rt.ArrayItem{ key: 'action_attempted', val: action_attempted }, rt.ArrayItem{ key: 'error_code', val: error_code }, rt.ArrayItem{ key: 'source', val: source }]))
}

fn Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.determine_tracking_entry_method(source string, shipping_option string) string {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return 'api'
	}
	if rt.is_true(rt.identical(rt.new_string('tracking-number'), rt.new_string(shipping_option))) {
		return 'ui_auto_lookup'
	}
	if rt.is_true(rt.identical(rt.new_string('manual-entry'), rt.new_string(shipping_option))) {
		return 'ui_manual'
	}
	return 'api'
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentstracker() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks() &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'track_fulfillment_modal_opened' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_modal_opened(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'track_fulfillment_creation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_creation(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'track_fulfillment_update' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_update(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4)
			return rt.new_null()
		}
		'track_fulfillment_deletion' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_deletion(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'track_fulfillment_tracking_added' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_tracking_added(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'track_fulfillment_tracking_lookup_attempt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_tracking_lookup_attempt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'track_fulfillment_bulk_action_used' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_bulk_action_used(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'track_fulfillment_filter_used' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_filter_used(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'track_fulfillment_notification_sent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_notification_sent(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'track_fulfillment_email_template_customized' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_email_template_customized(dispatch_arg_0)
			return rt.new_null()
		}
		'track_fulfillment_validation_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.track_fulfillment_validation_error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'determine_tracking_entry_method' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker.determine_tracking_entry_method(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsTracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_fulfillmentstracker_php() {
	// unsupported statement: Stmt_Declare
}
