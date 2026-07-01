import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('cart-order-summary-block')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock) get_inner_block_content(var_block_name rt.PhpVal, var_content rt.PhpVal) bool {
	mut var_matches := rt.new_null()
	mut var_content_mutated := var_content
	if rt.is_true(rt.call_function('preg_match', [
		this.inner_block_regex(var_block_name.dup()),
		var_content_mutated.dup(),
		var_matches.dup(),
	]))
	{
		return (var_matches.array_get(0)).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock) inner_block_regex(var_block_name rt.PhpVal) string {
	return '/<div data-block-name="woocommerce\\/cart-order-summary-' + var_block_name.str() +
		'-block"(.+?)>(.*?)<\\/div>/si'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	mut var_regex_for_cart_order_summary_totals :=
		rt.new_string(rt.new_string('/<div data-block-name="woocommerce\\/cart-order-summary-totals-block"(.+?)>/'))
	mut var_order_summary_totals_content :=
		rt.new_string(rt.new_string('<div data-block-name="woocommerce/cart-order-summary-totals-block" class="wp-block-woocommerce-cart-order-summary-totals-block">'))
	mut var_totals_inner_blocks := rt.create_array([
		rt.ArrayItem{ key: none, val: 'subtotal' },
		rt.ArrayItem{ key: none, val: 'discount' },
		rt.ArrayItem{ key: none, val: 'fee' },
		rt.ArrayItem{ key: none, val: 'shipping' },
		rt.ArrayItem{ key: none, val: 'taxes' },
	])
	if rt.is_true(rt.call_function('preg_match', [var_regex_for_cart_order_summary_totals.dup(),
		var_content_mutated.dup()]))
	{
		return var_content_mutated.dup()
	}
	{
		mut iter_1 := var_totals_inner_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_name := item_1.val
			mut var_key := item_1.key
			mut var_inner_block_content := rt.new_bool(this.get_inner_block_content(var_block_name.dup(),
				var_content_mutated.dup()))
			if rt.is_true(var_inner_block_content) {
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(rt.identical(var_totals_inner_blocks.dup().array_count() - 1, var_key)) {
					// unsupported expression: Expr_AssignOp_Concat
					var_content_mutated = rt.call_function('preg_replace', [
						this.inner_block_regex(var_block_name.dup()),
						var_order_summary_totals_content.dup(),
						var_content_mutated.dup(),
					])
				} else {
					var_content_mutated = rt.call_function('preg_replace', [
						this.inner_block_regex(var_block_name.dup()),
						rt.new_string(''),
						var_content_mutated.dup(),
					])
				}
			}
		}
	}
	return rt.call_function('preg_replace', [rt.new_string('/\\n\\n( *?)/i'),
		rt.new_string(''), var_content_mutated.dup()])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_cartordersummaryblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('cart-order-summary-block')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractinnerblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractInnerBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_inner_block_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.get_inner_block_content(dispatch_arg_0, dispatch_arg_1))
		}
		'inner_block_regex' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.inner_block_regex(dispatch_arg_0))
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CartOrderSummaryBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_cartordersummaryblock_php() {
}
