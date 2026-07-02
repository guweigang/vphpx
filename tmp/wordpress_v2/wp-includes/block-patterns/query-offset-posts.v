import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Offset'), rt.new_string('Block pattern title')]) },
		rt.ArrayItem{ key: 'blockTypes', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'core/query' }]) },
		rt.ArrayItem{ key: 'categories', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'query' }]) },
		rt.ArrayItem{
			key: 'content'
			val: '<!-- wp:group {"style":{"spacing":{"padding":{"top":"30px","right":"30px","bottom":"30px","left":"30px"}}},"layout":{"inherit":false}} -->\n\t\t\t\t\t<div class="wp-block-group" style="padding-top:30px;padding-right:30px;padding-bottom:30px;padding-left:30px"><!-- wp:columns -->\n\t\t\t\t\t<div class="wp-block-columns"><!-- wp:column {"width":"50%"} -->\n\t\t\t\t\t<div class="wp-block-column" style="flex-basis:50%"><!-- wp:query {"query":{"perPage":2,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"exclude","inherit":false},"displayLayout":{"type":"list"}} -->\n\t\t\t\t\t<div class="wp-block-query"><!-- wp:post-template -->\n\t\t\t\t\t<!-- wp:post-featured-image /-->\n\t\t\t\t\t<!-- wp:post-title /-->\n\t\t\t\t\t<!-- wp:post-date /-->\n\t\t\t\t\t<!-- wp:spacer {"height":200} -->\n\t\t\t\t\t<div style="height:200px" aria-hidden="true" class="wp-block-spacer"></div>\n\t\t\t\t\t<!-- /wp:spacer -->\n\t\t\t\t\t<!-- /wp:post-template --></div>\n\t\t\t\t\t<!-- /wp:query --></div>\n\t\t\t\t\t<!-- /wp:column -->\n\t\t\t\t\t<!-- wp:column {"width":"50%"} -->\n\t\t\t\t\t<div class="wp-block-column" style="flex-basis:50%"><!-- wp:query {"query":{"perPage":2,"pages":0,"offset":2,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"exclude","inherit":false},"displayLayout":{"type":"list"}} -->\n\t\t\t\t\t<div class="wp-block-query"><!-- wp:post-template -->\n\t\t\t\t\t<!-- wp:spacer {"height":200} -->\n\t\t\t\t\t<div style="height:200px" aria-hidden="true" class="wp-block-spacer"></div>\n\t\t\t\t\t<!-- /wp:spacer -->\n\t\t\t\t\t<!-- wp:post-featured-image /-->\n\t\t\t\t\t<!-- wp:post-title /-->\n\t\t\t\t\t<!-- wp:post-date /-->\n\t\t\t\t\t<!-- /wp:post-template --></div>\n\t\t\t\t\t<!-- /wp:query --></div>\n\t\t\t\t\t<!-- /wp:column --></div>\n\t\t\t\t\t<!-- /wp:columns --></div>\n\t\t\t\t\t<!-- /wp:group -->'
		},
	])
}
