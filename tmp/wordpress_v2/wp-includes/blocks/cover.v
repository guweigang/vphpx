import rt

fn render_block_core_cover(var_attributes rt.PhpVal, var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_src_matches := []rt.PhpVal{}
	mut var_matches := []rt.PhpVal{}
	mut var_url := rt.new_null()
	mut var_oembed_html := rt.new_null()
	mut var_iframe_src := rt.new_null()
	mut var_lower_src := ''
	mut var_provider := rt.new_null()
	mut var_parsed_url := rt.new_null()
	mut var_query_params := map[string]rt.PhpVal{}
	mut var_path := rt.new_null()
	mut var_path_segments := rt.new_null()
	mut var_video_id := rt.new_null()
	mut var_iframe_html := rt.new_null()
	mut var_processor := rt.new_null()
	mut var_figure_pattern := ''
	mut var_figure_start := rt.new_null()
	mut var_figure_length := i64(0)
	mut var_figure_end := rt.new_null()
	mut var_object_position := rt.new_null()
	mut var_attr := map[string]rt.PhpVal{}
	mut var_image := rt.new_null()
	mut var_current_featured_image := rt.new_null()
	mut var_current_thumbnail_id := rt.new_null()
	mut var_current_alt := ''
	mut var_styles := rt.new_null()
	mut var_inner_container_start := ''
	mut var_offset := rt.new_null()
	if var_attributes.array_isset(rt.new_string('backgroundType'))
		&& rt.is_true(rt.identical(rt.new_string('embed-video'), var_attributes.array_get(rt.new_string('backgroundType'))))
		&& var_attributes.array_isset(rt.new_string('url'))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('url'))))
		&& var_attributes.array_get(rt.new_string('url')).is_string() {
		var_url = var_attributes.array_get(rt.new_string('url'))
		var_oembed_html = rt.call_function('wp_oembed_get', [
			var_url.clone()])
		if rt.is_true(var_oembed_html) {
			rt.call_function('preg_match', [rt.new_string('/src=["\']([^"\']+)["\']/'),
				var_oembed_html.clone(), rt.create_array_from_list(var_src_matches)])
			if !(!rt.is_true(var_src_matches[1])) {
				var_iframe_src = var_src_matches[1]
				var_lower_src = var_iframe_src.clone().to_string().to_lower()
				var_provider = rt.new_null()
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(var_lower_src.str()).clone(), rt.new_string('youtube.com')]), rt.new_bool(false)))))
					|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(var_lower_src.str()).clone(), rt.new_string('youtu.be')]), rt.new_bool(false))))) {
					var_provider = rt.new_string('youtube')
				} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					rt.new_string(var_lower_src.str()).clone(),
					rt.new_string('vimeo.com'),
				]), rt.new_bool(false)))))
				{
					var_provider = rt.new_string('vimeo')
				} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					rt.new_string(var_lower_src.str()).clone(),
					rt.new_string('videopress.com'),
				]), rt.new_bool(false)))))
				{
					var_provider = rt.new_string('videopress')
				} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					rt.new_string(var_lower_src.str()).clone(),
					rt.new_string('wordpress.tv'),
				]), rt.new_bool(false)))))
				{
					var_provider = rt.new_string('wordpress-tv')
				}
				var_parsed_url = rt.call_function('wp_parse_url', [
					var_iframe_src.clone()])
				if rt.is_true(var_parsed_url) && var_parsed_url.array_isset(rt.new_string('host')) {
					var_query_params = map[string]rt.PhpVal{}
					if var_parsed_url.array_isset(rt.new_string('query')) {
						rt.call_function('parse_str', [
							var_parsed_url.array_get(rt.new_string('query')),
							rt.create_array_from_native_map(var_query_params),
						])
					}
					if rt.is_true(rt.identical(rt.new_string('youtube'), var_provider)) {
						var_query_params['autoplay'] = rt.new_string('1')
						var_query_params['mute'] = rt.new_string('1')
						var_query_params['loop'] = rt.new_string('1')
						var_query_params['controls'] = rt.new_string('0')
						var_query_params['modestbranding'] = rt.new_string('1')
						var_query_params['playsinline'] = rt.new_string('1')
						var_path = if !(var_parsed_url.array_get(rt.new_string('path'))).is_null() {
							var_parsed_url.array_get(rt.new_string('path'))
						} else {
							rt.new_string('')
						}
						var_path_segments = rt.call_function('explode', [
							rt.new_string('/'),
							var_path.clone(),
						])
						var_video_id = rt.call_function('end', [
							var_path_segments.clone()])
						if rt.is_true(var_video_id) {
							var_query_params['playlist'] = var_video_id.clone()
						}
					} else if rt.is_true(rt.identical(rt.new_string('vimeo'), var_provider)) {
						var_query_params['autoplay'] = rt.new_string('1')
						var_query_params['muted'] = rt.new_string('1')
						var_query_params['loop'] = rt.new_string('1')
						var_query_params['background'] = rt.new_string('1')
						var_query_params['controls'] = rt.new_string('0')
						var_query_params['transparent'] = rt.new_string('0')
					} else if rt.is_true(rt.identical(rt.new_string('videopress'), var_provider))
						|| rt.is_true(rt.identical(rt.new_string('wordpress-tv'), var_provider)) {
						var_query_params['autoplay'] = rt.new_string('1')
						var_query_params['loop'] = rt.new_string('1')
						var_query_params['muted'] = rt.new_string('1')
					}
					var_iframe_src = rt.new_string(
						(var_parsed_url.array_get(rt.new_string('scheme'))).str() + '://' +
						(var_parsed_url.array_get(rt.new_string('host'))).str())
					if var_parsed_url.array_isset(rt.new_string('path')) {
						var_iframe_src = rt.concat(var_iframe_src,
							var_parsed_url.array_get(rt.new_string('path')))
					}
					if !(!rt.is_true(var_query_params)) {
						var_iframe_src = rt.concat(var_iframe_src,
							rt.new_string('?' +(rt.call_function('http_build_query', [rt.create_array_from_native_map(var_query_params)])).str()))
					}
				}
				var_iframe_html = rt.call_function('sprintf', [
					rt.new_string('<div class="wp-block-cover__video-background wp-block-cover__embed-background"><iframe src="%s" title="Background video" frameborder="0" allow="autoplay; fullscreen"></iframe></div>'),
					rt.call_function('esc_url', [var_iframe_src.clone()]),
				])
				var_processor = create_wp_html_tag_processor(var_content.clone())
				if rt.is_true(var_processor.next_tag(rt.create_array([
					rt.ArrayItem{ key: 'tag_name', val: 'FIGURE' },
					rt.ArrayItem{ key: 'class_name', val: 'wp-block-embed' },
				])))
				{
					var_figure_pattern = '/<figure\\s+[^>]*\\bwp-block-embed\\b[^>]*>.*?<\\/figure>/is'
					if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
						rt.new_string(var_figure_pattern.str()).clone(),
						var_content.clone(),
						rt.create_array_from_list(var_matches),
						rt.get_constant('PREG_OFFSET_CAPTURE'),
					])))
					{
						var_figure_start = var_matches[0].array_get(rt.new_int(1))
						var_figure_length = var_matches[0].array_get(rt.new_int(0)).to_string().len
						var_figure_end = rt.add(var_figure_start, rt.new_int(var_figure_length))
						var_content = rt.new_string(
							(rt.call_function('substr', [var_content.clone(), rt.new_int(0), var_figure_start.clone()])).str() +
							var_iframe_html.str() +(rt.call_function('substr', [var_content.clone(), var_figure_end.clone()])).str())
					}
				}
			}
		}
		return var_content.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('image'), var_attributes.array_get(rt.new_string('backgroundType'))))))
		|| rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get(rt.new_string('useFeaturedImage')))) {
		return var_content.clone()
	}
	var_object_position = if var_attributes.array_isset(rt.new_string('focalPoint')) {
			(rt.call_function('round', [rt.mul(var_attributes.array_get(rt.new_string('focalPoint')).array_get(rt.new_string('x')), rt.new_int(100))])).str() +
			'% ' +
			(rt.call_function('round', [rt.mul(var_attributes.array_get(rt.new_string('focalPoint')).array_get(rt.new_string('y')), rt.new_int(100))])).str() +
			'%'
	} else {
		rt.new_null()
	}
	if !(rt.is_true(var_attributes.array_get(rt.new_string('hasParallax')))
		|| rt.is_true(var_attributes.array_get(rt.new_string('isRepeated')))) {
		var_attr = {
			'class':           rt.new_string('wp-block-cover__image-background')
			'data-object-fit': rt.new_string('cover')
		}
		if rt.is_true(var_object_position) {
			var_attr['data-object-position'] = var_object_position.clone()
			var_attr['style'] = 'object-position:' + var_object_position.str() + ';'
		}
		var_image = rt.call_function('get_the_post_thumbnail', [
			rt.new_null(), if !(var_attributes.array_get(rt.new_string('sizeSlug'))).is_null() {
				var_attributes.array_get(rt.new_string('sizeSlug'))
			} else {
				rt.new_string('post-thumbnail')
			}, rt.create_array_from_native_map(var_attr)])
	} else {
		if rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})) {
			rt.call_function('update_post_thumbnail_cache', []rt.PhpVal{})
		}
		var_current_featured_image = rt.call_function('get_the_post_thumbnail_url', [
			rt.new_null(),
			if !(var_attributes.array_get(rt.new_string('sizeSlug'))).is_null() {
				var_attributes.array_get(rt.new_string('sizeSlug'))
			} else {
				rt.new_null()
			},
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_current_featured_image)))) {
			return var_content.clone()
		}
		var_current_thumbnail_id = rt.call_function('get_post_thumbnail_id', []rt.PhpVal{})
		var_processor = create_wp_html_tag_processor(rt.new_string('<div></div>'))
		var_processor.next_tag()
		var_current_alt = rt.call_function('strip_tags', [
			rt.call_function('get_post_meta', [var_current_thumbnail_id.clone(),
				rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)]),
		]).to_string().trim_space()
		if var_current_alt.len > 0 && var_current_alt != '0' {
			var_processor.set_attribute(rt.new_string('role'), rt.new_string('img'))
			var_processor.set_attribute(rt.new_string('aria-label'),
				rt.new_string(var_current_alt.str()))
		}
		var_processor.add_class(rt.new_string('wp-block-cover__image-background'))
		var_processor.add_class(rt.new_string('wp-image-' + var_current_thumbnail_id.str()))
		if rt.is_true(var_attributes.array_get(rt.new_string('hasParallax'))) {
			var_processor.add_class(rt.new_string('has-parallax'))
		}
		if rt.is_true(var_attributes.array_get(rt.new_string('isRepeated'))) {
			var_processor.add_class(rt.new_string('is-repeated'))
		}
		var_styles = rt.new_string('background-position:' +
			(if !var_object_position.is_null() { var_object_position } else { rt.new_string('50% 50%') }).str() +
			';')
		var_styles = rt.concat(var_styles, rt.new_string('background-image:url(' +
			(rt.call_function('esc_url', [var_current_featured_image.clone()])).str() + ');'))
		var_processor.set_attribute(rt.new_string('style'), var_styles.clone())
		var_image = var_processor.get_updated_html()
	}
	var_inner_container_start = '/<div\\b[^>]+wp-block-cover__inner-container[\\s|"][^>]*>/U'
	if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string(var_inner_container_start.str()).clone(),
		var_content.clone(), rt.create_array_from_list(var_matches),
		rt.get_constant('PREG_OFFSET_CAPTURE')])))
	{
		var_offset = var_matches[0].array_get(rt.new_int(1))
		var_content = rt.new_string(
			(rt.call_function('substr', [var_content.clone(), rt.new_int(0), var_offset.clone()])).str() +
			var_image.str() +
			(rt.call_function('substr', [var_content.clone(), var_offset.clone()])).str())
	}
	return var_content.clone()
}

fn register_block_core_cover() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/cover'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_cover' },
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

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_cover')])
}
