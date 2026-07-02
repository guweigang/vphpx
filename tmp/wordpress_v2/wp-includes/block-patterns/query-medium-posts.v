import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Image at left'),
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
			val: '<!-- wp:query {"query":{"perPage":3,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":false}} -->\n\t\t\t\t\t<div class="wp-block-query">\n\t\t\t\t\t<!-- wp:post-template -->\n\t\t\t\t\t<!-- wp:columns {"align":"wide"} -->\n\t\t\t\t\t<div class="wp-block-columns alignwide"><!-- wp:column {"width":"66.66%"} -->\n\t\t\t\t\t<div class="wp-block-column" style="flex-basis:66.66%"><!-- wp:post-featured-image {"isLink":true} /--></div>\n\t\t\t\t\t<!-- /wp:column -->\n\t\t\t\t\t<!-- wp:column {"width":"33.33%"} -->\n\t\t\t\t\t<div class="wp-block-column" style="flex-basis:33.33%"><!-- wp:post-title {"isLink":true} /-->\n\t\t\t\t\t<!-- wp:post-excerpt /--></div>\n\t\t\t\t\t<!-- /wp:column --></div>\n\t\t\t\t\t<!-- /wp:columns -->\n\t\t\t\t\t<!-- /wp:post-template -->\n\t\t\t\t\t</div>\n\t\t\t\t\t<!-- /wp:query -->'
		},
	])
}
