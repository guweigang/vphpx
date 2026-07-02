import rt

struct Class_WC_Product_CSV_Exporter {
	rt.PhpObjectBase
pub mut:
	export_type                rt.PhpVal = rt.new_string('product')
	enable_meta_export         rt.PhpVal = rt.new_bool(false)
	product_types_to_export    rt.PhpVal = rt.new_array()
	product_category_to_export rt.PhpVal = rt.new_array()
	product_ids_to_export      rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_CSV_Exporter) construct() {
	this.Class_WC_CSV_Batch_Exporter.construct()
	mut iife_temp_0 := Class_WC_Admin_Exporters{}
	mut iife_result_0 := iife_temp_0.get_product_types()
	this.set_product_types_to_export(rt.func_array_keys(iife_result_0))
}

fn (mut this Class_WC_Product_CSV_Exporter) enable_meta_export(var_enable_meta_export rt.PhpVal) {
	this.enable_meta_export = var_enable_meta_export.to_bool()
}

fn (mut this Class_WC_Product_CSV_Exporter) set_product_types_to_export(var_product_types_to_export rt.PhpVal) {
	this.product_types_to_export = rt.call_function('array_map', [
		rt.new_string('wc_clean'),
		var_product_types_to_export.clone(),
	])
}

fn (mut this Class_WC_Product_CSV_Exporter) set_product_category_to_export(var_product_category_to_export rt.PhpVal) {
	this.product_category_to_export = rt.call_function('array_map', [
		rt.new_string('sanitize_title_with_dashes'),
		var_product_category_to_export.clone(),
	])
}

fn (mut this Class_WC_Product_CSV_Exporter) set_product_ids_to_export(var_product_ids rt.PhpVal) {
	this.product_ids_to_export = rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('absint'),
			rt.cast_array(var_product_ids)]),
	])
}

fn (mut this Class_WC_Product_CSV_Exporter) get_default_column_names() rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_1 := iife_temp_1.get_weight_unit_label(rt.call_function('get_option', [
		rt.new_string('woocommerce_weight_unit'),
		rt.new_string('kg'),
	]))
	mut var_weight_unit_label := iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_2 := iife_temp_2.get_dimensions_unit_label(rt.call_function('get_option', [
		rt.new_string('woocommerce_dimension_unit'),
		rt.new_string('cm'),
	]))
	mut var_dimension_unit_label := iife_result_2
	mut var_default_columns := {
		'id':                 rt.call_function('__', [rt.new_string('ID'),
			rt.new_string('woocommerce')])
		'type':               rt.call_function('__', [rt.new_string('Type'),
			rt.new_string('woocommerce')])
		'sku':                rt.call_function('__', [rt.new_string('SKU'),
			rt.new_string('woocommerce')])
		'global_unique_id':   rt.call_function('__', [
			rt.new_string('GTIN, UPC, EAN, or ISBN'),
			rt.new_string('woocommerce'),
		])
		'name':               rt.call_function('__', [rt.new_string('Name'),
			rt.new_string('woocommerce')])
		'published':          rt.call_function('__', [rt.new_string('Published'),
			rt.new_string('woocommerce')])
		'featured':           rt.call_function('__', [rt.new_string('Is featured?'),
			rt.new_string('woocommerce')])
		'catalog_visibility': rt.call_function('__', [
			rt.new_string('Visibility in catalog'),
			rt.new_string('woocommerce'),
		])
		'short_description':  rt.call_function('__', [rt.new_string('Short description'),
			rt.new_string('woocommerce')])
		'description':        rt.call_function('__', [rt.new_string('Description'),
			rt.new_string('woocommerce')])
		'date_on_sale_from':  rt.call_function('__', [
			rt.new_string('Date sale price starts'),
			rt.new_string('woocommerce'),
		])
		'date_on_sale_to':    rt.call_function('__', [
			rt.new_string('Date sale price ends'),
			rt.new_string('woocommerce'),
		])
		'tax_status':         rt.call_function('__', [rt.new_string('Tax status'),
			rt.new_string('woocommerce')])
		'tax_class':          rt.call_function('__', [rt.new_string('Tax class'),
			rt.new_string('woocommerce')])
		'stock_status':       rt.call_function('__', [rt.new_string('In stock?'),
			rt.new_string('woocommerce')])
		'stock':              rt.call_function('__', [rt.new_string('Stock'),
			rt.new_string('woocommerce')])
		'low_stock_amount':   rt.call_function('__', [rt.new_string('Low stock amount'),
			rt.new_string('woocommerce')])
		'backorders':         rt.call_function('__', [
			rt.new_string('Backorders allowed?'),
			rt.new_string('woocommerce'),
		])
		'sold_individually':  rt.call_function('__', [
			rt.new_string('Sold individually?'),
			rt.new_string('woocommerce'),
		])
		'weight':             rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Weight (%s)'),
				rt.new_string('woocommerce')]),
			var_weight_unit_label.clone(),
		])
		'length':             rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Length (%s)'),
				rt.new_string('woocommerce')]),
			var_dimension_unit_label.clone(),
		])
		'width':              rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Width (%s)'),
				rt.new_string('woocommerce')]),
			var_dimension_unit_label.clone(),
		])
		'height':             rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Height (%s)'),
				rt.new_string('woocommerce')]),
			var_dimension_unit_label.clone(),
		])
		'reviews_allowed':    rt.call_function('__', [
			rt.new_string('Allow customer reviews?'),
			rt.new_string('woocommerce'),
		])
		'purchase_note':      rt.call_function('__', [rt.new_string('Purchase note'),
			rt.new_string('woocommerce')])
		'sale_price':         rt.call_function('__', [rt.new_string('Sale price'),
			rt.new_string('woocommerce')])
		'regular_price':      rt.call_function('__', [rt.new_string('Regular price'),
			rt.new_string('woocommerce')])
		'category_ids':       rt.call_function('__', [rt.new_string('Categories'),
			rt.new_string('woocommerce')])
		'tag_ids':            rt.call_function('__', [rt.new_string('Tags'),
			rt.new_string('woocommerce')])
		'shipping_class_id':  rt.call_function('__', [rt.new_string('Shipping class'),
			rt.new_string('woocommerce')])
		'images':             rt.call_function('__', [rt.new_string('Images'),
			rt.new_string('woocommerce')])
		'download_limit':     rt.call_function('__', [rt.new_string('Download limit'),
			rt.new_string('woocommerce')])
		'download_expiry':    rt.call_function('__', [
			rt.new_string('Download expiry days'),
			rt.new_string('woocommerce'),
		])
		'parent_id':          rt.call_function('__', [rt.new_string('Parent'),
			rt.new_string('woocommerce')])
		'grouped_products':   rt.call_function('__', [rt.new_string('Grouped products'),
			rt.new_string('woocommerce')])
		'upsell_ids':         rt.call_function('__', [rt.new_string('Upsells'),
			rt.new_string('woocommerce')])
		'cross_sell_ids':     rt.call_function('__', [rt.new_string('Cross-sells'),
			rt.new_string('woocommerce')])
		'product_url':        rt.call_function('__', [rt.new_string('External URL'),
			rt.new_string('woocommerce')])
		'button_text':        rt.call_function('__', [rt.new_string('Button text'),
			rt.new_string('woocommerce')])
		'menu_order':         rt.call_function('__', [rt.new_string('Position'),
			rt.new_string('woocommerce')])
	}
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		var_default_columns['cogs_value'] = rt.call_function('__', [
			rt.new_string('Cost of goods'),
			rt.new_string('woocommerce'),
		])
	}
	return rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_product_export_'), this.export_type),
			rt.new_string('_default_columns')),
		rt.create_array_from_native_map(var_default_columns),
	])
}

fn (mut this Class_WC_Product_CSV_Exporter) prepare_data_to_export() {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.private() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.draft() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.future() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_ProductStatus.pending() },
		]) },
		rt.ArrayItem{ key: 'limit', val: this.get_limit() },
		rt.ArrayItem{ key: 'page', val: this.get_page() },
		rt.ArrayItem{ key: 'orderby', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: 'ASC' },
		]) },
		rt.ArrayItem{ key: 'return', val: 'objects' },
		rt.ArrayItem{ key: 'paginate', val: true },
	])
	if !(!rt.is_true(this.product_ids_to_export)) {
		var_args.array_set('include', this.product_ids_to_export)
	} else {
		var_args.array_set('type', this.product_types_to_export)
		if !(!rt.is_true(this.product_category_to_export)) {
			var_args.array_set('category', this.product_category_to_export)
		}
	}
	var_args = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('woocommerce_product_export_'), this.export_type),
			rt.new_string('_query_args')),
		var_args.clone(),
	])
	if !(!rt.is_true(var_args.array_get(rt.new_string('include')))) {
		var_args.array_set('include', rt.call_function('array_map', [
			rt.new_string('absint'),
			rt.cast_array(var_args.array_get(rt.new_string('include'))),
		]))
	}
	mut var_products := rt.call_function('wc_get_products', [
		var_args.clone()])
	this.dispatch_set_prop('total_rows', rt.get_property(var_products, 'total'))
	this.dispatch_set_prop('row_data', rt.new_array())
	mut var_variable_products := rt.new_array()
	mut iter_1 := rt.get_property(var_products, 'products').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_product := item_1.val
		if !(!rt.is_true(var_args.array_get(rt.new_string('include'))))
			|| !(!rt.is_true(var_args.array_get(rt.new_string('category'))))
			&& rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.create_array_from_list(var_variable_products), rt.new_bool(true)]))))) {
			var_variable_products << rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		}
		rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
			'WC_CSV_Batch_Exporter',
		], &this), 'row_data').array_push(this.generate_row_data(var_product.clone()))
	}
	if !(!rt.is_true(var_variable_products)) {
		for var_parent_id in var_variable_products {
			var_products = rt.call_function('wc_get_products', [
				rt.create_array([rt.ArrayItem{ key: 'parent', val: var_parent_id },
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Enums_ProductType.variation()
						},
					]) }, rt.ArrayItem{ key: 'return', val: 'objects' },
					rt.ArrayItem{ key: 'limit', val: -1 }]),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_products)))) {
				continue
			}
			mut iter_2 := var_products.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_product := item_2.val
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'row_data').array_push(this.generate_row_data(var_product.clone()))
			}
		}
	}
}

fn (mut this Class_WC_Product_CSV_Exporter) generate_row_data(var_product rt.PhpVal) rt.PhpVal {
	mut var_columns := this.get_column_names()
	mut var_row := rt.new_array()
	mut iter_3 := var_columns.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_column_name := item_3.val
		mut var_column_id := item_3.key
		var_column_id = if rt.is_true(rt.call_function('strstr', [
			var_column_id.clone(), rt.new_string(':')]))
		{ rt.call_function('current', [
				rt.call_function('explode', [rt.new_string(':'),
					var_column_id.clone()]),
			]) } else { var_column_id }
		mut var_value := rt.new_string('')
		if rt.is_true(rt.call_function('in_array', [var_column_id.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 'downloads'
		}, rt.ArrayItem{ key: none, val: 'attributes' }, rt.ArrayItem{ key: none, val: 'meta' }]), rt.new_bool(true)]))
			|| rt.is_true(rt.new_bool(!(rt.is_true(this.is_column_exporting(var_column_id.clone()))))) {
			continue
		}
		if rt.is_true(rt.call_function('has_filter', [
			rt.concat(rt.concat(rt.concat(rt.new_string('woocommerce_product_export_'),
				this.export_type), rt.new_string('_column_')), var_column_id),
		]))
		{
			var_value = rt.call_function('apply_filters', [
				rt.concat(rt.concat(rt.concat(rt.new_string('woocommerce_product_export_'),
					this.export_type), rt.new_string('_column_')), var_column_id),
				rt.new_string(''),
				var_product.clone(),
				var_column_id.clone(),
			])
		} else if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_column_value_${var_column_id.to_string()}' },
			]),
		]))
		{
			var_value = rt.call_method(rt.new_object('WC_Product_CSV_Exporter', [
				'WC_CSV_Batch_Exporter',
			], &this), 'get_column_value_${var_column_id.to_string()}', [
				var_product.clone()])
		} else if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_product },
				rt.ArrayItem{ key: none, val: 'get_${var_column_id.to_string()}' }]),
		]))
		{
			var_value = rt.call_method(var_product, 'get_${var_column_id.to_string()}', [
				rt.new_string('edit'),
			])
		}
		if rt.is_true(rt.identical(rt.new_string('description'), var_column_id))
			|| rt.is_true(rt.identical(rt.new_string('short_description'), var_column_id)) {
			var_value = this.filter_description_field(var_value.clone())
		}
		var_row.array_set(var_column_id, var_value.clone())
	}
	this.prepare_downloads_for_export(var_product.clone(), var_row.clone())
	this.prepare_attributes_for_export(var_product.clone(), var_row.clone())
	this.prepare_meta_for_export(var_product.clone(), var_row.clone())
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_export_row_data'),
		var_row.clone(),
		var_product.clone(),
		rt.new_object('WC_Product_CSV_Exporter', ['WC_CSV_Batch_Exporter'], &this),
	])
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_published(var_product rt.PhpVal) rt.PhpVal {
	mut var_statuses := rt.create_array([
		rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductStatus.draft(), val: -1 },
		rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductStatus.private(), val: 0 },
		rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), val: 1 },
	])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.variation(), rt.call_method(var_product,
		'get_type', []rt.PhpVal{})))
	{
		mut var_parent := rt.call_method(var_product, 'get_parent_data', []rt.PhpVal{})
		mut var_status := if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.draft(), var_parent.array_get(rt.new_string('status')))) { var_parent.array_get(rt.new_string('status')) } else { rt.call_method(var_product, 'get_status', [
				rt.new_string('edit'),
			]) }
	} else {
		var_status = rt.call_method(var_product, 'get_status', [
			rt.new_string('edit')])
	}
	return if var_statuses.array_isset(var_status) { var_statuses.array_get(var_status) } else { -1 }
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_sale_price(var_product rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_format_localized_price', [
		rt.call_method(var_product, 'get_sale_price', [rt.new_string('view')]),
	])
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_regular_price(var_product rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_format_localized_price', [
		rt.call_method(var_product, 'get_regular_price', []rt.PhpVal{}),
	])
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_category_ids(var_product rt.PhpVal) rt.PhpVal {
	mut var_term_ids := rt.call_method(var_product, 'get_category_ids', [
		rt.new_string('edit'),
	])
	return this.format_term_ids(var_term_ids.clone(), rt.new_string('product_cat'))
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_tag_ids(var_product rt.PhpVal) rt.PhpVal {
	mut var_term_ids := rt.call_method(var_product, 'get_tag_ids', [
		rt.new_string('edit'),
	])
	return this.format_term_ids(var_term_ids.clone(), rt.new_string('product_tag'))
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_shipping_class_id(var_product rt.PhpVal) rt.PhpVal {
	mut var_term_ids := rt.call_method(var_product, 'get_shipping_class_id', [
		rt.new_string('edit'),
	])
	return this.format_term_ids(var_term_ids.clone(), rt.new_string('product_shipping_class'))
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_images(var_product rt.PhpVal) rt.PhpVal {
	mut var_image_ids := rt.call_function('array_merge', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_method(var_product, 'get_image_id', [
				rt.new_string('edit'),
			]) },
		]),
		rt.call_method(var_product, 'get_gallery_image_ids', [
			rt.new_string('edit'),
		]),
	])
	mut var_images := rt.new_array()
	mut iter_4 := var_image_ids.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_image_id := item_4.val
		mut var_image := rt.call_function('wp_get_attachment_image_src', [
			var_image_id.clone(), rt.new_string('full')])
		if rt.is_true(var_image) {
			var_images << var_image.array_get(rt.new_int(0))
		}
	}
	return this.implode_values(var_images.clone())
}

fn (mut this Class_WC_Product_CSV_Exporter) prepare_linked_products_for_export(var_linked_products rt.PhpVal) rt.PhpVal {
	mut var_product_list := rt.new_array()
	mut iter_5 := var_linked_products.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_linked_product := item_5.val
		if rt.is_true(rt.call_method(var_linked_product, 'get_sku', []rt.PhpVal{})) {
			var_product_list << rt.call_method(var_linked_product, 'get_sku', []rt.PhpVal{})
		} else {
			var_product_list << 'id:' +
				(rt.call_method(var_linked_product, 'get_id', []rt.PhpVal{})).str()
		}
	}
	return this.implode_values(var_product_list.clone())
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_cross_sell_ids(var_product rt.PhpVal) rt.PhpVal {
	return this.prepare_linked_products_for_export(rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('wc_get_product'),
			rt.cast_array(rt.call_method(var_product, 'get_cross_sell_ids', [
				rt.new_string('edit'),
			]))]),
	]))
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_upsell_ids(var_product rt.PhpVal) rt.PhpVal {
	return this.prepare_linked_products_for_export(rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('wc_get_product'),
			rt.cast_array(rt.call_method(var_product, 'get_upsell_ids', [
				rt.new_string('edit'),
			]))]),
	]))
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_parent_id(var_product rt.PhpVal) string {
	if rt.is_true(rt.call_method(var_product, 'get_parent_id', [
		rt.new_string('edit')]))
	{
		mut var_parent := rt.call_function('wc_get_product', [
			rt.call_method(var_product, 'get_parent_id', [rt.new_string('edit')]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_parent)))) {
			return ''
		}
		return (if rt.is_true(rt.call_method(var_parent, 'get_sku', [
			rt.new_string('edit'),
		]))
		{
			rt.call_method(var_parent, 'get_sku', [rt.new_string('edit')])
		} else {
			'id:' + (rt.call_method(var_parent, 'get_id', []rt.PhpVal{})).str()
		}).str()
	}
	return ''
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_grouped_products(var_product rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductType.grouped(), rt.call_method(var_product,
		'get_type', []rt.PhpVal{})))))
	{
		return ''
	}
	mut var_grouped_products := rt.new_array()
	mut var_child_ids := rt.call_method(var_product, 'get_children', [
		rt.new_string('edit'),
	])
	mut iter_6 := var_child_ids.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_child_id := item_6.val
		mut var_child := rt.call_function('wc_get_product', [
			var_child_id.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_child)))) {
			continue
		}
		var_grouped_products << if rt.is_true(rt.call_method(var_child, 'get_sku', [
			rt.new_string('edit'),
		]))
		{
			rt.call_method(var_child, 'get_sku', [rt.new_string('edit')])
		} else {
			'id:' + var_child_id.str()
		}
	}
	return (this.implode_values(var_grouped_products.clone())).str()
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_download_limit(var_product rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product, 'get_download_limit', [rt.new_string('edit')])) { rt.call_method(var_product, 'get_download_limit', [
			rt.new_string('edit'),
		]) } else { rt.new_string('') }
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_download_expiry(var_product rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product, 'get_download_expiry', [rt.new_string('edit')])) { rt.call_method(var_product, 'get_download_expiry', [
			rt.new_string('edit'),
		]) } else { rt.new_string('') }
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_stock(var_product rt.PhpVal) string {
	mut var_manage_stock := rt.call_method(var_product, 'get_manage_stock', [
		rt.new_string('edit'),
	])
	mut var_stock_quantity := rt.call_method(var_product, 'get_stock_quantity', [
		rt.new_string('edit'),
	])
	if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()]))
		&& rt.is_true(rt.identical(rt.new_string('parent'), var_manage_stock)) {
		return 'parent'
	} else if rt.is_true(var_manage_stock) {
		return var_stock_quantity.str()
	} else {
		return ''
	}
	return ''
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_stock_status(var_product rt.PhpVal) rt.PhpVal {
	mut var_status := rt.call_method(var_product, 'get_stock_status', [
		rt.new_string('edit'),
	])
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder(),
		var_status))
	{
		return rt.new_string('backorder')
	}
	return rt.new_int(if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock(),
		var_status))
	{
		1
	} else {
		0
	})
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_backorders(var_product rt.PhpVal) rt.PhpVal {
	mut var_backorders := rt.call_method(var_product, 'get_backorders', [
		rt.new_string('edit'),
	])
	mut switch_val_1 := var_backorders
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('notify'))) {
		return rt.new_string('notify')
	} else {
		return rt.new_int(if rt.is_true(rt.call_function('wc_string_to_bool', [
			var_backorders.clone(),
		]))
		{ 1 } else { 0 })
	}
	return rt.new_null()
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_low_stock_amount(var_product rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_product, 'get_low_stock_amount', [rt.new_string('edit')])) { rt.call_method(var_product, 'get_low_stock_amount', [
			rt.new_string('edit'),
		]) } else { rt.new_string('') }
}

fn (mut this Class_WC_Product_CSV_Exporter) get_column_value_type(var_product rt.PhpVal) rt.PhpVal {
	mut var_types := rt.new_array()
	var_types << rt.call_method(var_product, 'get_type', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) {
		var_types << rt.new_string('downloadable')
	}
	if rt.is_true(rt.call_method(var_product, 'is_virtual', []rt.PhpVal{})) {
		var_types << rt.new_string('virtual')
	}
	return this.implode_values(var_types.clone())
}

fn (mut this Class_WC_Product_CSV_Exporter) filter_description_field(var_description rt.PhpVal) rt.PhpVal {
	mut var_description_mutated := var_description
	var_description_mutated = rt.call_function('str_replace', [
		rt.new_string('\\n'), rt.new_string('\\\\n'), var_description_mutated.clone()])
	var_description_mutated = rt.call_function('str_replace', [
		rt.new_string('\n'), rt.new_string('\\n'), var_description_mutated.clone()])
	return var_description_mutated.clone()
}

fn (mut this Class_WC_Product_CSV_Exporter) prepare_downloads_for_export(var_product rt.PhpVal, var_row rt.PhpVal) {
	mut var_row_mutated := var_row
	if rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{}))
		&& rt.is_true(this.is_column_exporting(rt.new_string('downloads'))) {
		mut var_downloads := rt.call_method(var_product, 'get_downloads', [
			rt.new_string('edit'),
		])
		if rt.is_true(var_downloads) {
			mut var_i := rt.new_int(1)
			mut iter_7 := var_downloads.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_download := item_7.val
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set('downloads:id' + var_i.str(), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Download %d ID'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]))
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set('downloads:name' + var_i.str(), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Download %d name'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]))
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set('downloads:url' + var_i.str(), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Download %d URL'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]))
				var_row_mutated.array_set('downloads:id' + var_i.str(), rt.call_method(var_download,
					'get_id', []rt.PhpVal{}))
				var_row_mutated.array_set('downloads:name' + var_i.str(), rt.call_method(var_download,
					'get_name', []rt.PhpVal{}))
				var_row_mutated.array_set('downloads:url' + var_i.str(), rt.call_method(var_download,
					'get_file', []rt.PhpVal{}))
				rt.pre_inc(var_i)
			}
		}
	}
}

fn (mut this Class_WC_Product_CSV_Exporter) prepare_attributes_for_export(var_product rt.PhpVal, var_row rt.PhpVal) {
	mut var_row_mutated := var_row
	if rt.is_true(this.is_column_exporting(rt.new_string('attributes'))) {
		mut var_attributes := rt.call_method(var_product, 'get_attributes', []rt.PhpVal{})
		mut var_default_attributes := rt.call_method(var_product, 'get_default_attributes',
			[]rt.PhpVal{})
		if rt.is_true(rt.new_int(var_attributes.clone().array_count())) {
			mut var_i := rt.new_int(1)
			mut iter_8 := var_attributes.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_attribute := item_8.val
				mut var_attribute_name := item_8.key
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set('attributes:name' + var_i.str(), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Attribute %d name'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]))
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set('attributes:value' + var_i.str(), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Attribute %d value(s)'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]))
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set('attributes:visible' + var_i.str(), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Attribute %d visible'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]))
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set('attributes:taxonomy' + var_i.str(), rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Attribute %d global'),
						rt.new_string('woocommerce')]),
					var_i.clone(),
				]))
				if rt.is_true(rt.call_function('is_a', [var_attribute.clone(),
					rt.new_string('WC_Product_Attribute')]))
				{
					var_row_mutated.array_set('attributes:name' + var_i.str(), rt.call_function('html_entity_decode', [
						rt.call_function('wc_attribute_label', [
							rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
							var_product.clone(),
						]),
						rt.get_constant('ENT_QUOTES'),
					]))
					if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
						mut var_terms := rt.call_method(var_attribute, 'get_terms', []rt.PhpVal{})
						mut var_values := rt.new_array()
						mut iter_9 := var_terms.iterator()
						for {
							item_9 := iter_9.next() or { break }
							mut var_term := item_9.val
							var_values << rt.get_property(var_term, 'name')
						}
						var_row_mutated.array_set('attributes:value' + var_i.str(),
							this.implode_values(var_values.clone()))
						var_row_mutated.array_set('attributes:taxonomy' + var_i.str(), 1)
					} else {
						var_row_mutated.array_set('attributes:value' + var_i.str(), this.implode_values(rt.call_method(var_attribute,
							'get_options', []rt.PhpVal{})))
						var_row_mutated.array_set('attributes:taxonomy' + var_i.str(), 0)
					}
					var_row_mutated.array_set('attributes:visible' + var_i.str(), rt.call_method(var_attribute,
						'get_visible', []rt.PhpVal{}))
				} else {
					var_row_mutated.array_set('attributes:name' + var_i.str(), rt.call_function('html_entity_decode', [
						rt.call_function('wc_attribute_label', [
							var_attribute_name.clone(), var_product.clone()]),
						rt.get_constant('ENT_QUOTES'),
					]))
					if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
						var_attribute_name.clone(),
						rt.new_string('pa_'),
					])))
					{
						mut var_option_term := rt.call_function('get_term_by', [
							rt.new_string('slug'),
							var_attribute.clone(),
							var_attribute_name.clone(),
						])
						var_row_mutated.array_set('attributes:value' + var_i.str(), if rt.is_true(var_option_term) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_option_term.clone()]))))) { rt.call_function('html_entity_decode', [
								rt.call_function('str_replace', [
									rt.new_string(','), rt.new_string('\\,'),
									rt.get_property(var_option_term, 'name')]),
								rt.get_constant('ENT_QUOTES'),
							]) } else { rt.call_function('html_entity_decode', [
								rt.call_function('str_replace', [
									rt.new_string(','), rt.new_string('\\,'),
									var_attribute.clone()]),
								rt.get_constant('ENT_QUOTES'),
							]) })
						var_row_mutated.array_set('attributes:taxonomy' + var_i.str(), 1)
					} else {
						var_row_mutated.array_set('attributes:value' + var_i.str(), rt.call_function('html_entity_decode', [
							rt.call_function('str_replace', [
								rt.new_string(','), rt.new_string('\\,'),
								var_attribute.clone()]),
							rt.get_constant('ENT_QUOTES'),
						]))
						var_row_mutated.array_set('attributes:taxonomy' + var_i.str(), 0)
					}
					var_row_mutated.array_set('attributes:visible' + var_i.str(), '')
				}
				if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()]))
					&& var_default_attributes.array_isset(rt.call_function('sanitize_title', [var_attribute_name.clone()])) {
					rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
						'WC_CSV_Batch_Exporter',
					], &this), 'column_names').array_set('attributes:default' + var_i.str(), rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Attribute %d default'),
							rt.new_string('woocommerce')]),
						var_i.clone(),
					]))
					mut var_default_value := var_default_attributes.array_get(rt.call_function('sanitize_title', [
						var_attribute_name.clone(),
					]))
					if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
						var_attribute_name.clone(),
						rt.new_string('pa_'),
					])))
					{
						var_option_term = rt.call_function('get_term_by', [
							rt.new_string('slug'),
							var_default_value.clone(),
							var_attribute_name.clone(),
						])
						var_row_mutated.array_set('attributes:default' + var_i.str(), if
							rt.is_true(var_option_term)
							&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_option_term.clone()]))))) {
							rt.get_property(var_option_term, 'name')
						} else {
							var_default_value
						})
					} else {
						var_row_mutated.array_set('attributes:default' + var_i.str(),
							var_default_value.clone())
					}
				}
				rt.pre_inc(var_i)
			}
		}
	}
}

fn (mut this Class_WC_Product_CSV_Exporter) prepare_meta_for_export(var_product rt.PhpVal, var_row rt.PhpVal) {
	mut var_row_mutated := var_row
	if rt.is_true(this.enable_meta_export) {
		mut var_meta_data := rt.call_method(var_product, 'get_meta_data', []rt.PhpVal{})
		if rt.is_true(rt.new_int(var_meta_data.clone().array_count())) {
			mut var_meta_keys_to_skip := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_product_export_skip_meta_keys'),
				rt.new_array(),
				var_product.clone(),
			])
			mut var_i := rt.new_int(1)
			mut iter_10 := var_meta_data.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_meta := item_10.val
				if rt.is_true(rt.call_function('in_array', [
					rt.get_property(var_meta, 'key'),
					var_meta_keys_to_skip.clone(),
					rt.new_bool(true),
				]))
				{
					continue
				}
				mut var_meta_value := rt.call_function('apply_filters', [
					rt.new_string('woocommerce_product_export_meta_value'),
					rt.get_property(var_meta, 'value'),
					var_meta.clone(),
					var_product.clone(),
					var_row_mutated.clone(),
				])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [
					var_meta_value.clone(),
				])))))
				{
					continue
				}
				mut var_column_key := rt.new_string('meta:' +
					(rt.call_function('esc_attr', [rt.get_property(var_meta, 'key')])).str())
				rt.get_property(rt.new_object('WC_Product_CSV_Exporter', [
					'WC_CSV_Batch_Exporter',
				], &this), 'column_names').array_set(var_column_key, rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Meta: %s'),
						rt.new_string('woocommerce')]),
					rt.get_property(var_meta, 'key'),
				]))
				var_row_mutated.array_set(var_column_key, var_meta_value.clone())
				rt.pre_inc(var_i)
			}
		}
	}
}

struct Class_WC_CSV_Batch_Exporter {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Exporters {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_wc_product_csv_exporter() &Class_WC_Product_CSV_Exporter {
	mut obj := &Class_WC_Product_CSV_Exporter{
		PhpObjectBase:              rt.PhpObjectBase{}
		export_type:                rt.new_string('product')
		enable_meta_export:         rt.new_bool(false)
		product_types_to_export:    rt.new_array()
		product_category_to_export: rt.new_array()
		product_ids_to_export:      rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wc_csv_batch_exporter(_args ...rt.PhpVal) &Class_WC_CSV_Batch_Exporter {
	mut obj := &Class_WC_CSV_Batch_Exporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_exporters(_args ...rt.PhpVal) &Class_WC_Admin_Exporters {
	mut obj := &Class_WC_Admin_Exporters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_CSV_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'enable_meta_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.enable_meta_export(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_types_to_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_types_to_export(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_category_to_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_category_to_export(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_ids_to_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_ids_to_export(dispatch_arg_0)
			return rt.new_null()
		}
		'get_default_column_names' {
			return this.get_default_column_names()
		}
		'prepare_data_to_export' {
			this.prepare_data_to_export()
			return rt.new_null()
		}
		'generate_row_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_row_data(dispatch_arg_0)
		}
		'get_column_value_published' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_published(dispatch_arg_0)
		}
		'get_column_value_sale_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_sale_price(dispatch_arg_0)
		}
		'get_column_value_regular_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_regular_price(dispatch_arg_0)
		}
		'get_column_value_category_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_category_ids(dispatch_arg_0)
		}
		'get_column_value_tag_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_tag_ids(dispatch_arg_0)
		}
		'get_column_value_shipping_class_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_shipping_class_id(dispatch_arg_0)
		}
		'get_column_value_images' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_images(dispatch_arg_0)
		}
		'prepare_linked_products_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_linked_products_for_export(dispatch_arg_0)
		}
		'get_column_value_cross_sell_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_cross_sell_ids(dispatch_arg_0)
		}
		'get_column_value_upsell_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_upsell_ids(dispatch_arg_0)
		}
		'get_column_value_parent_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_column_value_parent_id(dispatch_arg_0))
		}
		'get_column_value_grouped_products' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_column_value_grouped_products(dispatch_arg_0))
		}
		'get_column_value_download_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_download_limit(dispatch_arg_0)
		}
		'get_column_value_download_expiry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_download_expiry(dispatch_arg_0)
		}
		'get_column_value_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_column_value_stock(dispatch_arg_0))
		}
		'get_column_value_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_stock_status(dispatch_arg_0)
		}
		'get_column_value_backorders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_backorders(dispatch_arg_0)
		}
		'get_column_value_low_stock_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_low_stock_amount(dispatch_arg_0)
		}
		'get_column_value_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_column_value_type(dispatch_arg_0)
		}
		'filter_description_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_description_field(dispatch_arg_0)
		}
		'prepare_downloads_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prepare_downloads_for_export(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_attributes_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prepare_attributes_for_export(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prepare_meta_for_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prepare_meta_for_export(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Product_CSV_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'export_type' { return this.export_type }
		'enable_meta_export' { return this.enable_meta_export }
		'product_types_to_export' { return this.product_types_to_export }
		'product_category_to_export' { return this.product_category_to_export }
		'product_ids_to_export' { return this.product_ids_to_export }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_CSV_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'export_type' {
			this.export_type = val
			return true
		}
		'enable_meta_export' {
			this.enable_meta_export = val
			return true
		}
		'product_types_to_export' {
			this.product_types_to_export = val
			return true
		}
		'product_category_to_export' {
			this.product_category_to_export = val
			return true
		}
		'product_ids_to_export' {
			this.product_ids_to_export = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_CSV_Batch_Exporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_CSV_Batch_Exporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_CSV_Batch_Exporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
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
