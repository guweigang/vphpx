import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('order-confirmation-downloads')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	mut var_show_downloads := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_order)
		&& rt.is_true(rt.call_method(var_order, 'has_downloadable_item', []rt.PhpVal{}))))
		&& rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{}))))
	mut var_downloads := if rt.is_true(var_order) {
		rt.call_method(var_order, 'get_downloadable_items', []rt.PhpVal{})
	} else {
		rt.new_array()
	}
	if rt.is_true(rt.new_bool(!var_permission
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_show_downloads))))))
	{
		return (this.render_content_fallback()).str()
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0, arg_1)
	}(var_attributes.dup(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border_color' },
		rt.ArrayItem{ key: none, val: 'border_radius' },
		rt.ArrayItem{ key: none, val: 'border_width' },
		rt.ArrayItem{ key: none, val: 'border_style' },
		rt.ArrayItem{ key: none, val: 'background_color' },
		rt.ArrayItem{ key: none, val: 'text_color' },
	]))
	return '\n\t\t\t<table cellspacing="0" class="wc-block-order-confirmation-downloads__table ' +
		(rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')])).str() +
		'" style="' +
		(rt.call_function('esc_attr', [var_classes_and_styles.array_get('styles')])).str() +
		'">\n\t\t\t\t<thead>\n\t\t\t\t\t<tr>\n\t\t\t\t\t\t' +
		(this.render_order_downloads_column_headers(var_order.dup())).str() + '\n\t\t\t\t\t</td>\n\t\t\t\t</thead>\n\t\t\t\t<tbody>\n\t\t\t\t\t' + (this.render_order_downloads(var_order.dup(), var_downloads.dup())).str() +
		'\n\t\t\t\t</tbody>\n\t\t\t</table>\n\t\t'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) get_inline_styles(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array) string {
	mut var_link_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_link_color_class_and_style(arg_0)
	}(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{},
		var_attributes))
	mut var_link_hover_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_link_hover_color_class_and_style(arg_0)
	}(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{},
		var_attributes))
	mut var_border_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0, arg_1)
	}(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{},
		var_attributes), rt.create_array([rt.ArrayItem{ key: none, val: 'border_color' },
		rt.ArrayItem{ key: none, val: 'border_radius' }, rt.ArrayItem{
			key: none
			val: 'border_width'
		}, rt.ArrayItem{ key: none, val: 'border_style' }]))
	return '\n\t\t\t.wc-block-order-confirmation-downloads__table a {' +
		(var_link_classes_and_styles.array_get('style')).str() + '}\n\t\t\t.wc-block-order-confirmation-downloads__table a:hover, .wc-block-order-confirmation-downloads__table a:focus {' + (var_link_hover_classes_and_styles.array_get('style')).str() + '}\n\t\t\t.wc-block-order-confirmation-downloads__table {' + (var_border_classes_and_styles.array_get('styles')).str() + '}\n\t\t\t.wc-block-order-confirmation-downloads__table th, .wc-block-order-confirmation-downloads__table td {' + (var_border_classes_and_styles.array_get('styles')).str() + '}\n\t\t'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array, var_content rt.PhpVal, var_block rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array',
		[]string{}, var_attributes), var_content.dup(), var_block.dup())
	mut var_styles := rt.new_string(this.get_inline_styles(mut var_attributes))
	rt.call_function('wp_add_inline_style', [rt.new_string('wc-blocks-style'),
		var_styles.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) render_order_downloads_column_headers() rt.PhpVal {
	mut var_columns := rt.call_function('wc_get_account_downloads_columns', []rt.PhpVal{})
	mut var_return := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_columns.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_name := item_1.val
			mut var_column_id := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_return.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) render_order_downloads(var_order rt.PhpVal, var_downloads rt.PhpVal) rt.PhpVal {
	mut var_downloads_mutated := var_downloads
	mut var_return := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_downloads_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_download := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_return.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) render_order_download_row(var_download rt.PhpVal) rt.PhpVal {
	mut var_return := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := rt.call_function('wc_get_account_downloads_columns', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_column_name := item_1.val
			mut var_column_id := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.call_function('has_action', [
				'woocommerce_account_downloads_column_' + var_column_id.str(),
			]))
			{
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				mut switch_val_1 := var_column_id
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-product'))) {
					if rt.is_true(var_download.array_get('product_url')) {
						// unsupported expression: Expr_AssignOp_Concat
					} else {
						// unsupported expression: Expr_AssignOp_Concat
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-file'))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-remaining'))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('download-expires'))) {
					if !(!rt.is_true(var_download.array_get('access_expires'))) {
						// unsupported expression: Expr_AssignOp_Concat
					} else {
						// unsupported expression: Expr_AssignOp_Concat
					}
				}
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_return.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_downloads() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('order-confirmation-downloads')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.render_content(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'get_inline_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_inline_styles(mut dispatch_arg_0))
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'render_order_downloads_column_headers' {
			return this.render_order_downloads_column_headers()
		}
		'render_order_downloads' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.render_order_downloads(dispatch_arg_0, dispatch_arg_1)
		}
		'render_order_download_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_order_download_row(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_Downloads) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_downloads_php() {
}
