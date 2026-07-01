import rt

pub fn init_wp_includes_block_patterns_navigation_overlay_accent_bg_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Overlay with orange background'),
			rt.new_string('Block pattern title'),
		]) },
		rt.ArrayItem{ key: 'blockTypes', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'core/template-part/navigation-overlay' },
		]) },
		rt.ArrayItem{ key: 'categories', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'navigation' },
		]) },
		rt.ArrayItem{
			key: 'content'
			val: '<!-- wp:group {"metadata":{"name":"' +
				(rt.call_function('esc_attr', [rt.call_function('__', [rt.new_string('Navigation Overlay')])])).str() +
				'"},"style":{"spacing":{"padding":{"right":"var:preset|spacing|50","left":"var:preset|spacing|50","top":"var:preset|spacing|50","bottom":"var:preset|spacing|50"}},"color":{"background":"#f57600"},"dimensions":{"minHeight":"100vh"},"elements":{"link":{"color":{"text":"var:preset|color|black"}}}},"textColor":"black","layout":{"type":"grid","columnCount":2,"minimumColumnWidth":"600px","rowCount":2,"isManualPlacement":true}} -->\n<div class="wp-block-group has-black-color has-text-color has-background has-link-color" style="background-color:#f57600;min-height:100vh;padding-top:var(--wp--preset--spacing--50);padding-right:var(--wp--preset--spacing--50);padding-bottom:var(--wp--preset--spacing--50);padding-left:var(--wp--preset--spacing--50)"><!-- wp:group {"style":{"layout":{"columnStart":1,"rowStart":1}},"layout":{"type":"default"}} -->\n<div class="wp-block-group"><!-- wp:navigation-overlay-close {"style":{"layout":{"columnStart":1,"rowStart":1}}} /--></div>\n<!-- /wp:group -->\n\n<!-- wp:group {"style":{"typography":{"lineHeight":"0.8"},"layout":{"columnStart":1,"rowStart":2}},"layout":{"type":"flex","orientation":"vertical","verticalAlignment":"bottom"}} -->\n<div class="wp-block-group" style="line-height:0.8"><!-- wp:site-title {"fontSize":"large"} /-->\n\n<!-- wp:site-tagline {"style":{"typography":{"lineHeight":"1.2"},"elements":{"link":{"color":{"text":"#000000a6"}}},"color":{"text":"#000000a6"}},"fontSize":"large"} /--></div>\n<!-- /wp:group -->\n\n<!-- wp:spacer {"height":"10rem","style":{"layout":{"columnStart":2,"rowStart":2}}} -->\n<div style="height:10rem" aria-hidden="true" class="wp-block-spacer"></div>\n<!-- /wp:spacer -->\n\n<!-- wp:navigation {"overlayMenu":"never","style":{"typography":{"lineHeight":"1"},"layout":{"columnStart":2,"rowStart":1}},"fontSize":"large","layout":{"type":"flex","orientation":"vertical"}} /--></div>\n<!-- /wp:group -->'
		},
	])
}
