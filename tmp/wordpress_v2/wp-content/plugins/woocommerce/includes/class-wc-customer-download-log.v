import rt

struct Class_WC_Customer_Download_Log {
	rt.PhpObjectBase
pub mut:
	object_type rt.PhpVal = rt.new_string('customer_download_log')
	data        rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Customer_Download_Log) construct(download_log i64) {
	this.Class_WC_Data.construct(rt.new_int(download_log))
	if rt.new_int(download_log).is_long() || rt.new_int(download_log).is_double()
		&& download_log > 0 {
		this.set_id(rt.new_int(download_log))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(download_log), 'self'))) {
		this.set_id(rt.call_method(rt.new_int(download_log), 'get_id', []rt.PhpVal{}))
	} else if rt.new_int(download_log).is_object()
		&& !(!rt.is_true(rt.get_property(rt.new_int(download_log), 'download_log_id'))) {
		this.set_id(rt.get_property(rt.new_int(download_log), 'download_log_id'))
		this.set_props(rt.cast_array(rt.new_int(download_log)))
		this.set_object_read(rt.new_bool(true))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('customer-download-log'))
	this.dispatch_set_prop('data_store', iife_result_0)
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Customer_Download_Log', [
			'WC_Data',
		], &this), 'data_store'), 'read', [
			rt.new_object('WC_Customer_Download_Log', ['WC_Data'], &this),
		])
	}
}

fn (mut this Class_WC_Customer_Download_Log) get_timestamp(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('timestamp'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download_Log) get_permission_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('permission_id'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download_Log) get_user_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_id'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download_Log) get_user_ip_address(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_ip_address'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download_Log) set_timestamp(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('timestamp'), var_date.clone())
}

fn (mut this Class_WC_Customer_Download_Log) set_permission_id(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('permission_id'), rt.call_function('absint', [
		var_value.clone()]))
}

fn (mut this Class_WC_Customer_Download_Log) set_user_id(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('user_id'), rt.call_function('absint', [
		var_value.clone()]))
}

fn (mut this Class_WC_Customer_Download_Log) set_user_ip_address(var_value rt.PhpVal) {
	this.set_prop(rt.new_string('user_ip_address'), var_value.clone())
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_customer_download_log(download_log i64) &Class_WC_Customer_Download_Log {
	mut obj := &Class_WC_Customer_Download_Log{
		PhpObjectBase: rt.PhpObjectBase{}
		object_type:   rt.new_string('customer_download_log')
		data:          rt.new_array()
	}
	obj.construct(download_log)
	return obj
}

fn create_wc_data(_args ...rt.PhpVal) &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer_Download_Log) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_timestamp' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_timestamp(dispatch_arg_0)
		}
		'get_permission_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_permission_id(dispatch_arg_0)
		}
		'get_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_user_id(dispatch_arg_0)
		}
		'get_user_ip_address' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_user_ip_address(dispatch_arg_0)
		}
		'set_timestamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_timestamp(dispatch_arg_0)
			return rt.new_null()
		}
		'set_permission_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_permission_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_user_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_ip_address' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_user_ip_address(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Customer_Download_Log) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object_type' { return this.object_type }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Customer_Download_Log) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object_type' {
			this.object_type = val
			return true
		}
		'data' {
			this.data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
