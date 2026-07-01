import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('order-confirmation-downloads-wrapper')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper) store_has_downloadable_products() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('get_option', [rt.new_string('woocommerce_product_lookup_table_is_generating')])) {
		mut var_has_downloadable_products := rt.call_function('wp_cache_get', [rt.new_string('woocommerce_has_downloadable_products'), rt.new_string('woocommerce')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_has_downloadable_products)) {
			var_has_downloadable_products = // unsupported expression: Expr_Cast_Bool
			var_has_downloadable_products = rt.new_string(if rt.is_true(var_has_downloadable_products) { rt.new_string('yes') } else { rt.new_string('no') })
			rt.call_function('wp_cache_set', [rt.new_string('woocommerce_has_downloadable_products'), var_has_downloadable_products.dup(), rt.new_string('woocommerce'), rt.get_constant('HOUR_IN_SECONDS')])
		}
		var_has_downloadable_products = rt.identical(rt.new_string('yes'), var_has_downloadable_products)
	} else {
		var_has_downloadable_products = // unsupported expression: Expr_Cast_Bool
	}
	return var_has_downloadable_products.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array', []string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper', ['Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('storeHasDownloadableProducts'), this.store_has_downloadable_products()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper) render_content(var_order rt.PhpVal, permission bool, var_attributes rt.PhpVal, content string) string {
	mut var_show_downloads := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.call_method(var_order, 'has_downloadable_item', []rt.PhpVal{})))) && rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{}))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_show_downloads)))) || !(var_permission))) {
		return ''
	}
	return content
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_downloadswrapper() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('order-confirmation-downloads-wrapper')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_orderconfirmation_abstractorderconfirmationblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_AbstractOrderConfirmationBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'store_has_downloadable_products' {
			return this.store_has_downloadable_products()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'render_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.render_content(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_OrderConfirmation_DownloadsWrapper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_orderconfirmation_downloadswrapper_php() {
}
