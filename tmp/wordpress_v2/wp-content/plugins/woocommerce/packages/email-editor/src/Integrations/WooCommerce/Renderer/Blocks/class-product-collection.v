import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection.inner_block_spacing() string {
	return '8px'
}
struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_query := this.prepare_and_execute_query(mut var_parsed_block, mut var_rendering_context)
	mut var_collection_type := if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection')) } else { rt.new_string('') }
	mut var_columns := rt.new_int((if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('displayLayout')).array_get(rt.new_string('columns'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('displayLayout')).array_get(rt.new_string('columns')) } else { rt.new_int(1) }).to_i64())
	mut var_content := rt.new_string('')
	mut iter_1 := var_parsed_block.array_get(rt.new_string('innerBlocks')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_inner_block := item_1.val
		mut switch_val_1 := var_inner_block.array_get(rt.new_string('blockName'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce/product-template'))) {
			var_content = rt.concat(var_content, this.render_product_template(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_inner_block), mut rt.cast_object_ptr[Class_WP_Query](var_query), (var_collection_type).str(), (var_columns).to_i64(), mut var_rendering_context))
		} else {
			var_content = rt.concat(var_content, rt.call_function('render_block', [var_inner_block.clone()]))
		}
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return (var_content).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_product_template(mut var_inner_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_query Class_WP_Query, collection_type string, columns i64, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_inner_block_mutated := var_inner_block
	mut var_query_mutated := var_query
	mut collection_type_mutated := collection_type
	mut columns_mutated := columns
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query_mutated, 'have_posts', []rt.PhpVal{}))))) {
		return this.render_no_results_message()
	}
	mut var_posts := rt.call_method(var_query_mutated, 'get_posts', []rt.PhpVal{})
	mut var_total_count := rt.new_int(var_posts.clone().array_count())
	if rt.is_true(rt.identical(rt.new_int(0), var_total_count)) {
		return this.render_no_results_message()
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_post := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
		}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_post := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_post := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
		}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_post := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
		}
	mut var_products := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_posts.clone()])])
	return this.render_product_grid(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_products), mut var_inner_block_mutated, collection_type_mutated, columns_mutated, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_product_grid(mut var_products Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_inner_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, collection_type string, columns i64, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_products_mutated := var_products
	mut var_inner_block_mutated := var_inner_block
	mut collection_type_mutated := collection_type
	mut columns_mutated := columns
	columns_mutated = (rt.call_function('min', [rt.call_function('max', [rt.new_int(columns_mutated).clone(), rt.new_int(1)]), rt.new_int(2)])).to_i64()
	mut var_theme_styles := var_rendering_context.get_theme_styles()
	mut var_block_gap := if !(var_theme_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() { var_theme_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')) } else { rt.new_string('16px') }
	if 1 == columns_mutated {
		mut var_content := rt.new_string('')
		mut var_index := rt.new_int(0)
		mut iter_2 := var_products_mutated.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_product := item_2.val
			mut var_email_attrs := if !(var_inner_block_mutated.array_get(rt.new_string('email_attrs'))).is_null() { var_inner_block_mutated.array_get(rt.new_string('email_attrs')) } else { rt.new_array() }
			if rt.is_true(rt.greater(var_index, rt.new_int(0))) && !(var_email_attrs.array_isset(rt.new_string('margin-top'))) {
				var_email_attrs.array_set('margin-top', var_block_gap.clone())
			}
			var_content = rt.concat(var_content, this.add_spacer(rt.new_string(this.render_product_content(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product](var_product), mut var_inner_block_mutated, collection_type_mutated, rt.new_null())), var_email_attrs.clone()))
			rt.pre_inc(var_index)
		}
		return (var_content).str()
	}
	return (this.add_spacer(rt.new_string(this.render_two_column_grid(mut var_products_mutated, mut var_inner_block_mutated, collection_type_mutated, mut var_rendering_context, (var_block_gap).str())), if !(var_inner_block_mutated.array_get(rt.new_string('email_attrs'))).is_null() { var_inner_block_mutated.array_get(rt.new_string('email_attrs')) } else { rt.new_array() })).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_two_column_grid(mut var_products Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_inner_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, collection_type string, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, block_gap string) string {
	mut var_products_mutated := var_products
	mut var_inner_block_mutated := var_inner_block
	mut collection_type_mutated := collection_type
	mut block_gap_mutated := block_gap
	mut var_content := rt.new_string('')
	mut var_layout_width := rt.new_int((var_rendering_context.get_layout_width_without_padding()).to_i64())
	mut var_gap := rt.new_int(20)
	if rt.is_true(rt.less(var_layout_width, rt.add(var_gap, rt.new_int(2)))) {
	var_layout_width = rt.add(var_gap, rt.new_int(2))
	}
	mut var_cell_width := rt.new_int((rt.div(rt.sub(var_layout_width, var_gap), rt.new_int(2))).to_i64())
	var_content = rt.concat(var_content, rt.new_string('<table role="presentation" border="0" cellpadding="0" cellspacing="0" width="100%" style="width: 100%; border-collapse: collapse;">'))
	mut var_product_chunks := rt.call_function('array_chunk', [var_products_mutated, rt.new_int(2)])
	mut iter_3 := var_product_chunks.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_row_products := item_3.val
		mut var_row_index := item_3.key
		var_content = rt.concat(var_content, rt.new_string('<tr>'))
		mut iter_4 := var_row_products.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_product := item_4.val
			mut var_col_index := item_4.key
			mut var_cell_style := rt.new_string('width: 50%; vertical-align: top; padding: 0;')
			var_cell_style = rt.concat(var_cell_style, if rt.is_true(rt.identical(rt.new_int(0), var_col_index)) { ' padding-right: 10px;' } else { ' padding-left: 10px;' })
			var_content = rt.concat(var_content, rt.call_function('sprintf', [rt.new_string('<td style="%s">%s</td>'), rt.call_function('esc_attr', [var_cell_style.clone()]), rt.new_string(this.render_product_content(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product](var_product), mut var_inner_block_mutated, collection_type_mutated, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?int](var_cell_width)))]))
		}
		if 1 == var_row_products.clone().array_count() {
			var_content = rt.concat(var_content, rt.new_string('<td style="width: 50%; vertical-align: top; padding: 0; padding-left: 10px;"></td>'))
		}
		var_content = rt.concat(var_content, rt.new_string('</tr>'))
		if rt.is_true(rt.less(var_row_index, var_product_chunks.clone().array_count() - 1)) {
			var_content = rt.concat(var_content, rt.call_function('sprintf', [rt.new_string('<tr><td colspan="2" style="height: %s;"></td></tr>'), rt.call_function('esc_attr', [rt.new_string(block_gap_mutated).clone()])]))
		}
	}
	var_content = rt.concat(var_content, rt.new_string('</table>'))
	return (var_content).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_product_content(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product, mut var_template_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, collection_type string, mut var_cell_width Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?int) string {
	mut var_GLOBALS := rt.new_null()
	mut collection_type_mutated := collection_type
	mut var_cell_width_mutated := var_cell_width
	mut var_content := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return (var_content).str()
	}
	mut var_inner_index := rt.new_int(0)
	mut iter_5 := var_template_block.array_get(rt.new_string('innerBlocks')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_inner_block := item_5.val
		var_inner_block.array_set('email_attrs', if !(var_inner_block.array_get(rt.new_string('email_attrs'))).is_null() { var_inner_block.array_get(rt.new_string('email_attrs')) } else { rt.new_array() })
		if rt.is_true(rt.identical(rt.new_int(0), var_inner_index)) {
			var_inner_block.array_get(rt.new_string('email_attrs')).array_unset(rt.new_string('margin-top'))
		} else {
			var_inner_block.array_get_mut('email_attrs').array_set('margin-top', Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection.inner_block_spacing())
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_cell_width_mutated)))) {
			var_inner_block.array_get_mut('email_attrs').array_set('width', (var_cell_width_mutated).str() + 'px')
		}
		rt.pre_inc(var_inner_index)
		mut switch_val_2 := var_inner_block.array_get(rt.new_string('blockName'))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-price'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-button'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-sale-badge'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-image'))) {
			var_inner_block.array_set('context', if !(var_inner_block.array_get(rt.new_string('context'))).is_null() { var_inner_block.array_get(rt.new_string('context')) } else { rt.new_array() })
			var_inner_block.array_get_mut('context').array_set('postId', var_product.get_id())
			var_inner_block.array_get_mut('context').array_set('collection', collection_type_mutated)
			var_content = rt.concat(var_content, rt.call_function('render_block', [var_inner_block.clone()]))
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('core/post-title'))) {
			mut var_post := rt.get_superglobal('post')
			mut var_original_post := var_post.clone()
			mut var_original_global_product := if !(var_GLOBALS.array_get(rt.new_string('product'))).is_null() { var_GLOBALS.array_get(rt.new_string('product')) } else { rt.new_null() }
			mut var_product_post := rt.call_function('get_post', [var_product.get_id()])
			var_post = var_product_post.clone()
			var_GLOBALS.array_set('product', var_product)
			var_inner_block.array_set('context', if !(var_inner_block.array_get(rt.new_string('context'))).is_null() { var_inner_block.array_get(rt.new_string('context')) } else { rt.new_array() })
			var_inner_block.array_get_mut('context').array_set('postId', var_product.get_id())
			var_content = rt.concat(var_content, rt.call_function('render_block', [var_inner_block.clone()]))
			var_post = var_original_post.clone()
			var_GLOBALS.array_set('product', var_original_global_product.clone())
		} else {
		}
	}
	return (var_content).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) prepare_and_execute_query(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_collection := if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection')) } else { rt.new_string('') }
	mut var_query_attrs := if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')) } else { rt.new_array() }
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'posts_per_page', val: rt.new_int((if !(var_query_attrs.array_get(rt.new_string('perPage'))).is_null() { var_query_attrs.array_get(rt.new_string('perPage')) } else { rt.new_int(9) }).to_i64()) }, rt.ArrayItem{ key: 'orderby', val: rt.call_function('sanitize_key', [if !(var_query_attrs.array_get(rt.new_string('orderBy'))).is_null() { var_query_attrs.array_get(rt.new_string('orderBy')) } else { rt.new_string('menu_order') }]) }, rt.ArrayItem{ key: 'order', val: rt.call_function('sanitize_key', [if !(var_query_attrs.array_get(rt.new_string('order'))).is_null() { var_query_attrs.array_get(rt.new_string('order')) } else { rt.new_string('asc') }]) }, rt.ArrayItem{ key: 'meta_query', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_query', val: rt.new_array() }])
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('search')))) {
		var_query_args.array_set('s', rt.call_function('sanitize_text_field', [rt.new_string((var_query_attrs.array_get(rt.new_string('search'))).str())]))
	}
	if var_query_attrs.array_isset(rt.new_string('offset')) {
		var_query_args.array_set('offset', rt.new_int((var_query_attrs.array_get(rt.new_string('offset'))).to_i64()))
	}
	if var_query_attrs.array_isset(rt.new_string('exclude')) && var_query_attrs.array_get(rt.new_string('exclude')).is_array() {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return mut if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 }
			}
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return mut if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 }
			}
		var_query_args.array_set('post__not_in', rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_query_attrs.array_get(rt.new_string('exclude'))]))
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('woocommerceHandPickedProducts')))) {
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return mut if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 }
			}
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return mut if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 }
			}
		var_query_args.array_set('post__in', rt.call_function('array_map', [rt.new_closure(closure_7_fn), var_query_attrs.array_get(rt.new_string('woocommerceHandPickedProducts'))]))
		var_query_args.array_set('orderby', 'post__in')
	}
	mut var_is_featured := if !(var_query_attrs.array_get(rt.new_string('featured'))).is_null() { var_query_attrs.array_get(rt.new_string('featured')) } else { rt.new_bool(false) }
	if rt.is_true(rt.identical(rt.new_string('woocommerce/product-collection/featured'), var_collection)) || rt.is_true(var_is_featured) {
		mut var_featured_query := rt.call_function('wc_get_product_visibility_term_ids', []rt.PhpVal{})
		if var_featured_query.array_isset(rt.new_string('featured')) {
			var_query_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_int((var_featured_query.array_get(rt.new_string('featured'))).to_i64()) }]) }, rt.ArrayItem{ key: 'operator', val: 'IN' }]))
		}
	}
	mut var_is_on_sale := if !(var_query_attrs.array_get(rt.new_string('woocommerceOnSale'))).is_null() { var_query_attrs.array_get(rt.new_string('woocommerceOnSale')) } else { rt.new_bool(false) }
	if rt.is_true(rt.identical(rt.new_string('woocommerce/product-collection/on-sale'), var_collection)) || rt.is_true(var_is_on_sale) {
		var_query_args.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'relation', val: 'OR' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_sale_price' }, rt.ArrayItem{ key: 'value', val: '' }, rt.ArrayItem{ key: 'compare', val: '!=' }]) }]))
	}
	mut var_stock_status := if !(var_query_attrs.array_get(rt.new_string('woocommerceStockStatus'))).is_null() { var_query_attrs.array_get(rt.new_string('woocommerceStockStatus')) } else { rt.new_array() }
	if !(!rt.is_true(var_stock_status)) && !(this.is_all_stock_statuses(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_stock_status))) {
		var_query_args.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_stock_status' }, rt.ArrayItem{ key: 'value', val: var_stock_status }, rt.ArrayItem{ key: 'compare', val: 'IN' }]))
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('taxQuery')))) {
		mut var_tax_queries := this.build_tax_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_query_attrs.array_get(rt.new_string('taxQuery'))))
		var_query_args.array_set('tax_query', rt.call_function('array_merge', [var_query_args.array_get(rt.new_string('tax_query')), var_tax_queries.clone()]))
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('woocommerceAttributes')))) {
		mut var_attribute_queries := this.build_attribute_query(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_query_attrs.array_get(rt.new_string('woocommerceAttributes'))))
		var_query_args.array_set('tax_query', rt.call_function('array_merge', [var_query_args.array_get(rt.new_string('tax_query')), var_attribute_queries.clone()]))
	}
	mut var_product_ids_to_include := this.get_collection_specific_product_ids((var_collection).str(), mut var_parsed_block, mut var_rendering_context)
	if !(!rt.is_true(var_product_ids_to_include)) {
		var_query_args.array_set('post__in', var_product_ids_to_include.clone())
	}
	if var_query_args.array_get(rt.new_string('tax_query')).array_count() > 1 {
		var_query_args.array_get_mut('tax_query').array_set('relation', 'AND')
	}
	mut var_wp_query := create_wp_query(var_query_args.clone())
	return mut var_wp_query
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) is_all_stock_statuses(mut var_stock_status Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) bool {
	mut var_stock_status_mutated := var_stock_status
	if !rt.is_true(var_stock_status_mutated) {
		return true
	}
	mut var_all_stock_statuses := rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))
	return var_stock_status_mutated.array_count() == var_all_stock_statuses.clone().array_count() && rt.call_function('array_diff', [var_stock_status_mutated, var_all_stock_statuses.clone()]).array_count() == 0 && rt.call_function('array_diff', [var_all_stock_statuses.clone(), var_stock_status_mutated]).array_count() == 0
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) build_tax_query(mut var_tax_query_input Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_tax_queries := rt.new_array()
	if !rt.is_true(var_tax_query_input) {
		return var_tax_queries.clone()
	}
	mut var_first_key := rt.call_function('array_key_first', [var_tax_query_input])
	if !(var_first_key.clone().is_long()) {
		mut iter_6 := var_tax_query_input.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_terms := item_6.val
			mut var_taxonomy := item_6.key
			if !(!rt.is_true(var_terms)) {
				closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return rt.new_int(if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 })
					}
				closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return rt.new_int(if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 })
					}
				var_tax_queries.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: rt.call_function('array_map', [rt.new_closure(closure_9_fn), rt.cast_array(var_terms)]) }]))
			}
		}
	} else {
	var_tax_queries = var_tax_query_input
	}
	return var_tax_queries.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) build_attribute_query(mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_attribute_queries := rt.new_array()
	mut iter_7 := var_attributes.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_attribute := item_7.val
		if !(!rt.is_true(var_attribute.array_get(rt.new_string('taxonomy')))) && !(!rt.is_true(var_attribute.array_get(rt.new_string('termId')))) {
			var_attribute_queries.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_attribute.array_get(rt.new_string('taxonomy')) }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_int((var_attribute.array_get(rt.new_string('termId'))).to_i64()) }]) }]))
		}
	}
	return var_attribute_queries.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_collection_specific_product_ids(collection string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut collection_mutated := collection
	mut switch_val_3 := rt.new_string(collection_mutated)
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('woocommerce/product-collection/upsells'))) {
		return this.get_upsell_product_ids(mut var_parsed_block)
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('woocommerce/product-collection/cross-sells'))) {
		return this.get_cross_sell_product_ids(mut var_parsed_block)
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('woocommerce/product-collection/related'))) {
		return this.get_related_product_ids(mut var_parsed_block)
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('woocommerce/product-collection/cart-contents'))) {
		return this.get_cart_contents_product_ids(mut var_parsed_block, mut var_rendering_context)
	} else {
		return rt.new_array()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_upsell_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_product_references := this.get_product_references_for_collection(mut var_parsed_block)
	if !rt.is_true(var_product_references) {
		return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
	}
	mut var_products := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_product_references.clone()])])
	if !rt.is_true(var_products) {
		return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
	}
	mut var_all_upsells := rt.new_array()
	mut iter_8 := var_products.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_product := item_8.val
	var_all_upsells = rt.call_function('array_merge', [var_all_upsells.clone(), rt.call_method(var_product, 'get_upsell_ids', []rt.PhpVal{})])
	}
	mut var_unique_upsells := rt.call_function('array_unique', [var_all_upsells.clone()])
	mut var_upsells := rt.call_function('array_diff', [var_unique_upsells.clone(), var_product_references.clone()])
	return if !(!rt.is_true(var_upsells)) { var_upsells } else { rt.create_array([rt.ArrayItem{ key: none, val: -1 }]) }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_cross_sell_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_product_references := this.get_product_references_for_collection(mut var_parsed_block)
	if !rt.is_true(var_product_references) {
		return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
	}
	mut var_products := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('wc_get_product'), var_product_references.clone()])])
	if !rt.is_true(var_products) {
		return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product.get_id()
		}
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_product.get_id()
		}
	mut var_product_ids := rt.call_function('array_map', [rt.new_closure(closure_11_fn), var_products.clone()])
	mut var_all_cross_sells := rt.new_array()
	mut iter_9 := var_products.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_product := item_9.val
	var_all_cross_sells = rt.call_function('array_merge', [var_all_cross_sells.clone(), rt.call_method(var_product, 'get_cross_sell_ids', []rt.PhpVal{})])
	}
	mut var_unique_cross_sells := rt.call_function('array_unique', [var_all_cross_sells.clone()])
	mut var_cross_sells := rt.call_function('array_diff', [var_unique_cross_sells.clone(), var_product_ids.clone()])
	return if !(!rt.is_true(var_cross_sells)) { var_cross_sells } else { rt.create_array([rt.ArrayItem{ key: none, val: -1 }]) }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_related_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_product_references := this.get_product_references_for_collection(mut var_parsed_block)
	if !rt.is_true(var_product_references) {
		return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
	}
	mut var_product_reference := var_product_references.array_get(rt.new_int(0))
	if !rt.is_true(var_product_reference) {
		return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
	}
	mut var_related_ids := rt.call_function('wc_get_related_products', [var_product_reference.clone(), rt.new_int(100)])
	return if !(!rt.is_true(var_related_ids)) { var_related_ids } else { rt.create_array([rt.ArrayItem{ key: none, val: -1 }]) }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_product_references_for_collection(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_product := rt.new_null()
	mut var_query_attrs := if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query'))).is_null() { var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')) } else { rt.new_array() }
	mut var_product_references := rt.new_array()
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('productReference')))) {
	var_product_references = rt.create_array([rt.ArrayItem{ key: none, val: rt.new_int((var_query_attrs.array_get(rt.new_string('productReference'))).to_i64()) }])
	}
	if !rt.is_true(var_product_references) {
		if rt.is_true(var_product) && rt.is_true(rt.call_function('is_a', [var_product, rt.new_string('WC_Product')])) {
		var_product_references = rt.create_array([rt.ArrayItem{ key: none, val: var_product.get_id() }])
		}
	}
	return var_product_references.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_cart_contents_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_cart_product_ids := this.get_user_cart_product_ids_from_context(mut var_rendering_context)
	if !(!rt.is_true(var_cart_product_ids)) {
		return var_cart_product_ids.clone()
	}
	if rt.is_true(var_rendering_context.get(rt.new_string('is_user_preview'), rt.new_bool(false))) {
		return this.get_sample_product_ids_for_preview()
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_user_cart_product_ids_from_context(mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_user_id := var_rendering_context.get_user_id()
	mut var_email := var_rendering_context.get_recipient_email()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\Blocks\\Utils\\CartCheckoutUtils')])) && rt.is_true(rt.call_function('method_exists', [rt.new_string('\\Automattic\\WooCommerce\\Blocks\\Utils\\CartCheckoutUtils'), rt.new_string('get_cart_product_ids_for_user')])) {
		mut iife_temp_12 := Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
		mut iife_result_12 := iife_temp_12.get_cart_product_ids_for_user(var_user_id.clone(), var_email.clone())
		return iife_result_12
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) && rt.is_true(var_email) {
		mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), var_email.clone()])
		if rt.is_true(var_user) {
		var_user_id = rt.get_property(var_user, 'ID')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return rt.new_array()
	}
	mut var_cart_data := rt.call_function('get_user_meta', [var_user_id.clone(), rt.new_string('_woocommerce_persistent_cart_' + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str()), rt.new_bool(true)])
	if !(var_cart_data.clone().is_array()) || !rt.is_true(var_cart_data) || !(var_cart_data.array_isset(rt.new_string('cart'))) || !(var_cart_data.array_get(rt.new_string('cart')).is_array()) {
		return rt.new_array()
	}
	mut var_product_ids := rt.new_array()
	mut iter_10 := var_cart_data.array_get(rt.new_string('cart')).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_cart_item := item_10.val
		if var_cart_item.clone().is_array() && var_cart_item.array_isset(rt.new_string('product_id')) && var_cart_item.array_get(rt.new_string('product_id')).is_long() || var_cart_item.array_get(rt.new_string('product_id')).is_double() {
			var_product_ids.array_push(rt.new_int((var_cart_item.array_get(rt.new_string('product_id'))).to_i64()))
		}
	}
	return rt.call_function('array_unique', [var_product_ids.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_sample_product_ids_for_preview() rt.PhpVal {
	mut var_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'posts_per_page', val: 3 }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'fields', val: 'ids' }]))
	if !(!rt.is_true(rt.get_property(var_query, 'posts'))) && rt.get_property(var_query, 'posts').is_array() {
		closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int(if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 })
			}
		closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int(if var_id.clone().is_long() || var_id.clone().is_double() { rt.new_int((var_id).to_i64()) } else { 0 })
			}
		return rt.call_function('array_map', [rt.new_closure(closure_14_fn), rt.get_property(var_query, 'posts')])
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: -1 }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_no_results_message() string {
	return (rt.call_function('sprintf', [rt.new_string('<div style="text-align: center; padding: 20px; color: #666;">%s</div>'), rt.call_function('esc_html__', [rt.new_string('No products found.'), rt.new_string('woocommerce')])])).str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_product_collection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_abstract_product_block_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'render_product_template' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Query](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.render_product_template(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'render_product_grid' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_string(this.render_product_grid(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'render_two_column_grid' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_string(this.render_two_column_grid(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4))
		}
		'render_product_content' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?int](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_string(this.render_product_content(mut dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3))
		}
		'prepare_and_execute_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.prepare_and_execute_query(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'is_all_stock_statuses' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.is_all_stock_statuses(mut dispatch_arg_0))
		}
		'build_tax_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_tax_query(mut dispatch_arg_0)
		}
		'build_attribute_query' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_attribute_query(mut dispatch_arg_0)
		}
		'get_collection_specific_product_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_collection_specific_product_ids(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_upsell_product_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_upsell_product_ids(mut dispatch_arg_0)
		}
		'get_cross_sell_product_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_cross_sell_product_ids(mut dispatch_arg_0)
		}
		'get_related_product_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_related_product_ids(mut dispatch_arg_0)
		}
		'get_product_references_for_collection' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_product_references_for_collection(mut dispatch_arg_0)
		}
		'get_cart_contents_product_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_cart_contents_product_ids(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_user_cart_product_ids_from_context' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_user_cart_product_ids_from_context(mut dispatch_arg_0)
		}
		'get_sample_product_ids_for_preview' {
			return this.get_sample_product_ids_for_preview()
		}
		'render_no_results_message' {
			return rt.new_string(this.render_no_results_message())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
