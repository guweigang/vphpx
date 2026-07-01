import rt

struct Class_WC_Meta_Box_Product_Data {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Product_Data.output(var_post rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	mut var_thepostid := rt.get_property(var_post, 'ID')
	mut var_product_object := if rt.is_true(var_thepostid) { rt.call_function('wc_get_product', [var_thepostid.dup()]) } else { create_wc_product() }
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_save_data'), rt.new_string('woocommerce_meta_nonce')])
	rt.include_file(@DIR + '/views/html-product-data-panel.php', '1')
}

fn Class_WC_Meta_Box_Product_Data.output_tabs()  {
	mut var_post := rt.new_null()
	mut var_thepostid := rt.new_null()
	mut var_product_object := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.include_file(@DIR + '/views/html-product-data-general.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-inventory.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-shipping.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-linked-products.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-attributes.php', '1')
	rt.include_file(@DIR + '/views/html-product-data-advanced.php', '1')
}

fn Class_WC_Meta_Box_Product_Data.get_product_type_options() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('product_type_options'), rt.call_function('wc_get_default_product_type_options', []rt.PhpVal{})])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_WC_Meta_Box_Product_Data.get_product_data_tabs() rt.PhpVal {
	mut var_tabs := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_data_tabs'), rt.create_array([rt.ArrayItem{ key: 'general', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('General'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'general_product_data' }, rt.ArrayItem{ key: 'class', val: rt.create_array([rt.ArrayItem{ key: none, val: 'hide_if_grouped' }]) }, rt.ArrayItem{ key: 'priority', val: 10 }]) }, rt.ArrayItem{ key: 'inventory', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Inventory'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'inventory_product_data' }, rt.ArrayItem{ key: 'class', val: rt.create_array([rt.ArrayItem{ key: none, val: 'show_if_simple' }, rt.ArrayItem{ key: none, val: 'show_if_variable' }, rt.ArrayItem{ key: none, val: 'show_if_grouped' }, rt.ArrayItem{ key: none, val: 'show_if_external' }]) }, rt.ArrayItem{ key: 'priority', val: 20 }]) }, rt.ArrayItem{ key: 'shipping', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Shipping'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'shipping_product_data' }, rt.ArrayItem{ key: 'class', val: rt.create_array([rt.ArrayItem{ key: none, val: 'hide_if_virtual' }, rt.ArrayItem{ key: none, val: 'hide_if_grouped' }, rt.ArrayItem{ key: none, val: 'hide_if_external' }]) }, rt.ArrayItem{ key: 'priority', val: 30 }]) }, rt.ArrayItem{ key: 'linked_product', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Linked Products'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'linked_product_data' }, rt.ArrayItem{ key: 'class', val: rt.new_array() }, rt.ArrayItem{ key: 'priority', val: 40 }]) }, rt.ArrayItem{ key: 'attribute', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Attributes'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'product_attributes' }, rt.ArrayItem{ key: 'class', val: rt.new_array() }, rt.ArrayItem{ key: 'priority', val: 50 }]) }, rt.ArrayItem{ key: 'variations', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Variations'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'variable_product_options' }, rt.ArrayItem{ key: 'class', val: rt.create_array([rt.ArrayItem{ key: none, val: 'show_if_variable' }]) }, rt.ArrayItem{ key: 'priority', val: 60 }]) }, rt.ArrayItem{ key: 'advanced', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Advanced'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'advanced_product_data' }, rt.ArrayItem{ key: 'class', val: rt.new_array() }, rt.ArrayItem{ key: 'priority', val: 70 }]) }])])
	rt.call_function('uasort', [var_tabs.dup(), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'product_data_tabs_sort' }])])
	return var_tabs.dup()
}

fn Class_WC_Meta_Box_Product_Data.product_data_tabs_sort(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if !(var_a.array_isset(rt.new_string('priority')) && var_b.array_isset(rt.new_string('priority'))) {
		return (// unsupported expression: Expr_UnaryMinus).to_i64()
	}
	if rt.is_true(rt.identical(var_a.array_get('priority'), var_b.array_get('priority'))) {
		return 0
	}
	return (if rt.is_true(rt.less(var_a.array_get('priority'), var_b.array_get('priority'))) { // unsupported expression: Expr_UnaryMinus } else { rt.new_int(1) }).to_i64()
}

fn Class_WC_Meta_Box_Product_Data.filter_variation_attributes(var_attribute rt.PhpVal) rt.PhpVal {
	mut var_attribute_mutated := var_attribute
	return rt.identical(rt.new_bool(true), var_attribute_mutated.get_variation())
}

fn Class_WC_Meta_Box_Product_Data.filter_non_variation_attributes(var_attribute rt.PhpVal) rt.PhpVal {
	mut var_attribute_mutated := var_attribute
	return rt.identical(rt.new_bool(false), var_attribute_mutated.get_variation())
}

fn Class_WC_Meta_Box_Product_Data.output_variations()  {
	mut var_post := rt.new_null()
	mut var_wpdb := rt.new_null()
	mut var_product_object := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_variation_attributes := rt.call_function('array_filter', [rt.call_method(var_product_object, 'get_attributes', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'filter_variation_attributes' }])])
	mut var_default_attributes := rt.call_method(var_product_object, 'get_default_attributes', []rt.PhpVal{})
	mut var_variations_count := rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_meta_boxes_variations_count'), rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT COUNT(ID) FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_parent = %d AND post_type = \'product_variation\' AND post_status IN (\'publish\', \'private\')')), rt.get_property(var_post, 'ID')])]), rt.get_property(var_post, 'ID')])])
	mut var_variations_per_page := rt.call_function('absint', [rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_meta_boxes_variations_per_page'), rt.new_int(15)])])
	mut var_variations_total_pages := rt.call_function('ceil', [rt.div(var_variations_count, var_variations_per_page)])
	mut var_modal_title := rt.new_string(rt.concat(rt.call_function('get_bloginfo', [rt.new_string('name')]), rt.call_function('__', [rt.new_string(' says'), rt.new_string('woocommerce')])))
	rt.include_file(@DIR + '/views/html-product-data-variations.php', '1')
}

fn Class_WC_Meta_Box_Product_Data.prepare_downloads(var_file_names rt.PhpVal, var_file_urls rt.PhpVal, var_file_hashes rt.PhpVal) rt.PhpVal {
	mut var_downloads := rt.new_array()
	if !(!rt.is_true(var_file_urls)) {
		mut var_file_url_size := rt.new_int(rt.new_int(var_file_urls.dup().array_count()))
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, var_file_url_size))) { break }
				if !(!rt.is_true(var_file_urls.array_get(var_i))) {
					var_downloads << rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('wc_clean', [var_file_names.array_get(var_i)]) }, rt.ArrayItem{ key: 'file', val: rt.call_function('wp_unslash', [rt.new_string(var_file_urls.array_get(var_i).to_string().trim_space())]) }, rt.ArrayItem{ key: 'download_id', val: rt.call_function('wc_clean', [var_file_hashes.array_get(var_i)]) }])
				}
				rt.post_inc(var_i)
			}
		}
	}
	return var_downloads.dup()
}

fn Class_WC_Meta_Box_Product_Data.prepare_children() rt.PhpVal {
	return if rt.get_superglobal('_POST').array_isset(rt.new_string('grouped_products')) { rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('intval'), rt.cast_array(rt.get_superglobal('_POST').array_get('grouped_products'))])]) } else { rt.new_array() }
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn Class_WC_Meta_Box_Product_Data.prepare_attributes(data bool) rt.PhpVal {
	mut data_mutated := data
	mut var_attributes := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(data_mutated))))) {
		data_mutated = (rt.call_function('stripslashes_deep', [rt.get_superglobal('_POST').dup()])).to_bool()
		// unsupported statement: Stmt_Nop
	}
	if rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_names')) && rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_values')) {
		mut var_attribute_names := rt.new_bool(data_mutated).array_get('attribute_names')
		mut var_attribute_values := rt.new_bool(data_mutated).array_get('attribute_values')
		mut var_attribute_visibility := if rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_visibility')) { rt.new_bool(data_mutated).array_get('attribute_visibility') } else { rt.new_array() }
		mut var_attribute_variation := if rt.new_bool(data_mutated).array_isset(rt.new_string('attribute_variation')) { rt.new_bool(data_mutated).array_get('attribute_variation') } else { rt.new_array() }
		mut var_attribute_position := rt.new_bool(data_mutated).array_get('attribute_position')
		mut var_attribute_names_max_key := rt.call_function('max', [rt.func_array_keys(var_attribute_names.dup())])
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less_equal(var_i, var_attribute_names_max_key))) { break }
				if !rt.is_true(var_attribute_names.array_get(var_i)) || !(var_attribute_values.array_isset(var_i)) {
					continue
				}
				mut var_attribute_id := rt.new_int(rt.new_int(0))
				mut var_attribute_name := rt.call_function('wc_clean', [rt.call_function('esc_html', [var_attribute_names.array_get(var_i)])])
				if rt.is_true(rt.identical(rt.new_string('pa_'), rt.call_function('substr', [var_attribute_name.dup(), rt.new_int(0), rt.new_int(3)]))) {
					var_attribute_id = rt.call_function('wc_attribute_taxonomy_id_by_name', [var_attribute_name.dup()])
				}
				mut var_options := if var_attribute_values.array_isset(var_i) { var_attribute_values.array_get(var_i) } else { rt.new_string('') }
				if rt.is_true(rt.new_bool(var_options.dup().is_array())) {
					var_options = rt.call_function('wp_parse_id_list', [var_options.dup()])
				} else {
					var_options = if rt.is_true(rt.less(rt.new_int(0), var_attribute_id)) { rt.call_function('wc_sanitize_textarea', [rt.call_function('esc_html', [rt.call_function('wc_sanitize_term_text_based', [var_options.dup()])])]) } else { rt.call_function('wc_sanitize_textarea', [rt.call_function('esc_html', [var_options.dup()])]) }
					var_options = rt.call_function('wc_get_text_attributes', [var_options.dup()])
				}
				if !rt.is_true(var_options) {
					continue
				}
				mut var_attribute := create_wc_product_attribute()
				var_attribute.set_id(var_attribute_id.dup())
				var_attribute.set_name(var_attribute_name.dup())
				var_attribute.set_options(var_options.dup())
				var_attribute.set_position(var_attribute_position.array_get(var_i))
				var_attribute.set_visible(rt.new_bool(var_attribute_visibility.array_isset(var_i)))
				var_attribute.set_variation(rt.new_bool(var_attribute_variation.array_isset(var_i)))
				var_attributes.array_push(rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_meta_boxes_prepare_attribute'), var_attribute, rt.new_bool(data_mutated).dup(), var_i.dup()]))
				// unsupported statement: Stmt_Nop
				rt.post_inc(var_i)
			}
		}
	}
	return var_attributes.dup()
}

fn Class_WC_Meta_Box_Product_Data.prepare_set_attributes(var_all_attributes rt.PhpVal, key_prefix string, var_index rt.PhpVal) rt.PhpVal {
	mut var_attributes := rt.new_array()
	if rt.is_true(var_all_attributes) {
		{
			mut iter_1 := var_all_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				if rt.is_true(rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{})) {
					mut var_attribute_key := rt.call_function('sanitize_title', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_index.dup().is_null()))))) {
						mut var_value := if rt.get_superglobal('_POST').array_get(key_prefix + (var_attribute_key).str()).array_isset(var_index) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(key_prefix + (var_attribute_key).str()).array_get(var_index)]) } else { rt.new_string('') }
						// unsupported statement: Stmt_Nop
					} else {
						var_value = if rt.get_superglobal('_POST').array_isset(key_prefix + (var_attribute_key).str()) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(key_prefix + (var_attribute_key).str())]) } else { rt.new_string('') }
						// unsupported statement: Stmt_Nop
					}
					if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
						var_value = rt.call_function('sanitize_title', [var_value.dup()])
					} else {
						var_value = rt.call_function('html_entity_decode', [rt.call_function('wc_clean', [var_value.dup()]), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])])
						// unsupported statement: Stmt_Nop
					}
					var_attributes.array_set(var_attribute_key, var_value.dup())
				}
			}
		}
	}
	return var_attributes.dup()
}

fn Class_WC_Meta_Box_Product_Data.save(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	mut var_product_type := if !rt.is_true(rt.get_superglobal('_POST').array_get('product-type')) { fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Product_Factory{}; return temp.get_product_type(arg_0) }(var_post_id.dup()) } else { rt.call_function('sanitize_title', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('product-type')])]) }
	mut var_classname := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Product_Factory{}; return temp.get_product_classname(arg_0, arg_1) }(var_post_id.dup(), if rt.is_true(var_product_type) { var_product_type } else { Class_Automattic_WooCommerce_Enums_ProductType.simple() })
	mut var_product := rt.create_object_dynamically(var_classname, [var_post_id.dup()])
	mut var_attributes := Class_WC_Meta_Box_Product_Data.prepare_attributes()
	mut var_stock := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('_stock')) {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('_original_stock')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Meta_Boxes{}; return temp.add_error(arg_0) }(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The stock has not been updated because the value has changed since editing. Product %1$d has %2$d units in stock.'), rt.new_string('woocommerce')]), rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.call_method(var_product, 'get_stock_quantity', [rt.new_string('edit')])]))
		} else {
			var_stock = rt.call_function('wc_stock_amount', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('_stock')])])
		}
	}
	mut var_date_on_sale_from := rt.new_string(rt.new_string(''))
	mut var_date_on_sale_to := rt.new_string(rt.new_string(''))
	if rt.get_superglobal('_POST').array_isset(rt.new_string('_sale_price_dates_from')) {
		var_date_on_sale_from = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [.array_get()])])
		if !(!rt.is_true(var_date_on_sale_from)) {
			var_date_on_sale_from = rt.call_function('date', [, ])
			// unsupported statement: Stmt_Nop
		}
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('_sale_price_dates_to')) {
		var_date_on_sale_to = 
		if !(!rt.is_true()) {
		}
	}
	mut var_errors := 
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn Class_WC_Meta_Box_Product_Data.save_variations(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Meta_Boxes {
	rt.PhpObjectBase
}

fn create_wc_meta_box_product_data() &Class_WC_Meta_Box_Product_Data {
	mut obj := &Class_WC_Meta_Box_Product_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product() &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_attribute() &Class_WC_Product_Attribute {
	mut obj := &Class_WC_Product_Attribute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_factory() &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_meta_boxes() &Class_WC_Admin_Meta_Boxes {
	mut obj := &Class_WC_Admin_Meta_Boxes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Product_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Data.output(dispatch_arg_0)
			return rt.new_null()
		}
		'output_tabs' {
			Class_WC_Meta_Box_Product_Data.output_tabs()
			return rt.new_null()
		}
		'get_product_type_options' {
			return Class_WC_Meta_Box_Product_Data.get_product_type_options()
		}
		'get_product_data_tabs' {
			return Class_WC_Meta_Box_Product_Data.get_product_data_tabs()
		}
		'product_data_tabs_sort' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_WC_Meta_Box_Product_Data.product_data_tabs_sort(dispatch_arg_0, dispatch_arg_1))
		}
		'filter_variation_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.filter_variation_attributes(dispatch_arg_0)
		}
		'filter_non_variation_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.filter_non_variation_attributes(dispatch_arg_0)
		}
		'output_variations' {
			Class_WC_Meta_Box_Product_Data.output_variations()
			return rt.new_null()
		}
		'prepare_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.prepare_downloads(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_children' {
			return Class_WC_Meta_Box_Product_Data.prepare_children()
		}
		'prepare_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_WC_Meta_Box_Product_Data.prepare_attributes(dispatch_arg_0)
		}
		'prepare_set_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Data.prepare_set_attributes(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Data.save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'save_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Data.save_variations(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Meta_Box_Product_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Product_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Meta_Boxes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Meta_Boxes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Meta_Boxes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WC_Meta_Box_Product_Data', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_meta_box_product_data()
		return rt.new_object('WC_Meta_Box_Product_Data', []string{}, obj)
	})
	rt.register_class_factory('WC_Product', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product()
		return rt.new_object('WC_Product', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Attribute', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_attribute()
		return rt.new_object('WC_Product_Attribute', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Admin_Meta_Boxes', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_admin_meta_boxes()
		return rt.new_object('WC_Admin_Meta_Boxes', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_class_wc_meta_box_product_data_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
