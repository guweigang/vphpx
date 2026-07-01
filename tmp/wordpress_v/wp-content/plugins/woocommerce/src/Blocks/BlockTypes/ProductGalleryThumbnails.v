import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-gallery-thumbnails')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(!(rt.get_property(var_block, 'context')).is_null()) {
		return ''
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
		return temp.get_classes_and_styles_by_attributes(arg_0)
	}(var_attributes.dup())
	mut var_post_id := rt.get_property(var_block, 'context').array_get('postId')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return ''
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product,
		'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product'))))))
	{
		return ''
	}
	mut var_image_size := rt.new_string(if rt.is_true(rt.identical(rt.new_string('1'),
		var_attributes.array_get('aspectRatio')))
	{
		rt.new_string('woocommerce_thumbnail')
	} else {
		rt.new_string('woocommerce_single')
	})
	mut var_product_gallery_images := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{}
		return temp.get_product_gallery_image_data(arg_0, arg_1)
	}(var_product.dup(), var_image_size.dup())
	if var_product_gallery_images.dup().array_count() <= 1 {
		return ''
	}
	mut var_thumbnail_size := rt.call_function('str_replace', [
		rt.new_string('%'), rt.new_string(''), if !(var_attributes.array_get('thumbnailSize')).is_null() {
			var_attributes.array_get('thumbnailSize')
		} else {
			rt.new_string('25%')
		}])
	mut var_active_thumbnail_style := if !(var_attributes.array_get('activeThumbnailStyle')).is_null() {
		var_attributes.array_get('activeThumbnailStyle')
	} else {
		rt.new_string('overlay')
	}
	mut var_img_class :=
		rt.new_string(rt.new_string('wc-block-product-gallery-thumbnails__thumbnail__image'))
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_active_thumbnail_style.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')]))
	// unsupported statement: Stmt_InlineHTML
	print('--wc-block-product-gallery-thumbnails-size:' +
		(rt.call_function('absint', [var_thumbnail_size.dup()])).str() + ';' +
		(rt.call_function('esc_attr', [var_classes_and_styles.array_get('styles')])).str())
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_product_gallery_images.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_image := item_1.val
			mut var_index := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(if rt.is_true(rt.identical(rt.new_int(0), var_index)) { rt.call_function('esc_attr', [
					var_img_class.str() + ' wc-block-product-gallery-thumbnails__thumbnail__image--is-active',
				]) } else { rt.call_function('esc_attr', [var_img_class.dup()]) })
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_image.array_get('id')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_image.array_get('src')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_image.array_get('srcset')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_image.array_get('sizes')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_image.array_get('alt')]))
			// unsupported statement: Stmt_InlineHTML
			print(if rt.is_true(rt.identical(rt.new_int(0), var_index)) { '0' } else { '-1' })
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_attributes.array_get('aspectRatio')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_template := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return var_template.str()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productgallerythumbnails() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-gallery-thumbnails')
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

fn create_automattic_woocommerce_blocks_utils_productgalleryutils() &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryThumbnails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productgallerythumbnails_php() {
	// unsupported statement: Stmt_Declare
}
