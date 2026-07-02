import rt

struct Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster {
	rt.PhpObjectBase
pub mut:
	downloads_data_store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster) init() {
	this.downloads_data_store = rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Proxies_LegacyProxy.class(),
	]), 'get_instance_of', [
		Class_Automattic_WooCommerce_Internal_WC_Data_Store.class(),
		rt.new_string('customer-download'),
	])
	rt.call_function('add_action', [rt.new_string('adjust_download_permissions'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'adjust_download_permissions' },
		]),
		rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster) maybe_schedule_adjust_download_permissions(mut var_product Class_WC_Product) {
	mut var_product_mutated := var_product
	mut var_children_ids := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_children_ids)))) {
		return
	}
	rt.call_function('_prime_post_caches', [var_children_ids.clone()])
	mut var_are_any_children_downloadable := rt.new_bool(false)
	mut iter_1 := var_children_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_child_id := item_1.val
		mut var_child := rt.call_function('wc_get_product', [
			var_child_id.clone()])
		if rt.is_true(var_child)
			&& rt.is_true(rt.call_method(var_child, 'is_downloadable', []rt.PhpVal{})) {
			var_are_any_children_downloadable = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_downloadable', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_are_any_children_downloadable)))) {
		return
	}
	mut var_scheduled_action_args := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}) },
	])
	mut var_already_scheduled_actions := rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'call_function', [rt.new_string('as_get_scheduled_actions'),
		rt.create_array([rt.ArrayItem{ key: 'hook', val: 'adjust_download_permissions' },
			rt.ArrayItem{ key: 'args', val: var_scheduled_action_args },
			rt.ArrayItem{
				key: 'status'
				val: Class_Automattic_WooCommerce_Internal_ActionScheduler_Store.status_pending()
			}]),
		rt.new_string('ids')])
	if !rt.is_true(var_already_scheduled_actions) {
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
			rt.new_string('as_schedule_single_action'),
			rt.add(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
				rt.new_string('time'),
			]), rt.new_int(1)),
			rt.new_string('adjust_download_permissions'),
			var_scheduled_action_args.clone(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster) adjust_download_permissions(product_id i64) {
	mut var_product := rt.call_function('wc_get_product', [rt.new_int(product_id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return
	}
	mut var_children_ids := rt.call_method(var_product, 'get_children', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_children_ids)))) {
		return
	}
	mut var_parent_downloads :=
		this.get_download_files_and_permissions(mut rt.cast_object_ptr[Class_WC_Product](var_product))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_downloads)))) {
		return
	}
	rt.call_function('_prime_post_caches', [var_children_ids.clone()])
	mut var_children_with_downloads := rt.new_array()
	mut iter_2 := var_children_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_child_id := item_2.val
		mut var_child := rt.call_function('wc_get_product', [
			var_child_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_child, 'WC_Product')))))) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Unable to load child product %1$d while adjusting download permissions for product %2$d.'),
						rt.new_string('woocommerce'),
					]),
					var_child_id.clone(),
					rt.new_int(product_id),
				]),
			])
			continue
		}
		var_children_with_downloads.array_set(var_child_id,
			this.get_download_files_and_permissions(mut rt.cast_object_ptr[Class_WC_Product](var_child)))
	}
	mut iter_3 :=
		var_parent_downloads.array_get(rt.new_string('permission_data_by_file_order_user')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_parent_download_data := item_3.val
		mut var_parent_file_order_and_user := item_3.key
		mut iter_4 := var_children_with_downloads.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_child_download_data := item_4.val
			mut var_child_id := item_4.key
			mut var_file_url := var_parent_download_data.array_get(rt.new_string('file'))
			mut var_must_create_permission := rt.new_bool(
				rt.is_true(rt.call_function('in_array', [var_file_url.clone(), rt.func_array_keys(var_child_download_data.array_get(rt.new_string('download_ids_by_file_url'))), rt.new_bool(true)]))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_child_download_data.array_get(rt.new_string('permission_data_by_file_order_user')).array_isset(var_parent_file_order_and_user.clone())))))))
			if rt.is_true(var_must_create_permission) {
				mut var_new_download_data :=
					var_parent_download_data.array_get(rt.new_string('data'))
				var_new_download_data.array_set('product_id', var_child_id.clone())
				var_new_download_data.array_set('download_id',
					var_child_download_data.array_get(rt.new_string('download_ids_by_file_url')).array_get(var_file_url))
				rt.call_method(this.downloads_data_store, 'create_from_data', [
					var_new_download_data.clone(),
				])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster) get_download_files_and_permissions(mut var_product Class_WC_Product) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'permission_data_by_file_order_user', val: rt.new_array() },
		rt.ArrayItem{ key: 'download_ids_by_file_url', val: rt.new_array() },
	])
	mut var_downloads := rt.call_method(var_product_mutated, 'get_downloads', []rt.PhpVal{})
	mut iter_5 := var_downloads.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_download := item_5.val
		var_result.array_get_mut('download_ids_by_file_url').array_set(rt.call_method(var_download,
			'get_file', []rt.PhpVal{}), rt.call_method(var_download, 'get_id', []rt.PhpVal{}))
	}
	mut var_permissions := rt.call_method(this.downloads_data_store, 'get_downloads', [
		rt.create_array([
			rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_product_mutated, 'get_id',
				[]rt.PhpVal{}) },
		]),
	])
	mut iter_6 := var_permissions.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_permission := item_6.val
		mut var_permission_data := rt.cast_array(rt.get_property(var_permission, 'data'))
		if rt.is_true(rt.new_bool(var_downloads.clone().array_isset(var_permission_data.array_get(rt.new_string('download_id'))))) {
			mut var_file := rt.call_method(var_downloads.array_get(var_permission_data.array_get(rt.new_string('download_id'))),
				'get_file', []rt.PhpVal{})
			mut var_data := rt.create_array([rt.ArrayItem{ key: 'file', val: var_file },
				rt.ArrayItem{ key: 'data', val: rt.cast_array(rt.get_property(var_permission,
					'data')) }])
			var_result.array_get_mut('permission_data_by_file_order_user').array_set(rt.concat(rt.concat(rt.concat(rt.concat(var_file,
				rt.new_string(':')), var_permission_data.array_get(rt.new_string('user_id'))),
				rt.new_string(':')), var_permission_data.array_get(rt.new_string('order_id'))),
				var_data.clone())
		}
	}
	return var_result.clone()
}

fn create_automattic_woocommerce_internal_downloadpermissionsadjuster(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster {
	mut obj := &Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster{
		PhpObjectBase:        rt.PhpObjectBase{}
		downloads_data_store: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'maybe_schedule_adjust_download_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.maybe_schedule_adjust_download_permissions(mut dispatch_arg_0)
			return rt.new_null()
		}
		'adjust_download_permissions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.adjust_download_permissions(dispatch_arg_0)
			return rt.new_null()
		}
		'get_download_files_and_permissions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_download_files_and_permissions(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'downloads_data_store' { return this.downloads_data_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_DownloadPermissionsAdjuster) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'downloads_data_store' {
			this.downloads_data_store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
