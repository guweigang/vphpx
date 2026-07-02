import rt

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) init() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_source'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_product_source' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) is_product_editor_page(var_url rt.PhpVal) bool {
	mut var_query := rt.new_null()
	mut var_query_string := rt.call_function('wp_parse_url', [
		rt.call_function('wp_get_referer', []rt.PhpVal{}),
		rt.get_constant('PHP_URL_QUERY'),
	])
	rt.call_function('parse_str', [var_query_string.clone(), var_query.clone()])
	if !(var_query.array_isset(rt.new_string('page')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wc-admin'), var_query.array_get(rt.new_string('page'))))))
		|| !(var_query.array_isset(rt.new_string('path'))) {
		return false
	}
	mut var_path_pieces := rt.call_function('explode', [rt.new_string('/'),
		var_query.array_get(rt.new_string('path'))])
	mut var_route := var_path_pieces.array_get(rt.new_int(1))
	return rt.is_true(rt.identical(rt.new_string('add-product'), var_route))
		|| rt.is_true(rt.identical(rt.new_string('product'), var_route))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) add_product_source(var_source rt.PhpVal) string {
	if this.is_product_editor_page(rt.call_function('wp_get_referer', []rt.PhpVal{})) {
		return 'product-block-editor-v1'
	}
	return var_source.str()
}

fn create_automattic_woocommerce_admin_features_productblockeditor_tracks(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'is_product_editor_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_product_editor_page(dispatch_arg_0))
		}
		'add_product_source' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.add_product_source(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
