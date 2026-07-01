import rt

struct Class_WC_Product_CSV_Importer {
	rt.PhpObjectBase
pub mut:
		parsing_raw_data_index rt.PhpVal = rt.new_int(0)
		cogs_is_enabled rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_Product_CSV_Importer) construct(var_file rt.PhpVal, var_params rt.PhpVal)  {
	this.cogs_is_enabled = rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})
	mut var_default_args := { 'start_pos': rt.new_int(0), 'end_pos': // unsupported expression: Expr_UnaryMinus, 'lines': // unsupported expression: Expr_UnaryMinus, 'mapping': map[string]rt.PhpVal{}, 'parse': rt.new_bool(false), 'update_existing': rt.new_bool(false), 'delimiter': rt.new_string(','), 'prevent_timeouts': rt.new_bool(true), 'enclosure': rt.new_string('"'), 'escape': rt.new_string('') }
	this.dispatch_set_prop('params', rt.call_function('wp_parse_args', [var_params.dup(), var_default_args.dup()]))
	this.dispatch_set_prop('file', var_file.dup())
	if rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('mapping').array_isset(rt.new_string('from')) && rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('mapping').array_isset(rt.new_string('to')) {
		rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_set('mapping', rt.call_function('array_combine', [rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('mapping').array_get('from'), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('mapping').array_get('to')]))
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/admin/importers/mappings/mappings.php', '2')
	this.read_file()
}

fn (mut this Class_WC_Product_CSV_Importer) adjust_character_encoding(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_encoding := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('character_encoding')
	return if rt.is_true(rt.identical(rt.new_string('UTF-8'), var_encoding)) { var_value_mutated } else { rt.call_function('mb_convert_encoding', [var_value_mutated.dup(), rt.new_string('UTF-8'), var_encoding.dup()]) }
}

fn (mut this Class_WC_Product_CSV_Importer) read_file()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Product_CSV_Importer_Controller{}; return temp.is_file_valid_csv(arg_0) }(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'file')))))) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Invalid file type. The importer supports CSV and TXT file formats.'), rt.new_string('woocommerce')])])
	}
	mut var_handle := rt.call_function('fopen', [rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'file'), rt.new_string('r')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.dispatch_set_prop('raw_keys', rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('fgetcsv', [var_handle.dup(), rt.new_int(0), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('delimiter'), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('enclosure'), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('escape')])]))
		if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.is_truthy(arg_0, arg_1) }(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params'), rt.new_string('character_encoding'))) {
			this.dispatch_set_prop('raw_keys', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'adjust_character_encoding' }]), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys')]))
		}
		this.dispatch_set_prop('raw_keys', rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys')])]))
		if rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').array_isset(rt.new_int(0)) {
			rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').array_set(0, this.remove_utf8_bom(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').array_get(0)))
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('fseek', [var_handle.dup(), // unsupported expression: Expr_Cast_Int])
		}
		for rt.is_true(rt.new_int(1)) {
			mut var_row := rt.call_function('fgetcsv', [var_handle.dup(), rt.new_int(0), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('delimiter'), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('enclosure'), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('escape')])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.is_truthy(arg_0, arg_1) }(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params'), rt.new_string('character_encoding'))) {
					var_row = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'adjust_character_encoding' }]), var_row.dup()])
				}
				rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_push(var_row.dup())
				rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'file_positions').array_set(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_count(), rt.call_function('ftell', [var_handle.dup()]))
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.greater(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('end_pos'), rt.new_int(0))) && rt.is_true(rt.greater_equal(rt.call_function('ftell', [var_handle.dup()]), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('end_pos'))))) || rt.is_true(rt.identical(rt.new_int(0), rt.pre_dec(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('lines')))))) {
					break
				}
			} else {
				break
			}
		}
		this.dispatch_set_prop('file_position', rt.call_function('ftell', [var_handle.dup()]))
	}
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('mapping'))) {
		this.set_mapped_keys()
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('parse')) {
		this.set_parsed_data()
	}
}

fn (mut this Class_WC_Product_CSV_Importer) remove_utf8_bom(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
	if rt.is_true(rt.identical(rt.new_string('efbbbf'), rt.call_function('substr', [rt.call_function('bin2hex', [var_string_mutated.dup()]), rt.new_int(0), rt.new_int(6)]))) {
		var_string_mutated = rt.call_function('substr', [var_string_mutated.dup(), rt.new_int(3)])
	}
	return var_string_mutated.dup()
}

fn (mut this Class_WC_Product_CSV_Importer) set_mapped_keys()  {
	mut var_mapping := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('mapping')
	{
		mut iter_1 := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'mapped_keys').array_push(if var_mapping.array_isset(var_key) { var_mapping.array_get(var_key) } else { var_key })
		}
	}
}

fn (mut this Class_WC_Product_CSV_Importer) parse_relative_field(var_value rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_value_mutated := var_value
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_value_mutated) {
		return ''
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^id:(\\d+)$/'), var_value_mutated.dup(), var_matches.dup()])) {
		mut var_id := rt.new_int(rt.new_int(var_matches.array_get(1).to_i64()))
		mut var_original_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_original_id\' AND meta_value = %s;')), var_id.dup()])])
		if rt.is_true(var_original_id) {
			return (rt.call_function('absint', [var_original_id.dup()])).str()
		}
		mut var_existing_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type IN ( \'product\', \'product_variation\' ) AND ID = %d;')), var_id.dup()])])
		if rt.is_true(var_existing_id) {
			return (rt.call_function('absint', [var_existing_id.dup()])).str()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('update_existing'))))) {
			mut var_product := rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.simple()])
			rt.call_method(var_product, 'set_name', ['Import placeholder for ' + (var_id).str()])
			rt.call_method(var_product, 'set_status', [rt.new_string('importing')])
			rt.call_method(var_product, 'add_meta_data', [rt.new_string('_original_id'), var_id.dup(), rt.new_bool(true)])
			var_id = rt.call_method(var_product, 'save', []rt.PhpVal{})
		}
		return (var_id).str()
	}
	var_id = rt.call_function('wc_get_product_id_by_sku', [var_value_mutated.dup()])
	if rt.is_true(var_id) {
		return (var_id).str()
	}
	var_product = rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.simple()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_product, 'set_name', ['Import placeholder for ' + (var_value_mutated).str()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_product, 'set_status', [rt.new_string('importing')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_product, 'set_sku', [var_value_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_id = rt.call_method(var_product, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(rt.is_true(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.dup()]))))))) {
		return (var_id).str()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return ''
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return ''
}

fn (mut this Class_WC_Product_CSV_Importer) parse_id_field(var_value rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_value_mutated := var_value
	// unsupported statement: Stmt_Global
	mut var_id := rt.call_function('absint', [var_value_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return 0
	}
	mut var_original_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_original_id\' AND meta_value = %s;')), var_id.dup()])])
	if rt.is_true(var_original_id) {
		return (rt.call_function('absint', [var_original_id.dup()])).to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get('update_existing'))))) {
		mut var_mapped_keys := this.get_mapped_keys()
		mut var_sku_column_index := rt.call_function('absint', [rt.call_function('array_search', [rt.new_string('sku'), var_mapped_keys.dup(), rt.new_bool(true)])])
		mut var_row_sku := if rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_get(this.parsing_raw_data_index).array_isset(var_sku_column_index) { rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_get(this.parsing_raw_data_index).array_get(var_sku_column_index) } else { rt.new_string('') }
		mut var_id_from_sku := if rt.is_true(var_row_sku) { rt.call_function('wc_get_product_id_by_sku', [var_row_sku.dup()]) } else { rt.new_string('') }
		if rt.is_true(var_id_from_sku) {
			return (var_id_from_sku).to_i64()
		}
		mut var_product := rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.simple()])
		rt.call_method(var_product, 'set_name', ['Import placeholder for ' + (var_id).str()])
		rt.call_method(var_product, 'set_status', [rt.new_string('importing')])
		rt.call_method(var_product, 'add_meta_data', [rt.new_string('_original_id'), var_id.dup(), rt.new_bool(true)])
		if rt.is_true(var_row_sku) {
			rt.call_method(var_product, 'set_sku', [var_row_sku.dup()])
		}
		var_id = rt.call_method(var_product, 'save', []rt.PhpVal{})
	}
	return (if rt.is_true(rt.new_bool(rt.is_true(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.dup()]))))))) { var_id } else { rt.new_int(0) }).to_i64()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_relative_comma_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	return rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_relative_field' }]), this.explode_values(var_value_mutated.dup())])])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_comma_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!rt.is_true(var_value_mutated) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return map[string]rt.PhpVal{}
	}
	var_value_mutated = this.unescape_data(var_value_mutated.dup())
	return rt.call_function('array_map', [rt.new_string('wc_clean'), this.explode_values(var_value_mutated.dup())])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_bool_field(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('0'), var_value_mutated)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('1'), var_value_mutated)) {
		return true
	}
	return (rt.call_function('wc_clean', [var_value_mutated.dup()])).to_bool()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_float_field(var_value rt.PhpVal) f64 {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return (var_value_mutated).to_f64()
	}
	var_value_mutated = this.unescape_data(var_value_mutated.dup())
	return var_value_mutated.dup().to_f64()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_stock_quantity_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return var_value_mutated.dup()
	}
	var_value_mutated = this.unescape_data(var_value_mutated.dup())
	return rt.call_function('wc_stock_amount', [var_value_mutated.dup()])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_tax_status_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return var_value_mutated.dup()
	}
	var_value_mutated = this.unescape_data(.dup())
	if rt.is_true(rt.new_bool(rt.is_true() || rt.is_true())) {
		
	}
	return 
}

fn (mut this Class_WC_Product_CSV_Importer) parse_categories_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_tags_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_tags_spaces_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_shipping_class_field(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_images_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_date_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_datetime_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_backorders_field(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_skip_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_download_file_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_int_field(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_description_field(var_description rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product_CSV_Importer) parse_published_field(var_value rt.PhpVal) f64 {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) parse_cogs_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_CSV_Importer) get_formating_callback() rt.PhpVal {
}

fn (mut this Class_WC_Product_CSV_Importer) get_formatting_callback() rt.PhpVal {
}

fn (mut this Class_WC_Product_CSV_Importer) starts_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product_CSV_Importer) expand_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_WC_Product_CSV_Importer) set_parsed_data()  {
}

fn (mut this Class_WC_Product_CSV_Importer) get_row_id(var_parsed_data rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product_CSV_Importer) import() rt.PhpVal {
}

struct Class_WC_Product_Importer {
	rt.PhpObjectBase
}

struct Class_WC_Product_CSV_Importer_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn create_wc_product_csv_importer(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WC_Product_CSV_Importer {
	mut obj := &Class_WC_Product_CSV_Importer{
		PhpObjectBase: rt.PhpObjectBase{}
		parsing_raw_data_index: rt.new_int(0)
		cogs_is_enabled: rt.new_bool(false)
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wc_product_importer() &Class_WC_Product_Importer {
	mut obj := &Class_WC_Product_Importer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_csv_importer_controller() &Class_WC_Product_CSV_Importer_Controller {
	mut obj := &Class_WC_Product_CSV_Importer_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_CSV_Importer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'adjust_character_encoding' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.adjust_character_encoding(dispatch_arg_0)
		}
		'read_file' {
			this.read_file()
			return rt.new_null()
		}
		'remove_utf8_bom' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_utf8_bom(dispatch_arg_0)
		}
		'set_mapped_keys' {
			this.set_mapped_keys()
			return rt.new_null()
		}
		'parse_relative_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parse_relative_field(dispatch_arg_0))
		}
		'parse_id_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.parse_id_field(dispatch_arg_0))
		}
		'parse_relative_comma_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_relative_comma_field(dispatch_arg_0)
		}
		'parse_comma_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_comma_field(dispatch_arg_0)
		}
		'parse_bool_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.parse_bool_field(dispatch_arg_0))
		}
		'parse_float_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(this.parse_float_field(dispatch_arg_0))
		}
		'parse_stock_quantity_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_stock_quantity_field(dispatch_arg_0)
		}
		'parse_tax_status_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_tax_status_field(dispatch_arg_0)
		}
		'parse_categories_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_categories_field(dispatch_arg_0)
		}
		'parse_tags_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_tags_field(dispatch_arg_0)
		}
		'parse_tags_spaces_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_tags_spaces_field(dispatch_arg_0)
		}
		'parse_shipping_class_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.parse_shipping_class_field(dispatch_arg_0))
		}
		'parse_images_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_images_field(dispatch_arg_0)
		}
		'parse_date_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_date_field(dispatch_arg_0)
		}
		'parse_datetime_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_datetime_field(dispatch_arg_0)
		}
		'parse_backorders_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parse_backorders_field(dispatch_arg_0))
		}
		'parse_skip_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_skip_field(dispatch_arg_0)
		}
		'parse_download_file_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_download_file_field(dispatch_arg_0)
		}
		'parse_int_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.parse_int_field(dispatch_arg_0))
		}
		'parse_description_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_description_field(dispatch_arg_0)
		}
		'parse_published_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_float(this.parse_published_field(dispatch_arg_0))
		}
		'parse_cogs_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_cogs_field(dispatch_arg_0)
		}
		'get_formating_callback' {
			return this.get_formating_callback()
		}
		'get_formatting_callback' {
			return this.get_formatting_callback()
		}
		'starts_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.starts_with(dispatch_arg_0, dispatch_arg_1)
		}
		'expand_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.expand_data(dispatch_arg_0)
		}
		'set_parsed_data' {
			this.set_parsed_data()
			return rt.new_null()
		}
		'get_row_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_row_id(dispatch_arg_0)
		}
		'import' {
			return this.import()
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_CSV_Importer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parsing_raw_data_index' { return this.parsing_raw_data_index }
		'cogs_is_enabled' { return this.cogs_is_enabled }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_CSV_Importer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parsing_raw_data_index' { this.parsing_raw_data_index = val; return true }
		'cogs_is_enabled' { this.cogs_is_enabled = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Product_Importer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Importer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Importer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_import_class_wc_product_csv_importer_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_Importer'), rt.new_bool(false)]))))) {
		rt.include_file(@DIR + '/abstract-wc-product-importer.php', '2')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_CSV_Importer_Controller'), rt.new_bool(false)]))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/importers/class-wc-product-csv-importer-controller.php', '2')
	}
}
