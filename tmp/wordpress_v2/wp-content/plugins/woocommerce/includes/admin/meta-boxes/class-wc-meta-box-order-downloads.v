import rt

struct Class_WC_Meta_Box_Order_Downloads {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Order_Downloads.output(var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WC_Order'))) {
		mut var_order_id := rt.call_method(var_post, 'get_id', []rt.PhpVal{})
	} else {
		var_order_id = rt.get_property(var_post, 'ID')
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('customer-download'))
	mut var_data_store := iife_result_0
	mut var_download_permissions := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_order_id)))) {
		var_download_permissions = rt.call_method(var_data_store, 'get_downloads', [
			rt.create_array([rt.ArrayItem{ key: 'order_id', val: var_order_id },
				rt.ArrayItem{ key: 'orderby', val: 'product_id' }]),
		])
	}
	mut var_product := rt.new_null()
	mut var_loop := rt.new_int(0)
	mut var_file_counter := rt.new_int(1)
	if rt.is_true(var_download_permissions) && var_download_permissions.clone().array_count() > 0 {
		mut iter_1 := var_download_permissions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_download := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.call_method(var_download, 'get_product_id', []rt.PhpVal{}))))) {
				var_product = rt.call_function('wc_get_product', [
					rt.call_method(var_download, 'get_product_id', []rt.PhpVal{}),
				])
				var_file_counter = rt.new_int(1)
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'exists', []rt.PhpVal{})))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'has_file', [rt.call_method(var_download, 'get_download_id', []rt.PhpVal{})]))))) {
				continue
			}
			mut var_file := rt.call_method(var_product, 'get_file', [
				rt.call_method(var_download, 'get_download_id', []rt.PhpVal{}),
			])
			mut var_file_count := if var_file.array_isset(rt.new_string('name')) { var_file.array_get(rt.new_string('name')) } else { rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('File %d'),
						rt.new_string('woocommerce')]),
					var_file_counter.clone(),
				]) }
			rt.include_file(@DIR + '/views/html-order-download-permission.php', '1')
			rt.post_inc(var_loop)
			rt.post_inc(var_file_counter)
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Search for a downloadable product&hellip;'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Grant access'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Meta_Box_Order_Downloads.save(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	if rt.get_superglobal('_POST').array_isset(rt.new_string('permission_id')) {
		mut var_permission_ids :=
			rt.get_superglobal('_POST').array_get(rt.new_string('permission_id'))
		mut var_downloads_remaining :=
			rt.get_superglobal('_POST').array_get(rt.new_string('downloads_remaining'))
		mut var_access_expires :=
			rt.get_superglobal('_POST').array_get(rt.new_string('access_expires'))
		mut var_max := rt.call_function('max', [
			rt.func_array_keys(var_permission_ids.clone()),
		])
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_max))) { break
			 }
			if !(var_permission_ids.array_isset(var_i)) {
				continue
			}
			mut var_download := create_wc_customer_download(var_permission_ids.array_get(var_i))
			var_download.set_downloads_remaining(rt.call_function('wc_clean', [
				var_downloads_remaining.array_get(var_i),
			]))
			var_download.set_access_expires(if rt.is_true(rt.new_bool(var_access_expires.clone().array_isset(var_i.clone()))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_access_expires.array_get(var_i))))) { rt.call_function('strtotime', [
					var_access_expires.array_get(var_i),
				]) } else { rt.new_string('') })
			var_download.save()
			rt.post_inc(var_i)
		}
	}
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Customer_Download {
	rt.PhpObjectBase
}

fn create_wc_meta_box_order_downloads(_args ...rt.PhpVal) &Class_WC_Meta_Box_Order_Downloads {
	mut obj := &Class_WC_Meta_Box_Order_Downloads{
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

fn create_wc_customer_download(_args ...rt.PhpVal) &Class_WC_Customer_Download {
	mut obj := &Class_WC_Customer_Download{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Order_Downloads) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Downloads.output(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Order_Downloads.save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Order_Downloads) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Order_Downloads) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Customer_Download) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer_Download) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer_Download) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
