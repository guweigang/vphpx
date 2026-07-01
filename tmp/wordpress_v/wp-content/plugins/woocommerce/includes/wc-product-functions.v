import rt

fn wc_get_products(var_args rt.PhpVal) rt.PhpVal {
	mut var_map_legacy := { 'numberposts': 'limit', 'post_status': 'status', 'post_parent': 'parent', 'posts_per_page': 'limit', 'paged': 'page' }
	for var_from, var_to in var_map_legacy {
		if var_args.array_isset(rt.new_string(from)) {
			var_args.array_set(to, var_args.array_get(from))
		}
	}
	mut var_query := create_wc_product_query(var_args.dup())
	return var_query.get_products()
}

fn wc_get_product(the_product bool, var_deprecated rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_after_register_taxonomy')]))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_after_register_post_type')]))))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s should not be called before the %2$s, %3$s and %4$s actions have finished.'), rt.new_string('woocommerce')]), rt.new_string('wc_get_product'), rt.new_string('woocommerce_init'), rt.new_string('woocommerce_after_register_taxonomy'), rt.new_string('woocommerce_after_register_post_type')]), rt.new_string('3.9')])
		return false
	}
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('wc_deprecated_argument', [rt.new_string('args'), rt.new_string('3.0'), rt.new_string('Passing args to wc_get_product is deprecated. If you need to force a type, construct the product class directly.')])
	}
	return (rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'product_factory'), 'get_product', [rt.new_bool(the_product), var_deprecated.dup()])).to_bool()
}

fn wc_get_product_object(var_product_type rt.PhpVal, product_id i64) rt.PhpVal {
	mut var_classname := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Product_Factory{}; return temp.get_product_classname(arg_0, arg_1) }(rt.new_int(product_id), var_product_type.dup())
	return rt.create_object_dynamically(var_classname, [rt.new_int(product_id)])
}

fn wc_product_sku_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_product_sku_enabled'), rt.new_bool(true)])
}

fn wc_product_weight_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_product_weight_enabled'), rt.new_bool(true)])
}

fn wc_product_dimensions_enabled() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wc_product_dimensions_enabled'), rt.new_bool(true)])
}

fn wc_delete_product_transients(post_id i64) {
	mut var_transients_to_clear := ['wc_products_onsale', 'wc_featured_products', 'wc_outofstock_count', 'wc_low_stock_count']
	for var_transient in var_transients_to_clear {
		rt.call_function('delete_transient', [rt.new_string(transient)])
	}
	if post_id > 0 {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_ProductUtil.class()]), 'delete_product_specific_transients', [rt.new_int(post_id)])
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('product'), rt.new_bool(true))
	rt.call_function('do_action', [rt.new_string('woocommerce_delete_product_transients'), rt.new_int(post_id)])
}

fn wc_delete_related_product_transients(var_post_id rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('wc_delete_related_product_transients'), rt.new_string('10.1.0'), rt.new_string('This function is deprecated and will be removed in a future version.')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_id.dup().is_long() || var_post_id.dup().is_double()))))) {
		return rt.new_null()
	}
	mut var_transient_name := rt.new_string('wc_related_' + (var_post_id).str())
	mut var_old_transient := rt.call_function('get_transient', [var_transient_name.dup()])
	mut var_old_related_product_ids := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_old_transient.dup().is_array())) && !(!rt.is_true(var_old_transient)))) {
		var_old_related_product_ids = var_old_transient.array_get(rt.call_function('array_key_first', [var_old_transient.dup()]))
	}
	rt.call_function('delete_transient', [var_transient_name.dup()])
	mut var_new_related_product_ids := wc_get_related_products(var_post_id.dup(), 1000, rt.new_null(), rt.new_null())
	mut var_related_product_ids := rt.call_function('array_unique', [rt.call_function('array_merge', [var_old_related_product_ids.dup(), var_new_related_product_ids.dup()])])
	if !rt.is_true(var_related_product_ids) {
		return rt.new_null()
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string('wc_related_' + (var_id).str())
	}
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string('wc_related_' + (var_id).str())
	}
	mut var_related_product_transients := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_related_product_ids.dup()])
	rt.call_function('_wc_delete_transients', [var_related_product_transients.dup()])
}

fn wc_get_product_ids_on_sale() rt.PhpVal {
	mut var_product_ids_on_sale := rt.call_function('get_transient', [rt.new_string('wc_products_onsale')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_product_ids_on_sale.dup()
	}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product'))
	mut var_on_sale_products := rt.call_method(var_data_store, 'get_on_sale_products', []rt.PhpVal{})
	var_product_ids_on_sale = rt.call_function('wp_parse_id_list', [rt.call_function('array_merge', [rt.call_function('wp_list_pluck', [var_on_sale_products.dup(), rt.new_string('id')]), rt.call_function('array_diff', [rt.call_function('wp_list_pluck', [var_on_sale_products.dup(), rt.new_string('parent_id')]), rt.create_array([rt.ArrayItem{ key: none, val: 0 }])])])])
	rt.call_function('set_transient', [rt.new_string('wc_products_onsale'), var_product_ids_on_sale.dup(), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	return var_product_ids_on_sale.dup()
}

fn wc_get_featured_product_ids() rt.PhpVal {
	mut var_featured_product_ids := rt.call_function('get_transient', [rt.new_string('wc_featured_products')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_featured_product_ids.dup()
	}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('product'))
	mut var_featured := rt.call_method(var_data_store, 'get_featured_product_ids', []rt.PhpVal{})
	mut var_product_ids := rt.func_array_keys(var_featured.dup())
	mut var_parent_ids := rt.call_function('array_values', [rt.call_function('array_filter', [var_featured.dup()])])
	var_featured_product_ids = rt.call_function('array_unique', [rt.call_function('array_merge', [var_product_ids.dup(), var_parent_ids.dup()])])
	rt.call_function('set_transient', [rt.new_string('wc_featured_products'), var_featured_product_ids.dup(), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	return var_featured_product_ids.dup()
}

fn wc_product_post_type_link(permalink string, var_post rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_string(permalink)
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string(permalink), rt.new_string('%')]))) {
		return rt.new_string(permalink)
	}
	mut var_needs_category := rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
	mut var_product_cat := rt.new_string(rt.new_string(''))
	if var_needs_category {
		mut var_terms := rt.call_function('get_the_terms', [rt.get_property(var_post, 'ID'), rt.new_string('product_cat')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_terms)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()]))))))) && rt.is_true(rt.new_bool(var_terms.dup().is_array())))) {
			var_terms = rt.call_function('array_values', [var_terms.dup()])
			mut var_deepest_term := var_terms.array_get(0)
			mut var_deepest_ancestors := if rt.is_true(rt.get_property(var_deepest_term, 'parent')) { rt.call_function('get_ancestors', [rt.get_property(var_deepest_term, 'term_id'), rt.new_string('product_cat')]) } else { rt.new_array() }
			{
				mut iter_1 := var_terms.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_term := item_1.val
					if rt.is_true(rt.identical(rt.get_property(var_term, 'term_id'), rt.get_property(var_deepest_term, 'term_id'))) {
						continue
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_term, 'parent'))))) {
						continue
					}
					mut var_ancestors := rt.call_function('get_ancestors', [rt.get_property(var_term, 'term_id'), rt.new_string('product_cat')])
					if var_ancestors.dup().array_count() > var_deepest_ancestors.dup().array_count() {
						var_deepest_ancestors = var_ancestors.dup()
						var_deepest_term = var_term.dup()
					}
				}
			}
			mut var_category_object := rt.call_function('apply_filters', [rt.new_string('wc_product_post_type_link_product_cat'), var_deepest_term.dup(), var_terms.dup(), var_post.dup()])
			var_category_object = if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_category_object, 'WP_Term')))))) { var_deepest_term } else { var_category_object }
			var_product_cat = rt.get_property(var_category_object, 'slug')
			if rt.is_true(rt.get_property(var_category_object, 'parent')) {
				mut var_ancestors := if rt.is_true(rt.identical(rt.get_property(var_category_object, 'term_id'), rt.get_property(var_deepest_term, 'term_id'))) { var_deepest_ancestors } else { rt.call_function('get_ancestors', [rt.get_property(var_category_object, 'term_id'), rt.new_string('product_cat')]) }
				{
					mut iter_1 := var_ancestors.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_ancestor := item_1.val
						mut var_ancestor_object := rt.call_function('get_term', [var_ancestor.dup(), rt.new_string('product_cat')])
						if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_post_type_link_parent_category_only'), rt.new_bool(false)])) {
							var_product_cat = rt.get_property(var_ancestor_object, 'slug')
						} else {
							var_product_cat = rt.new_string( + ().str())
						}
					}
				}
			}
		} else {
			var_product_cat = rt.call_function('_x', [rt.new_string('uncategorized'), rt.new_string('slug'), rt.new_string('woocommerce')])
		}
	}
	mut var_find := ['%year%', '%monthnum%', '%day%', '%hour%', '%minute%', '%second%', '%post_id%', '%category%', '%product_cat%']
	mut var_replace := [, , , , , , , var_product_cat, var_product_cat]
	permalink = ().str()
	return rt.new_string(permalink)
}

struct Class_WC_Product_Query {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_product_query() &Class_WC_Product_Query {
	mut obj := &Class_WC_Product_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_factory() &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
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

fn (mut this Class_WC_Product_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn init_registry() {
	rt.register_class_factory('WC_Product_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_query()
		return rt.new_object('WC_Product_Query', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cache_helper()
		return rt.new_object('WC_Cache_Helper', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_wc_product_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	
}
