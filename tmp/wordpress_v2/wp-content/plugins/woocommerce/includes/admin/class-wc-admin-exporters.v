import rt

struct Class_WC_Admin_Exporters {
	rt.PhpObjectBase
pub mut:
	exporters rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Admin_Exporters) construct() {
	if !(this.export_allowed()) {
		return
	}
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Exporters', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_to_menus' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Exporters', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'hide_from_menus' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Exporters', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'menu_highlight_for_product_export' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Exporters', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'admin_scripts' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Exporters', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'download_export_file' },
		])])
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_woocommerce_do_ajax_product_export'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Exporters', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'do_ajax_product_export' },
		]),
	])
	this.exporters.array_set('product_exporter', rt.create_array([
		rt.ArrayItem{ key: 'menu', val: 'edit.php?post_type=product' },
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Product Export'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'capability', val: 'export' },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Exporters', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_exporter' },
		]) },
	]))
}

fn (mut this Class_WC_Admin_Exporters) export_allowed() bool {
	return rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('export')]))
}

fn (mut this Class_WC_Admin_Exporters) add_to_menus() {
	mut iter_1 := this.exporters.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_exporter := item_1.val
		mut var_id := item_1.key
		rt.call_function('add_submenu_page', [var_exporter.array_get(rt.new_string('menu')),
			var_exporter.array_get(rt.new_string('name')), var_exporter.array_get(rt.new_string('name')),
			var_exporter.array_get(rt.new_string('capability')),
			var_id.clone(), var_exporter.array_get(rt.new_string('callback'))])
	}
}

fn (mut this Class_WC_Admin_Exporters) hide_from_menus() {
	mut var_submenu := rt.new_null()
	mut iter_2 := this.exporters.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_exporter := item_2.val
		mut var_id := item_2.key
		if var_submenu.array_isset(var_exporter.array_get(rt.new_string('menu'))) {
			mut iter_3 :=
				var_submenu.array_get(var_exporter.array_get(rt.new_string('menu'))).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_menu := item_3.val
				mut var_key := item_3.key
				if rt.is_true(rt.identical(var_id, var_menu.array_get(rt.new_int(2)))) {
					var_submenu.array_get(var_exporter.array_get(rt.new_string('menu'))).array_unset(var_key)
				}
			}
		}
	}
}

fn (mut this Class_WC_Admin_Exporters) menu_highlight_for_product_export() {
	mut var_submenu_file := rt.get_superglobal('submenu_file')
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(var_screen)
		&& rt.is_true(rt.identical(rt.new_string('product_page_product_exporter'), rt.get_property(var_screen, 'id'))) {
		var_submenu_file = rt.new_string('edit.php?post_type=product')
	}
}

fn (mut this Class_WC_Admin_Exporters) admin_scripts() {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_0) { '' } else { '.min' }).str())
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_1
	rt.call_function('wp_register_script', [rt.new_string('wc-product-export'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/wc-product-export' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		var_version.clone()])
	rt.call_function('wp_localize_script', [rt.new_string('wc-product-export'),
		rt.new_string('wc_product_export_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'export_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc-product-export'),
			]) },
		])])
}

fn (mut this Class_WC_Admin_Exporters) product_exporter() {
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/export/class-wc-product-csv-exporter.php',
		'2')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/views/html-admin-page-product-export.php', '2')
}

fn (mut this Class_WC_Admin_Exporters) download_export_file() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('nonce'))
		&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('nonce'))]), rt.new_string('product-csv')]))
		&& rt.is_true(rt.identical(rt.new_string('download_product_csv'), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('action'))]))) {
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/export/class-wc-product-csv-exporter.php',
			'2')
		mut var_exporter := create_wc_product_csv_exporter()
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filename')))) {
			rt.call_method(var_exporter, 'set_filename', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('filename'))]),
			])
		}
		rt.call_method(var_exporter, 'export', []rt.PhpVal{})
	}
}

fn (mut this Class_WC_Admin_Exporters) do_ajax_product_export() {
	rt.call_function('check_ajax_referer', [rt.new_string('wc-product-export'),
		rt.new_string('security')])
	if !(this.export_allowed()) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Insufficient privileges to export products.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	}
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/export/class-wc-product-csv-exporter.php',
		'2')
	mut var_step := if rt.get_superglobal('_POST').array_isset(rt.new_string('step')) { rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('step')),
		]) } else { rt.new_int(1) }
	mut var_exporter := create_wc_product_csv_exporter()
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('columns')))) {
		rt.call_method(var_exporter, 'set_column_names', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('columns'))]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('selected_columns')))) {
		rt.call_method(var_exporter, 'set_columns_to_export', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('selected_columns')),
			]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('export_meta')))) {
		rt.call_method(var_exporter, 'enable_meta_export', [rt.new_bool(true)])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('export_types')))) {
		rt.call_method(var_exporter, 'set_product_types_to_export', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('export_types'))]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('export_category'))))
		&& rt.get_superglobal('_POST').array_get(rt.new_string('export_category')).is_array() {
		rt.call_method(var_exporter, 'set_product_category_to_export', [
			rt.call_function('wp_unslash', [
				rt.call_function('array_values', [
					rt.get_superglobal('_POST').array_get(rt.new_string('export_category')),
				]),
			]),
		])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('export_product_ids')))) {
		mut var_ids_raw := rt.call_function('explode', [rt.new_string(','),
			rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('export_product_ids')),
				]),
			])])
		if !(!rt.is_true(var_ids_raw)) {
			rt.call_method(var_exporter, 'set_product_ids_to_export', [
				var_ids_raw.clone()])
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('filename')))) {
		rt.call_method(var_exporter, 'set_filename', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('filename'))]),
		])
	}
	rt.call_method(var_exporter, 'set_page', [var_step.clone()])
	rt.call_method(var_exporter, 'generate_file', []rt.PhpVal{})
	mut var_query_args := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_export_get_ajax_query_args'),
		rt.create_array([
			rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('product-csv'),
			]) },
			rt.ArrayItem{ key: 'action', val: 'download_product_csv' },
			rt.ArrayItem{ key: 'filename', val: rt.call_method(var_exporter, 'get_filename',
				[]rt.PhpVal{}) },
		]),
	])
	if rt.is_true(rt.identical(rt.new_int(100), rt.call_method(var_exporter,
		'get_percent_complete', []rt.PhpVal{})))
	{
		rt.call_function('wp_send_json_success', [
			rt.create_array([rt.ArrayItem{ key: 'step', val: 'done' },
				rt.ArrayItem{ key: 'percentage', val: 100 }, rt.ArrayItem{ key: 'url', val: rt.call_function('add_query_arg', [
					var_query_args.clone(),
					rt.call_function('admin_url', [
						rt.new_string('edit.php?post_type=product&page=product_exporter'),
					]),
				]) }]),
		])
	} else {
		rt.call_function('wp_send_json_success', [
			rt.create_array([rt.ArrayItem{ key: 'step', val: rt.pre_inc(var_step) },
				rt.ArrayItem{ key: 'percentage', val: rt.call_method(var_exporter,
					'get_percent_complete', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'columns', val: rt.call_method(var_exporter, 'get_column_names',
					[]rt.PhpVal{}) }]),
		])
	}
}

fn Class_WC_Admin_Exporters.get_product_types() rt.PhpVal {
	mut var_product_types := rt.call_function('wc_get_product_types', []rt.PhpVal{})
	var_product_types.array_set(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_function('__', [
		rt.new_string('Product variations'),
		rt.new_string('woocommerce'),
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_exporter_product_types'),
		var_product_types.clone(),
	])
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Product_CSV_Exporter {
	rt.PhpObjectBase
}

fn create_wc_admin_exporters() &Class_WC_Admin_Exporters {
	mut obj := &Class_WC_Admin_Exporters{
		PhpObjectBase: rt.PhpObjectBase{}
		exporters:     rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_csv_exporter(_args ...rt.PhpVal) &Class_WC_Product_CSV_Exporter {
	mut obj := &Class_WC_Product_CSV_Exporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Exporters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'export_allowed' {
			return rt.new_bool(this.export_allowed())
		}
		'add_to_menus' {
			this.add_to_menus()
			return rt.new_null()
		}
		'hide_from_menus' {
			this.hide_from_menus()
			return rt.new_null()
		}
		'menu_highlight_for_product_export' {
			this.menu_highlight_for_product_export()
			return rt.new_null()
		}
		'admin_scripts' {
			this.admin_scripts()
			return rt.new_null()
		}
		'product_exporter' {
			this.product_exporter()
			return rt.new_null()
		}
		'download_export_file' {
			this.download_export_file()
			return rt.new_null()
		}
		'do_ajax_product_export' {
			this.do_ajax_product_export()
			return rt.new_null()
		}
		'get_product_types' {
			return Class_WC_Admin_Exporters.get_product_types()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Exporters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'exporters' { return this.exporters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Exporters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'exporters' {
			this.exporters = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Product_CSV_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_CSV_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_CSV_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	create_wc_admin_exporters()
}
