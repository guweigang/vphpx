import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('mini-cart-title-items-counter-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}
		return temp.is_enabled(arg_0)
	}(rt.new_string('experimental-iapi-mini-cart')))
	{
		return this.render_experimental_iapi_title_label_block()
	}
	return var_content.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock) render_experimental_iapi_title_label_block() rt.PhpVal {
	mut var_cart := this.get_cart_instance()
	mut var_cart_item_count := if rt.is_true(var_cart) {
		rt.call_method(var_cart, 'get_cart_contents_count', []rt.PhpVal{})
	} else {
		rt.new_int(0)
	}
	mut var_cart_item_text := rt.call_function('__', [rt.new_string('(items: %d)'),
		rt.new_string('woocommerce')])
	rt.call_function('wp_interactivity_config', [this.get_full_block_name(),
		rt.create_array([
			rt.ArrayItem{ key: 'itemsInCartTextTemplate', val: var_cart_item_text },
		])])
	rt.call_function('wp_interactivity_state', [this.get_full_block_name(),
		rt.create_array([
			rt.ArrayItem{ key: 'itemsInCartText', val: rt.call_function('sprintf', [
				var_cart_item_text.dup(),
				var_cart_item_count.dup(),
			]) },
		])])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'data-wp-text', val: 'state.itemsInCartText' },
			rt.ArrayItem{
				key: 'data-wp-interactive'
				val: 'woocommerce/mini-cart-title-items-counter-block'
			},
		]),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_wrapper_attributes)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock) get_cart_instance() rt.PhpVal {
	mut var_cart := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')
	if rt.is_true(rt.new_bool(rt.is_true(var_cart)
		&& rt.is_true(rt.new_bool(rt.instance_of(var_cart, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Cart')))))
	{
		return var_cart.dup()
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_minicarttitleitemscounterblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('mini-cart-title-items-counter-block')
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_experimental_iapi_title_label_block' {
			return this.render_experimental_iapi_title_label_block()
		}
		'get_cart_instance' {
			return this.get_cart_instance()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_MiniCartTitleItemsCounterBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_minicarttitleitemscounterblock_php() {
}
