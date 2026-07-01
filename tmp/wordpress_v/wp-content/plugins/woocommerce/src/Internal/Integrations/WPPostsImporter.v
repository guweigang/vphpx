import rt

struct Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter) register()  {
	rt.call_function('add_action', [rt.new_string('wp_import_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Integrations_WPPostsImporter', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_product_attribute_taxonomies' }]), rt.new_int(100), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter) register_product_attribute_taxonomies(var_posts rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_posts.dup().is_array()))))) || !rt.is_true(var_posts))) {
		return var_posts.dup()
	}
	{
		mut iter_1 := var_posts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !rt.is_true(var_post.array_get('terms')))) {
				continue
			}
			{
				mut iter_2 := var_post.array_get('terms').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_term := item_2.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_term.array_get('domain'), rt.new_string('pa_')]))))) {
						continue
					}
					if rt.is_true(rt.call_function('taxonomy_exists', [var_term.array_get('domain')])) {
						continue
					}
					mut var_attribute_name := rt.call_function('wc_attribute_taxonomy_slug', [var_term.array_get('domain')])
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_attribute_name.dup(), rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}), rt.new_bool(true)]))))) {
						rt.call_function('wc_create_attribute', [rt.create_array([rt.ArrayItem{ key: 'name', val: var_attribute_name }, rt.ArrayItem{ key: 'slug', val: var_attribute_name }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'order_by', val: 'menu_order' }, rt.ArrayItem{ key: 'has_archives', val: false }])])
					}
					rt.call_function('register_taxonomy', [var_term.array_get('domain'), rt.call_function('apply_filters', ['woocommerce_taxonomy_objects_' + (var_term.array_get('domain')).str(), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }])]), rt.call_function('apply_filters', ['woocommerce_taxonomy_args_' + (var_term.array_get('domain')).str(), rt.create_array([rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'show_ui', val: false }, rt.ArrayItem{ key: 'query_var', val: true }, rt.ArrayItem{ key: 'rewrite', val: false }])])])
				}
			}
		}
	}
	return var_posts.dup()
}

fn create_automattic_woocommerce_internal_integrations_wppostsimporter() &Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter {
	mut obj := &Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'register_product_attribute_taxonomies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_product_attribute_taxonomies(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPPostsImporter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_integrations_wppostsimporter_php() {
	// unsupported statement: Stmt_Declare
}
