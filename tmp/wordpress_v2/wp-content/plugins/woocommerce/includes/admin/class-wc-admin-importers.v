import rt

struct Class_WC_Admin_Importers {
	rt.PhpObjectBase
pub mut:
	importers rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Admin_Importers) construct() {
	if !(this.import_allowed()) {
		return
	}
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_to_menus' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_importers' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'hide_from_menus' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'menu_highlight_for_product_import' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'admin_scripts' },
		])])
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_woocommerce_do_ajax_product_import'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'do_ajax_product_import' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('in_admin_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_importer_exporter_view' },
		])])
	mut var_wp_posts_importer := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter.class(),
	])
	rt.call_method(var_wp_posts_importer, 'register', []rt.PhpVal{})
	this.importers.array_set('product_importer', rt.create_array([
		rt.ArrayItem{ key: 'menu', val: 'edit.php?post_type=product' },
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Product Import'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'capability', val: 'import' },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'product_importer' },
		]) },
	]))
}

fn (mut this Class_WC_Admin_Importers) import_allowed() bool {
	return rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_products')]))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('import')]))
}

fn (mut this Class_WC_Admin_Importers) add_to_menus() {
	mut iter_1 := this.importers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_importer := item_1.val
		mut var_id := item_1.key
		rt.call_function('add_submenu_page', [var_importer.array_get(rt.new_string('menu')),
			var_importer.array_get(rt.new_string('name')), var_importer.array_get(rt.new_string('name')),
			var_importer.array_get(rt.new_string('capability')),
			var_id.clone(), var_importer.array_get(rt.new_string('callback'))])
	}
}

fn (mut this Class_WC_Admin_Importers) hide_from_menus() {
	mut var_submenu := rt.new_null()
	mut iter_2 := this.importers.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_importer := item_2.val
		mut var_id := item_2.key
		if var_submenu.array_isset(var_importer.array_get(rt.new_string('menu'))) {
			mut iter_3 :=
				var_submenu.array_get(var_importer.array_get(rt.new_string('menu'))).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_menu := item_3.val
				mut var_key := item_3.key
				if rt.is_true(rt.identical(var_id, var_menu.array_get(rt.new_int(2)))) {
					var_submenu.array_get(var_importer.array_get(rt.new_string('menu'))).array_unset(var_key)
				}
			}
		}
	}
}

fn (mut this Class_WC_Admin_Importers) menu_highlight_for_product_import() {
	mut var_submenu_file := rt.get_superglobal('submenu_file')
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(var_screen)
		&& rt.is_true(rt.identical(rt.new_string('product_page_product_importer'), rt.get_property(var_screen, 'id'))) {
		var_submenu_file = rt.new_string('edit.php?post_type=product')
	}
}

fn (mut this Class_WC_Admin_Importers) admin_scripts() {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut var_suffix := rt.new_string((if rt.is_true(iife_result_0) { '' } else { '.min' }).str())
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_1
	rt.call_function('wp_register_script', [rt.new_string('wc-product-import'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/js/admin/wc-product-import' + var_suffix.str() + '.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		var_version.clone(), rt.new_bool(true)])
}

fn (mut this Class_WC_Admin_Importers) product_importer() {
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.is_defined(rt.new_string('WP_LOAD_IMPORTERS'))
	if rt.is_true(iife_result_2) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('edit.php?post_type=product&page=product_importer&source=wordpress-importer'),
			]),
		])
		exit(0)
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('source'))
		&& rt.is_true(rt.identical(rt.new_string('wordpress-importer'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('source'))])]))) {
		rt.call_function('wc_admin_record_tracks_event', [
			rt.new_string('product_importer_view_from_wp_importer'),
		])
	}
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/import/class-wc-product-csv-importer.php',
		'2')
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/importers/class-wc-product-csv-importer-controller.php',
		'2')
	mut var_importer := create_wc_product_csv_importer_controller()
	rt.call_method(var_importer, 'dispatch', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Importers) register_importers() {
	mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_3 := iife_temp_3.is_defined(rt.new_string('WP_LOAD_IMPORTERS'))
	if rt.is_true(iife_result_3) {
		rt.call_function('register_importer', [rt.new_string('woocommerce_product_csv'),
			rt.call_function('__', [rt.new_string('WooCommerce products (CSV)'),
				rt.new_string('woocommerce')]),
			rt.call_function('__', [
				rt.new_string('Import <strong>products</strong> to your store via a csv file.'),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'product_importer' },
			])])
		rt.call_function('register_importer', [rt.new_string('woocommerce_tax_rate_csv'),
			rt.call_function('__', [rt.new_string('WooCommerce tax rates (CSV)'),
				rt.new_string('woocommerce')]),
			rt.call_function('__', [
				rt.new_string('Import <strong>tax rates</strong> to your store via a csv file.'),
				rt.new_string('woocommerce'),
			]),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Importers', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'tax_rates_importer' },
			])])
	}
}

fn (mut this Class_WC_Admin_Importers) tax_rates_importer() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/import.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Importer'),
	])))))
	{
		mut var_class_wp_importer := rt.new_string(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-importer.php')
		if rt.is_true(rt.call_function('file_exists', [var_class_wp_importer.clone()])) {
			rt.include_file(var_class_wp_importer.to_string(), '3')
		}
	}
	rt.call_function('wc_admin_record_tracks_event', [
		rt.new_string('tax_rates_importer_view_from_wp_importer'),
	])
	rt.include_file(@DIR + '/importers/class-wc-tax-rate-importer.php', '3')
	mut var_importer := create_wc_tax_rate_importer()
	rt.call_method(var_importer, 'dispatch', []rt.PhpVal{})
}

fn (mut this Class_WC_Admin_Importers) post_importer_compatibility() {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('post_importer_compatibility'),
		rt.new_string('10.1.0'),
		rt.new_string('A new integration with the WP WXR importer now filters the posts during import and registers the taxonomies, instead of initializing them at the start of the import and having to re-parse the file.'),
	])
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('import_id')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WXR_Parser')]))))) {
		return
	}
	mut var_id := rt.call_function('absint',
		[rt.get_superglobal('_POST').array_get(rt.new_string('import_id'))])
	mut var_file := rt.call_function('get_attached_file', [var_id.clone()])
	mut var_parser := create_wxr_parser()
	mut var_import_data := var_parser.parse(var_file.clone())
	if var_import_data.array_isset(rt.new_string('posts'))
		&& !(!rt.is_true(var_import_data.array_get(rt.new_string('posts')))) {
		mut iter_4 := var_import_data.array_get(rt.new_string('posts')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_post := item_4.val
			if rt.is_true(rt.identical(rt.new_string('product'), var_post.array_get(rt.new_string('post_type'))))
				&& !(!rt.is_true(var_post.array_get(rt.new_string('terms')))) {
				mut iter_5 := var_post.array_get(rt.new_string('terms')).iterator()
				for {
					item_5 := iter_5.next() or { break }
					mut var_term := item_5.val
					if rt.is_true(rt.call_function('strstr', [
						var_term.array_get(rt.new_string('domain')),
						rt.new_string('pa_'),
					]))
					{
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
							var_term.array_get(rt.new_string('domain')),
						])))))
						{
							mut var_attribute_name := rt.call_function('wc_attribute_taxonomy_slug', [
								var_term.array_get(rt.new_string('domain')),
							])
							if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
								var_attribute_name.clone(),
								rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}),
								rt.new_bool(true),
							])))))
							{
								rt.call_function('wc_create_attribute', [
									rt.create_array([
										rt.ArrayItem{ key: 'name', val: var_attribute_name },
										rt.ArrayItem{ key: 'slug', val: var_attribute_name },
										rt.ArrayItem{ key: 'type', val: 'select' },
										rt.ArrayItem{ key: 'order_by', val: 'menu_order' },
										rt.ArrayItem{ key: 'has_archives', val: false },
									]),
								])
							}
							rt.call_function('register_taxonomy', [
								var_term.array_get(rt.new_string('domain')),
								rt.call_function('apply_filters', [
									rt.new_string('woocommerce_taxonomy_objects_' +
										(var_term.array_get(rt.new_string('domain'))).str()),
									rt.create_array([
										rt.ArrayItem{ key: none, val: 'product' },
									]),
								]),
								rt.call_function('apply_filters', [
									rt.new_string('woocommerce_taxonomy_args_' +
										(var_term.array_get(rt.new_string('domain'))).str()),
									rt.create_array([
										rt.ArrayItem{ key: 'hierarchical', val: true },
										rt.ArrayItem{ key: 'show_ui', val: false },
										rt.ArrayItem{ key: 'query_var', val: true },
										rt.ArrayItem{ key: 'rewrite', val: false },
									]),
								]),
							])
						}
					}
				}
			}
		}
	}
}

fn (mut this Class_WC_Admin_Importers) do_ajax_product_import() {
	if !(this.import_allowed()) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Insufficient privileges to import products.'),
					rt.new_string('woocommerce'),
				]) },
			]),
		])
	}
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/importers/class-wc-product-csv-importer-controller.php',
		'2')
	mut iife_temp_4 := Class_WC_Product_CSV_Importer_Controller{}
	mut iife_result_4 := iife_temp_4.dispatch_ajax()
}

fn (mut this Class_WC_Admin_Importers) track_importer_exporter_view() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if !(!(rt.get_property(var_screen, 'id')).is_null()) {
		return
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('import')) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('import'), rt.get_property(var_screen, 'id')))
		|| rt.is_true(rt.identical(rt.new_string('export'), rt.get_property(var_screen, 'id'))) {
		rt.call_function('wc_admin_record_tracks_event', [
			rt.new_string('wordpress_' + (rt.get_property(var_screen, 'id')).str() + '_view'),
		])
	}
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Product_CSV_Importer_Controller {
	rt.PhpObjectBase
}

struct Class_WC_Tax_Rate_Importer {
	rt.PhpObjectBase
}

struct Class_WXR_Parser {
	rt.PhpObjectBase
}

fn create_wc_admin_importers() &Class_WC_Admin_Importers {
	mut obj := &Class_WC_Admin_Importers{
		PhpObjectBase: rt.PhpObjectBase{}
		importers:     rt.new_array()
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

fn create_wc_product_csv_importer_controller(_args ...rt.PhpVal) &Class_WC_Product_CSV_Importer_Controller {
	mut obj := &Class_WC_Product_CSV_Importer_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax_rate_importer(_args ...rt.PhpVal) &Class_WC_Tax_Rate_Importer {
	mut obj := &Class_WC_Tax_Rate_Importer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wxr_parser(_args ...rt.PhpVal) &Class_WXR_Parser {
	mut obj := &Class_WXR_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Importers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'import_allowed' {
			return rt.new_bool(this.import_allowed())
		}
		'add_to_menus' {
			this.add_to_menus()
			return rt.new_null()
		}
		'hide_from_menus' {
			this.hide_from_menus()
			return rt.new_null()
		}
		'menu_highlight_for_product_import' {
			this.menu_highlight_for_product_import()
			return rt.new_null()
		}
		'admin_scripts' {
			this.admin_scripts()
			return rt.new_null()
		}
		'product_importer' {
			this.product_importer()
			return rt.new_null()
		}
		'register_importers' {
			this.register_importers()
			return rt.new_null()
		}
		'tax_rates_importer' {
			this.tax_rates_importer()
			return rt.new_null()
		}
		'post_importer_compatibility' {
			this.post_importer_compatibility()
			return rt.new_null()
		}
		'do_ajax_product_import' {
			this.do_ajax_product_import()
			return rt.new_null()
		}
		'track_importer_exporter_view' {
			this.track_importer_exporter_view()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Importers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'importers' { return this.importers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Importers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'importers' {
			this.importers = val
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

fn (mut this Class_WC_Product_CSV_Importer_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_CSV_Importer_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tax_Rate_Importer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax_Rate_Importer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax_Rate_Importer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WXR_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WXR_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WXR_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	create_wc_admin_importers()
}
