import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('mini-cart-cart-button-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock) render_experimental_iapi_markup(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_default_view_cart_text := rt.call_function('__', [
		rt.new_string('View my cart'),
		rt.new_string('woocommerce'),
	])
	mut var_view_cart_text := if rt.is_true(var_attributes.array_get(rt.new_string('cartButtonLabel'))) {
		var_attributes.array_get(rt.new_string('cartButtonLabel'))
	} else {
		var_default_view_cart_text
	}
	mut var_cart_page_id := rt.call_function('wc_get_page_id', [
		rt.new_string('cart')])
	mut var_cart_page_url := rt.call_function('get_permalink', [
		var_cart_page_id.clone()])
	mut var_classes := rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'wc-block-components-button' },
				rt.ArrayItem{ key: none, val: 'wp-element-button wc-block-mini-cart__footer-cart' },
				rt.ArrayItem{
					key: none
					val: if !(var_attributes.array_isset(rt.new_string('className')))
						|| rt.is_true(rt.identical(rt.call_function('strpos', [var_attributes.array_get(rt.new_string('className')), rt.new_string('is-style-')]), rt.new_bool(false))) {
						'is-style-outline'
					} else {
						''
					}
				},
			]),
		])])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('esc_url', [
				var_cart_page_url.clone()]) },
			rt.ArrayItem{ key: 'class', val: var_classes },
		]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_view_cart_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(iife_result_0) {
		return this.render_experimental_iapi_markup(var_attributes.clone(), var_content.clone(),
			var_block.clone())
	}
	return var_content.clone()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_minicartcartbuttonblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('mini-cart-cart-button-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_experimental_iapi_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_experimental_iapi_markup(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartCartButtonBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
