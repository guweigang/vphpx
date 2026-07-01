import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-gallery-large-image')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'postId' },
		rt.ArrayItem{ key: none, val: 'hoverZoom' }, rt.ArrayItem{
			key: none
			val: 'fullScreenOnClick'
		}])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) initialize() {
	rt.call_function('add_filter', [rt.new_string('block_type_metadata_settings'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_block_type_metadata_settings' },
		]),
		rt.new_int(10), rt.new_int(2)])
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) enqueue_assets(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array, var_content rt.PhpVal, var_block rt.PhpVal) {
	if !(!rt.is_true(rt.get_property(var_block, 'context').array_get('hoverZoom')))
		|| !(!rt.is_true(rt.get_property(var_block, 'context').array_get('fullScreenOnClick'))) {
		this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
			[]string{}, var_attributes), var_content.dup(), var_block.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
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
	mut var_images_html := rt.new_string(rt.new_string(''))
	mut var_inner_blocks_html := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := rt.get_property(var_block, 'inner_blocks').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			if rt.is_true(rt.identical(rt.new_string('woocommerce/product-image'), rt.get_property(var_inner_block,
				'name')))
			{
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				if rt.is_true(rt.identical(rt.new_string('woocommerce/product-gallery-large-image-next-previous'), rt.get_property(var_inner_block,
					'name')))
				{
					mut var_product_gallery_image_count := fn (arg_0 rt.PhpVal) rt.PhpVal {
						mut temp := Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{}
						return temp.get_product_gallery_image_count(arg_0)
					}(var_product.dup())
					if rt.is_true(rt.less_equal(var_product_gallery_image_count, rt.new_int(1))) {
						continue
					}
				}
				mut var_inner_block_html := rt.call_method(create_wp_block(rt.get_property(var_inner_block,
					'parsed_block'), rt.call_function('array_merge', [
					rt.cast_array(rt.get_property(var_block, 'context')),
					rt.create_array([
						rt.ArrayItem{ key: 'iapi/provider', val: 'woocommerce/product-gallery' },
					]),
				])), 'render', [
					rt.create_array([rt.ArrayItem{ key: 'dynamic', val: true }]),
				])
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_images_html)
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_inner_blocks_html)
	// unsupported statement: Stmt_InlineHTML
	mut var_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return var_html.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) update_single_image(var_image_html rt.PhpVal, var_context rt.PhpVal, var_index rt.PhpVal) rt.PhpVal {
	mut var_image_html_mutated := var_image_html
	mut var_p :=
		create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_image_html_mutated.dup())
	if rt.is_true(var_p.next_tag(rt.new_string('a'))) {
		var_p.remove_attribute(rt.new_string('onclick'))
		var_p.remove_attribute(rt.new_string('style'))
		var_p.set_attribute(rt.new_string('tabindex'), rt.new_string('-1'))
	} else {
		var_p =
			create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_image_html_mutated.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_p.next_tag(rt.new_string('img')))))) {
		return var_image_html_mutated.dup()
	}
	var_p.set_attribute(rt.new_string('tabindex'), rt.new_string('-1'))
	var_p.set_attribute(rt.new_string('draggable'), rt.new_string('false'))
	var_p.set_attribute(rt.new_string('data-wp-on--click'), rt.new_string('actions.onViewerClick'))
	var_p.set_attribute(rt.new_string('data-wp-on--touchstart'),
		rt.new_string('actions.onTouchStart'))
	var_p.set_attribute(rt.new_string('data-wp-on--touchmove'),
		rt.new_string('actions.onTouchMove'))
	var_p.set_attribute(rt.new_string('data-wp-on--touchend'), rt.new_string('actions.onTouchEnd'))
	if rt.is_true(rt.identical(rt.new_int(0), var_index)) {
		var_p.set_attribute(rt.new_string('fetchpriority'), rt.new_string('high'))
		var_p.set_attribute(rt.new_string('loading'), rt.new_string('eager'))
	} else {
		var_p.set_attribute(rt.new_string('fetchpriority'), rt.new_string('low'))
		var_p.set_attribute(rt.new_string('loading'), rt.new_string('lazy'))
	}
	mut var_img_classes :=
		rt.new_string(rt.new_string('wc-block-woocommerce-product-gallery-large-image__image'))
	if !(!rt.is_true(var_context.array_get('fullScreenOnClick'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_p.set_attribute(rt.new_string('data-wp-on--click'), rt.new_string('actions.openDialog'))
	}
	if !(!rt.is_true(var_context.array_get('hoverZoom'))) {
		// unsupported expression: Expr_AssignOp_Concat
		var_p.set_attribute(rt.new_string('data-wp-on--mousemove'),
			rt.new_string('actions.startZoom'))
		var_p.set_attribute(rt.new_string('data-wp-on--mouseleave'),
			rt.new_string('actions.resetZoom'))
	}
	var_p.add_class(var_img_classes.dup())
	return var_p.get_updated_html()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) get_main_images_html(var_context rt.PhpVal, var_product rt.PhpVal, var_inner_block rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_image_data := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{}
		return temp.get_product_gallery_image_data(arg_0, arg_1)
	}(var_product_mutated.dup(), rt.new_string('woocommerce_single'))
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Product gallery'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_image_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_image := item_1.val
			mut var_index := item_1.key
			// unsupported statement: Stmt_InlineHTML
			mut var_image_html := rt.call_method(create_wp_block(rt.get_property(var_inner_block,
				'parsed_block'), rt.call_function('array_merge', [
				var_context.dup(),
				rt.create_array([
					rt.ArrayItem{ key: 'imageId', val: var_image.array_get('id') },
				])])),
				'render', [rt.create_array([rt.ArrayItem{ key: 'dynamic', val: true }])])
			rt.echo_val(this.update_single_image(var_image_html.dup(), var_context.dup(),
				var_index.dup()))
			// unsupported statement: Stmt_Nop
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_template := rt.call_function('ob_get_clean', []rt.PhpVal{})
	return rt.call_function('wp_interactivity_process_directives', [
		var_template.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) get_block_type_editor_style() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) add_block_type_metadata_settings(var_settings rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_metadata.array_get('name')))
		&& rt.is_true(rt.identical(rt.new_string('woocommerce/product-gallery-large-image'), var_metadata.array_get('name')))))
	{
		var_settings_mutated.array_set('skip_inner_blocks', true)
	}
	return var_settings_mutated.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productgallerylargeimage() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-gallery-large-image')
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

fn create_wp_block() &Class_WP_Block {
	mut obj := &Class_WP_Block{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'enqueue_assets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'update_single_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_single_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_main_images_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_main_images_html(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_block_type_editor_style' {
			return this.get_block_type_editor_style()
		}
		'add_block_type_metadata_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_block_type_metadata_settings(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductGalleryLargeImage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productgallerylargeimage_php() {
	// unsupported statement: Stmt_Declare
}
