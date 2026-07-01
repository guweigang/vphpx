import rt

fn render_block_core_media_text(var_attributes rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get('useFeaturedImage'))) {
		return var_content.dup()
	}
	if rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})) {
		rt.call_function('update_post_thumbnail_cache', []rt.PhpVal{})
	}
	mut var_current_featured_image := rt.call_function('get_the_post_thumbnail_url', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_featured_image)))) {
		return var_content.dup()
	}
	mut var_has_media_on_right := (rt.identical(rt.new_string('right'), if !(var_attributes.array_get('mediaPosition')).is_null() { var_attributes.array_get('mediaPosition') } else { rt.new_null() })).to_bool()
	mut var_image_fill := // unsupported expression: Expr_Cast_Bool
	mut var_focal_point := rt.new_string(if var_attributes.array_isset(rt.new_string('focalPoint')) { (rt.call_function('round', [rt.mul(var_attributes.array_get('focalPoint').array_get('x'), rt.new_int(100))])).str() + '% ' + (rt.call_function('round', [rt.mul(var_attributes.array_get('focalPoint').array_get('y'), rt.new_int(100))])).str() + '%' } else { rt.new_string('50% 50%') })
	mut var_unique_id := rt.new_string('wp-block-media-text__media-' + (rt.call_function('wp_unique_id', []rt.PhpVal{})).str())
	mut var_block_tag_processor := create_wp_html_tag_processor(var_content.dup())
	mut var_block_query := { 'tag_name': 'div', 'class_name': 'wp-block-media-text' }
	for rt.is_true(var_block_tag_processor.next_tag(var_block_query.dup())) {
		if rt.is_true(var_image_fill) {
			var_block_tag_processor.remove_class(rt.new_string('is-image-fill'))
			var_block_tag_processor.add_class(rt.new_string('is-image-fill-element'))
		}
	}
	var_content = var_block_tag_processor.get_updated_html()
	mut var_media_tag_processor := create_wp_html_tag_processor(var_content.dup())
	mut var_wrapping_figure_query := { 'tag_name': 'figure', 'class_name': 'wp-block-media-text__media' }
	if var_has_media_on_right {
		for rt.is_true(var_media_tag_processor.next_tag(var_wrapping_figure_query.dup())) {
			var_media_tag_processor.set_bookmark(rt.new_string('last_figure'))
		}
		if rt.is_true(var_media_tag_processor.has_bookmark(rt.new_string('last_figure'))) {
			var_media_tag_processor.seek(rt.new_string('last_figure'))
			var_media_tag_processor.set_attribute(rt.new_string('id'), var_unique_id.dup())
		}
	} else {
		if rt.is_true(var_media_tag_processor.next_tag(var_wrapping_figure_query.dup())) {
			var_media_tag_processor.set_attribute(rt.new_string('id'), var_unique_id.dup())
		}
	}
	var_content = var_media_tag_processor.get_updated_html()
	mut var_media_size_slug := if !(var_attributes.array_get('mediaSizeSlug')).is_null() { var_attributes.array_get('mediaSizeSlug') } else { rt.new_string('full') }
	mut var_image_tag := '<img class="wp-block-media-text__featured_image">'
	var_content = rt.call_function('preg_replace', ['/(<figure\\s+id="' + (rt.call_function('preg_quote', [var_unique_id.dup(), rt.new_string('/')])).str() + '"\\s+class="wp-block-media-text__media"\\s*>)/', '$1' + var_image_tag, var_content.dup()])
	mut var_image_tag_processor := create_wp_html_tag_processor(var_content.dup())
	if rt.is_true(var_image_tag_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'figure' }, rt.ArrayItem{ key: 'id', val: var_unique_id }]))) {
		var_image_tag_processor.remove_attribute(rt.new_string('id'))
		if rt.is_true(var_image_tag_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'img' }, rt.ArrayItem{ key: 'class_name', val: 'wp-block-media-text__featured_image' }]))) {
			var_image_tag_processor.set_attribute(rt.new_string('src'), rt.call_function('esc_url', [var_current_featured_image.dup()]))
			var_image_tag_processor.set_attribute(rt.new_string('class'), rt.new_string('wp-image-' + (rt.call_function('get_post_thumbnail_id', []rt.PhpVal{})).str() + ' size-' + (var_media_size_slug).str()))
			var_image_tag_processor.set_attribute(rt.new_string('alt'), rt.new_string(rt.call_function('strip_tags', [rt.call_function('get_post_meta', [rt.call_function('get_post_thumbnail_id', []rt.PhpVal{}), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])]).to_string().trim_space()))
			if rt.is_true(var_image_fill) {
				var_image_tag_processor.set_attribute(rt.new_string('style'), rt.new_string('object-position:' + (var_focal_point).str() + ';'))
			}
			var_content = var_image_tag_processor.get_updated_html()
		}
	}
	return var_content.dup()
}

fn register_block_core_media_text() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/media-text', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_media_text' }])])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
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




pub fn init_wp_includes_blocks_media_text_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_media_text')])
}
