import rt

struct Class_WC_Product_Importer {
	rt.PhpObjectBase
pub mut:
	file           rt.PhpVal = rt.new_string('')
	file_position  rt.PhpVal = rt.new_int(0)
	params         rt.PhpVal = rt.new_array()
	raw_keys       rt.PhpVal = rt.new_array()
	mapped_keys    rt.PhpVal = rt.new_array()
	raw_data       rt.PhpVal = rt.new_array()
	file_positions rt.PhpVal = rt.new_array()
	parsed_data    rt.PhpVal = rt.new_array()
	start_time     rt.PhpVal = rt.new_int(0)
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
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_importer_parsed_data'),
		this.parsed_data,
		rt.new_object('WC_Product_Importer', ['WC_Importer_Interface'], &this),
	])
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
	return (rt.call_function('absint', [
		rt.call_function('min', [
			rt.call_function('floor', [
				rt.mul(rt.div(this.file_position, var_size), rt.new_int(100)),
			]),
			rt.new_int(100),
		]),
	])).to_i64()
}

fn (mut this Class_WC_Product_Importer) get_product_object(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_id := if var_data_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [
			var_data_mutated.array_get(rt.new_string('id')),
		]) } else { rt.new_int(0) }
	if var_data_mutated.array_isset(rt.new_string('type')) {
		mut iife_temp_0 := Class_WC_Admin_Exporters{}
		mut iife_result_0 := iife_temp_0.get_product_types()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(iife_result_0.array_isset(var_data_mutated.array_get(rt.new_string('type')))))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_product_importer_invalid_type'), rt.call_function('__', [
				rt.new_string('Invalid product type.'),
				rt.new_string('woocommerce'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }])))
		}
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(),
			var_data_mutated.array_get(rt.new_string('type'))))
		{
			var_id = rt.call_function('wp_update_post', [
				rt.create_array([rt.ArrayItem{ key: 'ID', val: var_id },
					rt.ArrayItem{ key: 'post_type', val: 'product_variation' }]),
			])
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
		mut var_product := rt.call_function('wc_get_product_object', [
			var_data_mutated.array_get(rt.new_string('type')),
			var_id.clone(),
		])
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
		if rt.instance_of(var_e_1, 'WC_Data_Exception') {
			mut var_e := var_e_1.clone()
			return rt.new_object('WP_Error', []string{}, create_wp_error(
				'woocommerce_product_csv_importer_' +
				(rt.call_method(var_e, 'getErrorCode', []rt.PhpVal{})).str(), rt.call_method(var_e,
				'getMessage', []rt.PhpVal{}), rt.create_array([
				rt.ArrayItem{ key: 'status', val: 401 },
			])))
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
	} else if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('id')))) {
		var_product = rt.call_function('wc_get_product', [var_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_product_csv_importer_invalid_id'), rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Invalid product ID %d.'),
					rt.new_string('woocommerce')]),
				var_id.clone(),
			]), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id },
				rt.ArrayItem{ key: 'status', val: 401 }])))
		}
	} else {
		var_product = rt.call_function('wc_get_product_object', [
			Class_Automattic_WooCommerce_Enums_ProductType.simple(),
			var_id.clone(),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_import_get_product_object'),
		var_product.clone(),
		var_data_mutated.clone(),
	])
}

fn (mut this Class_WC_Product_Importer) process_item(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_import_before_process_item'),
		var_data_mutated.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_data_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_import_process_item_data'),
		var_data_mutated.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !rt.is_true(var_data_mutated.array_get(rt.new_string('id')))
		&& !(!rt.is_true(var_data_mutated.array_get(rt.new_string('sku')))) {
		mut var_product_id := rt.call_function('wc_get_product_id_by_sku', [
			var_data_mutated.array_get(rt.new_string('sku')),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(var_product_id) {
			var_data_mutated.array_set('id', var_product_id.clone())
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
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_object := this.get_product_object(var_data_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_updating := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_object.clone()])) {
		return var_object.clone()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_method(var_object, 'get_id', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('importing'), rt.call_method(var_object, 'get_status', []rt.PhpVal{}))))) {
		var_updating = rt.new_bool(true)
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
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.external(), rt.call_method(var_object,
		'get_type', []rt.PhpVal{})))
	{
		var_data_mutated.array_unset(rt.new_string('manage_stock'))
		var_data_mutated.array_unset(rt.new_string('stock_status'))
		var_data_mutated.array_unset(rt.new_string('backorders'))
		var_data_mutated.array_unset(rt.new_string('low_stock_amount'))
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
	mut var_is_variation := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_object,
		'get_type', []rt.PhpVal{})))
	{
		if var_data_mutated.array_isset(rt.new_string('status'))
			&& rt.is_true(rt.identical(-1, var_data_mutated.array_get(rt.new_string('status')))) {
			var_data_mutated.array_set('status', 0)
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
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
		var_is_variation = rt.new_bool(true)
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
	if rt.is_true(rt.identical(rt.new_string('importing'), rt.call_method(var_object, 'get_status',
		[]rt.PhpVal{})))
	{
		rt.call_method(var_object, 'set_status', [
			Class_Automattic_WooCommerce_Enums_ProductStatus.publish(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_method(var_object, 'set_slug', [rt.new_string('')])
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
	if rt.is_true(rt.new_bool(var_data_mutated.clone().array_isset(rt.new_string('cogs_value')))) {
		rt.call_method(var_object, 'set_cogs_value', [
			var_data_mutated.array_get(rt.new_string('cogs_value')),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		var_data_mutated.array_unset(rt.new_string('cogs_value'))
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
	mut var_result := rt.call_method(var_object, 'set_props', [
		rt.call_function('array_diff_key', [var_data_mutated.clone(),
			rt.call_function('array_flip', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'meta_data' },
					rt.ArrayItem{ key: none, val: 'raw_image_id' },
					rt.ArrayItem{ key: none, val: 'raw_gallery_image_ids' },
					rt.ArrayItem{ key: none, val: 'raw_attributes' }]),
			])]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_result.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_result,
			'get_error_message', []rt.PhpVal{}))))
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
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_object,
		'get_type', []rt.PhpVal{})))
	{
		this.set_variation_data(var_object.clone(), var_data_mutated.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	} else {
		this.set_product_data(var_object.clone(), var_data_mutated.clone())
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
	this.set_image_data(var_object.clone(), var_data_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.set_meta_data(var_object.clone(), var_data_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_object = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_import_pre_insert_product_object'),
		var_object.clone(),
		var_data_mutated.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(var_object, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_product_import_inserted_product_object'),
		var_object.clone(),
		var_data_mutated.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_object, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'updated', val: var_updating },
		rt.ArrayItem{ key: 'is_variation', val: var_is_variation },
	])
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return create_wp_error(rt.new_string('woocommerce_product_importer_error'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		]))
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
	return rt.new_null()
}

fn (mut this Class_WC_Product_Importer) set_image_data(var_product rt.PhpVal, var_data rt.PhpVal) {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('raw_image_id')) {
		mut var_attachment_id := rt.new_int(this.get_attachment_id_from_url(var_data_mutated.array_get(rt.new_string('raw_image_id')), rt.call_method(var_product_mutated,
			'get_id', []rt.PhpVal{})))
		rt.call_method(var_product_mutated, 'set_image_id', [
			var_attachment_id.clone()])
		rt.call_function('wc_product_attach_featured_image', [
			var_attachment_id.clone(), var_product_mutated.clone()])
	}
	if var_data_mutated.array_isset(rt.new_string('raw_gallery_image_ids')) {
		mut var_gallery_image_ids := []rt.PhpVal{}
		mut iter_1 := var_data_mutated.array_get(rt.new_string('raw_gallery_image_ids')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_image_id := item_1.val
			var_gallery_image_ids << this.get_attachment_id_from_url(var_image_id.clone(), rt.call_method(var_product_mutated,
				'get_id', []rt.PhpVal{}))
		}
		rt.call_method(var_product_mutated, 'set_gallery_image_ids', [
			rt.create_array_from_list(var_gallery_image_ids),
		])
	}
}

fn (mut this Class_WC_Product_Importer) set_meta_data(var_product rt.PhpVal, var_data rt.PhpVal) {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('meta_data')) {
		mut iter_2 := var_data_mutated.array_get(rt.new_string('meta_data')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_meta := item_2.val
			rt.call_method(var_product_mutated, 'update_meta_data', [
				var_meta.array_get(rt.new_string('key')),
				var_meta.array_get(rt.new_string('value')),
			])
		}
	}
}

fn (mut this Class_WC_Product_Importer) set_product_data(var_product rt.PhpVal, var_data rt.PhpVal) {
	mut var_product_mutated := var_product
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('raw_attributes')) {
		mut var_attributes := []rt.PhpVal{}
		mut var_default_attributes := []rt.PhpVal{}
		mut var_existing_attributes := rt.call_method(var_product_mutated, 'get_attributes',
			[]rt.PhpVal{})
		mut iter_3 := var_data_mutated.array_get(rt.new_string('raw_attributes')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attribute := item_3.val
			mut var_position := item_3.key
			mut var_attribute_id := rt.new_int(0)
			if !(!rt.is_true(var_attribute.array_get(rt.new_string('taxonomy')))) {
				var_attribute_id =
					this.get_attribute_taxonomy_id(var_attribute.array_get(rt.new_string('name')))
			}
			if var_attribute.array_isset(rt.new_string('visible')) {
				mut var_is_visible := var_attribute.array_get(rt.new_string('visible'))
			} else {
				var_is_visible = rt.new_int(1)
			}
			mut var_attribute_name := if rt.is_true(var_attribute_id) { rt.call_function('wc_attribute_taxonomy_name_by_id', [
					var_attribute_id.clone(),
				]) } else { var_attribute.array_get(rt.new_string('name')) }
			mut var_is_variation := rt.new_int(0)
			if rt.is_true(var_existing_attributes) {
				mut iter_4 := var_existing_attributes.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_existing_attribute := item_4.val
					if rt.is_true(rt.identical(rt.call_method(var_existing_attribute, 'get_name',
						[]rt.PhpVal{}), var_attribute_name))
					{
						var_is_variation = rt.call_method(var_existing_attribute, 'get_variation',
							[]rt.PhpVal{})
						break
					}
				}
			}
			if rt.is_true(var_attribute_id) {
				if var_attribute.array_isset(rt.new_string('value')) {
					mut var_options := rt.call_function('array_map', [
						rt.new_string('wc_sanitize_term_text_based'),
						var_attribute.array_get(rt.new_string('value')),
					])
					var_options = rt.call_function('array_filter', [
						var_options.clone(), rt.new_string('strlen')])
				} else {
					var_options = []rt.PhpVal{}
				}
				if !(!rt.is_true(var_attribute.array_get(rt.new_string('default'))))
					&& rt.is_true(rt.call_function('in_array', [var_attribute.array_get(rt.new_string('default')), var_options.clone(), rt.new_bool(true)])) {
					mut var_default_term := rt.call_function('get_term_by', [
						rt.new_string('name'),
						var_attribute.array_get(rt.new_string('default')),
						var_attribute_name.clone(),
					])
					if rt.is_true(var_default_term)
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_default_term.clone()]))))) {
						mut var_default := rt.get_property(var_default_term, 'slug')
					} else {
						var_default = rt.call_function('sanitize_title', [
							var_attribute.array_get(rt.new_string('default')),
						])
					}
					var_default_attributes.array_set(var_attribute_name, var_default.clone())
					var_is_variation = rt.new_int(1)
				}
				if !(!rt.is_true(var_options)) {
					mut var_attribute_object := create_wc_product_attribute()
					var_attribute_object.set_id(var_attribute_id.clone())
					var_attribute_object.set_name(var_attribute_name.clone())
					var_attribute_object.set_options(var_options.clone())
					var_attribute_object.set_position(var_position.clone())
					var_attribute_object.set_visible(var_is_visible.clone())
					var_attribute_object.set_variation(var_is_variation.clone())
					var_attributes.array_push(rt.call_function('apply_filters', [
						rt.new_string('woocommerce_product_importer_read_attribute'),
						var_attribute_object,
						var_attribute.clone(),
						var_product_mutated.clone(),
					]))
				}
			} else if var_attribute.array_isset(rt.new_string('value')) {
				if !(!rt.is_true(var_attribute.array_get(rt.new_string('default'))))
					&& rt.is_true(rt.call_function('in_array', [var_attribute.array_get(rt.new_string('default')), var_attribute.array_get(rt.new_string('value')), rt.new_bool(true)])) {
					var_default_attributes.array_set(rt.call_function('sanitize_title', [
						var_attribute.array_get(rt.new_string('name')),
					]), var_attribute.array_get(rt.new_string('default')))
					var_is_variation = rt.new_int(1)
				}
				var_attribute_object = create_wc_product_attribute()
				var_attribute_object.set_name(var_attribute.array_get(rt.new_string('name')))
				var_attribute_object.set_options(var_attribute.array_get(rt.new_string('value')))
				var_attribute_object.set_position(var_position.clone())
				var_attribute_object.set_visible(var_is_visible.clone())
				var_attribute_object.set_variation(var_is_variation.clone())
				var_attributes.array_push(rt.call_function('apply_filters', [
					rt.new_string('woocommerce_product_importer_read_attribute'),
					var_attribute_object,
					var_attribute.clone(),
					var_product_mutated.clone(),
				]))
			}
		}
		rt.call_method(var_product_mutated, 'set_attributes', [
			var_attributes.clone()])
		if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [
			Class_Automattic_WooCommerce_Enums_ProductType.variable(),
		]))
		{
			rt.call_method(var_product_mutated, 'set_default_attributes', [
				var_default_attributes.clone()])
		}
	}
}

fn (mut this Class_WC_Product_Importer) set_variation_data(var_variation rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_parent := rt.new_bool(false)
	if var_data_mutated.array_isset(rt.new_string('parent_id')) {
		var_parent = rt.call_function('wc_get_product', [
			var_data_mutated.array_get(rt.new_string('parent_id')),
		])
		if rt.is_true(var_parent) {
			rt.call_method(var_variation, 'set_parent_id', [
				rt.call_method(var_parent, 'get_id', []rt.PhpVal{}),
			])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_product_importer_missing_variation_parent_id'), rt.call_function('__', [
			rt.new_string('Variation cannot be imported: Missing parent ID or parent does not exist yet.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }])))
	}
	if rt.is_true(rt.call_method(var_parent, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_product_importer_parent_set_as_variation'), rt.call_function('__', [
			rt.new_string('Variation cannot be imported: Parent product cannot be a product variation'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 401 }])))
	}
	if var_data_mutated.array_isset(rt.new_string('raw_attributes')) {
		mut var_attributes := []rt.PhpVal{}
		mut var_parent_attributes := this.get_variation_parent_attributes(var_data_mutated.array_get(rt.new_string('raw_attributes')),
			var_parent.clone())
		mut iter_5 := var_data_mutated.array_get(rt.new_string('raw_attributes')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_attribute := item_5.val
			mut var_attribute_id := rt.new_int(0)
			if !(!rt.is_true(var_attribute.array_get(rt.new_string('taxonomy')))) {
				var_attribute_id =
					this.get_attribute_taxonomy_id(var_attribute.array_get(rt.new_string('name')))
			}
			if rt.is_true(var_attribute_id) {
				mut var_attribute_name := rt.call_function('sanitize_title', [
					rt.call_function('wc_attribute_taxonomy_name_by_id', [
						var_attribute_id.clone()]),
				])
			} else {
				var_attribute_name = rt.call_function('sanitize_title', [
					var_attribute.array_get(rt.new_string('name')),
				])
			}
			if !(var_parent_attributes.array_isset(var_attribute_name))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_variation', []rt.PhpVal{}))))) {
				continue
			}
			mut var_attribute_key := rt.call_function('sanitize_title', [
				rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_name',
					[]rt.PhpVal{}),
			])
			mut var_attribute_value := if var_attribute.array_isset(rt.new_string('value')) { rt.call_function('current', [
					var_attribute.array_get(rt.new_string('value')),
				]) } else { rt.new_string('') }
			if rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name),
				'is_taxonomy', []rt.PhpVal{}))
			{
				mut var_taxonomy_name := rt.call_method(var_parent_attributes.array_get(var_attribute_name),
					'get_name', []rt.PhpVal{})
				mut var_term := rt.call_function('get_term_by', [
					rt.new_string('name'), var_attribute_value.clone(),
					var_taxonomy_name.clone()])
				if rt.is_true(var_term)
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
					var_attribute_value = rt.get_property(var_term, 'slug')
				} else {
					var_attribute_value = rt.call_function('sanitize_title', [
						var_attribute_value.clone()])
				}
			}
			var_attributes.array_set(var_attribute_key, var_attribute_value.clone())
		}
		rt.call_method(var_variation, 'set_attributes', [var_attributes.clone()])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Product_Importer) get_variation_parent_attributes(var_attributes rt.PhpVal, var_parent rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_parent_mutated := var_parent
	mut var_parent_attributes := rt.call_method(var_parent_mutated, 'get_attributes', []rt.PhpVal{})
	mut var_require_save := rt.new_bool(false)
	mut iter_6 := var_attributes_mutated.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_attribute := item_6.val
		mut var_attribute_id := rt.new_int(0)
		if !(!rt.is_true(var_attribute.array_get(rt.new_string('taxonomy')))) {
			var_attribute_id =
				this.get_attribute_taxonomy_id(var_attribute.array_get(rt.new_string('name')))
		}
		if rt.is_true(var_attribute_id) {
			mut var_attribute_name := rt.call_function('sanitize_title', [
				rt.call_function('wc_attribute_taxonomy_name_by_id', [
					var_attribute_id.clone()]),
			])
		} else {
			var_attribute_name = rt.call_function('sanitize_title', [
				var_attribute.array_get(rt.new_string('name')),
			])
		}
		if var_parent_attributes.array_isset(var_attribute_name)
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'get_variation', []rt.PhpVal{}))))) {
			var_parent_attributes.array_set(var_attribute_name,
				var_parent_attributes.array_get(var_attribute_name).dup())
			rt.call_method(var_parent_attributes.array_get(var_attribute_name), 'set_variation', [
				rt.new_int(1),
			])
			var_require_save = rt.new_bool(true)
		}
	}
	if rt.is_true(var_require_save) {
		rt.call_method(var_parent_mutated, 'set_attributes', [
			rt.call_function('array_values', [var_parent_attributes.clone()]),
		])
		rt.call_method(var_parent_mutated, 'save', []rt.PhpVal{})
	}
	return var_parent_attributes.clone()
}

fn (mut this Class_WC_Product_Importer) get_attachment_id_from_url(var_url rt.PhpVal, var_product_id rt.PhpVal) i64 {
	mut var_product_id_mutated := var_product_id
	if !rt.is_true(var_url) {
		return 0
	}
	mut var_id := rt.new_int(0)
	mut var_upload_dir := rt.call_function('wp_upload_dir', [
		rt.new_null(), rt.new_bool(false)])
	mut var_base_url := rt.new_string(
		(var_upload_dir.array_get(rt.new_string('baseurl'))).str() + '/')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_url.clone(), var_base_url.clone()])))))
		|| rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_url.clone(), rt.new_string('://')]))) {
		mut var_file := rt.call_function('str_replace', [var_base_url.clone(),
			rt.new_string(''), var_url.clone()])
		mut var_args := {
			'post_type':   rt.new_string('attachment')
			'post_status': rt.new_string('any')
			'fields':      rt.new_string('ids')
			'meta_query':  {
				'relation': rt.new_string('OR')
			}
		}
	} else {
		var_args = {
			'post_type':   rt.new_string('attachment')
			'post_status': rt.new_string('any')
			'fields':      rt.new_string('ids')
			'meta_query':  map[string]rt.PhpVal{}
		}
	}
	mut var_ids := rt.call_function('get_posts', [
		rt.create_array_from_native_map(var_args),
	])
	if rt.is_true(var_ids) {
		var_id = rt.call_function('current', [var_ids.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id))))
		&& rt.is_true(rt.call_function('stristr', [var_url.clone(), rt.new_string('://')])) {
		mut var_upload := rt.call_function('wc_rest_upload_image_from_url', [
			var_url.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_upload.clone()])) {
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_upload,
				'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
		}
		var_id = rt.call_function('wc_rest_set_uploaded_image_as_attachment', [
			var_upload.clone(),
			var_product_id_mutated.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_attachment_is_image', [
			var_id.clone(),
		])))))
		{
			rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Not able to attach "%s".'),
					rt.new_string('woocommerce')]),
				var_url.clone(),
			]), rt.new_int(400))))
		}
		rt.call_function('update_post_meta', [var_id.clone(),
			rt.new_string('_wc_attachment_source'), var_url.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Unable to use image "%s".'),
				rt.new_string('woocommerce')]),
			var_url.clone(),
		]), rt.new_int(400))))
	}
	return var_id.to_i64()
}

fn (mut this Class_WC_Product_Importer) get_attribute_taxonomy_id(var_raw_name rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_wc_product_attributes := rt.get_superglobal('wc_product_attributes')
	mut var_attribute_labels := rt.call_function('wp_list_pluck', [
		rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}),
		rt.new_string('attribute_label'),
		rt.new_string('attribute_name'),
	])
	mut var_attribute_name := rt.call_function('array_search', [
		var_raw_name.clone(), var_attribute_labels.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute_name)))) {
		var_attribute_name = rt.call_function('wc_sanitize_taxonomy_name', [
			var_raw_name.clone()])
	}
	mut var_attribute_id := rt.call_function('wc_attribute_taxonomy_id_by_name', [
		var_attribute_name.clone(),
	])
	if rt.is_true(var_attribute_id) {
		return var_attribute_id.clone()
	}
	var_attribute_id = rt.call_function('wc_create_attribute', [
		rt.create_array([rt.ArrayItem{ key: 'name', val: var_raw_name },
			rt.ArrayItem{ key: 'slug', val: var_attribute_name },
			rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{
				key: 'order_by'
				val: 'menu_order'
			}, rt.ArrayItem{ key: 'has_archives', val: false }]),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_attribute_id.clone()])) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_attribute_id,
			'get_error_message', []rt.PhpVal{}), rt.new_int(400))))
	}
	mut var_taxonomy_name := rt.call_function('wc_attribute_taxonomy_name', [
		var_attribute_name.clone()])
	rt.call_function('register_taxonomy', [var_taxonomy_name.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_objects_' + var_taxonomy_name.str()),
			rt.create_array([rt.ArrayItem{ key: none, val: 'product' }]),
		]),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_taxonomy_args_' + var_taxonomy_name.str()),
			rt.create_array([rt.ArrayItem{ key: 'labels', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_raw_name },
			]) }, rt.ArrayItem{ key: 'hierarchical', val: true },
				rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{
					key: 'query_var'
					val: true
				}, rt.ArrayItem{ key: 'rewrite', val: false }]),
		])])
	var_wc_product_attributes = []rt.PhpVal{}
	mut iter_7 := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_taxonomy := item_7.val
		var_wc_product_attributes.array_set(rt.call_function('wc_attribute_taxonomy_name', [
			rt.get_property(var_taxonomy, 'attribute_name'),
		]), var_taxonomy.clone())
	}
	return var_attribute_id.clone()
}

fn (mut this Class_WC_Product_Importer) memory_exceeded() rt.PhpVal {
	mut var_memory_limit := rt.new_float(this.get_memory_limit() * 0.9)
	mut var_current_memory := rt.call_function('memory_get_usage', [
		rt.new_bool(true)])
	mut var_return := rt.new_bool(false)
	if rt.is_true(rt.greater_equal(var_current_memory, var_memory_limit)) {
		var_return = rt.new_bool(true)
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_importer_memory_exceeded'),
		var_return.clone(),
	])
}

fn (mut this Class_WC_Product_Importer) get_memory_limit() rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')])) {
		mut var_memory_limit := rt.call_function('ini_get', [
			rt.new_string('memory_limit'),
		])
	} else {
		var_memory_limit = rt.new_string('128M')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_memory_limit))))
		|| -1 == var_memory_limit.clone().to_i64() {
		var_memory_limit = rt.new_string('32000M')
	}
	return rt.call_function('wp_convert_hr_to_bytes', [var_memory_limit.clone()])
}

fn (mut this Class_WC_Product_Importer) time_exceeded() rt.PhpVal {
	mut var_finish := rt.add(this.start_time, rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_importer_default_time_limit'),
		rt.new_int(20),
	]))
	mut var_return := rt.new_bool(false)
	if rt.is_true(rt.greater_equal(rt.call_function('time', []rt.PhpVal{}), var_finish)) {
		var_return = rt.new_bool(true)
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_importer_time_exceeded'),
		var_return.clone(),
	])
}

fn (mut this Class_WC_Product_Importer) explode_values(var_value rt.PhpVal, separator string) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = rt.call_function('str_replace', [rt.new_string('\\,'),
		rt.new_string('::separator::'), var_value_mutated.clone()])
	mut var_values := rt.call_function('explode', [rt.new_string(separator),
		var_value_mutated.clone()])
	var_values = rt.call_function('array_map', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_Importer', [
				'WC_Importer_Interface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'explode_values_formatter' },
		]),
		var_values.clone(),
	])
	return var_values.clone()
}

fn (mut this Class_WC_Product_Importer) explode_values_formatter(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	return rt.call_function('str_replace', [rt.new_string('::separator::'),
		rt.new_string(','), var_value_mutated.clone()]).to_string().trim_space()
}

fn (mut this Class_WC_Product_Importer) unescape_data(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_active_content_triggers := ["'=", "'+", "'-", "'@"]
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('mb_substr', [var_value_mutated.clone(),
			rt.new_int(0), rt.new_int(2)]),
		rt.create_array_from_list(var_active_content_triggers),
		rt.new_bool(true),
	]))
	{
		var_value_mutated = rt.call_function('mb_substr', [var_value_mutated.clone(),
			rt.new_int(1)])
	}
	return var_value_mutated.clone()
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
	code    i64
	file    string
	line    i64
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

fn create_wc_product_importer(_args ...rt.PhpVal) &Class_WC_Product_Importer {
	mut obj := &Class_WC_Product_Importer{
		PhpObjectBase:  rt.PhpObjectBase{}
		file:           rt.new_string('')
		file_position:  rt.new_int(0)
		params:         rt.new_array()
		raw_keys:       rt.new_array()
		mapped_keys:    rt.new_array()
		raw_data:       rt.new_array()
		file_positions: rt.new_array()
		parsed_data:    rt.new_array()
		start_time:     rt.new_int(0)
	}
	return obj
}

fn create_wc_admin_exporters(_args ...rt.PhpVal) &Class_WC_Admin_Exporters {
	mut obj := &Class_WC_Admin_Exporters{
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

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_product_attribute(_args ...rt.PhpVal) &Class_WC_Product_Attribute {
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
		else {
			return none
		}
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
		'file' {
			this.file = val
			return true
		}
		'file_position' {
			this.file_position = val
			return true
		}
		'params' {
			this.params = val
			return true
		}
		'raw_keys' {
			this.raw_keys = val
			return true
		}
		'mapped_keys' {
			this.mapped_keys = val
			return true
		}
		'raw_data' {
			this.raw_data = val
			return true
		}
		'file_positions' {
			this.file_positions = val
			return true
		}
		'parsed_data' {
			this.parsed_data = val
			return true
		}
		'start_time' {
			this.start_time = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
		else {
			return none
		}
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
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
		rt.new_string('WC_Importer_Interface'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file(
			(rt.get_constant('WC_ABSPATH')).str() + 'includes/interfaces/class-wc-importer-interface.php',
			'2')
	}
}
