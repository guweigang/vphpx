import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File {
	rt.PhpObjectBase
pub mut:
		path rt.PhpVal = rt.new_null()
		source rt.PhpVal = rt.new_string('')
		rotation rt.PhpVal = rt.new_null()
		created rt.PhpVal = rt.new_int(0)
		hash rt.PhpVal = rt.new_string('')
		stream rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) construct(var_path rt.PhpVal) {
	this.path = var_path.clone()
	this.ingest_path()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) magic_destruct() {
	if rt.is_true(rt.call_function('is_resource', [this.stream])) {
		rt.call_function('fclose', [this.stream])
	}
}

fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.parse_path(path string) rt.PhpVal {
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'dirname', val: '' }, rt.ArrayItem{ key: 'basename', val: '' }, rt.ArrayItem{ key: 'extension', val: '' }, rt.ArrayItem{ key: 'filename', val: '' }, rt.ArrayItem{ key: 'source', val: '' }, rt.ArrayItem{ key: 'rotation', val: rt.new_null() }, rt.ArrayItem{ key: 'created', val: 0 }, rt.ArrayItem{ key: 'hash', val: '' }, rt.ArrayItem{ key: 'file_id', val: '' }])
	mut var_parsed := rt.call_function('array_merge', [var_defaults.clone(), rt.call_function('pathinfo', [rt.new_string(path)])])
	mut var_segments := rt.call_function('explode', [rt.new_string('-'), var_parsed.array_get(rt.new_string('filename'))])
	mut var_timestamp := rt.call_function('strtotime', [rt.call_function('implode', [rt.new_string('-'), rt.call_function('array_slice', [var_segments.clone(), rt.new_int(-4), rt.new_int(3)])])])
	if var_segments.clone().array_count() >= 5 && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_timestamp)))) {
		var_parsed.array_set('source', rt.call_function('implode', [rt.new_string('-'), rt.call_function('array_slice', [var_segments.clone(), rt.new_int(0), rt.new_int(-4)])]))
		var_parsed.array_set('created', var_timestamp.clone())
		var_parsed.array_set('hash', rt.call_function('array_slice', [var_segments.clone(), rt.new_int(-1)]).array_get(rt.new_int(0)))
	} else {
		var_parsed.array_set('source', rt.call_function('implode', [rt.new_string('-'), var_segments.clone()]))
	}
	mut var_rotation_marker := rt.call_function('strrpos', [var_parsed.array_get(rt.new_string('source')), rt.new_string('.'), rt.new_int(-1)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_rotation_marker)))) {
		mut var_rotation := rt.call_function('substr', [var_parsed.array_get(rt.new_string('source')), rt.new_int(-1)])
		if rt.is_true(rt.new_bool(var_rotation.clone().is_long() || var_rotation.clone().is_double())) {
			var_parsed.array_set('rotation', var_rotation.clone().to_i64())
		}
		var_parsed.array_set('source', rt.call_function('substr', [var_parsed.array_get(rt.new_string('source')), rt.new_int(0), var_rotation_marker.clone()]))
	}
	var_parsed.array_set('file_id', Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_file_id((var_parsed.array_get(rt.new_string('source'))).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int](var_parsed.array_get(rt.new_string('rotation'))), (var_parsed.array_get(rt.new_string('created'))).to_i64()))
	return var_parsed.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_file_id(source string, mut var_rotation Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int, created i64) string {
	mut var_rotation_mutated := var_rotation
	mut created_mutated := created
	mut var_file_id := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.sanitize_source(source)
	if !(var_rotation_mutated.is_null()) {
		var_file_id = rt.concat(var_file_id, rt.new_string('.' + (var_rotation_mutated).str()))
	}
	if created_mutated > 0 {
		var_file_id = rt.concat(var_file_id, rt.new_string('-' + (rt.call_function('gmdate', [rt.new_string('Y-m-d'), rt.new_int(created_mutated).clone()])).str()))
	}
	return (var_file_id).str()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_hash(file_id string) string {
	mut file_id_mutated := file_id
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('AUTH_SALT'))
	mut var_key := if !(iife_result_0).is_null() { iife_result_0 } else { rt.new_string('wc-logs') }
	return (rt.call_function('hash_hmac', [rt.new_string('md5'), rt.new_string(file_id_mutated).clone(), var_key.clone()])).str()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.sanitize_source(source string) string {
	return (rt.call_function('sanitize_file_name', [rt.new_string(source)])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) ingest_path() {
	mut var_parsed_path := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.parse_path((this.path).str())
	this.source = var_parsed_path.array_get(rt.new_string('source'))
	this.rotation = var_parsed_path.array_get(rt.new_string('rotation'))
	this.created = var_parsed_path.array_get(rt.new_string('created'))
	this.hash = var_parsed_path.array_get(rt.new_string('hash'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) has_standard_filename() bool {
	return !(rt.is_true(rt.new_bool(!(rt.is_true(this.get_hash())))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) is_readable() bool {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_1 := iife_temp_1.get_wp_filesystem()
	mut var_filesystem := iife_result_1
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_is_readable := rt.new_bool(rt.is_true(rt.call_method(var_filesystem, 'is_file', [this.path])) && rt.is_true(rt.call_method(var_filesystem, 'is_readable', [this.path])))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_exception := var_e_1.clone()
		return false
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return (var_is_readable).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) is_writable() bool {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_2 := iife_temp_2.get_wp_filesystem()
	mut var_filesystem := iife_result_2
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_is_writable := rt.new_bool(rt.is_true(rt.call_method(var_filesystem, 'is_file', [this.path])) && rt.is_true(rt.call_method(var_filesystem, 'is_writable', [this.path])))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_exception := var_e_2.clone()
		return false
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return (var_is_writable).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_stream() bool {
	if !(this.is_readable()) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [this.stream]))))) {
		this.stream = rt.call_function('fopen', [this.path, rt.new_string('rb')])
	}
	return (this.stream).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) close_stream() bool {
	return (rt.call_function('fclose', [this.stream])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_path() string {
	return (this.path).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_basename() string {
	return (rt.call_function('basename', [this.path])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_source() string {
	return (this.source).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_rotation() i64 {
	return (this.rotation).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_hash() string {
	return (this.hash).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_file_id() string {
	mut var_created := rt.new_int(0)
	if this.has_standard_filename() {
	var_created = rt.new_int(this.get_created_timestamp())
	}
	mut var_file_id := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_file_id(this.get_source(), mut this.get_rotation(), (var_created).to_i64())
	return (var_file_id).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_created_timestamp() i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.created)))) && this.is_readable() {
		this.created = rt.call_function('filectime', [this.path])
	}
	return (this.created).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_modified_timestamp() bool {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_3 := iife_temp_3.get_wp_filesystem()
	mut var_filesystem := iife_result_3
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_timestamp := rt.call_method(var_filesystem, 'mtime', [this.path])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_exception := var_e_3.clone()
		return false
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
	return (var_timestamp).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) get_file_size() bool {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_4 := iife_temp_4.get_wp_filesystem()
	mut var_filesystem := iife_result_4
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_filesystem, 'is_readable', [this.path]))))) {
		return false
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	mut var_size := rt.call_method(var_filesystem, 'size', [this.path])
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_exception := var_e_4.clone()
		return false
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return (var_size).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) create() bool {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_5 := iife_temp_5.get_wp_filesystem()
	mut var_filesystem := iife_result_5
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_created := rt.call_method(var_filesystem, 'touch', [this.path])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	mut var_modded := rt.call_method(var_filesystem, 'chmod', [this.path])
	if rt.has_exception() { unsafe { goto catch_label_5 } }
	unsafe { goto end_label_5 }

catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'Exception') {
		mut var_exception := var_e_5.clone()
		return false
		unsafe { goto end_label_5 }
	}
	else {
		rt.throw_exception(var_e_5)
		unsafe { goto end_label_5 }
	}

end_label_5:
	return rt.is_true(var_created) && rt.is_true(var_modded)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) write(text string) bool {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(text))) {
		return false
	}
	if !(this.is_writable()) {
		mut var_created := rt.new_bool(this.create())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_created)))) || !(this.is_writable()) {
			return false
		}
	}
	mut var_eol_pos := rt.call_function('strrpos', [rt.new_string(text), rt.get_constant('PHP_EOL')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_eol_pos)) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(text.len), rt.add(var_eol_pos, rt.new_int(1)))))) {
		text = text + (rt.get_constant('PHP_EOL')).str()
	}
	mut var_resource := rt.call_function('fopen', [this.path, rt.new_string('ab')])
	rt.call_function('mbstring_binary_safe_encoding', []rt.PhpVal{})
	mut var_bytes_written := rt.call_function('fwrite', [var_resource.clone(), rt.new_string(text)])
	rt.call_function('reset_mbstring_encoding', []rt.PhpVal{})
	rt.call_function('fclose', [var_resource.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(text.len), var_bytes_written)))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) rotate() bool {
	if !(this.is_writable()) {
		return false
	}
	mut var_created := rt.new_int(0)
	if this.has_standard_filename() {
	var_created = rt.new_int(this.get_created_timestamp())
	}
	if rt.is_true(rt.new_bool(rt.new_int(this.get_rotation()).is_null())) {
	mut var_new_rotation := rt.new_int(0)
	} else {
	var_new_rotation = rt.new_int(this.get_rotation() + 1)
	}
	mut var_new_file_id := Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_file_id(this.get_source(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int](var_new_rotation), (var_created).to_i64())
	mut var_search := rt.create_array([rt.ArrayItem{ key: none, val: this.get_file_id() }])
	mut var_replace := rt.create_array([rt.ArrayItem{ key: none, val: var_new_file_id }])
	if this.has_standard_filename() {
		var_search.array_push(this.get_hash())
		var_replace.array_push(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_hash((var_new_file_id).str()))
	}
	mut var_old_filename := rt.new_string(this.get_basename())
	mut var_new_filename := rt.call_function('str_replace', [var_search.clone(), var_replace.clone(), var_old_filename.clone()])
	mut var_new_path := rt.call_function('str_replace', [var_old_filename.clone(), var_new_filename.clone(), this.path])
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_6 := iife_temp_6.get_wp_filesystem()
	mut var_filesystem := iife_result_6
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	mut var_moved := rt.call_method(var_filesystem, 'move', [this.path, var_new_path.clone(), rt.new_bool(true)])
	if rt.has_exception() { unsafe { goto catch_label_6 } }
	unsafe { goto end_label_6 }

catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'Exception') {
		mut var_exception := var_e_6.clone()
		return false
		unsafe { goto end_label_6 }
	}
	else {
		rt.throw_exception(var_e_6)
		unsafe { goto end_label_6 }
	}

end_label_6:
	if rt.is_true(rt.new_bool(!(rt.is_true(var_moved)))) {
		return false
	}
	this.path = var_new_path.clone()
	this.ingest_path()
	return this.is_readable()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) delete() bool {
	mut iife_temp_7 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_7 := iife_temp_7.get_wp_filesystem()
	mut var_filesystem := iife_result_7
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	mut var_deleted := rt.call_method(var_filesystem, 'delete', [this.path, rt.new_bool(false), rt.new_string('f')])
	if rt.has_exception() { unsafe { goto catch_label_7 } }
	unsafe { goto end_label_7 }

catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'Exception') {
		mut var_exception := var_e_7.clone()
		return false
		unsafe { goto end_label_7 }
	}
	else {
		rt.throw_exception(var_e_7)
		unsafe { goto end_label_7 }
	}

end_label_7:
	return (var_deleted).to_bool()
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_logging_filev2_file(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File{
		PhpObjectBase: rt.PhpObjectBase{}
		path: rt.new_null()
		source: rt.new_string('')
		rotation: rt.new_null()
		created: rt.new_int(0)
		hash: rt.new_string('')
		stream: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_filesystemutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'parse_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.parse_path(dispatch_arg_0)
		}
		'generate_file_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_file_id(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'generate_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.generate_hash(dispatch_arg_0))
		}
		'sanitize_source' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File.sanitize_source(dispatch_arg_0))
		}
		'ingest_path' {
			this.ingest_path()
			return rt.new_null()
		}
		'has_standard_filename' {
			return rt.new_bool(this.has_standard_filename())
		}
		'is_readable' {
			return rt.new_bool(this.is_readable())
		}
		'is_writable' {
			return rt.new_bool(this.is_writable())
		}
		'get_stream' {
			return rt.new_bool(this.get_stream())
		}
		'close_stream' {
			return rt.new_bool(this.close_stream())
		}
		'get_path' {
			return rt.new_string(this.get_path())
		}
		'get_basename' {
			return rt.new_string(this.get_basename())
		}
		'get_source' {
			return rt.new_string(this.get_source())
		}
		'get_rotation' {
			return rt.new_int(this.get_rotation())
		}
		'get_hash' {
			return rt.new_string(this.get_hash())
		}
		'get_file_id' {
			return rt.new_string(this.get_file_id())
		}
		'get_created_timestamp' {
			return rt.new_int(this.get_created_timestamp())
		}
		'get_modified_timestamp' {
			return rt.new_bool(this.get_modified_timestamp())
		}
		'get_file_size' {
			return rt.new_bool(this.get_file_size())
		}
		'create' {
			return rt.new_bool(this.create())
		}
		'write' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.write(dispatch_arg_0))
		}
		'rotate' {
			return rt.new_bool(this.rotate())
		}
		'delete' {
			return rt.new_bool(this.delete())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'path' { return this.path }
		'source' { return this.source }
		'rotation' { return this.rotation }
		'created' { return this.created }
		'hash' { return this.hash }
		'stream' { return this.stream }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Logging_FileV2_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'path' { this.path = val; return true }
		'source' { this.source = val; return true }
		'rotation' { this.rotation = val; return true }
		'created' { this.created = val; return true }
		'hash' { this.hash = val; return true }
		'stream' { this.stream = val; return true }
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


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
