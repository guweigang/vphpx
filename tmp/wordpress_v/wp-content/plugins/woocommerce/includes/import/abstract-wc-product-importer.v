import rt

struct Class_WC_Product_Importer {
	rt.PhpObjectBase
pub mut:
		file rt.PhpVal = rt.new_string('')
		file_position rt.PhpVal = rt.new_int(0)
		params rt.PhpVal = rt.new_array()
		raw_keys rt.PhpVal = rt.new_array()
		mapped_keys rt.PhpVal = rt.new_array()
		raw_data rt.PhpVal = rt.new_array()
		file_positions rt.PhpVal = rt.new_array()
		parsed_data rt.PhpVal = rt.new_array()
		start_time rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WC_Product_Importer) get_raw_keys() rt.PhpVal {
	return this.raw_keys
}

fn (mut this Class_WC_Product_Importer) get_mapped_keys() rt.PhpVal {
	return if !(!rt.is_true(this.mapped_keys)) { this.mapped_keys } else { this.raw_keys }
}

fn (mut this Class_WC_Product_Importer) get_raw_data() rt.PhpVal {
	return this.raw_data
}

fn (mut this Class_WC_Product_Importer) get_parsed_data() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_importer_parsed_data'), this.parsed_data, rt.new_object('WC_Product_Importer', ['WC_Importer_Interface'], &this)])
}

fn (mut this Class_WC_Product_Importer) get_params() rt.PhpVal {
	return this.params
}

fn (mut this Class_WC_Product_Importer) get_file_position() rt.PhpVal {
	return this.file_position
}

fn (mut this Class_WC_Product_Importer) get_percent_complete() i64 {
	mut var_size := rt.call_function('filesize', [this.file])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_size)))) {
		return 0
	}
	return (rt.call_function('absint', [rt.call_function('min', [rt.call_function('floor', [rt.mul(rt.div(this.file_position, var_size), rt.new_int(100))]), rt.new_int(100)])])).to_i64()
}

fn (mut this Class_WC_Product_Importer) get_product_object(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_id := if var_data_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [var_data_mutated.array_get('id')]) } else { rt.new_int(0) }
	if var_data_mutated.array_isset(rt.new_string('type')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(fn () rt.PhpVal { mut temp := Class_WC_Admin_Exporters{}; return temp.get_product_types() }().array_isset(var_data_mutated.array_get('type'))))))) {
			return create_wp_error(rt.new_string('woocommerce_product_importer_invalid_type'), rt.call_function('__', [rt.new_string('Invalid product type.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))
		}
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), var_data_mutated.array_get('type'))) {
			var_id = rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_id }, rt.ArrayItem{ key: 'post_type', val: 'product_variation' }])])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_product := rt.call_function('wc_get_product_object', [var_data_mutated.array_get('type'), var_id.dup()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'WC_Data_Exception') {
			mut var_e := var_e_1.dup()
			return create_wp_error('woocommerce_product_csv_importer_' + (rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{})).str(), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }]))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	} else if !(!rt.is_true(var_data_mutated.array_get('id'))) {
		var_product = rt.call_function('wc_get_product', [var_id.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
			return create_wp_error(rt.new_string('woocommerce_product_csv_importer_invalid_id'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid product ID %d.'), rt.new_string('woocommerce')]), var_id.dup()]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'status', val: 401 }]))
		}
	} else {
		var_product = rt.call_function('wc_get_product_object', [Class_Automattic_WooCommerce_Enums_ProductType.simple(), var_id.dup()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_product_import_get_product_object'), var_product.dup(), var_data_mutated.dup()])
}

fn (mut this Class_WC_Product_Importer) process_item(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	rt.call_function('do_action', [rt.new_string('woocommerce_product_import_before_process_item'), var_data_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_data_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_import_process_item_data'), var_data_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if !rt.is_true(var_data_mutated.array_get('id')) && !(!rt.is_true(var_data_mutated.array_get('sku'))) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [var_data_mutated.array_get('sku')])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		if rt.is_true(var_product_id) {
			var_data_mutated.array_set('id', var_product_id.dup())
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_object := this.get_product_object(var_data_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_updating := rt.new_bool(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_object.dup()])) {
		return var_object.dup()
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_object, 'get_id', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_updating = rt.new_bool(rt.new_bool(true))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.external(), rt.call_method(var_object, 'get_type', []rt.PhpVal{}))) {
		var_data_mutated.array_unset(rt.new_string('manage_stock'))
		var_data_mutated.array_unset(rt.new_string('stock_status'))
		var_data_mutated.array_unset(rt.new_string('backorders'))
		var_data_mutated.array_unset(rt.new_string('low_stock_amount'))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_is_variation := rt.new_bool(rt.new_bool(false))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_object, 'get_type', []rt.PhpVal{}))) {
		if rt.is_true(rt.new_bool(var_data_mutated.array_isset(rt.new_string('status')) && rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_data_mutated.array_get('status'))))) {
			var_data_mutated.array_set('status', 0)
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			// unsupported statement: Stmt_Nop
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_is_variation = rt.new_bool(rt.new_bool(true))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.identical(rt.new_string('importing'), rt.call_method(var_object, 'get_status', []rt.PhpVal{}))) {
		rt.call_method(var_object, 'set_status', [Class_Automattic_WooCommerce_Enums_ProductStatus.publish()])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		rt.call_method(var_object, 'set_slug', [rt.new_string('')])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.new_bool(var_data_mutated.dup().array_isset(rt.new_string('cogs_value')))) {
		rt.call_method(var_object, 'set_cogs_value', [var_data_mutated.array_get('cogs_value')])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_data_mutated.array_unset(rt.new_string('cogs_value'))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	mut var_result := rt.call_method(var_object, 'set_props', [rt.call_function('array_diff_key', [var_data_mutated.dup(), rt.call_function('array_flip', [rt.create_array([rt.ArrayItem{ key: none, val: 'meta_data' }, rt.ArrayItem{ key: none, val: 'raw_image_id' }, rt.ArrayItem{ key: none, val: 'raw_gallery_image_ids' }, rt.ArrayItem{ key: none, val: 'raw_attributes' }])])])])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_result, 'get_error_message', []rt.PhpVal{}))))
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_object, 'get_type', []rt.PhpVal{}))) {
		this.set_variation_data(var_object.dup(), var_data_mutated.dup())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else {
		this.set_product_data(var_object.dup(), var_data_mutated.dup())
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.set_image_data(var_object.dup(), var_data_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.set_meta_data(var_object.dup(), var_data_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_object = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_import_pre_insert_product_object'), var_object.dup(), var_data_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_method(var_object, 'save', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('do_action', [rt.new_string('woocommerce_product_import_inserted_product_object'), var_object.dup(), var_data_mutated.dup()])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'updated', val: var_updating }, rt.ArrayItem{ key: 'is_variation', val: var_is_variation }])
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		return create_wp_error(rt.new_string('woocommerce_product_importer_error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) }]))
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return rt.new_null()
}

fn (mut this Class_WC_Product_Importer) set_image_data(var_product rt.PhpVal, var_data rt.PhpVal)  {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('raw_image_id')) {
		mut var_attachment_id := rt.new_int(this.get_attachment_id_from_url(var_data_mutated.array_get('raw_image_id'), rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{})))
		rt.call_method(var_product_mutated, 'set_image_id', [var_attachment_id.dup()])
		rt.call_function('wc_product_attach_featured_image', [var_attachment_id.dup(), var_product_mutated.dup()])
	}
	if var_data_mutated.array_isset(rt.new_string('raw_gallery_image_ids')) {
		mut var_gallery_image_ids := []rt.PhpVal{}
		{
			mut iter_1 := var_data_mutated.array_get('raw_gallery_image_ids').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_image_id := item_1.val
				var_gallery_image_ids << this.get_attachment_id_from_url(var_image_id.dup(), rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}))
			}
		}
		rt.call_method(var_product_mutated, 'set_gallery_image_ids', [var_gallery_image_ids.dup()])
	}
}

fn (mut this Class_WC_Product_Importer) set_meta_data(var_product rt.PhpVal, var_data rt.PhpVal)  {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('meta_data')) {
		{
			mut iter_1 := var_data_mutated.array_get('meta_data').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				rt.call_method(var_product_mutated, 'update_meta_data', [var_meta.array_get('key'), var_meta.array_get('value')])
			}
		}
	}
}

fn (mut this Class_WC_Product_Importer) set_product_data(var_product rt.PhpVal, var_data rt.PhpVal)  {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('raw_attributes')) {
		mut var_attributes := []rt.PhpVal{}
		mut var_default_attributes := []rt.PhpVal{}
		mut var_existing_attributes := rt.call_method(var_product_mutated, 'get_attributes', []rt.PhpVal{})
		{
			mut iter_1 := var_data_mutated.array_get('raw_attributes').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				mut var_position := item_1.key
				mut var_attribute_id := rt.new_int(rt.new_int(0))
				if !(!rt.is_true(var_attribute.array_get('taxonomy'))) {
					var_attribute_id = this.get_attribute_taxonomy_id(var_attribute.array_get('name'))
				}
				if var_attribute.array_isset(rt.new_string('visible')) {
					mut var_is_visible := var_attribute.array_get('visible')
				} else {
					var_is_visible = rt.new_int(rt.new_int(1))
				}
				mut var_attribute_name := if rt.is_true(var_attribute_id) { rt.call_function('wc_attribute_taxonomy_name_by_id', [var_attribute_id.dup()]) } else { var_attribute.array_get('name') }
				mut var_is_variation := rt.new_int(rt.new_int(0))
				if rt.is_true(var_existing_attributes) {
					{
						mut iter_2 := var_existing_attributes.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_existing_attribute := item_2.val
							if rt.is_true(rt.identical(rt.call_method(var_existing_attribute, 'get_name', []rt.PhpVal{}), var_attribute_name)) {
								var_is_variation = rt.call_method(var_existing_attribute, 'get_variation', []rt.PhpVal{})
								break
							}
						}
					}
				}
				if rt.is_true(var_attribute_id) {
					if var_attribute.array_isset(rt.new_string('value')) {
						mut var_options := rt.call_function('array_map', [rt.new_string('wc_sanitize_term_text_based'), var_attribute.array_get('value')])
						var_options = rt.call_function('array_filter', [var_options.dup(), rt.new_string('strlen')])
					} else {
						var_options = []rt.PhpVal{}
					}
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_attribute.array_get('default'))) && rt.is_true(rt.call_function('in_array', [var_attribute.array_get('default'), var_options.dup(), rt.new_bool(true)])))) {
						mut var_default_term := rt.call_function('get_term_by', [rt.new_string('name'), var_attribute.array_get('default'), var_attribute_name.dup()])
						if rt.is_true(rt.new_bool(rt.is_true(var_default_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_default_term.dup()]))))))) {
							mut var_default := rt.get_property(var_default_term, 'slug')
						} else {
							var_default = rt.call_function('sanitize_title', [var_attribute.array_get('default')])
						}
						var_default_attributes.array_set(var_attribute_name, var_default.dup())
						var_is_variation = rt.new_int(rt.new_int(1))
					}
					if !(!rt.is_true(var_options)) {
						mut var_attribute_object := create_wc_product_attribute()
						var_attribute_object.set_id(var_attribute_id.dup())
						var_attribute_object.set_name(var_attribute_name.dup())
						var_attribute_object.set_options(var_options.dup())
						var_attribute_object.set_position(var_position.dup())
						var_attribute_object.set_visible(var_is_visible.dup())
						var_attribute_object.set_variation(var_is_variation.dup())
						var_attributes.array_push(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_importer_read_attribute'), var_attribute_object, var_attribute.dup(), var_product_mutated.dup()]))
					}
				} else if var_attribute.array_isset(rt.new_string('value')) {
					if rt.is_true(rt.new_bool(!(!rt.is_true(var_attribute.array_get('default'))) && rt.is_true(rt.call_function('in_array', [var_attribute.array_get('default'), var_attribute.array_get('value'), rt.new_bool(true)])))) {
						var_default_attributes.array_set(rt.call_function('sanitize_title', [var_attribute.array_get('name')]), var_attribute.array_get('default'))
						var_is_variation = rt.new_int(rt.new_int(1))
					}
					var_attribute_object = create_wc_product_attribute()
					var_attribute_object.set_name(.array_get())
					.set_options()
					
				}
			}
		}
		
	}
}

fn (mut this Class_WC_Product_Importer) set_variation_data(var_variation rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	
	return rt.new_null()
}

fn (mut this Class_WC_Product_Importer) get_variation_parent_attributes(var_attributes rt.PhpVal, var_parent rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_parent_mutated := var_parent
}

fn (mut this Class_WC_Product_Importer) get_attachment_id_from_url(var_url rt.PhpVal, var_product_id rt.PhpVal) i64 {
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Importer) get_attribute_taxonomy_id(var_raw_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Importer) memory_exceeded() rt.PhpVal {
}

fn (mut this Class_WC_Product_Importer) get_memory_limit() rt.PhpVal {
}

fn (mut this Class_WC_Product_Importer) time_exceeded() rt.PhpVal {
}

fn (mut this Class_WC_Product_Importer) explode_values(var_value rt.PhpVal, separator string) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_Importer) explode_values_formatter(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Product_Importer) unescape_data(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

struct Class_WC_Admin_Exporters {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
}

fn create_wc_product_importer() &Class_WC_Product_Importer {
	mut obj := &Class_WC_Product_Importer{
		PhpObjectBase: rt.PhpObjectBase{}
		file: rt.new_string('')
		file_position: rt.new_int(0)
		params: rt.new_array()
		raw_keys: rt.new_array()
		mapped_keys: rt.new_array()
		raw_data: rt.new_array()
		file_positions: rt.new_array()
		parsed_data: rt.new_array()
		start_time: rt.new_int(0)
	}
	return obj
}

fn create_wc_admin_exporters() &Class_WC_Admin_Exporters {
	mut obj := &Class_WC_Admin_Exporters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_product_attribute() &Class_WC_Product_Attribute {
	mut obj := &Class_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Importer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_raw_keys' {
			return this.get_raw_keys()
		}
		'get_mapped_keys' {
			return this.get_mapped_keys()
		}
		'get_raw_data' {
			return this.get_raw_data()
		}
		'get_parsed_data' {
			return this.get_parsed_data()
		}
		'get_params' {
			return this.get_params()
		}
		'get_file_position' {
			return this.get_file_position()
		}
		'get_percent_complete' {
			return rt.new_int(this.get_percent_complete())
		}
		'get_product_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_object(dispatch_arg_0)
		}
		'process_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_item(dispatch_arg_0)
		}
		'set_image_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_image_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_meta_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_product_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_variation_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.set_variation_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_variation_parent_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_variation_parent_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'get_attachment_id_from_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(this.get_attachment_id_from_url(dispatch_arg_0, dispatch_arg_1))
		}
		'get_attribute_taxonomy_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_attribute_taxonomy_id(dispatch_arg_0)
		}
		'memory_exceeded' {
			return this.memory_exceeded()
		}
		'get_memory_limit' {
			return this.get_memory_limit()
		}
		'time_exceeded' {
			return this.time_exceeded()
		}
		'explode_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.explode_values(dispatch_arg_0, dispatch_arg_1)
		}
		'explode_values_formatter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.explode_values_formatter(dispatch_arg_0))
		}
		'unescape_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.unescape_data(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Importer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file' { return this.file }
		'file_position' { return this.file_position }
		'params' { return this.params }
		'raw_keys' { return this.raw_keys }
		'mapped_keys' { return this.mapped_keys }
		'raw_data' { return this.raw_data }
		'file_positions' { return this.file_positions }
		'parsed_data' { return this.parsed_data }
		'start_time' { return this.start_time }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Importer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'file' { this.file = val; return true }
		'file_position' { this.file_position = val; return true }
		'params' { this.params = val; return true }
		'raw_keys' { this.raw_keys = val; return true }
		'mapped_keys' { this.mapped_keys = val; return true }
		'raw_data' { this.raw_data = val; return true }
		'file_positions' { this.file_positions = val; return true }
		'parsed_data' { this.parsed_data = val; return true }
		'start_time' { this.start_time = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Admin_Exporters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Exporters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Exporters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Product_Attribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Attribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Attribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_import_abstract_wc_product_importer_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Importer_Interface'), rt.new_bool(false)]))))) {
		rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-importer-interface.php', '2')
	}
}
