import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection.inner_block_spacing() string {
	return '8px'
}
struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_query := this.prepare_and_execute_query(mut var_parsed_block, mut var_rendering_context)
	mut var_collection_type := if !(var_parsed_block.array_get('attrs').array_get('collection')).is_null() { var_parsed_block.array_get('attrs').array_get('collection') } else { rt.new_string('') }
	mut var_columns := // unsupported expression: Expr_Cast_Int
	mut var_content := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_parsed_block.array_get('innerBlocks').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			mut switch_val_1 := var_inner_block.array_get('blockName')
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce/product-template'))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
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
	mut var_total_count := rt.new_int(rt.new_int(var_posts.dup().array_count()))
	if rt.is_true(rt.identical(rt.new_int(0), var_total_count)) {
		return this.render_no_results_message()
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_post := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
	}
	mut var_post := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
	}
	mut var_post := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
	}
	mut var_post := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Post'))) { rt.call_function('wc_get_product', [rt.get_property(var_post, 'ID')]) } else { rt.new_null() }).str()
	}
	mut var_products := rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_posts.dup()])])
	return this.render_product_grid(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_products), mut var_inner_block_mutated, collection_type_mutated, columns_mutated, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_product_grid(mut var_products Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_inner_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, collection_type string, columns i64, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_products_mutated := var_products
	mut var_inner_block_mutated := var_inner_block
	mut collection_type_mutated := collection_type
	mut columns_mutated := columns
	columns_mutated = (rt.call_function('min', [rt.call_function('max', [rt.new_int(columns_mutated).dup(), rt.new_int(1)]), rt.new_int(2)])).to_i64()
	mut var_theme_styles := var_rendering_context.get_theme_styles()
	mut var_block_gap := if !(var_theme_styles.array_get('spacing').array_get('blockGap')).is_null() { var_theme_styles.array_get('spacing').array_get('blockGap') } else { rt.new_string('16px') }
	if 1 == columns_mutated {
		mut var_content := rt.new_string(rt.new_string(''))
		mut var_index := rt.new_int(rt.new_int(0))
		{
			mut iter_1 := var_products_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_product := item_1.val
				mut var_email_attrs := if !(var_inner_block_mutated.array_get('email_attrs')).is_null() { var_inner_block_mutated.array_get('email_attrs') } else { rt.new_array() }
				if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_index, rt.new_int(0))) && !(var_email_attrs.array_isset(rt.new_string('margin-top'))))) {
					var_email_attrs.array_set('margin-top', var_block_gap.dup())
				}
				// unsupported expression: Expr_AssignOp_Concat
				rt.pre_inc(var_index)
			}
		}
		return (var_content).str()
	}
	return (this.add_spacer(rt.new_string(this.render_two_column_grid(mut var_products_mutated, mut var_inner_block_mutated, collection_type_mutated, mut var_rendering_context, (var_block_gap).str())), if !(var_inner_block_mutated.array_get('email_attrs')).is_null() { var_inner_block_mutated.array_get('email_attrs') } else { rt.new_array() })).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_two_column_grid(mut var_products Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_inner_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, collection_type string, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, block_gap string) string {
	mut var_products_mutated := var_products
	mut var_inner_block_mutated := var_inner_block
	mut collection_type_mutated := collection_type
	mut block_gap_mutated := block_gap
	mut var_content := rt.new_string(rt.new_string(''))
	mut var_layout_width := // unsupported expression: Expr_Cast_Int
	mut var_gap := rt.new_int(rt.new_int(20))
	if rt.is_true(rt.less(var_layout_width, rt.add(var_gap, rt.new_int(2)))) {
		var_layout_width = rt.add(var_gap, rt.new_int(2))
	}
	mut var_cell_width := // unsupported expression: Expr_Cast_Int
	// unsupported expression: Expr_AssignOp_Concat
	mut var_product_chunks := rt.call_function('array_chunk', [var_products_mutated.dup(), rt.new_int(2)])
	{
		mut iter_1 := var_product_chunks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row_products := item_1.val
			mut var_row_index := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
			{
				mut iter_2 := var_row_products.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_product := item_2.val
					mut var_col_index := item_2.key
					mut var_cell_style := rt.new_string(rt.new_string('width: 50%; vertical-align: top; padding: 0;'))
					// unsupported expression: Expr_AssignOp_Concat
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			if 1 == var_row_products.dup().array_count() {
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.less(var_row_index, var_product_chunks.dup().array_count() - 1)) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	// unsupported expression: Expr_AssignOp_Concat
	return (var_content).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_product_content(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?WC_Product, mut var_template_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, collection_type string, mut var_cell_width Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_?int) string {
	mut var_GLOBALS := rt.new_null()
	mut collection_type_mutated := collection_type
	mut var_cell_width_mutated := var_cell_width
	mut var_content := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return (var_content).str()
	}
	mut var_inner_index := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_template_block.array_get('innerBlocks').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			var_inner_block.array_set('email_attrs', if !(var_inner_block.array_get('email_attrs')).is_null() { var_inner_block.array_get('email_attrs') } else { rt.new_array() })
			if rt.is_true(rt.identical(rt.new_int(0), var_inner_index)) {
				var_inner_block.array_get('email_attrs').array_unset(rt.new_string('margin-top'))
			} else {
				var_inner_block.array_get_mut('email_attrs').array_set('margin-top', Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection.inner_block_spacing())
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_inner_block.array_get_mut('email_attrs').array_set('width', (var_cell_width_mutated).str() + 'px')
			}
			rt.pre_inc(var_inner_index)
			mut switch_val_2 := var_inner_block.array_get('blockName')
			if rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-price'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-button'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-sale-badge'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('woocommerce/product-image'))) {
				var_inner_block.array_set('context', if !(var_inner_block.array_get('context')).is_null() { var_inner_block.array_get('context') } else { rt.new_array() })
				var_inner_block.array_get_mut('context').array_set('postId', var_product.get_id())
				var_inner_block.array_get_mut('context').array_set('collection', collection_type_mutated)
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('core/post-title'))) {
				// unsupported statement: Stmt_Global
				mut var_original_post := var_post.dup()
				mut var_original_global_product := if !(var_GLOBALS.array_get('product')).is_null() { var_GLOBALS.array_get('product') } else { rt.new_null() }
				mut var_product_post := rt.call_function('get_post', [var_product.get_id()])
				mut var_post := var_product_post.dup()
				var_GLOBALS.array_set('product', var_product.dup())
				var_inner_block.array_set('context', if !(var_inner_block.array_get('context')).is_null() { var_inner_block.array_get('context') } else { rt.new_array() })
				var_inner_block.array_get_mut('context').array_set('postId', var_product.get_id())
				// unsupported expression: Expr_AssignOp_Concat
				var_post = var_original_post.dup()
				var_GLOBALS.array_set('product', var_original_global_product.dup())
			} else {
			}
		}
	}
	return (var_content).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) prepare_and_execute_query(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
	mut var_collection := if !(var_parsed_block.array_get('attrs').array_get('collection')).is_null() { var_parsed_block.array_get('attrs').array_get('collection') } else { rt.new_string('') }
	mut var_query_attrs := if !(var_parsed_block.array_get('attrs').array_get('query')).is_null() { var_parsed_block.array_get('attrs').array_get('query') } else { rt.new_array() }
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'posts_per_page', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'orderby', val: rt.call_function('sanitize_key', [if !(var_query_attrs.array_get('orderBy')).is_null() { var_query_attrs.array_get('orderBy') } else { rt.new_string('menu_order') }]) }, rt.ArrayItem{ key: 'order', val: rt.call_function('sanitize_key', [if !(var_query_attrs.array_get('order')).is_null() { var_query_attrs.array_get('order') } else { rt.new_string('asc') }]) }, rt.ArrayItem{ key: 'meta_query', val: rt.new_array() }, rt.ArrayItem{ key: 'tax_query', val: rt.new_array() }])
	if !(!rt.is_true(var_query_attrs.array_get('search'))) {
		var_query_args.array_set('s', rt.call_function('sanitize_text_field', [// unsupported expression: Expr_Cast_String]))
	}
	if var_query_attrs.array_isset(rt.new_string('offset')) {
		var_query_args.array_set('offset', // unsupported expression: Expr_Cast_Int)
	}
	if rt.is_true(rt.new_bool(var_query_attrs.array_isset(rt.new_string('exclude')) && rt.is_true(rt.new_bool(var_query_attrs.array_get('exclude').is_array())))) {
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return mut rt.cast_object_ptr[Class_WP_Query](if rt.is_true(rt.new_bool(var_id.dup().is_long() || var_id.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) })
	}
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return mut rt.cast_object_ptr[Class_WP_Query](if rt.is_true(rt.new_bool(var_id.dup().is_long() || var_id.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) })
	}
		var_query_args.array_set('post__not_in', rt.call_function('array_map', [rt.new_closure(closure_5_fn), var_query_attrs.array_get('exclude')]))
	}
	if !(!rt.is_true(var_query_attrs.array_get('woocommerceHandPickedProducts'))) {
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return mut rt.cast_object_ptr[Class_WP_Query](if rt.is_true(rt.new_bool(var_id.dup().is_long() || var_id.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) })
	}
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return mut rt.cast_object_ptr[Class_WP_Query](if rt.is_true(rt.new_bool(var_id.dup().is_long() || var_id.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) })
	}
		var_query_args.array_set('post__in', rt.call_function('array_map', [rt.new_closure(closure_7_fn), var_query_attrs.array_get('woocommerceHandPickedProducts')]))
		var_query_args.array_set('orderby', 'post__in')
	}
	mut var_is_featured := if !(var_query_attrs.array_get('featured')).is_null() { var_query_attrs.array_get('featured') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('woocommerce/product-collection/featured'), var_collection)) || rt.is_true(var_is_featured))) {
		mut var_featured_query := rt.call_function('wc_get_product_visibility_term_ids', []rt.PhpVal{})
		if var_featured_query.array_isset(rt.new_string('featured')) {
			var_query_args.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }, rt.ArrayItem{ key: , val:  }]))
		}
	}
	mut var_is_on_sale := if !(.array_get()).is_null() { .array_get() } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(, )) || rt.is_true(var_is_on_sale))) {
		.array_get_mut().array_push()
	}
	mut var_stock_status := 
	if !(!rt.is_true()) && !() {
	}
	if !(!rt.is_true()) {
	}
	if !(!rt.is_true()) {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) is_all_stock_statuses(mut var_stock_status Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) bool {
	mut var_stock_status_mutated := var_stock_status
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) build_tax_query(mut var_tax_query_input Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) build_attribute_query(mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_collection_specific_product_ids(collection string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context)  {
	mut collection_mutated := collection
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_upsell_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_cross_sell_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_related_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_product_references_for_collection(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_product := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_cart_contents_product_ids(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_user_cart_product_ids_from_context(mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) get_sample_product_ids_for_preview() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection) render_no_results_message() string {
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_product_collection() &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Collection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_abstract_product_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer{
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
			this.get_collection_specific_product_ids(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_woocommerce_renderer_blocks_class_product_collection_php() {
	// unsupported statement: Stmt_Declare
}
