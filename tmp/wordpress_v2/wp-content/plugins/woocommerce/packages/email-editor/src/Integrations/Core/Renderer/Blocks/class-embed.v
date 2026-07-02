import rt
import crypto.md5

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.max_embed_fetches() i64 {
	return 5
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.audio_providers() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'pocket-casts', val: rt.create_array([
			rt.ArrayItem{ key: 'domains', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'pca.st' },
			]) },
			rt.ArrayItem{ key: 'base_url', val: 'https://pca.st/' },
		]) },
		rt.ArrayItem{ key: 'spotify', val: rt.create_array([
			rt.ArrayItem{ key: 'domains', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'open.spotify.com' },
			]) },
			rt.ArrayItem{ key: 'base_url', val: 'https://open.spotify.com/' },
		]) },
		rt.ArrayItem{ key: 'soundcloud', val: rt.create_array([
			rt.ArrayItem{ key: 'domains', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'soundcloud.com' },
			]) },
			rt.ArrayItem{ key: 'base_url', val: 'https://soundcloud.com/' },
		]) },
		rt.ArrayItem{ key: 'mixcloud', val: rt.create_array([
			rt.ArrayItem{ key: 'domains', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'mixcloud.com' },
			]) },
			rt.ArrayItem{ key: 'base_url', val: 'https://www.mixcloud.com/' },
		]) },
		rt.ArrayItem{ key: 'reverbnation', val: rt.create_array([
			rt.ArrayItem{ key: 'domains', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'reverbnation.com' },
			]) },
			rt.ArrayItem{ key: 'base_url', val: 'https://www.reverbnation.com/' },
		]) },
	])
}

pub fn Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'youtube', val: rt.create_array([
			rt.ArrayItem{ key: 'domains', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'youtube.com' },
				rt.ArrayItem{ key: none, val: 'youtu.be' },
			]) },
			rt.ArrayItem{ key: 'base_url', val: 'https://www.youtube.com/' },
		]) },
		rt.ArrayItem{ key: 'videopress', val: rt.create_array([
			rt.ArrayItem{ key: 'domains', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'videopress.com' },
				rt.ArrayItem{ key: none, val: 'video.wordpress.com' },
			]) },
			rt.ArrayItem{ key: 'base_url', val: 'https://videopress.com/' },
		]) },
	])
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed {
	rt.PhpObjectBase
pub mut:
	embed_fetch_count rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_all_supported_providers() rt.PhpVal {
	return rt.call_function('array_merge', [
		rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.audio_providers()),
		rt.func_array_keys(Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers()),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_all_provider_configs() rt.PhpVal {
	return rt.call_function('array_merge', [
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.audio_providers(),
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers(),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) detect_provider_from_domains(content string) string {
	mut var_all_providers := this.get_all_provider_configs()
	mut iter_1 := var_all_providers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_config := item_1.val
		mut var_provider := item_1.key
		mut iter_2 := var_config.array_get(rt.new_string('domains')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_domain := item_2.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
				rt.new_string(content),
				var_domain.clone(),
			]), rt.new_bool(false)))))
			{
				return var_provider.str()
			}
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) is_valid_url(url string) bool {
	mut url_mutated := url
	return !(url_mutated == '')
		&& rt.is_true(rt.call_function('filter_var', [rt.new_string(url_mutated).clone(), rt.get_constant('FILTER_VALIDATE_URL')]))
		&& rt.is_true(rt.call_function('wp_http_validate_url', [rt.new_string(url_mutated).clone()]))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) create_fallback_attributes(url string, label string) rt.PhpVal {
	mut url_mutated := url
	mut label_mutated := label
	return rt.create_array([rt.ArrayItem{ key: 'url', val: url_mutated },
		rt.ArrayItem{ key: 'label', val: label_mutated }])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	if !(var_parsed_block.array_isset(rt.new_string('attrs')))
		|| !(var_parsed_block.array_get(rt.new_string('attrs')).is_array())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WooCommerce\\EmailEditor\\Integrations\\Utils\\Table_Wrapper_Helper')]))))) {
		return ''
	}
	mut var_attr := var_parsed_block.array_get(rt.new_string('attrs'))
	mut var_provider := rt.new_string(this.get_supported_provider(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr),
		block_content))
	if !rt.is_true(var_provider) {
		mut var_url := rt.new_string(this.extract_provider_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr),
			block_content))
		mut var_is_wp_embed := rt.new_bool(var_attr.array_isset(rt.new_string('type'))
			&& rt.is_true(rt.identical(rt.new_string('wp-embed'), var_attr.array_get(rt.new_string('type')))))
		if !(!rt.is_true(var_url)) && rt.is_true(var_is_wp_embed) {
			if rt.is_true(rt.greater_equal(this.embed_fetch_count,
				Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.max_embed_fetches()))
			{
				return this.render_compact_link_card(var_url.str(), mut var_parsed_block, mut
					var_rendering_context)
			}
			rt.pre_inc(this.embed_fetch_count)
			mut var_card_result := rt.new_string(this.render_link_embed_card(var_url.str(), mut
				var_parsed_block, mut var_rendering_context))
			if !(!rt.is_true(var_card_result)) {
				return var_card_result.str()
			}
			return this.render_compact_link_card(var_url.str(), mut var_parsed_block, mut
				var_rendering_context)
		}
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr),
			block_content, mut var_parsed_block, mut var_rendering_context)
	}
	var_url = rt.new_string(this.extract_provider_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr),
		block_content))
	if !rt.is_true(var_url) {
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr),
			block_content, mut var_parsed_block, mut var_rendering_context)
	}
	return this.render_content(block_content, mut var_parsed_block, mut var_rendering_context)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_attr := if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs'))
	} else {
		rt.new_array()
	}
	mut var_provider := rt.new_string(this.get_supported_provider(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr),
		block_content))
	mut var_url := rt.new_string(this.extract_provider_url(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr),
		block_content))
	if this.is_video_provider(var_provider.str()) {
		return this.render_video_embed(var_url.str(), var_provider.str(), mut var_parsed_block, mut
			var_rendering_context, block_content)
	}
	mut var_label := rt.new_string(this.get_provider_label(var_provider.str(), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_attr)))
	mut var_mock_audio_block := rt.create_array([
		rt.ArrayItem{ key: 'blockName', val: 'core/audio' },
		rt.ArrayItem{ key: 'attrs', val: rt.create_array([
			rt.ArrayItem{ key: 'src', val: var_url },
			rt.ArrayItem{ key: 'label', val: var_label },
		]) },
		rt.ArrayItem{ key: 'innerHTML', val:
			'<figure class="wp-block-audio"><audio controls src="' +
			(rt.call_function('esc_attr', [var_url.clone()])).str() + '"></audio></figure>' },
	])
	if var_parsed_block.array_isset(rt.new_string('email_attrs')) {
		var_mock_audio_block.array_set('email_attrs',
			var_parsed_block.array_get(rt.new_string('email_attrs')))
	}
	mut var_audio_renderer :=
		create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_audio()
	mut var_audio_result := var_audio_renderer.render(var_mock_audio_block.array_get(rt.new_string('innerHTML')),
		var_mock_audio_block.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context))
	if !rt.is_true(var_audio_result) {
		mut var_fallback_attr := this.create_fallback_attributes(var_url.str(), var_label.str())
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_fallback_attr),
			block_content, mut var_parsed_block, mut var_rendering_context)
	}
	return var_audio_result.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_supported_provider(mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string) string {
	mut var_attr_mutated := var_attr
	mut var_all_supported_providers := this.get_all_supported_providers()
	if var_attr_mutated.array_isset(rt.new_string('providerNameSlug'))
		&& rt.is_true(rt.call_function('in_array', [var_attr_mutated.array_get(rt.new_string('providerNameSlug')), var_all_supported_providers.clone(), rt.new_bool(true)])) {
		return (var_attr_mutated.array_get(rt.new_string('providerNameSlug'))).str()
	}
	mut var_url := if !(var_attr_mutated.array_get(rt.new_string('url'))).is_null() {
		var_attr_mutated.array_get(rt.new_string('url'))
	} else {
		rt.new_string('')
	}
	mut var_content_to_check := if !(!rt.is_true(var_url)) {
		var_url
	} else {
		rt.new_string(block_content)
	}
	return this.detect_provider_from_domains(var_content_to_check.str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) extract_url_from_content(block_content string) string {
	mut var_dom_helper :=
		create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content))
	mut var_wrapper_element := var_dom_helper.find_element(rt.new_string('div'))
	if rt.is_true(var_wrapper_element) {
		mut var_class_attr := var_dom_helper.get_attribute_value(var_wrapper_element.clone(),
			rt.new_string('class'))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
			var_class_attr.clone(),
			rt.new_string('wp-block-embed__wrapper'),
		]), rt.new_bool(false)))))
		{
			mut var_url :=
				rt.new_string(rt.get_property(var_wrapper_element, 'textContent').to_string().trim_space())
			var_url = rt.call_function('html_entity_decode', [
				var_url.clone(),
				rt.bitwise_or(rt.get_constant('ENT_QUOTES'),
					rt.get_constant('ENT_HTML5')),
				rt.new_string('UTF-8')])
			if this.is_valid_url(var_url.str()) {
				return var_url.str()
			}
		}
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) extract_provider_url(mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string) string {
	mut var_attr_mutated := var_attr
	if !(!rt.is_true(var_attr_mutated.array_get(rt.new_string('url')))) {
		mut var_url := var_attr_mutated.array_get(rt.new_string('url'))
		if this.is_valid_url(var_url.str()) {
			return var_url.str()
		}
		return ''
	}
	return this.extract_url_from_content(block_content)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_provider_label(provider string, mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array) string {
	mut provider_mutated := provider
	mut var_attr_mutated := var_attr
	if !(!rt.is_true(var_attr_mutated.array_get(rt.new_string('label')))) {
		return (var_attr_mutated.array_get(rt.new_string('label'))).str()
	}
	return this.get_translated_provider_label(provider_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_translated_provider_label(provider string) string {
	mut provider_mutated := provider
	mut switch_val_1 := rt.new_string(provider_mutated)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('spotify'))) {
		return (rt.call_function('__', [rt.new_string('Listen on Spotify'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('soundcloud'))) {
		return (rt.call_function('__', [rt.new_string('Listen on SoundCloud'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('pocket-casts'))) {
		return (rt.call_function('__', [rt.new_string('Listen on Pocket Casts'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('mixcloud'))) {
		return (rt.call_function('__', [rt.new_string('Listen on Mixcloud'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reverbnation'))) {
		return (rt.call_function('__', [rt.new_string('Listen on ReverbNation'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('youtube'))) {
		return (rt.call_function('__', [rt.new_string('Watch on YouTube'),
			rt.new_string('woocommerce')])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('videopress'))) {
		return (rt.call_function('__', [rt.new_string('Watch on VideoPress'),
			rt.new_string('woocommerce')])).str()
	} else {
		return (rt.call_function('__', [rt.new_string('Listen to the audio'),
			rt.new_string('woocommerce')])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_link_fallback(mut var_attr Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_attr_mutated := var_attr
	mut var_url := if !(var_attr_mutated.array_get(rt.new_string('url'))).is_null() {
		var_attr_mutated.array_get(rt.new_string('url'))
	} else {
		rt.new_string('')
	}
	if !rt.is_true(var_url) {
		var_url = rt.new_string(this.extract_url_from_content(block_content))
		if !rt.is_true(var_url) {
			mut var_dom_helper :=
				create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(rt.new_string(block_content))
			mut var_body_element := var_dom_helper.find_element(rt.new_string('body'))
			if rt.is_true(var_body_element) {
				mut var_text_content := rt.get_property(var_body_element, 'textContent')
				mut iife_temp_0 :=
					Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
				mut iife_result_0 := iife_temp_0.extract_url_from_text(var_text_content.clone())
				var_url = iife_result_0
			}
		}
	}
	if !rt.is_true(var_url) && var_attr_mutated.array_isset(rt.new_string('providerNameSlug')) {
		var_url =
			rt.new_string(this.get_provider_base_url((var_attr_mutated.array_get(rt.new_string('providerNameSlug'))).str()))
	}
	if !(this.is_valid_url(var_url.str())) {
		return ''
	}
	if !(!rt.is_true(var_attr_mutated.array_get(rt.new_string('label')))) {
		mut var_link_text := var_attr_mutated.array_get(rt.new_string('label'))
	} else {
		mut var_provider := if !(var_attr_mutated.array_get(rt.new_string('providerNameSlug'))).is_null() {
			var_attr_mutated.array_get(rt.new_string('providerNameSlug'))
		} else {
			rt.new_string('')
		}
		mut var_base_url := rt.new_string(this.get_provider_base_url(var_provider.str()))
		if !(!rt.is_true(var_base_url)) && rt.is_true(rt.identical(var_url, var_base_url)) {
			var_link_text = rt.new_string(this.get_provider_label(var_provider.str(), mut
				var_attr_mutated))
		} else {
			var_link_text = var_url.clone()
		}
	}
	mut var_email_styles := var_rendering_context.get_theme_styles()
	mut var_link_color := if !(var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs')).array_get(rt.new_string('color'))
	} else {
		if !(var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
			var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))
		} else {
			rt.new_string('#0073aa')
		}
	}
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
	mut iife_result_1 := iife_temp_1.sanitize_color(var_link_color.clone())
	var_link_color = iife_result_1
	mut var_link_html := rt.call_function('sprintf', [
		rt.new_string('<a href="%s" target="_blank" rel="noopener nofollow" style="color: %s; text-decoration: underline;">%s</a>'),
		rt.call_function('esc_url', [var_url.clone()]),
		rt.call_function('esc_attr', [var_link_color.clone()]),
		rt.call_function('esc_html', [var_link_text.clone()]),
	])
	return (this.add_spacer(var_link_html.clone(), if !(var_parsed_block.array_get(rt.new_string('email_attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs'))
	} else {
		rt.new_array()
	})).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_provider_base_url(provider string) string {
	mut provider_mutated := provider
	mut var_all_providers := this.get_all_provider_configs()
	return (if !(var_all_providers.array_get(rt.new_string(provider_mutated)).array_get(rt.new_string('base_url'))).is_null() {
		var_all_providers.array_get(rt.new_string(provider_mutated)).array_get(rt.new_string('base_url'))
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) is_video_provider(provider string) bool {
	mut provider_mutated := provider
	return Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed.video_providers().array_isset(rt.new_string(provider_mutated).clone())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) url_matches_provider(url string, provider string) bool {
	mut url_mutated := url
	mut provider_mutated := provider
	if !(this.is_valid_url(url_mutated)) {
		return false
	}
	mut var_parsed_url := rt.call_function('wp_parse_url', [rt.new_string(url_mutated).clone()])
	if !(var_parsed_url.array_isset(rt.new_string('host'))) {
		return false
	}
	mut var_url_host :=
		rt.new_string(var_parsed_url.array_get(rt.new_string('host')).to_string().to_lower())
	mut var_all_providers := this.get_all_provider_configs()
	mut var_allowed_domains := if !(var_all_providers.array_get(rt.new_string(provider_mutated)).array_get(rt.new_string('domains'))).is_null() {
		var_all_providers.array_get(rt.new_string(provider_mutated)).array_get(rt.new_string('domains'))
	} else {
		rt.new_array()
	}
	mut iter_3 := var_allowed_domains.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_allowed_domain := item_3.val
		var_allowed_domain = rt.new_string(var_allowed_domain.clone().to_string().to_lower())
		if rt.is_true(rt.identical(var_url_host, var_allowed_domain))
			|| rt.is_true(rt.call_function('str_ends_with', [var_url_host.clone(), rt.new_string('.' + var_allowed_domain.str())])) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_video_embed(url string, provider string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context, block_content string) string {
	mut url_mutated := url
	mut provider_mutated := provider
	if !(this.url_matches_provider(url_mutated, provider_mutated)) {
		mut var_fallback_attr := this.create_fallback_attributes(url_mutated, url_mutated)
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_fallback_attr),
			block_content, mut var_parsed_block, mut var_rendering_context)
	}
	mut var_poster_url := rt.new_string(this.get_video_thumbnail_url(url_mutated, provider_mutated))
	if !rt.is_true(var_poster_url) {
		var_fallback_attr = this.create_fallback_attributes(url_mutated, url_mutated)
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_fallback_attr),
			block_content, mut var_parsed_block, mut var_rendering_context)
	}
	mut var_mock_video_block := rt.create_array([
		rt.ArrayItem{ key: 'blockName', val: 'core/video' },
		rt.ArrayItem{ key: 'attrs', val: rt.create_array([
			rt.ArrayItem{ key: 'poster', val: var_poster_url },
			rt.ArrayItem{ key: 'videoUrl', val: url_mutated },
		]) },
		rt.ArrayItem{ key: 'innerHTML', val:
			'<figure class="wp-block-video wp-block-embed is-type-video is-provider-' +
			(rt.call_function('esc_attr', [rt.new_string(provider_mutated).clone()])).str() +
			'"><div class="wp-block-embed__wrapper">' +
			(rt.call_function('esc_url', [rt.new_string(url_mutated).clone()])).str() +
			'</div></figure>' },
	])
	if var_parsed_block.array_isset(rt.new_string('email_attrs')) {
		var_mock_video_block.array_set('email_attrs',
			var_parsed_block.array_get(rt.new_string('email_attrs')))
	}
	mut var_video_renderer :=
		create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_video()
	mut var_video_result := var_video_renderer.render(var_mock_video_block.array_get(rt.new_string('innerHTML')),
		var_mock_video_block.clone(), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context))
	if !rt.is_true(var_video_result) {
		var_fallback_attr = this.create_fallback_attributes(url_mutated, url_mutated)
		return this.render_link_fallback(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](var_fallback_attr),
			block_content, mut var_parsed_block, mut var_rendering_context)
	}
	return var_video_result.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_video_thumbnail_url(url string, provider string) string {
	mut url_mutated := url
	mut provider_mutated := provider
	if rt.is_true(rt.identical(rt.new_string('youtube'), rt.new_string(provider_mutated))) {
		return this.get_youtube_thumbnail(url_mutated)
	}
	if rt.is_true(rt.identical(rt.new_string('videopress'), rt.new_string(provider_mutated))) {
		return this.get_videopress_thumbnail(url_mutated)
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_youtube_thumbnail(url string) string {
	mut var_matches := rt.new_null()
	mut url_mutated := url
	mut var_video_id := rt.new_string('')
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/(?:youtube\\.com\\/watch\\?v=|youtu\\.be\\/)([a-zA-Z0-9_-]+)/'),
		rt.new_string(url_mutated).clone(),
		var_matches.clone(),
	]))
	{
		var_video_id = var_matches.array_get(rt.new_int(1))
	}
	if !rt.is_true(var_video_id) {
		return ''
	}
	return 'https://img.youtube.com/vi/' + var_video_id.str() + '/0.jpg'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) get_videopress_thumbnail(url string) string {
	mut url_mutated := url
	mut var_cache_key := rt.new_string('wc_email_vp_thumb_' + md5.hexhash(url_mutated))
	mut var_cached_thumbnail := rt.call_function('get_transient', [
		var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached_thumbnail)))) {
		return (if var_cached_thumbnail.clone().is_string() {
			var_cached_thumbnail
		} else {
			rt.new_string('')
		}).str()
	}
	mut var_oembed :=
		create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_oembed()
	mut var_oembed_data := var_oembed.get_data(rt.new_string(url_mutated))
	mut var_cache_ttl := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('oembed_ttl'),
		rt.get_constant('DAY_IN_SECONDS'),
		rt.new_string(url_mutated).clone(),
		rt.new_array(),
		rt.new_string(''),
	])).to_i64())
	if rt.is_true(rt.identical(rt.new_bool(false), var_oembed_data))
		|| !(var_oembed_data.clone().is_object()) {
		rt.call_function('set_transient', [var_cache_key.clone(),
			rt.new_string(''), var_cache_ttl.clone()])
		return ''
	}
	if !(!(rt.get_property(var_oembed_data, 'thumbnail_url')).is_null()) {
		rt.call_function('set_transient', [var_cache_key.clone(),
			rt.new_string(''), var_cache_ttl.clone()])
		return ''
	}
	mut var_thumbnail_url := rt.get_property(var_oembed_data, 'thumbnail_url')
	if !(!rt.is_true(var_thumbnail_url)) && this.is_valid_url(var_thumbnail_url.str()) {
		rt.call_function('set_transient', [var_cache_key.clone(),
			var_thumbnail_url.clone(), var_cache_ttl.clone()])
		return var_thumbnail_url.str()
	}
	rt.call_function('set_transient', [var_cache_key.clone(),
		rt.new_string(''), var_cache_ttl.clone()])
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) fetch_embed_page_data(url string) rt.PhpVal {
	mut url_mutated := url
	mut var_empty_result := rt.create_array([rt.ArrayItem{ key: 'title', val: '' },
		rt.ArrayItem{ key: 'thumbnail_url', val: '' }, rt.ArrayItem{ key: 'provider_name', val: '' },
		rt.ArrayItem{ key: 'provider_url', val: '' }, rt.ArrayItem{ key: 'excerpt', val: '' },
		rt.ArrayItem{ key: 'site_icon_url', val: '' }])
	mut var_parsed := rt.call_function('wp_parse_url', [rt.new_string(url_mutated).clone()])
	if !rt.is_true(var_parsed.array_get(rt.new_string('scheme')))
		|| !rt.is_true(var_parsed.array_get(rt.new_string('host'))) {
		return var_empty_result.clone()
	}
	mut var_embed_url := rt.new_string(
		(var_parsed.array_get(rt.new_string('scheme'))).str() + '://' + (var_parsed.array_get(rt.new_string('host'))).str() + if var_parsed.array_isset(rt.new_string('port')) { ':' +
		(var_parsed.array_get(rt.new_string('port'))).str() } else { '' } + (rt.call_function('trailingslashit', [if !(var_parsed.array_get(rt.new_string('path'))).is_null() { var_parsed.array_get(rt.new_string('path')) } else { rt.new_string('/') }])).str() +
		'embed/')
	if !(this.is_valid_url(var_embed_url.str())) {
		return var_empty_result.clone()
	}
	mut var_cache_key := rt.new_string('wc_email_embed_pg_' + md5.hexhash(url_mutated))
	mut var_cached := rt.call_function('get_transient', [var_cache_key.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached))))
		&& var_cached.clone().is_array() && var_cached.array_isset(rt.new_string('title'))
		&& var_cached.array_isset(rt.new_string('thumbnail_url'))
		&& var_cached.array_isset(rt.new_string('provider_name'))
		&& var_cached.array_isset(rt.new_string('provider_url'))
		&& var_cached.array_isset(rt.new_string('excerpt'))
		&& var_cached.array_isset(rt.new_string('site_icon_url'))
		&& var_cached.array_get(rt.new_string('title')).is_string()
		&& var_cached.array_get(rt.new_string('thumbnail_url')).is_string()
		&& var_cached.array_get(rt.new_string('provider_name')).is_string()
		&& var_cached.array_get(rt.new_string('provider_url')).is_string()
		&& var_cached.array_get(rt.new_string('excerpt')).is_string()
		&& var_cached.array_get(rt.new_string('site_icon_url')).is_string() {
		return rt.create_array([
			rt.ArrayItem{ key: 'title', val: var_cached.array_get(rt.new_string('title')) },
			rt.ArrayItem{
				key: 'thumbnail_url'
				val: var_cached.array_get(rt.new_string('thumbnail_url'))
			},
			rt.ArrayItem{
				key: 'provider_name'
				val: var_cached.array_get(rt.new_string('provider_name'))
			},
			rt.ArrayItem{
				key: 'provider_url'
				val: var_cached.array_get(rt.new_string('provider_url'))
			},
			rt.ArrayItem{ key: 'excerpt', val: var_cached.array_get(rt.new_string('excerpt')) },
			rt.ArrayItem{
				key: 'site_icon_url'
				val: var_cached.array_get(rt.new_string('site_icon_url'))
			},
		])
	}
	if rt.is_true(rt.new_bool(var_cached.clone().is_string())) {
		return var_empty_result.clone()
	}
	mut var_cache_ttl := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('oembed_ttl'),
		rt.get_constant('DAY_IN_SECONDS'),
		rt.new_string(url_mutated).clone(),
		rt.new_array(),
		rt.new_string(''),
	])).to_i64())
	mut var_response := rt.call_function('wp_safe_remote_get', [
		var_embed_url.clone(),
		rt.create_array([rt.ArrayItem{ key: 'timeout', val: 5 },
			rt.ArrayItem{ key: 'limit_response_size', val: rt.mul(rt.new_int(150),
				rt.get_constant('KB_IN_BYTES')) }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]))))) {
		rt.call_function('set_transient', [var_cache_key.clone(),
			rt.new_string(''), var_cache_ttl.clone()])
		return var_empty_result.clone()
	}
	mut var_body := rt.call_function('wp_remote_retrieve_body', [
		var_response.clone()])
	if !rt.is_true(var_body) {
		rt.call_function('set_transient', [var_cache_key.clone(),
			rt.new_string(''), var_cache_ttl.clone()])
		return var_empty_result.clone()
	}
	mut var_previous_libxml_errors := rt.call_function('libxml_use_internal_errors', [
		rt.new_bool(true),
	])
	mut var_dom :=
		create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_domdocument()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	var_dom.loadhtml(rt.new_string('<?xml encoding="UTF-8">' + var_body.str()), rt.new_int(rt.bitwise_or(rt.get_constant('LIBXML_HTML_NOIMPLIED'),
		rt.get_constant('LIBXML_HTML_NODEFDTD'))))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('libxml_clear_errors', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto finally_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()

	finally_label_1:
	rt.call_function('libxml_use_internal_errors', [var_previous_libxml_errors.clone()])
	if rt.has_exception() { return rt.new_null() }

	end_label_1:
	mut var_xpath :=
		create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_domxpath(var_dom)
	mut var_title := rt.new_string('')
	mut var_heading_nodes :=
		var_xpath.query(rt.new_string("//*[contains(concat(' ', normalize-space(@class), ' '), ' wp-embed-heading ')]"))
	mut var_heading_node := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_heading_nodes)))) && rt.is_true(rt.greater(rt.get_property(var_heading_nodes, 'length'), rt.new_int(0))) { rt.call_method(var_heading_nodes, 'item', [
			rt.new_int(0),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_heading_node,
		'Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMElement')))
	{
		var_title =
			rt.new_string(rt.get_property(var_heading_node, 'textContent').to_string().trim_space())
	}
	mut var_thumbnail_url := rt.new_string('')
	mut var_featured_nodes :=
		var_xpath.query(rt.new_string("//*[contains(concat(' ', normalize-space(@class), ' '), ' wp-embed-featured-image ')]//img"))
	mut var_featured_node := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_featured_nodes)))) && rt.is_true(rt.greater(rt.get_property(var_featured_nodes, 'length'), rt.new_int(0))) { rt.call_method(var_featured_nodes, 'item', [
			rt.new_int(0),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_featured_node,
		'Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMElement')))
	{
		mut var_img_src := rt.call_method(var_featured_node, 'getAttribute', [
			rt.new_string('src'),
		])
		if this.is_valid_url(var_img_src.str()) {
			var_thumbnail_url = var_img_src.clone()
		}
	}
	mut var_provider_name := rt.new_string('')
	mut var_site_title_nodes :=
		var_xpath.query(rt.new_string("//*[contains(concat(' ', normalize-space(@class), ' '), ' wp-embed-site-title ')]//span"))
	mut var_site_title_node := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_site_title_nodes)))) && rt.is_true(rt.greater(rt.get_property(var_site_title_nodes, 'length'), rt.new_int(0))) { rt.call_method(var_site_title_nodes, 'item', [
			rt.new_int(0),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_site_title_node,
		'Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMElement')))
	{
		var_provider_name =
			rt.new_string(rt.get_property(var_site_title_node, 'textContent').to_string().trim_space())
	}
	mut var_provider_url := rt.new_string('')
	mut var_site_link_nodes :=
		var_xpath.query(rt.new_string("//*[contains(concat(' ', normalize-space(@class), ' '), ' wp-embed-site-title ')]//a"))
	mut var_site_link_node := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_site_link_nodes)))) && rt.is_true(rt.greater(rt.get_property(var_site_link_nodes, 'length'), rt.new_int(0))) { rt.call_method(var_site_link_nodes, 'item', [
			rt.new_int(0),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_site_link_node,
		'Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMElement')))
	{
		mut var_href := rt.call_method(var_site_link_node, 'getAttribute', [
			rt.new_string('href'),
		])
		if this.is_valid_url(var_href.str()) {
			var_provider_url = var_href.clone()
		}
	}
	mut var_excerpt := rt.new_string('')
	mut var_excerpt_nodes :=
		var_xpath.query(rt.new_string("//*[contains(concat(' ', normalize-space(@class), ' '), ' wp-embed-excerpt ')]"))
	mut var_excerpt_node := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_excerpt_nodes)))) && rt.is_true(rt.greater(rt.get_property(var_excerpt_nodes, 'length'), rt.new_int(0))) { rt.call_method(var_excerpt_nodes, 'item', [
			rt.new_int(0),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_excerpt_node,
		'Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMElement')))
	{
		var_excerpt =
			rt.new_string(rt.get_property(var_excerpt_node, 'textContent').to_string().trim_space())
	}
	if rt.is_true(rt.greater(rt.call_function('mb_strlen', [var_excerpt.clone()]), rt.new_int(200))) {
		var_excerpt = rt.call_function('mb_substr', [var_excerpt.clone(),
			rt.new_int(0), rt.new_int(200)])
		var_excerpt =
			rt.new_string((var_excerpt.clone().to_string().trim_right(' \t\n\r') + '…').str())
	}
	mut var_site_icon_url := rt.new_string('')
	mut var_icon_nodes :=
		var_xpath.query(rt.new_string("//img[contains(concat(' ', normalize-space(@class), ' '), ' wp-embed-site-icon ')]"))
	mut var_icon_node := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_icon_nodes)))) && rt.is_true(rt.greater(rt.get_property(var_icon_nodes, 'length'), rt.new_int(0))) { rt.call_method(var_icon_nodes, 'item', [
			rt.new_int(0),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_icon_node,
		'Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMElement')))
	{
		mut var_icon_src := rt.call_method(var_icon_node, 'getAttribute', [
			rt.new_string('src'),
		])
		if this.is_valid_url(var_icon_src.str()) {
			var_site_icon_url = var_icon_src.clone()
		}
	}
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'title', val: var_title },
		rt.ArrayItem{ key: 'thumbnail_url', val: var_thumbnail_url },
		rt.ArrayItem{ key: 'provider_name', val: var_provider_name },
		rt.ArrayItem{ key: 'provider_url', val: var_provider_url },
		rt.ArrayItem{ key: 'excerpt', val: var_excerpt }, rt.ArrayItem{
			key: 'site_icon_url'
			val: var_site_icon_url
		}])
	rt.call_function('set_transient', [var_cache_key.clone(),
		var_result.clone(), var_cache_ttl.clone()])
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_link_embed_card(url string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut url_mutated := url
	mut var_embed_data := this.fetch_embed_page_data(url_mutated)
	if !rt.is_true(var_embed_data.array_get(rt.new_string('title'))) {
		return ''
	}
	mut var_title := var_embed_data.array_get(rt.new_string('title'))
	mut var_thumbnail_url := var_embed_data.array_get(rt.new_string('thumbnail_url'))
	mut var_provider_name := if !(!rt.is_true(var_embed_data.array_get(rt.new_string('provider_name')))) { var_embed_data.array_get(rt.new_string('provider_name')) } else { (rt.call_function('wp_parse_url', [
			rt.new_string(url_mutated).clone(),
			rt.get_constant('PHP_URL_HOST'),
		])).str() }
	mut var_provider_url := var_embed_data.array_get(rt.new_string('provider_url'))
	mut var_excerpt := var_embed_data.array_get(rt.new_string('excerpt'))
	mut var_site_icon_url := var_embed_data.array_get(rt.new_string('site_icon_url'))
	mut var_email_styles := var_rendering_context.get_theme_styles()
	mut var_text_color := if !(var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
		var_email_styles.array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	} else {
		rt.new_string('#1e1e1e')
	}
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
	mut iife_result_2 := iife_temp_2.sanitize_color(var_text_color.clone())
	var_text_color = iife_result_2
	mut var_link_color := if !(var_email_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
		var_email_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	} else {
		rt.new_string('#0073aa')
	}
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
	mut iife_result_3 := iife_temp_3.sanitize_color(var_link_color.clone())
	var_link_color = iife_result_3
	mut var_rows_html := rt.new_string('')
	if !(!rt.is_true(var_thumbnail_url)) {
		mut iife_temp_4 :=
			Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
		mut iife_result_4 := iife_temp_4.render_table_cell(rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_blank" rel="noopener nofollow"><img src="%s" alt="%s" style="display: block; width: 100%%; border-radius: 4px 4px 0 0;" /></a>'),
			rt.call_function('esc_url', [rt.new_string(url_mutated).clone()]),
			rt.call_function('esc_url', [var_thumbnail_url.clone()]),
			rt.call_function('esc_attr', [var_title.clone()]),
		]), rt.create_array([rt.ArrayItem{ key: 'style', val: 'padding: 0;' }]))
		mut var_thumbnail_cell := iife_result_4
		var_rows_html = rt.concat(var_rows_html, rt.new_string('<tr>' + var_thumbnail_cell.str() +
			'</tr>'))
	}
	mut var_content_parts := rt.call_function('sprintf', [
		rt.new_string('<a href="%s" target="_blank" rel="noopener nofollow" style="color: %s; text-decoration: none; font-weight: bold;">%s</a>'),
		rt.call_function('esc_url', [rt.new_string(url_mutated).clone()]),
		rt.call_function('esc_attr', [var_text_color.clone()]),
		rt.call_function('esc_html', [var_title.clone()]),
	])
	if !(!rt.is_true(var_excerpt)) {
		var_content_parts = rt.concat(var_content_parts, rt.call_function('sprintf', [
			rt.new_string('<br /><span style="font-size: 14px; color: %s; line-height: 1.4;">%s</span>'),
			rt.call_function('esc_attr', [var_text_color.clone()]),
			rt.call_function('esc_html', [var_excerpt.clone()]),
		]))
		var_content_parts = rt.concat(var_content_parts, rt.call_function('sprintf', [
			rt.new_string(' <a href="%s" target="_blank" rel="noopener nofollow" style="font-size: 14px; color: %s; text-decoration: underline;">%s</a>'),
			rt.call_function('esc_url', [rt.new_string(url_mutated).clone()]),
			rt.call_function('esc_attr', [var_link_color.clone()]),
			rt.call_function('esc_html__', [rt.new_string('Continue reading'),
				rt.new_string('woocommerce')]),
		]))
	}
	mut var_provider_text := if !(!rt.is_true(var_provider_url)) { rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_blank" rel="noopener nofollow" style="font-size: 13px; color: %s; text-decoration: none;">%s</a>'),
			rt.call_function('esc_url', [var_provider_url.clone()]),
			rt.call_function('esc_attr', [var_text_color.clone()]),
			rt.call_function('esc_html', [var_provider_name.clone()]),
		]) } else { rt.call_function('sprintf', [
			rt.new_string('<span style="font-size: 13px; color: %s;">%s</span>'),
			rt.call_function('esc_attr', [var_text_color.clone()]),
			rt.call_function('esc_html', [var_provider_name.clone()]),
		]) }
	if !(!rt.is_true(var_site_icon_url)) {
		var_content_parts = rt.concat(var_content_parts, rt.call_function('sprintf', [
			rt.new_string(
				'<table border="0" cellpadding="0" cellspacing="0" role="presentation" style="margin-top: 16px;">' +
				'<tr>' + '<td style="vertical-align: middle; padding-right: 6px;">' +
				'<img src="%s" width="16" height="16" alt="" style="display: block; border-radius: 2px;" />' +
				'</td>' + '<td style="vertical-align: middle;">%s</td>' + '</tr></table>'),
			rt.call_function('esc_url', [var_site_icon_url.clone()]),
			var_provider_text.clone(),
		]))
	} else {
		var_content_parts = rt.concat(var_content_parts, rt.new_string('<br />' +
			var_provider_text.str()))
	}
	mut iife_temp_5 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_5 := iife_temp_5.render_table_cell(var_content_parts.clone(), rt.create_array([
		rt.ArrayItem{ key: 'style', val: 'padding: 12px;' },
	]))
	mut var_content_cell := iife_result_5
	var_rows_html = rt.concat(var_rows_html,
		rt.new_string('<tr>' + var_content_cell.str() + '</tr>'))
	mut var_card_html := rt.call_function('sprintf', [
		rt.new_string('<table border="0" cellpadding="0" cellspacing="0" role="presentation" style="border: 1px solid #ddd; border-radius: 4px; width: 100%%;">'),
	])
	var_card_html = rt.concat(var_card_html, rt.new_string('<tbody>' + var_rows_html.str() +
		'</tbody></table>'))
	mut iife_temp_6 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_6 := iife_temp_6.render_outlook_table_wrapper(var_card_html.clone(), rt.create_array([
		rt.ArrayItem{ key: 'align', val: 'left' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	]))
	mut var_outlook_wrapped := iife_result_6
	return (this.add_spacer(var_outlook_wrapped.clone(), if !(var_parsed_block.array_get(rt.new_string('email_attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs'))
	} else {
		rt.new_array()
	})).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed) render_compact_link_card(url string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut url_mutated := url
	mut var_email_styles := var_rendering_context.get_theme_styles()
	mut var_link_color := if !(var_email_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))).is_null() {
		var_email_styles.array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_get(rt.new_string('text'))
	} else {
		rt.new_string('#0073aa')
	}
	mut iife_temp_7 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{}
	mut iife_result_7 := iife_temp_7.sanitize_color(var_link_color.clone())
	var_link_color = iife_result_7
	mut var_display_host := rt.new_string((rt.call_function('wp_parse_url', [
		rt.new_string(url_mutated).clone(), rt.get_constant('PHP_URL_HOST')])).str())
	mut var_display_path := rt.new_string((rt.call_function('wp_parse_url', [
		rt.new_string(url_mutated).clone(), rt.get_constant('PHP_URL_PATH')])).str())
	mut var_display_text := rt.new_string(var_display_host.str() + var_display_path.str())
	mut var_link_html := rt.call_function('sprintf', [
		rt.new_string('<a href="%s" target="_blank" rel="noopener nofollow" style="color: %s; text-decoration: none;">%s</a>'),
		rt.call_function('esc_url', [rt.new_string(url_mutated).clone()]),
		rt.call_function('esc_attr', [var_link_color.clone()]),
		rt.call_function('esc_html', [var_display_text.clone()]),
	])
	mut iife_temp_8 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_8 := iife_temp_8.render_table_cell(var_link_html.clone(), rt.create_array([
		rt.ArrayItem{ key: 'style', val: 'padding: 12px;' },
	]))
	mut var_content_cell := iife_result_8
	mut var_card_html :=
		rt.new_string('<table border="0" cellpadding="0" cellspacing="0" role="presentation" style="border: 1px solid #ddd; border-radius: 4px; width: 100%;">')
	var_card_html = rt.concat(var_card_html, rt.new_string('<tbody><tr>' + var_content_cell.str() +
		'</tr></tbody></table>'))
	mut iife_temp_9 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_9 := iife_temp_9.render_outlook_table_wrapper(var_card_html.clone(), rt.create_array([
		rt.ArrayItem{ key: 'align', val: 'left' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	]))
	mut var_outlook_wrapped := iife_result_9
	return (this.add_spacer(var_outlook_wrapped.clone(), if !(var_parsed_block.array_get(rt.new_string('email_attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('email_attrs'))
	} else {
		rt.new_array()
	})).str()
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

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_oEmbed {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMDocument {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMXPath {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_embed(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Embed{
		PhpObjectBase:     rt.PhpObjectBase{}
		embed_fetch_count: rt.new_int(0)
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_audio(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Audio{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_dom_document_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Dom_Document_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_html_processing_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Html_Processing_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_video(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_oembed(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_oEmbed {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_oEmbed{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_domdocument(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_domxpath(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMXPath {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMXPath{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
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
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'get_supported_provider' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_supported_provider(mut dispatch_arg_0, dispatch_arg_1))
		}
		'extract_url_from_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_url_from_content(dispatch_arg_0))
		}
		'extract_provider_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.extract_provider_url(mut dispatch_arg_0, dispatch_arg_1))
		}
		'get_provider_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_provider_label(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_translated_provider_label' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_translated_provider_label(dispatch_arg_0))
		}
		'render_link_fallback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_link_fallback(mut dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2, mut dispatch_arg_3))
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
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_string(this.render_video_embed(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2, mut dispatch_arg_3, dispatch_arg_4))
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
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_link_embed_card(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'render_compact_link_card' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_compact_link_card(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		else {
			return none
		}
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
		'embed_fetch_count' {
			this.embed_fetch_count = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Video) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_oEmbed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_oEmbed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_oEmbed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMXPath) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMXPath) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_DOMXPath) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
