import rt

pub fn Class_WC_Admin_Meta_Boxes.error_store() string {
	return 'woocommerce_meta_box_errors'
}
struct Class_WC_Admin_Meta_Boxes {
	rt.PhpObjectBase
pub mut:
		saved_meta_boxes rt.PhpVal = rt.new_bool(false)
		meta_box_errors rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Admin_Meta_Boxes) construct()  {
	rt.call_function('add_action', [rt.new_string('add_meta_boxes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_meta_boxes' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('add_meta_boxes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'rename_meta_boxes' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('add_meta_boxes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_meta_boxes' }]), rt.new_int(30)])
	rt.call_function('add_action', [rt.new_string('add_meta_boxes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_product_boxes_sort_order' }]), rt.new_int(40)])
	rt.call_function('add_action', [rt.new_string('save_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save_meta_boxes' }]), rt.new_int(1), rt.new_int(2)])
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit{}; return temp.add_save_meta_boxes() }()
	rt.call_function('add_action', [rt.new_string('woocommerce_process_product_meta'), rt.new_string('WC_Meta_Box_Product_Data::save'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_process_product_meta'), rt.new_string('WC_Meta_Box_Product_Images::save'), rt.new_int(20), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_process_shop_coupon_meta'), rt.new_string('WC_Meta_Box_Coupon_Data::save'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_update_comment_data'), rt.new_string('WC_Meta_Box_Product_Reviews::save'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'output_errors' }])])
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'append_to_error_store' }])])
	rt.call_function('add_filter', [rt.new_string('theme_product_templates'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Meta_Boxes', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_block_templates' }]), rt.new_int(10), rt.new_int(1)])
}

fn Class_WC_Admin_Meta_Boxes.add_error(var_text rt.PhpVal)  {
	// unsupported expression: Expr_StaticPropertyFetch.array_push(var_text.dup())
}

fn (mut this Class_WC_Admin_Meta_Boxes) save_errors()  {
	rt.call_function('update_option', [Class_WC_Admin_Meta_Boxes.error_store(), // unsupported expression: Expr_StaticPropertyFetch])
}

fn (mut this Class_WC_Admin_Meta_Boxes) append_to_error_store()  {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		return rt.new_null()
	}
	mut var_existing_errors := rt.call_function('get_option', [Class_WC_Admin_Meta_Boxes.error_store(), rt.new_array()])
	rt.call_function('update_option', [Class_WC_Admin_Meta_Boxes.error_store(), rt.call_function('array_unique', [rt.call_function('array_merge', [var_existing_errors.dup(), // unsupported expression: Expr_StaticPropertyFetch])])])
}

fn (mut this Class_WC_Admin_Meta_Boxes) output_errors()  {
	mut var_errors := rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_option', [Class_WC_Admin_Meta_Boxes.error_store()]))])
	if !(!rt.is_true(var_errors)) {
		print('<div id="woocommerce_errors" class="error notice is-dismissible">')
		{
			mut iter_1 := var_errors.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_error := item_1.val
				print('<p>' + (rt.call_function('wp_kses_post', [var_error.dup()])).str() + '</p>')
			}
		}
		print('</div>')
		rt.call_function('delete_option', [Class_WC_Admin_Meta_Boxes.error_store()])
	}
}

fn (mut this Class_WC_Admin_Meta_Boxes) add_meta_boxes()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	rt.call_function('add_meta_box', [rt.new_string('postexcerpt'), rt.call_function('__', [rt.new_string('Product short description'), rt.new_string('woocommerce')]), rt.new_string('WC_Meta_Box_Product_Short_Description::output'), rt.new_string('product'), rt.new_string('normal')])
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-product-data'), rt.call_function('__', [rt.new_string('Product data'), rt.new_string('woocommerce')]), rt.new_string('WC_Meta_Box_Product_Data::output'), rt.new_string('product'), rt.new_string('normal'), rt.new_string('high')])
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-product-images'), rt.call_function('__', [rt.new_string('Product gallery'), rt.new_string('woocommerce')]), rt.new_string('WC_Meta_Box_Product_Images::output'), rt.new_string('product'), rt.new_string('side'), rt.new_string('low')])
	{
		mut iter_1 := rt.call_function('wc_get_order_types', [rt.new_string('order-meta-boxes')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			mut var_order_type_object := rt.call_function('get_post_type_object', [var_type.dup()])
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit{}; return temp.add_order_meta_boxes(arg_0, arg_1) }(var_type.dup(), rt.get_property(rt.get_property(var_order_type_object, 'labels'), 'singular_name'))
		}
	}
	rt.call_function('add_meta_box', [rt.new_string('woocommerce-coupon-data'), rt.call_function('__', [rt.new_string('Coupon data'), rt.new_string('woocommerce')]), rt.new_string('WC_Meta_Box_Coupon_Data::output'), rt.new_string('shop_coupon'), rt.new_string('normal'), rt.new_string('high')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('comment'), var_screen_id)) && rt.get_superglobal('_GET').array_isset(rt.new_string('c')))) && rt.is_true(rt.call_function('metadata_exists', [rt.new_string('comment'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('c')])]), rt.new_string('rating')])))) {
		rt.call_function('add_meta_box', [rt.new_string('woocommerce-rating'), rt.call_function('__', [rt.new_string('Rating'), rt.new_string('woocommerce')]), rt.new_string('WC_Meta_Box_Product_Reviews::output'), rt.new_string('comment'), rt.new_string('normal'), rt.new_string('high')])
	}
}

fn (mut this Class_WC_Admin_Meta_Boxes) add_product_boxes_sort_order()  {
	mut var_current_value := rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('meta-box-order_product'), rt.new_bool(true)])
	if rt.is_true(var_current_value) {
		return rt.new_null()
	}
	rt.call_function('update_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('meta-box-order_product'), rt.create_array([rt.ArrayItem{ key: 'side', val: 'submitdiv,postimagediv,woocommerce-product-images,product_catdiv,tagsdiv-product_tag' }, rt.ArrayItem{ key: 'normal', val: 'woocommerce-product-data,postcustom,slugdiv,postexcerpt' }, rt.ArrayItem{ key: 'advanced', val: '' }])])
}

fn (mut this Class_WC_Admin_Meta_Boxes) remove_meta_boxes()  {
	rt.call_function('remove_meta_box', [rt.new_string('postexcerpt'), rt.new_string('product'), rt.new_string('normal')])
	rt.call_function('remove_meta_box', [rt.new_string('product_shipping_classdiv'), rt.new_string('product'), rt.new_string('side')])
	rt.call_function('remove_meta_box', [rt.new_string('commentsdiv'), rt.new_string('product'), rt.new_string('normal')])
	rt.call_function('remove_meta_box', [rt.new_string('commentstatusdiv'), rt.new_string('product'), rt.new_string('side')])
	rt.call_function('remove_meta_box', [rt.new_string('commentstatusdiv'), rt.new_string('product'), rt.new_string('normal')])
	rt.call_function('remove_meta_box', [rt.new_string('woothemes-settings'), rt.new_string('shop_coupon'), rt.new_string('normal')])
	rt.call_function('remove_meta_box', [rt.new_string('commentstatusdiv'), rt.new_string('shop_coupon'), rt.new_string('normal')])
	rt.call_function('remove_meta_box', [rt.new_string('slugdiv'), rt.new_string('shop_coupon'), rt.new_string('normal')])
	{
		mut iter_1 := rt.call_function('wc_get_order_types', [rt.new_string('order-meta-boxes')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			rt.call_function('remove_meta_box', [rt.new_string('commentsdiv'), var_type.dup(), rt.new_string('normal')])
			rt.call_function('remove_meta_box', [rt.new_string('woothemes-settings'), var_type.dup(), rt.new_string('normal')])
			rt.call_function('remove_meta_box', [rt.new_string('commentstatusdiv'), var_type.dup(), rt.new_string('normal')])
			rt.call_function('remove_meta_box', [rt.new_string('slugdiv'), var_type.dup(), rt.new_string('normal')])
			rt.call_function('remove_meta_box', [rt.new_string('submitdiv'), var_type.dup(), rt.new_string('side')])
		}
	}
}

fn (mut this Class_WC_Admin_Meta_Boxes) rename_meta_boxes()  {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_post).is_null() && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_post, 'post_status'))) || rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status'))))))) && rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'), rt.new_string('comments')])))) {
		rt.call_function('remove_meta_box', [rt.new_string('commentsdiv'), rt.new_string('product'), rt.new_string('normal')])
		rt.call_function('add_meta_box', [rt.new_string('commentsdiv'), rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')]), rt.new_string('post_comment_meta_box'), rt.new_string('product'), rt.new_string('normal')])
	}
}

fn (mut this Class_WC_Admin_Meta_Boxes) save_meta_boxes(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = rt.call_function('absint', [var_post_id_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_post_id_mutated) || !rt.is_true(var_post) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_post.dup(), rt.new_string('WP_Post')]))))))) || rt.is_true(// unsupported expression: Expr_StaticPropertyFetch))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('DOING_AUTOSAVE'))) || rt.is_true(rt.new_bool(rt.call_function('wp_is_post_revision', [var_post.dup()]).is_long())))) || rt.is_true(rt.new_bool(rt.call_function('wp_is_post_autosave', [var_post.dup()]).is_long())))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('woocommerce_meta_nonce')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('woocommerce_meta_nonce')]), rt.new_string('woocommerce_save_data')]))))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('post_ID')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_post_id_mutated.dup()]))))) {
		return rt.new_null()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.call_function('wc_get_order_types', [rt.new_string('order-meta-boxes')]), rt.new_bool(true)])) {
		if rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.custom_orders_table_usage_is_enabled() }()) {
			return rt.new_null()
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_process_shop_order_meta'), var_post_id_mutated.dup(), var_post.dup()])
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'product' }, rt.ArrayItem{ key: none, val: 'shop_coupon' }]), rt.new_bool(true)])) {
		rt.call_function('do_action', ['woocommerce_process_' + (rt.get_property(var_post, 'post_type')).str() + '_meta', var_post_id_mutated.dup(), var_post.dup()])
	}
}

fn (mut this Class_WC_Admin_Meta_Boxes) remove_block_templates(var_templates rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_templates.dup().array_count() == 0 || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))))) {
		return var_templates.dup()
	}
	mut var_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_stylesheet', []rt.PhpVal{})
	mut var_filtered_templates := rt.new_array()
	{
		mut iter_1 := var_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template_name := item_1.val
			mut var_template_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('single-product'), var_template_key)) {
				continue
			}
			mut var_block_template := rt.call_function('get_block_template', [(var_theme).str() + '//' + (var_template_key).str()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_block_template) && rt.is_true(rt.new_bool(rt.get_property(var_block_template, 'post_types').is_array())))) && rt.is_true(rt.call_function('in_array', [rt.new_string('product'), rt.get_property(var_block_template, 'post_types')])))) {
				var_filtered_templates.array_set(var_template_key, var_template_name.dup())
			}
		}
	}
	return var_filtered_templates.dup()
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_wc_admin_meta_boxes() &Class_WC_Admin_Meta_Boxes {
	mut obj := &Class_WC_Admin_Meta_Boxes{
		PhpObjectBase: rt.PhpObjectBase{}
		saved_meta_boxes: rt.new_bool(false)
		meta_box_errors: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_edit() &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Meta_Boxes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Admin_Meta_Boxes.add_error(dispatch_arg_0)
			return rt.new_null()
		}
		'save_errors' {
			this.save_errors()
			return rt.new_null()
		}
		'append_to_error_store' {
			this.append_to_error_store()
			return rt.new_null()
		}
		'output_errors' {
			this.output_errors()
			return rt.new_null()
		}
		'add_meta_boxes' {
			this.add_meta_boxes()
			return rt.new_null()
		}
		'add_product_boxes_sort_order' {
			this.add_product_boxes_sort_order()
			return rt.new_null()
		}
		'remove_meta_boxes' {
			this.remove_meta_boxes()
			return rt.new_null()
		}
		'rename_meta_boxes' {
			this.rename_meta_boxes()
			return rt.new_null()
		}
		'save_meta_boxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save_meta_boxes(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_block_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_block_templates(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Admin_Meta_Boxes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'saved_meta_boxes' { return this.saved_meta_boxes }
		'meta_box_errors' { return this.meta_box_errors }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Admin_Meta_Boxes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'saved_meta_boxes' { this.saved_meta_boxes = val; return true }
		'meta_box_errors' { this.meta_box_errors = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_Edit) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_class_wc_admin_meta_boxes_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	create_wc_admin_meta_boxes()
}
