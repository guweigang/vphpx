import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage {
	rt.PhpObjectBase
pub mut:
	block_name  rt.PhpVal = rt.new_string('product-image')
	api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) register_block_type_assets() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'query' },
		rt.ArrayItem{ key: none, val: 'queryId' }, rt.ArrayItem{ key: none, val: 'postId' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) parse_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'showProductLink', val: true },
		rt.ArrayItem{ key: 'imageSizing', val: 'single' },
		rt.ArrayItem{ key: 'productId', val: 'number' },
		rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: 'false' },
		rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: 'false' },
		rt.ArrayItem{ key: 'scale', val: 'cover' },
	])
	return rt.call_function('wp_parse_args', [var_attributes.clone(),
		var_defaults.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) render_on_sale_badge(var_product rt.PhpVal, var_attributes rt.PhpVal) string {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{})))))
		|| !(var_attributes.array_isset(rt.new_string('showSaleBadge')))
		|| (var_attributes.array_isset(rt.new_string('showSaleBadge'))
		&& rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get(rt.new_string('showSaleBadge'))))) {
		return ''
	}
	mut var_align := if !(var_attributes.array_get(rt.new_string('saleBadgeAlign'))).is_null() {
		var_attributes.array_get(rt.new_string('saleBadgeAlign'))
	} else {
		rt.new_string('right')
	}
	mut var_block := create_automattic_woocommerce_blocks_blocktypes_wp_block(rt.create_array([
		rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-sale-badge' },
		rt.ArrayItem{ key: 'attrs', val: rt.create_array([
			rt.ArrayItem{ key: 'align', val: var_align },
		]) },
	]), rt.create_array([
		rt.ArrayItem{ key: 'postId', val: rt.call_method(var_product_mutated, 'get_id',
			[]rt.PhpVal{}) },
	]))
	return (var_block.render()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) render_anchor(var_product rt.PhpVal, var_on_sale_badge rt.PhpVal, var_product_image rt.PhpVal, var_attributes rt.PhpVal, var_inner_blocks_content rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_product_permalink := rt.call_method(var_product_mutated, 'get_permalink', []rt.PhpVal{})
	mut var_is_link := if var_attributes.array_isset(rt.new_string('showProductLink')) {
		var_attributes.array_get(rt.new_string('showProductLink'))
	} else {
		rt.new_bool(true)
	}
	mut var_href_attribute := if rt.is_true(var_is_link) { rt.call_function('sprintf', [
			rt.new_string('href="%s"'),
			rt.call_function('esc_url', [var_product_permalink.clone()]),
		]) } else { rt.new_string('href="#" onclick="return false;"') }
	mut var_wrapper_style := rt.new_string((if rt.is_true(rt.new_bool(!(rt.is_true(var_is_link)))) {
		'pointer-events: none; cursor: default;'
	} else {
		''
	}).str())
	mut var_directive := rt.new_string((if rt.is_true(var_is_link) {
		'data-wp-on--click="woocommerce/product-collection::actions.viewProduct"'
	} else {
		''
	}).str())
	mut var_inner_blocks_container := rt.call_function('sprintf', [
		rt.new_string('<div class="wc-block-components-product-image__inner-container">%s</div>'),
		var_inner_blocks_content.clone(),
	])
	return rt.call_function('sprintf', [
		rt.new_string('<a %1$s style="%2$s" %3$s>%4$s%5$s%6$s</a>'),
		var_href_attribute.clone(),
		rt.call_function('esc_attr', [var_wrapper_style.clone()]),
		var_directive.clone(),
		var_on_sale_badge.clone(),
		var_product_image.clone(),
		var_inner_blocks_container.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) render_image(var_product rt.PhpVal, var_attributes rt.PhpVal, var_image_id rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	mut var_image_id_mutated := var_image_id
	mut var_image_size := rt.new_string((if rt.is_true(rt.identical(rt.new_string('single'),
		var_attributes.array_get(rt.new_string('imageSizing'))))
	{
		'woocommerce_single'
	} else {
		'woocommerce_thumbnail'
	}).str())
	mut var_image_style := rt.new_string('')
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('height')))) {
		var_image_style = rt.concat(var_image_style, rt.call_function('sprintf', [
			rt.new_string('height:%s;'),
			var_attributes.array_get(rt.new_string('height')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('width')))) {
		var_image_style = rt.concat(var_image_style, rt.call_function('sprintf', [
			rt.new_string('width:%s;'),
			var_attributes.array_get(rt.new_string('width')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('scale')))) {
		var_image_style = rt.concat(var_image_style, rt.call_function('sprintf', [
			rt.new_string('object-fit:%s;'),
			var_attributes.array_get(rt.new_string('scale')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('aspectRatio')))) {
		var_image_style = rt.concat(var_image_style, rt.call_function('sprintf', [
			rt.new_string('aspect-ratio:%s;'),
			var_attributes.array_get(rt.new_string('aspectRatio')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('aspectRatio')))) {
		var_image_style = rt.concat(var_image_style, rt.call_function('sprintf', [
			rt.new_string('aspect-ratio:%s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('aspectRatio')),
		]))
	}
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('minHeight')))) {
		var_image_style = rt.concat(var_image_style, rt.call_function('sprintf', [
			rt.new_string('min-height:%s;'),
			var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('minHeight')),
		]))
	}
	mut var_featured_image_id := rt.new_int((rt.call_method(var_product_mutated, 'get_image_id',
		[]rt.PhpVal{})).to_i64())
	mut var_provided_image_id_is_valid := rt.new_bool(false)
	if rt.is_true(var_image_id_mutated) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{}
		mut iife_result_0 := iife_temp_0.get_all_image_ids(var_product_mutated.clone())
		mut var_gallery_image_ids := iife_result_0
		mut var_available_image_ids := rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_featured_image_id }]),
			var_gallery_image_ids.clone(),
		])
		var_provided_image_id_is_valid = rt.call_function('in_array', [
			var_image_id_mutated.clone(), var_available_image_ids.clone(),
			rt.new_bool(true)])
	}
	mut var_target_image_id := if rt.is_true(var_provided_image_id_is_valid) {
		var_image_id_mutated
	} else {
		var_featured_image_id
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_target_image_id)))) {
		return rt.call_function('wc_placeholder_img', [var_image_size.clone(),
			rt.create_array([rt.ArrayItem{ key: 'style', val: var_image_style }])])
	}
	mut var_alt_text := rt.call_function('get_post_meta', [var_target_image_id.clone(),
		rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])
	mut var_loading_attr := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_image_loading_attr'),
		rt.new_string('lazy'),
		var_target_image_id.clone(),
	])
	var_loading_attr = rt.new_string((if var_loading_attr.clone().is_string() {
		var_loading_attr.clone().to_string().trim_space().to_lower()
	} else {
		''
	}).str())
	mut var_allowed_loading := rt.create_array([rt.ArrayItem{ key: none, val: 'lazy' },
		rt.ArrayItem{ key: none, val: 'eager' }, rt.ArrayItem{ key: none, val: 'auto' }])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_loading_attr.clone(), var_allowed_loading.clone(),
		rt.new_bool(true)])))))
	{
		var_loading_attr = rt.new_string('')
	}
	mut var_attr := rt.create_array([
		rt.ArrayItem{
			key: 'alt'
			val: if !rt.is_true(var_alt_text) {
				rt.call_method(var_product_mutated, 'get_title', []rt.PhpVal{})
			} else {
				var_alt_text
			}
		},
		rt.ArrayItem{ key: 'data-testid', val: 'product-image' },
		rt.ArrayItem{ key: 'data-image-id', val: var_target_image_id },
		rt.ArrayItem{ key: 'style', val: var_image_style },
	])
	if !(!rt.is_true(var_loading_attr)) {
		var_attr.array_set('loading', var_loading_attr.clone())
	}
	return if rt.is_true(var_provided_image_id_is_valid) { rt.call_function('wp_get_attachment_image', [
			var_image_id_mutated.clone(),
			var_image_size.clone(),
			rt.new_bool(false),
			var_attr.clone(),
		]) } else { rt.call_method(var_product_mutated, 'get_image', [
			var_image_size.clone(), var_attr.clone()]) }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductImage', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('isBlockTheme'),
		rt.call_function('wp_is_block_theme', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductImage', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [
		rt.new_string('placeholderImgSrcFullSize'),
		rt.call_function('wc_placeholder_img_src', [rt.new_string('woocommerce_single')]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_block_mutated := var_block
	mut var_parsed_attributes := this.parse_attributes(var_attributes.clone())
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_1 := iife_temp_1.get_classes_and_styles_by_attributes(var_attributes.clone(),
		rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_classes_and_styles := iife_result_1
	mut var_post_id := if rt.get_property(var_block_mutated, 'context').array_isset(rt.new_string('postId')) {
		rt.get_property(var_block_mutated, 'context').array_get(rt.new_string('postId'))
	} else {
		rt.new_string('')
	}
	mut var_image_id := if rt.get_property(var_block_mutated, 'context').array_isset(rt.new_string('imageId')) {
		rt.new_int((rt.get_property(var_block_mutated, 'context').array_get(rt.new_string('imageId'))).to_i64())
	} else {
		rt.new_null()
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id.clone()])
	mut var_aspect_ratio := if !(var_parsed_attributes.array_get(rt.new_string('aspectRatio'))).is_null() {
		var_parsed_attributes.array_get(rt.new_string('aspectRatio'))
	} else {
		if !(var_parsed_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('aspectRatio'))).is_null() {
			var_parsed_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('dimensions')).array_get(rt.new_string('aspectRatio'))
		} else {
			rt.new_string('auto')
		}
	}
	mut var_aspect_ratio_class := rt.new_string(
		'wc-block-components-product-image--aspect-ratio-' +(rt.call_function('str_replace', [rt.new_string('/'), rt.new_string('-'), var_aspect_ratio.clone()])).str())
	mut var_classes := rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'wc-block-components-product-image wc-block-grid__product-image'
				},
				rt.ArrayItem{ key: none, val: var_aspect_ratio_class },
				rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [
					var_classes_and_styles.array_get(rt.new_string('classes')),
				]) },
			]),
		])])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('esc_attr', [
				var_classes.clone()]) },
			rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
				var_classes_and_styles.array_get(rt.new_string('styles'))]) },
		]),
	])
	if rt.is_true(var_product) {
		mut var_inner_content := this.render_anchor(var_product.clone(), rt.new_string(this.render_on_sale_badge(var_product.clone(),
			var_parsed_attributes.clone())), this.render_image(var_product.clone(),
			var_parsed_attributes.clone(), var_image_id.clone()), var_attributes.clone(),
			var_content.clone())
		return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
			var_wrapper_attributes.clone(), var_inner_content.clone()])).str()
	}
	return ''
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productimage(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-image')
		api_version:   rt.new_string('3')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_block(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_productgalleryutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductGalleryUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_block_type_assets' {
			return this.register_block_type_assets()
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'parse_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_attributes(dispatch_arg_0)
		}
		'render_on_sale_badge' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.render_on_sale_badge(dispatch_arg_0, dispatch_arg_1))
		}
		'render_anchor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.render_anchor(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'render_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductImage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'api_version' {
			this.api_version = val
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
