import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) get_import_subdir_name() string {
	return 'wc-imports'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) get_import_dir(create bool) string {
	mut var_wp_upload_dir := rt.call_function('wp_upload_dir', [rt.new_null(), rt.new_bool(create)])
	if rt.is_true(var_wp_upload_dir.array_get(rt.new_string('error'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_Exception', []string{}, create_automattic_woocommerce_internal_admin_importexport_exception(rt.call_function('esc_html', [var_wp_upload_dir.array_get(rt.new_string('error'))]))))
	}
	mut var_upload_dir := rt.new_string((rt.call_function('trailingslashit', [var_wp_upload_dir.array_get(rt.new_string('basedir'))])).str() + this.get_import_subdir_name())
	if var_create {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_0 := iife_temp_0.mkdir_p_not_indexable(var_upload_dir.clone())
	}
	return (var_upload_dir).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) handle_csv_upload(import_type string, files_index string, mut var_allowed_mime_types Class_Automattic_WooCommerce_Internal_Admin_ImportExport_?array) rt.PhpVal {
	mut var__FILES := rt.new_null()
	mut import_type_mutated := import_type
	mut var_allowed_mime_types_mutated := var_allowed_mime_types
	import_type_mutated = (rt.call_function('sanitize_key', [rt.new_string(import_type_mutated).clone()])).str()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(import_type_mutated))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_Exception', []string{}, create_automattic_woocommerce_internal_admin_importexport_exception(rt.new_string('Import type is invalid.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allowed_mime_types_mutated)))) {
	var_allowed_mime_types_mutated = rt.create_array([rt.ArrayItem{ key: 'csv', val: 'text/csv' }, rt.ArrayItem{ key: 'txt', val: 'text/plain' }])
	}
	mut var_file := if !(var__FILES.array_get(rt.new_string(files_index))).is_null() { var__FILES.array_get(rt.new_string(files_index)) } else { rt.new_null() }
	if !(var_file.array_isset(rt.new_string('tmp_name'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_uploaded_file', [var_file.array_get(rt.new_string('tmp_name'))]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_Exception', []string{}, create_automattic_woocommerce_internal_admin_importexport_exception(rt.call_function('esc_html__', [rt.new_string('File is empty. Please upload something more substantial. This error could also be caused by uploads being disabled in your php.ini or by post_max_size being defined as smaller than upload_max_filesize in php.ini.'), rt.new_string('woocommerce')]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_import_handle_upload')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/import.php', '4')
	}
	this.get_import_dir(false)
	var_file.array_set('name', import_type_mutated + '-' + (var_file.array_get(rt.new_string('name'))).str())
	closure_2_fn := fn [var_allowed_mime_types] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_overrides_ := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_overrides_.array_set('test_form', false)
		var_overrides_.array_set('test_type', true)
		var_overrides_.array_set('mimes', var_allowed_mime_types_mutated)
		return var_overrides_.clone()
		}
	mut var_overrides_callback := rt.new_closure(closure_2_fn)
	rt.call_function('add_filter', [rt.new_string('upload_dir'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'override_upload_dir' }])])
	rt.call_function('add_filter', [rt.new_string('wp_unique_filename'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'override_unique_filename' }]), rt.new_int(0), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_handle_upload_overrides'), var_overrides_callback.clone(), rt.new_int(999)])
	rt.call_function('add_filter', [rt.new_string('wp_handle_upload_prefilter'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_txt_from_uploaded_file' }]), rt.new_int(0)])
	rt.call_function('add_filter', [rt.new_string('wp_check_filetype_and_ext'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_woocommerce_check_filetype_for_csv' }]), rt.new_int(10), rt.new_int(5)])
	mut var_orig_files_import := if !(var__FILES.array_get(rt.new_string('import'))).is_null() { var__FILES.array_get(rt.new_string('import')) } else { rt.new_null() }
	var__FILES.array_set('import', var_file.clone())
	mut var_upload := rt.call_function('wp_import_handle_upload', []rt.PhpVal{})
	rt.call_function('remove_filter', [rt.new_string('upload_dir'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'override_upload_dir' }])])
	rt.call_function('remove_filter', [rt.new_string('wp_unique_filename'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'override_unique_filename' }]), rt.new_int(0)])
	rt.call_function('remove_filter', [rt.new_string('wp_handle_upload_overrides'), var_overrides_callback.clone(), rt.new_int(999)])
	rt.call_function('remove_filter', [rt.new_string('wp_handle_upload_prefilter'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_txt_from_uploaded_file' }]), rt.new_int(0)])
	rt.call_function('remove_filter', [rt.new_string('wp_check_filetype_and_ext'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_woocommerce_check_filetype_for_csv' }]), rt.new_int(10)])
	if rt.is_true(var_orig_files_import) {
		var__FILES.array_set('import', var_orig_files_import.clone())
	} else {
		var__FILES.array_unset(rt.new_string('import'))
	}
	if !(!rt.is_true(var_upload.array_get(rt.new_string('error')))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_Exception', []string{}, create_automattic_woocommerce_internal_admin_importexport_exception(rt.call_function('esc_html', [var_upload.array_get(rt.new_string('error'))]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_file_valid_csv', [var_upload.array_get(rt.new_string('file')), rt.new_bool(false)]))))) {
		rt.call_function('wp_delete_attachment', [var_file.array_get(rt.new_string('id')), rt.new_bool(true)])
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_Exception', []string{}, create_automattic_woocommerce_internal_admin_importexport_exception(rt.call_function('esc_html__', [rt.new_string('Invalid file type for a CSV import.'), rt.new_string('woocommerce')]))))
	}
	return var_upload.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) override_upload_dir(var_uploads rt.PhpVal) rt.PhpVal {
	mut var_uploads_mutated := var_uploads
	mut var_new_subdir := rt.new_string('/' + this.get_import_subdir_name())
	var_uploads_mutated.array_set('path', (var_uploads_mutated.array_get(rt.new_string('basedir'))).str() + (var_new_subdir).str())
	var_uploads_mutated.array_set('url', (var_uploads_mutated.array_get(rt.new_string('baseurl'))).str() + (var_new_subdir).str())
	var_uploads_mutated.array_set('subdir', var_new_subdir.clone())
	return var_uploads_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) override_unique_filename(filename string, ext string) string {
	mut filename_mutated := filename
	mut var_length := rt.call_function('min', [rt.new_int(10), rt.new_int(255 - filename_mutated.len - 1)])
	if rt.is_true(rt.less(rt.new_int(1), var_length)) {
	mut var_suffix := rt.new_string(rt.call_function('wp_generate_password', [var_length.clone(), rt.new_bool(false), rt.new_bool(false)]).to_string().to_lower())
	filename_mutated = (rt.call_function('substr', [rt.new_string(filename_mutated).clone(), rt.new_int(0), rt.new_int(filename_mutated.len - ext.len)])).str() + '-' + (var_suffix).str() + ext
	}
	return filename_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) remove_txt_from_uploaded_file(mut var_file Class_Automattic_WooCommerce_Internal_Admin_ImportExport_array) rt.PhpVal {
	mut var_file_mutated := var_file
	var_file_mutated.array_set('name', rt.call_function('substr', [var_file_mutated.array_get(rt.new_string('name')), rt.new_int(0), rt.new_int(-4)]))
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_ImportExport_array', []string{}, var_file_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) filter_woocommerce_check_filetype_for_csv(var_data rt.PhpVal, var_file rt.PhpVal, var_filename rt.PhpVal, var_mimes rt.PhpVal, var_real_mime rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_file_mutated := var_file
	mut var_filename_mutated := var_filename
	if rt.is_true(rt.identical(rt.new_string('text/html'), var_real_mime)) {
		mut var_filename_check := rt.call_function('wp_check_filetype', [var_filename_mutated.clone(), var_mimes.clone()])
		mut var_file_ext := var_filename_check.array_get(rt.new_string('ext'))
		mut var_file_type := var_filename_check.array_get(rt.new_string('type'))
		if rt.is_true(rt.identical(rt.new_string('csv'), var_file_ext)) && rt.is_true(rt.identical(rt.new_string('text/csv'), var_file_type)) {
			var_data_mutated.array_set('ext', 'csv')
			var_data_mutated.array_set('type', 'text/csv')
		}
	}
	return var_data_mutated.clone()
}

struct Class_Automattic_WooCommerce_Internal_Admin_ImportExport_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_importexport_csvuploadhelper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_importexport_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ImportExport_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ImportExport_Exception{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_import_subdir_name' {
			return rt.new_string(this.get_import_subdir_name())
		}
		'get_import_dir' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_import_dir(dispatch_arg_0))
		}
		'handle_csv_upload' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_ImportExport_?array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.handle_csv_upload(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'override_upload_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.override_upload_dir(dispatch_arg_0)
		}
		'override_unique_filename' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.override_unique_filename(dispatch_arg_0, dispatch_arg_1))
		}
		'remove_txt_from_uploaded_file' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_ImportExport_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.remove_txt_from_uploaded_file(mut dispatch_arg_0)
		}
		'filter_woocommerce_check_filetype_for_csv' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.filter_woocommerce_check_filetype_for_csv(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ImportExport_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ImportExport_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
