import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init.feature_id() string {
	return 'async-product-editor-category-field'
}

struct Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 :=
		iife_temp_0.is_enabled(Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init.feature_id())
	if rt.is_true(iife_result_0) {
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'enqueue_styles' },
			])])
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'enqueue_scripts' },
			])])
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_taxonomy_args_product_cat'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'add_metabox_args' },
			]),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init) add_metabox_args(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if !(var_args_mutated.array_isset(rt.new_string('meta_box_cb'))) {
		var_args_mutated.array_set('meta_box_cb', 'WC_Meta_Box_Product_Categories::output')
		var_args_mutated.array_set('meta_box_sanitize_cb',
			'taxonomy_meta_box_sanitize_cb_checkboxes')
	}
	return var_args_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init) enqueue_scripts() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_1 := iife_temp_1.is_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_2 := iife_temp_2.register_script(rt.new_string('wp-admin-scripts'),
		rt.new_string('product-category-metabox'), rt.new_bool(true))
	rt.call_function('wp_localize_script', [
		rt.new_string('wc-admin-product-category-metabox'),
		rt.new_string('wc_product_category_metabox_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'search_categories_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-categories'),
			]) },
			rt.ArrayItem{ key: 'search_taxonomy_terms_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('search-taxonomy-terms'),
			]) },
		]),
	])
	rt.call_function('wp_enqueue_script', [rt.new_string('product-category-metabox')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init) enqueue_styles() {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_3 := iife_temp_3.is_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
		return
	}
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_4
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_5 := iife_temp_5.get_url(rt.new_string('product-category-metabox/style'),
		rt.new_string('css'))
	rt.call_function('wp_register_style', [
		rt.new_string('woocommerce_admin_product_category_metabox_styles'),
		iife_result_5,
		rt.new_array(),
		var_version.clone(),
	])
	rt.call_function('wp_style_add_data', [
		rt.new_string('woocommerce_admin_product_category_metabox_styles'),
		rt.new_string('rtl'),
		rt.new_string('replace'),
	])
	rt.call_function('wp_enqueue_style', [
		rt.new_string('woocommerce_admin_product_category_metabox_styles'),
	])
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_asyncproducteditorcategoryfield_init() &Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_wcadminassets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_metabox_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_metabox_args(dispatch_arg_0)
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'enqueue_styles' {
			this.enqueue_styles()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_AsyncProductEditorCategoryField_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
