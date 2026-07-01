import rt

struct Class_WC_Product_Variable_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
		prices_array rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) read_attributes(var_product rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_meta_attributes := rt.call_function('get_post_meta', [var_product_id.dup(), rt.new_string('_product_attributes'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_meta_attributes)) && rt.is_true(rt.new_bool(var_meta_attributes.dup().is_array())))) {
		mut var_attributes := rt.new_array()
		mut var_force_update := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := var_meta_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta_attribute_value := item_1.val
				mut var_meta_attribute_key := item_1.key
				mut var_meta_value := rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'name', val: '' }, rt.ArrayItem{ key: 'value', val: '' }, rt.ArrayItem{ key: 'position', val: 0 }, rt.ArrayItem{ key: 'is_visible', val: 0 }, rt.ArrayItem{ key: 'is_variation', val: 0 }, rt.ArrayItem{ key: 'is_taxonomy', val: 0 }]), rt.cast_array(var_meta_attribute_value)])
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_meta_value.array_get('is_variation')) && rt.is_true(rt.call_function('strstr', [var_meta_value.array_get('name'), rt.new_string('/')])))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					// unsupported statement: Stmt_Global
					mut var_child_ids := rt.call_method(var_product, 'get_children', []rt.PhpVal{})
					if !(!rt.is_true(var_child_ids)) {
						mut var_products_to_migrate := rt.call_function('implode', [rt.new_string(', '), var_child_ids.dup()])
						mut var_old_slug := rt.new_string('attribute_' + (var_meta_attribute_key).str())
						mut var_old_meta_rows := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT post_id, meta_value FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = %s AND post_id IN ( ')), var_products_to_migrate), rt.new_string(' )')), var_old_slug.dup()])])
						if rt.is_true(var_old_meta_rows) {
							mut var_new_slug := rt.new_string('attribute_' + (rt.call_function('sanitize_title', [var_meta_value.array_get('name')])).str())
							{
								mut iter_2 := var_old_meta_rows.iterator()
								for {
									item_2 := iter_2.next() or { break }
									mut var_old_meta_row := item_2.val
									rt.call_function('update_post_meta', [rt.get_property(var_old_meta_row, 'post_id'), var_new_slug.dup(), rt.get_property(var_old_meta_row, 'meta_value')])
								}
							}
						}
					}
					var_force_update = rt.new_bool(rt.new_bool(true))
				}
				if !(!rt.is_true(var_meta_value.array_get('is_taxonomy'))) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_meta_value.array_get('name')]))))) {
						continue
					}
					mut var_id := rt.call_function('wc_attribute_taxonomy_id_by_name', [var_meta_value.array_get('name')])
					mut var_options := rt.call_function('wc_get_object_terms', [var_product_id.dup(), var_meta_value.array_get('name'), rt.new_string('term_id')])
				} else {
					var_id = rt.new_int(rt.new_int(0))
					var_options = rt.call_function('wc_get_text_attributes', [var_meta_value.array_get('value')])
				}
				mut var_attribute := create_wc_product_attribute()
				rt.call_method(var_attribute, 'set_id', [var_id.dup()])
				rt.call_method(var_attribute, 'set_name', [var_meta_value.array_get('name')])
				rt.call_method(var_attribute, 'set_options', [var_options.dup()])
				rt.call_method(var_attribute, 'set_position', [var_meta_value.array_get('position')])
				rt.call_method(var_attribute, 'set_visible', [var_meta_value.array_get('is_visible')])
				rt.call_method(var_attribute, 'set_variation', [var_meta_value.array_get('is_variation')])
				var_attributes.array_push(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_read_attribute'), var_attribute.dup(), var_meta_value.dup(), var_product.dup()]))
			}
		}
		rt.call_method(var_product, 'set_attributes', [var_attributes.dup()])
		if rt.is_true(var_force_update) {
			this.update_attributes(var_product.dup(), rt.new_bool(true))
		}
	}
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) read_product_data(var_product rt.PhpVal)  {
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	rt.call_function('wp_prime_option_caches', [rt.create_array([rt.ArrayItem{ key: none, val: '_transient_wc_var_prices_' + (var_product_id).str() }, rt.ArrayItem{ key: none, val: '_transient_timeout_wc_var_prices_' + (var_product_id).str() }, rt.ArrayItem{ key: none, val: '_transient_wc_product_children_' + (var_product_id).str() }, rt.ArrayItem{ key: none, val: '_transient_timeout_wc_product_children_' + (var_product_id).str() }])])
	this.Class_WC_Product_Data_Store_CPT.read_product_data(var_product.dup())
	rt.call_method(var_product, 'set_regular_price', [rt.new_string('')])
	rt.call_method(var_product, 'set_sale_price', [rt.new_string('')])
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) read_children(var_product rt.PhpVal, force_read bool) rt.PhpVal {
	mut force_read_mutated := force_read
	mut var_children_transient_name := rt.new_string('wc_product_children_' + (rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str())
	mut var_children := rt.call_function('get_transient', [var_children_transient_name.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_children) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_children.dup().is_array()))))))) {
		var_children = rt.new_array()
	}
	mut var_transient_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0) }(rt.new_string('product'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(force_read_mutated))))) && rt.is_true(var_children))) {
		if !(this.validate_children_data(var_children.dup(), var_transient_version.dup())) {
			var_children = rt.new_array()
			force_read_mutated = true
		}
	}
	if rt.is_true(rt.new_bool(!(var_children.array_isset(rt.new_string('all'))) || !(var_children.array_isset(rt.new_string('visible'))) || rt.is_true(rt.new_bool(force_read_mutated)))) {
		mut var_all_args := { 'post_parent': rt.call_method(var_product, 'get_id', []rt.PhpVal{}), 'post_type': rt.new_string('product_variation'), 'orderby': { 'menu_order': rt.new_string('ASC'), 'ID': rt.new_string('ASC') }, 'fields': rt.new_string('ids'), 'post_status': map[string]rt.PhpVal{}, 'numberposts': // unsupported expression: Expr_UnaryMinus }
		mut var_visible_only_args := var_all_args.dup()
		var_visible_only_args.array_set('post_status', Class_Automattic_WooCommerce_Enums_ProductStatus.publish())
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) {
			var_visible_only_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'terms', val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock() }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
		}
		var_children.array_set('all', rt.call_function('get_posts', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variable_children_args'), var_all_args.dup(), var_product.dup(), rt.new_bool(false)])]))
		var_children.array_set('visible', rt.call_function('get_posts', [rt.call_function('apply_filters', [rt.new_string('woocommerce_variable_children_args'), var_visible_only_args.dup(), var_product.dup(), rt.new_bool(true)])]))
		if this.validate_children_data(var_children.dup(), var_transient_version.dup()) {
			rt.call_function('set_transient', [var_children_transient_name.dup(), var_children.dup(), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
		}
	}
	var_children.array_set('all', rt.call_function('wp_parse_id_list', [rt.cast_array(var_children.array_get('all'))]))
	var_children.array_set('visible', rt.call_function('wp_parse_id_list', [rt.cast_array(var_children.array_get('visible'))]))
	return var_children.dup()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) read_variation_attributes(var_product rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_variation_attributes := rt.new_array()
	mut var_attributes := rt.call_method(var_product, 'get_attributes', []rt.PhpVal{})
	mut var_child_ids := rt.call_method(var_product, 'get_children', []rt.PhpVal{})
	mut var_cache_key := rt.new_string((fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_cache_prefix(arg_0) }(rt.new_string('product_' + (rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str()))).str() + 'product_variation_attributes_' + (rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str())
	mut var_cache_group := rt.new_string(rt.new_string('products'))
	mut var_cached_data := rt.call_function('wp_cache_get', [var_cache_key.dup(), var_cache_group.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_cached_data.dup()
	}
	if !(!rt.is_true(var_attributes)) {
		{
			mut iter_1 := var_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				if !rt.is_true(var_attribute.array_get('is_variation')) {
					continue
				}
				if !(!rt.is_true(var_child_ids)) {
					mut var_format := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_child_ids.dup().array_count()), rt.new_string('%d')])
					mut var_query_in := rt.new_string('(' + (rt.call_function('implode', [rt.new_string(','), var_format.dup()])).str() + ')')
					mut var_query_args := rt.add(rt.create_array([rt.ArrayItem{ key: 'attribute_name', val: rt.call_function('wc_variation_attribute_name', [var_attribute.array_get('name')]) }]), var_child_ids)
					mut var_values := rt.call_function('array_unique', [rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.new_string('SELECT meta_value FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE meta_key = %s AND post_id IN ')), var_query_in), var_query_args.dup()])])])
				} else {
					var_values = rt.new_array()
				}
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_null(), var_values.dup(), rt.new_bool(true)])) || rt.is_true(rt.call_function('in_array', [rt.new_string(''), var_values.dup(), rt.new_bool(true)])))) || !rt.is_true(var_values))) {
					var_values = if rt.is_true(var_attribute.array_get('is_taxonomy')) { rt.call_function('wc_get_object_terms', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_attribute.array_get('name'), rt.new_string('slug')]) } else { rt.call_function('wc_get_text_attributes', [var_attribute.array_get('value')]) }
					// unsupported statement: Stmt_Nop
				} else if rt.is_true(rt.new_bool(!(rt.is_true(var_attribute.array_get('is_taxonomy'))))) {
					mut var_text_attributes := rt.call_function('wc_get_text_attributes', [var_attribute.array_get('value')])
					mut var_assigned_text_attributes := var_values.dup()
					var_values = rt.new_array()
					if rt.is_true(rt.call_function('version_compare', [rt.call_function('get_post_meta', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.new_string('_product_version'), rt.new_bool(true)]), rt.new_string('2.4.0'), rt.new_string('<')])) {
						var_assigned_text_attributes = rt.call_function('array_map', [rt.new_string('sanitize_title'), var_assigned_text_attributes.dup()])
						{
							mut iter_2 := var_text_attributes.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_text_attribute := item_2.val
								if rt.is_true(rt.call_function('in_array', [rt.call_function('sanitize_title', [var_text_attribute.dup()]), var_assigned_text_attributes.dup(), rt.new_bool(true)])) {
									var_values.array_push(var_text_attribute.dup())
								}
							}
						}
					} else {
						{
							mut iter_2 := var_text_attributes.iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_text_attribute := item_2.val
								if rt.is_true(rt.call_function('in_array', [var_text_attribute.dup(), var_assigned_text_attributes.dup(), rt.new_bool(true)])) {
									var_values.array_push(var_text_attribute.dup())
								}
							}
						}
					}
				}
				var_variation_attributes.array_set(var_attribute.array_get('name'), rt.call_function('array_unique', [var_values.dup()]))
			}
		}
	}
	rt.call_function('wp_cache_set', [var_cache_key.dup(), var_variation_attributes.dup(), var_cache_group.dup()])
	return var_variation_attributes.dup()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) read_price_data(var_product rt.PhpVal, for_display bool) rt.PhpVal {
	mut var_transient_name := rt.new_string('wc_var_prices_' + (rt.call_method(var_product, 'get_id', []rt.PhpVal{})).str())
	mut var_transient_version := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0) }(rt.new_string('product'))
	mut var_price_hash := rt.new_string(this.get_price_hash(var_product.dup(), for_display))
	mut var_opposite_price_hash := if this.taxes_influence_price(var_product.dup()) { rt.new_null() } else { this.get_price_hash(var_product.dup(), !(var_for_display)) }
	if !rt.is_true(this.prices_array.array_get(var_price_hash)) {
		mut var_transient_cached_prices_array := rt.call_function('array_filter', [rt.cast_array(rt.call_function('json_decode', [rt.new_string(rt.call_function('get_transient', [var_transient_name.dup()]).to_string()), rt.new_bool(true)]))])
		if !(this.validate_prices_data(var_transient_cached_prices_array.dup(), var_transient_version.dup())) {
			var_transient_cached_prices_array = rt.new_array()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(var_transient_cached_prices_array.array_get(var_price_hash)) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_opposite_price_hash.dup().is_null()))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && !rt.is_true(var_transient_cached_prices_array.array_get(var_opposite_price_hash)))))) {
			mut var_prices_array := rt.create_array([rt.ArrayItem{ key: 'price', val: rt.new_array() }, rt.ArrayItem{ key: 'regular_price', val: rt.new_array() }, rt.ArrayItem{ key: 'sale_price', val: rt.new_array() }])
			mut var_variation_ids := rt.call_method(var_product, 'get_visible_children', []rt.PhpVal{})
			if !(!rt.is_true(var_variation_ids)) {
				rt.call_function('_prime_post_caches', [var_variation_ids.dup()])
			}
			mut var_tax_display_mode := if var_for_display { rt.call_function('get_option', []) } else { rt.new_null() }
			mut var_price_decimals := rt.call_function('wc_get_price_decimals', []rt.PhpVal{})
			{
				mut iter_1 := var_variation_ids.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_variation_id := item_1.val
					
				}
			}
		}
		
	}
	return 
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) taxes_influence_price(var_product rt.PhpVal) bool {
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) get_price_hash(var_product rt.PhpVal, for_display bool) string {
	mut var_wp_filter := rt.new_null()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) child_has_weight(var_product rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) child_has_dimensions(var_product rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) child_is_in_stock(var_product rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) child_has_stock_status(var_product rt.PhpVal, var_status rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_status_mutated := var_status
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) sync_variation_names(var_product rt.PhpVal, previous_name string, new_name string)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) sync_managed_variation_stock_status(var_product rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) sync_price(var_product rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) sync_stock_status(var_product rt.PhpVal)  {
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) delete_variations(var_product_id rt.PhpVal, force_delete bool)  {
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) untrash_variations(var_product_id rt.PhpVal)  {
	mut var_product_id_mutated := var_product_id
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) validate_children_data(var_children rt.PhpVal, var_deprecated rt.PhpVal) bool {
	mut var_children_mutated := var_children
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) validate_prices_data(var_prices_array rt.PhpVal, var_deprecated rt.PhpVal) bool {
	mut var_prices_array_mutated := var_prices_array
}

struct Class_WC_Product_Data_Store_CPT {
	rt.PhpObjectBase
}

struct Class_WC_Product_Attribute {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_wc_product_variable_data_store_cpt() &Class_WC_Product_Variable_Data_Store_CPT {
	mut obj := &Class_WC_Product_Variable_Data_Store_CPT{
		PhpObjectBase: rt.PhpObjectBase{}
		prices_array: rt.new_array()
	}
	return obj
}

fn create_wc_product_data_store_cpt() &Class_WC_Product_Data_Store_CPT {
	mut obj := &Class_WC_Product_Data_Store_CPT{
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

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'read_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_attributes(dispatch_arg_0)
			return rt.new_null()
		}
		'read_product_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_product_data(dispatch_arg_0)
			return rt.new_null()
		}
		'read_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.read_children(dispatch_arg_0, dispatch_arg_1)
		}
		'read_variation_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.read_variation_attributes(dispatch_arg_0)
		}
		'read_price_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.read_price_data(dispatch_arg_0, dispatch_arg_1)
		}
		'taxes_influence_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.taxes_influence_price(dispatch_arg_0))
		}
		'get_price_hash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_price_hash(dispatch_arg_0, dispatch_arg_1))
		}
		'child_has_weight' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.child_has_weight(dispatch_arg_0))
		}
		'child_has_dimensions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.child_has_dimensions(dispatch_arg_0))
		}
		'child_is_in_stock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.child_is_in_stock(dispatch_arg_0)
		}
		'child_has_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.child_has_stock_status(dispatch_arg_0, dispatch_arg_1)
		}
		'sync_variation_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.sync_variation_names(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'sync_managed_variation_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.sync_managed_variation_stock_status(dispatch_arg_0)
			return rt.new_null()
		}
		'sync_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.sync_price(dispatch_arg_0)
			return rt.new_null()
		}
		'sync_stock_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.sync_stock_status(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.delete_variations(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'untrash_variations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.untrash_variations(dispatch_arg_0)
			return rt.new_null()
		}
		'validate_children_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_children_data(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_prices_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_prices_data(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Variable_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'prices_array' { return this.prices_array }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_Variable_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'prices_array' { this.prices_array = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_product_variable_data_store_cpt_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
