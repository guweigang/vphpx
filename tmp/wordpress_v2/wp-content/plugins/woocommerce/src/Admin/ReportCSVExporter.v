import rt

struct Class_Automattic_WooCommerce_Admin_ReportCSVExporter {
	rt.PhpObjectBase
pub mut:
	report_type rt.PhpVal = rt.new_null()
	report_args rt.PhpVal = rt.new_null()
	controller  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) construct(type bool, var_args rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter.construct()
	Class_Automattic_WooCommerce_Admin_ReportCSVExporter.maybe_create_directory()
	if !(!type) {
		this.set_report_type(rt.new_bool(type))
		this.set_column_names(this.get_report_columns())
	}
	if !(!rt.is_true(var_args)) {
		this.set_report_args(var_args.clone())
	}
}

fn Class_Automattic_WooCommerce_Admin_ReportCSVExporter.maybe_create_directory() {
	mut var_reports_dir :=
		Class_Automattic_WooCommerce_Admin_ReportCSVExporter.get_reports_directory()
	mut var_files := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'base', val: var_reports_dir },
			rt.ArrayItem{ key: 'file', val: '.htaccess' },
			rt.ArrayItem{ key: 'content', val: 'DirectoryIndex index.php index.html' +
				(rt.get_constant('PHP_EOL')).str() + 'deny from all' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'base', val: var_reports_dir },
			rt.ArrayItem{ key: 'file', val: 'index.html' },
			rt.ArrayItem{ key: 'content', val: '' },
		]) },
	])
	mut iter_1 := var_files.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_file := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
			rt.call_function('trailingslashit', [var_file.array_get(rt.new_string('base'))]),
		])))))
		{
			rt.call_function('wp_mkdir_p', [var_file.array_get(rt.new_string('base'))])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
			rt.new_string(
				(rt.call_function('trailingslashit', [var_file.array_get(rt.new_string('base'))])).str() +
				(var_file.array_get(rt.new_string('file'))).str()),
		])))))
		{
			mut var_file_handle := rt.call_function('fopen', [
				rt.new_string(
					(rt.call_function('trailingslashit', [var_file.array_get(rt.new_string('base'))])).str() +
					(var_file.array_get(rt.new_string('file'))).str()),
				rt.new_string('wb'),
			])
			if rt.is_true(var_file_handle) {
				rt.call_function('fwrite', [var_file_handle.clone(),
					var_file.array_get(rt.new_string('content'))])
				rt.call_function('fclose', [var_file_handle.clone()])
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Admin_ReportCSVExporter.get_reports_directory() string {
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	return
		(rt.call_function('trailingslashit', [var_upload_dir.array_get(rt.new_string('basedir'))])).str() +
		'woocommerce_uploads/reports/'
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) get_file_path() string {
	return (Class_Automattic_WooCommerce_Admin_ReportCSVExporter.get_reports_directory()).str() +
		(this.get_filename()).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) set_report_type(var_type rt.PhpVal) {
	this.report_type = var_type.clone()
	this.dispatch_set_prop('export_type', rt.new_string('admin_${var_type.to_string()}_report'))
	this.dispatch_set_prop('filename', rt.new_string('wc-${var_type.to_string()}-report-export'))
	this.controller = this.map_report_controller()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) set_report_args(var_args rt.PhpVal) {
	mut var_report_args := rt.call_function('array_merge', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'per_page', val: this.get_limit() },
			rt.ArrayItem{ key: 'extended_info', val: true }])])
	if var_report_args.array_isset(rt.new_string('page')) {
		this.set_page(var_report_args.array_get(rt.new_string('page')))
	}
	this.report_args = var_report_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) map_report_controller() bool {
	mut var_controller_map := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_export_report_controller_map'),
		rt.create_array([
			rt.ArrayItem{
				key: 'products'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Products\\Controller'
			},
			rt.ArrayItem{
				key: 'variations'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Variations\\Controller'
			},
			rt.ArrayItem{
				key: 'orders'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Orders\\Controller'
			},
			rt.ArrayItem{
				key: 'categories'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Categories\\Controller'
			},
			rt.ArrayItem{
				key: 'taxes'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Taxes\\Controller'
			},
			rt.ArrayItem{
				key: 'coupons'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Coupons\\Controller'
			},
			rt.ArrayItem{
				key: 'stock'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Stock\\Controller'
			},
			rt.ArrayItem{
				key: 'downloads'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Downloads\\Controller'
			},
			rt.ArrayItem{
				key: 'customers'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Customers\\Controller'
			},
			rt.ArrayItem{
				key: 'revenue'
				val: 'Automattic\\WooCommerce\\Admin\\API\\Reports\\Revenue\\Stats\\Controller'
			},
		]),
	])
	if var_controller_map.array_isset(this.report_type) {
		return (rt.create_object_dynamically(var_controller_map.array_get(this.report_type),
			[]rt.PhpVal{})).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) get_report_columns() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.instance_of(this.controller,
		'Automattic_WooCommerce_Admin_API_Reports_ExportableInterface')))
	{
		return rt.call_method(this.controller, 'get_export_columns', []rt.PhpVal{})
	}
	mut var_report_columns := rt.new_array()
	mut var_report_schema := rt.call_method(this.controller, 'get_item_schema', []rt.PhpVal{})
	if var_report_schema.array_isset(rt.new_string('properties')) {
		mut iter_2 := var_report_schema.array_get(rt.new_string('properties')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_column_info := item_2.val
			mut var_column_name := item_2.key
			if rt.is_true(rt.identical(rt.new_string('extended_info'), var_column_name)) {
				mut var_extended_info := rt.call_function('array_diff', [
					rt.func_array_keys(var_column_info.clone()),
					rt.create_array([rt.ArrayItem{ key: none, val: 'image' }]),
				])
				var_report_columns = rt.call_function('array_merge', [
					var_report_columns.clone(), var_extended_info.clone()])
			} else {
				var_report_columns.array_push(var_column_name.clone())
			}
		}
	}
	return var_report_columns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) get_percent_complete() i64 {
	return this.Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter.get_percent_complete().to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) get_total_rows() rt.PhpVal {
	return rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
		'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
	], &this), 'total_rows')
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) prepare_data_to_export() {
	mut var_report_endpoint := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_export_report_data_endpoint'),
		rt.concat(rt.new_string('/wc-analytics/reports/'), this.report_type),
		this.report_type,
	])
	mut var_request := create_automattic_woocommerce_admin_wp_rest_request(rt.new_string('GET'),
		var_report_endpoint.clone())
	mut var_params := rt.call_method(this.controller, 'get_collection_params', []rt.PhpVal{})
	mut var_defaults := rt.new_array()
	mut iter_3 := var_params.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_options := item_3.val
		mut var_arg := item_3.key
		if var_options.array_isset(rt.new_string('default')) {
			var_defaults.array_set(var_arg, var_options.array_get(rt.new_string('default')))
		}
	}
	var_request.set_attributes(rt.create_array([
		rt.ArrayItem{ key: 'args', val: var_params },
	]))
	var_request.set_default_params(var_defaults.clone())
	var_request.set_query_params(this.report_args)
	var_request.sanitize_params()
	if rt.is_true(rt.call_function('is_callable', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.controller },
			rt.ArrayItem{ key: none, val: 'get_export_items' }]),
	]))
	{
		mut var_response := rt.call_method(this.controller, 'get_export_items', [
			var_request,
		])
	} else {
		var_response = rt.call_method(this.controller, 'get_items', [var_request])
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_rest_check_permissions'),
		rt.new_string('__return_true')])
	mut var_rest_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut var_report_data := rt.call_method(var_rest_server, 'response_to_data', [
		var_response.clone(),
		rt.new_bool(true),
	])
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_rest_check_permissions'),
		rt.new_string('__return_true'),
	])
	mut var_report_meta := rt.call_method(var_response, 'get_headers', []rt.PhpVal{})
	this.dispatch_set_prop('total_rows', var_report_meta.array_get(rt.new_string('X-WP-Total')))
	this.dispatch_set_prop('row_data', rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
				'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
			], &this) },
			rt.ArrayItem{ key: none, val: 'generate_row_data' },
		]),
		var_report_data.clone(),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) get_raw_row_data(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_columns := this.get_column_names()
	mut var_row := rt.new_array()
	if var_item_mutated.array_isset(rt.new_string('extended_info')) {
		mut var_extended_info :=
			rt.cast_array(var_item_mutated.array_get(rt.new_string('extended_info')))
		var_item_mutated.array_unset(rt.new_string('extended_info'))
		var_item_mutated = rt.call_function('array_merge', [var_item_mutated.clone(),
			var_extended_info.clone()])
	}
	mut iter_4 := var_columns.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_column_name := item_4.val
		mut var_column_id := item_4.key
		mut var_value := if var_item_mutated.array_isset(var_column_name) {
			var_item_mutated.array_get(var_column_name)
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.call_function('has_filter', [
			rt.concat(rt.concat(rt.concat(rt.new_string('woocommerce_export_'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
				'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
			], &this), 'export_type')), rt.new_string('_column_')), var_column_name),
		]))
		{
			var_value = rt.call_function('apply_filters', [
				rt.concat(rt.concat(rt.concat(rt.new_string('woocommerce_export_'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
					'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
				], &this), 'export_type')), rt.new_string('_column_')), var_column_name),
				rt.new_string(''),
				var_item_mutated.clone(),
			])
		} else if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
					'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_column_value_${var_column_name.to_string()}' },
			]),
		]))
		{
			var_value = rt.call_method(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
				'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
			], &this), 'get_column_value_${var_column_name.to_string()}', [
				var_item_mutated.clone(),
				rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
					'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
				], &this), 'export_type')])
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [
			var_value.clone(),
		])))))
		{
			var_value = rt.call_function('wp_json_encode', [var_value.clone()])
		}
		var_row.array_set(var_column_id, var_value.clone())
	}
	return var_row.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) generate_row_data(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	if rt.is_true(rt.new_bool(rt.instance_of(this.controller,
		'Automattic_WooCommerce_Admin_API_Reports_ExportableInterface')))
	{
		mut var_row := rt.call_method(this.controller, 'prepare_item_for_export', [
			var_item_mutated.clone(),
		])
	} else {
		var_row = this.get_raw_row_data(var_item_mutated.clone())
	}
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_export_'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
			'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
		], &this), 'export_type')), rt.new_string('_row_data')),
		var_row.clone(),
		var_item_mutated.clone(),
	])
}

struct Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_reportcsvexporter(type bool, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_ReportCSVExporter {
	mut obj := &Class_Automattic_WooCommerce_Admin_ReportCSVExporter{
		PhpObjectBase: rt.PhpObjectBase{}
		report_type:   rt.new_null()
		report_args:   rt.new_null()
		controller:    rt.new_null()
	}
	obj.construct(type, arg_1)
	return obj
}

fn create_automattic_woocommerce_admin_wc_csv_batch_exporter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter {
	mut obj := &Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_wp_rest_request(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_WP_REST_Request {
	mut obj := &Class_Automattic_WooCommerce_Admin_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_create_directory' {
			Class_Automattic_WooCommerce_Admin_ReportCSVExporter.maybe_create_directory()
			return rt.new_null()
		}
		'get_reports_directory' {
			return rt.new_string(Class_Automattic_WooCommerce_Admin_ReportCSVExporter.get_reports_directory())
		}
		'get_file_path' {
			return rt.new_string(this.get_file_path())
		}
		'set_report_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_report_type(dispatch_arg_0)
			return rt.new_null()
		}
		'set_report_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_report_args(dispatch_arg_0)
			return rt.new_null()
		}
		'map_report_controller' {
			return rt.new_bool(this.map_report_controller())
		}
		'get_report_columns' {
			return this.get_report_columns()
		}
		'get_percent_complete' {
			return rt.new_int(this.get_percent_complete())
		}
		'get_total_rows' {
			return this.get_total_rows()
		}
		'prepare_data_to_export' {
			this.prepare_data_to_export()
			return rt.new_null()
		}
		'get_raw_row_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_raw_row_data(dispatch_arg_0)
		}
		'generate_row_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_row_data(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_ReportCSVExporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'report_type' { return this.report_type }
		'report_args' { return this.report_args }
		'controller' { return this.controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_ReportCSVExporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'report_type' {
			this.report_type = val
			return true
		}
		'report_args' {
			this.report_args = val
			return true
		}
		'controller' {
			this.controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_ReportCSVExporter', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		obj := create_automattic_woocommerce_admin_reportcsvexporter(c_arg_0, c_arg_1)
		return rt.new_object('Automattic_WooCommerce_Admin_ReportCSVExporter', [
			'Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_wc_csv_batch_exporter()
		return rt.new_object('Automattic_WooCommerce_Admin_WC_CSV_Batch_Exporter', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_WP_REST_Request', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_wp_rest_request()
		return rt.new_object('Automattic_WooCommerce_Admin_WP_REST_Request', []string{}, obj)
	})
}

fn init() {
	init_registry()
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_CSV_Batch_Exporter'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/export/abstract-wc-csv-batch-exporter.php',
			'2')
	}
}
