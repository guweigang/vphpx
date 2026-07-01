import rt

fn render_block_core_cover(var_attributes rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	mut var_src_matches := []rt.PhpVal{}
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('backgroundType')) && rt.is_true(rt.identical(rt.new_string('embed-video'), var_attributes.array_get('backgroundType'))))) && var_attributes.array_isset(rt.new_string('url')))) && !(!rt.is_true(var_attributes.array_get('url'))))) && rt.is_true(rt.new_bool(var_attributes.array_get('url').is_string())))) {
		mut var_url := var_attributes.array_get('url')
		mut var_oembed_html := rt.call_function('wp_oembed_get', [var_url.dup()])
		if rt.is_true(var_oembed_html) {
			rt.call_function('preg_match', [rt.new_string('/src=["\']([^"\']+)["\']/'), var_oembed_html.dup(), var_src_matches.dup()])
			if !(!rt.is_true(var_src_matches.array_get(1))) {
				mut var_iframe_src := var_src_matches.array_get(1)
				mut var_lower_src := var_iframe_src.dup().to_string().to_lower()
				mut var_provider := rt.new_null()
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_provider = rt.new_string(rt.new_string('youtube'))
				} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_provider = rt.new_string(rt.new_string('vimeo'))
				} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_provider = rt.new_string(rt.new_string('videopress'))
				} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_provider = rt.new_string(rt.new_string('wordpress-tv'))
				}
				mut var_parsed_url := rt.call_function('wp_parse_url', [var_iframe_src.dup()])
				if rt.is_true(rt.new_bool(rt.is_true(var_parsed_url) && var_parsed_url.array_isset(rt.new_string('host')))) {
					mut var_query_params := map[string]rt.PhpVal{}
					if var_parsed_url.array_isset(rt.new_string('query')) {
						rt.call_function('parse_str', [var_parsed_url.array_get('query'), var_query_params.dup()])
					}
					if rt.is_true(rt.identical(rt.new_string('youtube'), var_provider)) {
						var_query_params['autoplay'] = rt.new_string('1')
						var_query_params['mute'] = rt.new_string('1')
						var_query_params['loop'] = rt.new_string('1')
						var_query_params['controls'] = rt.new_string('0')
						var_query_params['modestbranding'] = rt.new_string('1')
						var_query_params['playsinline'] = rt.new_string('1')
						mut var_path := if !(var_parsed_url.array_get('path')).is_null() { var_parsed_url.array_get('path') } else { rt.new_string('') }
						mut var_path_segments := rt.call_function('explode', [rt.new_string('/'), var_path.dup()])
						mut var_video_id := rt.call_function('end', [var_path_segments.dup()])
						if rt.is_true(var_video_id) {
							var_query_params['playlist'] = var_video_id.dup()
						}
					} else if rt.is_true(rt.identical(rt.new_string('vimeo'), var_provider)) {
						var_query_params['autoplay'] = rt.new_string('1')
						var_query_params['muted'] = rt.new_string('1')
						var_query_params['loop'] = rt.new_string('1')
						var_query_params['background'] = rt.new_string('1')
						var_query_params['controls'] = rt.new_string('0')
						var_query_params['transparent'] = rt.new_string('0')
					} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('videopress'), var_provider)) || rt.is_true(rt.identical(rt.new_string('wordpress-tv'), var_provider)))) {
						var_query_params['autoplay'] = rt.new_string('1')
						var_query_params['loop'] = rt.new_string('1')
						var_query_params['muted'] = rt.new_string('1')
					}
					var_iframe_src = rt.new_string((var_parsed_url.array_get('scheme')).str() + '://' + (var_parsed_url.array_get('host')).str())
					if var_parsed_url.array_isset(rt.new_string('path')) {
						// unsupported expression: Expr_AssignOp_Concat
					}
					if !(!rt.is_true(var_query_params)) {
						// unsupported expression: Expr_AssignOp_Concat
					}
				}
				mut var_iframe_html := rt.call_function('sprintf', [rt.new_string('<div class="wp-block-cover__video-background wp-block-cover__embed-background"><iframe src="%s" title="Background video" frameborder="0" allow="autoplay; fullscreen"></iframe></div>'), rt.call_function('esc_url', [var_iframe_src.dup()])])
				mut var_processor := create_wp_html_tag_processor(var_content.dup())
				if rt.is_true(var_processor.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: 'FIGURE' }, rt.ArrayItem{ key: 'class_name', val: 'wp-block-embed' }]))) {
					mut var_figure_pattern := '/<figure\\s+[^>]*\\bwp-block-embed\\b[^>]*>.*?<\\/figure>/is'
					if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [rt.new_string(var_figure_pattern).dup(), var_content.dup(), var_matches.dup(), rt.get_constant('PREG_OFFSET_CAPTURE')]))) {
						mut var_figure_start := var_matches.array_get(0).array_get(1)
						mut var_figure_length := var_matches.array_get(0).array_get(0).to_string().len
						mut var_figure_end := rt.add(var_figure_start, rt.new_int(var_figure_length))
						var_content = rt.new_string((rt.call_function('substr', [var_content.dup(), rt.new_int(0), var_figure_start.dup()])).str() + (var_iframe_html).str() + (rt.call_function('substr', [var_content.dup(), var_figure_end.dup()])).str())
					}
				}
			}
		}
		return var_content.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.identical(rt.new_bool(false), var_attributes.array_get('useFeaturedImage'))))) {
		return var_content.dup()
	}
	mut var_object_position := if var_attributes.array_isset(rt.new_string('focalPoint')) { (rt.call_function('round', [rt.mul(var_attributes.array_get('focalPoint').array_get('x'), rt.new_int(100))])).str() + '% ' + (rt.call_function('round', [rt.mul(var_attributes.array_get('focalPoint').array_get('y'), rt.new_int(100))])).str() + '%' } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(var_attributes.array_get('hasParallax')) || rt.is_true(var_attributes.array_get('isRepeated'))))))) {
		mut var_attr := { 'class': rt.new_string('wp-block-cover__image-background'), 'data-object-fit': rt.new_string('cover') }
		if rt.is_true(var_object_position) {
			var_attr['data-object-position'] = var_object_position.dup()
			var_attr['style'] = 'object-position:' + (var_object_position).str() + ';'
		}
		mut var_image := rt.call_function('get_the_post_thumbnail', [rt.new_null(), if !(var_attributes.array_get('sizeSlug')).is_null() { var_attributes.array_get('sizeSlug') } else { rt.new_string('post-thumbnail') }, var_attr.dup()])
	} else {
		if rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})) {
			rt.call_function('update_post_thumbnail_cache', []rt.PhpVal{})
		}
		mut var_current_featured_image := rt.call_function('get_the_post_thumbnail_url', [rt.new_null(), if !(var_attributes.array_get('sizeSlug')).is_null() { var_attributes.array_get('sizeSlug') } else { rt.new_null() }])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_current_featured_image)))) {
			return var_content.dup()
		}
		mut var_current_thumbnail_id := rt.call_function('get_post_thumbnail_id', []rt.PhpVal{})
		var_processor = create_wp_html_tag_processor(rt.new_string('<div></div>'))
		var_processor.next_tag()
		mut var_current_alt := rt.call_function('strip_tags', [rt.call_function('get_post_meta', [var_current_thumbnail_id.dup(), rt.new_string('_wp_attachment_image_alt'), rt.new_bool(true)])]).to_string().trim_space()
		if var_current_alt.len > 0 && var_current_alt != '0' {
			var_processor.set_attribute(rt.new_string('role'), rt.new_string('img'))
			var_processor.set_attribute(rt.new_string('aria-label'), rt.new_string(var_current_alt))
		}
		var_processor.add_class(rt.new_string('wp-block-cover__image-background'))
		var_processor.add_class(rt.new_string('wp-image-' + (var_current_thumbnail_id).str()))
		if rt.is_true(var_attributes.array_get('hasParallax')) {
			var_processor.add_class(rt.new_string('has-parallax'))
		}
		if rt.is_true(var_attributes.array_get('isRepeated')) {
			var_processor.add_class(rt.new_string('is-repeated'))
		}
		mut var_styles := rt.new_string('background-position:' + (if !(var_object_position).is_null() { var_object_position } else { rt.new_string('50% 50%') }).str() + ';')
		// unsupported expression: Expr_AssignOp_Concat
		var_processor.set_attribute(rt.new_string('style'), var_styles.dup())
		var_image = var_processor.get_updated_html()
	}
	mut var_inner_container_start := '/<div\\b[^>]+wp-block-cover__inner-container[\\s|"][^>]*>/U'
	if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [rt.new_string(var_inner_container_start).dup(), var_content.dup(), var_matches.dup(), rt.get_constant('PREG_OFFSET_CAPTURE')]))) {
		mut var_offset := var_matches.array_get(0).array_get(1)
		var_content = rt.new_string((rt.call_function('substr', [var_content.dup(), rt.new_int(0), var_offset.dup()])).str() + (var_image).str() + (rt.call_function('substr', [var_content.dup(), var_offset.dup()])).str())
	}
	return var_content.dup()
}

fn register_block_core_cover() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/cover', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_cover' }])])
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




pub fn init_wp_includes_blocks_cover_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_cover')])
}
