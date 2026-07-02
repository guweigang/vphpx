import rt

struct Class_WC_CSV_Exporter {
	rt.PhpObjectBase
pub mut:
	export_type        rt.PhpVal = rt.new_string('')
	filename           rt.PhpVal = rt.new_string('wc-export.csv')
	limit              rt.PhpVal = rt.new_int(50)
	exported_row_count rt.PhpVal = rt.new_int(0)
	row_data           rt.PhpVal = rt.new_array()
	total_rows         rt.PhpVal = rt.new_int(0)
	column_names       rt.PhpVal = rt.new_array()
	columns_to_export  rt.PhpVal = rt.new_array()
	delimiter          rt.PhpVal = rt.new_string(',')
}

fn (mut this Class_WC_CSV_Exporter) prepare_data_to_export() {
}

fn (mut this Class_WC_CSV_Exporter) get_column_names() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_'), this.export_type),
			rt.new_string('_export_column_names')),
		this.column_names,
		rt.new_object('WC_CSV_Exporter', []string{}, &this),
	])
}

fn (mut this Class_WC_CSV_Exporter) set_column_names(var_column_names rt.PhpVal) {
	this.column_names = rt.new_array()
	mut iter_1 := var_column_names.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_column_name := item_1.val
		mut var_column_id := item_1.key
		this.column_names.array_set(rt.call_function('wc_clean', [
			var_column_id.clone()]), rt.call_function('wc_clean', [
			var_column_name.clone()]))
	}
}

fn (mut this Class_WC_CSV_Exporter) get_columns_to_export() rt.PhpVal {
	return this.columns_to_export
}

fn (mut this Class_WC_CSV_Exporter) get_delimiter() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_'), this.export_type),
			rt.new_string('_export_delimiter')),
		this.delimiter,
	])
}

fn (mut this Class_WC_CSV_Exporter) set_columns_to_export(var_columns rt.PhpVal) {
	mut var_columns_mutated := var_columns
	this.columns_to_export = rt.call_function('array_map', [rt.new_string('wc_clean'),
		var_columns_mutated.clone()])
}

fn (mut this Class_WC_CSV_Exporter) is_column_exporting(var_column_id rt.PhpVal) bool {
	mut var_column_id_mutated := var_column_id
	var_column_id_mutated = if rt.is_true(rt.call_function('strstr', [
		var_column_id_mutated.clone(), rt.new_string(':')]))
	{ rt.call_function('current', [
			rt.call_function('explode', [rt.new_string(':'), var_column_id_mutated.clone()]),
		]) } else { var_column_id_mutated }
	mut var_columns_to_export := this.get_columns_to_export()
	if !rt.is_true(var_columns_to_export) {
		return true
	}
	if rt.is_true(rt.call_function('in_array', [var_column_id_mutated.clone(), var_columns_to_export.clone(), rt.new_bool(true)]))
		|| rt.is_true(rt.identical(rt.new_string('meta'), var_column_id_mutated)) {
		return true
	}
	return false
}

fn (mut this Class_WC_CSV_Exporter) get_default_column_names() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WC_CSV_Exporter) export() {
	this.prepare_data_to_export()
	this.send_headers()
	this.send_content(rt.new_string((rt.call_function('chr', [rt.new_int(239)])).str() +
		(rt.call_function('chr', [rt.new_int(187)])).str() +
		(rt.call_function('chr', [rt.new_int(191)])).str() +
		(this.export_column_headers()).str() + (this.get_csv_data()).str()))
	exit(0)
}

fn (mut this Class_WC_CSV_Exporter) send_headers() {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gc_enable')])) {
		rt.call_function('gc_enable', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('apache_setenv')])) {
		rt.call_function('apache_setenv', [rt.new_string('no-gzip'),
			rt.new_int(1)])
	}
	rt.call_function('ini_set', [rt.new_string('zlib.output_compression'),
		rt.new_string('Off')])
	rt.call_function('ini_set', [rt.new_string('output_buffering'),
		rt.new_string('Off')])
	rt.call_function('ini_set', [rt.new_string('output_handler'),
		rt.new_string('')])
	rt.call_function('ignore_user_abort', [rt.new_bool(true)])
	rt.call_function('wc_set_time_limit', [rt.new_int(0)])
	rt.call_function('wc_nocache_headers', []rt.PhpVal{})
	rt.call_function('header', [rt.new_string('Content-Type: text/csv; charset=utf-8')])
	rt.call_function('header', [
		rt.new_string('Content-Disposition: attachment; filename=' + (this.get_filename()).str()),
	])
	rt.call_function('header', [rt.new_string('Pragma: no-cache')])
	rt.call_function('header', [rt.new_string('Expires: 0')])
}

fn (mut this Class_WC_CSV_Exporter) set_filename(var_filename rt.PhpVal) {
	this.filename = rt.call_function('sanitize_file_name', [
		rt.new_string(
			(rt.call_function('str_replace', [rt.new_string('.csv'), rt.new_string(''), var_filename.clone()])).str() +
			'.csv'),
	])
}

fn (mut this Class_WC_CSV_Exporter) get_filename() rt.PhpVal {
	return rt.call_function('sanitize_file_name', [
		rt.call_function('apply_filters', [
			rt.concat(rt.concat(rt.new_string('woocommerce_'), this.export_type),
				rt.new_string('_export_get_filename')),
			this.filename,
		]),
	])
}

fn (mut this Class_WC_CSV_Exporter) send_content(var_csv_data rt.PhpVal) {
	rt.echo_val(var_csv_data)
}

fn (mut this Class_WC_CSV_Exporter) get_csv_data() rt.PhpVal {
	return this.export_rows()
}

fn (mut this Class_WC_CSV_Exporter) export_column_headers() rt.PhpVal {
	mut var_columns := this.get_column_names()
	mut var_export_row := rt.new_array()
	mut var_buffer := rt.call_function('fopen', [rt.new_string('php://output'),
		rt.new_string('w')])
	rt.call_function('ob_start', []rt.PhpVal{})
	mut iter_2 := var_columns.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_column_name := item_2.val
		mut var_column_id := item_2.key
		if !(this.is_column_exporting(var_column_id.clone())) {
			continue
		}
		var_export_row << this.format_data(var_column_name.clone())
	}
	this.fputcsv(var_buffer.clone(), var_export_row.clone())
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_CSV_Exporter) get_data_to_export() rt.PhpVal {
	return this.row_data
}

fn (mut this Class_WC_CSV_Exporter) export_rows() rt.PhpVal {
	mut var_data := this.get_data_to_export()
	mut var_buffer := rt.call_function('fopen', [rt.new_string('php://output'),
		rt.new_string('w')])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('array_walk', [var_data.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_CSV_Exporter', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'export_row' },
		]),
		var_buffer.clone()])
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_'), this.export_type),
			rt.new_string('_export_rows')),
		rt.call_function('ob_get_clean', []rt.PhpVal{}),
		rt.new_object('WC_CSV_Exporter', []string{}, &this),
	])
}

fn (mut this Class_WC_CSV_Exporter) export_row(var_row_data rt.PhpVal, var_key rt.PhpVal, var_buffer rt.PhpVal) {
	mut var_buffer_mutated := var_buffer
	mut var_columns := this.get_column_names()
	mut var_export_row := rt.new_array()
	mut iter_3 := var_columns.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_column_name := item_3.val
		mut var_column_id := item_3.key
		if !(this.is_column_exporting(var_column_id.clone())) {
			continue
		}
		if var_row_data.array_isset(var_column_id) {
			var_export_row << this.format_data(var_row_data.array_get(var_column_id))
		} else {
			var_export_row << rt.new_string('')
		}
	}
	this.fputcsv(var_buffer_mutated.clone(), var_export_row.clone())
	rt.pre_inc(this.exported_row_count)
}

fn (mut this Class_WC_CSV_Exporter) get_limit() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_'), this.export_type),
			rt.new_string('_export_batch_limit')),
		this.limit,
		rt.new_object('WC_CSV_Exporter', []string{}, &this),
	])
}

fn (mut this Class_WC_CSV_Exporter) set_limit(var_limit rt.PhpVal) {
	this.limit = rt.call_function('absint', [var_limit.clone()])
}

fn (mut this Class_WC_CSV_Exporter) get_total_exported() rt.PhpVal {
	return this.exported_row_count
}

fn (mut this Class_WC_CSV_Exporter) escape_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_active_content_triggers := [rt.new_string('='), rt.new_string('+'),
		rt.new_string('-'), rt.new_string('@'), rt.call_function('chr', [
			rt.new_int(9)]),
		rt.call_function('chr', [rt.new_int(13)])]
	if var_data_mutated.clone().is_long() || var_data_mutated.clone().is_double() {
		return var_data_mutated.clone()
	}
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('mb_substr', [var_data_mutated.clone(),
			rt.new_int(0), rt.new_int(1)]),
		rt.create_array_from_list(var_active_content_triggers),
		rt.new_bool(true),
	]))
	{
		var_data_mutated = rt.new_string("'" + var_data_mutated.str())
	}
	return var_data_mutated.clone()
}

fn (mut this Class_WC_CSV_Exporter) format_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [
		var_data_mutated.clone()])))))
	{
		if rt.is_true(rt.call_function('is_a', [var_data_mutated.clone(),
			rt.new_string('WC_Datetime')]))
		{
			var_data_mutated = rt.call_method(var_data_mutated, 'date', [
				rt.new_string('Y-m-d G:i:s'),
			])
		} else {
			var_data_mutated = rt.new_string('')
		}
	} else if rt.is_true(rt.new_bool(var_data_mutated.clone().is_bool())) {
		var_data_mutated = rt.new_int(if rt.is_true(var_data_mutated) { 1 } else { 0 })
	}
	mut var_use_mb := rt.call_function('function_exists', [
		rt.new_string('mb_convert_encoding'),
	])
	if rt.is_true(var_use_mb) {
		mut var_is_valid_utf_8 := rt.call_function('mb_check_encoding', [
			var_data_mutated.clone(), rt.new_string('UTF-8')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_valid_utf_8)))) {
			var_data_mutated = rt.call_function('mb_convert_encoding', [
				var_data_mutated.clone(), rt.new_string('UTF-8'),
				rt.new_string('ISO-8859-1')])
		}
	}
	return this.escape_data(var_data_mutated.clone())
}

fn (mut this Class_WC_CSV_Exporter) format_term_ids(var_term_ids rt.PhpVal, var_taxonomy rt.PhpVal) string {
	mut var_term_ids_mutated := var_term_ids
	var_term_ids_mutated = rt.call_function('wp_parse_id_list', [
		var_term_ids_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_term_ids_mutated.clone().array_count()))))) {
		return ''
	}
	mut var_formatted_terms := rt.new_array()
	if rt.is_true(rt.call_function('is_taxonomy_hierarchical', [
		var_taxonomy.clone()]))
	{
		mut iter_4 := var_term_ids_mutated.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_term_id := item_4.val
			mut var_formatted_term := rt.new_array()
			mut var_ancestor_ids := rt.call_function('array_reverse', [
				rt.call_function('get_ancestors', [var_term_id.clone(),
					var_taxonomy.clone()]),
			])
			mut iter_5 := var_ancestor_ids.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_ancestor_id := item_5.val
				mut var_term := rt.call_function('get_term', [
					var_ancestor_id.clone(), var_taxonomy.clone()])
				if rt.is_true(var_term)
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
					var_formatted_term << rt.get_property(var_term, 'name')
				}
			}
			mut var_term := rt.call_function('get_term', [var_term_id.clone(),
				var_taxonomy.clone()])
			if rt.is_true(var_term)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
				var_formatted_term << rt.get_property(var_term, 'name')
			}
			var_formatted_terms << rt.call_function('implode', [
				rt.new_string(' > '), rt.create_array_from_list(var_formatted_term)])
		}
	} else {
		mut iter_6 := var_term_ids_mutated.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_term_id := item_6.val
			mut var_term := rt.call_function('get_term', [var_term_id.clone(),
				var_taxonomy.clone()])
			if rt.is_true(var_term)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
				var_formatted_terms << rt.get_property(var_term, 'name')
			}
		}
	}
	return (this.implode_values(var_formatted_terms.clone())).str()
}

fn (mut this Class_WC_CSV_Exporter) implode_values(var_values rt.PhpVal) rt.PhpVal {
	mut var_values_to_implode := rt.new_array()
	mut iter_7 := var_values.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_value := item_7.val
		var_value = if rt.is_true((rt.call_function('is_scalar', [
			var_value.clone()])).str())
		{ rt.call_function('html_entity_decode', [var_value.clone(),
				rt.get_constant('ENT_QUOTES')]) } else { rt.new_string('') }
		var_values_to_implode << rt.call_function('str_replace', [
			rt.new_string(','), rt.new_string('\\,'), var_value.clone()])
	}
	return rt.call_function('implode', [rt.new_string(', '),
		rt.create_array_from_list(var_values_to_implode)])
}

fn (mut this Class_WC_CSV_Exporter) fputcsv(var_buffer rt.PhpVal, var_export_row rt.PhpVal) {
	mut var_buffer_mutated := var_buffer
	mut var_export_row_mutated := var_export_row
	rt.call_function('fputcsv', [var_buffer_mutated.clone(), var_export_row_mutated.clone(),
		this.get_delimiter(), rt.new_string('"'), rt.new_string('')])
}

fn create_wc_csv_exporter(_args ...rt.PhpVal) &Class_WC_CSV_Exporter {
	mut obj := &Class_WC_CSV_Exporter{
		PhpObjectBase:      rt.PhpObjectBase{}
		export_type:        rt.new_string('')
		filename:           rt.new_string('wc-export.csv')
		limit:              rt.new_int(50)
		exported_row_count: rt.new_int(0)
		row_data:           rt.new_array()
		total_rows:         rt.new_int(0)
		column_names:       rt.new_array()
		columns_to_export:  rt.new_array()
		delimiter:          rt.new_string(',')
	}
	return obj
}

fn (mut this Class_WC_CSV_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_data_to_export' {
			this.prepare_data_to_export()
			return rt.new_null()
		}
		'get_column_names' {
			return this.get_column_names()
		}
		'set_column_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_column_names(dispatch_arg_0)
			return rt.new_null()
		}
		'get_columns_to_export' {
			return this.get_columns_to_export()
		}
		'get_delimiter' {
			return this.get_delimiter()
		}
		'set_columns_to_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_columns_to_export(dispatch_arg_0)
			return rt.new_null()
		}
		'is_column_exporting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_column_exporting(dispatch_arg_0))
		}
		'get_default_column_names' {
			return this.get_default_column_names()
		}
		'export' {
			this.export()
			return rt.new_null()
		}
		'send_headers' {
			this.send_headers()
			return rt.new_null()
		}
		'set_filename' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_filename(dispatch_arg_0)
			return rt.new_null()
		}
		'get_filename' {
			return this.get_filename()
		}
		'send_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.send_content(dispatch_arg_0)
			return rt.new_null()
		}
		'get_csv_data' {
			return this.get_csv_data()
		}
		'export_column_headers' {
			return this.export_column_headers()
		}
		'get_data_to_export' {
			return this.get_data_to_export()
		}
		'export_rows' {
			return this.export_rows()
		}
		'export_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.export_row(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_limit' {
			return this.get_limit()
		}
		'set_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_limit(dispatch_arg_0)
			return rt.new_null()
		}
		'get_total_exported' {
			return this.get_total_exported()
		}
		'escape_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.escape_data(dispatch_arg_0)
		}
		'format_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_data(dispatch_arg_0)
		}
		'format_term_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.format_term_ids(dispatch_arg_0, dispatch_arg_1))
		}
		'implode_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.implode_values(dispatch_arg_0)
		}
		'fputcsv' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.fputcsv(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_CSV_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'export_type' { return this.export_type }
		'filename' { return this.filename }
		'limit' { return this.limit }
		'exported_row_count' { return this.exported_row_count }
		'row_data' { return this.row_data }
		'total_rows' { return this.total_rows }
		'column_names' { return this.column_names }
		'columns_to_export' { return this.columns_to_export }
		'delimiter' { return this.delimiter }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_CSV_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'export_type' {
			this.export_type = val
			return true
		}
		'filename' {
			this.filename = val
			return true
		}
		'limit' {
			this.limit = val
			return true
		}
		'exported_row_count' {
			this.exported_row_count = val
			return true
		}
		'row_data' {
			this.row_data = val
			return true
		}
		'total_rows' {
			this.total_rows = val
			return true
		}
		'column_names' {
			this.column_names = val
			return true
		}
		'columns_to_export' {
			this.columns_to_export = val
			return true
		}
		'delimiter' {
			this.delimiter = val
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
