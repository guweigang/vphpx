import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter.chunk_size() rt.PhpVal {
	return 4 * rt.get_constant('KB_IN_BYTES')
}

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter {
	rt.PhpObjectBase
pub mut:
	path               string
	alternate_filename string
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) construct(path string, alternate_filename string) {
	this.path = path
	this.alternate_filename = alternate_filename
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) emit_file() rt.PhpVal {
	mut var_filesystem := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
		return temp.get_wp_filesystem()
	}()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_is_readable := rt.new_bool(rt.new_bool(
		rt.is_true(rt.call_method(var_filesystem, 'is_file', [this.path]))
		&& rt.is_true(rt.call_method(var_filesystem, 'is_readable', [this.path]))))
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
		mut var_exception := var_e_1.dup()
		var_is_readable = rt.new_bool(rt.new_bool(false))
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
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_readable)))) {
		return create_wp_error(rt.new_string('wc_logs_invalid_file'), rt.call_function('__', [
			rt.new_string('Could not access file.'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gc_enable')])) {
		rt.call_function('gc_enable', []rt.PhpVal{})
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apache_setenv')])) {
		rt.call_function('apache_setenv', [rt.new_string('no-gzip'),
			rt.new_string('1')])
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('ini_set', [rt.new_string('zlib.output_compression'),
		rt.new_string('Off')])
	rt.call_function('ini_set', [rt.new_string('output_buffering'),
		rt.new_string('Off')])
	rt.call_function('ini_set', [rt.new_string('output_handler'),
		rt.new_string('')])
	rt.call_function('ignore_user_abort', [rt.new_bool(true)])
	rt.call_function('wc_set_time_limit', []rt.PhpVal{})
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	this.send_headers()
	this.send_contents()
	// unsupported expression: Expr_Exit
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) send_headers() {
	rt.call_function('header', [rt.new_string('Content-Type: text/plain; charset=utf-8')])
	rt.call_function('header', [
		'Content-Disposition: attachment; filename=' + this.get_filename(),
	])
	rt.call_function('header', [rt.new_string('Pragma: no-cache')])
	rt.call_function('header', [rt.new_string('Expires: 0')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) send_contents() {
	mut var_stream := rt.call_function('fopen', [this.path, rt.new_string('rb')])
	for rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_resource', [var_stream.dup()]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('feof', [var_stream.dup()]))))))) {
		mut var_chunk := rt.call_function('fread', [var_stream.dup(),
			Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter.chunk_size()])
		if rt.is_true(rt.new_bool(var_chunk.dup().is_string())) {
			rt.echo_val(var_chunk)
		}
	}
	rt.call_function('fclose', [var_stream.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) get_filename() string {
	if rt.is_true(this.alternate_filename) {
		return this.alternate_filename
	}
	return (rt.call_function('basename', [this.path])).str()
}

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_fileexporter(path string, alternate_filename string) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter{
		PhpObjectBase:      rt.PhpObjectBase{}
		path:               ''
		alternate_filename: ''
	}
	obj.construct(path, alternate_filename)
	return obj
}

fn create_automattic_woocommerce_internal_utilities_filesystemutil() &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'emit_file' {
			return this.emit_file()
		}
		'send_headers' {
			this.send_headers()
			return rt.new_null()
		}
		'send_contents' {
			this.send_contents()
			return rt.new_null()
		}
		'get_filename' {
			return rt.new_string(this.get_filename())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'path' { return rt.new_string(this.path) }
		'alternate_filename' { return rt.new_string(this.alternate_filename) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_FileExporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'path' {
			this.path = val.str()
			return true
		}
		'alternate_filename' {
			this.alternate_filename = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_admin_logging_filev2_fileexporter_php() {
	// unsupported statement: Stmt_Declare
}
