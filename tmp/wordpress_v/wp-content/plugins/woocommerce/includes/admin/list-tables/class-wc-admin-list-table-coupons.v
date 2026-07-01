import rt

struct Class_WC_Admin_List_Table_Coupons {
	rt.PhpObjectBase
pub mut:
		list_table_type rt.PhpVal = rt.new_string('shop_coupon')
}

fn (mut this Class_WC_Admin_List_Table_Coupons) construct()  {
	this.Class_WC_Admin_List_Table.construct()
	rt.call_function('add_filter', [rt.new_string('disable_months_dropdown'), rt.new_string('__return_true')])
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_blank_state()  {
	print('<div class="woocommerce-BlankState">')
	print('<h2 class="woocommerce-BlankState-message">' + (rt.call_function('esc_html__', [rt.new_string('Coupons are a great way to offer discounts and rewards to your customers. They will appear here once created.'), rt.new_string('woocommerce')])).str() + '</h2>')
	print('<a class="woocommerce-BlankState-cta button-primary button" href="' + (rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('post-new.php?post_type=shop_coupon')])])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Create your first coupon'), rt.new_string('woocommerce')])).str() + '</a>')
	print('<a class="woocommerce-BlankState-cta button" target="_blank" href="https://woocommerce.com/document/coupon-management/?utm_source=blankslate&utm_medium=product&utm_content=couponsdoc&utm_campaign=woocommerceplugin">' + (rt.call_function('esc_html__', [rt.new_string('Learn more about coupons'), rt.new_string('woocommerce')])).str() + '</a>')
	print('</div>')
}

fn (mut this Class_WC_Admin_List_Table_Coupons) get_primary_column() string {
	return 'coupon_code'
}

fn (mut this Class_WC_Admin_List_Table_Coupons) get_row_actions(var_actions rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	var_actions.array_unset(rt.new_string('inline hide-if-no-js'))
	return var_actions.dup()
}

fn (mut this Class_WC_Admin_List_Table_Coupons) define_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_show_columns := map[string]rt.PhpVal{}
	var_show_columns['cb'] = var_columns.array_get('cb')
	var_show_columns['coupon_code'] = rt.call_function('__', [rt.new_string('Code'), rt.new_string('woocommerce')])
	var_show_columns['type'] = rt.call_function('__', [rt.new_string('Coupon type'), rt.new_string('woocommerce')])
	var_show_columns['amount'] = rt.call_function('__', [rt.new_string('Coupon amount'), rt.new_string('woocommerce')])
	var_show_columns['description'] = rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')])
	var_show_columns['products'] = rt.call_function('__', [rt.new_string('Product IDs'), rt.new_string('woocommerce')])
	var_show_columns['usage'] = rt.call_function('__', [rt.new_string('Usage / Limit'), rt.new_string('woocommerce')])
	var_show_columns['expiry_date'] = rt.call_function('__', [rt.new_string('Expiry date'), rt.new_string('woocommerce')])
	return var_show_columns.dup()
}

fn (mut this Class_WC_Admin_List_Table_Coupons) prepare_row_data(var_post_id rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.dispatch_set_prop('object', create_wc_coupon(var_post_id.dup()))
		mut var_the_coupon := rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object')
	}
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_coupon_code_column()  {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_edit_link := rt.call_function('get_edit_post_link', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_id', []rt.PhpVal{})])
	mut var_title := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_code', []rt.PhpVal{})
	print('<strong><a class="row-title" href="' + (rt.call_function('esc_url', [var_edit_link.dup()])).str() + '">' + (rt.call_function('esc_html', [var_title.dup()])).str() + '</a>')
	rt.call_function('_post_states', [var_post.dup()])
	print('</strong>')
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_type_column()  {
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('wc_get_coupon_type', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_discount_type', []rt.PhpVal{})])]))
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_amount_column()  {
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('wc_format_localized_price', [rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_amount', []rt.PhpVal{})])]))
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_products_column()  {
	mut var_product_ids := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_product_ids', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_product_ids.dup().is_array())) && var_product_ids.dup().array_count() > 0)) {
		rt.echo_val(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string(', '), var_product_ids.dup()])]))
	} else {
		print('&ndash;')
	}
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_usage_limit_column()  {
	mut var_usage_limit := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_usage_limit', []rt.PhpVal{})
	if rt.is_true(var_usage_limit) {
		rt.echo_val(rt.call_function('esc_html', [var_usage_limit.dup()]))
	} else {
		print('&ndash;')
	}
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_usage_column()  {
	mut var_usage_count := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_usage_count', []rt.PhpVal{})
	mut var_usage_limit := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_usage_limit', []rt.PhpVal{})
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('%1$s / %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_usage_count.dup()]), if rt.is_true(var_usage_limit) { rt.call_function('esc_html', [var_usage_limit.dup()]) } else { rt.new_string('&infin;') }])
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_expiry_date_column()  {
	mut var_expiry_date := rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_date_expires', []rt.PhpVal{})
	if rt.is_true(var_expiry_date) {
		rt.echo_val(rt.call_function('esc_html', [rt.call_method(var_expiry_date, 'date_i18n', [rt.new_string('F j, Y')])]))
	} else {
		print('&ndash;')
	}
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_description_column()  {
	rt.echo_val(rt.call_function('wp_kses_post', [if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_description', []rt.PhpVal{})) { rt.call_method(rt.get_property(rt.new_object('WC_Admin_List_Table_Coupons', ['WC_Admin_List_Table'], &this), 'object'), 'get_description', []rt.PhpVal{}) } else { rt.new_string('&ndash;') }]))
}

fn (mut this Class_WC_Admin_List_Table_Coupons) render_filters()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Show all types'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_types := rt.call_function('wc_get_coupon_types', []rt.PhpVal{})
	{
		mut iter_1 := var_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			mut var_name := item_1.key
			print('<option value="' + (rt.call_function('esc_attr', [var_name.dup()])).str() + '"')
			if rt.get_superglobal('_GET').array_isset(rt.new_string('coupon_type')) {
				rt.call_function('selected', [var_name.dup(), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('coupon_type')])])])
				// unsupported statement: Stmt_Nop
			}
			print('>' + (rt.call_function('esc_html', [var_type.dup()])).str() + '</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_List_Table_Coupons) query_filters(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('coupon_type'))) {
		var_query_vars_mutated.array_set('meta_key', 'discount_type')
		var_query_vars_mutated.array_set('meta_value', rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('coupon_type')])]))
		// unsupported statement: Stmt_Nop
	}
	return var_query_vars_mutated.dup()
}

struct Class_WC_Admin_List_Table {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

fn create_wc_admin_list_table_coupons() &Class_WC_Admin_List_Table_Coupons {
	mut obj := &Class_WC_Admin_List_Table_Coupons{
		PhpObjectBase: rt.PhpObjectBase{}
		list_table_type: rt.new_string('shop_coupon')
	}
	obj.construct()
	return obj
}

fn create_wc_admin_list_table() &Class_WC_Admin_List_Table {
	mut obj := &Class_WC_Admin_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon() &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_List_Table_Coupons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'render_blank_state' {
			this.render_blank_state()
			return rt.new_null()
		}
		'get_primary_column' {
			return rt.new_string(this.get_primary_column())
		}
		'get_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_row_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'define_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.define_columns(dispatch_arg_0)
		}
		'prepare_row_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.prepare_row_data(dispatch_arg_0)
			return rt.new_null()
		}
		'render_coupon_code_column' {
			this.render_coupon_code_column()
			return rt.new_null()
		}
		'render_type_column' {
			this.render_type_column()
			return rt.new_null()
		}
		'render_amount_column' {
			this.render_amount_column()
			return rt.new_null()
		}
		'render_products_column' {
			this.render_products_column()
			return rt.new_null()
		}
		'render_usage_limit_column' {
			this.render_usage_limit_column()
			return rt.new_null()
		}
		'render_usage_column' {
			this.render_usage_column()
			return rt.new_null()
		}
		'render_expiry_date_column' {
			this.render_expiry_date_column()
			return rt.new_null()
		}
		'render_description_column' {
			this.render_description_column()
			return rt.new_null()
		}
		'render_filters' {
			this.render_filters()
			return rt.new_null()
		}
		'query_filters' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query_filters(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_List_Table_Coupons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'list_table_type' { return this.list_table_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_List_Table_Coupons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'list_table_type' { this.list_table_type = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Admin_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_list_tables_class_wc_admin_list_table_coupons_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_List_Table_Coupons'), rt.new_bool(false)])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_List_Table'), rt.new_bool(false)]))))) {
		rt.include_file(@DIR + '/abstract-class-wc-admin-list-table.php', '2')
	}
}
