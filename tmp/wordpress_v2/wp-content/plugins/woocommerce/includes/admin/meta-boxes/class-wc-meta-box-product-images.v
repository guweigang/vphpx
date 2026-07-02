import rt

struct Class_WC_Meta_Box_Product_Images {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Product_Images.output(var_post rt.PhpVal) {
	mut var_thepostid := rt.get_superglobal('thepostid')
	mut var_product_object := rt.get_superglobal('product_object')
	var_thepostid = rt.get_property(var_post, 'ID')
	var_product_object = if rt.is_true(var_thepostid) { rt.call_function('wc_get_product', [
			var_thepostid.clone(),
		]) } else { create_wc_product() }
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_save_data'),
		rt.new_string('woocommerce_meta_nonce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_product_image_gallery := rt.call_method(var_product_object, 'get_gallery_image_ids', [
		rt.new_string('edit'),
	])
	mut var_attachments := rt.call_function('array_filter', [
		var_product_image_gallery.clone()])
	mut var_update_meta := rt.new_bool(false)
	mut var_updated_gallery_ids := []rt.PhpVal{}
	if !(!rt.is_true(var_attachments)) {
		rt.call_function('_prime_post_caches', [var_attachments.clone()])
		mut iter_1 := var_attachments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attachment_id := item_1.val
			mut var_attachment := rt.call_function('wp_get_attachment_image', [
				var_attachment_id.clone(),
				rt.new_string('thumbnail'),
			])
			if !rt.is_true(var_attachment) {
				var_update_meta = rt.new_bool(true)
				continue
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_attachment_id.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_attachment)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_attr_e', [rt.new_string('Delete image'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('esc_html_e', [rt.new_string('Delete'),
				rt.new_string('woocommerce')])
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('do_action', [
				rt.new_string('woocommerce_admin_after_product_gallery_item'),
				var_thepostid.clone(),
				var_attachment_id.clone(),
			])
			// unsupported statement: Stmt_InlineHTML
			var_updated_gallery_ids << var_attachment_id.clone()
		}
		if rt.is_true(var_update_meta) {
			rt.call_function('update_post_meta', [rt.get_property(var_post, 'ID'),
				rt.new_string('_product_image_gallery'),
				rt.call_function('implode', [
					rt.new_string(','),
					rt.create_array_from_list(var_updated_gallery_ids),
				])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(','),
			rt.create_array_from_list(var_updated_gallery_ids)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add images to product gallery'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Add to gallery'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Delete image'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Delete'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Add product gallery images'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Meta_Box_Product_Images.save(var_post_id rt.PhpVal, var_post rt.PhpVal) {
	mut iife_temp_0 := Class_WC_Product_Factory{}
	mut iife_result_0 := iife_temp_0.get_product_type(var_post_id.clone())
	mut var_product_type := if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('product-type'))) { iife_result_0 } else { rt.call_function('sanitize_title', [
			rt.call_function('stripslashes', [
				rt.get_superglobal('_POST').array_get(rt.new_string('product-type')),
			]),
		]) }
	mut iife_temp_1 := Class_WC_Product_Factory{}
	mut iife_result_1 := iife_temp_1.get_product_classname(var_post_id.clone(), if rt.is_true(var_product_type) {
		var_product_type
	} else {
		Class_Automattic_WooCommerce_Enums_ProductType.simple()
	})
	mut var_classname := iife_result_1
	mut var_product := rt.create_object_dynamically(var_classname, [
		var_post_id.clone()])
	mut var_attachment_ids := if rt.get_superglobal('_POST').array_isset(rt.new_string('product_image_gallery')) { rt.call_function('array_filter', [
			rt.call_function('explode', [rt.new_string(','),
				rt.call_function('wc_clean', [
					rt.get_superglobal('_POST').array_get(rt.new_string('product_image_gallery')),
				])]),
		]) } else { []rt.PhpVal{} }
	rt.call_method(var_product, 'set_gallery_image_ids', [var_attachment_ids.clone()])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Product_Factory {
	rt.PhpObjectBase
}

fn create_wc_meta_box_product_images(_args ...rt.PhpVal) &Class_WC_Meta_Box_Product_Images {
	mut obj := &Class_WC_Meta_Box_Product_Images{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product(_args ...rt.PhpVal) &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_factory(_args ...rt.PhpVal) &Class_WC_Product_Factory {
	mut obj := &Class_WC_Product_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Product_Images) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Images.output(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Images.save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Product_Images) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Product_Images) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Product_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Meta_Box_Product_Images', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_meta_box_product_images()
		return rt.new_object('WC_Meta_Box_Product_Images', []string{}, obj)
	})
	rt.register_class_factory('WC_Product', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product()
		return rt.new_object('WC_Product', []string{}, obj)
	})
	rt.register_class_factory('WC_Product_Factory', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_factory()
		return rt.new_object('WC_Product_Factory', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
