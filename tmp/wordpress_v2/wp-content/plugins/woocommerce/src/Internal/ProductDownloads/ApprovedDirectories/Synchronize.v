import rt

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task() string {
	return 'woocommerce_download_dir_sync'
}

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_group() string {
	return 'woocommerce-db-updates'
}

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_page() string {
	return 'wc_product_download_dir_sync_page'
}

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_progress() string {
	return 'wc_product_download_dir_sync_progress'
}

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_batch_size() i64 {
	return 20
}

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize {
	rt.PhpObjectBase
pub mut:
	queue    rt.PhpVal = rt.new_null()
	register rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) init(mut var_register Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) {
	this.queue = rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_instance_of', [
		Class_WC_Queue_Interface.class(),
	])
	this.register = var_register
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) init_hooks() {
	rt.call_function('add_action', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'run' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) init_feature(synchronize bool, enable_feature bool) {
	this.add_default_directories()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if var_synchronize {
		this.start()
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
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
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
			rt.new_string('warning'),
			rt.call_function('__', [
				rt.new_string('It was not possible to synchronize download directories following the most recent update.'),
				rt.new_string('woocommerce'),
			]),
		])
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
	rt.call_method(this.register, 'set_mode', [if var_enable_feature {
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_enabled()
	} else {
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_disabled()
	}])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) add_default_directories() {
	mut var_upload_dir := rt.call_function('wp_get_upload_dir', []rt.PhpVal{})
	rt.call_method(this.register, 'add_approved_directory', [
		rt.new_string(
			(var_upload_dir.array_get(rt.new_string('basedir'))).str() + '/woocommerce_uploads'),
	])
	rt.call_method(this.register, 'add_approved_directory', [
		rt.new_string(
			(var_upload_dir.array_get(rt.new_string('baseurl'))).str() + '/woocommerce_uploads'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) start() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.call_method(this.queue,
		'get_next', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task(),
	])))))
	{
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
			rt.new_string('warning'),
			rt.call_function('__', [
				rt.new_string('Synchronization of approved product download directories is already in progress.'),
				rt.new_string('woocommerce'),
			]),
		])
		return false
	}
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_page(),
		rt.new_int(1),
	])
	rt.call_method(this.queue, 'schedule_single', [
		rt.call_function('time', []rt.PhpVal{}),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task(),
		rt.new_array(),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_group(),
	])
	rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
		rt.new_string('info'),
		rt.call_function('__', [
			rt.new_string('Approved Download Directories sync: new scan scheduled.'),
			rt.new_string('woocommerce'),
		]),
	])
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) run() {
	mut var_products := this.get_next_set_of_downloadable_products()
	mut iter_1 := var_products.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product := item_1.val
		this.process_product(mut rt.cast_object_ptr[Class_WC_Product](var_product))
	}
	if rt.is_true(rt.less(rt.new_int(var_products.clone().array_count()),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_batch_size()))
	{
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
			rt.new_string('info'),
			rt.call_function('__', [
				rt.new_string('Approved Download Directories sync: scan is complete!'),
				rt.new_string('woocommerce'),
			]),
		])
		this.stop()
	} else {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
			rt.new_string('info'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Approved Download Directories sync: completed batch %1$d (%2$d%% complete).'),
					rt.new_string('woocommerce'),
				]),
				rt.new_int((rt.call_function('get_option', [
					Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_page(),
					rt.new_int(2),
				])).to_i64()) - 1,
				rt.new_int(this.get_progress()),
			]),
		])
		rt.call_method(this.queue, 'schedule_single', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(1)),
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task(),
			rt.new_array(),
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_group(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) stop() {
	mut iife_temp_0 := Class_WC_Admin_Notices{}
	mut iife_result_0 := iife_temp_0.add_notice(rt.new_string('download_directories_sync_complete'),
		rt.new_bool(true))
	rt.call_function('delete_option', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_page(),
	])
	rt.call_function('delete_option', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_progress(),
	])
	rt.call_method(this.queue, 'cancel', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) get_next_set_of_downloadable_products() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_query := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_query.array_get_mut('meta_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'key', val: '_downloadable_files' },
			rt.ArrayItem{ key: 'compare', val: 'EXISTS' },
		]))
		return var_query.clone()
	}
	mut var_query_filter := rt.new_closure(closure_2_fn)
	mut var_page := rt.new_int((rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_page(),
		rt.new_int(1),
	])).to_i64())
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_product_data_store_cpt_get_products_query'),
		var_query_filter.clone(),
	])
	mut var_products := rt.call_function('wc_get_products', [
		rt.create_array([
			rt.ArrayItem{
				key: 'limit'
				val: Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_batch_size()
			},
			rt.ArrayItem{ key: 'page', val: var_page },
			rt.ArrayItem{ key: 'paginate', val: true },
		]),
	])
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_product_data_store_cpt_get_products_query'),
		var_query_filter.clone(),
	])
	mut var_progress := rt.new_int(if rt.is_true(rt.greater(rt.get_property(var_products,
		'max_num_pages'), rt.new_int(0)))
	{
		rt.new_int((rt.mul(rt.div(var_page, rt.get_property(var_products, 'max_num_pages')),
			rt.new_int(100))).to_i64())
	} else {
		1
	})
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_page(),
		rt.add(var_page, rt.new_int(1)),
	])
	rt.call_function('update_option', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_progress(),
		var_progress.clone(),
	])
	return rt.get_property(var_products, 'products')
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) process_product(mut var_product Class_WC_Product) {
	mut var_downloads := var_product.get_downloads()
	mut iter_2 := var_downloads.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_downloadable := item_2.val
		mut var_parent_url := rt.call_function('_x', [rt.new_string('invalid URL'),
			rt.new_string('Approved product download URLs migration'),
			rt.new_string('woocommerce')])
		mut var_download_file := rt.call_method(var_downloadable, 'get_file', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_downloads_approved_directory_validation_for_shortcodes'), rt.new_bool(true)]))
			&& rt.is_true(rt.identical(rt.new_string('shortcode'), rt.call_method(var_downloadable, 'get_type_of_file_path', []rt.PhpVal{}))) {
			var_download_file = rt.call_function('do_shortcode', [
				var_download_file.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		var_parent_url = rt.call_method(create_automattic_woocommerce_internal_utilities_url(var_download_file.clone()),
			'get_parent_url', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(this.register, 'add_approved_directory', [
			var_parent_url.clone(), rt.new_bool(false)])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Exception') {
			mut var_e := var_e_2.clone()
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'log', [
				rt.new_string('error'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Product download migration: %1$s (for product %1$d) could not be added to the list of approved download directories.'),
						rt.new_string('woocommerce'),
					]),
					var_parent_url.clone(),
					var_product.get_id(),
				]),
			])
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) in_progress() bool {
	return (rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_page(),
		rt.new_bool(false),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) get_progress() i64 {
	return (rt.call_function('min', [rt.new_int(100),
		rt.call_function('max', [rt.new_int(0),
			rt.new_int((rt.call_function('get_option', [
				Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.sync_task_progress(),
				rt.new_int(0),
			])).to_i64())])])).to_i64()
}

struct Class_WC_Admin_Notices {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_URL {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_synchronize(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize{
		PhpObjectBase: rt.PhpObjectBase{}
		queue:         rt.new_null()
		register:      rt.new_null()
	}
	return obj
}

fn create_wc_admin_notices(_args ...rt.PhpVal) &Class_WC_Admin_Notices {
	mut obj := &Class_WC_Admin_Notices{
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

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'init_feature' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.init_feature(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_default_directories' {
			this.add_default_directories()
			return rt.new_null()
		}
		'start' {
			return rt.new_bool(this.start())
		}
		'run' {
			this.run()
			return rt.new_null()
		}
		'stop' {
			this.stop()
			return rt.new_null()
		}
		'get_next_set_of_downloadable_products' {
			return this.get_next_set_of_downloadable_products()
		}
		'process_product' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.process_product(mut dispatch_arg_0)
			return rt.new_null()
		}
		'in_progress' {
			return rt.new_bool(this.in_progress())
		}
		'get_progress' {
			return rt.new_int(this.get_progress())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'queue' { return this.queue }
		'register' { return this.register }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'queue' {
			this.queue = val
			return true
		}
		'register' {
			this.register = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Admin_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
