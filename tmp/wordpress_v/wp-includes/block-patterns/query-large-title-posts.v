import rt

pub fn init_wp_includes_block_patterns_query_large_title_posts_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Large title'),
			rt.new_string('Block pattern title'),
		]) },
		rt.ArrayItem{ key: 'blockTypes', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'core/query' },
		]) },
		rt.ArrayItem{ key: 'categories', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'query' },
		]) },
		rt.ArrayItem{
			key: 'content'
			val: '<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"100px","right":"100px","bottom":"100px","left":"100px"}},"color":{"text":"#ffffff","background":"#000000"}}} -->\n\t\t\t\t\t<div class="wp-block-group alignfull has-text-color has-background" style="background-color:#000000;color:#ffffff;padding-top:100px;padding-right:100px;padding-bottom:100px;padding-left:100px"><!-- wp:query {"query":{"perPage":3,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->\n\t\t\t\t\t<div class="wp-block-query"><!-- wp:post-template -->\n\t\t\t\t\t<!-- wp:separator {"customColor":"#ffffff","align":"wide","className":"is-style-wide"} -->\n\t\t\t\t\t<hr class="wp-block-separator alignwide has-text-color has-background is-style-wide" style="background-color:#ffffff;color:#ffffff"/>\n\t\t\t\t\t<!-- /wp:separator -->\n\n\t\t\t\t\t<!-- wp:columns {"verticalAlignment":"center","align":"wide"} -->\n\t\t\t\t\t<div class="wp-block-columns alignwide are-vertically-aligned-center"><!-- wp:column {"verticalAlignment":"center","width":"20%"} -->\n\t\t\t\t\t<div class="wp-block-column is-vertically-aligned-center" style="flex-basis:20%"><!-- wp:post-date {"style":{"color":{"text":"#ffffff"}},"fontSize":"extra-small"} /--></div>\n\t\t\t\t\t<!-- /wp:column -->\n\n\t\t\t\t\t<!-- wp:column {"verticalAlignment":"center","width":"80%"} -->\n\t\t\t\t\t<div class="wp-block-column is-vertically-aligned-center" style="flex-basis:80%"><!-- wp:post-title {"isLink":true,"style":{"typography":{"fontSize":"72px","lineHeight":"1.1"},"color":{"text":"#ffffff","link":"#ffffff"}}} /--></div>\n\t\t\t\t\t<!-- /wp:column --></div>\n\t\t\t\t\t<!-- /wp:columns -->\n\t\t\t\t\t<!-- /wp:post-template --></div>\n\t\t\t\t\t<!-- /wp:query --></div>\n\t\t\t\t\t<!-- /wp:group -->'
		},
	])
}
