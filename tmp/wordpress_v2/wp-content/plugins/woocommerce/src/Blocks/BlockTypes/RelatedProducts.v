import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts {
	rt.PhpObjectBase
pub mut:
	block_name   rt.PhpVal = rt.new_string('related-products')
	parsed_block rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('pre_render_block'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_query' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'render_block' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) update_query(var_pre_render rt.PhpVal, var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block_mutated := var_parsed_block
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('core/query'),
		var_parsed_block_mutated.array_get(rt.new_string('blockName'))))))
	{
		return var_pre_render.clone()
	}
	this.parsed_block = var_parsed_block_mutated.clone()
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery{}
	mut iife_result_0 := iife_temp_0.is_woocommerce_variation(var_parsed_block_mutated.clone())
	if rt.is_true(iife_result_0)
		&& rt.is_true(rt.identical(rt.new_string('woocommerce/related-products'), var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('namespace')))) {
		rt.call_function('add_filter', [rt.new_string('query_loop_block_query_vars'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{ key: none, val: 'build_query' },
			]),
			rt.new_int(10), rt.new_int(2)])
	}
	return var_pre_render.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) build_query(var_query rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_parsed_block := this.parsed_block
	if !(this.is_related_products_block(var_parsed_block.clone(), var_block.clone())) {
		return var_query.clone()
	}
	mut var_related_products_ids :=
		this.get_related_products_ids((var_query.array_get(rt.new_string('posts_per_page'))).to_i64())
	if var_related_products_ids.clone().array_count() < 1 {
		return rt.new_array()
	}
	return rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' },
		rt.ArrayItem{ key: 'post__in', val: var_related_products_ids },
		rt.ArrayItem{
			key: 'post_status'
			val: Class_Automattic_WooCommerce_Enums_ProductStatus.publish()
		}, rt.ArrayItem{
			key: 'posts_per_page'
			val: var_query.array_get(rt.new_string('posts_per_page'))
		}])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) render_block(content string, mut var_block Class_Automattic_WooCommerce_Blocks_BlockTypes_array) string {
	if !(this.is_related_products_block(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_block), rt.new_null())) {
		return content
	}
	mut var_related_products_ids := this.get_related_products_ids(0)
	if var_related_products_ids.clone().array_count() < 1 {
		return ''
	}
	return content
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) is_related_products_block(var_parsed_block rt.PhpVal, var_rendered_block rt.PhpVal) bool {
	mut var_parsed_block_mutated := var_parsed_block
	mut var_is_product_collection_block := if !(rt.get_property(var_rendered_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('isProductCollectionBlock'))).is_null() {
		rt.get_property(var_rendered_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('isProductCollectionBlock'))
	} else {
		rt.new_bool(false)
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery{}
	mut iife_result_1 := iife_temp_1.is_woocommerce_variation(var_parsed_block_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_product_collection_block))))
		&& rt.is_true(rt.identical(rt.new_string('woocommerce/related-products'), if !(var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('namespace'))).is_null() { var_parsed_block_mutated.array_get(rt.new_string('attrs')).array_get(rt.new_string('namespace')) } else { rt.new_null() }))
		&& rt.is_true(iife_result_1) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) get_related_products_ids(product_per_page i64) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_product := rt.call_function('wc_get_product', [
		rt.get_property(var_post, 'ID'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product'))))))
	{
		return rt.new_array()
	}
	mut var_related_products_ids := rt.call_function('wc_get_related_products', [
		rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.new_int(product_per_page),
		rt.call_method(var_product, 'get_upsell_ids', []rt.PhpVal{}),
	])
	if !(!rt.is_true(var_related_products_ids)) {
		rt.call_function('_prime_post_caches', [var_related_products_ids.clone()])
		mut var_related_products := rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('wc_get_product'),
				var_related_products_ids.clone()]),
			rt.new_string('wc_products_array_filter_visible'),
		])
		var_related_products = rt.call_function('wc_products_array_orderby', [
			var_related_products.clone(), rt.new_string('rand'),
			rt.new_string('desc')])
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_int((rt.call_method(var_product, 'get_image_id', []rt.PhpVal{})).to_i64())
		}
		rt.call_function('_prime_post_caches', [
			rt.call_function('array_filter', [
				rt.call_function('array_map', [rt.new_closure(closure_3_fn),
					var_related_products.clone()]),
			]),
		])
		closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		}
		closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_product := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		}
		var_related_products_ids = rt.call_function('array_map', [
			rt.new_closure(closure_11_fn),
			var_related_products.clone(),
		])
	}
	return var_related_products_ids.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_relatedproducts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('related-products')
		parsed_block:  rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productquery(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'update_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_query(dispatch_arg_0, dispatch_arg_1)
		}
		'build_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.build_query(dispatch_arg_0, dispatch_arg_1)
		}
		'render_block' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_block(dispatch_arg_0, mut dispatch_arg_1))
		}
		'is_related_products_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.is_related_products_block(dispatch_arg_0, dispatch_arg_1))
		}
		'get_related_products_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_related_products_ids(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'parsed_block' { return this.parsed_block }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_RelatedProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'parsed_block' {
			this.parsed_block = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
