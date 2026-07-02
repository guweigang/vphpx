import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_TransientNotices.queue_option() string {
	return 'woocommerce_admin_transient_notices_queue'
}

struct Class_Automattic_WooCommerce_Admin_Features_TransientNotices {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) construct() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_preload_options'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_TransientNotices',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'preload_options' },
		])])
}

fn Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue() rt.PhpVal {
	return rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_TransientNotices.queue_option(),
		rt.new_array(),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue_by_user(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_notices := Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue()
	closure_1_fn := fn [var_user_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_notice := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(!(var_notice.array_isset(rt.new_string('user_id')))
			|| rt.is_true(rt.identical(rt.new_null(), var_notice.array_get(rt.new_string('user_id'))))
			|| rt.is_true(rt.identical(var_user_id, var_notice.array_get(rt.new_string('user_id')))))
	}
	return rt.call_function('array_filter', [var_notices.clone(),
		rt.new_closure(closure_1_fn)])
}

fn Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get(var_notice_id rt.PhpVal) rt.PhpVal {
	mut var_queue := Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue()
	if var_queue.array_isset(var_notice_id) {
		return var_queue.array_get(var_notice_id)
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_Features_TransientNotices.add(var_notice rt.PhpVal) {
	mut var_queue := Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue()
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'user_id', val: rt.new_null() },
		rt.ArrayItem{ key: 'status', val: 'info' },
		rt.ArrayItem{ key: 'options', val: rt.new_array() },
	])
	mut var_notice_data := rt.call_function('array_merge', [var_defaults.clone(),
		var_notice.clone()])
	var_notice_data.array_set('options',
		rt.array_to_object(var_notice_data.array_get(rt.new_string('options'))))
	var_queue.array_set(var_notice.array_get(rt.new_string('id')), var_notice_data.clone())
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_TransientNotices.queue_option(),
		var_queue.clone(),
	])
}

fn Class_Automattic_WooCommerce_Admin_Features_TransientNotices.remove(var_notice_id rt.PhpVal) {
	mut var_queue := Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue()
	var_queue.array_unset(var_notice_id)
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_TransientNotices.queue_option(),
		var_queue.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) preload_options(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	var_options_mutated.array_push(Class_Automattic_WooCommerce_Admin_Features_Automattic_WooCommerce_Admin_Features_TransientNotices.queue_option())
	return var_options_mutated.clone()
}

fn create_automattic_woocommerce_admin_features_transientnotices() &Class_Automattic_WooCommerce_Admin_Features_TransientNotices {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_TransientNotices{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_queue' {
			return Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue()
		}
		'get_queue_by_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get_queue_by_user(dispatch_arg_0)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_TransientNotices.get(dispatch_arg_0)
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_TransientNotices.add(dispatch_arg_0)
			return rt.new_null()
		}
		'remove' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Admin_Features_TransientNotices.remove(dispatch_arg_0)
			return rt.new_null()
		}
		'preload_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.preload_options(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_TransientNotices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
