import rt

struct Class_WC_Product_Download {
	rt.PhpObjectBase
pub mut:
	data       rt.PhpVal = rt.new_array()
	extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Download) get_data() rt.PhpVal {
	return rt.call_function('array_merge', [this.extra_data, this.data])
}

fn (mut this Class_WC_Product_Download) get_allowed_mime_types() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_downloadable_file_allowed_mime_types'),
		rt.call_function('get_allowed_mime_types', []rt.PhpVal{}),
	])
}

fn (mut this Class_WC_Product_Download) get_type_of_file_path(file_path string) string {
	mut file_path_mutated := file_path
	file_path_mutated = (if rt.is_true(rt.new_string(file_path_mutated)) {
		rt.new_string(file_path_mutated)
	} else {
		this.get_file()
	}).str()
	mut var_parsed_url := rt.call_function('wp_parse_url',
		[rt.new_string(file_path_mutated).clone()])
	if rt.is_true(var_parsed_url) && var_parsed_url.array_isset(rt.new_string('host'))
		&& !(var_parsed_url.array_isset(rt.new_string('scheme')))
		|| rt.is_true(rt.call_function('in_array', [var_parsed_url.array_get(rt.new_string('scheme')), rt.create_array([rt.ArrayItem{
		key: none
		val: 'http'
	}, rt.ArrayItem{ key: none, val: 'https' }]), rt.new_bool(true)])) {
		return 'absolute'
	} else if
		rt.is_true(rt.identical(rt.new_string('['), rt.call_function('substr', [rt.new_string(file_path_mutated).clone(), rt.new_int(0), rt.new_int(1)])))
		&& rt.is_true(rt.identical(rt.new_string(']'), rt.call_function('substr', [rt.new_string(file_path_mutated).clone(), rt.new_int(-1)]))) {
		return 'shortcode'
	} else {
		return 'relative'
	}
	return ''
}

fn (mut this Class_WC_Product_Download) get_file_type() rt.PhpVal {
	mut var_type := rt.call_function('wp_check_filetype', [
		rt.call_function('strtok', [this.get_file(), rt.new_string('?')]),
		this.get_allowed_mime_types(),
	])
	return var_type.array_get(rt.new_string('type'))
}

fn (mut this Class_WC_Product_Download) get_file_extension() rt.PhpVal {
	mut var_parsed_url := rt.call_function('wp_parse_url', [this.get_file(),
		rt.get_constant('PHP_URL_PATH')])
	return rt.call_function('pathinfo', [var_parsed_url.clone(),
		rt.get_constant('PATHINFO_EXTENSION')])
}

fn (mut this Class_WC_Product_Download) check_is_valid(auto_add_to_approved_directory_list bool) {
	mut var_download_file := this.get_file()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.data.array_get(rt.new_string('enabled')))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The downloadable file %s cannot be used as it has been disabled.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<code>' +
				(rt.call_function('basename', [var_download_file.clone()])).str() + '</code>'),
		]))))
	}
	if !(this.is_allowed_filetype()) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The downloadable file %1$s cannot be used as it does not have an allowed file type. Allowed types include: %2$s'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<code>' +
				(rt.call_function('basename', [var_download_file.clone()])).str() + '</code>'),
			rt.new_string('<code>' +
				(rt.call_function('implode', [rt.new_string(', '), rt.func_array_keys(this.get_allowed_mime_types())])).str() +
				'</code>'),
		]))))
	}
	if !(this.file_exists()) {
		this.raise_invalid_file_exception(var_download_file.str())
	}
	this.approved_directory_checks(auto_add_to_approved_directory_list)
}

fn (mut this Class_WC_Product_Download) is_allowed_filetype() bool {
	mut var_file_path := this.get_file()
	mut iife_temp_0 := Class_WC_Download_Handler{}
	mut iife_result_0 := iife_temp_0.parse_file_path(var_file_path.clone())
	mut var_parsed_file_path := iife_result_0
	mut var_is_file_on_server :=
		rt.new_bool(!(rt.is_true(var_parsed_file_path.array_get(rt.new_string('remote_file')))))
	mut var_file_path_type := rt.new_string(this.get_type_of_file_path(var_file_path.str()))
	if rt.is_true(rt.identical(rt.new_string('shortcode'), var_file_path_type)) {
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_file_on_server))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('relative'), var_file_path_type)))) {
		return true
	}
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('PHP_OS'))
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('PHP_OS'))
	mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_3 := iife_temp_3.get_constant(rt.new_string('PHP_OS'))
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.get_constant(rt.new_string('PHP_OS'))
	if rt.is_true(var_is_file_on_server)
		&& rt.is_true(rt.new_bool(!(rt.is_true(this.get_file_extension()))))
		&& rt.is_true(rt.identical(rt.new_string('WIN'), rt.new_string(rt.call_function('substr', [iife_result_3, rt.new_int(0), rt.new_int(3)]).to_string().to_upper()))) {
		if rt.is_true(rt.identical(rt.new_string('.'), rt.call_function('substr', [
			var_file_path.clone(),
			rt.new_int(-1),
		])))
		{
			return false
		}
	}
	return rt.is_true(rt.new_bool(!(rt.is_true(this.get_file_extension()))))
		|| rt.is_true(rt.call_function('in_array', [this.get_file_type(), this.get_allowed_mime_types(), rt.new_bool(true)]))
}

fn (mut this Class_WC_Product_Download) file_exists() bool {
	if rt.is_true(rt.new_bool('relative' != this.get_type_of_file_path(''))) {
		return true
	}
	mut var_file_url := this.get_file()
	if rt.is_true(rt.identical(rt.new_string('..'), rt.call_function('substr', [var_file_url.clone(), rt.new_int(0), rt.new_int(2)])))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), rt.call_function('substr', [var_file_url.clone(), rt.new_int(0), rt.new_int(1)]))))) {
		var_file_url = rt.call_function('realpath', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_url.str()),
		])
	} else if rt.is_true(rt.identical(rt.call_function('substr', [
		rt.get_constant('WP_CONTENT_DIR'),
		rt.new_int(rt.call_function('untrailingslashit', [rt.get_constant('ABSPATH')]).to_string().len),
	]), rt.call_function('substr', [var_file_url.clone(), rt.new_int(0),
		rt.new_int(rt.call_function('substr', [rt.get_constant('WP_CONTENT_DIR'),
			rt.new_int(rt.call_function('untrailingslashit', [
				rt.get_constant('ABSPATH')]).to_string().len)]).to_string().len)])))
	{
		var_file_url = rt.call_function('realpath', [
			rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() +
				(rt.call_function('substr', [var_file_url.clone(), rt.new_int(11)])).str()),
		])
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_downloadable_file_exists'),
		rt.call_function('file_exists', [var_file_url.clone()]),
		this.get_file(),
	])).to_bool()
}

fn (mut this Class_WC_Product_Download) approved_directory_checks(auto_add_to_approved_directory_list bool) {
	mut var_download_directories := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.class(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_download_directories,
		'get_mode', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_enabled()))))
	{
		return
	}
	mut var_download_file := this.get_file()
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_downloads_approved_directory_validation_for_shortcodes'), rt.new_bool(true)]))
		&& rt.is_true(rt.identical(rt.new_string('shortcode'), this.get_type_of_file_path(''))) {
		var_download_file = rt.call_function('do_shortcode', [
			var_download_file.clone()])
	}
	mut var_is_site_administrator := if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('current_user_can', [
			rt.new_string('manage_sites'),
		]) } else { rt.call_function('current_user_can', [
			rt.new_string('manage_options'),
		]) }
	mut var_valid_storage_directory := rt.call_method(var_download_directories, 'is_valid_path', [
		var_download_file.clone(),
	])
	if rt.is_true(var_valid_storage_directory) {
		return
	}
	if var_auto_add_to_approved_directory_list {
		rt.call_method(var_download_directories, 'add_approved_directory', [
			rt.call_method(create_automattic_woocommerce_internal_utilities_url(var_download_file.clone()),
				'get_parent_url', []rt.PhpVal{}),
			var_is_site_administrator.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		var_valid_storage_directory = rt.call_method(var_download_directories, 'is_valid_path', [
			var_download_file.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_valid_storage_directory)))) {
		this.raise_invalid_file_exception(var_download_file.str())
	}
}

fn (mut this Class_WC_Product_Download) raise_invalid_file_exception(download_file string) {
	mut download_file_mutated := download_file
	rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('The downloadable file %s cannot be used as it does not exist on the server, or is not located within an approved directory. Please contact a site administrator for help. %2$sLearn more.%3$s'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('<code>' + download_file_mutated + '</code>'),
		rt.new_string('<a href="https://woocommerce.com/document/approved-download-directories">'),
		rt.new_string('</a>'),
	]))))
}

fn (mut this Class_WC_Product_Download) set_extra_data(key string, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.extra_data.array_set(key, var_value_mutated.clone())
}

fn (mut this Class_WC_Product_Download) set_id(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.data.array_set('id', rt.call_function('wc_clean', [var_value_mutated.clone()]))
}

fn (mut this Class_WC_Product_Download) set_name(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	this.data.array_set('name', rt.call_function('wc_clean', [
		var_value_mutated.clone()]))
}

fn (mut this Class_WC_Product_Download) set_previous_hash(var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	rt.call_function('wc_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3')])
	this.data.array_set('previous_hash', rt.call_function('wc_clean', [
		var_value_mutated.clone()]))
}

fn (mut this Class_WC_Product_Download) set_file(var_value rt.PhpVal) {
	mut var_matches := []rt.PhpVal{}
	mut var_value_mutated := var_value
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^//+(/[^/].+)$#i'),
		var_value_mutated.clone(), rt.create_array_from_list(var_matches)]))
	{
		var_value_mutated = var_matches.array_get(rt.new_int(1))
	}
	mut switch_val_1 := this.get_type_of_file_path(var_value_mutated.str())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('absolute'))) {
		this.data.array_set('file', rt.call_function('esc_url_raw', [
			var_value_mutated.clone()]))
	} else {
		this.data.array_set('file', rt.call_function('wc_clean', [
			var_value_mutated.clone()]))
	}
}

fn (mut this Class_WC_Product_Download) set_enabled(enabled bool) {
	this.data.array_set('enabled', enabled)
}

fn (mut this Class_WC_Product_Download) get_all_extra_data() rt.PhpVal {
	return this.extra_data
}

fn (mut this Class_WC_Product_Download) get_extra_data(key string) rt.PhpVal {
	return if !(this.extra_data.array_get(rt.new_string(key))).is_null() {
		this.extra_data.array_get(rt.new_string(key))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WC_Product_Download) get_id() rt.PhpVal {
	return this.data.array_get(rt.new_string('id'))
}

fn (mut this Class_WC_Product_Download) get_name() rt.PhpVal {
	return this.data.array_get(rt.new_string('name'))
}

fn (mut this Class_WC_Product_Download) get_previous_hash() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3')])
	return this.data.array_get(rt.new_string('previous_hash'))
}

fn (mut this Class_WC_Product_Download) get_file() rt.PhpVal {
	return this.data.array_get(rt.new_string('file'))
}

fn (mut this Class_WC_Product_Download) get_enabled() bool {
	return (this.data.array_get(rt.new_string('enabled'))).to_bool()
}

fn (mut this Class_WC_Product_Download) offsetget(var_offset rt.PhpVal) string {
	mut switch_val_2 := var_offset
	if true {
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_Download', [
					'ArrayAccess',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_${var_offset.to_string()}' },
			]),
		]))
		{
			return (rt.call_method(rt.new_object('WC_Product_Download', [
				'ArrayAccess',
			], &this), 'get_${var_offset.to_string()}', []rt.PhpVal{})).str()
		}
		if this.extra_data.array_isset(var_offset) {
			return (this.extra_data.array_get(var_offset)).str()
		}
	}
	return ''
}

fn (mut this Class_WC_Product_Download) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal) {
	mut var_value_mutated := var_value
	mut switch_val_3 := var_offset
	if true {
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_Download', [
					'ArrayAccess',
				], &this) },
				rt.ArrayItem{ key: none, val: 'set_${var_offset.to_string()}' },
			]),
		]))
		{
			rt.call_method(rt.new_object('WC_Product_Download', ['ArrayAccess'], &this),
				'set_${var_offset.to_string()}', [var_value_mutated.clone()])
		}
		this.extra_data.array_set(var_offset, var_value_mutated.clone())
	}
}

fn (mut this Class_WC_Product_Download) offsetunset(var_offset rt.PhpVal) {
}

fn (mut this Class_WC_Product_Download) offsetexists(var_offset rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_offset.clone(),
		rt.call_function('array_merge', [rt.func_array_keys(this.data),
			rt.func_array_keys(this.extra_data)]),
		rt.new_bool(true)])
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Download_Handler {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_URL {
	rt.PhpObjectBase
}

fn create_wc_product_download(_args ...rt.PhpVal) &Class_WC_Product_Download {
	mut obj := &Class_WC_Product_Download{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_array()
		extra_data:    rt.new_array()
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_download_handler(_args ...rt.PhpVal) &Class_WC_Download_Handler {
	mut obj := &Class_WC_Download_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_url(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_URL {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_URL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_data' {
			return this.get_data()
		}
		'get_allowed_mime_types' {
			return this.get_allowed_mime_types()
		}
		'get_type_of_file_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_type_of_file_path(dispatch_arg_0))
		}
		'get_file_type' {
			return this.get_file_type()
		}
		'get_file_extension' {
			return this.get_file_extension()
		}
		'check_is_valid' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.check_is_valid(dispatch_arg_0)
			return rt.new_null()
		}
		'is_allowed_filetype' {
			return rt.new_bool(this.is_allowed_filetype())
		}
		'file_exists' {
			return rt.new_bool(this.file_exists())
		}
		'approved_directory_checks' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.approved_directory_checks(dispatch_arg_0)
			return rt.new_null()
		}
		'raise_invalid_file_exception' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.raise_invalid_file_exception(dispatch_arg_0)
			return rt.new_null()
		}
		'set_extra_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_extra_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_previous_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_previous_hash(dispatch_arg_0)
			return rt.new_null()
		}
		'set_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_file(dispatch_arg_0)
			return rt.new_null()
		}
		'set_enabled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_enabled(dispatch_arg_0)
			return rt.new_null()
		}
		'get_all_extra_data' {
			return this.get_all_extra_data()
		}
		'get_extra_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_extra_data(dispatch_arg_0)
		}
		'get_id' {
			return this.get_id()
		}
		'get_name' {
			return this.get_name()
		}
		'get_previous_hash' {
			return this.get_previous_hash()
		}
		'get_file' {
			return this.get_file()
		}
		'get_enabled' {
			return rt.new_bool(this.get_enabled())
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.offsetget(dispatch_arg_0))
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val
			return true
		}
		'extra_data' {
			this.extra_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
		else {
			return none
		}
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
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Download_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Download_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Download_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
