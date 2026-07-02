import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('filled-mini-cart-contents-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('experimental-iapi-mini-cart'))
	if rt.is_true(iife_result_0) {
		return this.render_experimental_filled_mini_cart_contents(var_attributes.clone(),
			var_content.clone(), var_block.clone())
	}
	return var_content.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock) render_experimental_filled_mini_cart_contents(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_consent :=
		rt.new_string('I acknowledge that using private APIs means my theme or plugin will inevitably break in the next version of WooCommerce')
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{}
	mut iife_result_1 := iife_temp_1.get_cart_error_notices(var_consent.clone())
	mut var_notices := iife_result_1
	mut var_context := rt.call_function('wp_json_encode', [
		rt.create_array([rt.ArrayItem{ key: 'notices', val: var_notices }]),
		rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_NUMERIC_CHECK'),
			rt.get_constant('JSON_HEX_TAG')), rt.get_constant('JSON_HEX_APOS')),
			rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP')),
	])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'data-wp-interactive', val: 'woocommerce/mini-cart' },
			rt.ArrayItem{ key: 'data-wp-context', val: 'woocommerce/store-notices::' +
				var_context.str() },
			rt.ArrayItem{ key: 'data-wp-bind--hidden', val: 'state.cartIsEmpty' },
		]),
	])
	mut var_dismiss_aria_label := rt.call_function('__', [
		rt.new_string('Dismiss this notice'),
		rt.new_string('woocommerce'),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_dismiss_aria_label.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_content)
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_filledminicartcontentsblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('filled-mini-cart-contents-block')
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

fn create_automattic_woocommerce_blocks_utils_blockssharedstate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_experimental_filled_mini_cart_contents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_experimental_filled_mini_cart_contents(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FilledMiniCartContentsBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksSharedState) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
