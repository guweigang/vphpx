import rt

struct Class_WC_Admin_Upload_Downloadable_Product {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Upload_Downloadable_Product) construct() {
	rt.call_function('add_filter', [rt.new_string('upload_dir'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Upload_Downloadable_Product',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'upload_dir' },
		])])
	rt.call_function('add_filter', [rt.new_string('wp_unique_filename'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Upload_Downloadable_Product',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_filename' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('media_upload_downloadable_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Upload_Downloadable_Product',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'media_upload_downloadable_product' },
		])])
}

fn (mut this Class_WC_Admin_Upload_Downloadable_Product) upload_dir(var_pathdata rt.PhpVal) rt.PhpVal {
	mut var_pathdata_mutated := var_pathdata
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('type'))
		&& rt.is_true(rt.identical(rt.new_string('downloadable_product'), rt.get_superglobal('_POST').array_get('type')))))
	{
		if !rt.is_true(var_pathdata_mutated.array_get('subdir')) {
			var_pathdata_mutated.array_set('path',

				(var_pathdata_mutated.array_get('path')).str() + '/woocommerce_uploads')
			var_pathdata_mutated.array_set('url',

				(var_pathdata_mutated.array_get('url')).str() + '/woocommerce_uploads')
			var_pathdata_mutated.array_set('subdir', '/woocommerce_uploads')
		} else {
			mut var_new_subdir := rt.new_string('/woocommerce_uploads' +
				(var_pathdata_mutated.array_get('subdir')).str())
			var_pathdata_mutated.array_set('path', rt.call_function('str_replace', [
				var_pathdata_mutated.array_get('subdir'),
				var_new_subdir.dup(),
				var_pathdata_mutated.array_get('path'),
			]))
			var_pathdata_mutated.array_set('url', rt.call_function('str_replace', [
				var_pathdata_mutated.array_get('subdir'),
				var_new_subdir.dup(),
				var_pathdata_mutated.array_get('url'),
			]))
			var_pathdata_mutated.array_set('subdir', rt.call_function('str_replace', [
				var_pathdata_mutated.array_get('subdir'),
				var_new_subdir.dup(),
				var_pathdata_mutated.array_get('subdir'),
			]))
		}
	}
	return var_pathdata_mutated.dup()
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Admin_Upload_Downloadable_Product) update_filename(var_full_filename rt.PhpVal, var_ext rt.PhpVal, var_dir rt.PhpVal) rt.PhpVal {
	mut var_full_filename_mutated := var_full_filename
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_POST').array_isset(rt.new_string('type')))
		|| rt.is_true(rt.identical(rt.new_bool(!(rt.is_true(rt.new_string('downloadable_product')))), rt.get_superglobal('_POST').array_get('type')))))
	{
		return var_full_filename_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [
		var_dir.dup(), rt.new_string('woocommerce_uploads')])))))
	{
		return var_full_filename_mutated.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_downloads_add_hash_to_filename'),
	])))
	{
		return var_full_filename_mutated.dup()
	}
	return this.unique_filename(var_full_filename_mutated.dup(), var_ext.dup())
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Admin_Upload_Downloadable_Product) unique_filename(var_full_filename rt.PhpVal, var_ext rt.PhpVal) rt.PhpVal {
	mut var_full_filename_mutated := var_full_filename
	mut var_ideal_random_char_length := rt.new_int(rt.new_int(6))
	mut var_max_filename_length := rt.new_int(rt.new_int(255))
	mut var_length_to_prepend := rt.call_function('min', [var_ideal_random_char_length.dup(),
		rt.sub(rt.sub(var_max_filename_length,
			rt.new_int(var_full_filename_mutated.dup().to_string().len)), rt.new_int(1))])
	if rt.is_true(rt.greater(rt.new_int(1), var_length_to_prepend)) {
		return var_full_filename_mutated.dup()
	}
	mut var_suffix := rt.new_string(rt.new_string(rt.call_function('wp_generate_password', [
		var_length_to_prepend.dup(),
		rt.new_bool(false),
		rt.new_bool(false),
	]).to_string().to_lower()))
	mut var_filename := var_full_filename_mutated.dup()
	if var_ext.dup().to_string().len > 0 {
		var_filename = rt.call_function('substr', [var_filename.dup(),
			rt.new_int(0), var_filename.dup().to_string().len - var_ext.dup().to_string().len])
	}
	var_full_filename_mutated = rt.call_function('str_replace', [
		var_filename.dup(), rt.new_string('${var_filename.to_string()}-${var_suffix.to_string()}'),
		var_full_filename_mutated.dup()])
	return var_full_filename_mutated.dup()
}

fn (mut this Class_WC_Admin_Upload_Downloadable_Product) woocommerce_media_upload_downloadable_product() {
	rt.call_function('do_action', [rt.new_string('media_upload_file')])
}

fn create_wc_admin_upload_downloadable_product() &Class_WC_Admin_Upload_Downloadable_Product {
	mut obj := &Class_WC_Admin_Upload_Downloadable_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Admin_Upload_Downloadable_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'upload_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.upload_dir(dispatch_arg_0)
		}
		'update_filename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_filename(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'unique_filename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.unique_filename(dispatch_arg_0, dispatch_arg_1)
		}
		'woocommerce_media_upload_downloadable_product' {
			this.woocommerce_media_upload_downloadable_product()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Upload_Downloadable_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Upload_Downloadable_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_upload_downloadable_product_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Upload_Downloadable_Product'),
		rt.new_bool(false),
	]))
	{
		return create_wc_admin_upload_downloadable_product()
	}
}
