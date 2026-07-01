import rt

struct Class_WP_oEmbed {
	rt.PhpObjectBase
pub mut:
		providers rt.PhpVal = rt.new_array()
		early_providers rt.PhpVal = rt.new_array()
		compat_methods rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_oEmbed) construct()  {
	mut var_host := rt.call_function('urlencode', [rt.call_function('home_url', []rt.PhpVal{})])
	mut var_providers := rt.create_array([rt.ArrayItem{ key: '#https?://((m|www)\\.)?youtube\\.com/watch.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.youtube.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://((m|www)\\.)?youtube\\.com/playlist.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.youtube.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://((m|www)\\.)?youtube\\.com/shorts/*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.youtube.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://((m|www)\\.)?youtube\\.com/live/*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.youtube.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://youtu\\.be/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.youtube.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(.+\\.)?vimeo\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://vimeo.com/api/oembed.{format}' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?dailymotion\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.dailymotion.com/services/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://dai\\.ly/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.dailymotion.com/services/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?flickr\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.flickr.com/services/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://flic\\.kr/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.flickr.com/services/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(.+\\.)?smugmug\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://api.smugmug.com/services/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?scribd\\.com/(doc|document)/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.scribd.com/services/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://wordpress\\.tv/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://wordpress.tv/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(.+\\.)?crowdsignal\\.net/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://api.crowdsignal.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(.+\\.)?polldaddy\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://api.crowdsignal.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://poll\\.fm/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://api.crowdsignal.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(.+\\.)?survey\\.fm/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://api.crowdsignal.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?twitter\\.com/\\w{1,15}/status(es)?/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://publish.twitter.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?twitter\\.com/\\w{1,15}$#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://publish.twitter.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?twitter\\.com/\\w{1,15}/likes$#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://publish.twitter.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?twitter\\.com/\\w{1,15}/lists/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://publish.twitter.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?twitter\\.com/\\w{1,15}/timelines/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://publish.twitter.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?twitter\\.com/i/moments/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://publish.twitter.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?soundcloud\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://soundcloud.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(open|play)\\.spotify\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://embed.spotify.com/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(.+\\.)?imgur\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://api.imgur.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?issuu\\.com/.+/docs/.+#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://issuu.com/oembed_wp' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?mixcloud\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://app.mixcloud.com/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.|embed\\.)?ted\\.com/talks/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.ted.com/services/v1/oembed.{format}' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?(animoto|video214)\\.com/play/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://animoto.com/oembeds/create' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(.+)\\.tumblr\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.tumblr.com/oembed/1.0' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?kickstarter\\.com/projects/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.kickstarter.com/services/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://kck\\.st/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.kickstarter.com/services/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://cloudup\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://cloudup.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?reverbnation\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.reverbnation.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://videopress\\.com/v/.*#', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://public-api.wordpress.com/oembed/?for=' + (var_host).str() }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?reddit\\.com/r/[^/]+/comments/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.reddit.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?speakerdeck\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://speakerdeck.com/oembed.{format}' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://([a-z0-9-]+\\.)?amazon\\.(com|com\\.mx|com\\.br|ca)/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.com/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://([a-z0-9-]+\\.)?amazon\\.(co\\.uk|de|fr|it|es|in|nl|ru)/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.co.uk/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://([a-z0-9-]+\\.)?amazon\\.(co\\.jp|com\\.au)/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.com.au/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://([a-z0-9-]+\\.)?amazon\\.cn/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.cn/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?a\\.co/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.com/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?amzn\\.to/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.com/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?amzn\\.eu/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.co.uk/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?amzn\\.in/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.in/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?amzn\\.asia/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.com.au/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?z\\.cn/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://read.amazon.cn/kp/api/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://www\\.someecards\\.com/.+-cards/.+#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.someecards.com/v2/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://www\\.someecards\\.com/usercards/viewcard/.+#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.someecards.com/v2/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://some\\.ly\\/.+#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.someecards.com/v2/oembed/' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?tiktok\\.com/.*/video/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.tiktok.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?tiktok\\.com/@.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.tiktok.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://([a-z]{2}|www)\\.pinterest\\.com(\\.(au|mx))?/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.pinterest.com/oembed.json' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?wolframcloud\\.com/obj/.+#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://www.wolframcloud.com/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://pca\\.st/.+#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://pca.st/oembed.json' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://((play|www)\\.)?anghami\\.com/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://api.anghami.com/rest/v1/oembed.view' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://bsky.app/profile/.*/post/.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://embed.bsky.app/oembed' }, rt.ArrayItem{ key: none, val: true }]) }, rt.ArrayItem{ key: '#https?://(www\\.)?canva\\.com/design/.*/view.*#i', val: rt.create_array([rt.ArrayItem{ key: none, val: 'https://canva.com/_oembed' }, rt.ArrayItem{ key: none, val: true }]) }])
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch.array_get('add'))) {
		{
			mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.array_get('add').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_data := item_1.val
				mut var_format := item_1.key
				var_providers.array_set(var_format, var_data.dup())
			}
		}
	}
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch.array_get('remove'))) {
		{
			mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.array_get('remove').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_format := item_1.val
				var_providers.array_unset(var_format)
			}
		}
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	this.providers = rt.call_function('apply_filters', [rt.new_string('oembed_providers'), var_providers.dup()])
	rt.call_function('add_filter', [rt.new_string('oembed_dataparse'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_oEmbed', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_strip_newlines' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_WP_oEmbed) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), this.compat_methods, rt.new_bool(true)])) {
		return (rt.call_method(rt.new_object('WP_oEmbed', []string{}, &this), var_name, [var_arguments.dup()])).to_bool()
	}
	return false
}

fn (mut this Class_WP_oEmbed) get_provider(var_url rt.PhpVal, args string) rt.PhpVal {
	mut var_providerurl := rt.new_null()
	mut var_regex := rt.new_null()
	mut args_mutated := args
	args_mutated = (rt.call_function('wp_parse_args', [rt.new_string(args_mutated).dup()])).str()
	mut var_provider := rt.new_bool(rt.new_bool(false))
	if !(rt.new_string(args_mutated).array_isset(rt.new_string('discover'))) {
		rt.new_string(args_mutated).array_set('discover', true)
	}
	{
		mut iter_1 := this.providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_matchmask := item_1.key
			// unsupported assign target: Expr_List
			if rt.is_true(rt.new_bool(!(rt.is_true(var_regex)))) {
				var_matchmask = rt.new_string('#' + (rt.call_function('str_replace', [rt.new_string('___wildcard___'), rt.new_string('(.+)'), rt.call_function('preg_quote', [rt.call_function('str_replace', [rt.new_string('*'), rt.new_string('___wildcard___'), var_matchmask.dup()]), rt.new_string('#')])])).str() + '#i')
				var_matchmask = rt.call_function('preg_replace', [rt.new_string('|^#http\\\\://|'), rt.new_string('#https?\\://'), var_matchmask.dup()])
			}
			if rt.is_true(rt.call_function('preg_match', [var_matchmask.dup(), var_url.dup()])) {
				var_provider = rt.call_function('str_replace', [rt.new_string('{format}'), rt.new_string('json'), var_providerurl.dup()])
				break
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_provider)))) && rt.is_true(rt.new_string(args_mutated).array_get('discover')))) {
		var_provider = rt.new_bool(this.discover(var_url.dup()))
	}
	return var_provider.dup()
}

fn Class_WP_oEmbed._add_provider_early(var_format rt.PhpVal, var_provider rt.PhpVal, regex bool)  {
	mut var_provider_mutated := var_provider
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch.array_get('add')) {
		// unsupported expression: Expr_StaticPropertyFetch.array_set('add', rt.new_array())
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_get_mut('add').array_set(var_format, rt.create_array([rt.ArrayItem{ key: none, val: var_provider_mutated }, rt.ArrayItem{ key: none, val: regex }]))
}

fn Class_WP_oEmbed._remove_provider_early(var_format rt.PhpVal)  {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch.array_get('remove')) {
		// unsupported expression: Expr_StaticPropertyFetch.array_set('remove', rt.new_array())
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_get_mut('remove').array_push(var_format.dup())
}

fn (mut this Class_WP_oEmbed) get_data(var_url rt.PhpVal, args string) bool {
	mut args_mutated := args
	args_mutated = (rt.call_function('wp_parse_args', [rt.new_string(args_mutated).dup()])).str()
	mut var_provider := this.get_provider(var_url.dup(), args_mutated)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_provider)))) {
		return false
	}
	return this.fetch(var_provider.dup(), var_url.dup(), args_mutated)
}

fn (mut this Class_WP_oEmbed) get_html(var_url rt.PhpVal, args string) bool {
	mut args_mutated := args
	mut var_pre := rt.call_function('apply_filters', [rt.new_string('pre_oembed_result'), rt.new_null(), var_url.dup(), rt.new_string(args_mutated).dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_pre).to_bool()
	}
	mut var_data := rt.new_bool(this.get_data(var_url.dup(), args_mutated))
	if rt.is_true(rt.identical(rt.new_bool(false), var_data)) {
		return false
	}
	return (rt.call_function('apply_filters', [rt.new_string('oembed_result'), this.data2html(var_data.dup(), var_url.dup()), var_url.dup(), rt.new_string(args_mutated).dup()])).to_bool()
}

fn (mut this Class_WP_oEmbed) discover(var_url rt.PhpVal) bool {
	mut var_links := []rt.PhpVal{}
	mut var_providers := rt.new_array()
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'limit_response_size', val: 153600 }])
	var_args = rt.call_function('apply_filters', [rt.new_string('oembed_remote_get_args'), var_args.dup(), var_url.dup()])
	mut var_request := rt.call_function('wp_safe_remote_get', [var_url.dup(), var_args.dup()])
	mut var_html := rt.call_function('wp_remote_retrieve_body', [var_request.dup()])
	if rt.is_true(var_html) {
		mut var_linktypes := rt.call_function('apply_filters', [rt.new_string('oembed_linktypes'), rt.create_array([rt.ArrayItem{ key: 'application/json+oembed', val: 'json' }, rt.ArrayItem{ key: 'text/xml+oembed', val: 'xml' }, rt.ArrayItem{ key: 'application/xml+oembed', val: 'xml' }])])
		mut var_html_head_end := rt.call_function('stripos', [var_html.dup(), rt.new_string('</head>')])
		if rt.is_true(var_html_head_end) {
			var_html = rt.call_function('substr', [var_html.dup(), rt.new_int(0), var_html_head_end.dup()])
		}
		mut var_tagfound := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := var_linktypes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_format := item_1.val
				mut var_linktype := item_1.key
				if rt.is_true(rt.call_function('stripos', [var_html.dup(), var_linktype.dup()])) {
					var_tagfound = rt.new_bool(rt.new_bool(true))
					break
				}
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_tagfound) && rt.is_true(rt.call_function('preg_match_all', [rt.new_string('#<link([^<>]+)/?>#iU'), var_html.dup(), var_links.dup()])))) {
			{
				mut iter_1 := var_links.array_get(1).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_link := item_1.val
					mut var_atts := rt.call_function('shortcode_parse_atts', [var_link.dup()])
					if !(!rt.is_true(var_atts.array_get('type'))) && !(!rt.is_true(var_linktypes.array_get(var_atts.array_get('type')))) && !(!rt.is_true(var_atts.array_get('href'))) {
						var_providers.array_set(var_linktypes.array_get(var_atts.array_get('type')), rt.call_function('htmlspecialchars_decode', [var_atts.array_get('href')]))
						if rt.is_true(rt.identical(rt.new_string('json'), var_linktypes.array_get(var_atts.array_get('type')))) {
							break
						}
					}
				}
			}
		}
	}
	if !(!rt.is_true(var_providers.array_get('json'))) {
		return (var_providers.array_get('json')).to_bool()
	} else if !(!rt.is_true(var_providers.array_get('xml'))) {
		return (var_providers.array_get('xml')).to_bool()
	} else {
		return false
	}
	return false
}

fn (mut this Class_WP_oEmbed) fetch(var_provider rt.PhpVal, var_url rt.PhpVal, args string) bool {
	mut var_provider_mutated := var_provider
	mut args_mutated := args
	args_mutated = (rt.call_function('wp_parse_args', [rt.new_string(args_mutated).dup(), rt.call_function('wp_embed_defaults', [var_url.dup()])])).str()
	var_provider_mutated = rt.call_function('add_query_arg', [rt.new_string('maxwidth'), // unsupported expression: Expr_Cast_Int, var_provider_mutated.dup()])
	var_provider_mutated = rt.call_function('add_query_arg', [rt.new_string('maxheight'), // unsupported expression: Expr_Cast_Int, var_provider_mutated.dup()])
	var_provider_mutated = rt.call_function('add_query_arg', [rt.new_string('url'), rt.call_function('urlencode', [var_url.dup()]), var_provider_mutated.dup()])
	var_provider_mutated = rt.call_function('add_query_arg', [rt.new_string('dnt'), rt.new_int(1), var_provider_mutated.dup()])
	var_provider_mutated = rt.call_function('apply_filters', [rt.new_string('oembed_fetch_url'), var_provider_mutated.dup(), var_url.dup(), rt.new_string(args_mutated).dup()])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'json' }, rt.ArrayItem{ key: none, val: 'xml' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_format := item_1.val
			mut var_result := rt.new_bool(this._fetch_with_format(var_provider_mutated.dup(), var_format.dup()))
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) && rt.is_true(rt.identical(rt.new_string('not-implemented'), rt.call_method(var_result, 'get_error_code', []rt.PhpVal{}))))) {
				continue
			}
			return (if rt.is_true(rt.new_bool(rt.is_true(var_result) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))))) { var_result } else { rt.new_bool(false) }).to_bool()
		}
	}
	return false
}

fn (mut this Class_WP_oEmbed) _fetch_with_format(var_provider_url_with_args rt.PhpVal, var_format rt.PhpVal) bool {
	mut var_provider_url_with_args_mutated := var_provider_url_with_args
	var_provider_url_with_args_mutated = rt.call_function('add_query_arg', [rt.new_string('format'), var_format.dup(), var_provider_url_with_args_mutated.dup()])
	mut var_args := rt.call_function('apply_filters', [rt.new_string('oembed_remote_get_args'), rt.new_array(), var_provider_url_with_args_mutated.dup()])
	mut var_response := rt.call_function('wp_safe_remote_get', [var_provider_url_with_args_mutated.dup(), var_args.dup()])
	if rt.is_true(rt.identical(rt.new_int(501), rt.call_function('wp_remote_retrieve_response_code', [var_response.dup()]))) {
		return (create_wp_error(rt.new_string('not-implemented'))).to_bool()
	}
	mut var_body := rt.call_function('wp_remote_retrieve_body', [var_response.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_body)))) {
		return false
	}
	mut var_parse_method := rt.new_string(rt.new_string("_parse_${var_format.to_string()}"))
	return (rt.call_method(rt.new_object('WP_oEmbed', []string{}, &this), var_parse_method, [var_body.dup()])).to_bool()
}

fn (mut this Class_WP_oEmbed) _parse_json(var_response_body rt.PhpVal) rt.PhpVal {
	mut var_data := rt.call_function('json_decode', [rt.new_string(var_response_body.dup().to_string().trim_space())])
	return if rt.is_true(rt.new_bool(rt.is_true(var_data) && rt.is_true(rt.new_bool(var_data.dup().is_object())))) { var_data } else { rt.new_bool(false) }
}

fn (mut this Class_WP_oEmbed) _parse_xml(var_response_body rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('libxml_disable_entity_loader')]))))) {
		return false
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) {
		mut var_loader := rt.call_function('libxml_disable_entity_loader', [rt.new_bool(true)])
	}
	mut var_errors := rt.call_function('libxml_use_internal_errors', [rt.new_bool(true)])
	mut var_return := rt.new_bool(this._parse_xml_body(var_response_body.dup()))
	rt.call_function('libxml_use_internal_errors', [var_errors.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000))) && !(var_loader).is_null())) {
		rt.call_function('libxml_disable_entity_loader', [var_loader.dup()])
	}
	return (var_return).to_bool()
}

fn (mut this Class_WP_oEmbed) _parse_xml_body(var_response_body rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('simplexml_import_dom')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument'), rt.new_bool(false)]))))))) {
		return false
	}
	mut var_dom := create_domdocument()
	mut var_success := var_dom.loadxml(var_response_body.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
		return false
	}
	if !(rt.get_property(var_dom, 'doctype')).is_null() {
		return false
	}
	{
		mut iter_1 := rt.get_property(var_dom, 'childNodes').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child := item_1.val
			if rt.is_true(rt.identical(rt.get_constant('XML_DOCUMENT_TYPE_NODE'), rt.get_property(var_child, 'nodeType'))) {
				return false
			}
		}
	}
	mut var_xml := rt.call_function('simplexml_import_dom', [var_dom])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_xml)))) {
		return false
	}
	mut var_return := create_stdclass()
	{
		mut iter_1 := var_xml.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			rt.set_property(var_return, '{"nodeType":"Expr_Variable","line":677,"name":"key"}', // unsupported expression: Expr_Cast_String)
		}
	}
	return (var_return).to_bool()
}

fn (mut this Class_WP_oEmbed) data2html(var_data rt.PhpVal, var_url rt.PhpVal) bool {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(.dup().is_object()))))) || !rt.is_true(rt.get_property(var_data_mutated, 'type')))) {
		return false
	}
	mut var_return := rt.new_bool(rt.new_bool(false))
	mut switch_val_1 := rt.get_property(, 'type')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('photo'))) {
		if !rt.is_true() || !rt.is_true() || !rt.is_true() {
		}
		if rt.is_true() {
		}
		
	} else if rt.is_true(rt.equal(switch_val_1, )) || rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}

fn (mut this Class_WP_oEmbed) _strip_newlines(var_html rt.PhpVal, var_data rt.PhpVal, var_url rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_html_mutated := var_html
	mut var_data_mutated := var_data
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_DOMDocument {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_oembed() &Class_WP_oEmbed {
	mut obj := &Class_WP_oEmbed{
		PhpObjectBase: rt.PhpObjectBase{}
		providers: rt.new_array()
		early_providers: rt.new_array()
		compat_methods: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_domdocument() &Class_DOMDocument {
	mut obj := &Class_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_oEmbed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		'get_provider' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_provider(dispatch_arg_0, dispatch_arg_1)
		}
		'_add_provider_early' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			Class_WP_oEmbed._add_provider_early(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'_remove_provider_early' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WP_oEmbed._remove_provider_early(dispatch_arg_0)
			return rt.new_null()
		}
		'get_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_data(dispatch_arg_0, dispatch_arg_1))
		}
		'get_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_html(dispatch_arg_0, dispatch_arg_1))
		}
		'discover' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.discover(dispatch_arg_0))
		}
		'fetch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.fetch(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'_fetch_with_format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this._fetch_with_format(dispatch_arg_0, dispatch_arg_1))
		}
		'_parse_json' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._parse_json(dispatch_arg_0)
		}
		'_parse_xml' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._parse_xml(dispatch_arg_0))
		}
		'_parse_xml_body' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._parse_xml_body(dispatch_arg_0))
		}
		'data2html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.data2html(dispatch_arg_0, dispatch_arg_1))
		}
		'_strip_newlines' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this._strip_newlines(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WP_oEmbed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'providers' { return this.providers }
		'early_providers' { return this.early_providers }
		'compat_methods' { return this.compat_methods }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_oEmbed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'providers' { this.providers = val; return true }
		'early_providers' { this.early_providers = val; return true }
		'compat_methods' { this.compat_methods = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_class_wp_oembed_php() {
}
