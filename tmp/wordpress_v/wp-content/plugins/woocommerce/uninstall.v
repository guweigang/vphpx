import rt

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_uninstall_php() {
	mut var_wpdb := rt.new_null()
	mut var_wp_version := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_UNINSTALL_PLUGIN')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	mut var_wc_uninstalling_plugin := true
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_scheduled_sales')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cancel_unpaid_orders')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_sessions')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_personal_data')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_logs')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_geoip_updater')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_tracker_send_event')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('woocommerce_cleanup_rate_limits')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('wc_admin_daily')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('generate_category_lookup_table')])
	rt.call_function('wp_clear_scheduled_hook', [rt.new_string('wc_admin_unsnooze_admin_notes')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [Class_ActionScheduler.class()])) && rt.is_true(fn () rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.is_initialized() }()))) && rt.is_true(rt.call_function('function_exists', [rt.new_string('as_unschedule_all_actions')])))) {
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_scheduled_sales')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_cancel_unpaid_orders')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_cleanup_sessions')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_cleanup_personal_data')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_cleanup_logs')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_geoip_updater')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_tracker_send_event')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('woocommerce_cleanup_rate_limits')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('wc_admin_daily')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('generate_category_lookup_table')])
		rt.call_function('as_unschedule_all_actions', [rt.new_string('wc_admin_unsnooze_admin_notes')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WC_REMOVE_ALL_DATA')])) && rt.is_true(rt.identical(rt.new_bool(true), rt.get_constant('WC_REMOVE_ALL_DATA'))))) {
		rt.include_file(@DIR + '/includes/class-wc-install.php', '4')
		mut var_index_exists := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_type\';'))])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' DROP INDEX woo_idx_comment_type;'))])
		}
		mut var_date_type_index_exists := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_date_type\';'))])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' DROP INDEX woo_idx_comment_date_type;'))])
		}
		mut var_comment_approved_type_index_exists := rt.call_method(var_wpdb, 'get_row', [rt.concat(rt.concat(rt.new_string('SHOW INDEX FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE key_name = \'woo_idx_comment_approved_type\';'))])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' DROP INDEX woo_idx_comment_approved_type;'))])
		}
		fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.remove_roles() }()
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_shop_page_id')])])
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_cart_page_id')])])
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_checkout_page_id')])])
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_myaccount_page_id')])])
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_edit_address_page_id')])])
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_view_order_page_id')])])
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_change_password_page_id')])])
		rt.call_function('wp_trash_post', [rt.call_function('get_option', [rt.new_string('woocommerce_logout_page_id')])])
		if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SHOW TABLES LIKE \''), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies\';'))])) {
			mut var_wc_attributes := rt.call_function('array_filter', [rt.cast_array(rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.new_string('SELECT attribute_name FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_attribute_taxonomies;'))]))])
		} else {
			var_wc_attributes = rt.new_array()
		}
		fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.drop_tables() }()
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name LIKE \'woocommerce\\_%\';'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name LIKE \'widget\\_woocommerce\\_%\';'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE meta_key LIKE \'woocommerce\\_%\';'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type IN ( \'product\', \'product_variation\', \'shop_coupon\', \'shop_order\', \'shop_order_refund\' );'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE meta FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' meta LEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts ON posts.ID = meta.post_id WHERE posts.ID IS NULL;'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_type IN ( \'order_note\' );'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE meta FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' meta LEFT JOIN ')), rt.get_property(var_wpdb, 'comments')), rt.new_string(' comments ON comments.comment_ID = meta.comment_id WHERE comments.comment_ID IS NULL;'))])
		if rt.is_true(rt.call_function('version_compare', [var_wp_version.dup(), rt.new_string('4.2'), rt.new_string('>=')])) {
			{
				mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }, rt.ArrayItem{ key: none, val: 'product_tag' }, rt.ArrayItem{ key: none, val: 'product_shipping_class' }, rt.ArrayItem{ key: none, val: 'product_type' }]).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var__taxonomy := item_1.val
					rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'term_taxonomy'), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var__taxonomy }])])
				}
			}
			{
				mut iter_1 := var_wc_attributes.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var__taxonomy := item_1.val
					rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'term_taxonomy'), rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'pa_' + (var__taxonomy).str() }])])
				}
			}
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE tr FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr LEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' posts ON posts.ID = tr.object_id WHERE posts.ID IS NULL;'))])
			rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE t FROM '), rt.get_property(var_wpdb, 'terms')), rt.new_string(' t LEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON t.term_id = tt.term_id WHERE tt.term_id IS NULL;'))])
			if !(!rt.is_true(rt.get_property(var_wpdb, 'termmeta'))) {
				rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE tm FROM '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' tm LEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON tm.term_id = tt.term_id WHERE tt.term_id IS NULL;'))])
			}
		}
		rt.call_function('wp_cache_flush', []rt.PhpVal{})
	}
	var_wc_uninstalling_plugin = false
}
