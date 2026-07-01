import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-image-gallery')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) enqueue_assets(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(var_attributes.dup(),
		var_content.dup(), var_block.dup())
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_legacy_assets' },
		]),
		rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) enqueue_legacy_assets() {
	mut var_need_single_product_script := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('wc-product-gallery-zoom'),
	]))
	{
		var_need_single_product_script = rt.new_bool(rt.new_bool(true))
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-zoom')])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('wc-product-gallery-slider'),
	]))
	{
		var_need_single_product_script = rt.new_bool(rt.new_bool(true))
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-flexslider')])
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('wc-product-gallery-lightbox'),
	]))
	{
		var_need_single_product_script = rt.new_bool(rt.new_bool(true))
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-photoswipe-ui-default')])
		rt.call_function('wp_enqueue_style', [rt.new_string('photoswipe-default-skin')])
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			rt.call_function('wc_get_template', [
				rt.new_string('single-product/photoswipe.php'),
			])
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('wp_footer'),
			rt.new_closure(closure_1_fn)])
	}
	if rt.is_true(var_need_single_product_script) {
		rt.call_function('wp_enqueue_script', [rt.new_string('wc-single-product')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_post_id := rt.get_property(var_block, 'context').array_get('postId')
	if !(!var_post_id.is_null()) {
		return ''
	}
	// unsupported statement: Stmt_Global
	mut var_previous_product := var_product.dup()
	mut var_product := rt.call_function('wc_get_product', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product'))))))
	{
		var_product = var_previous_product.dup()
		return ''
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_single_product_zoom_enabled'),
		rt.new_string('__return_true'),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_single_product_photoswipe_enabled'),
		rt.new_string('__return_true'),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_single_product_flexslider_enabled'),
		rt.new_string('__return_true'),
	])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_show_product_sale_flash', []rt.PhpVal{})
	mut var_sale_badge_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('woocommerce_show_product_images', []rt.PhpVal{})
	mut var_product_image_gallery_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	var_product = var_previous_product.dup()
	mut var_classname := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_by_attributes(arg_0, arg_1)
	}(var_attributes.dup(), rt.create_array([
		rt.ArrayItem{ key: none, val: 'extra_classes' },
	]))
	return (rt.call_function('sprintf', [
		rt.new_string('<div class="wp-block-woocommerce-product-image-gallery %1$s">%2$s %3$s</div>'),
		rt.call_function('esc_attr', [var_classname.dup()]),
		var_sale_badge_html.dup(),
		var_product_image_gallery_html.dup(),
	])).str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productimagegallery() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-image-gallery')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'enqueue_assets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue_legacy_assets' {
			this.enqueue_legacy_assets()
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImageGallery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productimagegallery_php() {
}
