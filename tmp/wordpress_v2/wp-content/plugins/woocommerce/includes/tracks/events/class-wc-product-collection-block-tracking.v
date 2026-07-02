import rt

struct Class_WC_Product_Collection_Block_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Product_Collection_Block_Tracking) init() {
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_Collection_Block_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_collection_instances' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_Product_Collection_Block_Tracking) track_collection_instances(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('REST_REQUEST')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('REST_REQUEST'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return
	}
	mut var_post_status := rt.get_property(var_post, 'post_status')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_post_status)))) {
		return
	}
	mut var_post_type := rt.get_property(var_post, 'post_type')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'wp_template' }, rt.ArrayItem{ key: none, val: 'wp_template_part' }, rt.ArrayItem{ key: none, val: 'wp_block' }]), rt.new_bool(true)]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_block', [rt.new_string('woocommerce/product-collection'), var_post.clone()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_block', [rt.new_string('core/template-part'), var_post.clone()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_block', [rt.new_string('core/block'), var_post.clone()]))))) {
		return
	}
	mut var_blocks := rt.call_function('parse_blocks', [rt.get_property(var_post, 'post_content')])
	if !rt.is_true(var_blocks) {
		return
	}
	mut var_instances := this.parse_blocks_track_data(var_blocks.clone(), false, false, false)
	if !rt.is_true(var_instances) {
		return
	}
	mut var_order_count := rt.new_int(0)
	mut iter_1 := rt.call_function('wc_get_order_statuses', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_status_name := item_1.val
		mut var_status_slug := item_1.key
		var_order_count = rt.add(var_order_count, rt.call_function('wc_orders_count', [var_status_slug.clone()]))
	}
	mut var_additional_data := { 'editor_context': this.parse_editor_location_context(var_post.clone()), 'order_count': var_order_count }
	mut iter_2 := var_instances.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_instance := item_2.val
	mut var_event_properties := rt.call_function('array_merge', [rt.create_array_from_native_map(var_additional_data), var_instance.clone()])
	mut iife_temp_0 := Class_WC_Tracks{}
	mut iife_result_0 := iife_temp_0.record_event(rt.new_string('product_collection_instance'), var_event_properties.clone())
	}
}

fn (mut this Class_WC_Product_Collection_Block_Tracking) parse_blocks_track_data(var_blocks rt.PhpVal, is_in_single_product bool, is_in_template_part bool, is_in_synced_pattern bool) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	mut var_instances := rt.new_array()
	if !(var_blocks_mutated.clone().is_array()) || !rt.is_true(var_blocks_mutated) {
		return var_instances.clone()
	}
	mut iter_3 := var_blocks_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_block := item_3.val
		if !rt.is_true(var_block.array_get(rt.new_string('blockName'))) {
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('woocommerce/product-collection'), var_block.array_get(rt.new_string('blockName')))) {
			var_instances.array_push(rt.create_array([rt.ArrayItem{ key: 'collection', val: if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('collection')) } else { rt.new_string('product-catalog') } }, rt.ArrayItem{ key: 'in_single_product', val: if var_is_in_single_product { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'in_template_part', val: if var_is_in_template_part { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'in_synced_pattern', val: if var_is_in_synced_pattern { 'yes' } else { 'no' } }, rt.ArrayItem{ key: 'filters', val: rt.call_function('wp_json_encode', [this.get_query_filters_usage_data(var_block.clone()), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]) }]))
		}
		mut var_local_is_in_single_product := rt.new_bool(is_in_single_product)
		if rt.is_true(rt.identical(rt.new_string('woocommerce/single-product'), var_block.array_get(rt.new_string('blockName')))) {
		var_local_is_in_single_product = rt.new_bool(true)
		}
		if !(var_is_in_synced_pattern) && !(var_is_in_template_part) && rt.is_true(rt.identical(rt.new_string('core/template-part'), var_block.array_get(rt.new_string('blockName')))) {
			mut var_template_part_theme := if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('theme'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('theme')) } else { rt.new_string('') }
			mut var_template_part_slug := if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('slug'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('slug')) } else { rt.new_string('') }
			mut var_template_part := rt.call_function('get_block_template', [rt.new_string((var_template_part_theme).str() + '//' + (var_template_part_slug).str()), rt.new_string('wp_template_part')])
			if rt.is_true(rt.new_bool(rt.instance_of(var_template_part, 'WP_Block_Template'))) && !(!rt.is_true(rt.get_property(var_template_part, 'content'))) {
			var_instances = rt.call_function('array_merge', [var_instances.clone(), this.parse_blocks_track_data(rt.call_function('parse_blocks', [rt.get_property(var_template_part, 'content')]), (var_local_is_in_single_product).to_bool(), true, is_in_synced_pattern)])
			}
		}
		if !(var_is_in_synced_pattern) && !(var_is_in_template_part) && rt.is_true(rt.identical(rt.new_string('core/block'), var_block.array_get(rt.new_string('blockName')))) {
			mut var_block_id := if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('ref'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('ref')) } else { rt.new_int(0) }
			mut var_synced_pattern := rt.call_function('get_post', [var_block_id.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_synced_pattern, 'WP_Post'))) && !(!rt.is_true(rt.get_property(var_synced_pattern, 'post_content'))) {
			var_instances = rt.call_function('array_merge', [var_instances.clone(), this.parse_blocks_track_data(rt.call_function('parse_blocks', [rt.get_property(var_synced_pattern, 'post_content')]), (var_local_is_in_single_product).to_bool(), is_in_template_part, true)])
			}
		}
		if !(!rt.is_true(var_block.array_get(rt.new_string('innerBlocks')))) {
		var_instances = rt.call_function('array_merge', [var_instances.clone(), this.parse_blocks_track_data(var_block.array_get(rt.new_string('innerBlocks')), (var_local_is_in_single_product).to_bool(), is_in_template_part, is_in_synced_pattern)])
		}
	}
	return var_instances.clone()
}

fn (mut this Class_WC_Product_Collection_Block_Tracking) parse_editor_location_context(var_post rt.PhpVal) rt.PhpVal {
	mut var_context := rt.new_string('other')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return var_context.clone()
	}
	mut var_post_type := rt.get_property(var_post, 'post_type')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'wp_template' }, rt.ArrayItem{ key: none, val: 'wp_template_part' }, rt.ArrayItem{ key: none, val: 'wp_block' }]), rt.new_bool(true)]))))) {
		return var_context.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('wp_template'), var_post_type)) {
		mut var_name := rt.get_property(var_post, 'post_name')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_name.clone(), Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.slug()]))))) {
		var_context = rt.new_string('single-product')
		} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug(), var_name)) {
		var_context = rt.new_string('product-archive')
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_name.clone(), rt.new_string('taxonomy-')]))))) {
			mut var_taxonomy := rt.call_function('str_replace', [rt.new_string('taxonomy-'), rt.new_string(''), var_name.clone()])
			mut var_product_taxonomies := rt.call_function('get_object_taxonomies', [rt.new_string('product'), rt.new_string('names')])
			if rt.is_true(rt.call_function('in_array', [var_taxonomy.clone(), var_product_taxonomies.clone(), rt.new_bool(true)])) {
			var_context = rt.new_string('product-archive')
			}
		} else if rt.is_true(rt.call_function('in_array', [var_name.clone(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate.slug() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate.slug() }]), rt.new_bool(true)])) {
		var_context = rt.new_string('cart')
		} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate.slug(), var_name)) {
		var_context = rt.new_string('checkout')
		} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate.slug(), var_name)) {
		var_context = rt.new_string('product-catalog')
		} else if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate.slug(), var_name)) {
		var_context = rt.new_string('order-confirmation')
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'wp_block' }, rt.ArrayItem{ key: none, val: 'wp_template_part' }]), rt.new_bool(true)])) {
	var_context = rt.new_string('isolated')
	}
	if rt.is_true(rt.identical(rt.new_string('page'), var_post_type)) {
	var_context = rt.new_string('page')
	}
	if rt.is_true(rt.identical(rt.new_string('post'), var_post_type)) {
	var_context = rt.new_string('post')
	}
	return var_context.clone()
}

fn (mut this Class_WC_Product_Collection_Block_Tracking) get_query_filters_usage_data(var_block rt.PhpVal) rt.PhpVal {
	if !(var_block.array_isset(rt.new_string('attrs'))) {
		return rt.new_array()
	}
	mut var_query_attrs := if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query'))).is_null() { var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('query')) } else { rt.new_array() }
	mut var_filters := { 'inherit': 'no', 'order-by': 'no', 'on-sale': 'no', 'stock-status': 'no', 'handpicked': 'no', 'keyword': 'no', 'attributes': 'no', 'category': 'no', 'tag': 'no', 'featured': 'no', 'created': 'no', 'price': 'no' }
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('inherit')))) && rt.is_true(rt.identical(rt.new_bool(true), var_query_attrs.array_get(rt.new_string('inherit')))) {
		var_filters['inherit'] = 'yes'
	}
	if (!(!rt.is_true(var_query_attrs.array_get(rt.new_string('order')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('asc'), var_query_attrs.array_get(rt.new_string('order'))))))) || (!(!rt.is_true(var_query_attrs.array_get(rt.new_string('orderBy')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('title'), var_query_attrs.array_get(rt.new_string('orderBy'))))))) {
		var_filters['order-by'] = 'yes'
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('woocommerceOnSale')))) {
		var_filters['on-sale'] = 'yes'
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('woocommerceStockStatus')))) {
		mut var_stock_statuses := rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})
		mut var_default_values := if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_hide_out_of_stock_items')]))) { rt.call_function('array_diff_key', [var_stock_statuses.clone(), rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock(), val: '' }])]) } else { var_stock_statuses }
		mut var_default_diff := rt.call_function('array_diff', [rt.func_array_keys(var_default_values.clone()), var_query_attrs.array_get(rt.new_string('woocommerceStockStatus'))])
		if !(!rt.is_true(var_default_diff)) {
			var_filters['stock-status'] = 'yes'
		}
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('woocommerceAttributes')))) {
		var_filters['attributes'] = 'yes'
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('timeFrame')))) {
		var_filters['created'] = 'yes'
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('taxQuery')))) {
		if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('taxQuery')).array_get(rt.new_string('product_cat')))) {
			var_filters['category'] = 'yes'
		}
		if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('taxQuery')).array_get(rt.new_string('product_tag')))) {
			var_filters['tag'] = 'yes'
		}
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('woocommerceHandPickedProducts')))) {
		var_filters['handpicked'] = 'yes'
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('search')))) {
		var_filters['keyword'] = 'yes'
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('featured')))) {
		var_filters['featured'] = 'yes'
	}
	if !(!rt.is_true(var_query_attrs.array_get(rt.new_string('priceRange')))) {
		var_filters['price'] = 'yes'
	}
	return var_filters.clone()
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_product_collection_block_tracking(_args ...rt.PhpVal) &Class_WC_Product_Collection_Block_Tracking {
	mut obj := &Class_WC_Product_Collection_Block_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_Collection_Block_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_collection_instances' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.track_collection_instances(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse_blocks_track_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.parse_blocks_track_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'parse_editor_location_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_editor_location_context(dispatch_arg_0)
		}
		'get_query_filters_usage_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_query_filters_usage_data(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Collection_Block_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Collection_Block_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
