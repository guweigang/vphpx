import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Overlay with site info and CTA'),
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
				'"},"style":{"spacing":{"padding":{"right":"var:preset|spacing|40","left":"var:preset|spacing|40","top":"var:preset|spacing|40","bottom":"var:preset|spacing|40"}},"dimensions":{"minHeight":"100vh"},"elements":{"link":{"color":{"text":"var:preset|color|black"}}}},"backgroundColor":"white","textColor":"black","layout":{"type":"default"}} -->\n<div class="wp-block-group has-black-color has-white-background-color has-text-color has-background has-link-color" style="min-height:100vh;padding-top:var(--wp--preset--spacing--40);padding-right:var(--wp--preset--spacing--40);padding-bottom:var(--wp--preset--spacing--40);padding-left:var(--wp--preset--spacing--40)"><!-- wp:group {"align":"wide","layout":{"type":"flex","flexWrap":"nowrap","justifyContent":"right"}} -->\n<div class="wp-block-group alignwide"><!-- wp:navigation-overlay-close /--></div>\n<!-- /wp:group -->\n\n<!-- wp:group {"align":"wide","layout":{"type":"constrained"}} -->\n<div class="wp-block-group alignwide"><!-- wp:site-logo {"width":80,"isLink":false,"align":"center","className":"is-style-rounded"} /-->\n\n<!-- wp:site-title {"textAlign":"center","fontSize":"large"} /-->\n\n<!-- wp:site-tagline {"textAlign":"center","fontSize":"medium"} /-->\n\n<!-- wp:group {"style":{"spacing":{"padding":{"top":"var:preset|spacing|50","bottom":"var:preset|spacing|50"}}},"layout":{"type":"constrained"}} -->\n<div class="wp-block-group" style="padding-top:var(--wp--preset--spacing--50);padding-bottom:var(--wp--preset--spacing--50)"><!-- wp:navigation {"overlayMenu":"never","style":{"typography":{"textTransform":"uppercase"}},"fontSize":"x-large","layout":{"type":"flex","orientation":"vertical","justifyContent":"center"}} /--></div>\n<!-- /wp:group -->\n\n<!-- wp:group {"align":"full","style":{"border":{"top":{"color":"#eeeeee","width":"1px"}},"spacing":{"padding":{"top":"var:preset|spacing|60","bottom":"var:preset|spacing|60"}}},"layout":{"type":"constrained"}} -->\n<div class="wp-block-group alignfull" style="border-top-color:#eeeeee;border-top-width:1px;padding-top:var(--wp--preset--spacing--60);padding-bottom:var(--wp--preset--spacing--60)"><!-- wp:paragraph {"style":{"typography":{"textAlign":"center"}}} -->\n<p class="has-text-align-center">' +
				(rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Find out how we can help your business.')])])).str() +
				' <a href="#">' +
				(rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Learn more')])])).str() +
				'</a></p>\n<!-- /wp:paragraph -->\n\n<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->\n<div class="wp-block-buttons"><!-- wp:button {"style":{"typography":{"textTransform":"uppercase"}}} -->\n<div class="wp-block-button"><a class="wp-block-button__link wp-element-button" style="text-transform:uppercase">' +
				(rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Get started today!')])])).str() +
				'</a></div>\n<!-- /wp:button -->\n\n<!-- wp:button -->\n<div class="wp-block-button"><a class="wp-block-button__link wp-element-button"></a></div>\n<!-- /wp:button --></div>\n<!-- /wp:buttons --></div>\n<!-- /wp:group --></div>\n<!-- /wp:group --></div>\n<!-- /wp:group -->'
		},
	])
}
