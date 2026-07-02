import rt

struct Class_Automattic_WooCommerce_Internal_ProductFilters_Params {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_productfilters_params() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_ProductFilters_Params', 'params',
		rt.new_array())
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_param_keys() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_ProductFilters_Params',
		'params')) {
		this.init_params()
	}
	mut var_keys := rt.new_array()
	mut iter_1 := rt.get_static_prop('Automattic_WooCommerce_Internal_ProductFilters_Params',
		'params').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_params := item_1.val
		mut var_taxonomy := item_1.key
		var_keys = rt.call_function('array_merge', [var_keys.clone(),
			rt.call_function('array_values', [var_params.clone()])])
		if rt.is_true(rt.identical(rt.new_string('attribute'), var_taxonomy)) {
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_param := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_string('query_type_' + var_param.str())
			}
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_param := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_string('query_type_' + var_param.str())
			}
			mut var_query_type_params := rt.call_function('array_map', [
				rt.new_closure(closure_1_fn),
				rt.func_array_keys(var_params.clone()),
			])
			var_keys = rt.call_function('array_merge', [var_keys.clone(),
				var_query_type_params.clone()])
		}
	}
	return var_keys.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_param(type string) rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_ProductFilters_Params',
		'params')) {
		this.init_params()
	}
	return if !(rt.get_static_prop('Automattic_WooCommerce_Internal_ProductFilters_Params',
		'params').array_get(rt.new_string(type))).is_null() {
		rt.get_static_prop('Automattic_WooCommerce_Internal_ProductFilters_Params', 'params').array_get(rt.new_string(type))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) init_params() {
	rt.set_static_prop('Automattic_WooCommerce_Internal_ProductFilters_Params', 'params', rt.create_array([
		rt.ArrayItem{ key: 'price', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'min_price' },
			rt.ArrayItem{ key: none, val: 'max_price' },
		]) },
		rt.ArrayItem{ key: 'rating', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'rating_filter' },
		]) },
		rt.ArrayItem{ key: 'status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'filter_stock_status' },
		]) },
		rt.ArrayItem{ key: 'attribute', val: this.get_attribute_params() },
		rt.ArrayItem{ key: 'taxonomy', val: this.get_taxonomy_params() },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_attribute_params() rt.PhpVal {
	mut var_params := rt.new_array()
	mut iter_2 := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_attribute := item_2.val
		var_params.array_set(rt.get_property(var_attribute, 'attribute_name'), rt.concat(rt.new_string('filter_'), rt.get_property(var_attribute,
			'attribute_name')))
	}
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) get_taxonomy_params() rt.PhpVal {
	mut var_public_product_taxonomies := rt.call_function('get_taxonomies', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true },
			rt.ArrayItem{ key: 'show_ui', val: true }]),
		rt.new_string('objects'),
	])
	mut var_map := rt.create_array([
		rt.ArrayItem{ key: 'product_cat', val: 'categories' },
		rt.ArrayItem{ key: 'product_tag', val: 'tags' },
		rt.ArrayItem{ key: 'product_brand', val: 'brands' },
	])
	mut var_params := rt.new_array()
	mut iter_3 := var_public_product_taxonomies.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_taxonomy := item_3.val
		if rt.get_property(var_taxonomy, 'object_type').is_array()
			&& rt.is_true(rt.call_function('in_array', [rt.new_string('product'), rt.get_property(var_taxonomy, 'object_type'), rt.new_bool(true)])) {
			var_params.array_set(rt.get_property(var_taxonomy, 'name'), if !(var_map.array_get(rt.get_property(var_taxonomy,
				'name'))).is_null() {
				var_map.array_get(rt.get_property(var_taxonomy, 'name'))
			} else {
				rt.concat(rt.new_string('filter_'), rt.get_property(var_taxonomy, 'name'))
			})
		}
	}
	return var_params.clone()
}

fn create_automattic_woocommerce_internal_productfilters_params(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFilters_Params {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_Params{
		PhpObjectBase: rt.PhpObjectBase{}
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_Params) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_Params) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
