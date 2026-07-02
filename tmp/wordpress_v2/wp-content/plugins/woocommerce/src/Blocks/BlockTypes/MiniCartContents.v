import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('mini-cart-contents')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) get_block_type_editor_script(var_key rt.PhpVal) rt.PhpVal {
	mut var_script := rt.create_array([
		rt.ArrayItem{ key: 'handle', val: 'wc-' + (this.block_name).str() + '-block' },
		rt.ArrayItem{ key: 'path', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_api'), 'get_block_asset_build_path', [
			this.block_name,
		]) },
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks' },
		]) },
	])
	return if rt.is_true(var_key) { var_script.array_get(var_key) } else { var_script }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) render_experimental_iapi_mini_cart_contents(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/mini-cart-contents' },
			rt.ArrayItem{
				key: 'data-wp-style--background-color'
				val: 'woocommerce/mini-cart::state.contentsBackgroundColor'
			},
		]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_content)
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})) {
		return ''
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(iife_result_0) {
		return (this.render_experimental_iapi_mini_cart_contents(var_attributes.clone(),
			var_content.clone(), var_block.clone())).str()
	}
	return var_content.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes), var_content.clone(), var_block.clone())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_1 := iife_temp_1.get_text_color_class_and_style(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	mut var_text_color := iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_2 := iife_temp_2.get_background_color_class_and_style(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	mut var_bg_color := iife_result_2
	mut var_styles := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'selector', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: '.wc-block-mini-cart__footer .wc-block-mini-cart__footer-actions .wc-block-mini-cart__footer-checkout'
				},
				rt.ArrayItem{
					key: none
					val: '.wc-block-mini-cart__footer .wc-block-mini-cart__footer-actions .wc-block-mini-cart__footer-checkout:hover'
				},
				rt.ArrayItem{
					key: none
					val: '.wc-block-mini-cart__footer .wc-block-mini-cart__footer-actions .wc-block-mini-cart__footer-checkout:focus'
				},
				rt.ArrayItem{
					key: none
					val: '.wc-block-mini-cart__footer .wc-block-mini-cart__footer-actions .wc-block-mini-cart__footer-cart.wc-block-components-button:hover'
				},
				rt.ArrayItem{
					key: none
					val: '.wc-block-mini-cart__footer .wc-block-mini-cart__footer-actions .wc-block-mini-cart__footer-cart.wc-block-components-button:focus'
				},
				rt.ArrayItem{ key: none, val: '.wc-block-mini-cart__shopping-button a:hover' },
				rt.ArrayItem{ key: none, val: '.wc-block-mini-cart__shopping-button a:focus' },
			]) },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'property', val: 'color' },
					rt.ArrayItem{
						key: 'value'
						val: if rt.is_true(var_bg_color) {
							var_bg_color.array_get(rt.new_string('value'))
						} else {
							rt.new_bool(false)
						}
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'property', val: 'border-color' },
					rt.ArrayItem{
						key: 'value'
						val: if rt.is_true(var_text_color) {
							var_text_color.array_get(rt.new_string('value'))
						} else {
							rt.new_bool(false)
						}
					},
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'property', val: 'background-color' },
					rt.ArrayItem{
						key: 'value'
						val: if rt.is_true(var_text_color) {
							var_text_color.array_get(rt.new_string('value'))
						} else {
							rt.new_bool(false)
						}
					},
				]) },
			]) },
		]) },
	])
	mut var_parsed_style := rt.call_function('sprintf', [
		rt.new_string(':root { --drawer-width: %s; --neg-drawer-width: calc(var(--drawer-width) * -1); }'),
		rt.call_function('esc_html', [var_attributes.array_get(rt.new_string('width'))]),
	])
	mut iter_1 := var_styles.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_style := item_1.val
		mut var_selector := if var_style.array_get(rt.new_string('selector')).is_array() { rt.call_function('implode', [
				rt.new_string(','),
				var_style.array_get(rt.new_string('selector')),
			]) } else { var_style.array_get(rt.new_string('selector')) }
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		mut var_properties := rt.call_function('array_filter', [
			var_style.array_get(rt.new_string('properties')),
			rt.new_closure(closure_4_fn),
		])
		if !(!rt.is_true(var_properties)) {
			var_parsed_style = rt.concat(var_parsed_style, rt.new_string(var_selector.str() + '{'))
			mut iter_2 := var_properties.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_property := item_2.val
				var_parsed_style = rt.concat(var_parsed_style, rt.call_function('sprintf', [
					rt.new_string('%1$s:%2$s;'),
					var_property.array_get(rt.new_string('property')),
					var_property.array_get(rt.new_string('value')),
				]))
			}
			var_parsed_style = rt.concat(var_parsed_style, rt.new_string('}'))
		}
	}
	rt.call_function('wp_add_inline_style', [rt.new_string('wc-blocks-style'),
		var_parsed_style.clone()])
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents.get_mini_cart_block_types() rt.PhpVal {
	mut var_block_types := rt.new_array()
	var_block_types.array_push('MiniCartContents')
	var_block_types.array_push('EmptyMiniCartContentsBlock')
	var_block_types.array_push('FilledMiniCartContentsBlock')
	var_block_types.array_push('MiniCartFooterBlock')
	var_block_types.array_push('MiniCartItemsBlock')
	var_block_types.array_push('MiniCartProductsTableBlock')
	var_block_types.array_push('MiniCartShoppingButtonBlock')
	var_block_types.array_push('MiniCartCartButtonBlock')
	var_block_types.array_push('MiniCartCheckoutButtonBlock')
	var_block_types.array_push('MiniCartTitleBlock')
	var_block_types.array_push('MiniCartTitleItemsCounterBlock')
	var_block_types.array_push('MiniCartTitleLabelBlock')
	return var_block_types.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_minicartcontents(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('mini-cart-contents')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_editor_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_editor_script(dispatch_arg_0)
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		'render_experimental_iapi_mini_cart_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_experimental_iapi_mini_cart_contents(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_mini_cart_block_types' {
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents.get_mini_cart_block_types()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartContents) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
