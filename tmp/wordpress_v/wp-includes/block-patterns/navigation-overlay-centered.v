import rt

pub fn init_wp_includes_block_patterns_navigation_overlay_centered_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Overlay with centered navigation'),
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
				'"},"style":{"spacing":{"padding":{"right":"var:preset|spacing|40","left":"var:preset|spacing|40","top":"var:preset|spacing|40","bottom":"var:preset|spacing|40"}},"dimensions":{"minHeight":"100vh"},"elements":{"link":{"color":{"text":"var:preset|color|black"}}},"color":{"background":"#eeeeee"}},"textColor":"black","layout":{"type":"default"}} -->\n<div class="wp-block-group has-black-color has-text-color has-background has-link-color" style="background-color:#eeeeee;min-height:100vh;padding-top:var(--wp--preset--spacing--40);padding-right:var(--wp--preset--spacing--40);padding-bottom:var(--wp--preset--spacing--40);padding-left:var(--wp--preset--spacing--40)"><!-- wp:group {"align":"wide","layout":{"type":"flex","flexWrap":"nowrap","justifyContent":"right"}} -->\n<div class="wp-block-group alignwide"><!-- wp:navigation-overlay-close /--></div>\n<!-- /wp:group -->\n\n<!-- wp:group {"align":"wide","style":{"dimensions":{"minHeight":"90vh"}},"layout":{"type":"flex","orientation":"vertical","justifyContent":"center","verticalAlignment":"center"}} -->\n<div class="wp-block-group alignwide" style="min-height:90vh"><!-- wp:navigation {"layout":{"type":"flex","orientation":"vertical","justifyContent":"center"}} /--></div>\n<!-- /wp:group --></div>\n<!-- /wp:group -->'
		},
	])
}
