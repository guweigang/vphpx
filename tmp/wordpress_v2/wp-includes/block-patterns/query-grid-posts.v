import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Grid'), rt.new_string('Block pattern title')]) },
		rt.ArrayItem{ key: 'blockTypes', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'core/query' }]) },
		rt.ArrayItem{ key: 'categories', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'query' }]) },
		rt.ArrayItem{
			key: 'content'
			val: '<!-- wp:query {"query":{"perPage":6,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"exclude","inherit":false},"displayLayout":{"type":"flex","columns":3}} -->\n\t\t\t\t\t<div class="wp-block-query">\n\t\t\t\t\t<!-- wp:post-template -->\n\t\t\t\t\t<!-- wp:group {"style":{"spacing":{"padding":{"top":"30px","right":"30px","bottom":"30px","left":"30px"}}},"layout":{"inherit":false}} -->\n\t\t\t\t\t<div class="wp-block-group" style="padding-top:30px;padding-right:30px;padding-bottom:30px;padding-left:30px"><!-- wp:post-title {"isLink":true} /-->\n\t\t\t\t\t<!-- wp:post-excerpt /-->\n\t\t\t\t\t<!-- wp:post-date /--></div>\n\t\t\t\t\t<!-- /wp:group -->\n\t\t\t\t\t<!-- /wp:post-template -->\n\t\t\t\t\t</div>\n\t\t\t\t\t<!-- /wp:query -->'
		},
	])
}
