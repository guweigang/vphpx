import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.max_embed_fetches() i64 {
	return 5
}
pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.audio_providers() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'pocket-casts', val: rt.create_array([rt.ArrayItem{ key: 'domains', val: rt.create_array([rt.ArrayItem{ key: none, val: 'pca.st' }]) }, rt.ArrayItem{ key: 'base_url', val: 'https://pca.st/' }]) }, rt.ArrayItem{ key: 'spotify', val: rt.create_array([rt.ArrayItem{ key: 'domains', val: rt.create_array([rt.ArrayItem{ key: none, val: 'open.spotify.com' }]) }, rt.ArrayItem{ key: 'base_url', val: 'https://open.spotify.com/' }]) }, rt.ArrayItem{ key: 'soundcloud', val: rt.create_array([rt.ArrayItem{ key: 'domains', val: rt.create_array([rt.ArrayItem{ key: none, val: 'soundcloud.com' }]) }, rt.ArrayItem{ key: 'base_url', val: 'https://soundcloud.com/' }]) }, rt.ArrayItem{ key: 'mixcloud', val: rt.create_array([rt.ArrayItem{ key: 'domains', val: rt.create_array([rt.ArrayItem{ key: none, val: 'mixcloud.com' }]) }, rt.ArrayItem{ key: 'base_url', val: 'https://www.mixcloud.com/' }]) }, rt.ArrayItem{ key: 'reverbnation', val: rt.create_array([rt.ArrayItem{ key: 'domains', val: rt.create_array([rt.ArrayItem{ key: none, val: 'reverbnation.com' }]) }, rt.ArrayItem{ key: 'base_url', val: 'https://www.reverbnation.com/' }]) }])
}
pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'youtube', val: rt.create_array([rt.ArrayItem{ key: 'domains', val: rt.create_array([rt.ArrayItem{ key: none, val: 'youtube.com' }, rt.ArrayItem{ key: none, val: 'youtu.be' }]) }, rt.ArrayItem{ key: 'base_url', val: 'https://www.youtube.com/' }]) }, rt.ArrayItem{ key: 'videopress', val: rt.create_array([rt.ArrayItem{ key: 'domains', val: rt.create_array([rt.ArrayItem{ key: none, val: 'videopress.com' }, rt.ArrayItem{ key: none, val: 'video.wordpress.com' }]) }, rt.ArrayItem{ key: 'base_url', val: 'https://videopress.com/' }]) }])
}
struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed {
	rt.PhpObjectBase
pub mut:
		embed_fetch_count rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_all_supported_providers() rt.PhpVal {
	return rt.call_function('array_merge', [rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.audio_providers()), rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers())])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_all_provider_configs() rt.PhpVal {
	return rt.call_function('array_merge', [Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.audio_providers(), Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) detect_provider_from_domains(content string) string {
	mut var_all_providers := this.get_all_provider_configs()
	{
		mut iter_1 := var_all_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_config := item_1.val
			mut var_provider := item_1.key
			{
				mut iter_2 := var_config.array_get('domains').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_domain := item_2.val
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						return (var_provider).str()
					}
				}
			}
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) is_valid_url(url string) bool {
	mut url_mutated := url
	return rt.is_true(rt.new_bool(!(url_mutated == '') && rt.is_true(rt.call_function('filter_var', [rt.new_string(url_mutated).dup(), rt.get_constant('FILTER_VALIDATE_URL')])))) && rt.is_true(rt.call_function('wp_http_validate_url', [rt.new_string(url_mutated).dup()]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) create_fallback_attributes(url string, label string) rt.PhpVal {
	mut url_mutated := url
	mut label_mutated := label
	return rt.create_array([rt.ArrayItem{ key: 'url', val: url_mutated }, rt.ArrayItem{ key: 'label', val: label_mutated }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_parsed_block.array_isset(rt.new_string('attrs'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_parsed_block.array_get('attrs').is_array()))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\EmailEditor\\Integrations\\Utils\\Table_Wrapper_Helper')]))))))) {
		return ''
	}
	mut var_attr := var_parsed_block.array_get('attrs')
	mut var_provider := rt.new_string(this.get_supported_provider(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr), block_content))
	if !rt.is_true(var_provider) {
		mut var_url := rt.new_string(this.extract_provider_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr), block_content))
		mut var_is_wp_embed := rt.new_bool(rt.new_bool(var_attr.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('wp-embed'), var_attr.array_get('type')))))
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_url)) && rt.is_true(var_is_wp_embed))) {
			if rt.is_true(rt.greater_equal(this.embed_fetch_count, Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.max_embed_fetches())) {
				return this.render_compact_link_card((var_url).str(), mut var_parsed_block, mut var_rendering_context)
			}
			rt.pre_inc(this.embed_fetch_count)
			mut var_card_result := rt.new_string(this.render_link_embed_card((var_url).str(), mut var_parsed_block, mut var_rendering_context))
			if !(!rt.is_true(var_card_result)) {
				return (var_card_result).str()
			}
			return this.render_compact_link_card((var_url).str(), mut var_parsed_block, mut var_rendering_context)
		}
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr), block_content, mut var_parsed_block, mut var_rendering_context)
	}
	var_url = rt.new_string(this.extract_provider_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr), block_content))
	if !rt.is_true(var_url) {
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr), block_content, mut var_parsed_block, mut var_rendering_context)
	}
	return this.render_content(block_content, mut var_parsed_block, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_attr := if !(var_parsed_block.array_get('attrs')).is_null() { var_parsed_block.array_get('attrs') } else { rt.new_array() }
	mut var_provider := rt.new_string(this.get_supported_provider(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr), block_content))
	mut var_url := rt.new_string(this.extract_provider_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr), block_content))
	if this.is_video_provider((var_provider).str()) {
		return this.render_video_embed((var_url).str(), (var_provider).str(), mut var_parsed_block, mut var_rendering_context, block_content)
	}
	mut var_label := rt.new_string(this.get_provider_label((var_provider).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr)))
	mut var_mock_audio_block := rt.create_array([rt.ArrayItem{ key: 'blockName', val: 'core/audio' }, rt.ArrayItem{ key: 'attrs', val: rt.create_array([rt.ArrayItem{ key: 'src', val: var_url }, rt.ArrayItem{ key: 'label', val: var_label }]) }, rt.ArrayItem{ key: 'innerHTML', val: '<figure class="wp-block-audio"><audio controls src="' + (rt.call_function('esc_attr', [var_url.dup()])).str() + '"></audio></figure>' }])
	if var_parsed_block.array_isset(rt.new_string('email_attrs')) {
		var_mock_audio_block.array_set('email_attrs', var_parsed_block.array_get('email_attrs'))
	}
	mut var_audio_renderer := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_audio()
	mut var_audio_result := var_audio_renderer.render(var_mock_audio_block.array_get('innerHTML'), var_mock_audio_block.dup(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context', []string{}, var_rendering_context))
	if !rt.is_true(var_audio_result) {
		mut var_fallback_attr := this.create_fallback_attributes((var_url).str(), (var_label).str())
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_fallback_attr), block_content, mut var_parsed_block, mut var_rendering_context)
	}
	return (var_audio_result).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_supported_provider(mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string) string {
	mut var_attr_mutated := var_attr
	mut var_all_supported_providers := this.get_all_supported_providers()
	if rt.is_true(rt.new_bool(var_attr_mutated.array_isset(rt.new_string('providerNameSlug')) && rt.is_true(rt.call_function('in_array', [var_attr_mutated.array_get('providerNameSlug'), var_all_supported_providers.dup(), rt.new_bool(true)])))) {
		return (var_attr_mutated.array_get('providerNameSlug')).str()
	}
	mut var_url := if !(var_attr_mutated.array_get('url')).is_null() { var_attr_mutated.array_get('url') } else { rt.new_string('') }
	mut var_content_to_check := if !(!rt.is_true(var_url)) { var_url } else { rt.new_string(block_content) }
	return this.detect_provider_from_domains((var_content_to_check).str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) extract_url_from_content(block_content string) string {
	mut var_dom_helper := create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup())
	mut var_wrapper_element := var_dom_helper.find_element(rt.new_string('div'))
	if rt.is_true(var_wrapper_element) {
		mut var_class_attr := var_dom_helper.get_attribute_value(var_wrapper_element.dup(), rt.new_string('class'))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_url := rt.new_string(rt.new_string(rt.get_property(var_wrapper_element, 'textContent').to_string().trim_space()))
			var_url = rt.call_function('html_entity_decode', [var_url.dup(), rt.bitwise_or(rt.get_constant('ENT_QUOTES'), rt.get_constant('ENT_HTML5')), rt.new_string('UTF-8')])
			if this.is_valid_url((var_url).str()) {
				return (var_url).str()
			}
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) extract_provider_url(mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string) string {
	mut var_attr_mutated := var_attr
	if !(!rt.is_true(var_attr_mutated.array_get('url'))) {
		mut var_url := var_attr_mutated.array_get('url')
		if this.is_valid_url((var_url).str()) {
			return (var_url).str()
		}
		return ''
	}
	return this.extract_url_from_content(block_content)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_provider_label(provider string, mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut provider_mutated := provider
	mut var_attr_mutated := var_attr
	if !(!rt.is_true(var_attr_mutated.array_get('label'))) {
		return (var_attr_mutated.array_get('label')).str()
	}
	return this.get_translated_provider_label(provider_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_translated_provider_label(provider string) string {
	mut provider_mutated := provider
	mut switch_val_1 := rt.new_string(provider_mutated)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('spotify'))) {
		return (rt.call_function('__', [rt.new_string('Listen on Spotify'), rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('soundcloud'))) {
		return (rt.call_function('__', [rt.new_string('Listen on SoundCloud'), rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pocket-casts'))) {
		return (rt.call_function('__', [rt.new_string('Listen on Pocket Casts'), rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mixcloud'))) {
		return (rt.call_function('__', [rt.new_string('Listen on Mixcloud'), rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reverbnation'))) {
		return (rt.call_function('__', [rt.new_string('Listen on ReverbNation'), rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('youtube'))) {
		return (rt.call_function('__', [rt.new_string('Watch on YouTube'), rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('videopress'))) {
		return (rt.call_function('__', [rt.new_string('Watch on VideoPress'), rt.new_string('woocommerce')])).str()
	} else {
		return (rt.call_function('__', [rt.new_string('Listen to the audio'), rt.new_string('woocommerce')])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_link_fallback(mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_attr_mutated := var_attr
	mut var_url := if !(var_attr_mutated.array_get('url')).is_null() { var_attr_mutated.array_get('url') } else { rt.new_string('') }
	if !rt.is_true(var_url) {
		var_url = rt.new_string(this.extract_url_from_content(block_content))
		if !rt.is_true(var_url) {
			mut var_dom_helper := create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content).dup())
			mut var_body_element := var_dom_helper.find_element(rt.new_string('body'))
			if rt.is_true(var_body_element) {
				mut var_text_content := rt.get_property(var_body_element, 'textContent')
				var_url = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.extract_url_from_text(arg_0) }(var_text_content.dup())
			}
		}
	}
	if !rt.is_true(var_url) && var_attr_mutated.array_isset(rt.new_string('providerNameSlug')) {
		var_url = rt.new_string(this.get_provider_base_url((var_attr_mutated.array_get('providerNameSlug')).str()))
	}
	if !(this.is_valid_url((var_url).str())) {
		return ''
	}
	if !(!rt.is_true(var_attr_mutated.array_get('label'))) {
		mut var_link_text := var_attr_mutated.array_get('label')
	} else {
		mut var_provider := if !(var_attr_mutated.array_get('providerNameSlug')).is_null() { var_attr_mutated.array_get('providerNameSlug') } else { rt.new_string('') }
		mut var_base_url := rt.new_string(this.get_provider_base_url((var_provider).str()))
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_base_url)) && rt.is_true(rt.identical(var_url, var_base_url)))) {
			var_link_text = rt.new_string(this.get_provider_label((var_provider).str(), mut var_attr_mutated))
		} else {
			var_link_text = var_url.dup()
		}
	}
	mut var_email_styles := var_rendering_context.get_theme_styles()
	mut var_link_color := if !(var_parsed_block.array_get('email_attrs').array_get('color')).is_null() { var_parsed_block.array_get('email_attrs').array_get('color') } else { if !(var_email_styles.array_get('color').array_get('text')).is_null() { var_email_styles.array_get('color').array_get('text') } else { rt.new_string('#0073aa') } }
	var_link_color = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}; return temp.sanitize_color(arg_0) }(var_link_color.dup())
	mut var_link_html := rt.call_function('sprintf', [rt.new_string('<a href="%s" target="_blank" rel="noopener nofollow" style="color: %s; text-decoration: underline;">%s</a>'), rt.call_function('esc_url', [var_url.dup()]), rt.call_function('esc_attr', [var_link_color.dup()]), rt.call_function('esc_html', [var_link_text.dup()])])
	return (this.add_spacer(var_link_html.dup(), if !(var_parsed_block.array_get('email_attrs')).is_null() { var_parsed_block.array_get('email_attrs') } else { rt.new_array() })).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_provider_base_url(provider string) string {
	mut provider_mutated := provider
	mut var_all_providers := this.get_all_provider_configs()
	return (if !(var_all_providers.array_get(provider_mutated).array_get('base_url')).is_null() { var_all_providers.array_get(provider_mutated).array_get('base_url') } else { rt.new_string('') }).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) is_video_provider(provider string) bool {
	mut provider_mutated := provider
	return Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers().array_isset(rt.new_string(provider_mutated).dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) url_matches_provider(url string, provider string) bool {
	mut url_mutated := url
	mut provider_mutated := provider
	if !(this.is_valid_url(url_mutated)) {
		return false
	}
	mut var_parsed_url := rt.call_function('wp_parse_url', [rt.new_string(url_mutated).dup()])
	if !(var_parsed_url.array_isset(rt.new_string('host'))) {
		return false
	}
	mut var_url_host := rt.new_string(rt.new_string(var_parsed_url.array_get('host').to_string().to_lower()))
	mut var_all_providers := this.get_all_provider_configs()
	mut var_allowed_domains := if !().is_null() {  } else {  }
	{
		mut iter_1 := var_allowed_domains.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_allowed_domain := item_1.val
			
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_video_embed(url string, provider string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, block_content string) string {
	mut url_mutated := url
	mut provider_mutated := provider
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_video_thumbnail_url(url string, provider string) string {
	mut url_mutated := url
	mut provider_mutated := provider
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_youtube_thumbnail(url string) string {
	mut var_matches := rt.new_null()
	mut url_mutated := url
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_videopress_thumbnail(url string) string {
	mut url_mutated := url
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) fetch_embed_page_data(url string) rt.PhpVal {
	mut url_mutated := url
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_link_embed_card(url string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut url_mutated := url
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_compact_link_card(url string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut url_mutated := url
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_embed() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed{
		PhpObjectBase: rt.PhpObjectBase{}
		embed_fetch_count: rt.new_int(0)
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_audio() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all_supported_providers' {
			return this.get_all_supported_providers()
		}
		'get_all_provider_configs' {
			return this.get_all_provider_configs()
		}
		'detect_provider_from_domains' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.detect_provider_from_domains(dispatch_arg_0))
		}
		'is_valid_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_valid_url(dispatch_arg_0))
		}
		'create_fallback_attributes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.create_fallback_attributes(dispatch_arg_0, dispatch_arg_1)
		}
		'render' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'get_supported_provider' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_supported_provider(mut dispatch_arg_0, dispatch_arg_1))
		}
		'extract_url_from_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_url_from_content(dispatch_arg_0))
		}
		'extract_provider_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_provider_url(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_provider_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.get_provider_label(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_translated_provider_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_translated_provider_label(dispatch_arg_0))
		}
		'render_link_fallback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_string(this.render_link_fallback(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3))
		}
		'get_provider_base_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_provider_base_url(dispatch_arg_0))
		}
		'is_video_provider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_video_provider(dispatch_arg_0))
		}
		'url_matches_provider' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.url_matches_provider(dispatch_arg_0, dispatch_arg_1))
		}
		'render_video_embed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 3 { args[3] } else { rt.new_null() })
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_string(this.render_video_embed(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4))
		}
		'get_video_thumbnail_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_video_thumbnail_url(dispatch_arg_0, dispatch_arg_1))
		}
		'get_youtube_thumbnail' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_youtube_thumbnail(dispatch_arg_0))
		}
		'get_videopress_thumbnail' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_videopress_thumbnail(dispatch_arg_0))
		}
		'fetch_embed_page_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.fetch_embed_page_data(dispatch_arg_0)
		}
		'render_link_embed_card' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_link_embed_card(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'render_compact_link_card' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.render_compact_link_card(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'embed_fetch_count' { return this.embed_fetch_count }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'embed_fetch_count' { this.embed_fetch_count = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_embed_php() {
	// unsupported statement: Stmt_Declare
}
