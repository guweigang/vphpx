import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('mini-cart-shopping-button-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}
		return temp.is_enabled(arg_0)
	}(rt.new_string('experimental-iapi-mini-cart')))
	{
		return this.render_experimental_iapi_markup(var_attributes.dup(), var_content.dup(),
			var_block.dup())
	}
	return var_content.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock) render_experimental_iapi_markup(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_shop_url := rt.call_function('wc_get_page_permalink', [
		rt.new_string('shop')])
	mut var_default_start_shopping_label := rt.call_function('__', [
		rt.new_string('Start shopping'),
		rt.new_string('woocommerce'),
	])
	mut var_start_shopping_label := if rt.is_true(var_attributes.array_get('startShoppingButtonLabel')) {
		var_attributes.array_get('startShoppingButtonLabel')
	} else {
		var_default_start_shopping_label
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{
				key: 'class'
				val: 'wc-block-components-button wp-element-button wc-block-mini-cart__shopping-button'
			},
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_shop_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_start_shopping_label.dup()]))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_minicartshoppingbuttonblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('mini-cart-shopping-button-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_experimental_iapi_markup' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_experimental_iapi_markup(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartShoppingButtonBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_minicartshoppingbuttonblock_php() {
}
