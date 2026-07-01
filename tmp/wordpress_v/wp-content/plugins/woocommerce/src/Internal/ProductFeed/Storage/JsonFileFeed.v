import rt

pub fn Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed.upload_dir() string {
	return 'product-feeds'
}
struct Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed {
	rt.PhpObjectBase
pub mut:
		has_entries bool
		base_name string
		file_name rt.PhpVal = rt.new_null()
		file_path rt.PhpVal = rt.new_null()
		file_handle rt.PhpVal = rt.new_null()
		file_completed bool
		file_url rt.PhpVal = rt.new_null()
		is_temp_filepath bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) construct(base_name string)  {
	this.base_name = base_name
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) start()  {
	mut var_current_time := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_feed_time'), rt.call_function('time', []rt.PhpVal{}), rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed', ['FeedInterface'], &this)])
	mut var_hash_data := rt.new_string(this.base_name + (rt.call_function('gmdate', [rt.new_string('r'), var_current_time.dup()])).str())
	this.file_name = rt.call_function('sprintf', [rt.new_string('%s-%s-%s.json'), this.base_name, rt.call_function('gmdate', [rt.new_string('Y-m-d'), var_current_time.dup()]), rt.call_function('wp_hash', [var_hash_data.dup()])])
	this.file_path = (rt.call_function('get_temp_dir', []rt.PhpVal{})).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (this.file_name).str()
	this.file_handle = rt.call_function('fopen', [this.file_path, rt.new_string('w')])
	if rt.is_true(rt.identical(rt.new_bool(false), this.file_handle)) {
		mut var_upload_dir := this.get_upload_dir()
		this.file_path = rt.concat(var_upload_dir.array_get('path'), this.file_name)
		this.file_handle = rt.call_function('fopen', [this.file_path, rt.new_string('w')])
	} else {
		this.is_temp_filepath = true
	}
	if rt.is_true(rt.identical(rt.new_bool(false), this.file_handle)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to open feed file for writing: %s'), rt.new_string('woocommerce')]), this.file_path])]))))
	}
	rt.call_function('fwrite', [this.file_handle, rt.new_string('[')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) add_entry(mut var_entry Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_array)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [this.file_handle]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.has_entries)))) {
		this.has_entries = true
	} else {
		rt.call_function('fwrite', [this.file_handle, rt.new_string(',')])
	}
	mut var_json := rt.call_function('wp_json_encode', [var_entry])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('fwrite', [this.file_handle, var_json.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) end()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [this.file_handle]))))) {
		return rt.new_null()
	}
	rt.call_function('fwrite', [this.file_handle, rt.new_string(']')])
	rt.call_function('fclose', [this.file_handle])
	this.file_completed = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) get_file_path() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.file_completed)))) {
		return (rt.new_null()).str()
	}
	return (this.file_path).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) get_file_url() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.file_completed)))) {
		return (rt.new_null()).str()
	}
	mut var_upload_dir := this.get_upload_dir()
	if rt.is_true(this.is_temp_filepath) {
		mut var_tmp_path := this.file_path
		this.file_path = rt.concat(var_upload_dir.array_get('path'), this.file_name)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('copy', [var_tmp_path.dup(), this.file_path]))))) {
			mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
			mut var_error_message := if rt.is_true(rt.new_bool(var_error.dup().is_array())) { var_error.array_get('message') } else { rt.new_string('Unknown error') }
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to move feed file %1$s to upload directory: %2$s'), rt.new_string('woocommerce')]), this.file_path, var_error_message.dup()])]))))
		}
		rt.call_function('unlink', [var_tmp_path.dup()])
		this.is_temp_filepath = false
	}
	this.file_url = rt.concat(var_upload_dir.array_get('url'), this.file_name)
	return (this.file_url).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) get_upload_dir() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if !(var_prepared).is_null() {
		return var_prepared.dup()
	}
	mut var_upload_dir := rt.call_function('wp_upload_dir', [rt.new_null(), rt.new_bool(true)])
	mut var_directory_path := rt.new_string((var_upload_dir.array_get('basedir')).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str() + (Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed.upload_dir()).str() + (rt.get_constant('DIRECTORY_SEPARATOR')).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_directory_path.dup()]))))) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}; return temp.mkdir_p_not_indexable(arg_0) }(var_directory_path.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_directory_path.dup()]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to create feed directory: %s'), rt.new_string('woocommerce')]), var_directory_path.dup()])]))))
	}
	mut var_directory_url := rt.new_string((var_upload_dir.array_get('baseurl')).str() + '/' + (Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed.upload_dir()).str() + '/')
	mut var_prepared := rt.create_array([rt.ArrayItem{ key: 'path', val: var_directory_path }, rt.ArrayItem{ key: 'url', val: var_directory_url }])
	return var_prepared.dup()
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

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfeed_storage_jsonfilefeed(base_name string) &Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed{
		PhpObjectBase: rt.PhpObjectBase{}
		has_entries: false
		base_name: ''
		file_name: rt.new_null()
		file_path: rt.new_null()
		file_handle: rt.new_null()
		file_completed: false
		file_url: rt.new_null()
		is_temp_filepath: false
	}
	obj.construct(base_name)
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

fn create_automattic_woocommerce_internal_utilities_filesystemutil() &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'start' {
			this.start()
			return rt.new_null()
		}
		'add_entry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.add_entry(mut dispatch_arg_0)
			return rt.new_null()
		}
		'end' {
			this.end()
			return rt.new_null()
		}
		'get_file_path' {
			return rt.new_string(this.get_file_path())
		}
		'get_file_url' {
			return rt.new_string(this.get_file_url())
		}
		'get_upload_dir' {
			return this.get_upload_dir()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'has_entries' { return rt.new_bool(this.has_entries) }
		'base_name' { return rt.new_string(this.base_name) }
		'file_name' { return this.file_name }
		'file_path' { return this.file_path }
		'file_handle' { return this.file_handle }
		'file_completed' { return rt.new_bool(this.file_completed) }
		'file_url' { return this.file_url }
		'is_temp_filepath' { return rt.new_bool(this.is_temp_filepath) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'has_entries' { this.has_entries = (val).to_bool(); return true }
		'base_name' { this.base_name = (val).str(); return true }
		'file_name' { this.file_name = val; return true }
		'file_path' { this.file_path = val; return true }
		'file_handle' { this.file_handle = val; return true }
		'file_completed' { this.file_completed = (val).to_bool(); return true }
		'file_url' { this.file_url = val; return true }
		'is_temp_filepath' { this.is_temp_filepath = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productfeed_storage_jsonfilefeed_php() {
	// unsupported statement: Stmt_Declare
}
