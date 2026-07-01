import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-collection')
		collection_handler_registry rt.PhpVal = rt.new_null()
		query_builder rt.PhpVal = rt.new_null()
		renderer rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) initialize()  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	this.query_builder = create_automattic_woocommerce_blocks_blocktypes_productcollection_querybuilder()
	this.renderer = create_automattic_woocommerce_blocks_blocktypes_productcollection_renderer()
	this.collection_handler_registry = create_automattic_woocommerce_blocks_blocktypes_productcollection_handlerregistry()
	rt.call_function('add_filter', [rt.new_string('query_loop_block_query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'build_frontend_query' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('pre_render_block'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'add_support_for_filter_blocks' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('rest_api_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'register_settings' }])])
	rt.call_function('add_filter', [rt.new_string('rest_product_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'update_rest_query_in_editor' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('rest_product_collection_params'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'extend_rest_query_allowed_params' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/post-title'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'add_product_title_click_event_directives' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('render_block_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'disable_enhanced_pagination' }]), rt.new_int(10), rt.new_int(1)])
	this.register_core_collections_and_set_handler_store()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) add_product_title_click_event_directives(var_block_content rt.PhpVal, var_block rt.PhpVal, var_instance rt.PhpVal) rt.PhpVal {
	mut var_block_content_mutated := var_block_content
	mut var_namespace := if !(rt.get_property(var_instance, 'attributes').array_get('__woocommerceNamespace')).is_null() { rt.get_property(var_instance, 'attributes').array_get('__woocommerceNamespace') } else { rt.new_string('') }
	mut var_is_product_title_block := rt.identical(rt.new_string('woocommerce/product-collection/product-title'), var_namespace)
	mut var_is_link := if !(rt.get_property(var_instance, 'attributes').array_get('isLink')).is_null() { rt.get_property(var_instance, 'attributes').array_get('isLink') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(var_is_product_title_block) && rt.is_true(var_is_link))) {
		mut var_p := create_automattic_woocommerce_blocks_blocktypes_productcollection_wp_html_tag_processor(var_block_content_mutated.dup())
		var_p.next_tag(rt.create_array([rt.ArrayItem{ key: 'class_name', val: 'wp-block-post-title' }]))
		mut var_is_anchor := var_p.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'a' }]))
		if rt.is_true(var_is_anchor) {
			var_p.set_attribute(rt.new_string('data-wp-on--click'), rt.new_string('woocommerce/product-collection::actions.viewProduct'))
			var_block_content_mutated = var_p.get_updated_html()
		}
	}
	return var_block_content_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) is_block_compatible(var_block_name rt.PhpVal) bool {
	mut var_block_name_mutated := var_block_name
	mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [var_block_name_mutated.dup()])
	mut var_supports_interactivity := rt.new_bool(rt.new_bool(rt.get_property(var_block_type, 'supports').array_isset(rt.new_string('interactivity')) && rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_block_type, 'supports').array_get('interactivity')))))
	mut var_supports_client_navigation := rt.new_bool(rt.new_bool(rt.get_property(var_block_type, 'supports').array_get('interactivity').array_isset(rt.new_string('clientNavigation')) && rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_block_type, 'supports').array_get('interactivity').array_get('clientNavigation')))))
	return rt.is_true(var_supports_interactivity) || rt.is_true(var_supports_client_navigation)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) disable_enhanced_pagination(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_enhanced_query_stack := rt.new_null()
	mut var_dirty_enhanced_queries := rt.new_null()
	// unsupported statement: Stmt_Static
	// unsupported statement: Stmt_Static
	// unsupported statement: Stmt_Static
	mut var_block_name := var_parsed_block.array_get('blockName')
	mut var_is_product_collection_block := if !(var_parsed_block.array_get('attrs').array_get('query').array_get('isProductCollectionBlock')).is_null() { var_parsed_block.array_get('attrs').array_get('query').array_get('isProductCollectionBlock') } else { rt.new_bool(false) }
	mut var_force_page_reload_global := rt.new_bool(rt.new_bool(rt.is_true(if !(var_parsed_block.array_get('attrs').array_get('forcePageReload')).is_null() { var_parsed_block.array_get('attrs').array_get('forcePageReload') } else { rt.new_bool(false) }) && var_parsed_block.array_get('attrs').array_isset(rt.new_string('queryId'))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_is_product_collection_block) && rt.is_true(rt.identical(rt.new_string('woocommerce/product-collection'), var_block_name)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_force_page_reload_global)))))) && var_parsed_block.array_get('attrs').array_isset(rt.new_string('queryId')))) {
		var_enhanced_query_stack.array_push(var_parsed_block.array_get('attrs').array_get('queryId'))
		if !(!(var_render_product_collection_callback).is_null()) {
			closure_1_fn := fn [mut var_enhanced_query_stack, mut var_dirty_enhanced_queries, mut var_render_product_collection_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_content := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_force_page_reload := rt.new_bool(rt.new_bool(rt.is_true(if !(var_block.array_get('attrs').array_get('forcePageReload')).is_null() { var_block.array_get('attrs').array_get('forcePageReload') } else { rt.new_bool(false) }) && var_block.array_get('attrs').array_isset(rt.new_string('queryId'))))
	if rt.is_true(var_force_page_reload) {
		return var_content.dup()
	}
	if var_block.array_get('attrs').array_isset(rt.new_string('queryId')) && var_dirty_enhanced_queries.array_isset(var_block.array_get('attrs').array_get('queryId')) {
		rt.call_function('wp_interactivity_config', [rt.new_string('core/router'), rt.create_array([rt.ArrayItem{ key: 'clientNavigationDisabled', val: true }])])
		var_dirty_enhanced_queries.array_set(var_block.array_get('attrs').array_get('queryId'), rt.new_null())
	}
	rt.call_function('array_pop', [var_enhanced_query_stack.dup()])
	if !rt.is_true(var_enhanced_query_stack) {
		rt.call_function('remove_filter', [rt.new_string('render_block_woocommerce/product-collection'), var_render_product_collection_callback.dup(), rt.new_int(5)])
		var_render_product_collection_callback = rt.new_null()
	}
	return var_content.dup()
	}
			mut var_render_product_collection_callback := rt.new_closure(closure_1_fn)
			rt.call_function('add_filter', [rt.new_string('render_block_woocommerce/product-collection'), var_render_product_collection_callback.dup(), rt.new_int(5), rt.new_int(2)])
		}
	} else if !(!rt.is_true(var_enhanced_query_stack)) && !(var_block_name).is_null() && !(this.is_block_compatible(var_block_name.dup())) {
		{
			mut iter_1 := var_enhanced_query_stack.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_query_id := item_1.val
				var_dirty_enhanced_queries.array_set(var_query_id, true)
			}
		}
	}
	return var_parsed_block.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array', []string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('loopShopPerPage'), rt.call_function('apply_filters', [rt.new_string('loop_shop_per_page'), rt.mul(rt.call_function('wc_get_default_products_per_row', []rt.PhpVal{}), rt.call_function('wc_get_default_product_rows_per_page', []rt.PhpVal{}))])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) register_settings()  {
	rt.call_function('register_setting', [rt.new_string('options'), rt.new_string('woocommerce_default_catalog_orderby'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('How should products be sorted in the catalog by default?'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Default product sorting'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'show_in_rest', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'woocommerce_default_catalog_orderby' }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'menu_order' }, rt.ArrayItem{ key: none, val: 'popularity' }, rt.ArrayItem{ key: none, val: 'rating' }, rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'price' }, rt.ArrayItem{ key: none, val: 'price-desc' }]) }]) }]) }, rt.ArrayItem{ key: 'default', val: 'menu_order' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) update_rest_query_in_editor(var_query rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_is_product_collection_block := rt.call_method(var_request, 'get_param', [rt.new_string('isProductCollectionBlock')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block)))) {
		return var_query_mutated.dup()
	}
	mut var_product_collection_query_context := rt.call_method(var_request, 'get_param', [rt.new_string('productCollectionQueryContext')])
	mut var_collection_args := rt.create_array([rt.ArrayItem{ key: 'name', val: if !(var_product_collection_query_context.array_get('collection')).is_null() { var_product_collection_query_context.array_get('collection') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'productCollectionLocation', val: rt.call_method(var_request, 'get_param', [rt.new_string('productCollectionLocation')]) }])
	mut var_handlers := rt.call_method(this.collection_handler_registry, 'get_collection_handler', [var_collection_args.array_get('name')])
	if var_handlers.array_isset(rt.new_string('editor_args')) {
		var_collection_args = rt.call_function('call_user_func', [var_handlers.array_get('editor_args'), var_collection_args.dup(), var_query_mutated.dup(), var_request.dup()])
	}
	mut var_orderby := rt.call_method(var_request, 'get_param', [rt.new_string('orderby')])
	mut var_preview_state := rt.call_method(var_request, 'get_param', [rt.new_string('previewState')])
	if rt.is_true(rt.new_bool(var_preview_state.array_isset(rt.new_string('isPreview')) && rt.is_true(rt.identical(rt.new_string('true'), var_preview_state.array_get('isPreview'))))) {
		return rt.call_method(this.query_builder, 'get_preview_query_args', [var_collection_args.dup(), rt.call_function('array_merge', [var_query_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'orderby', val: var_orderby }])]), var_request.dup()])
	}
	mut var_on_sale := rt.identical(rt.call_method(var_request, 'get_param', [rt.new_string('woocommerceOnSale')]), rt.new_string('true'))
	mut var_stock_status := rt.call_method(var_request, 'get_param', [rt.new_string('woocommerceStockStatus')])
	mut var_product_attributes := rt.call_method(var_request, 'get_param', [rt.new_string('woocommerceAttributes')])
	mut var_handpicked_products := rt.call_method(var_request, 'get_param', [rt.new_string('woocommerceHandPickedProducts')])
	mut var_featured := rt.call_method(var_request, 'get_param', [rt.new_string('featured')])
	mut var_time_frame := rt.call_method(var_request, 'get_param', [rt.new_string('timeFrame')])
	mut var_price_range := rt.call_method(var_request, 'get_param', [rt.new_string('priceRange')])
	mut var_raw_tax_query_from_rest_params := if !(var_query_mutated.array_get('tax_query')).is_null() { var_query_mutated.array_get('tax_query') } else { rt.new_array() }
	var_query_mutated.array_set('author', '')
	return rt.call_method(this.query_builder, 'get_final_query_args', [var_collection_args.dup(), var_query_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'on_sale', val: var_on_sale }, rt.ArrayItem{ key: 'stock_status', val: var_stock_status }, rt.ArrayItem{ key: 'product_attributes', val: var_product_attributes }, rt.ArrayItem{ key: 'handpicked_products', val: var_handpicked_products }, rt.ArrayItem{ key: 'featured', val: var_featured }, rt.ArrayItem{ key: 'timeFrame', val: var_time_frame }, rt.ArrayItem{ key: 'priceRange', val: var_price_range }, rt.ArrayItem{ key: 'taxonomies_query', val: var_raw_tax_query_from_rest_params }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) add_support_for_filter_blocks(var_pre_render rt.PhpVal, var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_is_product_collection_block := if !(var_parsed_block.array_get('attrs').array_get('query').array_get('isProductCollectionBlock')).is_null() { var_parsed_block.array_get('attrs').array_get('query').array_get('isProductCollectionBlock') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block)))) {
		return var_pre_render.dup()
	}
	rt.call_method(this.renderer, 'set_parsed_block', [var_parsed_block.dup()])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('hasFilterableProducts'), rt.new_bool(true)])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('isRenderingPhpTemplate'), rt.new_bool(true)])
	return var_pre_render.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) build_frontend_query(var_query rt.PhpVal, var_block rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_is_product_collection_block := if !(rt.get_property(var_block, 'context').array_get('query').array_get('isProductCollectionBlock')).is_null() { rt.get_property(var_block, 'context').array_get('query').array_get('isProductCollectionBlock') } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block)))) {
		return var_query_mutated.dup()
	}
	mut var_block_context_query := rt.get_property(var_block, 'context').array_get('query')
	var_block_context_query.array_set('tax_query', if !(!rt.is_true(var_query_mutated.array_get('tax_query'))) { var_query_mutated.array_get('tax_query') } else { rt.new_array() })
	mut var_inherit := if !(rt.get_property(var_block, 'context').array_get('query').array_get('inherit')).is_null() { rt.get_property(var_block, 'context').array_get('query').array_get('inherit') } else { rt.new_bool(false) }
	mut var_filterable := if !(rt.get_property(var_block, 'context').array_get('query').array_get('filterable')).is_null() { rt.get_property(var_block, 'context').array_get('query').array_get('filterable') } else { rt.new_bool(false) }
	mut var_is_exclude_applied_filters := rt.new_bool(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(var_inherit) || rt.is_true(var_filterable))))))
	mut var_collection_args := rt.create_array([rt.ArrayItem{ key: 'name', val: if !(rt.get_property(var_block, 'context').array_get('collection')).is_null() { rt.get_property(var_block, 'context').array_get('collection') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'productCollectionLocation', val: if !(rt.get_property(var_block, 'context').array_get('productCollectionLocation')).is_null() { rt.get_property(var_block, 'context').array_get('productCollectionLocation') } else { rt.new_null() } }])
	return rt.call_method(this.query_builder, 'get_final_frontend_query', [var_collection_args.dup(), var_block_context_query.dup(), var_page.dup(), var_is_exclude_applied_filters.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) extend_rest_query_allowed_params(var_params rt.PhpVal) rt.PhpVal {
	mut var_original_enum := if var_params.array_get('orderby').array_isset(rt.new_string('enum')) { var_params.array_get('orderby').array_get('enum') } else { rt.new_array() }
	var_params.array_get_mut('orderby').array_set('enum', rt.call_function('array_unique', [rt.call_function('array_merge', [var_original_enum.dup(), rt.call_method(this.query_builder, 'get_custom_order_opts', []rt.PhpVal{})])]))
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) register_core_collections_and_set_handler_store()  {
	mut var_collection_handler_store := rt.call_method(this.collection_handler_registry, 'register_core_collections', []rt.PhpVal{})
	rt.call_method(this.query_builder, 'set_collection_handler_store', [var_collection_handler_store.dup()])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_controller() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-collection')
		collection_handler_registry: rt.new_null()
		query_builder: rt.new_null()
		renderer: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_querybuilder() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_renderer() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_handlerregistry() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_wp_block_type_registry() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_Block_Type_Registry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'add_product_title_click_event_directives' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_product_title_click_event_directives(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'is_block_compatible' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_block_compatible(dispatch_arg_0))
		}
		'disable_enhanced_pagination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.disable_enhanced_pagination(dispatch_arg_0)
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_settings' {
			this.register_settings()
			return rt.new_null()
		}
		'update_rest_query_in_editor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_rest_query_in_editor(dispatch_arg_0, dispatch_arg_1)
		}
		'add_support_for_filter_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_support_for_filter_blocks(dispatch_arg_0, dispatch_arg_1)
		}
		'build_frontend_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.build_frontend_query(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'extend_rest_query_allowed_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.extend_rest_query_allowed_params(dispatch_arg_0)
		}
		'register_core_collections_and_set_handler_store' {
			this.register_core_collections_and_set_handler_store()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'collection_handler_registry' { return this.collection_handler_registry }
		'query_builder' { return this.query_builder }
		'renderer' { return this.renderer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		'collection_handler_registry' { this.collection_handler_registry = val; return true }
		'query_builder' { this.query_builder = val; return true }
		'renderer' { this.renderer = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_QueryBuilder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_HandlerRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productcollection_controller_php() {
	// unsupported statement: Stmt_Declare
}
