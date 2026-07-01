import rt

struct Class_WC_Customer_Download {
	rt.PhpObjectBase
pub mut:
		object_type rt.PhpVal = rt.new_string('customer_download')
		data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Customer_Download) construct(download i64)  {
	this.Class_WC_Data.construct(rt.new_int(download))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_int(download).is_long() || rt.new_int(download).is_double())) && download > 0)) {
		this.set_id(rt.new_int(download))
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(download), 'self'))) {
		this.set_id(rt.call_method(rt.new_int(download), 'get_id', []rt.PhpVal{}))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_int(download).is_object())) && !(!rt.is_true(rt.get_property(rt.new_int(download), 'permission_id'))))) {
		this.set_id(rt.get_property(rt.new_int(download), 'permission_id'))
		this.set_props(rt.cast_array(rt.new_int(download)))
		this.set_object_read(rt.new_bool(true))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download')))
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this), 'data_store'), 'read', [rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this)])
	}
}

fn (mut this Class_WC_Customer_Download) get_download_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('download_id'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_product_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('product_id'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_user_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_id'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_user_email(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('user_email'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_order_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('order_id'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_order_key(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('order_key'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_downloads_remaining(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('downloads_remaining'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_access_granted(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('access_granted'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_access_expires(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('access_expires'), rt.new_string(context))
}

fn (mut this Class_WC_Customer_Download) get_download_count(context string) rt.PhpVal {
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download-log'))
	mut var_download_log_count := rt.call_method(var_data_store, 'get_download_logs_count_for_permission', [this.get_id()])
	mut var_download_count_prop := this.get_prop(rt.new_string('download_count'), rt.new_string(context))
	return rt.call_function('max', [var_download_log_count.dup(), var_download_count_prop.dup()])
}

fn (mut this Class_WC_Customer_Download) set_download_id(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('download_id'), var_value.dup())
}

fn (mut this Class_WC_Customer_Download) set_product_id(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('product_id'), rt.call_function('absint', [var_value.dup()]))
}

fn (mut this Class_WC_Customer_Download) set_user_id(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('user_id'), rt.call_function('absint', [var_value.dup()]))
}

fn (mut this Class_WC_Customer_Download) set_user_email(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('user_email'), rt.call_function('sanitize_email', [var_value.dup()]))
}

fn (mut this Class_WC_Customer_Download) set_order_id(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('order_id'), rt.call_function('absint', [var_value.dup()]))
}

fn (mut this Class_WC_Customer_Download) set_order_key(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('order_key'), var_value.dup())
}

fn (mut this Class_WC_Customer_Download) set_downloads_remaining(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('downloads_remaining'), if rt.is_true(rt.identical(rt.new_string(''), var_value)) { rt.new_string('') } else { rt.call_function('absint', [var_value.dup()]) })
}

fn (mut this Class_WC_Customer_Download) set_access_granted(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string('access_granted'), var_date.dup())
}

fn (mut this Class_WC_Customer_Download) set_access_expires(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string('access_expires'), var_date.dup())
}

fn (mut this Class_WC_Customer_Download) set_download_count(var_value rt.PhpVal)  {
	this.set_prop(rt.new_string('download_count'), rt.call_function('absint', [var_value.dup()]))
}

fn (mut this Class_WC_Customer_Download) track_download(var_user_id rt.PhpVal, var_user_ip_address rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.greater(this.get_id(), rt.new_int(0)))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [rt.new_string('Invalid permission ID.'), rt.new_string('woocommerce')]))))
	}
	mut var_query := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\nUPDATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions\nSET download_count = download_count + 1,\ndownloads_remaining = IF( downloads_remaining = \'\', \'\', GREATEST( 0, downloads_remaining - 1 ) )\nWHERE permission_id = %d')), this.get_id()])
	rt.call_method(var_wpdb, 'query', [var_query.dup()])
	rt.call_method(rt.get_property(rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this), 'data_store'), 'read', [rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this)])
	mut var_download_log := create_wc_customer_download_log()
	var_download_log.set_timestamp(rt.call_function('time', []rt.PhpVal{}))
	var_download_log.set_permission_id(this.get_id())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_user_id.dup().is_null()))))) {
		var_download_log.set_user_id(var_user_id.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_user_ip_address.dup().is_null()))))) {
		var_download_log.set_user_ip_address(var_user_ip_address.dup())
	}
	var_download_log.save()
}

fn (mut this Class_WC_Customer_Download) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: "get_${var_offset.to_string()}" }])])) {
		return rt.call_method(rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this), "get_${var_offset.to_string()}", []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_WC_Customer_Download) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: "set_${var_offset.to_string()}" }])])) {
		rt.call_method(rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this), "set_${var_offset.to_string()}", [var_value.dup()])
	}
}

fn (mut this Class_WC_Customer_Download) offsetunset(var_offset rt.PhpVal)  {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: "set_${var_offset.to_string()}" }])])) {
		rt.call_method(rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this), "set_${var_offset.to_string()}", [rt.new_string('')])
	}
}

fn (mut this Class_WC_Customer_Download) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_offset.dup(), rt.func_array_keys(this.data), rt.new_bool(true)])
}

fn (mut this Class_WC_Customer_Download) magic_isset(var_key rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_key.dup(), rt.func_array_keys(this.data), rt.new_bool(true)])
}

fn (mut this Class_WC_Customer_Download) magic_get(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this) }, rt.ArrayItem{ key: none, val: "get_${var_key.to_string()}" }])])) {
		return rt.call_method(rt.new_object('WC_Customer_Download', ['WC_Data', 'ArrayAccess'], &this), "get_${var_key.to_string()}", [rt.new_string('')])
	}
	return rt.new_null()
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Customer_Download_Log {
	rt.PhpObjectBase
}

fn create_wc_customer_download(download i64) &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
		object_type: rt.new_string('customer_download')
		data: rt.new_array()
	}
	obj.construct(download)
	return obj
}

fn create_wc_data() &Class_WC_Data {
	mut obj := &Class_WC_Data{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_customer_download_log() &Class_WC_Customer_Download_Log {
	mut obj := &Class_WC_Customer_Download_Log{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_download_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_download_id(dispatch_arg_0)
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
		'get_order_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_id(dispatch_arg_0)
		}
		'get_order_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_order_key(dispatch_arg_0)
		}
		'get_downloads_remaining' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_downloads_remaining(dispatch_arg_0)
		}
		'get_access_granted' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_access_granted(dispatch_arg_0)
		}
		'get_access_expires' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_access_expires(dispatch_arg_0)
		}
		'get_download_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_download_count(dispatch_arg_0)
		}
		'set_download_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_download_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_user_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_user_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_user_email(dispatch_arg_0)
			return rt.new_null()
		}
		'set_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_order_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_order_key(dispatch_arg_0)
			return rt.new_null()
		}
		'set_downloads_remaining' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_downloads_remaining(dispatch_arg_0)
			return rt.new_null()
		}
		'set_access_granted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_access_granted(dispatch_arg_0)
			return rt.new_null()
		}
		'set_access_expires' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_access_expires(dispatch_arg_0)
			return rt.new_null()
		}
		'set_download_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_download_count(dispatch_arg_0)
			return rt.new_null()
		}
		'track_download' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.track_download(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetUnset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.offsetunset(dispatch_arg_0)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetexists(dispatch_arg_0)
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_isset(dispatch_arg_0)
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Customer_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object_type' { return this.object_type }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Customer_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object_type' { this.object_type = val; return true }
		'data' { this.data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Customer_Download_Log) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download_Log) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download_Log) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_customer_download_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
