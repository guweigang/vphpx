import rt

struct Class_WC_Product_CSV_Importer {
	rt.PhpObjectBase
pub mut:
		parsing_raw_data_index rt.PhpVal = rt.new_int(0)
		cogs_is_enabled rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_Product_CSV_Importer) construct(var_file rt.PhpVal, var_params rt.PhpVal) {
	this.cogs_is_enabled = rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class()]), 'feature_is_enabled', []rt.PhpVal{})
	mut var_default_args := { 'start_pos': rt.new_int(0), 'end_pos': -1, 'lines': -1, 'mapping': map[string]rt.PhpVal{}, 'parse': rt.new_bool(false), 'update_existing': rt.new_bool(false), 'delimiter': rt.new_string(','), 'prevent_timeouts': rt.new_bool(true), 'enclosure': rt.new_string('"'), 'escape': rt.new_string('') }
	this.dispatch_set_prop('params', rt.call_function('wp_parse_args', [var_params.clone(), rt.create_array_from_native_map(var_default_args)]))
	this.dispatch_set_prop('file', var_file.clone())
	if rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('mapping')).array_isset(rt.new_string('from')) && rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('mapping')).array_isset(rt.new_string('to')) {
		rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_set('mapping', rt.call_function('array_combine', [rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('mapping')).array_get(rt.new_string('from')), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('mapping')).array_get(rt.new_string('to'))]))
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/admin/importers/mappings/mappings.php', '2')
	this.read_file()
}

fn (mut this Class_WC_Product_CSV_Importer) adjust_character_encoding(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_encoding := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('character_encoding'))
	return if rt.is_true(rt.identical(rt.new_string('UTF-8'), var_encoding)) { var_value_mutated } else { rt.call_function('mb_convert_encoding', [var_value_mutated.clone(), rt.new_string('UTF-8'), var_encoding.clone()]) }
}

fn (mut this Class_WC_Product_CSV_Importer) read_file() {
	mut iife_temp_0 := Class_WC_Product_CSV_Importer_Controller{}
	mut iife_result_0 := iife_temp_0.is_file_valid_csv(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'file'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Invalid file type. The importer supports CSV and TXT file formats.'), rt.new_string('woocommerce')])])
	}
	mut var_handle := rt.call_function('fopen', [rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'file'), rt.new_string('r')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_handle)))) {
		this.dispatch_set_prop('raw_keys', rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('fgetcsv', [var_handle.clone(), rt.new_int(0), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('delimiter')), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('enclosure')), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('escape'))])]))
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_1 := iife_temp_1.is_truthy(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params'), rt.new_string('character_encoding'))
		if rt.is_true(iife_result_1) {
			this.dispatch_set_prop('raw_keys', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'adjust_character_encoding' }]), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys')]))
		}
		this.dispatch_set_prop('raw_keys', rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys')])]))
		if rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').array_isset(rt.new_int(0)) {
			rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').array_set(0, this.remove_utf8_bom(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').array_get(rt.new_int(0))))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('start_pos')))))) {
			rt.call_function('fseek', [var_handle.clone(), rt.new_int((rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('start_pos'))).to_i64())])
		}
		for rt.is_true(rt.new_int(1)) {
			mut var_row := rt.call_function('fgetcsv', [var_handle.clone(), rt.new_int(0), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('delimiter')), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('enclosure')), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('escape'))])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_row)))) {
				mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
				mut iife_result_2 := iife_temp_2.is_truthy(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params'), rt.new_string('character_encoding'))
				if rt.is_true(iife_result_2) {
				var_row = rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'adjust_character_encoding' }]), var_row.clone()])
				}
				rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_push(var_row.clone())
				rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'file_positions').array_set(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_count(), rt.call_function('ftell', [var_handle.clone()]))
				if (rt.is_true(rt.greater(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('end_pos')), rt.new_int(0))) && rt.is_true(rt.greater_equal(rt.call_function('ftell', [var_handle.clone()]), rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('end_pos'))))) || rt.is_true(rt.identical(rt.new_int(0), rt.pre_dec(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('lines'))))) {
					break
				}
			} else {
				break
			}
		}
		this.dispatch_set_prop('file_position', rt.call_function('ftell', [var_handle.clone()]))
	}
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('mapping')))) {
		this.set_mapped_keys()
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('parse'))) {
		this.set_parsed_data()
	}
}

fn (mut this Class_WC_Product_CSV_Importer) remove_utf8_bom(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
	if rt.is_true(rt.identical(rt.new_string('efbbbf'), rt.call_function('substr', [rt.call_function('bin2hex', [var_string_mutated.clone()]), rt.new_int(0), rt.new_int(6)]))) {
	var_string_mutated = rt.call_function('substr', [var_string_mutated.clone(), rt.new_int(3)])
	}
	return var_string_mutated.clone()
}

fn (mut this Class_WC_Product_CSV_Importer) set_mapped_keys() {
	mut var_mapping := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('mapping'))
	mut iter_1 := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_keys').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'mapped_keys').array_push(if var_mapping.array_isset(var_key) { var_mapping.array_get(var_key) } else { var_key })
	}
}

fn (mut this Class_WC_Product_CSV_Importer) parse_relative_field(var_value rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return ''
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^id:(\\d+)$/'), var_value_mutated.clone(), rt.create_array_from_list(var_matches)])) {
		mut var_id := rt.new_int(var_matches.array_get(rt.new_int(1)).to_i64())
		mut var_original_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_original_id\' AND meta_value = %s;')), var_id.clone()])])
		if rt.is_true(var_original_id) {
			return (rt.call_function('absint', [var_original_id.clone()])).str()
		}
		mut var_existing_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type IN ( \'product\', \'product_variation\' ) AND ID = %d;')), var_id.clone()])])
		if rt.is_true(var_existing_id) {
			return (rt.call_function('absint', [var_existing_id.clone()])).str()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('update_existing')))))) {
			mut var_product := rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.simple()])
			rt.call_method(var_product, 'set_name', [rt.new_string('Import placeholder for ' + (var_id).str())])
			rt.call_method(var_product, 'set_status', [rt.new_string('importing')])
			rt.call_method(var_product, 'add_meta_data', [rt.new_string('_original_id'), var_id.clone(), rt.new_bool(true)])
		var_id = rt.call_method(var_product, 'save', []rt.PhpVal{})
		}
		return (var_id).str()
	}
	var_id = rt.call_function('wc_get_product_id_by_sku', [var_value_mutated.clone()])
	if rt.is_true(var_id) {
		return (var_id).str()
	}
	var_product = rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.simple()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_product, 'set_name', [rt.new_string('Import placeholder for ' + (var_value_mutated).str())])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_product, 'set_status', [rt.new_string('importing')])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	rt.call_method(var_product, 'set_sku', [var_value_mutated.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_id = rt.call_method(var_product, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.clone()]))))) {
		return (var_id).str()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
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
	mut var_id := rt.call_function('absint', [var_value_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return 0
	}
	mut var_original_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_id FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = \'_original_id\' AND meta_value = %s;')), var_id.clone()])])
	if rt.is_true(var_original_id) {
		return (rt.call_function('absint', [var_original_id.clone()])).to_i64()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('update_existing')))))) {
		mut var_mapped_keys := this.get_mapped_keys()
		mut var_sku_column_index := rt.call_function('absint', [rt.call_function('array_search', [rt.new_string('sku'), var_mapped_keys.clone(), rt.new_bool(true)])])
		mut var_row_sku := if rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_get(this.parsing_raw_data_index).array_isset(var_sku_column_index) { rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').array_get(this.parsing_raw_data_index).array_get(var_sku_column_index) } else { rt.new_string('') }
		mut var_id_from_sku := if rt.is_true(var_row_sku) { rt.call_function('wc_get_product_id_by_sku', [var_row_sku.clone()]) } else { rt.new_string('') }
		if rt.is_true(var_id_from_sku) {
			return (var_id_from_sku).to_i64()
		}
		mut var_product := rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.simple()])
		rt.call_method(var_product, 'set_name', [rt.new_string('Import placeholder for ' + (var_id).str())])
		rt.call_method(var_product, 'set_status', [rt.new_string('importing')])
		rt.call_method(var_product, 'add_meta_data', [rt.new_string('_original_id'), var_id.clone(), rt.new_bool(true)])
		if rt.is_true(var_row_sku) {
			rt.call_method(var_product, 'set_sku', [var_row_sku.clone()])
		}
	var_id = rt.call_method(var_product, 'save', []rt.PhpVal{})
	}
	return (if rt.is_true(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.clone()]))))) { var_id } else { rt.new_int(0) }).to_i64()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_relative_comma_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	return rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_relative_field' }]), this.explode_values(var_value_mutated.clone())])])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_comma_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0'), var_value_mutated)))) {
		return map[string]rt.PhpVal{}
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	return rt.call_function('array_map', [rt.new_string('wc_clean'), this.explode_values(var_value_mutated.clone())])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_bool_field(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('0'), var_value_mutated)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('1'), var_value_mutated)) {
		return true
	}
	return (rt.call_function('wc_clean', [var_value_mutated.clone()])).to_bool()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_float_field(var_value rt.PhpVal) f64 {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return (var_value_mutated).to_f64()
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	return var_value_mutated.clone().to_f64()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_stock_quantity_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return var_value_mutated.clone()
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	return rt.call_function('wc_stock_amount', [var_value_mutated.clone()])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_tax_status_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return var_value_mutated.clone()
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	if rt.is_true(rt.identical(rt.new_string('true'), rt.new_string(var_value_mutated.clone().to_string().to_lower()))) || rt.is_true(rt.identical(rt.new_string('false'), rt.new_string(var_value_mutated.clone().to_string().to_lower()))) {
	var_value_mutated = if rt.is_true(rt.call_function('wc_string_to_bool', [var_value_mutated.clone()])) { Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() } else { Class_Automattic_WooCommerce_Enums_ProductTaxStatus.none() }
	}
	return rt.call_function('wc_clean', [var_value_mutated.clone()])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_categories_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	mut var_row_terms := this.explode_values(var_value_mutated.clone())
	mut var_categories := map[string]rt.PhpVal{}
	mut iter_2 := var_row_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_row_term := item_2.val
		mut var_parent := rt.new_null()
		mut var__terms := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('>'), var_row_term.clone()])])
		mut var_total := rt.new_int(var__terms.clone().array_count())
		mut iter_3 := var__terms.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var__term := item_3.val
			mut var_index := item_3.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_product_terms')]))))) {
				break
			}
			mut var_term := rt.call_function('wp_insert_term', [var__term.clone(), rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'parent', val: var_parent.clone().to_i64() }])])
			if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
				if rt.is_true(rt.identical(rt.call_method(var_term, 'get_error_code', []rt.PhpVal{}), rt.new_string('term_exists'))) {
				mut var_term_id := rt.call_method(var_term, 'get_error_data', []rt.PhpVal{})
				} else {
					break
				}
			} else {
			var_term_id = var_term.array_get(rt.new_string('term_id'))
			}
			if rt.is_true(rt.identical(rt.add(rt.new_int(1), var_index), var_total)) {
				var_categories << var_term_id.clone()
			} else {
			var_parent = var_term_id.clone()
			}
		}
	}
	return var_categories.clone()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_tags_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	mut var_names := this.explode_values(var_value_mutated.clone())
	mut var_tags := map[string]rt.PhpVal{}
	mut iter_4 := var_names.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_name := item_4.val
		mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_name.clone(), rt.new_string('product_tag')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) || rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		var_term = rt.array_to_object(rt.call_function('wp_insert_term', [var_name.clone(), rt.new_string('product_tag')]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
			var_tags << rt.get_property(var_term, 'term_id')
		}
	}
	return var_tags.clone()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_tags_spaces_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	mut var_names := this.explode_values(var_value_mutated.clone(), rt.new_string(' '))
	mut var_tags := map[string]rt.PhpVal{}
	mut iter_5 := var_names.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_name := item_5.val
		mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_name.clone(), rt.new_string('product_tag')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) || rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		var_term = rt.array_to_object(rt.call_function('wp_insert_term', [var_name.clone(), rt.new_string('product_tag')]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
			var_tags << rt.get_property(var_term, 'term_id')
		}
	}
	return var_tags.clone()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_shipping_class_field(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return 0
	}
	mut var_term := rt.call_function('get_term_by', [rt.new_string('name'), var_value_mutated.clone(), rt.new_string('product_shipping_class')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) || rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
	var_term = rt.array_to_object(rt.call_function('wp_insert_term', [var_value_mutated.clone(), rt.new_string('product_shipping_class')]))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return 0
	}
	return (rt.get_property(var_term, 'term_id')).to_i64()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_images_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return map[string]rt.PhpVal{}
	}
	mut var_images := map[string]rt.PhpVal{}
	mut var_separator := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_import_image_separator'), rt.new_string(',')])
	mut iter_6 := this.explode_values(var_value_mutated.clone(), var_separator.clone()).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_image := item_6.val
		if rt.is_true(rt.call_function('stristr', [var_image.clone(), rt.new_string('://')])) {
			var_images.array_push(rt.call_function('esc_url_raw', [var_image.clone()]))
		} else {
			var_images.array_push(rt.call_function('sanitize_file_name', [var_image.clone()]))
		}
	}
	return var_images.clone()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_date_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])([ 01-9:]*)$/'), var_value_mutated.clone()])) {
		return rt.call_function('current', [rt.call_function('explode', [rt.new_string(' '), var_value_mutated.clone()])])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_datetime_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double())) {
		mut var_datetime := create_datetime(rt.new_string("@${var_value.to_string()}"))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		return var_datetime.format(rt.new_string('Y-m-d\\TH:i:s\\Z'))
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strtotime', [var_value_mutated.clone()]))))) {
		return var_value_mutated.clone()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_backorders_field(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	if !rt.is_true(var_value_mutated) {
		return 'no'
	}
	var_value_mutated = rt.new_bool(this.parse_bool_field(var_value_mutated.clone()))
	if rt.is_true(rt.identical(rt.new_string('notify'), var_value_mutated)) {
		return 'notify'
	} else if rt.is_true(rt.new_bool(var_value_mutated.clone().is_bool())) {
		return if rt.is_true(var_value_mutated) { 'yes' } else { 'no' }
	}
	return 'no'
}

fn (mut this Class_WC_Product_CSV_Importer) parse_skip_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return var_value_mutated.clone()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_download_file_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_value_mutated.clone(), rt.new_string('http')]))) {
		return rt.call_function('esc_url_raw', [var_value_mutated.clone()])
	}
	return rt.call_function('wc_clean', [var_value_mutated.clone()])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_int_field(var_value rt.PhpVal) i64 {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return (var_value_mutated).to_i64()
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	return var_value_mutated.clone().to_i64()
}

fn (mut this Class_WC_Product_CSV_Importer) parse_description_field(var_description rt.PhpVal) rt.PhpVal {
	mut var_parts := rt.call_function('explode', [rt.new_string('\\\\n'), var_description.clone()])
	mut iter_7 := var_parts.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_part := item_7.val
		mut var_key := item_7.key
		var_parts.array_set(var_key, rt.call_function('str_replace', [rt.new_string('\\n'), rt.new_string('\n'), var_part.clone()]))
	}
	return rt.call_function('implode', [rt.new_string('\\\\n'), var_parts.clone()])
}

fn (mut this Class_WC_Product_CSV_Importer) parse_published_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return var_value_mutated.clone()
	}
	var_value_mutated = this.unescape_data(var_value_mutated.clone())
	if rt.is_true(rt.identical(rt.new_string('true'), rt.new_string(var_value_mutated.clone().to_string().to_lower()))) || rt.is_true(rt.identical(rt.new_string('false'), rt.new_string(var_value_mutated.clone().to_string().to_lower()))) {
		return rt.new_int(if rt.is_true(rt.call_function('wc_string_to_bool', [var_value_mutated.clone()])) { 1 } else { -1 })
	}
	return rt.new_float(var_value_mutated.clone().to_f64())
}

fn (mut this Class_WC_Product_CSV_Importer) parse_cogs_field(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) { rt.new_null() } else { rt.new_float((rt.call_function('wc_format_decimal', [var_value_mutated.clone()])).to_f64()) }
}

fn (mut this Class_WC_Product_CSV_Importer) get_formating_callback() rt.PhpVal {
	return this.get_formatting_callback()
}

fn (mut this Class_WC_Product_CSV_Importer) get_formatting_callback() rt.PhpVal {
	mut var_data_formatting := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_id_field' }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_comma_field' }]) }, rt.ArrayItem{ key: 'published', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_published_field' }]) }, rt.ArrayItem{ key: 'featured', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_bool_field' }]) }, rt.ArrayItem{ key: 'date_on_sale_from', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_datetime_field' }]) }, rt.ArrayItem{ key: 'date_on_sale_to', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_datetime_field' }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_skip_field' }]) }, rt.ArrayItem{ key: 'short_description', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_description_field' }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_description_field' }]) }, rt.ArrayItem{ key: 'manage_stock', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_bool_field' }]) }, rt.ArrayItem{ key: 'low_stock_amount', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_stock_quantity_field' }]) }, rt.ArrayItem{ key: 'backorders', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_backorders_field' }]) }, rt.ArrayItem{ key: 'stock_status', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_bool_field' }]) }, rt.ArrayItem{ key: 'sold_individually', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_bool_field' }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_float_field' }]) }, rt.ArrayItem{ key: 'length', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_float_field' }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_float_field' }]) }, rt.ArrayItem{ key: 'weight', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_float_field' }]) }, rt.ArrayItem{ key: 'reviews_allowed', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_bool_field' }]) }, rt.ArrayItem{ key: 'purchase_note', val: 'wp_filter_post_kses' }, rt.ArrayItem{ key: 'price', val: 'wc_format_decimal' }, rt.ArrayItem{ key: 'regular_price', val: 'wc_format_decimal' }, rt.ArrayItem{ key: 'stock_quantity', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_stock_quantity_field' }]) }, rt.ArrayItem{ key: 'category_ids', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_categories_field' }]) }, rt.ArrayItem{ key: 'tag_ids', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_tags_field' }]) }, rt.ArrayItem{ key: 'tag_ids_spaces', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_tags_spaces_field' }]) }, rt.ArrayItem{ key: 'shipping_class_id', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_shipping_class_field' }]) }, rt.ArrayItem{ key: 'images', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_images_field' }]) }, rt.ArrayItem{ key: 'parent_id', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_relative_field' }]) }, rt.ArrayItem{ key: 'grouped_products', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_relative_comma_field' }]) }, rt.ArrayItem{ key: 'upsell_ids', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_relative_comma_field' }]) }, rt.ArrayItem{ key: 'cross_sell_ids', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_relative_comma_field' }]) }, rt.ArrayItem{ key: 'download_limit', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_int_field' }]) }, rt.ArrayItem{ key: 'download_expiry', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_int_field' }]) }, rt.ArrayItem{ key: 'product_url', val: 'esc_url_raw' }, rt.ArrayItem{ key: 'menu_order', val: 'intval' }, rt.ArrayItem{ key: 'tax_status', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_tax_status_field' }]) }, rt.ArrayItem{ key: 'cogs_value', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this) }, rt.ArrayItem{ key: none, val: 'parse_cogs_field' }]) }])
	mut var_regex_match_data_formatting := { '/attributes:value*/': map[string]rt.PhpVal{}, '/attributes:visible*/': map[string]rt.PhpVal{}, '/attributes:taxonomy*/': map[string]rt.PhpVal{}, '/downloads:url*/': map[string]rt.PhpVal{}, '/meta:*/': rt.new_string('wp_kses_post') }
	mut var_callbacks := map[string]rt.PhpVal{}
	mut iter_8 := this.get_mapped_keys().iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_heading := item_8.val
		mut var_index := item_8.key
		mut var_callback := rt.new_string('wc_clean')
		if var_data_formatting.array_isset(var_heading) {
		var_callback = var_data_formatting.array_get(var_heading)
		} else {
			for var_regex, var_callback_shadow in var_regex_match_data_formatting {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string(regex), var_heading.clone()])) {
					var_callback_shadow = var_callback_shadow.clone()
					break
				}
			}
		}
		var_callbacks << var_callback.clone()
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_importer_formatting_callbacks'), rt.create_array_from_list(var_callbacks), rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this)])
}

fn (mut this Class_WC_Product_CSV_Importer) starts_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.call_function('substr', [var_haystack.clone(), rt.new_int(0), rt.new_int(var_needle.clone().to_string().len)]), var_needle)
}

fn (mut this Class_WC_Product_CSV_Importer) expand_data(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	var_data_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_importer_pre_expand_data'), var_data_mutated.clone()])
	if var_data_mutated.array_isset(rt.new_string('images')) {
		mut var_images := var_data_mutated.array_get(rt.new_string('images'))
		var_data_mutated.array_set('raw_image_id', rt.call_function('array_shift', [var_images.clone()]))
		if !(!rt.is_true(var_images)) {
			var_data_mutated.array_set('raw_gallery_image_ids', var_images.clone())
		}
		var_data_mutated.array_unset(rt.new_string('images'))
	}
	if var_data_mutated.array_isset(rt.new_string('type')) {
		var_data_mutated.array_set('type', rt.call_function('array_map', [rt.new_string('strtolower'), var_data_mutated.array_get(rt.new_string('type'))]))
		var_data_mutated.array_set('virtual', rt.call_function('in_array', [rt.new_string('virtual'), var_data_mutated.array_get(rt.new_string('type')), rt.new_bool(true)]))
		var_data_mutated.array_set('downloadable', rt.call_function('in_array', [rt.new_string('downloadable'), var_data_mutated.array_get(rt.new_string('type')), rt.new_bool(true)]))
		var_data_mutated.array_set('type', rt.call_function('current', [rt.call_function('array_diff', [var_data_mutated.array_get(rt.new_string('type')), rt.create_array([rt.ArrayItem{ key: none, val: 'virtual' }, rt.ArrayItem{ key: none, val: 'downloadable' }])])]))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_data_mutated.array_get(rt.new_string('type')))))) {
			var_data_mutated.array_set('type', Class_Automattic_WooCommerce_Enums_ProductType.simple())
		}
	}
	if var_data_mutated.array_isset(rt.new_string('published')) {
		mut var_published := var_data_mutated.array_get(rt.new_string('published'))
		if rt.is_true(rt.new_bool(var_published.clone().is_double())) {
		var_published = rt.new_int((var_published).to_i64())
		}
		mut var_statuses := rt.create_array([rt.ArrayItem{ key: -1, val: Class_Automattic_WooCommerce_Enums_ProductStatus.draft() }, rt.ArrayItem{ key: 0, val: Class_Automattic_WooCommerce_Enums_ProductStatus.private() }, rt.ArrayItem{ key: 1, val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() }])
		var_data_mutated.array_set('status', if !(var_statuses.array_get(var_published)).is_null() { var_statuses.array_get(var_published) } else { Class_Automattic_WooCommerce_Enums_ProductStatus.draft() })
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), if !(var_data_mutated.array_get(rt.new_string('type'))).is_null() { var_data_mutated.array_get(rt.new_string('type')) } else { rt.new_null() })) && rt.is_true(rt.identical(-1, var_published)) {
			var_data_mutated.array_set('status', Class_Automattic_WooCommerce_Enums_ProductStatus.publish())
		}
		var_data_mutated.array_unset(rt.new_string('published'))
	}
	if var_data_mutated.array_isset(rt.new_string('stock_quantity')) {
		if rt.is_true(rt.identical(rt.new_string(''), var_data_mutated.array_get(rt.new_string('stock_quantity')))) {
			var_data_mutated.array_set('manage_stock', false)
			var_data_mutated.array_set('stock_status', if var_data_mutated.array_isset(rt.new_string('stock_status')) { var_data_mutated.array_get(rt.new_string('stock_status')) } else { rt.new_bool(true) })
		} else {
			var_data_mutated.array_set('manage_stock', true)
		}
	}
	if var_data_mutated.array_isset(rt.new_string('stock_status')) {
		if rt.is_true(rt.identical(rt.new_string('backorder'), var_data_mutated.array_get(rt.new_string('stock_status')))) {
			var_data_mutated.array_set('stock_status', Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder())
		} else {
			var_data_mutated.array_set('stock_status', if rt.is_true(var_data_mutated.array_get(rt.new_string('stock_status'))) { Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock() } else { Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() })
		}
	}
	if var_data_mutated.array_isset(rt.new_string('grouped_products')) {
		var_data_mutated.array_set('children', var_data_mutated.array_get(rt.new_string('grouped_products')))
		var_data_mutated.array_unset(rt.new_string('grouped_products'))
	}
	if var_data_mutated.array_isset(rt.new_string('tag_ids_spaces')) {
		var_data_mutated.array_set('tag_ids', var_data_mutated.array_get(rt.new_string('tag_ids_spaces')))
		var_data_mutated.array_unset(rt.new_string('tag_ids_spaces'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.cogs_is_enabled)))) {
		var_data_mutated.array_unset(rt.new_string('cogs_value'))
	}
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_downloads := map[string]rt.PhpVal{}
	mut var_meta_data := map[string]rt.PhpVal{}
	mut iter_9 := var_data_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_value := item_9.val
		mut var_key := item_9.key
		if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('attributes:name'))) {
			if !(!rt.is_true(var_value)) {
				var_attributes.array_get_mut(rt.call_function('str_replace', [rt.new_string('attributes:name'), rt.new_string(''), var_key.clone()])).array_set('name', var_value.clone())
			}
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('attributes:value'))) {
			var_attributes.array_get_mut(rt.call_function('str_replace', [rt.new_string('attributes:value'), rt.new_string(''), var_key.clone()])).array_set('value', var_value.clone())
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('attributes:taxonomy'))) {
			var_attributes.array_get_mut(rt.call_function('str_replace', [rt.new_string('attributes:taxonomy'), rt.new_string(''), var_key.clone()])).array_set('taxonomy', rt.call_function('wc_string_to_bool', [var_value.clone()]))
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('attributes:visible'))) {
			var_attributes.array_get_mut(rt.call_function('str_replace', [rt.new_string('attributes:visible'), rt.new_string(''), var_key.clone()])).array_set('visible', rt.call_function('wc_string_to_bool', [var_value.clone()]))
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('attributes:default'))) {
			if !(!rt.is_true(var_value)) {
				var_attributes.array_get_mut(rt.call_function('str_replace', [rt.new_string('attributes:default'), rt.new_string(''), var_key.clone()])).array_set('default', var_value.clone())
			}
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('downloads:id'))) {
			if !(!rt.is_true(var_value)) {
				var_downloads.array_get_mut(rt.call_function('str_replace', [rt.new_string('downloads:id'), rt.new_string(''), var_key.clone()])).array_set('id', var_value.clone())
			}
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('downloads:name'))) {
			if !(!rt.is_true(var_value)) {
				var_downloads.array_get_mut(rt.call_function('str_replace', [rt.new_string('downloads:name'), rt.new_string(''), var_key.clone()])).array_set('name', var_value.clone())
			}
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('downloads:url'))) {
			if !(!rt.is_true(var_value)) {
				var_downloads.array_get_mut(rt.call_function('str_replace', [rt.new_string('downloads:url'), rt.new_string(''), var_key.clone()])).array_set('url', var_value.clone())
			}
			var_data_mutated.array_unset(var_key)
		} else if rt.is_true(this.starts_with(var_key.clone(), rt.new_string('meta:'))) {
			var_meta_data << rt.create_array([rt.ArrayItem{ key: 'key', val: rt.call_function('str_replace', [rt.new_string('meta:'), rt.new_string(''), var_key.clone()]) }, rt.ArrayItem{ key: 'value', val: var_value }])
			var_data_mutated.array_unset(var_key)
		}
	}
	if !(!rt.is_true(var_attributes)) {
		mut iter_10 := var_attributes.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_attribute := item_10.val
			if !rt.is_true(var_attribute.array_get(rt.new_string('name'))) {
				continue
			}
			var_data_mutated.array_get_mut('raw_attributes').array_push(var_attribute.clone())
		}
	}
	if !(!rt.is_true(var_downloads)) {
		var_data_mutated.array_set('downloads', map[string]rt.PhpVal{})
		mut iter_11 := var_downloads.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_file := item_11.val
			mut var_key := item_11.key
			if !rt.is_true(var_file.array_get(rt.new_string('url'))) {
				continue
			}
			var_data_mutated.array_get_mut('downloads').array_push(rt.create_array([rt.ArrayItem{ key: 'download_id', val: if var_file.array_isset(rt.new_string('id')) { var_file.array_get(rt.new_string('id')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'name', val: if rt.is_true(var_file.array_get(rt.new_string('name'))) { var_file.array_get(rt.new_string('name')) } else { rt.call_function('wc_get_filename_from_url', [var_file.array_get(rt.new_string('url'))]) } }, rt.ArrayItem{ key: 'file', val: var_file.array_get(rt.new_string('url')) }]))
		}
	}
	if !(!rt.is_true(var_meta_data)) {
		var_data_mutated.array_set('meta_data', var_meta_data.clone())
	}
	return var_data_mutated.clone()
}

fn (mut this Class_WC_Product_CSV_Importer) set_parsed_data() {
	mut var_parse_functions := this.get_formatting_callback()
	mut var_mapped_keys := this.get_mapped_keys()
	mut var_use_mb := rt.call_function('function_exists', [rt.new_string('mb_convert_encoding')])
	mut iter_12 := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'raw_data').iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_row := item_12.val
		mut var_row_index := item_12.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(rt.call_function('array_filter', [var_row.clone()]).array_count()))))) {
			continue
		}
		this.parsing_raw_data_index = var_row_index.clone()
		mut var_data := map[string]rt.PhpVal{}
		rt.call_function('do_action', [rt.new_string('woocommerce_product_importer_before_set_parsed_data'), var_row.clone(), var_mapped_keys.clone()])
		mut iter_13 := var_row.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_value := item_13.val
			mut var_id := item_13.key
			if !rt.is_true(var_mapped_keys.array_get(var_id)) {
				continue
			}
			if rt.is_true(var_use_mb) {
				mut var_encoding := rt.call_function('mb_detect_encoding', [var_value.clone(), rt.call_function('mb_detect_order', []rt.PhpVal{}), rt.new_bool(true)])
				if rt.is_true(var_encoding) {
				var_value = rt.call_function('mb_convert_encoding', [var_value.clone(), rt.new_string('UTF-8'), var_encoding.clone()])
				} else {
				var_value = rt.call_function('mb_convert_encoding', [var_value.clone(), rt.new_string('UTF-8'), rt.new_string('UTF-8')])
				}
			} else {
			var_value = rt.call_function('wp_check_invalid_utf8', [var_value.clone(), rt.new_bool(true)])
			}
			var_data.array_set(var_mapped_keys.array_get(var_id), rt.call_function('call_user_func', [var_parse_functions.array_get(var_id), var_value.clone()]))
		}
		rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'parsed_data').array_push(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_importer_parsed_data'), this.expand_data(var_data.clone()), rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this)]))
	}
}

fn (mut this Class_WC_Product_CSV_Importer) get_row_id(var_parsed_data rt.PhpVal) rt.PhpVal {
	mut var_id := if var_parsed_data.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_parsed_data.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
	mut var_sku := if var_parsed_data.array_isset(rt.new_string('sku')) { rt.call_function('esc_attr', [var_parsed_data.array_get(rt.new_string('sku'))]) } else { rt.new_string('') }
	mut var_name := if var_parsed_data.array_isset(rt.new_string('name')) { rt.call_function('esc_attr', [var_parsed_data.array_get(rt.new_string('name'))]) } else { rt.new_string('') }
	mut var_row_data := map[string]rt.PhpVal{}
	if rt.is_true(var_name) {
		var_row_data << var_name.clone()
	}
	if rt.is_true(var_id) {
		var_row_data << rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('ID %d'), rt.new_string('woocommerce')]), var_id.clone()])
	}
	if rt.is_true(var_sku) {
		var_row_data << rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('SKU %s'), rt.new_string('woocommerce')]), var_sku.clone()])
	}
	return rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_row_data)])
}

fn (mut this Class_WC_Product_CSV_Importer) import() rt.PhpVal {
	this.dispatch_set_prop('start_time', rt.call_function('time', []rt.PhpVal{}))
	mut var_index := rt.new_int(0)
	mut var_update_existing := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('update_existing'))
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'imported', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'imported_variations', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'failed', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'updated', val: map[string]rt.PhpVal{} }, rt.ArrayItem{ key: 'skipped', val: map[string]rt.PhpVal{} }])
	mut iter_14 := rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'parsed_data').iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_parsed_data := item_14.val
		mut var_parsed_data_key := item_14.key
		rt.call_function('do_action', [rt.new_string('woocommerce_product_import_before_import'), var_parsed_data.clone()])
		mut var_id := if var_parsed_data.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_parsed_data.array_get(rt.new_string('id'))]) } else { rt.new_int(0) }
		mut var_sku := if var_parsed_data.array_isset(rt.new_string('sku')) { var_parsed_data.array_get(rt.new_string('sku')) } else { rt.new_string('') }
		mut var_id_exists := rt.new_bool(false)
		mut var_sku_exists := rt.new_bool(false)
		if rt.is_true(var_id) {
		mut var_product := rt.call_function('wc_get_product', [var_id.clone()])
		var_id_exists = rt.new_bool(rt.is_true(var_product) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('importing'), rt.call_method(var_product, 'get_status', []rt.PhpVal{}))))))
		}
		if rt.is_true(var_sku) {
		mut var_id_from_sku := rt.call_function('wc_get_product_id_by_sku', [var_sku.clone()])
		var_product = if rt.is_true(var_id_from_sku) { rt.call_function('wc_get_product', [var_id_from_sku.clone()]) } else { rt.new_bool(false) }
		var_sku_exists = rt.new_bool(rt.is_true(var_product) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('importing'), rt.call_method(var_product, 'get_status', []rt.PhpVal{}))))))
		}
		if rt.is_true(var_sku_exists) && rt.is_true(rt.new_bool(!(rt.is_true(var_update_existing)))) {
			var_data.array_get_mut('skipped').array_push(create_wp_error(rt.new_string('woocommerce_product_importer_error'), rt.call_function('esc_html__', [rt.new_string('A product with this SKU already exists.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'sku', val: rt.call_function('esc_attr', [var_sku.clone()]) }, rt.ArrayItem{ key: 'row', val: this.get_row_id(var_parsed_data.clone()) }])))
			continue
		}
		if rt.is_true(var_id_exists) && rt.is_true(rt.new_bool(!(rt.is_true(var_update_existing)))) {
			var_data.array_get_mut('skipped').array_push(create_wp_error(rt.new_string('woocommerce_product_importer_error'), rt.call_function('esc_html__', [rt.new_string('A product with this ID already exists.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'row', val: this.get_row_id(var_parsed_data.clone()) }])))
			continue
		}
		if rt.is_true(var_update_existing) && var_parsed_data.array_isset(rt.new_string('id')) || var_parsed_data.array_isset(rt.new_string('sku')) && rt.is_true(rt.new_bool(!(rt.is_true(var_id_exists)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_sku_exists)))) {
			var_data.array_get_mut('skipped').array_push(create_wp_error(rt.new_string('woocommerce_product_importer_error'), rt.call_function('esc_html__', [rt.new_string('No matching product exists to update.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'sku', val: rt.call_function('esc_attr', [var_sku.clone()]) }, rt.ArrayItem{ key: 'row', val: this.get_row_id(var_parsed_data.clone()) }])))
			continue
		}
		mut var_result := this.process_item(var_parsed_data.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
			rt.call_method(var_result, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'row', val: this.get_row_id(var_parsed_data.clone()) }])])
			var_data.array_get_mut('failed').array_push(var_result.clone())
		} else if rt.is_true(var_result.array_get(rt.new_string('updated'))) {
			var_data.array_get_mut('updated').array_push(var_result.array_get(rt.new_string('id')))
		} else if rt.is_true(var_result.array_get(rt.new_string('is_variation'))) {
			var_data.array_get_mut('imported_variations').array_push(var_result.array_get(rt.new_string('id')))
		} else {
			var_data.array_get_mut('imported').array_push(var_result.array_get(rt.new_string('id')))
		}
		rt.pre_inc(var_index)
		if rt.is_true(rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'params').array_get(rt.new_string('prevent_timeouts'))) && rt.is_true(this.time_exceeded()) || rt.is_true(this.memory_exceeded()) {
			this.dispatch_set_prop('file_position', rt.get_property(rt.new_object('WC_Product_CSV_Importer', ['WC_Product_Importer'], &this), 'file_positions').array_get(var_index))
			break
		}
	}
	return var_data.clone()
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

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_WP_Error {
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

fn create_wc_product_importer(_args ...rt.PhpVal) &Class_WC_Product_Importer {
	mut obj := &Class_WC_Product_Importer{
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

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
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
			return this.parse_published_field(dispatch_arg_0)
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


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_Importer'), rt.new_bool(false)]))))) {
		rt.include_file(@DIR + '/abstract-wc-product-importer.php', '2')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_CSV_Importer_Controller'), rt.new_bool(false)]))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/importers/class-wc-product-csv-importer-controller.php', '2')
	}
}
