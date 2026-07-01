import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_first_block() string {
	return '__wooCommerceIsFirstBlock'
}
pub fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_last_block() string {
	return '__wooCommerceIsLastBlock'
}
struct Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) inject_hooks(var_block_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product', []rt.PhpVal{}))))) {
		return var_block_content.dup()
	}
	this.remove_default_hooks()
	mut var_block_name := var_block.array_get('blockName')
	closure_1_fn := fn [var_block_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_hook := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('in_array', [var_block_name.dup(), var_hook.array_get('block_names'), rt.new_bool(true)])
	}
	mut var_block_hooks := rt.call_function('array_filter', [rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility'], &this), 'hook_data'), rt.new_closure(closure_1_fn)])
	mut var_first_or_last_block_content := this.inject_hook_to_first_and_last_blocks(var_block_content.dup(), var_block.dup(), var_block_hooks.dup())
	if !(var_first_or_last_block_content).is_null() {
		return var_first_or_last_block_content.dup()
	}
	return rt.call_function('sprintf', [rt.new_string('%1$s%2$s%3$s'), this.get_hooks_buffer(var_block_hooks.dup(), rt.new_string('before')), var_block_content.dup(), this.get_hooks_buffer(var_block_hooks.dup(), rt.new_string('after'))])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) inject_hook_to_first_and_last_blocks(var_block_content rt.PhpVal, var_block rt.PhpVal, var_block_hooks rt.PhpVal) rt.PhpVal {
	mut var_block_hooks_mutated := var_block_hooks
	mut var_first_block_hook := rt.create_array([rt.ArrayItem{ key: 'before', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_before_main_content', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility'], &this), 'hook_data').array_get('woocommerce_before_main_content') }, rt.ArrayItem{ key: 'woocommerce_before_single_product', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility'], &this), 'hook_data').array_get('woocommerce_before_single_product') }, rt.ArrayItem{ key: 'woocommerce_before_single_product_summary', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility'], &this), 'hook_data').array_get('woocommerce_before_single_product_summary') }]) }, rt.ArrayItem{ key: 'after', val: rt.new_array() }])
	mut var_last_block_hook := rt.create_array([rt.ArrayItem{ key: 'before', val: rt.new_array() }, rt.ArrayItem{ key: 'after', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_after_single_product', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility'], &this), 'hook_data').array_get('woocommerce_after_single_product') }, rt.ArrayItem{ key: 'woocommerce_after_main_content', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility'], &this), 'hook_data').array_get('woocommerce_after_main_content') }, rt.ArrayItem{ key: 'woocommerce_sidebar', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility', ['Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility'], &this), 'hook_data').array_get('woocommerce_sidebar') }]) }])
	if var_block.array_get('attrs').array_isset(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_first_block()) && var_block.array_get('attrs').array_isset(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_last_block()) {
		return rt.call_function('sprintf', [rt.new_string('%1$s%2$s'), this.inject_hooks_after_the_wrapper(var_block_content.dup(), rt.call_function('array_merge', [var_first_block_hook.array_get('before'), var_block_hooks_mutated.dup(), var_last_block_hook.array_get('before')])), this.get_hooks_buffer(rt.call_function('array_merge', [var_first_block_hook.array_get('after'), var_block_hooks_mutated.dup(), var_last_block_hook.array_get('after')]), rt.new_string('after'))])
	}
	if var_block.array_get('attrs').array_isset(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_first_block()) {
		return rt.call_function('sprintf', [rt.new_string('%1$s%2$s'), this.inject_hooks_after_the_wrapper(var_block_content.dup(), rt.call_function('array_merge', [var_first_block_hook.array_get('before'), var_block_hooks_mutated.dup()])), this.get_hooks_buffer(rt.call_function('array_merge', [var_first_block_hook.array_get('after'), var_block_hooks_mutated.dup()]), rt.new_string('after'))])
	}
	if var_block.array_get('attrs').array_isset(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_last_block()) {
		return rt.call_function('sprintf', [rt.new_string('%1$s%2$s%3$s'), this.get_hooks_buffer(rt.call_function('array_merge', [var_last_block_hook.array_get('before'), var_block_hooks_mutated.dup()]), rt.new_string('before')), var_block_content.dup(), this.get_hooks_buffer(rt.call_function('array_merge', [var_block_hooks_mutated.dup(), var_last_block_hook.array_get('after')]), rt.new_string('after'))])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) update_render_block_data(var_parsed_block rt.PhpVal, var_source_block rt.PhpVal, var_parent_block rt.PhpVal) rt.PhpVal {
	return var_parsed_block.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) set_hook_data()  {
	this.dispatch_set_prop('hook_data', rt.create_array([rt.ArrayItem{ key: 'woocommerce_before_main_content', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.new_array() }, rt.ArrayItem{ key: 'position', val: 'before' }, rt.ArrayItem{ key: 'hooked', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_output_content_wrapper', val: 10 }, rt.ArrayItem{ key: 'woocommerce_breadcrumb', val: 20 }]) }]) }, rt.ArrayItem{ key: 'woocommerce_after_main_content', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.new_array() }, rt.ArrayItem{ key: 'position', val: 'after' }, rt.ArrayItem{ key: 'hooked', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_output_content_wrapper_end', val: 10 }]) }]) }, rt.ArrayItem{ key: 'woocommerce_sidebar', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.new_array() }, rt.ArrayItem{ key: 'position', val: 'after' }, rt.ArrayItem{ key: 'hooked', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_get_sidebar', val: 10 }]) }]) }, rt.ArrayItem{ key: 'woocommerce_before_single_product', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.new_array() }, rt.ArrayItem{ key: 'position', val: 'before' }, rt.ArrayItem{ key: 'hooked', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_output_all_notices', val: 10 }]) }]) }, rt.ArrayItem{ key: 'woocommerce_before_single_product_summary', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.new_array() }, rt.ArrayItem{ key: 'position', val: 'before' }, rt.ArrayItem{ key: 'hooked', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_show_product_sale_flash', val: 10 }, rt.ArrayItem{ key: 'woocommerce_show_product_images', val: 20 }]) }]) }, rt.ArrayItem{ key: 'woocommerce_single_product_summary', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.create_array([rt.ArrayItem{ key: none, val: 'core/post-excerpt' }, rt.ArrayItem{ key: none, val: 'woocommerce/product-summary' }]) }, rt.ArrayItem{ key: 'position', val: 'before' }, rt.ArrayItem{ key: 'hooked', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_template_single_title', val: 5 }, rt.ArrayItem{ key: 'woocommerce_template_single_rating', val: 10 }, rt.ArrayItem{ key: 'woocommerce_template_single_price', val: 10 }, rt.ArrayItem{ key: 'woocommerce_template_single_excerpt', val: 20 }, rt.ArrayItem{ key: 'woocommerce_template_single_add_to_cart', val: 30 }, rt.ArrayItem{ key: 'woocommerce_template_single_meta', val: 40 }, rt.ArrayItem{ key: 'woocommerce_template_single_sharing', val: 50 }]) }]) }, rt.ArrayItem{ key: 'woocommerce_after_single_product', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.new_array() }, rt.ArrayItem{ key: 'position', val: 'after' }, rt.ArrayItem{ key: 'hooked', val: rt.new_array() }]) }, rt.ArrayItem{ key: 'woocommerce_product_meta_start', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/product-meta' }]) }, rt.ArrayItem{ key: 'position', val: 'before' }, rt.ArrayItem{ key: 'hooked', val: rt.new_array() }]) }, rt.ArrayItem{ key: 'woocommerce_product_meta_end', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/product-meta' }]) }, rt.ArrayItem{ key: 'position', val: 'after' }, rt.ArrayItem{ key: 'hooked', val: rt.new_array() }]) }, rt.ArrayItem{ key: 'woocommerce_share', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/product-details' }]) }, rt.ArrayItem{ key: 'position', val: 'before' }, rt.ArrayItem{ key: 'hooked', val: rt.new_array() }]) }, rt.ArrayItem{ key: 'woocommerce_after_single_product_summary', val: rt.create_array([rt.ArrayItem{ key: 'block_names', val: rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/product-details' }]) }, rt.ArrayItem{ key: 'position', val: 'after' }, rt.ArrayItem{ key: 'hooked', val: rt.create_array([rt.ArrayItem{ key: 'woocommerce_output_product_data_tabs', val: 10 }, rt.ArrayItem{ key: 'woocommerce_output_related_products', val: 20 }]) }]) }]))
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.add_compatibility_layer(var_template_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_template_content.dup()
	}
	mut var_blocks := rt.call_function('parse_blocks', [var_template_content.dup()])
	if rt.is_true(Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.has_single_product_template_blocks(var_blocks.dup())) {
		var_blocks = Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.wrap_single_product_template(var_template_content.dup())
	}
	mut var_template := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.inject_custom_attributes_to_first_and_last_block_single_product_template(var_blocks.dup())
	return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.serialize_blocks(var_template.dup())
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.wrap_single_product_template(var_template_content rt.PhpVal) rt.PhpVal {
	mut var_parsed_blocks := rt.call_function('parse_blocks', [var_template_content.dup()])
	mut var_grouped_blocks := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.group_blocks(var_parsed_blocks.dup())
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_blocks := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.identical(rt.new_string('core/template-part'), var_blocks.array_get(0).array_get('blockName'))) {
		return var_blocks.dup()
	}
	mut var_has_single_product_template_blocks := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.has_single_product_template_blocks(var_blocks.dup())
	if rt.is_true(var_has_single_product_template_blocks) {
		mut var_wrapped_block := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.create_wrap_block_group(var_blocks.dup())
		return rt.create_array([rt.ArrayItem{ key: none, val: var_wrapped_block.array_get(0) }])
	}
	return var_blocks.dup()
	}
	mut var_blocks := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.identical(rt.new_string('core/template-part'), var_blocks.array_get(0).array_get('blockName'))) {
		return var_blocks.dup()
	}
	mut var_has_single_product_template_blocks := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.has_single_product_template_blocks(var_blocks.dup())
	if rt.is_true(var_has_single_product_template_blocks) {
		mut var_wrapped_block := Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.create_wrap_block_group(var_blocks.dup())
		return rt.create_array([rt.ArrayItem{ key: none, val: var_wrapped_block.array_get(0) }])
	}
	return var_blocks.dup()
	}
	mut var_wrapped_blocks := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_grouped_blocks.dup()])
	return var_wrapped_blocks.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.inject_custom_attributes_to_first_and_last_block_single_product_template(var_wrapped_blocks rt.PhpVal) rt.PhpVal {
	mut var_wrapped_blocks_mutated := var_wrapped_blocks
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_item := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_index := var_carry.array_get('index')
	var_carry.array_set('index', rt.add(var_carry.array_get('index'), rt.new_int(1)))
	mut var_block := if var_item.array_isset(rt.new_int(0)) { var_item.array_get(0) } else { var_item }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/template-part'), var_block.array_get('blockName'))) || rt.is_true(Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_custom_html(var_block.dup())))) {
		var_carry.array_get_mut('template').array_push(var_block.dup())
		return var_carry.dup()
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_carry.array_get('first_block').array_get('index'))) {
		var_block.array_get_mut('attrs').array_set(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_first_block(), true)
		var_carry.array_get_mut('first_block').array_set('index', var_index.dup())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_index_element := var_carry.array_get('last_block').array_get('index')
		var_carry.array_get_mut('last_block').array_set('index', var_index.dup())
		var_block.array_get_mut('attrs').array_set(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_last_block(), true)
		var_carry.array_get('template').array_get(var_index_element).array_get('attrs').array_unset(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_last_block())
		var_carry.array_get_mut('template').array_push(var_block.dup())
		return var_carry.dup()
	}
	var_block.array_get_mut('attrs').array_set(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_last_block(), true)
	var_carry.array_get_mut('last_block').array_set('index', var_index.dup())
	var_carry.array_get_mut('template').array_push(var_block.dup())
	return var_carry.dup()
	}
	mut var_template_with_custom_attributes := rt.call_function('array_reduce', [var_wrapped_blocks_mutated.dup(), rt.new_closure(closure_4_fn), rt.create_array([rt.ArrayItem{ key: 'template', val: rt.new_array() }, rt.ArrayItem{ key: 'first_block', val: rt.create_array([rt.ArrayItem{ key: 'index', val: '' }]) }, rt.ArrayItem{ key: 'last_block', val: rt.create_array([rt.ArrayItem{ key: 'index', val: '' }]) }, rt.ArrayItem{ key: 'index', val: 0 }])])
	return rt.create_array([rt.ArrayItem{ key: none, val: var_template_with_custom_attributes.array_get('template') }])
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.create_wrap_block_group(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	mut var_serialized_blocks := rt.call_function('serialize_blocks', [var_blocks_mutated.dup()])
	mut var_new_block := rt.call_function('parse_blocks', [rt.call_function('sprintf', [rt.new_string('<!-- wp:group {"className":"woocommerce product"} -->\n\t\t\t\t<div class="wp-block-group woocommerce product">\n\t\t\t\t\t%1$s\n\t\t\t\t</div>\n\t\t\t<!-- /wp:group -->'), var_serialized_blocks.dup()])])
	var_new_block.array_set('innerBlocks', var_blocks_mutated.dup())
	return var_new_block.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.has_single_product_template_blocks(var_parsed_blocks rt.PhpVal) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	mut var_single_product_template_blocks := rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/product-image-gallery' }, rt.ArrayItem{ key: none, val: 'woocommerce/product-gallery' }, rt.ArrayItem{ key: none, val: 'woocommerce/product-details' }, rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-form' }, rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-with-options' }, rt.ArrayItem{ key: none, val: 'woocommerce/product-meta' }, rt.ArrayItem{ key: none, val: 'woocommerce/product-price' }, rt.ArrayItem{ key: none, val: 'woocommerce/breadcrumbs' }])
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.has_block_including_patterns(arg_0, arg_1) }(var_single_product_template_blocks.dup(), var_parsed_blocks_mutated.dup())
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.group_blocks(var_parsed_blocks rt.PhpVal) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.identical(rt.new_string('core/template-part'), var_block.array_get('blockName'))) {
		var_carry.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_block }]))
		return var_carry.dup()
	}
	mut var_last_element_index := rt.new_int(var_carry.dup().array_count() - 1)
	if rt.is_true(rt.new_bool(var_carry.array_get(var_last_element_index).array_get(0).array_isset(rt.new_string('blockName')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_carry.array_get_mut(var_last_element_index).array_push(var_block.dup())
		return var_carry.dup()
	}
	var_carry.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_block }]))
	return var_carry.dup()
	}
	return rt.call_function('array_reduce', [var_parsed_blocks_mutated.dup(), rt.new_closure(closure_5_fn), rt.new_array()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) inject_hooks_after_the_wrapper(var_block_content rt.PhpVal, var_hooks rt.PhpVal) rt.PhpVal {
	mut var_closing_tag_position := rt.call_function('strpos', [var_block_content.dup(), rt.new_string('>')])
	return rt.call_function('substr_replace', [var_block_content.dup(), this.get_hooks_buffer(var_hooks.dup(), rt.new_string('before')), rt.add(var_closing_tag_position, rt.new_int(1)), rt.new_int(0)])
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_custom_html(var_block rt.PhpVal) bool {
	return !rt.is_true(var_block.array_get('blockName')) && !(!rt.is_true(var_block.array_get('innerHTML')))
}

fn Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.serialize_blocks(var_parsed_blocks rt.PhpVal) rt.PhpVal {
	mut var_parsed_blocks_mutated := var_parsed_blocks
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_item := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(var_item.dup().is_array())) {
		return rt.new_string((var_carry).str() + (rt.call_function('serialize_blocks', [var_item.dup()])).str())
	}
	return rt.new_string((var_carry).str() + (rt.call_function('serialize_block', [var_item.dup()])).str())
	}
	return rt.call_function('array_reduce', [var_parsed_blocks_mutated.dup(), rt.new_closure(closure_6_fn), rt.new_string('')])
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_singleproducttemplatecompatibility() &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatecompatibility() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'inject_hooks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.inject_hooks(dispatch_arg_0, dispatch_arg_1)
		}
		'inject_hook_to_first_and_last_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.inject_hook_to_first_and_last_blocks(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_render_block_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_render_block_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_hook_data' {
			this.set_hook_data()
			return rt.new_null()
		}
		'add_compatibility_layer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.add_compatibility_layer(dispatch_arg_0)
		}
		'wrap_single_product_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.wrap_single_product_template(dispatch_arg_0)
		}
		'inject_custom_attributes_to_first_and_last_block_single_product_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.inject_custom_attributes_to_first_and_last_block_single_product_template(dispatch_arg_0)
		}
		'create_wrap_block_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.create_wrap_block_group(dispatch_arg_0)
		}
		'has_single_product_template_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.has_single_product_template_blocks(dispatch_arg_0)
		}
		'group_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.group_blocks(dispatch_arg_0)
		}
		'inject_hooks_after_the_wrapper' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.inject_hooks_after_the_wrapper(dispatch_arg_0, dispatch_arg_1)
		}
		'is_custom_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.is_custom_html(dispatch_arg_0))
		}
		'serialize_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility.serialize_blocks(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplateCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_singleproducttemplatecompatibility_php() {
	// unsupported statement: Stmt_Declare
}
