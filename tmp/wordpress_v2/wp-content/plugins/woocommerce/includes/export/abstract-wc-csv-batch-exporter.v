import rt

struct Class_WC_CSV_Batch_Exporter {
	rt.PhpObjectBase
pub mut:
	page rt.PhpVal = rt.new_int(1)
}

fn (mut this Class_WC_CSV_Batch_Exporter) construct() {
	this.dispatch_set_prop('column_names', this.get_default_column_names())
}

fn (mut this Class_WC_CSV_Batch_Exporter) get_file_path() string {
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	return
		(rt.call_function('trailingslashit', [var_upload_dir.array_get(rt.new_string('basedir'))])).str() +
		(this.get_filename()).str()
}

fn (mut this Class_WC_CSV_Batch_Exporter) get_headers_row_file_path() string {
	return this.get_file_path() + '.headers'
}

fn (mut this Class_WC_CSV_Batch_Exporter) get_headers_row_file() rt.PhpVal {
	mut var_file := rt.new_string((rt.call_function('chr', [rt.new_int(239)])).str() +
		(rt.call_function('chr', [rt.new_int(187)])).str() +
		(rt.call_function('chr', [rt.new_int(191)])).str() + (this.export_column_headers()).str())
	if rt.is_true(rt.call_function('file_exists', [
		rt.new_string(this.get_headers_row_file_path()),
	]))
	{
		var_file = rt.call_function('file_get_contents', [
			rt.new_string(this.get_headers_row_file_path()),
		])
	}
	return var_file.clone()
}

fn (mut this Class_WC_CSV_Batch_Exporter) get_file() rt.PhpVal {
	mut var_file := rt.new_string('')
	if rt.is_true(rt.call_function('file_exists', [rt.new_string(this.get_file_path())])) {
		var_file = rt.call_function('file_get_contents', [
			rt.new_string(this.get_file_path()),
		])
	} else {
		rt.call_function('file_put_contents', [rt.new_string(this.get_file_path()),
			rt.new_string('')])
		rt.call_function('chmod', [rt.new_string(this.get_file_path()),
			rt.new_int(436)])
	}
	return var_file.clone()
}

fn (mut this Class_WC_CSV_Batch_Exporter) export() {
	this.send_headers()
	this.send_content(rt.new_string((this.get_headers_row_file()).str() + (this.get_file()).str()))
	rt.call_function('unlink', [rt.new_string(this.get_file_path())])
	rt.call_function('unlink', [rt.new_string(this.get_headers_row_file_path())])
	exit(0)
}

fn (mut this Class_WC_CSV_Batch_Exporter) generate_file() {
	if rt.is_true(rt.identical(rt.new_int(1), this.get_page())) {
		rt.call_function('unlink', [rt.new_string(this.get_file_path())])
		this.get_file()
	}
	this.prepare_data_to_export()
	this.write_csv_data(this.get_csv_data())
}

fn (mut this Class_WC_CSV_Batch_Exporter) write_csv_data(var_data rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [rt.new_string(this.get_file_path())])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writeable', [rt.new_string(this.get_file_path())]))))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Unable to create or write to %s during CSV export. Please check file permissions.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.new_string(this.get_file_path()),
				]),
			]),
		])
		return false
	}
	mut var_fopen_mode := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_exporter_fopen_mode'),
		rt.new_string('a+'),
	])
	mut var_fp := rt.call_function('fopen', [rt.new_string(this.get_file_path()),
		var_fopen_mode.clone()])
	if rt.is_true(var_fp) {
		rt.call_function('fwrite', [var_fp.clone(), var_data.clone()])
		rt.call_function('fclose', [var_fp.clone()])
	}
	if 100 == this.get_percent_complete() {
		mut var_header := rt.new_string((rt.call_function('chr', [rt.new_int(239)])).str() +
			(rt.call_function('chr', [rt.new_int(187)])).str() +
			(rt.call_function('chr', [rt.new_int(191)])).str() +
			(this.export_column_headers()).str())
		rt.call_function('file_put_contents', [
			rt.new_string(this.get_headers_row_file_path()),
			var_header.clone(),
		])
	}
	return false
}

fn (mut this Class_WC_CSV_Batch_Exporter) get_page() rt.PhpVal {
	return this.page
}

fn (mut this Class_WC_CSV_Batch_Exporter) set_page(var_page rt.PhpVal) {
	this.page = rt.call_function('absint', [var_page.clone()])
}

fn (mut this Class_WC_CSV_Batch_Exporter) get_total_exported() rt.PhpVal {
	return rt.add(rt.mul(rt.sub(this.get_page(), rt.new_int(1)), this.get_limit()), rt.get_property(rt.new_object('WC_CSV_Batch_Exporter', [
		'WC_CSV_Exporter',
	], &this), 'exported_row_count'))
}

fn (mut this Class_WC_CSV_Batch_Exporter) get_percent_complete() i64 {
	return if rt.is_true(rt.get_property(rt.new_object('WC_CSV_Batch_Exporter', [
		'WC_CSV_Exporter',
	], &this), 'total_rows'))
	{ rt.new_int((rt.call_function('floor', [
			rt.mul(rt.div(this.get_total_exported(), rt.get_property(rt.new_object('WC_CSV_Batch_Exporter', [
				'WC_CSV_Exporter',
			], &this), 'total_rows')), rt.new_int(100)),
		])).to_i64()) } else { 100 }
}

struct Class_WC_CSV_Exporter {
	rt.PhpObjectBase
}

fn create_wc_csv_batch_exporter() &Class_WC_CSV_Batch_Exporter {
	mut obj := &Class_WC_CSV_Batch_Exporter{
		PhpObjectBase: rt.PhpObjectBase{}
		page:          rt.new_int(1)
	}
	obj.construct()
	return obj
}

fn create_wc_csv_exporter(_args ...rt.PhpVal) &Class_WC_CSV_Exporter {
	mut obj := &Class_WC_CSV_Exporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_CSV_Batch_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_file_path' {
			return rt.new_string(this.get_file_path())
		}
		'get_headers_row_file_path' {
			return rt.new_string(this.get_headers_row_file_path())
		}
		'get_headers_row_file' {
			return this.get_headers_row_file()
		}
		'get_file' {
			return this.get_file()
		}
		'export' {
			this.export()
			return rt.new_null()
		}
		'generate_file' {
			this.generate_file()
			return rt.new_null()
		}
		'write_csv_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.write_csv_data(dispatch_arg_0))
		}
		'get_page' {
			return this.get_page()
		}
		'set_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_page(dispatch_arg_0)
			return rt.new_null()
		}
		'get_total_exported' {
			return this.get_total_exported()
		}
		'get_percent_complete' {
			return rt.new_int(this.get_percent_complete())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_CSV_Batch_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'page' { return this.page }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_CSV_Batch_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'page' {
			this.page = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_CSV_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_CSV_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CSV_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_CSV_Exporter'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/export/abstract-wc-csv-exporter.php',
			'4')
	}
}
