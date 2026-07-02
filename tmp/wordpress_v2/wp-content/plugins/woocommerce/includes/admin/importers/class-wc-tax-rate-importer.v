import rt

struct Class_WC_Tax_Rate_Importer {
	rt.PhpObjectBase
pub mut:
	id                   rt.PhpVal = rt.new_null()
	file_url             rt.PhpVal = rt.new_null()
	import_page          string
	delimiter            rt.PhpVal = rt.new_null()
	import_error_message rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Tax_Rate_Importer) construct() {
	this.import_page = 'woocommerce_tax_rate_csv'
	this.delimiter = if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('delimiter'))) { ',' } else { (rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('delimiter'))]),
		])).str() }
}

fn (mut this Class_WC_Tax_Rate_Importer) dispatch() {
	this.header()
	mut var_step := rt.new_int(if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('step'))) {
		0
	} else {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('step'))).to_i64())
	})
	mut switch_val_1 := var_step
	if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
		this.greet()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
		rt.call_function('check_admin_referer', [rt.new_string('import-upload')])
		if this.handle_upload() {
			if rt.is_true(this.id) {
				mut var_file := rt.call_function('get_attached_file', [this.id])
			} else {
				var_file = rt.new_string((rt.get_constant('ABSPATH')).str() + (this.file_url).str())
			}
			rt.call_function('add_filter', [rt.new_string('http_request_timeout'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Tax_Rate_Importer', [
						'WP_Importer',
					], &this) },
					rt.ArrayItem{ key: none, val: 'bump_request_timeout' },
				])])
			this.import(var_file.clone())
		} else {
			this.import_error((this.import_error_message).str())
		}
	}
	this.footer()
}

fn (mut this Class_WC_Tax_Rate_Importer) import_start() {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gc_enable')])) {
		rt.call_function('gc_enable', []rt.PhpVal{})
	}
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	rt.call_function('ob_flush', []rt.PhpVal{})
	rt.call_function('flush', []rt.PhpVal{})
}

fn (mut this Class_WC_Tax_Rate_Importer) format_data_from_csv(var_data rt.PhpVal, var_enc rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.identical(rt.new_string('UTF-8'), var_enc)) { var_data } else { rt.call_function('utf8_encode', [
			var_data.clone(),
		]) }
}

fn (mut this Class_WC_Tax_Rate_Importer) import(var_file rt.PhpVal) {
	mut var_country := rt.new_null()
	mut var_state := rt.new_null()
	mut var_postcode := rt.new_null()
	mut var_city := rt.new_null()
	mut var_rate := rt.new_null()
	mut var_name := rt.new_null()
	mut var_priority := rt.new_null()
	mut var_compound := rt.new_null()
	mut var_shipping := rt.new_null()
	mut var_class := rt.new_null()
	mut var_file_mutated := var_file
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [
		var_file_mutated.clone()])))))
	{
		this.import_error((rt.call_function('__', [
			rt.new_string('The file does not exist, please try again.'),
			rt.new_string('woocommerce'),
		])).str())
	}
	this.import_start()
	mut var_loop := rt.new_int(0)
	mut var_handle := rt.call_function('fopen', [var_file_mutated.clone(),
		rt.new_string('r')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_handle)))) {
		mut var_header := rt.call_function('fgetcsv', [var_handle.clone(),
			rt.new_int(0), this.delimiter])
		mut var_count := rt.new_int(if rt.call_function('is_countable', [
			var_header.clone()])
		{ var_header.clone().array_count() } else { 0 })
		if rt.is_true(rt.identical(rt.new_int(10), var_count)) {
			mut var_row := rt.call_function('fgetcsv', [var_handle.clone(),
				rt.new_int(0), this.delimiter])
			for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_row)))) {
				mut list_tmp_1 := var_row
				var_country = list_tmp_1.array_get(0)
				var_state = list_tmp_1.array_get(1)
				var_postcode = list_tmp_1.array_get(2)
				var_city = list_tmp_1.array_get(3)
				var_rate = list_tmp_1.array_get(4)
				var_name = list_tmp_1.array_get(5)
				var_priority = list_tmp_1.array_get(6)
				var_compound = list_tmp_1.array_get(7)
				var_shipping = list_tmp_1.array_get(8)
				var_class = list_tmp_1.array_get(9)
				mut var_tax_rate := {
					'tax_rate_country':  var_country
					'tax_rate_state':    var_state
					'tax_rate':          var_rate
					'tax_rate_name':     var_name
					'tax_rate_priority': var_priority
					'tax_rate_compound': if rt.is_true(var_compound) { 1 } else { 0 }
					'tax_rate_shipping': if rt.is_true(var_shipping) { 1 } else { 0 }
					'tax_rate_order':    rt.post_inc(var_loop)
					'tax_rate_class':    var_class
				}
				mut iife_temp_0 := Class_WC_Tax{}
				mut iife_result_0 := iife_temp_0._insert_tax_rate(var_tax_rate.clone())
				mut var_tax_rate_id := iife_result_0
				mut iife_temp_1 := Class_WC_Tax{}
				mut iife_result_1 := iife_temp_1._update_tax_rate_postcodes(var_tax_rate_id.clone(), rt.call_function('wc_clean', [
					var_postcode.clone(),
				]))
				mut iife_temp_2 := Class_WC_Tax{}
				mut iife_result_2 := iife_temp_2._update_tax_rate_cities(var_tax_rate_id.clone(), rt.call_function('wc_clean', [
					var_city.clone(),
				]))
				var_row = rt.call_function('fgetcsv', [var_handle.clone(),
					rt.new_int(0), this.delimiter])
			}
		} else {
			this.import_error((rt.call_function('__', [
				rt.new_string('The CSV is invalid.'),
				rt.new_string('woocommerce'),
			])).str())
		}
		rt.call_function('fclose', [var_handle.clone()])
	}
	print('<div class="updated settings-error"><p>')
	rt.call_function('printf', [
		rt.call_function('esc_html__', [
			rt.new_string('Import complete - imported %s tax rates.'),
			rt.new_string('woocommerce'),
		]),
		rt.new_string('<strong>' + (rt.call_function('absint', [var_loop.clone()])).str() +
			'</strong>'),
	])
	print('</p></div>')
	this.import_end()
}

fn (mut this Class_WC_Tax_Rate_Importer) import_end() {
	print('<p>' +
		(rt.call_function('esc_html__', [rt.new_string('All done!'), rt.new_string('woocommerce')])).str() +
		' <a href="' +
		(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=tax')])])).str() +
		'">' +
		(rt.call_function('esc_html__', [rt.new_string('View tax rates'), rt.new_string('woocommerce')])).str() +
		'</a></p>')
	rt.call_function('do_action', [rt.new_string('import_end')])
}

fn (mut this Class_WC_Tax_Rate_Importer) set_import_error_message(var_message rt.PhpVal) {
	this.import_error_message = var_message.clone()
}

fn (mut this Class_WC_Tax_Rate_Importer) handle_upload() bool {
	mut var_file_url := if rt.get_superglobal('_POST').array_isset(rt.new_string('file_url')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('file_url'))]),
		]) } else { rt.new_string('') }
	if !rt.is_true(var_file_url) {
		mut var_file := rt.call_function('wp_import_handle_upload', []rt.PhpVal{})
		if var_file.array_isset(rt.new_string('error')) {
			this.set_import_error_message(var_file.array_get(rt.new_string('error')))
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_file_valid_csv', [
			var_file.array_get(rt.new_string('file')),
			rt.new_bool(false),
		])))))
		{
			rt.call_function('wp_delete_attachment', [var_file.array_get(rt.new_string('id')),
				rt.new_bool(true)])
			this.set_import_error_message(rt.call_function('__', [
				rt.new_string('Invalid file type. The importer supports CSV and TXT file formats.'),
				rt.new_string('woocommerce'),
			]))
			return false
		}
		this.id = rt.call_function('absint', [var_file.array_get(rt.new_string('id'))])
	} else if
		rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [rt.call_function('realpath', [rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_url.str())]), rt.get_constant('ABSPATH')])))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_url.str())])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_is_file_valid_csv', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_url.str()),
		])))))
		{
			this.set_import_error_message(rt.call_function('__', [
				rt.new_string('Invalid file type. The importer supports CSV and TXT file formats.'),
				rt.new_string('woocommerce'),
			]))
			return false
		}
		this.file_url = rt.call_function('esc_attr', [var_file_url.clone()])
	} else {
		return false
	}
	return true
}

fn (mut this Class_WC_Tax_Rate_Importer) header() {
	print('<div class="wrap">')
	print('<h1>' +
		(rt.call_function('esc_html__', [rt.new_string('Import tax rates'), rt.new_string('woocommerce')])).str() +
		'</h1>')
}

fn (mut this Class_WC_Tax_Rate_Importer) footer() {
	print('</div>')
}

fn (mut this Class_WC_Tax_Rate_Importer) greet() {
	print('<div class="narrow">')
	print('<p>' +
		(rt.call_function('esc_html__', [rt.new_string('Hi there! Upload a CSV file containing tax rates to import the contents into your shop. Choose a .csv file to upload, then click "Upload file and import".'), rt.new_string('woocommerce')])).str() +
		'</p>')
	print('<p>' +
		(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your CSV needs to include columns in a specific order. %1$sClick here to download a sample%2$s.'), rt.new_string('woocommerce')]), rt.new_string('<a href="' + (rt.call_function('esc_url', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() +
		'/sample-data/sample_tax_rates.csv">'), rt.new_string('</a>')])).str() + '</p>')
	mut var_action := rt.new_string('admin.php?import=woocommerce_tax_rate_csv&step=1')
	mut var_bytes := rt.call_function('apply_filters', [
		rt.new_string('import_upload_size_limit'),
		rt.call_function('wp_max_upload_size', []rt.PhpVal{}),
	])
	mut var_size := rt.call_function('size_format', [var_bytes.clone()])
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	if !(!rt.is_true(var_upload_dir.array_get(rt.new_string('error')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Before you can upload your import file, you will need to fix the following error:'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_upload_dir.array_get(rt.new_string('error'))]))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.call_function('wp_nonce_url', [var_action.clone(),
				rt.new_string('import-upload')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Choose a file from your computer:'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('absint', [var_bytes.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [
			rt.call_function('esc_html__', [rt.new_string('Maximum size: %s'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_attr', [var_size.clone()]),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('OR enter path to file:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		print(' ' + (rt.call_function('esc_html', [rt.get_constant('ABSPATH')])).str() + ' ')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Delimiter'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Upload file and import'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Upload file and import'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	print('</div>')
}

fn (mut this Class_WC_Tax_Rate_Importer) import_error(message string) {
	print('<p><strong>' +
		(rt.call_function('esc_html__', [rt.new_string('Sorry, there has been an error.'), rt.new_string('woocommerce')])).str() +
		'</strong><br />')
	if var_message.len > 0 && var_message != '0' {
		rt.echo_val(rt.call_function('esc_html', [rt.new_string(message)]))
	}
	print('</p>')
	this.footer()
	exit(0)
}

fn (mut this Class_WC_Tax_Rate_Importer) bump_request_timeout(var_val rt.PhpVal) i64 {
	return 60
}

struct Class_WP_Importer {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_tax_rate_importer() &Class_WC_Tax_Rate_Importer {
	mut obj := &Class_WC_Tax_Rate_Importer{
		PhpObjectBase:        rt.PhpObjectBase{}
		id:                   rt.new_null()
		file_url:             rt.new_null()
		import_page:          ''
		delimiter:            rt.new_null()
		import_error_message: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_importer(_args ...rt.PhpVal) &Class_WP_Importer {
	mut obj := &Class_WP_Importer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tax_Rate_Importer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'dispatch' {
			this.dispatch()
			return rt.new_null()
		}
		'import_start' {
			this.import_start()
			return rt.new_null()
		}
		'format_data_from_csv' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.format_data_from_csv(dispatch_arg_0, dispatch_arg_1)
		}
		'import' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.import(dispatch_arg_0)
			return rt.new_null()
		}
		'import_end' {
			this.import_end()
			return rt.new_null()
		}
		'set_import_error_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_import_error_message(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_upload' {
			return rt.new_bool(this.handle_upload())
		}
		'header' {
			this.header()
			return rt.new_null()
		}
		'footer' {
			this.footer()
			return rt.new_null()
		}
		'greet' {
			this.greet()
			return rt.new_null()
		}
		'import_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.import_error(dispatch_arg_0)
			return rt.new_null()
		}
		'bump_request_timeout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.bump_request_timeout(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Tax_Rate_Importer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'file_url' { return this.file_url }
		'import_page' { return rt.new_string(this.import_page) }
		'delimiter' { return this.delimiter }
		'import_error_message' { return this.import_error_message }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Tax_Rate_Importer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'file_url' {
			this.file_url = val
			return true
		}
		'import_page' {
			this.import_page = val.str()
			return true
		}
		'delimiter' {
			this.delimiter = val
			return true
		}
		'import_error_message' {
			this.import_error_message = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Importer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Importer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Importer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Importer'),
	])))))
	{
		return rt.new_null()
	}
}
