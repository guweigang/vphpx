import rt

struct Class_WC_Admin_Duplicate_Product {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Duplicate_Product) construct()  {
	rt.call_function('add_action', [rt.new_string('admin_action_duplicate_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Duplicate_Product', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'duplicate_product_action' }])])
	rt.call_function('add_filter', [rt.new_string('post_row_actions'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Duplicate_Product', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'dupe_link' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('post_submitbox_start'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Duplicate_Product', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'dupe_button' }])])
}

fn (mut this Class_WC_Admin_Duplicate_Product) dupe_link(var_actions rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_actions_mutated := var_actions
	mut var_post_mutated := var_post
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.call_function('apply_filters', [rt.new_string('woocommerce_duplicate_product_capability'), rt.new_string('manage_woocommerce')])]))))) {
		return var_actions_mutated.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_actions_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_the_product) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_the_product := rt.call_function('wc_get_product', [var_post_mutated.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_the_product) && rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), rt.call_method(var_the_product, 'get_status', []rt.PhpVal{}))))) && rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_the_product, 'get_total_sales', []rt.PhpVal{}))))) {
		var_actions_mutated.array_set('trash', rt.call_function('sprintf', [rt.new_string('<a href="%s" class="submitdelete trash-product" aria-label="%s">%s</a>'), rt.call_function('get_delete_post_link', [rt.call_method(var_the_product, 'get_id', []rt.PhpVal{}), rt.new_string(''), rt.new_bool(false)]), rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Move &#8220;%s&#8221; to the Trash'), rt.new_string('woocommerce')]), rt.call_method(var_the_product, 'get_name', []rt.PhpVal{})])]), rt.call_function('esc_html__', [rt.new_string('Trash'), rt.new_string('woocommerce')])]))
	}
	var_actions_mutated.array_set('duplicate', '<a href="' + (rt.call_function('wp_nonce_url', [rt.call_function('admin_url', ['edit.php?post_type=product&action=duplicate_product&amp;post=' + (rt.get_property(var_post_mutated, 'ID')).str()]), 'woocommerce-duplicate-product_' + (rt.get_property(var_post_mutated, 'ID')).str()])).str() + '" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Make a duplicate from this product'), rt.new_string('woocommerce')])).str() + '" rel="permalink">' + (rt.call_function('esc_html__', [rt.new_string('Duplicate'), rt.new_string('woocommerce')])).str() + '</a>')
	return var_actions_mutated.dup()
}

fn (mut this Class_WC_Admin_Duplicate_Product) dupe_button()  {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.call_function('apply_filters', [rt.new_string('woocommerce_duplicate_product_capability'), rt.new_string('manage_woocommerce')])]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post.dup().is_object()))))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_notify_url := rt.call_function('wp_nonce_url', [rt.call_function('admin_url', ['edit.php?post_type=product&action=duplicate_product&post=' + (rt.call_function('absint', [rt.get_property(var_post, 'ID')])).str()]), 'woocommerce-duplicate-product_' + (rt.get_property(var_post, 'ID')).str()])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_notify_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy to a new draft'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Admin_Duplicate_Product) duplicate_product_action()  {
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('post')) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('No product to duplicate has been supplied!'), rt.new_string('woocommerce')])])
	}
	mut var_product_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('post')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('post')]) } else { rt.new_string('') }
	rt.call_function('check_admin_referer', ['woocommerce-duplicate-product_' + (var_product_id).str()])
	mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_product)) {
		rt.call_function('wp_die', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Product creation failed, could not find original product: %s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_product_id.dup()])])])
	}
	mut var_duplicate := this.product_duplicate(var_product.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_product_duplicate'), var_duplicate.dup(), var_product.dup()])
	rt.call_function('wc_do_deprecated_action', [rt.new_string('woocommerce_duplicate_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_method(var_duplicate, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: this.get_product_to_duplicate(var_product_id.dup()) }]), rt.new_string('3.0'), rt.new_string('Use woocommerce_product_duplicate action instead.')])
	rt.call_function('wp_redirect', [rt.call_function('admin_url', ['post.php?action=edit&post=' + (rt.call_method(var_duplicate, 'get_id', []rt.PhpVal{})).str()])])
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WC_Admin_Duplicate_Product) product_duplicate(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product_mutated, 'WC_Product')))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.new_string('product_duplicate() expects a WC_Product instance'), rt.new_string('10.5.0')])
		return create_wc_product()
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_datum := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_datum, 'key')
	}
	mut var_datum := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_datum, 'key')
	}
	mut var_datum := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_datum, 'key')
	}
	mut var_datum := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_datum, 'key')
	}
	mut var_meta_to_exclude := rt.call_function('array_filter', [rt.call_function('apply_filters', [rt.new_string('woocommerce_duplicate_product_exclude_meta'), rt.new_array(), rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.call_method(var_product_mutated, 'get_meta_data', []rt.PhpVal{})])])])
	mut var_duplicate := // unsupported expression: Expr_Clone
	rt.call_method(var_duplicate, 'set_id', [rt.new_int(0)])
	rt.call_method(var_duplicate, 'set_name', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s (Copy)'), rt.new_string('woocommerce')]), rt.call_method(var_duplicate, 'get_name', []rt.PhpVal{})])])
	rt.call_method(var_duplicate, 'set_total_sales', [rt.new_int(0)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.generate_unique_sku(var_duplicate.dup())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_method(var_duplicate, 'set_global_unique_id', [rt.new_string('')])
	}
	rt.call_method(var_duplicate, 'set_status', [Class_Automattic_WooCommerce_Enums_ProductStatus.draft()])
	rt.call_method(var_duplicate, 'set_date_created', [rt.new_null()])
	rt.call_method(var_duplicate, 'set_slug', [rt.new_string('')])
	rt.call_method(var_duplicate, 'set_rating_counts', [rt.new_int(0)])
	rt.call_method(var_duplicate, 'set_average_rating', [rt.new_int(0)])
	rt.call_method(var_duplicate, 'set_review_count', [rt.new_int(0)])
	{
		mut iter_1 := var_meta_to_exclude.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta_key := item_1.val
			rt.call_method(var_duplicate, 'delete_meta_data', [var_meta_key.dup()])
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_product_duplicate_before_save'), var_duplicate.dup(), var_product_mutated.dup()])
	rt.call_method(var_duplicate, 'save', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_duplicate_product_exclude_children'), rt.new_bool(false), var_product_mutated.dup()]))))) && rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])))) {
		{
			mut iter_1 := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_child_id := item_1.val
				mut var_child := rt.call_function('wc_get_product', [var_child_id.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_child, 'WC_Product')))))) {
					rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD), rt.new_string('product_duplicate() expects product children to be WC_Product instances'), rt.new_string('10.5.0')])
					continue
				}
				rt.call_method(var_child, 'read_meta_data', []rt.PhpVal{})
				mut var_child_duplicate := // unsupported expression: Expr_Clone
				rt.call_method(var_child_duplicate, 'set_parent_id', [rt.call_method(var_duplicate, 'get_id', []rt.PhpVal{})])
				rt.call_method(var_child_duplicate, 'set_id', [rt.new_int(0)])
				rt.call_method(var_child_duplicate, 'set_date_created', [rt.new_null()])
				this.generate_unique_slug(var_child_duplicate.dup())
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					this.generate_unique_sku(var_child_duplicate.dup())
				}
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.call_method(var_child_duplicate, 'set_global_unique_id', [rt.new_string('')])
				}
				{
					mut iter_2 := var_meta_to_exclude.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_meta_key := item_2.val
						rt.call_method(var_child_duplicate, 'delete_meta_data', [var_meta_key.dup()])
					}
				}
				rt.call_function('do_action', [rt.new_string('woocommerce_product_duplicate_before_save'), var_child_duplicate.dup(), var_child.dup()])
				rt.call_method(var_child_duplicate, 'save', []rt.PhpVal{})
			}
		}
		var_duplicate = rt.call_function('wc_get_product', [rt.call_method(var_duplicate, 'get_id', []rt.PhpVal{})])
	}
	return var_duplicate.dup()
}

fn (mut this Class_WC_Admin_Duplicate_Product) get_product_to_duplicate(var_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_id_mutated := var_id
	// unsupported statement: Stmt_Global
	var_id_mutated = rt.call_function('absint', [var_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id_mutated)))) {
		return false
	}
	mut var_post := rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.* FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID = %d')), var_id_mutated.dup()])])
	if rt.is_true(rt.new_bool(!(rt.get_property(var_post, 'post_type')).is_null() && rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_post, 'post_type'))))) {
		var_id_mutated = rt.get_property(var_post, 'post_parent')
		var_post = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.* FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE ID = %d')), var_id_mutated.dup()])])
	}
	return (var_post).to_bool()
}

fn (mut this Class_WC_Admin_Duplicate_Product) generate_unique_slug(var_product rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
	// unsupported statement: Stmt_Global
	mut var_root_slug := rt.call_function('preg_replace', [rt.new_string('/-[0-9]+$/'), rt.new_string(''), rt.call_method(var_product_mutated, 'get_slug', []rt.PhpVal{})])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT post_name FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_name LIKE %s AND post_type IN ( \'product\', \'product_variation\' )')), (var_root_slug).str() + '%'])])
	if !rt.is_true(var_results) {
		return rt.new_null()
	}
	mut var_max_suffix := rt.new_int(rt.new_int(1))
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_result := item_1.val
			mut var_suffix := rt.new_int(rt.new_int(rt.call_function('substr', [rt.get_property(var_result, 'post_name'), rt.add(rt.call_function('strrpos', [rt.get_property(var_result, 'post_name'), rt.new_string('-')]), rt.new_int(1))]).to_i64()))
			if rt.is_true(rt.greater(var_suffix, var_max_suffix)) {
				var_max_suffix = var_suffix.dup()
			}
		}
	}
	rt.call_method(var_product_mutated, 'set_slug', [(var_root_slug).str() + '-' + (rt.add(var_max_suffix, rt.new_int(1))).str()])
}

fn (mut this Class_WC_Admin_Duplicate_Product) generate_unique_sku(var_product rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
	// unsupported statement: Stmt_Global
	mut var_root_sku := rt.call_function('preg_replace', [rt.new_string('/-[0-9]+$/'), rt.new_string(''), rt.call_method(var_product_mutated, 'get_sku', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_root_sku)))) {
		return rt.new_null()
	}
	mut var_existing_skus := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(, ), ), ), ), ().str() + ])])
	if !rt.is_true(var_existing_skus) {
		rt.call_method(var_product_mutated, 'set_sku', [var_root_sku.dup()])
		return rt.new_null()
	}
	mut var_max_suffix := rt.new_int()
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_existing_sku := item_1.val
		}
	}
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

fn create_wc_admin_duplicate_product() &Class_WC_Admin_Duplicate_Product {
	mut obj := &Class_WC_Admin_Duplicate_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_product() &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Duplicate_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'dupe_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.dupe_link(dispatch_arg_0, dispatch_arg_1)
		}
		'dupe_button' {
			this.dupe_button()
			return rt.new_null()
		}
		'duplicate_product_action' {
			this.duplicate_product_action()
			return rt.new_null()
		}
		'product_duplicate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.product_duplicate(dispatch_arg_0)
		}
		'get_product_to_duplicate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_product_to_duplicate(dispatch_arg_0))
		}
		'generate_unique_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.generate_unique_slug(dispatch_arg_0)
			return rt.new_null()
		}
		'generate_unique_sku' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.generate_unique_sku(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Duplicate_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Duplicate_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_duplicate_product_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Duplicate_Product'), rt.new_bool(false)])) {
		return create_wc_admin_duplicate_product()
	}
}
