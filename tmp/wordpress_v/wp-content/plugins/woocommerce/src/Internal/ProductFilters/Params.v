import rt

struct Class_Automattic_WooCommerce_Internal_ProductFilters_Params {
	rt.PhpObjectBase
pub mut:
		params rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_param_keys() rt.PhpVal {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		this.init_params()
	}
	mut var_keys := rt.new_array()
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_params := item_1.val
			mut var_taxonomy := item_1.key
			var_keys = rt.call_function('array_merge', [var_keys.dup(), rt.call_function('array_values', [var_params.dup()])])
			if rt.is_true(rt.identical(rt.new_string('attribute'), var_taxonomy)) {
				closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_param := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string('query_type_' + (var_param).str())
	}
	mut var_param := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string('query_type_' + (var_param).str())
	}
				mut var_query_type_params := rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.func_array_keys(var_params.dup())])
				var_keys = rt.call_function('array_merge', [var_keys.dup(), var_query_type_params.dup()])
			}
		}
	}
	return var_keys.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_param(type string) rt.PhpVal {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		this.init_params()
	}
	return if !(// unsupported expression: Expr_StaticPropertyFetch.array_get(type)).is_null() { // unsupported expression: Expr_StaticPropertyFetch.array_get(type) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) init_params()  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_attribute_params() rt.PhpVal {
	mut var_params := rt.new_array()
	{
		mut iter_1 := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute := item_1.val
			var_params.array_set(rt.get_property(var_attribute, 'attribute_name'), rt.concat(rt.new_string('filter_'), rt.get_property(var_attribute, 'attribute_name')))
		}
	}
	return var_params.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_taxonomy_params() rt.PhpVal {
	mut var_public_product_taxonomies := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'public', val: true }, rt.ArrayItem{ key: 'show_ui', val: true }]), rt.new_string('objects')])
	mut var_map := rt.create_array([rt.ArrayItem{ key: 'product_cat', val: 'categories' }, rt.ArrayItem{ key: 'product_tag', val: 'tags' }, rt.ArrayItem{ key: 'product_brand', val: 'brands' }])
	mut var_params := rt.new_array()
	{
		mut iter_1 := var_public_product_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_property(var_taxonomy, 'object_type').is_array())) && rt.is_true(rt.call_function('in_array', [rt.new_string('product'), rt.get_property(var_taxonomy, 'object_type'), rt.new_bool(true)])))) {
				var_params.array_set(rt.get_property(var_taxonomy, 'name'), if !(var_map.array_get(rt.get_property(var_taxonomy, 'name'))).is_null() { var_map.array_get(rt.get_property(var_taxonomy, 'name')) } else { rt.concat(rt.new_string('filter_'), rt.get_property(var_taxonomy, 'name')) })
			}
		}
	}
	return var_params.dup()
}

fn create_automattic_woocommerce_internal_productfilters_params() &Class_Automattic_WooCommerce_Internal_ProductFilters_Params {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_Params{
		PhpObjectBase: rt.PhpObjectBase{}
		params: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_param_keys' {
			return this.get_param_keys()
		}
		'get_param' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_param(dispatch_arg_0)
		}
		'init_params' {
			this.init_params()
			return rt.new_null()
		}
		'get_attribute_params' {
			return this.get_attribute_params()
		}
		'get_taxonomy_params' {
			return this.get_taxonomy_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_Params) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'params' { return this.params }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'params' { this.params = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productfilters_params_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
