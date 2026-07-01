import rt

pub fn init_wp_includes_block_patterns_query_small_posts_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Small image and title'),
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
			val: '<!-- wp:query {"query":{"perPage":3,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->\n\t\t\t\t\t<div class="wp-block-query">\n\t\t\t\t\t<!-- wp:post-template -->\n\t\t\t\t\t<!-- wp:columns {"verticalAlignment":"center"} -->\n\t\t\t\t\t<div class="wp-block-columns are-vertically-aligned-center"><!-- wp:column {"verticalAlignment":"center","width":"25%"} -->\n\t\t\t\t\t<div class="wp-block-column is-vertically-aligned-center" style="flex-basis:25%"><!-- wp:post-featured-image {"isLink":true} /--></div>\n\t\t\t\t\t<!-- /wp:column -->\n\t\t\t\t\t<!-- wp:column {"verticalAlignment":"center","width":"75%"} -->\n\t\t\t\t\t<div class="wp-block-column is-vertically-aligned-center" style="flex-basis:75%"><!-- wp:post-title {"isLink":true} /--></div>\n\t\t\t\t\t<!-- /wp:column --></div>\n\t\t\t\t\t<!-- /wp:columns -->\n\t\t\t\t\t<!-- /wp:post-template -->\n\t\t\t\t\t</div>\n\t\t\t\t\t<!-- /wp:query -->'
		},
	])
}
