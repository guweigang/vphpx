import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	rt.PhpObjectBase
pub mut:
		object_type rt.PhpVal = rt.new_string('stock_notification')
		product rt.PhpVal = rt.new_null()
		data rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) construct(read i64) {
	this.Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data.construct(rt.new_int(read))
	if rt.new_int(read).is_long() || rt.new_int(read).is_double() && read > 0 {
		this.set_id(rt.new_int(read))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(read), 'Automattic_WooCommerce_Internal_StockNotifications_self'))) {
		this.set_id(rt.call_method(rt.new_int(read), 'get_id', []rt.PhpVal{}))
	} else if !(!rt.is_true(rt.get_property(rt.new_int(read), 'ID'))) {
		this.set_id(rt.call_function('absint', [rt.get_property(rt.new_int(read), 'ID')]))
	} else if rt.new_int(read).is_array() && !(!rt.is_true(rt.new_int(read).array_get(rt.new_string('id')))) {
		this.set_props(rt.new_int(read))
		this.set_object_read(rt.new_bool(true))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('stock_notification'))
	this.dispatch_set_prop('data_store', iife_result_0)
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', ['Automattic_WooCommerce_Internal_StockNotifications_WC_Data'], &this), 'data_store'), 'read', [rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', ['Automattic_WooCommerce_Internal_StockNotifications_WC_Data'], &this)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_product_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('product_id'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_user_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_id'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_user_email(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_email'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_status(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('status'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_date_created(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_created'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_date_modified(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_modified'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_date_confirmed(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_confirmed'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_date_last_attempt(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_last_attempt'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_date_notified(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_notified'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_date_cancelled(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_cancelled'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_cancellation_source(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('cancellation_source'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_product() bool {
	if !(!rt.is_true(this.product)) {
		return (this.product).to_bool()
	}
	mut var_product := rt.call_function('wc_get_product', [this.get_prop(rt.new_string('product_id'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return false
	}
	this.product = var_product.clone()
	return (var_product).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_product_id(product_id i64) {
	if rt.is_true(rt.call_function('is_a', [this.product, rt.new_string('WC_Product')])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(product_id), rt.call_method(this.product, 'get_id', []rt.PhpVal{}))))) {
		this.product = rt.new_null()
	}
	this.set_prop(rt.new_string('product_id'), rt.new_int(product_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_user_id(user_id i64) {
	this.set_prop(rt.new_string('user_id'), rt.new_int(user_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_user_email(user_email string) {
	this.set_prop(rt.new_string('user_email'), rt.new_string(user_email))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_status(status string) {
	mut status_mutated := status
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus{}
	mut iife_result_1 := iife_temp_1.get_valid_statuses()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(status_mutated).clone(), iife_result_1, rt.new_bool(true)]))))) {
	status_mutated = (Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus.pending()).str()
	}
	this.set_prop(rt.new_string('status'), rt.new_string(status_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_date_created(var_date_created rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_created'), var_date_created.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_date_modified(var_date_modified rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_modified'), var_date_modified.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_date_confirmed(var_date_confirmed rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_confirmed'), var_date_confirmed.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_date_last_attempt(var_date_last_attempt rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_last_attempt'), var_date_last_attempt.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_date_notified(var_date_notified rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_notified'), var_date_notified.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_date_cancelled(var_date_cancelled rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_cancelled'), var_date_cancelled.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) set_cancellation_source(mut var_cancellation_source Class_Automattic_WooCommerce_Internal_StockNotifications_?string) {
	mut var_cancellation_source_mutated := var_cancellation_source
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource{}
	mut iife_result_2 := iife_temp_2.get_valid_cancellation_sources()
	if rt.is_true(var_cancellation_source_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_cancellation_source_mutated, iife_result_2, rt.new_bool(true)]))))) {
	var_cancellation_source_mutated = Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource.user()
	}
	this.set_prop(rt.new_string('cancellation_source'), rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_?string', []string{}, var_cancellation_source_mutated))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) validate_props() {
	if !rt.is_true(this.get_prop(rt.new_string('product_id'))) {
		this.error(rt.new_string('stock_notification_product_id_required'), rt.call_function('__', [rt.new_string('Product ID is required.'), rt.new_string('woocommerce')]))
	}
	if !rt.is_true(this.get_prop(rt.new_string('user_id'))) && !rt.is_true(this.get_prop(rt.new_string('user_email'))) {
		this.error(rt.new_string('stock_notification_user_id_or_user_email_required'), rt.call_function('__', [rt.new_string('User ID or User Email is required.'), rt.new_string('woocommerce')]))
	}
	if !(!rt.is_true(this.get_prop(rt.new_string('user_email')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('filter_var', [this.get_prop(rt.new_string('user_email')), rt.get_constant('FILTER_VALIDATE_EMAIL')]))))) {
		this.error(rt.new_string('stock_notification_user_email_invalid'), rt.call_function('__', [rt.new_string('User Email is invalid.'), rt.new_string('woocommerce')]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) save() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', ['Automattic_WooCommerce_Internal_StockNotifications_WC_Data'], &this), 'data_store'))))) {
		return this.get_id()
	}
	this.validate_props()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_WP_Error', []string{}, create_automattic_woocommerce_internal_stocknotifications_wp_error(rt.new_string('stock_notification_validation_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(this.get_id()) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', ['Automattic_WooCommerce_Internal_StockNotifications_WC_Data'], &this), 'data_store'), 'update', [rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', ['Automattic_WooCommerce_Internal_StockNotifications_WC_Data'], &this)])
	} else {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', ['Automattic_WooCommerce_Internal_StockNotifications_WC_Data'], &this), 'data_store'), 'create', [rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Notification', ['Automattic_WooCommerce_Internal_StockNotifications_WC_Data'], &this)])
	}
	return this.get_id()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_product_formatted_variation_list(flat bool) string {
	mut var_product := rt.new_bool(this.get_product())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_type', [rt.create_array([rt.ArrayItem{ key: none, val: 'variation' }])]))))) {
		return ''
	}
	mut var_attributes := this.get_meta(rt.new_string('posted_attributes'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes)))) {
	var_attributes = rt.call_method(var_product, 'get_attributes', []rt.PhpVal{})
	}
	if !rt.is_true(var_attributes) {
		return ''
	}
	mut var_attrs := rt.new_array()
	mut iter_1 := var_attributes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_key.clone(), rt.new_string('attribute_pa_')]))) {
			var_attrs.array_set(rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), var_key.clone()]), var_value.clone())
		} else {
			var_attrs.array_set(rt.call_function('wc_attribute_label', [rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), var_key.clone()]), var_product.clone()]), var_value.clone())
		}
	}
	mut var_formatted_variation_list := rt.call_function('wc_get_formatted_variation', [var_attrs.clone(), rt.new_bool(flat), rt.new_bool(true), rt.new_bool(true)])
	return (var_formatted_variation_list).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_product_permalink() string {
	mut var_product := rt.new_bool(this.get_product())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	if rt.is_true(rt.call_method(var_product, 'is_type', [rt.new_string('variation')])) && !(!rt.is_true(this.get_meta(rt.new_string('posted_attributes')))) {
		return (rt.call_method(var_product, 'get_permalink', [rt.create_array([rt.ArrayItem{ key: 'item_meta_array', val: this.get_meta(rt.new_string('posted_attributes')) }])])).str()
	} else {
		return (rt.call_method(var_product, 'get_permalink', []rt.PhpVal{})).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_product_name() string {
	mut var_product := rt.new_bool(this.get_product())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	return (if rt.is_true(rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})) { rt.call_method(var_product, 'get_name', []rt.PhpVal{}) } else { rt.call_method(var_product, 'get_title', []rt.PhpVal{}) }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) check_verification_key(key string) bool {
	mut var_timestamp := rt.new_null()
	mut var_hash := rt.new_null()
	mut key_mutated := key
	mut var_action_key := this.get_meta(rt.new_string('email_link_action_key'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_action_key.clone(), rt.new_string(':')]))))) {
		return false
	}
	mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'), var_action_key.clone(), rt.new_int(2)])
	var_timestamp = (list_tmp_1).array_get(0)
	var_hash = (list_tmp_1).array_get(1)
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
	mut iife_result_3 := iife_temp_3.get_verification_expiration_time_threshold()
	mut var_threshold := iife_result_3
	if rt.is_true(rt.greater(rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.new_int((var_timestamp).to_i64())), var_threshold)) {
		return false
	}
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper{}
	mut iife_result_4 := iife_temp_4.wp_verify_fast_hash(rt.new_string(key_mutated), var_hash.clone())
	return (iife_result_4).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_verification_key(persist bool) string {
	mut var_key := rt.call_function('wp_generate_password', [rt.new_int(20), rt.new_bool(false)])
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper{}
	mut iife_result_5 := iife_temp_5.wp_fast_hash(var_key.clone())
	this.update_meta_data(rt.new_string('email_link_action_key'), rt.new_string((rt.call_function('time', []rt.PhpVal{})).str() + ':' + (iife_result_5).str()))
	if var_persist {
		this.save()
	}
	return (var_key).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) check_unsubscribe_key(key string) bool {
	mut key_mutated := key
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper{}
	mut iife_result_6 := iife_temp_6.wp_verify_fast_hash(rt.new_string(key_mutated), this.get_meta(rt.new_string('email_link_action_key')))
	return (iife_result_6).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) get_unsubscribe_key(persist bool) string {
	mut var_key := rt.call_function('wp_generate_password', [rt.new_int(20), rt.new_bool(false)])
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper{}
	mut iife_result_7 := iife_temp_7.wp_fast_hash(var_key.clone())
	mut var_hash := iife_result_7
	this.update_meta_data(rt.new_string('email_link_action_key'), var_hash.clone())
	if var_persist {
		this.save()
	}
	return (var_key).str()
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_notification(read i64) &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
		object_type: rt.new_string('stock_notification')
		product: rt.new_null()
		data: rt.new_array()
	}
	obj.construct(read)
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_wc_data(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_enums_notificationstatus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_enums_notificationcancellationsource(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_config(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_utilities_hasherhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_product_id(dispatch_arg_0)
		}
		'get_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_user_id(dispatch_arg_0)
		}
		'get_user_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_user_email(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_status(dispatch_arg_0)
		}
		'get_date_created' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_created(dispatch_arg_0)
		}
		'get_date_modified' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_modified(dispatch_arg_0)
		}
		'get_date_confirmed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_confirmed(dispatch_arg_0)
		}
		'get_date_last_attempt' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_last_attempt(dispatch_arg_0)
		}
		'get_date_notified' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_notified(dispatch_arg_0)
		}
		'get_date_cancelled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_cancelled(dispatch_arg_0)
		}
		'get_cancellation_source' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cancellation_source(dispatch_arg_0)
		}
		'get_product' {
			return rt.new_bool(this.get_product())
		}
		'set_product_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_product_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_user_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_user_email(dispatch_arg_0)
			return rt.new_null()
		}
		'set_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_created(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_modified(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_confirmed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_confirmed(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_last_attempt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_last_attempt(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_notified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_notified(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_cancelled' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_cancelled(dispatch_arg_0)
			return rt.new_null()
		}
		'set_cancellation_source' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_cancellation_source(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate_props' {
			this.validate_props()
			return rt.new_null()
		}
		'save' {
			return this.save()
		}
		'get_product_formatted_variation_list' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_product_formatted_variation_list(dispatch_arg_0))
		}
		'get_product_permalink' {
			return rt.new_string(this.get_product_permalink())
		}
		'get_product_name' {
			return rt.new_string(this.get_product_name())
		}
		'check_verification_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.check_verification_key(dispatch_arg_0))
		}
		'get_verification_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_verification_key(dispatch_arg_0))
		}
		'check_unsubscribe_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.check_unsubscribe_key(dispatch_arg_0))
		}
		'get_unsubscribe_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_unsubscribe_key(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object_type' { return this.object_type }
		'product' { return this.product }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object_type' { this.object_type = val; return true }
		'product' { this.product = val; return true }
		'data' { this.data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Enums_NotificationCancellationSource) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Utilities_HasherHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
