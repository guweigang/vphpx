import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('product-gallery')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery) render_dialog(var_images rt.PhpVal) rt.PhpVal {
	mut var_images_html := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_images.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_image := item_1.val
			mut var_index := item_1.key
			mut var_id := var_image.array_get('id')
			mut var_src := var_image.array_get('src')
			mut var_srcset := var_image.array_get('srcset')
			mut var_sizes := var_image.array_get('sizes')
			mut var_alt := var_image.array_get('alt')
			mut var_loading := rt.new_string(if rt.is_true(rt.identical(rt.new_int(0), var_index)) { rt.new_string('fetchpriority="high"') } else { rt.new_string('loading="lazy"') })
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Close dialog'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_images_html)
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery) inject_dialog(var_gallery_html rt.PhpVal, var_dialog_html rt.PhpVal) rt.PhpVal {
	mut var_pos := rt.call_function('strrpos', [var_gallery_html.dup(), rt.new_string('</div>')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_html := rt.call_function('substr_replace', [var_gallery_html.dup(), var_dialog_html.dup(), var_pos.dup(), rt.new_int(0)])
		return var_html.dup()
	}
	return var_gallery_html.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_post_id := if !(rt.get_property(var_block, 'context').array_get('postId')).is_null() { rt.get_property(var_block, 'context').array_get('postId') } else { rt.new_string('') }
	mut var_product := rt.call_function('wc_get_product', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product')))))) {
		return ''
	}
	mut var_image_ids := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{}; return temp.get_all_image_ids(arg_0) }(var_product.dup())
	mut var_number_of_images := rt.new_int(rt.new_int(var_image_ids.dup().array_count()))
	mut var_classname := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_by_attributes(arg_0, arg_1) }(var_attributes.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_initial_image_id := if rt.is_true(rt.greater(var_number_of_images, rt.new_int(0))) { var_image_ids.array_get(0) } else { // unsupported expression: Expr_UnaryMinus }
	mut var_classname_single_image := rt.new_string(if rt.is_true(rt.less(var_number_of_images, rt.new_int(2))) { rt.new_string('is-single-product-gallery-image') } else { rt.new_string('') })
	mut var_product_id := rt.new_string(rt.new_string(rt.call_method(var_product, 'get_id', []rt.PhpVal{}).to_string()))
	mut var_fullsize_image_data := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{}; return temp.get_image_src_data(arg_0, arg_1, arg_2) }(var_image_ids.dup(), rt.new_string('full'), rt.call_method(var_product, 'get_title', []rt.PhpVal{}))
	mut var_gallery_with_dialog := this.inject_dialog(var_content.dup(), this.render_dialog(var_fullsize_image_data.dup()))
	mut var_p := create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_gallery_with_dialog.dup())
	mut var_html := var_gallery_with_dialog.dup()
	if rt.is_true(var_p.next_tag()) {
		var_p.set_attribute(rt.new_string('data-wp-interactive'), this.get_full_block_name())
		var_p.set_attribute(rt.new_string('data-wp-context'), rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'imageData', val: var_image_ids }, rt.ArrayItem{ key: 'isDialogOpen', val: false }, rt.ArrayItem{ key: 'isDragging', val: false }, rt.ArrayItem{ key: 'touchStartX', val: 0 }, rt.ArrayItem{ key: 'touchCurrentX', val: 0 }, rt.ArrayItem{ key: 'productId', val: var_product_id }, rt.ArrayItem{ key: 'selectedImageId', val: var_initial_image_id }, rt.ArrayItem{ key: 'thumbnailsOverflow', val: rt.create_array([rt.ArrayItem{ key: 'top', val: false }, rt.ArrayItem{ key: 'bottom', val: false }, rt.ArrayItem{ key: 'left', val: false }, rt.ArrayItem{ key: 'right', val: false }]) }, rt.ArrayItem{ key: 'hideNextPreviousButtons', val: rt.less_equal(var_number_of_images, rt.new_int(1)) }, rt.ArrayItem{ key: 'isDisabledPrevious', val: true }, rt.ArrayItem{ key: 'isDisabledNext', val: false }, rt.ArrayItem{ key: 'ariaLabelPrevious', val: rt.call_function('__', [rt.new_string('Previous image'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'ariaLabelNext', val: rt.call_function('__', [rt.new_string('Next image'), rt.new_string('woocommerce')]) }]), rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')), rt.get_constant('JSON_HEX_AMP'))]))
		if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variable()])) {
			mut var_has_variation_images := rt.new_bool(rt.new_bool(false))
			{
				mut iter_1 := rt.call_method(var_product, 'get_available_variations', [rt.new_string('objects')]).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_variation := item_1.val
					if rt.is_true(// unsupported expression: Expr_Cast_Int) {
						var_has_variation_images = rt.new_bool(rt.new_bool(true))
						break
					}
				}
			}
			if rt.is_true(var_has_variation_images) {
				var_p.set_attribute(rt.new_string('data-wp-init--watch-changes-on-add-to-cart-form'), rt.new_string('callbacks.watchForChangesOnAddToCartForm'))
				var_p.set_attribute(rt.new_string('data-wp-watch'), rt.new_string('callbacks.listenToProductDataChanges'))
			}
		}
		var_p.add_class(var_classname.dup())
		var_p.add_class(var_classname_single_image.dup())
		var_html = var_p.get_updated_html()
	}
	return (var_html).str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productgallery() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('product-gallery')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_productgalleryutils() &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{
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

fn create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'render_dialog' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_dialog(dispatch_arg_0)
		}
		'inject_dialog' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.inject_dialog(dispatch_arg_0, dispatch_arg_1)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGallery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productgallery_php() {
	// unsupported statement: Stmt_Declare
}
