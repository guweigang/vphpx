import rt

pub fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.ftp_init_failure_transient() string {
	return 'wc_ftp_filesystem_init_failed'
}
pub fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.ftp_init_cooldown_minutes() i64 {
	return 2
}
struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.get_wp_filesystem() rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_initialized := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base'))) || rt.is_true(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.initialize_wp_filesystem())))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_initialized)))) || rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.is_usable_ftp_filesystem(mut rt.cast_object_ptr[Class_WP_Filesystem_Base](var_wp_filesystem)))))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('The WordPress filesystem could not be initialized.'))))
	}
	return var_wp_filesystem.dup()
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.get_wp_filesystem_method_or_direct() string {
	mut var_proxy := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Proxies_LegacyProxy.class()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.constant_exists('FS_METHOD'))))) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_proxy, 'call_function', [rt.new_string('get_option'), rt.new_string('ftp_credentials')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.constant_exists('FTP_HOST'))))))) {
		return 'direct'
	}
	mut var_method := rt.call_method(var_proxy, 'call_function', [rt.new_string('get_filesystem_method')])
	if rt.is_true(var_method) {
		return (var_method).str()
	}
	return 'direct'
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.constant_exists(name string) bool {
	return rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_defined(arg_0) }(rt.new_string(name))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string(name)).is_null())))))
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.mkdir_p_not_indexable(path string, allow_file_access bool)  {
	mut var_wp_fs := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.get_wp_filesystem()
	if rt.is_true(rt.call_method(var_wp_fs, 'is_dir', [rt.new_string(path)])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_mkdir_p', [rt.new_string(path)]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html', [rt.call_function('sprintf', [rt.new_string('Could not create directory: %s.'), rt.call_function('wp_basename', [rt.new_string(path)])])]))))
	}
	mut var_htaccess_content := rt.new_string(if var_allow_file_access { rt.new_string('Options -Indexes') } else { rt.new_string('deny from all') })
	mut var_files := rt.create_array([rt.ArrayItem{ key: '.htaccess', val: var_htaccess_content }, rt.ArrayItem{ key: 'index.html', val: '' }])
	{
		mut iter_1 := var_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_content := item_1.val
			mut var_name := item_1.key
			rt.call_method(var_wp_fs, 'put_contents', [rt.concat(rt.call_function('trailingslashit', [rt.new_string(path)]), var_name), var_content.dup()])
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.initialize_wp_filesystem() bool {
	mut var_wp_filesystem := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base'))) {
		return true
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	mut var_method := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.get_wp_filesystem_method_or_direct()
	mut var_initialized := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.identical(rt.new_string('direct'), var_method)) {
		var_initialized = rt.call_function('WP_Filesystem', []rt.PhpVal{})
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_is_ftp := rt.call_function('in_array', [var_method.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'ftpext' }, rt.ArrayItem{ key: none, val: 'ftpsockets' }]), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(rt.is_true(var_is_ftp) && rt.is_true(rt.call_function('get_transient', [Class_Automattic_WooCommerce_Internal_Utilities_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.ftp_init_failure_transient()])))) {
			return false
		}
		rt.call_function('ob_start', []rt.PhpVal{})
		mut var_credentials := rt.call_function('request_filesystem_credentials', [rt.new_string('')])
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		var_initialized = rt.new_bool(rt.new_bool(rt.is_true(var_credentials) && rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.dup()]))))
		if rt.is_true(var_is_ftp) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_initialized)))) {
				rt.call_function('set_transient', [Class_Automattic_WooCommerce_Internal_Utilities_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.ftp_init_failure_transient(), rt.new_bool(true), rt.mul(Class_Automattic_WooCommerce_Internal_Utilities_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.ftp_init_cooldown_minutes(), rt.get_constant('MINUTE_IN_SECONDS'))])
				rt.call_function('error_log', [rt.call_function('sprintf', [rt.new_string('WooCommerce: FTP filesystem connection failed. Please check your FTP credentials. Retrying in %d minutes.'), Class_Automattic_WooCommerce_Internal_Utilities_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.ftp_init_cooldown_minutes()])])
				// unsupported statement: Stmt_Nop
			} else {
				rt.call_function('delete_transient', [Class_Automattic_WooCommerce_Internal_Utilities_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.ftp_init_failure_transient()])
			}
		}
	}
	return (if rt.is_true(rt.new_bool(var_initialized.dup().is_null())) { rt.new_bool(false) } else { var_initialized }).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.is_usable_ftp_filesystem(mut var_wp_filesystem Class_WP_Filesystem_Base) bool {
	mut var_wp_filesystem_mutated := var_wp_filesystem
	mut var_has_broken_state := rt.new_bool(rt.new_bool(false))
	mut var_has_errors := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.identical(rt.new_string('ftpext'), rt.get_property(var_wp_filesystem_mutated, 'method'))) {
		var_has_broken_state = rt.new_bool(!rt.is_true(rt.get_property(var_wp_filesystem_mutated, 'link')))
		var_has_errors = rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem_mutated, 'errors')])) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem_mutated, 'errors'), 'has_errors', []rt.PhpVal{}))))
	}
	if rt.is_true(rt.identical(rt.new_string('ftpsockets'), rt.get_property(var_wp_filesystem_mutated, 'method'))) {
		var_has_broken_state = rt.new_bool(!rt.is_true(rt.get_property(var_wp_filesystem_mutated, 'ftp')))
		var_has_errors = rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem_mutated, 'errors')])) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem_mutated, 'errors'), 'has_errors', []rt.PhpVal{}))))
	}
	return rt.is_true(rt.new_bool(!(rt.is_true(var_has_broken_state)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_errors))))
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.validate_upload_file_path(path string)  {
	mut var_wp_filesystem := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.get_wp_filesystem()
	mut var_is_valid_file := rt.call_method(var_wp_filesystem, 'is_readable', [rt.new_string(path)])
	if rt.is_true(var_is_valid_file) {
		var_is_valid_file = Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.file_is_in_directory(path, (rt.call_method(var_wp_filesystem, 'abspath', []rt.PhpVal{})).str())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_valid_file)))) {
			mut var_upload_dir := rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
			var_is_valid_file = rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_upload_dir.array_get('error'))) && rt.is_true(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.file_is_in_directory(path, (var_upload_dir.array_get('basedir')).str()))))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_valid_file)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('File path is not a valid upload path.'), rt.new_string('woocommerce')]))))
	}
}

fn Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.file_is_in_directory(file_path string, directory string) bool {
	mut var_matches := rt.new_null()
	mut file_path_mutated := file_path
	mut var_protocol := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('#^([a-z0-9]+://)#i'), rt.new_string(file_path_mutated).dup(), var_matches.dup()])) {
		var_protocol = var_matches.array_get(1)
		file_path_mutated = (rt.call_function('preg_replace', [rt.new_string('#^[a-z0-9]+://#i'), rt.new_string(''), rt.new_string(file_path_mutated).dup()])).str()
	}
	file_path_mutated = (// unsupported expression: Expr_Cast_String).str()
	file_path_mutated = (rt.call_function('preg_replace', [rt.new_string('/^file:\\/\\//'), var_protocol.dup(), rt.new_string(file_path_mutated).dup()])).str()
	file_path_mutated = (rt.call_function('preg_replace', [rt.new_string('/^file:\\/\\//'), rt.new_string(''), rt.new_string(file_path_mutated).dup()])).str()
	return (rt.identical(rt.new_int(0), rt.call_function('stripos', [rt.call_function('wp_normalize_path', [rt.new_string(file_path_mutated).dup()]), rt.call_function('trailingslashit', [rt.call_function('wp_normalize_path', [rt.new_string(directory)])])]))).to_bool()
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

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_filesystemutil() &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
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

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_wp_filesystem' {
			return Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.get_wp_filesystem()
		}
		'get_wp_filesystem_method_or_direct' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.get_wp_filesystem_method_or_direct())
		}
		'constant_exists' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.constant_exists(dispatch_arg_0))
		}
		'mkdir_p_not_indexable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.mkdir_p_not_indexable(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'initialize_wp_filesystem' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.initialize_wp_filesystem())
		}
		'is_usable_ftp_filesystem' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Filesystem_Base](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.is_usable_ftp_filesystem(mut dispatch_arg_0))
		}
		'validate_upload_file_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.validate_upload_file_path(dispatch_arg_0)
			return rt.new_null()
		}
		'file_is_in_directory' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil.file_is_in_directory(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_filesystemutil_php() {
	// unsupported statement: Stmt_Declare
}
