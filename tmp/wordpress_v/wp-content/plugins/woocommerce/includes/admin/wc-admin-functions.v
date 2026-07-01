import rt

fn wc_get_screen_ids() rt.PhpVal {
	mut var_wc_screen_id := 'woocommerce'
	mut var_screen_ids := ['toplevel_page_' + var_wc_screen_id, var_wc_screen_id + '_page_wc-orders', var_wc_screen_id + '_page_wc-reports', var_wc_screen_id + '_page_wc-shipping', var_wc_screen_id + '_page_wc-settings', var_wc_screen_id + '_page_wc-status', var_wc_screen_id + '_page_wc-addons', rt.new_string('toplevel_page_wc-reports'), rt.new_string('product_page_product_attributes'), rt.new_string('product_page_product_exporter'), rt.new_string('product_page_product_importer'), rt.new_string('product_page_product-reviews'), rt.new_string('edit-product'), rt.new_string('product'), rt.new_string('edit-shop_coupon'), rt.new_string('shop_coupon'), rt.new_string('edit-product_cat'), rt.new_string('edit-product_tag'), rt.new_string('edit-product-brand'), rt.new_string('profile'), rt.new_string('user-edit')]
	{
		mut iter_1 := rt.call_function('wc_get_order_types', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			var_screen_ids << var_type.dup()
			var_screen_ids << 'edit-' + (var_type).str()
			var_screen_ids << wc_get_page_screen_id(var_type.dup())
		}
	}
	mut var_attributes := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if rt.is_true(var_attributes) {
		{
			mut iter_1 := var_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute := item_1.val
				var_screen_ids << 'edit-' + (rt.call_function('wc_attribute_taxonomy_name', [rt.get_property(var_attribute, 'attribute_name')])).str()
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_screen_ids'), var_screen_ids.dup()])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn wc_get_page_screen_id(var_for rt.PhpVal) rt.PhpVal {
	mut var_screen_id := rt.new_string(rt.new_string(''))
	var_for = rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), var_for.dup()])
	if rt.is_true(rt.call_function('in_array', [var_for.dup(), rt.call_function('wc_get_order_types', [rt.new_string('admin-menu')]), rt.new_bool(true)])) {
		if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()) {
			var_screen_id = rt.new_string(if rt.is_true(fn () rt.PhpVal { mut temp := Class_WC_Admin_Menus{}; return temp.can_view_woocommerce_menu_item() }()) { 'woocommerce_page_wc-orders' } else { 'admin_page_wc-orders' } + if rt.is_true(rt.identical(rt.new_string('shop_order'), var_for)) { '' } else { '--' + (var_for).str() })
		} else {
			var_screen_id = var_for.dup()
		}
	}
	return var_screen_id.dup()
}

fn wc_create_page(var_slug rt.PhpVal, option string, page_title string, page_content string, post_parent i64, post_status string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_option_value := rt.call_function('get_option', [rt.new_string(option)])
	if rt.is_true(rt.greater(var_option_value, rt.new_int(0))) {
		mut var_page_object := rt.call_function('get_post', [var_option_value.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_page_object) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_page_object, 'post_type'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_page_object, 'post_status'), rt.create_array([rt.ArrayItem{ key: none, val: 'pending' }, rt.ArrayItem{ key: none, val: 'trash' }, rt.ArrayItem{ key: none, val: 'future' }, rt.ArrayItem{ key: none, val: 'auto-draft' }]), rt.new_bool(true)]))))))) {
			return rt.get_property(var_page_object, 'ID')
		}
	}
	if page_content.len > 0 {
		mut var_shortcode := rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '<!-- wp:shortcode -->' }, rt.ArrayItem{ key: none, val: '<!-- /wp:shortcode -->' }]), rt.new_string(''), rt.new_string(page_content)])
		mut var_valid_page_found := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type=\'page\' AND post_status NOT IN ( \'pending\', \'trash\', \'future\', \'auto-draft\' ) AND post_content LIKE %s LIMIT 1;')), rt.new_string("%${var_shortcode.to_string()}%")])])
	} else {
		var_valid_page_found = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type=\'page\' AND post_status NOT IN ( \'pending\', \'trash\', \'future\', \'auto-draft\' )  AND post_name = %s LIMIT 1;')), var_slug.dup()])])
	}
	var_valid_page_found = rt.call_function('apply_filters', [rt.new_string('woocommerce_create_page_id'), var_valid_page_found.dup(), var_slug.dup(), rt.new_string(page_content)])
	if rt.is_true(var_valid_page_found) {
		if var_option.len > 0 && var_option != '0' {
			rt.call_function('update_option', [rt.new_string(option), var_valid_page_found.dup()])
		}
		return var_valid_page_found.dup()
	}
	if page_content.len > 0 {
		mut var_trashed_page_found := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type=\'page\' AND post_status = \'trash\' AND post_content LIKE %s LIMIT 1;')), rt.new_string("%${var_page_content}%")])])
	} else {
		var_trashed_page_found = rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type=\'page\' AND post_status = \'trash\' AND post_name = %s LIMIT 1;')), var_slug.dup()])])
	}
	if rt.is_true(var_trashed_page_found) {
		mut var_page_id := var_trashed_page_found.dup()
		mut var_page_data := { 'ID': var_page_id, 'post_status': rt.new_string(post_status) }
		rt.call_function('wp_update_post', [var_page_data.dup()])
	} else {
		var_page_data = { 'post_status': rt.new_string(post_status), 'post_type': rt.new_string('page'), 'post_author': rt.new_int(1), 'post_name': var_slug, 'post_title': rt.new_string(page_title), 'post_content': rt.new_string(page_content), 'post_parent': rt.new_int(post_parent), 'comment_status': rt.new_string('closed') }
		var_page_id = rt.call_function('wp_insert_post', [var_page_data.dup()])
		rt.call_function('do_action', [rt.new_string('woocommerce_page_created'), var_page_id.dup(), var_page_data.dup()])
		// unsupported statement: Stmt_Nop
	}
	if var_option.len > 0 && var_option != '0' {
		rt.call_function('update_option', [rt.new_string(option), var_page_id.dup()])
	}
	return var_page_id.dup()
}

fn woocommerce_admin_fields(var_options rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings'), rt.new_bool(false)]))))) {
		rt.include_file(@DIR + '/class-wc-admin-settings.php', '1')
	}
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.output_fields(arg_0) }(var_options.dup())
}

fn woocommerce_update_options(var_options rt.PhpVal, var_data rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings'), rt.new_bool(false)]))))) {
		rt.include_file(@DIR + '/class-wc-admin-settings.php', '1')
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.save_fields(arg_0, arg_1) }(var_options.dup(), var_data.dup())
}

fn woocommerce_settings_get_option(var_option_name rt.PhpVal, default string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Settings'), rt.new_bool(false)]))))) {
		rt.include_file(@DIR + '/class-wc-admin-settings.php', '1')
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.get_option(arg_0, arg_1) }(var_option_name.dup(), rt.new_string(default))
}

fn wc_maybe_adjust_line_item_product_stock(var_item rt.PhpVal, item_quantity i64) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_prevent_adjust_line_item_product_stock'), rt.new_bool(false), var_item.dup(), rt.new_int(item_quantity)])) {
		return rt.new_bool(false)
	}
	mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'managing_stock', []rt.PhpVal{}))))))) {
		return rt.new_bool(false)
	}
	item_quantity = (rt.call_function('wc_stock_amount', [if item_quantity >= 0 { rt.new_int(item_quantity) } else { rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}) }])).to_i64()
	mut var_already_reduced_stock := rt.call_function('wc_stock_amount', [rt.call_method(var_item, 'get_meta', [rt.new_string('_reduced_stock'), rt.new_bool(true)])])
	mut var_restock_refunded_items := rt.call_function('wc_stock_amount', [rt.call_method(var_item, 'get_meta', [rt.new_string('_restock_refunded_items'), rt.new_bool(true)])])
	mut var_diff := rt.sub(rt.sub(rt.new_int(item_quantity), var_restock_refunded_items), var_already_reduced_stock)
	if 0 == item_quantity {
		var_diff = rt.mul(var_already_reduced_stock, // unsupported expression: Expr_UnaryMinus)
	}
	if rt.is_true(rt.less(var_diff, rt.new_int(0))) {
		mut var_new_stock := rt.call_function('wc_update_product_stock', [var_product.dup(), rt.mul(var_diff, // unsupported expression: Expr_UnaryMinus), rt.new_string('increase')])
	} else if rt.is_true(rt.greater(var_diff, rt.new_int(0))) {
		var_new_stock = rt.call_function('wc_update_product_stock', [var_product.dup(), var_diff.dup(), rt.new_string('decrease')])
	} else {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_new_stock.dup()])) {
		return var_new_stock.dup()
	}
	rt.call_method(var_item, 'update_meta_data', [rt.new_string('_reduced_stock'), rt.sub(rt.new_int(item_quantity), var_restock_refunded_items)])
	rt.call_method(var_item, 'save', []rt.PhpVal{})
	if item_quantity > 0 {
		mut var_order_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order'))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_item, 'get_order_id', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order_data_store, 'get_stock_reduced', [rt.call_method(var_item, 'get_order_id', []rt.PhpVal{})]))))))) {
			rt.call_method(var_order_data_store, 'set_stock_reduced', [rt.call_method(var_item, 'get_order_id', []rt.PhpVal{}), rt.new_bool(true)])
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'from', val: rt.add(var_new_stock, var_diff) }, rt.ArrayItem{ key: 'to', val: var_new_stock }])
}

fn wc_save_order_items(var_order_id rt.PhpVal, var_items rt.PhpVal) {
	rt.call_function('do_action', [rt.new_string('woocommerce_before_save_order_items'), var_order_id.dup(), var_items.dup()])
	mut var_qty_change_order_notes := []rt.PhpVal{}
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if var_items.array_isset(rt.new_string('order_item_id')) {
		mut var_data_keys := { 'line_tax': []rt.PhpVal{}, 'line_subtotal_tax': []rt.PhpVal{}, 'order_item_name': rt.new_null(), 'order_item_qty': rt.new_null(), 'order_item_tax_class': rt.new_null(), 'line_total': rt.new_null(), 'line_subtotal': rt.new_null() }
		{
			mut iter_1 := var_items.array_get('order_item_id').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item_id := item_1.val
				mut var_item := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Order_Factory{}; return temp.get_order_item(arg_0) }(rt.call_function('absint', [var_item_id.dup()]))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
					continue
				}
				mut var_item_data := []rt.PhpVal{}
				for var_key, var_default in var_data_keys {
					var_item_data.array_set(key, if var_items.array_get(key).array_isset(var_item_id) { rt.call_function('wc_check_invalid_utf8', [rt.call_function('wp_unslash', [var_items.array_get(key).array_get(var_item_id)])]) } else { var_default })
				}
				if rt.is_true(rt.identical(rt.new_string('0'), var_item_data.array_get('order_item_qty'))) {
					mut var_changed_stock := wc_maybe_adjust_line_item_product_stock(var_item.dup(), 0)
					if rt.is_true(rt.new_bool(rt.is_true(var_changed_stock) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_changed_stock.dup()]))))))) {
						var_qty_change_order_notes << (rt.call_method(var_item, 'get_name', []rt.PhpVal{})).str() + ' &ndash; ' + (var_changed_stock.array_get('from')).str() + '&rarr;' + (var_changed_stock.array_get('to')).str()
					}
					rt.call_method(var_item, 'delete', []rt.PhpVal{})
					continue
				}
				rt.call_method(var_item, 'set_props', [rt.create_array([rt.ArrayItem{ key: 'name', val: var_item_data.array_get('order_item_name') }, rt.ArrayItem{ key: 'quantity', val: var_item_data.array_get('order_item_qty') }, rt.ArrayItem{ key: 'tax_class', val: var_item_data.array_get('order_item_tax_class') }, rt.ArrayItem{ key: 'total', val: var_item_data.array_get('line_total') }, rt.ArrayItem{ key: 'subtotal', val: var_item_data.array_get('line_subtotal') }, rt.ArrayItem{ key: 'taxes', val: rt.create_array([rt.ArrayItem{ key: 'total', val: var_item_data.array_get('line_tax') }, rt.ArrayItem{ key: 'subtotal', val: var_item_data.array_get('line_subtotal_tax') }]) }])])
				if rt.is_true(rt.identical(rt.new_string('fee'), rt.call_method(var_item, 'get_type', []rt.PhpVal{}))) {
					rt.call_method(var_item, 'set_amount', [var_item_data.array_get('line_total')])
				}
				if var_items.array_get('meta_key').array_isset(var_item_id) && var_items.array_get('meta_value').array_isset(var_item_id) {
					{
						mut iter_2 := var_items.array_get('meta_key').array_get(var_item_id).iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_meta_key := item_2.val
							mut var_meta_id := item_2.key
							var_meta_key = rt.call_function('substr', [rt.call_function('wp_unslash', [var_meta_key.dup()]), rt.new_int(0), rt.new_int(255)])
							mut var_meta_value := if var_items.array_get('meta_value').array_get(var_item_id).array_isset(var_meta_id) { rt.call_function('wp_unslash', [.array_get().array_get(var_item_id).array_get(var_meta_id)]) } else { rt.new_string('') }
							if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_meta_key)) && rt.is_true(rt.identical(rt.new_string(''), var_meta_value)))) {
								if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_meta_id.dup(), rt.new_string('new-')]))))) {
									rt.call_method(var_item, 'delete_meta_data_by_mid', [var_meta_id.dup()])
								}
							} else if rt.is_true(rt.call_function('strstr', [var_meta_id.dup(), rt.new_string('new-')])) {
								rt.call_method(var_item, 'add_meta_data', [var_meta_key.dup(), var_meta_value.dup(), rt.new_bool(false)])
							} else {
								rt.call_method(var_item, 'update_meta_data', [var_meta_key.dup(), var_meta_value.dup(), var_meta_id.dup()])
							}
						}
					}
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_before_save_order_item'), var_item.dup()])
				rt.call_method(var_item, 'save', []rt.PhpVal{})
				if rt.is_true(rt.call_function('in_array', [, , ])) {
					
				}
			}
		}
	}
	if var_items.array_isset(rt.new_string('shipping_method_id')) {
		
	}
	
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Menus {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Order_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_menus() &Class_WC_Admin_Menus {
	mut obj := &Class_WC_Admin_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings() &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_factory() &Class_WC_Order_Factory {
	mut obj := &Class_WC_Order_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_wc_admin_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
