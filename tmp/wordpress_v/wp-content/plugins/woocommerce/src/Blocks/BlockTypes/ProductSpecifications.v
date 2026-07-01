import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-specifications')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	mut var_product := rt.call_function('wc_get_product',
		[rt.get_property(var_block, 'context').array_get('postId')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var_product_data := rt.new_array()
	mut var_show_weight := if var_attributes.array_isset(rt.new_string('showWeight')) {
		var_attributes.array_get('showWeight')
	} else {
		rt.new_bool(true)
	}
	mut var_show_dimensions := if var_attributes.array_isset(rt.new_string('showDimensions')) {
		var_attributes.array_get('showDimensions')
	} else {
		rt.new_bool(true)
	}
	mut var_show_attributes := if var_attributes.array_isset(rt.new_string('showAttributes')) {
		var_attributes.array_get('showAttributes')
	} else {
		rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_show_weight)
		&& rt.is_true(rt.call_method(var_product, 'has_weight', []rt.PhpVal{}))))
	{
		var_product_data.array_set('weight', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Weight'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_weight', [
				rt.call_method(var_product, 'get_weight', []rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'api_field', val: 'formatted_weight' },
		]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_show_dimensions)
		&& rt.is_true(rt.call_method(var_product, 'has_dimensions', []rt.PhpVal{}))))
	{
		var_product_data.array_set('dimensions', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Dimensions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_dimensions', [
				rt.call_method(var_product, 'get_dimensions', [
					rt.new_bool(false)]),
			]) },
			rt.ArrayItem{ key: 'api_field', val: 'formatted_dimensions' },
		]))
	}
	mut var_is_interactive := rt.call_method(var_product, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variable(),
	])
	if rt.is_true(var_is_interactive) {
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('woocommerce/product-elements'),
		])
	}
	if rt.is_true(var_show_attributes) {
		{
			mut iter_1 := rt.call_method(var_product, 'get_attributes', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				mut var_values := rt.new_array()
				if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) {
					mut var_attribute_taxonomy := rt.call_method(var_attribute,
						'get_taxonomy_object', []rt.PhpVal{})
					mut var_attribute_values := rt.call_function('wc_get_product_terms', [
						rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
						rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
						rt.create_array([rt.ArrayItem{ key: 'fields', val: 'all' }]),
					])
					{
						mut iter_2 := var_attribute_values.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_attribute_value := item_2.val
							mut var_value_name := rt.call_function('esc_html', [
								rt.get_property(var_attribute_value, 'name'),
							])
							if rt.is_true(rt.get_property(var_attribute_taxonomy,
								'attribute_public'))
							{
								var_values.array_push('<a href="' +
									(rt.call_function('esc_url', [rt.call_function('get_term_link', [rt.get_property(var_attribute_value, 'term_id'), rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])])).str() +
									'" rel="tag">' + var_value_name.str() + '</a>')
							} else {
								var_values.array_push(var_value_name.dup())
							}
						}
					}
				} else {
					var_values = rt.call_method(var_attribute, 'get_options', []rt.PhpVal{})
					{
						mut iter_2 := var_values.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_value := item_2.val
							var_value = rt.call_function('make_clickable', [
								rt.call_function('esc_html', [
									var_value.dup()]),
							])
						}
					}
				}
				var_product_data.array_set('attribute_' +(rt.call_function('sanitize_title_with_dashes', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])).str(), rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('wc_attribute_label', [
						rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
					]) },
					rt.ArrayItem{ key: 'value', val: rt.call_function('wpautop', [
						rt.call_function('wptexturize', [
							rt.call_function('implode', [rt.new_string(', '),
								var_values.dup()]),
						]),
					]) },
				]))
			}
		}
	}
	if !rt.is_true(var_product_data) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: 'wp-block-table' }]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Attributes'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Value'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_product_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_attribute := item_1.val
			mut var_product_attribute_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_product_attribute_key.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_product_attribute.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(rt.is_true(var_is_interactive)
				&& var_product_attribute.array_isset(rt.new_string('api_field'))))
			{
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr',
					[var_product_attribute.array_get('api_field')]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_product_attribute.array_get('value')]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_product_attribute.array_get('value')]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications) get_block_type_style() rt.PhpVal {
	mut var_deps :=
		this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_deps.dup().is_array()))))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 'wp-block-table' }])
	}
	return rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp-block-table' }]),
		var_deps.dup(),
	])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productspecifications() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-specifications')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSpecifications) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productspecifications_php() {
	// unsupported statement: Stmt_Declare
}
