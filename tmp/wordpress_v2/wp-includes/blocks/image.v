import rt

fn render_block_core_image(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_processor := rt.new_null()
	mut var_has_id_binding := false
	mut var_id := rt.new_null()
	mut var_image_classnames := rt.new_null()
	mut var_class_with_binding_value := ''
	mut var_data_id := rt.new_null()
	mut var_figcaption_span := rt.new_null()
	mut var_link_destination := rt.new_null()
	mut var_lightbox_settings := rt.new_null()
	mut var_output := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		var_content.clone(),
		rt.new_string('<img'),
	])))
	{
		return ''
	}
	var_processor = rt.create_object_dynamically(rt.new_null(), [
		var_content.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_processor, 'next_tag', [rt.new_string('img')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_processor, 'get_attribute', [rt.new_string('src')]))))) {
		return ''
	}
	var_has_id_binding =
		var_attributes.array_get(rt.new_string('metadata')).array_get(rt.new_string('bindings')).array_isset(rt.new_string('id'))
		&& var_attributes.array_isset(rt.new_string('id'))
	if var_has_id_binding {
		var_id = var_attributes.array_get(rt.new_string('id'))
		var_image_classnames = rt.call_method(var_processor, 'get_attribute', [
			rt.new_string('class'),
		])
		var_class_with_binding_value = 'wp-image-${var_id.to_string()}'
		if var_image_classnames.clone().is_string()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_image_classnames.clone(), rt.new_string(var_class_with_binding_value.str()).clone()]))))) {
			var_image_classnames = rt.call_function('preg_replace', [
				rt.new_string('/wp-image-(\\d+)/'),
				rt.new_string(var_class_with_binding_value.str()).clone(),
				var_image_classnames.clone(),
			])
			rt.call_method(var_processor, 'set_attribute', [rt.new_string('class'),
				var_image_classnames.clone()])
		}
	}
	if var_attributes.array_isset(rt.new_string('data-id')) {
		var_data_id = if var_has_id_binding {
			var_attributes.array_get(rt.new_string('id'))
		} else {
			var_attributes.array_get(rt.new_string('data-id'))
		}
		rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-id'),
			var_data_id.clone()])
	}
	if rt.is_true(rt.call_method(var_processor, 'next_tag', [rt.new_string('FIGCAPTION')]))
		&& !rt.is_true(var_attributes.array_get(rt.new_string('caption'))) {
		var_figcaption_span = rt.call_method(var_processor,
			'block_core_image_extract_empty_figcaption_element', []rt.PhpVal{})
	}
	var_link_destination = if !(var_attributes.array_get(rt.new_string('linkDestination'))).is_null() {
		var_attributes.array_get(rt.new_string('linkDestination'))
	} else {
		rt.new_string('none')
	}
	var_lightbox_settings = block_core_image_get_lightbox_settings(rt.get_property(var_block,
		'parsed_block'))
	if !var_lightbox_settings.is_null()
		&& rt.is_true(rt.identical(rt.new_string('none'), var_link_destination))
		&& var_lightbox_settings.array_isset(rt.new_string('enabled'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_lightbox_settings.array_get(rt.new_string('enabled')))) {
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('@wordpress/block-library/image/view'),
		])
		rt.call_function('add_filter', [rt.new_string('render_block_core/image'),
			rt.new_string('block_core_image_render_lightbox'),
			rt.new_int(15), rt.new_int(3)])
	} else {
		rt.call_function('remove_filter', [rt.new_string('render_block_core/image'),
			rt.new_string('block_core_image_render_lightbox'),
			rt.new_int(15)])
	}
	var_output = rt.call_method(var_processor, 'get_updated_html', []rt.PhpVal{})
	if !(!rt.is_true(var_figcaption_span)) {
		return
			(rt.call_function('substr', [var_output.clone(), rt.new_int(0), rt.get_property(var_figcaption_span, 'start')])).str() +(rt.call_function('substr', [var_output.clone(), rt.add(rt.get_property(var_figcaption_span, 'start'), rt.get_property(var_figcaption_span, 'length'))])).str()
	}
	return var_output.str()
}

fn block_core_image_get_lightbox_settings(var_block rt.PhpVal) rt.PhpVal {
	mut var_lightbox_settings := rt.new_null()
	if var_block.array_get(rt.new_string('attrs')).array_isset(rt.new_string('lightbox')) {
		var_lightbox_settings =
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('lightbox'))
	}
	if !(!var_lightbox_settings.is_null()) {
		var_lightbox_settings = rt.call_function('wp_get_global_settings', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'lightbox' }]),
			rt.create_array([rt.ArrayItem{ key: 'block_name', val: 'core/image' }]),
		])
		if var_lightbox_settings.array_isset(rt.new_string('lightbox')) {
			var_lightbox_settings = rt.call_function('wp_get_global_settings', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'lightbox' }]),
			])
		}
	}
	return if !var_lightbox_settings.is_null() { var_lightbox_settings } else { rt.new_null() }
}

fn block_core_image_render_lightbox(var_block_content rt.PhpVal, var_block rt.PhpVal, var_block_instance rt.PhpVal) rt.PhpVal {
	mut var_processor := rt.new_null()
	mut var_alt := rt.new_null()
	mut var_img_uploaded_src := rt.new_null()
	mut var_img_class_names := rt.new_null()
	mut var_img_styles := rt.new_null()
	mut var_img_width := rt.new_null()
	mut var_img_height := rt.new_null()
	mut var_img_srcset := rt.new_null()
	mut var_custom_aria_label := rt.new_null()
	mut var_img_metadata := rt.new_null()
	mut var_has_dimensions := false
	mut var_srcset_size := rt.new_null()
	mut var_figure_class_names := rt.new_null()
	mut var_figure_styles := rt.new_null()
	mut var_unique_image_id := rt.new_null()
	mut var_body_content := rt.new_null()
	mut var_img := rt.new_null()
	mut var_button := rt.new_null()
	var_processor = create_wp_html_tag_processor(var_block_content.clone())
	if rt.is_true(rt.call_method(var_processor, 'next_tag', [
		rt.new_string('figure')]))
	{
		rt.call_method(var_processor, 'set_bookmark', [rt.new_string('figure')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_processor, 'next_tag', [
		rt.new_string('img'),
	])))))
	{
		return var_block_content.clone()
	}
	var_alt = rt.call_method(var_processor, 'get_attribute', [
		rt.new_string('alt')])
	var_img_uploaded_src = rt.call_method(var_processor, 'get_attribute', [
		rt.new_string('src'),
	])
	var_img_class_names = rt.call_method(var_processor, 'get_attribute', [
		rt.new_string('class'),
	])
	var_img_styles = rt.call_method(var_processor, 'get_attribute', [
		rt.new_string('style'),
	])
	var_img_width = rt.new_string('none')
	var_img_height = rt.new_string('none')
	var_img_srcset = rt.new_bool(false)
	rt.call_function('wp_interactivity_config', [rt.new_string('core/image'),
		rt.create_array([
			rt.ArrayItem{ key: 'defaultAriaLabel', val: rt.call_function('__', [
				rt.new_string('Enlarged image'),
			]) },
			rt.ArrayItem{ key: 'closeButtonText', val: rt.call_function('esc_html__', [
				rt.new_string('Close'),
			]) },
			rt.ArrayItem{ key: 'prevButtonText', val: rt.call_function('esc_html_x', [
				rt.new_string('Previous'),
				rt.new_string('previous image in lightbox'),
			]) },
			rt.ArrayItem{ key: 'nextButtonText', val: rt.call_function('esc_html_x', [
				rt.new_string('Next'),
				rt.new_string('next image in lightbox'),
			]) },
		])])
	if rt.is_true(var_alt) {
		var_custom_aria_label = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Enlarged image: %s')]),
			var_alt.clone(),
		])
	}
	if var_block.array_get(rt.new_string('attrs')).array_isset(rt.new_string('id')) {
		var_img_uploaded_src = rt.call_function('wp_get_attachment_url', [
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('id')),
		])
		var_img_metadata = rt.call_function('wp_get_attachment_metadata', [
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('id')),
		])
		var_has_dimensions =
			rt.is_true(if !(var_img_metadata.array_get(rt.new_string('width'))).is_null() { var_img_metadata.array_get(rt.new_string('width')) } else { rt.new_string('') })
			&& rt.is_true(if !(var_img_metadata.array_get(rt.new_string('height'))).is_null() { var_img_metadata.array_get(rt.new_string('height')) } else { rt.new_string('') })
		var_srcset_size = if var_has_dimensions { rt.create_array([
				rt.ArrayItem{ key: none, val: var_img_metadata.array_get(rt.new_string('width')) },
				rt.ArrayItem{ key: none, val: var_img_metadata.array_get(rt.new_string('height')) },
			]) } else { rt.new_string('large') }
		var_img_srcset = rt.call_function('wp_get_attachment_image_srcset', [
			var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('id')),
			var_srcset_size.clone(),
		])
		var_img_width = if !(var_img_metadata.array_get(rt.new_string('width'))).is_null() {
			var_img_metadata.array_get(rt.new_string('width'))
		} else {
			rt.new_string('none')
		}
		var_img_height = if !(var_img_metadata.array_get(rt.new_string('height'))).is_null() {
			var_img_metadata.array_get(rt.new_string('height'))
		} else {
			rt.new_string('none')
		}
	}
	rt.call_method(var_processor, 'seek', [rt.new_string('figure')])
	var_figure_class_names = rt.call_method(var_processor, 'get_attribute', [
		rt.new_string('class'),
	])
	var_figure_styles = rt.call_method(var_processor, 'get_attribute', [
		rt.new_string('style'),
	])
	var_unique_image_id = rt.call_function('uniqid', []rt.PhpVal{})
	rt.call_function('wp_interactivity_state', [rt.new_string('core/image'),
		rt.create_array([
			rt.ArrayItem{ key: 'metadata', val: rt.create_array([
				rt.ArrayItem{ key: var_unique_image_id, val: rt.create_array([
					rt.ArrayItem{ key: 'uploadedSrc', val: var_img_uploaded_src },
					rt.ArrayItem{ key: 'lightboxSrcset', val: var_img_srcset },
					rt.ArrayItem{ key: 'figureClassNames', val: var_figure_class_names },
					rt.ArrayItem{ key: 'figureStyles', val: var_figure_styles },
					rt.ArrayItem{ key: 'imgClassNames', val: var_img_class_names },
					rt.ArrayItem{ key: 'imgStyles', val: var_img_styles },
					rt.ArrayItem{ key: 'targetWidth', val: var_img_width },
					rt.ArrayItem{ key: 'targetHeight', val: var_img_height },
					rt.ArrayItem{
						key: 'scaleAttr'
						val: if !(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('scale'))).is_null() {
							var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('scale'))
						} else {
							rt.new_bool(false)
						}
					},
					rt.ArrayItem{ key: 'alt', val: var_alt },
					rt.ArrayItem{
						key: 'galleryId'
						val: if !(rt.get_property(var_block_instance, 'context').array_get(rt.new_string('galleryId'))).is_null() {
							rt.get_property(var_block_instance, 'context').array_get(rt.new_string('galleryId'))
						} else {
							rt.new_null()
						}
					},
					rt.ArrayItem{
						key: 'customAriaLabel'
						val: if !var_custom_aria_label.is_null() {
							var_custom_aria_label
						} else {
							rt.new_null()
						}
					},
					rt.ArrayItem{
						key: 'navigationButtonType'
						val: if !(rt.get_property(var_block_instance, 'context').array_get(rt.new_string('navigationButtonType'))).is_null() {
							rt.get_property(var_block_instance, 'context').array_get(rt.new_string('navigationButtonType'))
						} else {
							rt.new_string('icon')
						}
					},
					rt.ArrayItem{ key: 'triggerButtonAriaLabel', val: rt.new_null() },
				]) },
			]) },
		])])
	rt.call_method(var_processor, 'add_class', [rt.new_string('wp-lightbox-container')])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-interactive'),
		rt.new_string('core/image')])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-context'),
		rt.call_function('wp_json_encode', [
			rt.create_array([rt.ArrayItem{ key: 'imageId', val: var_unique_image_id }]),
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
				rt.get_constant('JSON_HEX_AMP')),
		])])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-key'),
		var_unique_image_id.clone()])
	rt.call_method(var_processor, 'next_tag', [rt.new_string('img')])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-init'),
		rt.new_string('callbacks.setButtonStyles')])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-on--load'),
		rt.new_string('callbacks.setButtonStyles')])
	rt.call_method(var_processor, 'set_attribute', [
		rt.new_string('data-wp-on-window--resize'),
		rt.new_string('callbacks.setButtonStyles'),
	])
	rt.call_method(var_processor, 'set_attribute', [
		rt.new_string('data-wp-on--pointerenter'),
		rt.new_string('actions.preloadImageWithDelay'),
	])
	rt.call_method(var_processor, 'set_attribute', [
		rt.new_string('data-wp-on--pointerdown'),
		rt.new_string('actions.preloadImage'),
	])
	rt.call_method(var_processor, 'set_attribute', [
		rt.new_string('data-wp-on--pointerleave'),
		rt.new_string('actions.cancelPreload'),
	])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-on--click'),
		rt.new_string('actions.showLightbox')])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-class--hide'),
		rt.new_string('state.isContentHidden')])
	rt.call_method(var_processor, 'set_attribute', [rt.new_string('data-wp-class--show'),
		rt.new_string('state.isContentVisible')])
	var_body_content = rt.call_method(var_processor, 'get_updated_html', []rt.PhpVal{})
	var_img = rt.new_null()
	rt.call_function('preg_match', [rt.new_string('/<img[^>]+>/'),
		var_body_content.clone(), var_img.clone()])
	var_button = rt.new_string(
		(var_img.array_get(rt.new_int(0))).str() + '<button\n\t\t\tclass="lightbox-trigger"\n\t\t\ttype="button"\n\t\t\taria-haspopup="dialog"\n\t\t\tdata-wp-bind--aria-label="state.thisImage.triggerButtonAriaLabel"\n\t\t\tdata-wp-init="callbacks.initTriggerButton"\n\t\t\tdata-wp-on--click="actions.showLightbox"\n\t\t\tdata-wp-style--right="state.thisImage.buttonRight"\n\t\t\tdata-wp-style--top="state.thisImage.buttonTop"\n\t\t>\n\t\t\t<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="none" viewBox="0 0 12 12">\n\t\t\t\t<path fill="#fff" d="M2 0a2 2 0 0 0-2 2v2h1.5V2a.5.5 0 0 1 .5-.5h2V0H2Zm2 10.5H2a.5.5 0 0 1-.5-.5V8H0v2a2 2 0 0 0 2 2h2v-1.5ZM8 12v-1.5h2a.5.5 0 0 0 .5-.5V8H12v2a2 2 0 0 1-2 2H8Zm2-12a2 2 0 0 1 2 2v2h-1.5V2a.5.5 0 0 0-.5-.5H8V0h2Z" />\n\t\t\t</svg>\n\t\t</button>')
	var_body_content = rt.call_function('preg_replace', [rt.new_string('/<img[^>]+>/'),
		var_button.clone(), var_body_content.clone()])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.new_string('block_core_image_print_lightbox_overlay')])
	return var_body_content.clone()
}

fn block_core_image_print_lightbox_overlay() {
	mut var_dialog_label := rt.new_null()
	mut var_close_button_text := rt.new_null()
	mut var_prev_button_text := rt.new_null()
	mut var_next_button_text := rt.new_null()
	mut var_close_button_icon := ''
	mut var_prev_button_icon := ''
	mut var_next_button_icon := ''
	mut var_background_color := rt.new_null()
	mut var_close_button_color := rt.new_null()
	mut var_global_styles_color := rt.new_null()
	var_dialog_label = rt.call_function('esc_attr__', [rt.new_string('Enlarged images')])
	var_close_button_text = rt.call_function('esc_attr__', [rt.new_string('Close')])
	var_prev_button_text = rt.call_function('esc_attr_x', [rt.new_string('Previous'),
		rt.new_string('previous image in lightbox')])
	var_next_button_text = rt.call_function('esc_attr_x', [rt.new_string('Next'),
		rt.new_string('next image in lightbox')])
	var_close_button_icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" aria-hidden="true" focusable="false"><path d="m13.06 12 6.47-6.47-1.06-1.06L12 10.94 5.53 4.47 4.47 5.53 10.94 12l-6.47 6.47 1.06 1.06L12 13.06l6.47 6.47 1.06-1.06L13.06 12Z"></path></svg>'
	var_prev_button_icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28" aria-hidden="true" focusable="false"><path d="M14.6 7l-1.2-1L8 12l5.4 6 1.2-1-4.6-5z"></path></svg>'
	var_next_button_icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28" aria-hidden="true" focusable="false"><path d="M10.6 6L9.4 7l4.6 5-4.6 5 1.2 1 5.4-6z"></path></svg>'
	var_background_color = rt.new_string('#fff')
	var_close_button_color = rt.new_string('#000')
	if rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})) {
		var_global_styles_color = rt.call_function('wp_get_global_styles', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'color' }]),
		])
		if !(!rt.is_true(var_global_styles_color.array_get(rt.new_string('background')))) {
			var_background_color = rt.call_function('esc_attr', [
				var_global_styles_color.array_get(rt.new_string('background')),
			])
		}
		if !(!rt.is_true(var_global_styles_color.array_get(rt.new_string('text')))) {
			var_close_button_color = rt.call_function('esc_attr', [
				var_global_styles_color.array_get(rt.new_string('text')),
			])
		}
	}
	print("\t\t<div\n\t\t\tclass=\"wp-lightbox-overlay zoom\"\n\t\t\taria-label=\"${var_dialog_label.to_string()}\"\n\t\t\tdata-wp-interactive=\"core/image\"\n\t\t\tdata-wp-router-region='{ \"id\": \"core/image-overlay\", \"attachTo\": \"body\" }'\n\t\t\tdata-wp-key=\"wp-lightbox-overlay\"\n\t\t\tdata-wp-context='{}'\n\t\t\tdata-wp-bind--role=\"state.roleAttribute\"\n\t\t\tdata-wp-bind--aria-label=\"state.ariaLabel\"\n\t\t\tdata-wp-bind--aria-modal=\"state.ariaModal\"\n\t\t\tdata-wp-class--active=\"state.overlayEnabled\"\n\t\t\tdata-wp-class--show-closing-animation=\"state.overlayOpened\"\n\t\t\tdata-wp-watch---focus=\"callbacks.setOverlayFocus\"\n\t\t\tdata-wp-watch---inert=\"callbacks.setInertElements\"\n\t\t\tdata-wp-on--keydown=\"actions.handleKeydown\"\n\t\t\tdata-wp-on--touchstart=\"actions.handleTouchStart\"\n\t\t\tdata-wp-on--touchmove=\"actions.handleTouchMove\"\n\t\t\tdata-wp-on--touchend=\"actions.handleTouchEnd\"\n\t\t\tdata-wp-on--click=\"actions.hideLightbox\"\n\t\t\tdata-wp-on-window--resize=\"callbacks.setOverlayStyles\"\n\t\t\tdata-wp-on-window--scroll=\"actions.handleScroll\"\n\t\t\tdata-wp-bind--style=\"state.overlayStyles\"\n\t\t\ttabindex=\"-1\"\n\t\t\t>\n\t\t\t\t<button type=\"button\" style=\"fill:${var_close_button_color.to_string()}\" class=\"wp-lightbox-close-button\" data-wp-bind--aria-label=\"state.closeButtonAriaLabel\">\n\t\t\t\t\t<span class=\"wp-lightbox-close-icon\" data-wp-bind--hidden=\"!state.hasNavigationIcon\">${var_close_button_icon}</span>\n\t\t\t\t\t<span class=\"wp-lightbox-close-text\" data-wp-bind--hidden=\"!state.hasNavigationText\">${var_close_button_text.to_string()}</span>\n\t\t\t\t</button>\n\t\t\t\t<button type=\"button\" style=\"fill:${var_close_button_color.to_string()}\" class=\"wp-lightbox-navigation-button wp-lightbox-navigation-button-prev\" data-wp-bind--hidden=\"!state.hasNavigation\" data-wp-on--click=\"actions.showPreviousImage\" data-wp-bind--aria-label=\"state.prevButtonAriaLabel\">\n\t\t\t\t\t<span class=\"wp-lightbox-navigation-icon\" data-wp-bind--hidden=\"!state.hasNavigationIcon\">${var_prev_button_icon}</span>\n\t\t\t\t\t<span class=\"wp-lightbox-navigation-text\" data-wp-bind--hidden=\"!state.hasNavigationText\">${var_prev_button_text.to_string()}</span>\n\t\t\t\t</button>\n\t\t\t\t<div class=\"lightbox-image-container\">\n\t\t\t\t\t<figure data-wp-bind--class=\"state.selectedImage.figureClassNames\" data-wp-bind--style=\"state.figureStyles\">\n\t\t\t\t\t\t<img data-wp-bind--alt=\"state.selectedImage.alt\" data-wp-bind--class=\"state.selectedImage.imgClassNames\" data-wp-bind--style=\"state.imgStyles\" data-wp-bind--src=\"state.selectedImage.currentSrc\">\n\t\t\t\t\t</figure>\n\t\t\t\t</div>\n\t\t\t\t<div class=\"lightbox-image-container\">\n\t\t\t\t\t<figure data-wp-bind--class=\"state.selectedImage.figureClassNames\" data-wp-bind--style=\"state.figureStyles\">\n\t\t\t\t\t\t<img\n\t\t\t\t\t\t\tdata-wp-bind--alt=\"state.selectedImage.alt\"\n\t\t\t\t\t\t\tdata-wp-bind--class=\"state.selectedImage.imgClassNames\"\n\t\t\t\t\t\t\tdata-wp-bind--style=\"state.imgStyles\"\n\t\t\t\t\t\t\tdata-wp-bind--src=\"state.enlargedSrc\"\n\t\t\t\t\t\t\tdata-wp-bind--srcset=\"state.enlargedSrcset\"\n\t\t\t\t\t\t\tdata-wp-bind--srcset=\"state.enlargedSrcset\"\n\t\t\t\t\t\t\tsizes=\"100vw\"\n\t\t\t\t\t\t>\n\t\t\t\t\t</figure>\n\t\t\t\t</div>\n\t\t\t\t<button type=\"button\" style=\"fill:${var_close_button_color.to_string()}\" class=\"wp-lightbox-navigation-button wp-lightbox-navigation-button-next\" data-wp-bind--hidden=\"!state.hasNavigation\" data-wp-on--click=\"actions.showNextImage\" data-wp-bind--aria-label=\"state.nextButtonAriaLabel\">\n\t\t\t\t\t<span class=\"wp-lightbox-navigation-text\" data-wp-bind--hidden=\"!state.hasNavigationText\">${var_next_button_text.to_string()}</span>\n\t\t\t\t\t<span class=\"wp-lightbox-navigation-icon\" data-wp-bind--hidden=\"!state.hasNavigationIcon\">${var_next_button_icon}</span>\n\t\t\t\t</button>\n\t\t\t\t<div data-wp-text=\"state.ariaLabel\" aria-live=\"polite\" aria-atomic=\"true\" class=\"screen-reader-text\"></div>\n\t\t\t\t<div class=\"scrim\" style=\"background-color: ${var_background_color.to_string()}\" aria-hidden=\"true\"></div>\n\t\t</div>")
}

fn register_block_core_image() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/image'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_image' },
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

fn init_registry() {
	rt.register_class_factory('WP_HTML_Tag_Processor', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_html_tag_processor()
		return rt.new_object('WP_HTML_Tag_Processor', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_image')])
}
