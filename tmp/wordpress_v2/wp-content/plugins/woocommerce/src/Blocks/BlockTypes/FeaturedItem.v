import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem {
	rt.PhpObjectBase
pub mut:
	block_name                       rt.PhpVal = rt.new_null()
	defaults                         rt.PhpVal = rt.new_array()
	global_style_wrapper             rt.PhpVal = rt.new_array()
	current_item                     rt.PhpVal = rt.new_null()
	featured_item_id                 rt.PhpVal = rt.new_int(0)
	featured_item_inner_blocks_names rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock.initialize()
	rt.call_function('add_filter', [rt.new_string('render_block_context'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_context' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/post-title'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
			], &this) },
			rt.ArrayItem{ key: none, val: 'restore_global_post' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) extract_featured_item_inner_block_names(var_block rt.PhpVal, var_result rt.PhpVal) rt.PhpVal {
	mut var_result_mutated := var_result
	if var_block.array_isset(rt.new_string('blockName')) {
		var_result_mutated.array_push(var_block.array_get(rt.new_string('blockName')))
	}
	if rt.is_true(rt.identical(rt.new_string('woocommerce/product-template'), var_block.array_get(rt.new_string('blockName'))))
		|| rt.is_true(rt.identical(rt.new_string('core/post-template'), var_block.array_get(rt.new_string('blockName')))) {
		return var_result_mutated.clone()
	}
	if var_block.array_isset(rt.new_string('innerBlocks')) {
		mut iter_1 := var_block.array_get(rt.new_string('innerBlocks')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block := item_1.val
			this.extract_featured_item_inner_block_names(var_inner_block.clone(),
				var_result_mutated.clone())
		}
	}
	return var_result_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) replace_post_for_featured_item_inner_block(var_block rt.PhpVal, var_context rt.PhpVal) {
	mut var_context_mutated := var_context
	if rt.is_true(this.featured_item_inner_blocks_names) {
		mut var_block_name := rt.call_function('end', [
			this.featured_item_inner_blocks_names,
		])
		if rt.is_true(rt.identical(var_block_name, var_block.array_get(rt.new_string('blockName')))) {
			rt.call_function('array_pop', [this.featured_item_inner_blocks_names])
			if rt.is_true(rt.identical(rt.new_string('core/post-excerpt'), var_block_name))
				|| rt.is_true(rt.identical(rt.new_string('core/post-title'), var_block_name)) {
				mut var_post := rt.get_superglobal('post')
				var_post = rt.call_function('get_post', [this.featured_item_id])
				if rt.is_true(rt.new_bool(rt.instance_of(var_post,
					'Automattic_WooCommerce_Blocks_BlockTypes_WP_Post')))
				{
					rt.call_function('setup_postdata', [var_post.clone()])
				}
			}
			var_context_mutated.array_set('postId', this.featured_item_id)
			var_context_mutated.array_set('postType', 'product')
			this.current_item = rt.call_function('wc_get_product', [this.featured_item_id])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) update_context(var_context rt.PhpVal, var_parsed_block rt.PhpVal, var_parent_block rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	if rt.is_true(rt.identical(rt.new_string('woocommerce/featured-product'), var_parsed_block.array_get(rt.new_string('blockName'))))
		|| rt.is_true(rt.identical(rt.new_string('woocommerce/featured-category'), var_parsed_block.array_get(rt.new_string('blockName'))))
		&& var_parsed_block.array_isset(rt.new_string('attrs')) {
		mut var_item := this.get_item(var_parsed_block.array_get(rt.new_string('attrs')))
		if rt.is_true(rt.new_bool(rt.instance_of(var_item,
			'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product')))
		{
			this.featured_item_id = rt.call_method(var_item, 'get_id', []rt.PhpVal{})
			this.featured_item_inner_blocks_names = rt.call_function('array_reverse', [
				this.extract_featured_item_inner_block_names(var_parsed_block.clone(),
					rt.new_null()),
			])
		}
	}
	this.replace_post_for_featured_item_inner_block(var_parsed_block.clone(),
		var_context_mutated.clone())
	return var_context_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) restore_global_post(var_block_content rt.PhpVal, var_parsed_block rt.PhpVal, var_block_instance rt.PhpVal) rt.PhpVal {
	if rt.is_true(this.current_item) {
		rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	}
	return var_block_content.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) get_item(var_attributes rt.PhpVal) {
	mut var_attributes_mutated := var_attributes
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) get_item_title(var_item rt.PhpVal) {
	mut var_item_mutated := var_item
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) get_item_image(var_item rt.PhpVal, size string) {
	mut var_item_mutated := var_item
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) render_attributes(var_item rt.PhpVal, var_attributes rt.PhpVal) {
	mut var_item_mutated := var_item
	mut var_attributes_mutated := var_attributes
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_attributes_mutated := var_attributes
	mut var_content_mutated := var_content
	mut var_item := this.get_item(var_attributes_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_item)))) {
		return ''
	}
	mut var_aria_label := if !(var_attributes_mutated.array_get(rt.new_string('ariaLabel'))).is_null() {
		var_attributes_mutated.array_get(rt.new_string('ariaLabel'))
	} else {
		rt.new_string('')
	}
	var_attributes_mutated = rt.call_function('wp_parse_args', [
		var_attributes_mutated.clone(), this.defaults])
	var_attributes_mutated.array_set('height', if !(var_attributes_mutated.array_get(rt.new_string('height'))).is_null() { var_attributes_mutated.array_get(rt.new_string('height')) } else { rt.call_function('wc_get_theme_support', [
			rt.new_string('featured_block::default_height'),
			rt.new_int(500),
		]) })
	mut var_image_url := rt.call_function('esc_url', [
		this.get_image_url(var_attributes_mutated.clone(), var_item.clone()),
	])
	mut var_styles := this.get_styles(var_attributes_mutated.clone())
	mut var_classes := this.get_classes(var_attributes_mutated.clone())
	mut var_output := rt.call_function('sprintf', [
		rt.new_string('<div class="%1$s wp-block-woocommerce-%2$s" style="%3$s">'),
		rt.call_function('esc_attr', [
			rt.new_string(var_classes.clone().to_string().trim_space()),
		]),
		this.block_name,
		rt.call_function('esc_attr', [
			var_styles.clone(),
		]),
	])
	var_output = rt.concat(var_output, rt.call_function('sprintf', [
		rt.new_string('<div class="wc-block-%s__wrapper">'),
		this.block_name,
	]))
	var_output = rt.concat(var_output, this.render_overlay(var_attributes_mutated.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes_mutated.array_get(rt.new_string('isRepeated'))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_attributes_mutated.array_get(rt.new_string('hasParallax')))))) {
		var_output = rt.concat(var_output, this.render_image(var_attributes_mutated.clone(),
			var_item.clone(), var_image_url.str()))
	} else {
		var_output = rt.concat(var_output, this.render_bg_image(var_attributes_mutated.clone(),
			var_image_url.clone()))
	}
	if !var_aria_label.is_null() && !(!rt.is_true(var_aria_label)) {
		mut var_p :=
			create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_content_mutated.clone())
		if rt.is_true(var_p.next_tag(rt.new_string('a'), rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'wp-block-button__link' },
		])))
		{
			var_p.set_attribute(rt.new_string('aria-label'), var_aria_label.clone())
			var_content_mutated = var_p.get_updated_html()
		}
	}
	var_output = rt.concat(var_output, this.render_attributes(var_item.clone(),
		var_attributes_mutated.clone()))
	if !(!rt.is_true(var_content_mutated)) {
		var_output = rt.concat(var_output, rt.call_function('sprintf', [
			rt.new_string('<div class="wc-block-%s__inner-blocks">%s</div>'),
			this.block_name,
			var_content_mutated.clone(),
		]))
	}
	var_output = rt.concat(var_output, rt.new_string('</div>'))
	var_output = rt.concat(var_output, rt.new_string('</div>'))
	return var_output.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) get_image_url(var_attributes rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_item_mutated := var_item
	mut var_image_size := rt.new_string('large')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('none'), var_attributes_mutated.array_get(rt.new_string('align'))))))
		|| rt.is_true(rt.greater(var_attributes_mutated.array_get(rt.new_string('height')), rt.new_int(800))) {
		var_image_size = rt.new_string('full')
	}
	if rt.is_true(var_attributes_mutated.array_get(rt.new_string('mediaId'))) {
		return rt.call_function('wp_get_attachment_image_url', [
			var_attributes_mutated.array_get(rt.new_string('mediaId')),
			var_image_size.clone(),
		])
	}
	this.get_item_image(var_item_mutated.clone(), var_image_size.str())
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) render_bg_image(var_attributes rt.PhpVal, var_image_url rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_image_url_mutated := var_image_url
	mut var_styles := this.get_bg_styles(var_attributes_mutated.clone(),
		var_image_url_mutated.clone())
	mut var_classes := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.concat(rt.concat(rt.new_string('wc-block-'),
			this.block_name), rt.new_string('__background-image')) },
	])
	if rt.is_true(var_attributes_mutated.array_get(rt.new_string('hasParallax'))) {
		var_classes.array_push(' has-parallax')
	}
	return rt.call_function('sprintf', [
		rt.new_string('<div class="%1$s" style="%2$s" /></div>'),
		rt.call_function('esc_attr', [
			rt.call_function('implode', [rt.new_string(' '), var_classes.clone()]),
		]),
		rt.call_function('esc_attr', [
			var_styles.clone(),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) get_bg_styles(var_attributes rt.PhpVal, var_image_url rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_image_url_mutated := var_image_url
	mut var_style := rt.new_string('')
	if rt.is_true(var_attributes_mutated.array_get(rt.new_string('isRepeated')))
		|| rt.is_true(var_attributes_mutated.array_get(rt.new_string('hasParallax'))) {
		var_style = rt.concat(var_style,
			rt.new_string('background-image: url(${var_image_url.to_string()});'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes_mutated.array_get(rt.new_string('isRepeated')))))) {
		var_style = rt.concat(var_style, rt.new_string('background-repeat: no-repeat;'))
		mut var_bg_size := if rt.is_true(rt.identical(rt.new_string('cover'),
			var_attributes_mutated.array_get(rt.new_string('imageFit'))))
		{
			var_attributes_mutated.array_get(rt.new_string('imageFit'))
		} else {
			rt.new_string('auto')
		}
		var_style = rt.concat(var_style,
			rt.new_string('background-size: ' + var_bg_size.str() + ';'))
	}
	if this.hasfocalpoint(var_attributes_mutated.clone()) {
		var_style = rt.concat(var_style, rt.call_function('sprintf', [
			rt.new_string('background-position: %s%% %s%%;'),
			rt.mul(var_attributes_mutated.array_get(rt.new_string('focalPoint')).array_get(rt.new_string('x')),
				rt.new_int(100)),
			rt.mul(var_attributes_mutated.array_get(rt.new_string('focalPoint')).array_get(rt.new_string('y')),
				rt.new_int(100)),
		]))
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_0 := iife_temp_0.get_styles_by_attributes(var_attributes_mutated.clone(),
		this.global_style_wrapper)
	mut var_global_style_style := iife_result_0
	var_style = rt.concat(var_style, var_global_style_style)
	return var_style.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) render_image(var_attributes rt.PhpVal, var_item rt.PhpVal, image_url string) string {
	mut var_attributes_mutated := var_attributes
	mut var_item_mutated := var_item
	mut image_url_mutated := image_url
	mut var_style := rt.call_function('sprintf', [rt.new_string('object-fit: %s;'),
		rt.call_function('esc_attr', [var_attributes_mutated.array_get(rt.new_string('imageFit'))])])
	mut var_img_alt := if rt.is_true(var_attributes_mutated.array_get(rt.new_string('alt'))) {
		var_attributes_mutated.array_get(rt.new_string('alt'))
	} else {
		this.get_item_title(var_item_mutated.clone())
	}
	if this.hasfocalpoint(var_attributes_mutated.clone()) {
		var_style = rt.concat(var_style, rt.call_function('sprintf', [
			rt.new_string('object-position: %s%% %s%%;'),
			rt.mul(var_attributes_mutated.array_get(rt.new_string('focalPoint')).array_get(rt.new_string('x')),
				rt.new_int(100)),
			rt.mul(var_attributes_mutated.array_get(rt.new_string('focalPoint')).array_get(rt.new_string('y')),
				rt.new_int(100)),
		]))
	}
	if !(image_url_mutated == '') {
		return (rt.call_function('sprintf', [
			rt.new_string('<img alt="%1$s" class="wc-block-%2$s__background-image" src="%3$s" style="%4$s" />'),
			rt.call_function('esc_attr', [var_img_alt.clone()]),
			this.block_name,
			rt.call_function('esc_url', [rt.new_string(image_url_mutated).clone()]),
			rt.call_function('esc_attr', [var_style.clone()]),
		])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) get_styles(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_style := rt.new_string('')
	mut var_min_height := if !(var_attributes_mutated.array_get(rt.new_string('minHeight'))).is_null() { var_attributes_mutated.array_get(rt.new_string('minHeight')) } else { rt.call_function('wc_get_theme_support', [
			rt.new_string('featured_block::default_height'),
			rt.new_int(500),
		]) }
	if var_attributes_mutated.array_isset(rt.new_string('minHeight')) {
		var_style = rt.concat(var_style, rt.call_function('sprintf', [
			rt.new_string('min-height:%dpx;'),
			rt.new_int(var_min_height.clone().to_i64()),
		]))
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_1 := iife_temp_1.get_styles_by_attributes(var_attributes_mutated.clone(),
		this.global_style_wrapper)
	mut var_global_style_style := iife_result_1
	var_style = rt.concat(var_style, var_global_style_style)
	return var_style.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) get_classes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_classes := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wc-block-' + (this.block_name).str() },
	])
	if var_attributes_mutated.array_isset(rt.new_string('align')) {
		var_classes.array_push(rt.concat(rt.new_string('align'),
			var_attributes_mutated.array_get(rt.new_string('align'))))
	}
	if var_attributes_mutated.array_isset(rt.new_string('dimRatio'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_attributes_mutated.array_get(rt.new_string('dimRatio')))))) {
		var_classes.array_push('has-background-dim')
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(50),
			var_attributes_mutated.array_get(rt.new_string('dimRatio'))))))
		{
			var_classes.array_push('has-background-dim-' +(rt.mul(rt.new_int(10), rt.call_function('round', [rt.div(var_attributes_mutated.array_get(rt.new_string('dimRatio')), rt.new_int(10))]))).str())
		}
	}
	if var_attributes_mutated.array_isset(rt.new_string('contentAlign'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('center'), var_attributes_mutated.array_get(rt.new_string('contentAlign')))))) {
		var_classes.array_push(rt.concat(rt.concat(rt.new_string('has-'),
			var_attributes_mutated.array_get(rt.new_string('contentAlign'))),
			rt.new_string('-content')))
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_2 := iife_temp_2.get_classes_by_attributes(var_attributes_mutated.clone(),
		this.global_style_wrapper)
	mut var_global_style_classes := iife_result_2
	var_classes.array_push(var_global_style_classes.clone())
	return rt.call_function('implode', [rt.new_string(' '), var_classes.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) render_overlay(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if var_attributes_mutated.array_isset(rt.new_string('overlayGradient')) {
		mut var_overlay_styles := rt.call_function('sprintf', [
			rt.new_string('background-image: %s'),
			var_attributes_mutated.array_get(rt.new_string('overlayGradient')),
		])
	} else if var_attributes_mutated.array_isset(rt.new_string('overlayColor')) {
		var_overlay_styles = rt.call_function('sprintf', [
			rt.new_string('background-color: %s'),
			var_attributes_mutated.array_get(rt.new_string('overlayColor')),
		])
	} else {
		var_overlay_styles = rt.new_string('background-color: #000000')
	}
	return rt.call_function('sprintf', [
		rt.new_string('<div class="background-dim__overlay" style="%s"></div>'),
		rt.call_function('esc_attr', [var_overlay_styles.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) hasfocalpoint(var_attributes rt.PhpVal) bool {
	mut var_attributes_mutated := var_attributes
	return var_attributes_mutated.array_get(rt.new_string('focalPoint')).is_array()
		&& 2 == var_attributes_mutated.array_get(rt.new_string('focalPoint')).array_count()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	mut var_attributes_mutated := var_attributes
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes_mutated))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultHeight'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('featured_block::default_height'),
			rt.new_int(500),
		])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_featureditem(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem{
		PhpObjectBase:                    rt.PhpObjectBase{}
		block_name:                       rt.new_null()
		defaults:                         rt.new_array()
		global_style_wrapper:             rt.new_array()
		current_item:                     rt.new_null()
		featured_item_id:                 rt.new_int(0)
		featured_item_inner_blocks_names: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractdynamicblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'extract_featured_item_inner_block_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.extract_featured_item_inner_block_names(dispatch_arg_0, dispatch_arg_1)
		}
		'replace_post_for_featured_item_inner_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.replace_post_for_featured_item_inner_block(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.update_context(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'restore_global_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.restore_global_post(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_item(dispatch_arg_0)
			return rt.new_null()
		}
		'get_item_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_item_title(dispatch_arg_0)
			return rt.new_null()
		}
		'get_item_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.get_item_image(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'render_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.render_attributes(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_image_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_image_url(dispatch_arg_0, dispatch_arg_1)
		}
		'render_bg_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.render_bg_image(dispatch_arg_0, dispatch_arg_1)
		}
		'get_bg_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_bg_styles(dispatch_arg_0, dispatch_arg_1)
		}
		'render_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(this.render_image(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_styles(dispatch_arg_0)
		}
		'get_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_classes(dispatch_arg_0)
		}
		'render_overlay' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_overlay(dispatch_arg_0)
		}
		'hasFocalPoint' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.hasfocalpoint(dispatch_arg_0))
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'defaults' { return this.defaults }
		'global_style_wrapper' { return this.global_style_wrapper }
		'current_item' { return this.current_item }
		'featured_item_id' { return this.featured_item_id }
		'featured_item_inner_blocks_names' { return this.featured_item_inner_blocks_names }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_FeaturedItem) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'defaults' {
			this.defaults = val
			return true
		}
		'global_style_wrapper' {
			this.global_style_wrapper = val
			return true
		}
		'current_item' {
			this.current_item = val
			return true
		}
		'featured_item_id' {
			this.featured_item_id = val
			return true
		}
		'featured_item_inner_blocks_names' {
			this.featured_item_inner_blocks_names = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
