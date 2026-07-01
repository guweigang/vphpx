import rt

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController {
	rt.PhpObjectBase
pub mut:
		product_templates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) construct()  {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('product_block_editor'))) {
		rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_redirect_to_new_editor' }]), rt.new_int(30), rt.new_int(0)])
		rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'redirect_non_supported_product_types' }]), rt.new_int(30), rt.new_int(0)])
	} else {
		rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_redirect_to_old_editor' }]), rt.new_int(30), rt.new_int(0)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) is_legacy_add_new_screen() bool {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	return rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'base'))) && rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_screen, 'post_type'))))) && rt.is_true(rt.identical(rt.new_string('add'), rt.get_property(var_screen, 'action')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) is_legacy_edit_screen() bool {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	return rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_screen, 'base'))) && rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_screen, 'post_type'))))) && rt.get_superglobal('_GET').array_isset(rt.new_string('post')))) && rt.get_superglobal('_GET').array_isset(rt.new_string('action')))) && rt.is_true(rt.identical(rt.new_string('edit'), rt.get_superglobal('_GET').array_get('action')))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) is_product_supported(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
	mut var_product := if rt.is_true(var_product_id_mutated) { rt.call_function('wc_get_product', [var_product_id_mutated.dup()]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(var_product.dup().is_null())) {
		return false
	}
	mut var_digital_product := rt.new_bool(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_product, 'is_virtual', []rt.PhpVal{}))))
	mut var_product_template_id := rt.call_method(var_product, 'get_meta', [rt.new_string('_product_template_id')])
	{
		mut iter_1 := this.product_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_template := item_1.val
			if rt.is_true(rt.new_bool(rt.call_method(var_product_template, 'get_layout_template_id', []rt.PhpVal{}).is_null())) {
				continue
			}
			mut var_product_data := rt.call_method(var_product_template, 'get_product_data', []rt.PhpVal{})
			mut var_product_data_type := var_product_data.array_get('type')
			mut var_product_type := if rt.is_true(rt.identical(rt.call_method(var_product, 'get_type', []rt.PhpVal{}), Class_Automattic_WooCommerce_Enums_ProductType.variable())) { Class_Automattic_WooCommerce_Enums_ProductType.simple() } else { rt.call_method(var_product, 'get_type', []rt.PhpVal{}) }
			if rt.is_true(rt.new_bool(!(var_product_data_type).is_null() && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(var_product_template_id).is_null() && rt.is_true(rt.identical(var_product_template_id, rt.call_method(var_product_template, 'get_id', []rt.PhpVal{}))))) {
				return true
			}
			if !(var_product_data_type).is_null() {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) set_product_templates(mut var_product_templates Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array)  {
	this.product_templates = var_product_templates.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) maybe_redirect_to_new_editor()  {
	if this.is_legacy_add_new_screen() {
		rt.call_function('wp_safe_redirect', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&path=/add-product')])])
		// unsupported expression: Expr_Exit
	}
	if this.is_legacy_edit_screen() {
		mut var_product_id := if rt.get_superglobal('_GET').array_isset(rt.new_string('post')) { rt.call_function('absint', [rt.get_superglobal('_GET').array_get('post')]) } else { rt.new_null() }
		if !(this.is_product_supported(var_product_id.dup())) {
			return rt.new_null()
		}
		rt.call_function('wp_safe_redirect', [rt.call_function('admin_url', ['admin.php?page=wc-admin&path=/product/' + (var_product_id).str()])])
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) maybe_redirect_to_old_editor()  {
	mut var_route := this.get_parsed_route()
	if rt.is_true(rt.identical(rt.new_string('add-product'), var_route.array_get('page'))) {
		rt.call_function('wp_safe_redirect', [rt.call_function('admin_url', [rt.new_string('post-new.php?post_type=product')])])
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.identical(rt.new_string('product'), var_route.array_get('page'))) {
		rt.call_function('wp_safe_redirect', [rt.call_function('admin_url', ['post.php?post=' + (var_route.array_get('product_id')).str() + '&action=edit'])])
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) get_parsed_route() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('path'))))) {
		return rt.create_array([rt.ArrayItem{ key: 'page', val: rt.new_null() }, rt.ArrayItem{ key: 'product_id', val: rt.new_null() }])
	}
	mut var_path := rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('path')])])
	mut var_path_pieces := rt.call_function('explode', [rt.new_string('/'), rt.call_function('wp_parse_url', [var_path.dup(), rt.get_constant('PHP_URL_PATH')])])
	return rt.create_array([rt.ArrayItem{ key: 'page', val: if !(var_path_pieces.array_get(1)).is_null() { var_path_pieces.array_get(1) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'product_id', val: if rt.is_true(rt.identical(rt.new_string('product'), if !(var_path_pieces.array_get(1)).is_null() { var_path_pieces.array_get(1) } else { rt.new_string('') })) { rt.call_function('absint', [if !(var_path_pieces.array_get(2)).is_null() { var_path_pieces.array_get(2) } else { rt.new_int(0) }]) } else { rt.new_null() } }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) redirect_non_supported_product_types()  {
	mut var_route := this.get_parsed_route()
	mut var_product_id := var_route.array_get('product_id')
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('product'), var_route.array_get('page'))) && !(this.is_product_supported(var_product_id.dup())))) {
		rt.call_function('wp_safe_redirect', [rt.call_function('admin_url', ['post.php?post=' + (var_route.array_get('product_id')).str() + '&action=edit'])])
		// unsupported expression: Expr_Exit
	}
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_productblockeditor_redirectioncontroller() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController{
		PhpObjectBase: rt.PhpObjectBase{}
		product_templates: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_legacy_add_new_screen' {
			return rt.new_bool(this.is_legacy_add_new_screen())
		}
		'is_legacy_edit_screen' {
			return rt.new_bool(this.is_legacy_edit_screen())
		}
		'is_product_supported' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_product_supported(dispatch_arg_0))
		}
		'set_product_templates' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_product_templates(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_redirect_to_new_editor' {
			this.maybe_redirect_to_new_editor()
			return rt.new_null()
		}
		'maybe_redirect_to_old_editor' {
			this.maybe_redirect_to_old_editor()
			return rt.new_null()
		}
		'get_parsed_route' {
			return this.get_parsed_route()
		}
		'redirect_non_supported_product_types' {
			this.redirect_non_supported_product_types()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_templates' { return this.product_templates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_RedirectionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_templates' { this.product_templates = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_productblockeditor_redirectioncontroller_php() {
}
