import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-template')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) initialize() {
	rt.call_function('add_filter', [rt.new_string('block_type_metadata_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_block_type_metadata_settings' },
		]),
		rt.new_int(10), rt.new_int(2)])
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content_mutated := var_content
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{}
	mut iife_result_0 := iife_temp_0.prepare_and_execute_query(var_block.clone())
	mut var_query := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'have_posts', []rt.PhpVal{}))))) {
		return ''
	}
	if this.block_core_post_template_uses_featured_image(rt.get_property(var_block, 'inner_blocks')) {
		rt.call_function('update_post_thumbnail_cache', [var_query.clone()])
	}
	mut var_classnames := rt.new_string('')
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('displayLayout'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('query')) {
		var_classnames = rt.new_string('is-product-collection-layout-' +
			(rt.get_property(var_block, 'context').array_get(rt.new_string('displayLayout')).array_get(rt.new_string('type'))).str() +
			' ')
		if rt.get_property(var_block, 'context').array_get(rt.new_string('displayLayout')).array_isset(rt.new_string('type'))
			&& rt.is_true(rt.identical(rt.new_string('flex'), rt.get_property(var_block, 'context').array_get(rt.new_string('displayLayout')).array_get(rt.new_string('type')))) {
			if rt.get_property(var_block, 'context').array_get(rt.new_string('displayLayout')).array_isset(rt.new_string('shrinkColumns'))
				&& rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('displayLayout')).array_get(rt.new_string('shrinkColumns'))) {
				var_classnames = rt.new_string((rt.concat(rt.new_string('wc-block-product-template__responsive columns-'), rt.get_property(var_block,
					'context').array_get(rt.new_string('displayLayout')).array_get(rt.new_string('columns')))).str())
			} else {
				var_classnames = rt.new_string((rt.concat(rt.new_string('is-flex-container columns-'), rt.get_property(var_block,
					'context').array_get(rt.new_string('displayLayout')).array_get(rt.new_string('columns')))).str())
			}
		}
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classnames = rt.concat(var_classnames, rt.new_string(' has-link-color'))
	}
	var_classnames = rt.concat(var_classnames, rt.new_string(' wc-block-product-template'))
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: var_classnames.clone().to_string().trim_space() },
			rt.ArrayItem{ key: 'data-wp-on--scroll', val: 'actions.watchScroll' },
			rt.ArrayItem{ key: 'data-wp-init', val: 'callbacks.initResizeObserver' },
		]),
	])
	var_content_mutated = rt.new_string('')
	for rt.is_true(rt.call_method(var_query, 'have_posts', []rt.PhpVal{})) {
		rt.call_method(var_query, 'the_post', []rt.PhpVal{})
		mut var_block_instance := rt.get_property(var_block, 'parsed_block')
		mut var_product_id := rt.new_int((rt.call_function('get_the_ID', []rt.PhpVal{})).to_i64())
		var_block_instance.array_set('blockName', 'core/null')
		mut var_available_context := rt.call_function('array_merge', [
			rt.cast_array(rt.get_property(var_block, 'context')),
			rt.create_array([
				rt.ArrayItem{ key: 'postType', val: rt.call_function('get_post_type', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'postId', val: var_product_id },
			]),
		])
		mut var_block_content := rt.call_method(create_wp_block(var_block_instance.clone(),
			var_available_context.clone()), 'render', [
			rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }]),
		])
		rt.call_function('wc_interactivity_api_load_product', [
			rt.new_string('I acknowledge that using experimental APIs means my theme or plugin will inevitably break in the next version of WooCommerce'),
			var_product_id.clone(),
		])
		mut var_product_context_directive := rt.call_function('wp_interactivity_data_wp_context', [
			rt.create_array([rt.ArrayItem{ key: 'productId', val: var_product_id },
				rt.ArrayItem{ key: 'variationId', val: rt.new_null() }]),
			rt.new_string('woocommerce/products'),
		])
		mut var_li_directives := rt.new_string(
			'\n\t\t\t\tdata-wp-interactive="woocommerce/product-collection"\n\t\t\t\t' +
			var_product_context_directive.str() + '\n\t\t\t\tdata-wp-key="product-item-' +
			var_product_id.str() + '"\n\t\t\t')
		mut var_post_classes := rt.call_function('implode', [
			rt.new_string(' '), rt.call_function('get_post_class', [
				rt.new_string('wc-block-product'),
			])])
		var_content_mutated = rt.concat(var_content_mutated, rt.call_function('strtr', [
			rt.new_string('<li class="{classes}"\n\t\t\t\t\t{li_directives}\n\t\t\t\t>\n\t\t\t\t\t{content}\n\t\t\t\t</li>'),
			rt.create_array([
				rt.ArrayItem{ key: '{classes}', val: rt.call_function('esc_attr', [
					var_post_classes.clone(),
				]) },
				rt.ArrayItem{ key: '{li_directives}', val: var_li_directives },
				rt.ArrayItem{ key: '{content}', val: var_block_content },
			]),
		]))
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<ul %1$s>%2$s</ul>'),
		var_wrapper_attributes.clone(), var_content_mutated.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) block_core_post_template_uses_featured_image(var_inner_blocks rt.PhpVal) bool {
	mut iter_1 := var_inner_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block := item_1.val
		if rt.is_true(rt.identical(rt.new_string('core/post-featured-image'), rt.get_property(var_block,
			'name')))
		{
			return true
		}
		if rt.is_true(rt.identical(rt.new_string('core/cover'), rt.get_property(var_block, 'name')))
			&& !(!rt.is_true(rt.get_property(var_block, 'attributes').array_get(rt.new_string('useFeaturedImage')))) {
			return true
		}
		if rt.is_true(rt.get_property(var_block, 'inner_blocks'))
			&& rt.is_true(rt.call_function('block_core_post_template_uses_featured_image', [rt.get_property(var_block, 'inner_blocks')])) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) add_block_type_metadata_settings(var_settings rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if !(!rt.is_true(var_metadata.array_get(rt.new_string('name'))))
		&& rt.is_true(rt.identical(rt.new_string('woocommerce/product-template'), var_metadata.array_get(rt.new_string('name')))) {
		var_settings_mutated.array_set('skip_inner_blocks', true)
	}
	return var_settings_mutated.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_producttemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-template')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_productcollection_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'block_core_post_template_uses_featured_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.block_core_post_template_uses_featured_image(dispatch_arg_0))
		}
		'add_block_type_metadata_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_block_type_metadata_settings(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductCollection_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
