import rt

fn block_core_gallery_data_id_backcompatibility(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_inner_block := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('core/gallery'),
		var_parsed_block.array_get(rt.new_string('blockName'))))
	{
		mut iter_1 := var_parsed_block.array_get(rt.new_string('innerBlocks')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_inner_block_shadow := item_1.val
			mut var_key_shadow := item_1.key
			if rt.is_true(rt.identical(rt.new_string('core/image'),
				var_inner_block_shadow['blockName']))
			{
				if !(var_parsed_block.array_get(rt.new_string('innerBlocks')).array_get(var_key_shadow).array_get(rt.new_string('attrs')).array_isset(rt.new_string('data-id')))
					&& var_inner_block_shadow['attrs'].array_isset(rt.new_string('id')) {
					var_parsed_block.array_get_mut('innerBlocks').array_get_mut(var_key_shadow).array_get_mut('attrs').array_set('data-id', rt.call_function('esc_attr', [
						var_inner_block_shadow['attrs'].array_get(rt.new_string('id')),
					]))
				}
			}
		}
	}
	return var_parsed_block.clone()
}

fn block_core_gallery_render_context(var_context rt.PhpVal, var_parsed_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('core/gallery'),
		var_parsed_block.array_get(rt.new_string('blockName'))))
	{
		var_context['galleryId'] = rt.call_function('uniqid', []rt.PhpVal{})
	}
	return var_context.clone()
}

fn block_core_gallery_render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_gap := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_index_to_splice := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_unique_gallery_classname := rt.new_null()
	mut var_processed_content := rt.new_null()
	mut var_fallback_gap := ''
	mut var_gap_value := rt.new_null()
	mut var_gap_column := rt.new_null()
	mut var_gap_row := rt.new_null()
	mut var_gallery_styles := []rt.PhpVal{}
	mut var_updated_content := rt.new_null()
	mut var_pattern := ''
	mut var_image_blocks := rt.new_null()
	mut var_i := i64(0)
	mut var_state := rt.new_null()
	mut var_gallery_id := rt.new_null()
	mut var_image_ids := []rt.PhpVal{}
	mut var_metadata := map[string]rt.PhpVal{}
	mut var_image_id := rt.new_null()
	mut var_total := i64(0)
	mut var_lightbox_index := i64(0)
	mut var_processor := rt.new_null()
	mut var_wp_key := rt.new_null()
	mut var_alt := rt.new_null()
	var_gap = if !(var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))).is_null() {
		var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(var_gap.clone().is_array())) {
		mut iter_2 := var_gap.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value_shadow := item_2.val
			mut var_key_shadow := item_2.key
			var_value_shadow = if var_value_shadow.clone().is_string() {
				var_value_shadow
			} else {
				rt.new_string('')
			}
			var_value_shadow = if rt.is_true(var_value_shadow)
				&& rt.is_true(rt.call_function('preg_match', [rt.new_string('%[\\\\(&=}]|/\\*%'), var_value_shadow.clone()])) {
				rt.new_null()
			} else {
				var_value_shadow
			}
			if var_value_shadow.clone().is_string()
				&& rt.is_true(rt.call_function('str_contains', [var_value_shadow.clone(), rt.new_string('var:preset|spacing|')])) {
				var_index_to_splice = rt.add(rt.call_function('strrpos', [
					var_value_shadow.clone(), rt.new_string('|')]), rt.new_int(1))
				var_slug = rt.call_function('_wp_to_kebab_case', [
					rt.call_function('substr', [var_value_shadow.clone(),
						var_index_to_splice.clone()]),
				])
				var_value_shadow =
					rt.new_string('var(--wp--preset--spacing--${var_slug.to_string()})')
			}
			var_gap.array_set(var_key_shadow, var_value_shadow.clone())
		}
	} else {
		var_gap = if var_gap.clone().is_string() { var_gap } else { rt.new_string('') }
		var_gap = if rt.is_true(var_gap)
			&& rt.is_true(rt.call_function('preg_match', [rt.new_string('%[\\\\(&=}]|/\\*%'), var_gap.clone()])) {
			rt.new_null()
		} else {
			var_gap
		}
		if var_gap.clone().is_string()
			&& rt.is_true(rt.call_function('str_contains', [var_gap.clone(), rt.new_string('var:preset|spacing|')])) {
			var_index_to_splice = rt.add(rt.call_function('strrpos', [
				var_gap.clone(), rt.new_string('|')]), rt.new_int(1))
			var_slug = rt.call_function('_wp_to_kebab_case', [
				rt.call_function('substr', [var_gap.clone(), var_index_to_splice.clone()]),
			])
			var_gap = rt.new_string('var(--wp--preset--spacing--${var_slug.to_string()})')
		}
	}
	var_unique_gallery_classname = rt.call_function('wp_unique_id', [
		rt.new_string('wp-block-gallery-'),
	])
	var_processed_content = create_wp_html_tag_processor(var_content.clone())
	var_processed_content.next_tag()
	var_processed_content.add_class(var_unique_gallery_classname.clone())
	var_fallback_gap = 'var( --wp--style--gallery-gap-default, var( --gallery-block--gutter-size, var( --wp--style--block-gap, 0.5em ) ) )'
	var_gap_value = if rt.is_true(var_gap) { var_gap } else { rt.new_string(var_fallback_gap.str()) }
	var_gap_column = var_gap_value.clone()
	if rt.is_true(rt.new_bool(var_gap_value.clone().is_array())) {
		var_gap_row = if !(var_gap_value.array_get(rt.new_string('top'))).is_null() {
			var_gap_value.array_get(rt.new_string('top'))
		} else {
			rt.new_string(var_fallback_gap.str())
		}
		var_gap_column = if !(var_gap_value.array_get(rt.new_string('left'))).is_null() {
			var_gap_value.array_get(rt.new_string('left'))
		} else {
			rt.new_string(var_fallback_gap.str())
		}
		var_gap_value = if rt.is_true(rt.identical(var_gap_row, var_gap_column)) {
			var_gap_row
		} else {
			var_gap_row.str() + ' ' + var_gap_column.str()
		}
	}
	if rt.is_true(rt.identical(rt.new_string('0'), var_gap_column)) {
		var_gap_column = rt.new_string('0px')
	}
	var_gallery_styles = [
		[rt.new_string('.wp-block-gallery.${var_unique_gallery_classname.to_string()}'),
			[var_gap_column, var_gap_value]],
	]
	rt.call_function('wp_style_engine_get_stylesheet_from_css_rules', [
		rt.create_array_from_list(var_gallery_styles),
		rt.create_array([rt.ArrayItem{ key: 'context', val: 'block-supports' }]),
	])
	var_updated_content = var_processed_content.get_updated_html()
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('randomOrder')))) {
		var_pattern = '/<figure[^>]*\\bwp-block-image\\b[^>]*>.*?<\\/figure>/s'
		rt.call_function('preg_match_all', [rt.new_string(var_pattern.str()).clone(),
			var_updated_content.clone(), rt.create_array_from_list(var_matches)])
		if rt.is_true(var_matches) {
			var_image_blocks = var_matches[0]
			rt.call_function('shuffle', [var_image_blocks.clone()])
			var_i = 0
			closure_1_fn := fn [var_image_blocks, mut var_i] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				return var_image_blocks.array_get(rt.post_inc(rt.new_int(var_i)))
			}
			var_updated_content = rt.call_function('preg_replace_callback', [
				rt.new_string(var_pattern.str()).clone(), rt.new_closure(closure_1_fn),
				var_updated_content.clone()])
		}
	}
	var_state = rt.call_function('wp_interactivity_state', [rt.new_string('core/image')])
	var_gallery_id = if !(rt.get_property(var_block, 'context').array_get(rt.new_string('galleryId'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('galleryId'))
	} else {
		rt.new_null()
	}
	var_image_ids = []rt.PhpVal{}
	if !var_gallery_id.is_null() && var_state.array_isset(rt.new_string('metadata')) {
		mut iter_3 := var_state.array_get(rt.new_string('metadata')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_metadata_shadow := item_3.val
			mut var_image_id_shadow := item_3.key
			if var_metadata_shadow.array_isset(rt.new_string('galleryId'))
				&& rt.is_true(rt.identical(var_metadata_shadow['galleryId'], var_gallery_id)) {
				var_image_ids << var_image_id_shadow.clone()
			}
		}
	}
	if !(!rt.is_true(var_image_ids)) {
		var_total = var_image_ids.len
		var_lightbox_index = 0
		var_processor = create_wp_html_tag_processor(var_updated_content.clone())
		var_processor.next_tag()
		var_processor.set_attribute(rt.new_string('data-wp-interactive'),
			rt.new_string('core/gallery'))
		var_processor.set_attribute(rt.new_string('data-wp-context'), rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'galleryId', val: var_gallery_id }]),
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
				rt.get_constant('JSON_HEX_AMP')),
		]))
		for rt.is_true(var_processor.next_tag(rt.new_string('figure'))) {
			var_wp_key = var_processor.get_attribute(rt.new_string('data-wp-key'))
			if rt.is_true(var_wp_key)
				&& var_state.array_get(rt.new_string('metadata')).array_isset(var_wp_key) {
				var_alt =
					var_state.array_get(rt.new_string('metadata')).array_get(var_wp_key).array_get(rt.new_string('alt'))
				rt.call_function('wp_interactivity_state', [rt.new_string('core/image'),
					rt.create_array([
						rt.ArrayItem{ key: 'metadata', val: rt.create_array([
							rt.ArrayItem{ key: var_wp_key, val: rt.create_array([
								rt.ArrayItem{
									key: 'customAriaLabel'
									val: if !rt.is_true(var_alt) { rt.call_function('sprintf', [
											rt.call_function('__', [
												rt.new_string('Enlarged image %1$s of %2$s'),
											]),
											rt.new_int(var_lightbox_index + 1),
											rt.new_int(var_total).clone(),
										]) } else { rt.call_function('sprintf', [
											rt.call_function('__', [
												rt.new_string('Enlarged image %1$s of %2$s: %3$s'),
											]),
											rt.new_int(var_lightbox_index + 1),
											rt.new_int(var_total).clone(),
											var_alt.clone(),
										]) }
								},
								rt.ArrayItem{ key: 'triggerButtonAriaLabel', val: rt.call_function('sprintf', [
									rt.call_function('__', [
										rt.new_string('Enlarge %1$s of %2$s'),
									]),
									rt.new_int(var_lightbox_index + 1),
									rt.new_int(var_total).clone(),
								]) },
								rt.ArrayItem{ key: 'order', val: var_lightbox_index },
							]) },
						]) },
					])])
				var_lightbox_index += 1
			}
		}
		return var_processor.get_updated_html()
	}
	return var_updated_content.clone()
}

fn register_block_core_gallery() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/gallery'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'block_core_gallery_render' },
		]),
	])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_filter', [rt.new_string('render_block_data'),
		rt.new_string('block_core_gallery_data_id_backcompatibility')])
	rt.call_function('add_filter', [rt.new_string('render_block_context'),
		rt.new_string('block_core_gallery_render_context'), rt.new_int(10),
		rt.new_int(2)])
	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_gallery')])
}
