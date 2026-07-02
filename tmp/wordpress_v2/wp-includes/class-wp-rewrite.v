import rt

struct Class_WP_Rewrite {
	rt.PhpObjectBase
pub mut:
		permalink_structure rt.PhpVal = rt.new_null()
		use_trailing_slashes rt.PhpVal = rt.new_null()
		author_base rt.PhpVal = rt.new_string('author')
		author_structure rt.PhpVal = rt.new_null()
		date_structure rt.PhpVal = rt.new_null()
		page_structure rt.PhpVal = rt.new_null()
		search_base rt.PhpVal = rt.new_string('search')
		search_structure rt.PhpVal = rt.new_null()
		comments_base rt.PhpVal = rt.new_string('comments')
		pagination_base rt.PhpVal = rt.new_string('page')
		comments_pagination_base rt.PhpVal = rt.new_string('comment-page')
		feed_base rt.PhpVal = rt.new_string('feed')
		comment_feed_structure rt.PhpVal = rt.new_null()
		feed_structure rt.PhpVal = rt.new_null()
		front rt.PhpVal = rt.new_null()
		root rt.PhpVal = rt.new_string('')
		index rt.PhpVal = rt.new_string('index.php')
		matches string
		rules rt.PhpVal = rt.new_null()
		extra_rules rt.PhpVal = rt.new_array()
		extra_rules_top rt.PhpVal = rt.new_array()
		non_wp_rules rt.PhpVal = rt.new_array()
		extra_permastructs rt.PhpVal = rt.new_array()
		endpoints rt.PhpVal = rt.new_null()
		use_verbose_rules rt.PhpVal = rt.new_bool(false)
		use_verbose_page_rules bool
		rewritecode rt.PhpVal = rt.new_array()
		rewritereplace rt.PhpVal = rt.new_array()
		queryreplace rt.PhpVal = rt.new_array()
		feeds rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Rewrite) using_permalinks() bool {
	return !(!rt.is_true(this.permalink_structure))
}

fn (mut this Class_WP_Rewrite) using_index_permalinks() bool {
	if !rt.is_true(this.permalink_structure) {
		return false
	}
	return (rt.call_function('preg_match', [rt.new_string('#^/*' + (this.index).str() + '#'), this.permalink_structure])).to_bool()
}

fn (mut this Class_WP_Rewrite) using_mod_rewrite_permalinks() bool {
	return this.using_permalinks() && !(this.using_index_permalinks())
}

fn (mut this Class_WP_Rewrite) preg_index(var_number rt.PhpVal) string {
	mut var_match_prefix := rt.new_string('$')
	mut var_match_suffix := rt.new_string('')
	if !(this.matches == '') {
	var_match_prefix = rt.new_string('$' + this.matches + '[')
	var_match_suffix = rt.new_string(']')
	}
	return "${var_match_prefix.to_string()}${var_number.to_string()}${var_match_suffix.to_string()}"
}

fn (mut this Class_WP_Rewrite) page_uri_index() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_pages := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_name, post_parent FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'page\' AND post_status != \'auto-draft\''))])
	mut var_posts := rt.call_function('get_page_hierarchy', [var_pages.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts)))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: rt.new_array() }])
	}
	var_posts = rt.call_function('array_reverse', [var_posts.clone(), rt.new_bool(true)])
	mut var_page_uris := rt.new_array()
	mut var_page_attachment_uris := rt.new_array()
	mut iter_1 := var_posts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post := item_1.val
		mut var_id := item_1.key
		mut var_uri := rt.call_function('get_page_uri', [var_id.clone()])
		mut var_attachments := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_name, post_parent FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'attachment\' AND post_parent = %d')), var_id.clone()])])
		if !(!rt.is_true(var_attachments)) {
			mut iter_2 := var_attachments.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_attachment := item_2.val
				mut var_attach_uri := rt.call_function('get_page_uri', [rt.get_property(var_attachment, 'ID')])
				var_page_attachment_uris.array_set(var_attach_uri, rt.get_property(var_attachment, 'ID'))
			}
		}
		var_page_uris.array_set(var_uri, var_id.clone())
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_page_uris }, rt.ArrayItem{ key: none, val: var_page_attachment_uris }])
}

fn (mut this Class_WP_Rewrite) page_rewrite_rules() rt.PhpVal {
	this.add_rewrite_tag(rt.new_string('%pagename%'), rt.new_string('(.?.+?)'), rt.new_string('pagename='))
	return this.generate_rewrite_rules(rt.new_bool(this.get_page_permastruct()), rt.get_constant('EP_PAGES'), true, true, false, false, false)
}

fn (mut this Class_WP_Rewrite) get_date_permastruct() bool {
	mut var_tokens := []rt.PhpVal{}
	if !(this.date_structure).is_null() {
		return (this.date_structure).to_bool()
	}
	if !rt.is_true(this.permalink_structure) {
		this.date_structure = rt.new_string('')
		return false
	}
	mut var_endians := ['%year%/%monthnum%/%day%', '%day%/%monthnum%/%year%', '%monthnum%/%day%/%year%']
	this.date_structure = rt.new_string('')
	mut var_date_endian := rt.new_string('')
	for var_endian in var_endians {
		if rt.is_true(rt.call_function('str_contains', [this.permalink_structure, rt.new_string(endian)])) {
			var_date_endian = rt.new_string(endian)
			break
		}
	}
	if !rt.is_true(var_date_endian) {
	var_date_endian = rt.new_string('%year%/%monthnum%/%day%')
	}
	mut var_front := this.front
	rt.call_function('preg_match_all', [rt.new_string('/%.+?%/'), this.permalink_structure, rt.create_array_from_list(var_tokens)])
	mut var_tok_index := rt.new_int(1)
	mut iter_3 := rt.cast_array(var_tokens.array_get(rt.new_int(0))).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_token := item_3.val
		if rt.is_true(rt.identical(rt.new_string('%post_id%'), var_token)) && rt.is_true(rt.less_equal(var_tok_index, rt.new_int(3))) {
			var_front = rt.new_string((var_front).str() + 'date/')
			break
		}
		rt.pre_inc(var_tok_index)
	}
	this.date_structure = (var_front).str() + (var_date_endian).str()
	return (this.date_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_year_permastruct() bool {
	mut var_structure := rt.new_bool(this.get_date_permastruct())
	if !rt.is_true(var_structure) {
		return false
	}
	var_structure = rt.call_function('str_replace', [rt.new_string('%monthnum%'), rt.new_string(''), var_structure.clone()])
	var_structure = rt.call_function('str_replace', [rt.new_string('%day%'), rt.new_string(''), var_structure.clone()])
	var_structure = rt.call_function('preg_replace', [rt.new_string('#/+#'), rt.new_string('/'), var_structure.clone()])
	return (var_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_month_permastruct() bool {
	mut var_structure := rt.new_bool(this.get_date_permastruct())
	if !rt.is_true(var_structure) {
		return false
	}
	var_structure = rt.call_function('str_replace', [rt.new_string('%day%'), rt.new_string(''), var_structure.clone()])
	var_structure = rt.call_function('preg_replace', [rt.new_string('#/+#'), rt.new_string('/'), var_structure.clone()])
	return (var_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_day_permastruct() rt.PhpVal {
	return rt.new_bool(this.get_date_permastruct())
}

fn (mut this Class_WP_Rewrite) get_category_permastruct() rt.PhpVal {
	return rt.new_bool(this.get_extra_permastruct(rt.new_string('category')))
}

fn (mut this Class_WP_Rewrite) get_tag_permastruct() rt.PhpVal {
	return rt.new_bool(this.get_extra_permastruct(rt.new_string('post_tag')))
}

fn (mut this Class_WP_Rewrite) get_extra_permastruct(var_name rt.PhpVal) bool {
	if !rt.is_true(this.permalink_structure) {
		return false
	}
	if this.extra_permastructs.array_isset(var_name) {
		return (this.extra_permastructs.array_get(var_name).array_get(rt.new_string('struct'))).to_bool()
	}
	return false
}

fn (mut this Class_WP_Rewrite) get_author_permastruct() bool {
	if !(this.author_structure).is_null() {
		return (this.author_structure).to_bool()
	}
	if !rt.is_true(this.permalink_structure) {
		this.author_structure = rt.new_string('')
		return false
	}
	this.author_structure = (this.front).str() + (this.author_base).str() + '/%author%'
	return (this.author_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_search_permastruct() bool {
	if !(this.search_structure).is_null() {
		return (this.search_structure).to_bool()
	}
	if !rt.is_true(this.permalink_structure) {
		this.search_structure = rt.new_string('')
		return false
	}
	this.search_structure = (this.root).str() + (this.search_base).str() + '/%search%'
	return (this.search_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_page_permastruct() bool {
	if !(this.page_structure).is_null() {
		return (this.page_structure).to_bool()
	}
	if !rt.is_true(this.permalink_structure) {
		this.page_structure = rt.new_string('')
		return false
	}
	this.page_structure = (this.root).str() + '%pagename%'
	return (this.page_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_feed_permastruct() bool {
	if !(this.feed_structure).is_null() {
		return (this.feed_structure).to_bool()
	}
	if !rt.is_true(this.permalink_structure) {
		this.feed_structure = rt.new_string('')
		return false
	}
	this.feed_structure = (this.root).str() + (this.feed_base).str() + '/%feed%'
	return (this.feed_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_comment_feed_permastruct() bool {
	if !(this.comment_feed_structure).is_null() {
		return (this.comment_feed_structure).to_bool()
	}
	if !rt.is_true(this.permalink_structure) {
		this.comment_feed_structure = rt.new_string('')
		return false
	}
	this.comment_feed_structure = (this.root).str() + (this.comments_base).str() + '/' + (this.feed_base).str() + '/%feed%'
	return (this.comment_feed_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) add_rewrite_tag(var_tag rt.PhpVal, var_regex rt.PhpVal, var_query rt.PhpVal) {
	mut var_query_mutated := var_query
	mut var_position := rt.call_function('array_search', [var_tag.clone(), this.rewritecode, rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_position)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_position)))) {
		this.rewritereplace.array_set(var_position, var_regex.clone())
		this.queryreplace.array_set(var_position, var_query_mutated.clone())
	} else {
		this.rewritecode.array_push(var_tag.clone())
		this.rewritereplace.array_push(var_regex.clone())
		this.queryreplace.array_push(var_query_mutated.clone())
	}
}

fn (mut this Class_WP_Rewrite) remove_rewrite_tag(var_tag rt.PhpVal) {
	mut var_position := rt.call_function('array_search', [var_tag.clone(), this.rewritecode, rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_position)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_position)))) {
		this.rewritecode.array_unset(var_position)
		this.rewritereplace.array_unset(var_position)
		this.queryreplace.array_unset(var_position)
	}
}

fn (mut this Class_WP_Rewrite) generate_rewrite_rules(var_permalink_structure rt.PhpVal, var_ep_mask rt.PhpVal, paged bool, feed bool, forcomments bool, walk_dirs bool, endpoints bool) rt.PhpVal {
	mut var_tokens := []rt.PhpVal{}
	mut var_toks := rt.new_null()
	mut var_feedregex2 := rt.new_string('')
	mut iter_4 := rt.cast_array(this.feeds).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_feed_name := item_4.val
		var_feedregex2 = rt.concat(var_feedregex2, rt.new_string((var_feed_name).str() + '|'))
	}
	var_feedregex2 = rt.new_string('(' + var_feedregex2.clone().to_string().trim_space() + ')/?$')
	mut var_feedregex := rt.new_string((this.feed_base).str() + '/' + (var_feedregex2).str())
	mut var_trackbackregex := rt.new_string('trackback/?$')
	mut var_pageregex := rt.new_string((this.pagination_base).str() + '/?([0-9]{1,})/?$')
	mut var_commentregex := rt.new_string((this.comments_pagination_base).str() + '-([0-9]{1,})/?$')
	mut var_embedregex := rt.new_string('embed/?$')
	if var_endpoints {
		mut var_ep_query_append := rt.new_array()
		mut iter_5 := rt.cast_array(this.endpoints).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_endpoint := item_5.val
			mut var_epmatch := rt.new_string((var_endpoint.array_get(rt.new_int(1))).str() + '(/(.*))?/?$')
			mut var_epquery := rt.new_string('&' + (var_endpoint.array_get(rt.new_int(2))).str() + '=')
			var_ep_query_append.array_set(var_epmatch, rt.create_array([rt.ArrayItem{ key: none, val: var_endpoint.array_get(rt.new_int(0)) }, rt.ArrayItem{ key: none, val: var_epquery }]))
		}
	}
	mut var_front := rt.call_function('substr', [var_permalink_structure.clone(), rt.new_int(0), rt.call_function('strpos', [var_permalink_structure.clone(), rt.new_string('%')])])
	rt.call_function('preg_match_all', [rt.new_string('/%.+?%/'), var_permalink_structure.clone(), rt.create_array_from_list(var_tokens)])
	mut var_num_tokens := rt.new_int(var_tokens.array_get(rt.new_int(0)).array_count())
	mut var_index := this.index
	mut var_feedindex := var_index.clone()
	mut var_trackbackindex := var_index.clone()
	mut var_embedindex := var_index.clone()
	mut var_queries := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_num_tokens))) { break }
		if rt.is_true(rt.less(rt.new_int(0), var_i)) {
			var_queries.array_set(var_i, (var_queries.array_get(rt.sub(var_i, rt.new_int(1)))).str() + '&')
		} else {
			var_queries.array_set(var_i, '')
		}
		mut var_query_token := rt.new_string((rt.call_function('str_replace', [this.rewritecode, this.queryreplace, var_tokens.array_get(rt.new_int(0)).array_get(var_i)])).str() + this.preg_index(rt.add(var_i, rt.new_int(1))))
		var_queries.array_get(var_i) = rt.concat(var_queries.array_get(var_i), var_query_token)
		rt.pre_inc(var_i)
	}
	mut var_structure := var_permalink_structure
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), var_front)))) {
	var_structure = rt.call_function('str_replace', [var_front.clone(), rt.new_string(''), var_structure.clone()])
	}
	var_structure = rt.new_string(var_structure.clone().to_string().trim_space())
	mut var_dirs := if var_walk_dirs { rt.call_function('explode', [rt.new_string('/'), var_structure.clone()]) } else { rt.create_array([rt.ArrayItem{ key: none, val: var_structure }]) }
	mut var_num_dirs := rt.new_int(var_dirs.clone().array_count())
	var_front = rt.call_function('preg_replace', [rt.new_string('|^/+|'), rt.new_string(''), var_front.clone()])
	mut var_post_rewrite := rt.new_array()
	mut var_struct := var_front.clone()
	mut var_j := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_j, var_num_dirs))) { break }
		var_struct = rt.concat(var_struct, rt.new_string((var_dirs.array_get(var_j)).str() + '/'))
		var_struct = rt.new_string(var_struct.clone().to_string().trim_left(' \t\n\r'))
		mut var_match := rt.call_function('str_replace', [this.rewritecode, this.rewritereplace, var_struct.clone()])
		mut var_num_toks := rt.call_function('preg_match_all', [rt.new_string('/%.+?%/'), var_struct.clone(), var_toks.clone()])
		mut var_query := if !(!rt.is_true(var_num_toks)) && var_queries.array_isset(rt.sub(var_num_toks, rt.new_int(1))) { var_queries.array_get(rt.sub(var_num_toks, rt.new_int(1))) } else { rt.new_string('') }
		mut switch_val_1 := var_dirs.array_get(var_j)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('%year%'))) {
		mut var_ep_mask_specific := rt.get_constant('EP_YEAR')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('%monthnum%'))) {
		var_ep_mask_specific = rt.get_constant('EP_MONTH')
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('%day%'))) {
		var_ep_mask_specific = rt.get_constant('EP_DAY')
		} else {
		var_ep_mask_specific = rt.get_constant('EP_NONE')
		}
		mut var_pagematch := rt.new_string((var_match).str() + (var_pageregex).str())
		mut var_pagequery := rt.new_string((var_index).str() + '?' + (var_query).str() + '&paged=' + this.preg_index(rt.add(var_num_toks, rt.new_int(1))))
		mut var_commentmatch := rt.new_string((var_match).str() + (var_commentregex).str())
		mut var_commentquery := rt.new_string((var_index).str() + '?' + (var_query).str() + '&cpage=' + this.preg_index(rt.add(var_num_toks, rt.new_int(1))))
		if rt.is_true(rt.call_function('get_option', [rt.new_string('page_on_front')])) {
		mut var_rootcommentmatch := rt.new_string((var_match).str() + (var_commentregex).str())
		mut var_rootcommentquery := rt.new_string((var_index).str() + '?' + (var_query).str() + '&page_id=' + (rt.call_function('get_option', [rt.new_string('page_on_front')])).str() + '&cpage=' + this.preg_index(rt.add(var_num_toks, rt.new_int(1))))
		}
		mut var_feedmatch := rt.new_string((var_match).str() + (var_feedregex).str())
		mut var_feedquery := rt.new_string((var_feedindex).str() + '?' + (var_query).str() + '&feed=' + this.preg_index(rt.add(var_num_toks, rt.new_int(1))))
		mut var_feedmatch2 := rt.new_string((var_match).str() + (var_feedregex2).str())
		mut var_feedquery2 := rt.new_string((var_feedindex).str() + '?' + (var_query).str() + '&feed=' + this.preg_index(rt.add(var_num_toks, rt.new_int(1))))
		mut var_embedmatch := rt.new_string((var_match).str() + (var_embedregex).str())
		mut var_embedquery := rt.new_string((var_embedindex).str() + '?' + (var_query).str() + '&embed=true')
		if var_forcomments {
			var_feedquery = rt.concat(var_feedquery, rt.new_string('&withcomments=1'))
			var_feedquery2 = rt.concat(var_feedquery2, rt.new_string('&withcomments=1'))
		}
		mut var_rewrite := rt.new_array()
		if var_feed {
		var_rewrite = rt.create_array([rt.ArrayItem{ key: var_feedmatch, val: var_feedquery }, rt.ArrayItem{ key: var_feedmatch2, val: var_feedquery2 }, rt.ArrayItem{ key: var_embedmatch, val: var_embedquery }])
		}
		if var_paged {
		var_rewrite = rt.call_function('array_merge', [var_rewrite.clone(), rt.create_array([rt.ArrayItem{ key: var_pagematch, val: var_pagequery }])])
		}
		if rt.is_true(rt.bitwise_and(rt.get_constant('EP_PAGES'), var_ep_mask)) || rt.is_true(rt.bitwise_and(rt.get_constant('EP_PERMALINK'), var_ep_mask)) {
		var_rewrite = rt.call_function('array_merge', [var_rewrite.clone(), rt.create_array([rt.ArrayItem{ key: var_commentmatch, val: var_commentquery }])])
		} else if rt.is_true(rt.bitwise_and(rt.get_constant('EP_ROOT'), var_ep_mask)) && rt.is_true(rt.call_function('get_option', [rt.new_string('page_on_front')])) {
		var_rewrite = rt.call_function('array_merge', [var_rewrite.clone(), rt.create_array([rt.ArrayItem{ key: var_rootcommentmatch, val: var_rootcommentquery }])])
		}
		if var_endpoints {
			mut iter_6 := rt.cast_array(var_ep_query_append).iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_ep := item_6.val
				mut var_regex := item_6.key
				if rt.is_true(rt.bitwise_and(var_ep.array_get(rt.new_int(0)), var_ep_mask)) || rt.is_true(rt.bitwise_and(var_ep.array_get(rt.new_int(0)), var_ep_mask_specific)) {
					var_rewrite.array_set((var_match).str() + (var_regex).str(), (var_index).str() + '?' + (var_query).str() + (var_ep.array_get(rt.new_int(1))).str() + this.preg_index(rt.add(var_num_toks, rt.new_int(2))))
				}
			}
		}
		if rt.is_true(var_num_toks) {
			mut var_post := rt.new_bool(false)
			mut var_page := rt.new_bool(false)
			if rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%postname%')])) || rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%post_id%')])) || rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%pagename%')])) || (rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%year%')])) && rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%monthnum%')])) && rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%day%')])) && rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%hour%')])) && rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%minute%')])) && rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%second%')]))) {
				var_post = rt.new_bool(true)
				if rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string('%pagename%')])) {
				var_page = rt.new_bool(true)
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
				mut iter_7 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: '_builtin', val: false }])]).iterator()
				for {
					item_7 := iter_7.next() or { break }
					mut var_ptype := item_7.val
					if rt.is_true(rt.call_function('str_contains', [var_struct.clone(), rt.new_string("%${var_ptype.to_string()}%")])) {
						var_post = rt.new_bool(true)
						var_page = rt.call_function('is_post_type_hierarchical', [var_ptype.clone()])
						break
					}
				}
			}
			if rt.is_true(var_post) {
				mut var_trackbackmatch := rt.new_string((var_match).str() + (var_trackbackregex).str())
				mut var_trackbackquery := rt.new_string((var_trackbackindex).str() + '?' + (var_query).str() + '&tb=1')
				var_embedmatch = rt.new_string((var_match).str() + (var_embedregex).str())
				var_embedquery = rt.new_string((var_embedindex).str() + '?' + (var_query).str() + '&embed=true')
				var_match = rt.new_string(var_match.clone().to_string().trim_right(' \t\n\r'))
				mut var_submatchbase := rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '(' }, rt.ArrayItem{ key: none, val: ')' }]), rt.new_string(''), var_match.clone()])
				mut var_sub1 := rt.new_string((var_submatchbase).str() + '/([^/]+)/')
				mut var_sub1tb := rt.new_string((var_sub1).str() + (var_trackbackregex).str())
				mut var_sub1feed := rt.new_string((var_sub1).str() + (var_feedregex).str())
				mut var_sub1feed2 := rt.new_string((var_sub1).str() + (var_feedregex2).str())
				mut var_sub1comment := rt.new_string((var_sub1).str() + (var_commentregex).str())
				mut var_sub1embed := rt.new_string((var_sub1).str() + (var_embedregex).str())
				mut var_sub2 := rt.new_string((var_submatchbase).str() + '/attachment/([^/]+)/')
				mut var_sub2tb := rt.new_string((var_sub2).str() + (var_trackbackregex).str())
				mut var_sub2feed := rt.new_string((var_sub2).str() + (var_feedregex).str())
				mut var_sub2feed2 := rt.new_string((var_sub2).str() + (var_feedregex2).str())
				mut var_sub2comment := rt.new_string((var_sub2).str() + (var_commentregex).str())
				mut var_sub2embed := rt.new_string((var_sub2).str() + (var_embedregex).str())
				mut var_subquery := rt.new_string((var_index).str() + '?attachment=' + this.preg_index(rt.new_int(1)))
				mut var_subtbquery := rt.new_string((var_subquery).str() + '&tb=1')
				mut var_subfeedquery := rt.new_string((var_subquery).str() + '&feed=' + this.preg_index(rt.new_int(2)))
				mut var_subcommentquery := rt.new_string((var_subquery).str() + '&cpage=' + this.preg_index(rt.new_int(2)))
				mut var_subembedquery := rt.new_string((var_subquery).str() + '&embed=true')
				if !(!(endpoints)) {
					mut iter_8 := rt.cast_array(var_ep_query_append).iterator()
					for {
						item_8 := iter_8.next() or { break }
						mut var_ep := item_8.val
						mut var_regex := item_8.key
						if rt.is_true(rt.bitwise_and(var_ep.array_get(rt.new_int(0)), rt.get_constant('EP_ATTACHMENT'))) {
							var_rewrite.array_set((var_sub1).str() + (var_regex).str(), (var_subquery).str() + (var_ep.array_get(rt.new_int(1))).str() + this.preg_index(rt.new_int(3)))
							var_rewrite.array_set((var_sub2).str() + (var_regex).str(), (var_subquery).str() + (var_ep.array_get(rt.new_int(1))).str() + this.preg_index(rt.new_int(3)))
						}
					}
				}
				var_sub1 = rt.concat(var_sub1, rt.new_string('?$'))
				var_sub2 = rt.concat(var_sub2, rt.new_string('?$'))
			var_match = rt.new_string((var_match).str() + '(?:/([0-9]+))?/?$')
			var_query = rt.new_string((var_index).str() + '?' + (var_query).str() + '&page=' + this.preg_index(rt.add(var_num_toks, rt.new_int(1))))
			} else {
				var_match = rt.concat(var_match, rt.new_string('?$'))
			var_query = rt.new_string((var_index).str() + '?' + (var_query).str())
			}
			var_rewrite = rt.call_function('array_merge', [var_rewrite.clone(), rt.create_array([rt.ArrayItem{ key: var_match, val: var_query }])])
			if rt.is_true(var_post) {
				var_rewrite = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: var_trackbackmatch, val: var_trackbackquery }]), var_rewrite.clone()])
				var_rewrite = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: var_embedmatch, val: var_embedquery }]), var_rewrite.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
				var_rewrite = rt.call_function('array_merge', [var_rewrite.clone(), rt.create_array([rt.ArrayItem{ key: var_sub1, val: var_subquery }, rt.ArrayItem{ key: var_sub1tb, val: var_subtbquery }, rt.ArrayItem{ key: var_sub1feed, val: var_subfeedquery }, rt.ArrayItem{ key: var_sub1feed2, val: var_subfeedquery }, rt.ArrayItem{ key: var_sub1comment, val: var_subcommentquery }, rt.ArrayItem{ key: var_sub1embed, val: var_subembedquery }])])
				}
			var_rewrite = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: var_sub2, val: var_subquery }, rt.ArrayItem{ key: var_sub2tb, val: var_subtbquery }, rt.ArrayItem{ key: var_sub2feed, val: var_subfeedquery }, rt.ArrayItem{ key: var_sub2feed2, val: var_subfeedquery }, rt.ArrayItem{ key: var_sub2comment, val: var_subcommentquery }, rt.ArrayItem{ key: var_sub2embed, val: var_subembedquery }]), var_rewrite.clone()])
			}
		}
		var_post_rewrite = rt.call_function('array_merge', [var_rewrite.clone(), var_post_rewrite.clone()])
		rt.pre_inc(var_j)
	}
	return var_post_rewrite.clone()
}

fn (mut this Class_WP_Rewrite) generate_rewrite_rule(var_permalink_structure rt.PhpVal, walk_dirs bool) rt.PhpVal {
	return this.generate_rewrite_rules(var_permalink_structure.clone(), rt.get_constant('EP_NONE'), false, false, false, walk_dirs, false)
}

fn (mut this Class_WP_Rewrite) rewrite_rules() rt.PhpVal {
	mut var_rewrite := rt.new_array()
	if !rt.is_true(this.permalink_structure) {
		return var_rewrite.clone()
	}
	mut var_home_path := rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	mut var_robots_rewrite := if !rt.is_true(var_home_path.array_get(rt.new_string('path'))) || rt.is_true(rt.identical(rt.new_string('/'), var_home_path.array_get(rt.new_string('path')))) { rt.create_array([rt.ArrayItem{ key: 'robots\\.txt$', val: (this.index).str() + '?robots=1' }]) } else { rt.new_array() }
	mut var_favicon_rewrite := if !rt.is_true(var_home_path.array_get(rt.new_string('path'))) || rt.is_true(rt.identical(rt.new_string('/'), var_home_path.array_get(rt.new_string('path')))) { rt.create_array([rt.ArrayItem{ key: 'favicon\\.ico$', val: (this.index).str() + '?favicon=1' }]) } else { rt.new_array() }
	mut var_sitemap_rewrite := if !rt.is_true(var_home_path.array_get(rt.new_string('path'))) || rt.is_true(rt.identical(rt.new_string('/'), var_home_path.array_get(rt.new_string('path')))) { rt.create_array([rt.ArrayItem{ key: 'sitemap\\.xml', val: (this.index).str() + '?sitemap=index' }]) } else { rt.new_array() }
	mut var_deprecated_files := { '.*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$': (this.index).str() + '?feed=old', '.*wp-app\\.php(/.*)?$': (this.index).str() + '?error=403' }
	mut var_registration_pages := rt.new_array()
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})) {
		var_registration_pages['.*wp-signup.php$'] = (this.index).str() + '?signup=true'
		var_registration_pages['.*wp-activate.php$'] = (this.index).str() + '?activate=true'
	}
	var_registration_pages['.*wp-register.php$'] = (this.index).str() + '?register=true'
	mut var_post_rewrite := this.generate_rewrite_rules(this.permalink_structure, rt.get_constant('EP_PERMALINK'), false, false, false, false, false)
	var_post_rewrite = rt.call_function('apply_filters', [rt.new_string('post_rewrite_rules'), var_post_rewrite.clone()])
	mut var_date_rewrite := this.generate_rewrite_rules(rt.new_bool(this.get_date_permastruct()), rt.get_constant('EP_DATE'), false, false, false, false, false)
	var_date_rewrite = rt.call_function('apply_filters', [rt.new_string('date_rewrite_rules'), var_date_rewrite.clone()])
	mut var_root_rewrite := this.generate_rewrite_rules(rt.new_string((this.root).str() + '/'), rt.get_constant('EP_ROOT'), false, false, false, false, false)
	var_root_rewrite = rt.call_function('apply_filters', [rt.new_string('root_rewrite_rules'), var_root_rewrite.clone()])
	mut var_comments_rewrite := this.generate_rewrite_rules(rt.new_string((this.root).str() + (this.comments_base).str()), rt.get_constant('EP_COMMENTS'), false, true, true, false, false)
	var_comments_rewrite = rt.call_function('apply_filters', [rt.new_string('comments_rewrite_rules'), var_comments_rewrite.clone()])
	mut var_search_structure := rt.new_bool(this.get_search_permastruct())
	mut var_search_rewrite := this.generate_rewrite_rules(var_search_structure.clone(), rt.get_constant('EP_SEARCH'), false, false, false, false, false)
	var_search_rewrite = rt.call_function('apply_filters', [rt.new_string('search_rewrite_rules'), var_search_rewrite.clone()])
	mut var_author_rewrite := this.generate_rewrite_rules(rt.new_bool(this.get_author_permastruct()), rt.get_constant('EP_AUTHORS'), false, false, false, false, false)
	var_author_rewrite = rt.call_function('apply_filters', [rt.new_string('author_rewrite_rules'), var_author_rewrite.clone()])
	mut var_page_rewrite := this.page_rewrite_rules()
	var_page_rewrite = rt.call_function('apply_filters', [rt.new_string('page_rewrite_rules'), var_page_rewrite.clone()])
	mut iter_9 := this.extra_permastructs.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_struct := item_9.val
		mut var_permastructname := item_9.key
		if rt.is_true(rt.new_bool(var_struct.clone().is_array())) {
			if var_struct.clone().array_count() == 2 {
			mut var_rules := this.generate_rewrite_rules(var_struct.array_get(rt.new_int(0)), var_struct.array_get(rt.new_int(1)), false, false, false, false, false)
			} else {
			var_rules = this.generate_rewrite_rules(var_struct.array_get(rt.new_string('struct')), var_struct.array_get(rt.new_string('ep_mask')), (var_struct.array_get(rt.new_string('paged'))).to_bool(), (var_struct.array_get(rt.new_string('feed'))).to_bool(), (var_struct.array_get(rt.new_string('forcomments'))).to_bool(), (var_struct.array_get(rt.new_string('walk_dirs'))).to_bool(), (var_struct.array_get(rt.new_string('endpoints'))).to_bool())
			}
		} else {
		var_rules = this.generate_rewrite_rules(var_struct.clone(), rt.new_null(), false, false, false, false, false)
		}
		var_rules = rt.call_function('apply_filters', [rt.new_string("${var_permastructname.to_string()}_rewrite_rules"), var_rules.clone()])
		if rt.is_true(rt.identical(rt.new_string('post_tag'), var_permastructname)) {
		var_rules = rt.call_function('apply_filters_deprecated', [rt.new_string('tag_rewrite_rules'), rt.create_array([rt.ArrayItem{ key: none, val: var_rules }]), rt.new_string('3.1.0'), rt.new_string('post_tag_rewrite_rules')])
		}
		this.extra_rules_top = rt.call_function('array_merge', [this.extra_rules_top, var_rules.clone()])
	}
	if this.use_verbose_page_rules {
		this.rules = rt.call_function('array_merge', [this.extra_rules_top, var_robots_rewrite.clone(), var_favicon_rewrite.clone(), var_sitemap_rewrite.clone(), rt.create_array_from_native_map(var_deprecated_files), rt.create_array_from_native_map(var_registration_pages), var_root_rewrite.clone(), var_comments_rewrite.clone(), var_search_rewrite.clone(), var_author_rewrite.clone(), var_date_rewrite.clone(), var_page_rewrite.clone(), var_post_rewrite.clone(), this.extra_rules])
	} else {
		this.rules = rt.call_function('array_merge', [this.extra_rules_top, var_robots_rewrite.clone(), var_favicon_rewrite.clone(), var_sitemap_rewrite.clone(), rt.create_array_from_native_map(var_deprecated_files), rt.create_array_from_native_map(var_registration_pages), var_root_rewrite.clone(), var_comments_rewrite.clone(), var_search_rewrite.clone(), var_author_rewrite.clone(), var_date_rewrite.clone(), var_post_rewrite.clone(), var_page_rewrite.clone(), this.extra_rules])
	}
	rt.call_function('do_action_ref_array', [rt.new_string('generate_rewrite_rules'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Rewrite', []string{}, &this) }])])
	this.rules = rt.call_function('apply_filters', [rt.new_string('rewrite_rules_array'), this.rules])
	return this.rules
}

fn (mut this Class_WP_Rewrite) wp_rewrite_rules() rt.PhpVal {
	this.rules = rt.call_function('get_option', [rt.new_string('rewrite_rules')])
	if !rt.is_true(this.rules) {
		this.refresh_rewrite_rules()
	}
	return this.rules
}

fn (mut this Class_WP_Rewrite) refresh_rewrite_rules() {
	this.rules = rt.new_string('')
	this.matches = 'matches'
	this.rewrite_rules()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
		rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Rewrite', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'flush_rules' }])])
	} else {
		rt.call_function('update_option', [rt.new_string('rewrite_rules'), this.rules])
	}
}

fn (mut this Class_WP_Rewrite) mod_rewrite_rules() string {
	if !(this.using_permalinks()) {
		return ''
	}
	mut var_site_root := rt.call_function('parse_url', [rt.call_function('site_url', []rt.PhpVal{})])
	if var_site_root.array_isset(rt.new_string('path')) {
	var_site_root = rt.call_function('trailingslashit', [var_site_root.array_get(rt.new_string('path'))])
	}
	mut var_home_root := rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	if var_home_root.array_isset(rt.new_string('path')) {
	var_home_root = rt.call_function('trailingslashit', [var_home_root.array_get(rt.new_string('path'))])
	} else {
	var_home_root = rt.new_string('/')
	}
	mut var_rules := rt.new_string('<IfModule mod_rewrite.c>\n')
	var_rules = rt.concat(var_rules, rt.new_string('RewriteEngine On\n'))
	var_rules = rt.concat(var_rules, rt.new_string('RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]\n'))
	var_rules = rt.concat(var_rules, rt.new_string("RewriteBase ${var_home_root.to_string()}\n"))
	var_rules = rt.concat(var_rules, rt.new_string('RewriteRule ^index\\.php$ - [L]\n'))
	mut iter_10 := rt.cast_array(this.non_wp_rules).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_query := item_10.val
		mut var_match := item_10.key
		var_match = rt.call_function('str_replace', [rt.new_string('.+?'), rt.new_string('.+'), var_match.clone()])
		var_rules = rt.concat(var_rules, rt.new_string('RewriteRule ^' + (var_match).str() + ' ' + (var_home_root).str() + (var_query).str() + ' [QSA,L]\n'))
	}
	if rt.is_true(this.use_verbose_rules) {
		this.matches = ''
		mut var_rewrite := this.rewrite_rules()
		mut var_num_rules := rt.new_int(var_rewrite.clone().array_count())
		var_rules = rt.concat(var_rules, rt.new_string('RewriteCond %{REQUEST_FILENAME} -f [OR]\n' + 'RewriteCond %{REQUEST_FILENAME} -d\n' + rt.concat(rt.concat(rt.new_string('RewriteRule ^.*$ - [S='), var_num_rules), rt.new_string(']\n'))))
		mut iter_11 := rt.cast_array(var_rewrite).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_query := item_11.val
			mut var_match := item_11.key
			var_match = rt.call_function('str_replace', [rt.new_string('.+?'), rt.new_string('.+'), var_match.clone()])
			if rt.is_true(rt.call_function('str_contains', [var_query.clone(), this.index])) {
				var_rules = rt.concat(var_rules, rt.new_string('RewriteRule ^' + (var_match).str() + ' ' + (var_home_root).str() + (var_query).str() + ' [QSA,L]\n'))
			} else {
				var_rules = rt.concat(var_rules, rt.new_string('RewriteRule ^' + (var_match).str() + ' ' + (var_site_root).str() + (var_query).str() + ' [QSA,L]\n'))
			}
		}
	} else {
		var_rules = rt.concat(var_rules, rt.new_string('RewriteCond %{REQUEST_FILENAME} !-f\n' + 'RewriteCond %{REQUEST_FILENAME} !-d\n' + rt.concat(rt.concat(rt.concat(rt.new_string('RewriteRule . '), var_home_root), this.index), rt.new_string(' [L]\n'))))
	}
	var_rules = rt.concat(var_rules, rt.new_string('</IfModule>\n'))
	var_rules = rt.call_function('apply_filters', [rt.new_string('mod_rewrite_rules'), var_rules.clone()])
	return (rt.call_function('apply_filters_deprecated', [rt.new_string('rewrite_rules'), rt.create_array([rt.ArrayItem{ key: none, val: var_rules }]), rt.new_string('1.5.0'), rt.new_string('mod_rewrite_rules')])).str()
}

fn (mut this Class_WP_Rewrite) iis7_url_rewrite_rules(add_parent_tags bool) string {
	if !(this.using_permalinks()) {
		return ''
	}
	mut var_rules := rt.new_string('')
	if var_add_parent_tags {
		var_rules = rt.concat(var_rules, rt.new_string('<configuration>\n\t<system.webServer>\n\t\t<rewrite>\n\t\t\t<rules>'))
	}
	var_rules = rt.concat(var_rules, rt.new_string('\n\t\t\t<rule name="WordPress: ' + (rt.call_function('esc_attr', [rt.call_function('home_url', []rt.PhpVal{})])).str() + '" patternSyntax="Wildcard">\n\t\t\t\t<match url="*" />\n\t\t\t\t\t<conditions>\n\t\t\t\t\t\t<add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />\n\t\t\t\t\t\t<add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />\n\t\t\t\t\t</conditions>\n\t\t\t\t<action type="Rewrite" url="index.php" />\n\t\t\t</rule>'))
	if var_add_parent_tags {
		var_rules = rt.concat(var_rules, rt.new_string('\n\t\t\t</rules>\n\t\t</rewrite>\n\t</system.webServer>\n</configuration>'))
	}
	return (rt.call_function('apply_filters', [rt.new_string('iis7_url_rewrite_rules'), var_rules.clone()])).str()
}

fn (mut this Class_WP_Rewrite) add_rule(var_regex rt.PhpVal, var_query rt.PhpVal, after string) {
	mut var_query_mutated := var_query
	if rt.is_true(rt.new_bool(var_query_mutated.clone().is_array())) {
	mut var_external := rt.new_bool(false)
	var_query_mutated = rt.call_function('add_query_arg', [var_query_mutated.clone(), rt.new_string('index.php')])
	} else {
	mut var_index := if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_query_mutated.clone(), rt.new_string('?')]))))) { rt.new_int(var_query_mutated.clone().to_string().len) } else { rt.call_function('strpos', [var_query_mutated.clone(), rt.new_string('?')]) }
	mut var_front := rt.call_function('substr', [var_query_mutated.clone(), rt.new_int(0), var_index.clone()])
	var_external = rt.new_bool(!rt.is_true(rt.identical(var_front, this.index)))
	}
	if rt.is_true(var_external) {
		this.add_external_rule(var_regex.clone(), var_query_mutated.clone())
	} else {
		if rt.is_true(rt.identical(rt.new_string('bottom'), rt.new_string(after))) {
			this.extra_rules = rt.call_function('array_merge', [this.extra_rules, rt.create_array([rt.ArrayItem{ key: var_regex, val: var_query_mutated }])])
		} else {
			this.extra_rules_top = rt.call_function('array_merge', [this.extra_rules_top, rt.create_array([rt.ArrayItem{ key: var_regex, val: var_query_mutated }])])
		}
	}
}

fn (mut this Class_WP_Rewrite) add_external_rule(var_regex rt.PhpVal, var_query rt.PhpVal) {
	mut var_query_mutated := var_query
	this.non_wp_rules.array_set(var_regex, var_query_mutated.clone())
}

fn (mut this Class_WP_Rewrite) add_endpoint(var_name rt.PhpVal, var_places rt.PhpVal, query_var bool) {
	mut var_wp := rt.new_null()
	mut query_var_mutated := query_var
	if rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(query_var_mutated))) || rt.is_true(rt.identical(rt.new_null(), rt.new_bool(query_var_mutated))) {
	query_var_mutated = (var_name).to_bool()
	}
	this.endpoints.array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_places }, rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: query_var_mutated }]))
	if rt.is_true(rt.new_bool(query_var_mutated)) {
		rt.call_method(var_wp, 'add_query_var', [rt.new_bool(query_var_mutated).clone()])
	}
}

fn (mut this Class_WP_Rewrite) add_permastruct(var_name rt.PhpVal, var_struct rt.PhpVal, var_args rt.PhpVal) {
	mut var_struct_mutated := var_struct
	mut var_args_mutated := var_args
	if !(var_args_mutated.clone().is_array()) {
	var_args_mutated = rt.create_array([rt.ArrayItem{ key: 'with_front', val: var_args_mutated }])
	}
	if rt.is_true(rt.identical(rt.call_function('func_num_args', []rt.PhpVal{}), rt.new_int(4))) {
		var_args_mutated.array_set('ep_mask', rt.call_function('func_get_arg', [rt.new_int(3)]))
	}
	mut var_defaults := { 'with_front': rt.new_bool(true), 'ep_mask': rt.get_constant('EP_NONE'), 'paged': rt.new_bool(true), 'feed': rt.new_bool(true), 'forcomments': rt.new_bool(false), 'walk_dirs': rt.new_bool(true), 'endpoints': rt.new_bool(true) }
	var_args_mutated = rt.call_function('array_intersect_key', [var_args_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(var_args_mutated.array_get(rt.new_string('with_front'))) {
	var_struct_mutated = rt.new_string((this.front).str() + (var_struct_mutated).str())
	} else {
	var_struct_mutated = rt.new_string((this.root).str() + (var_struct_mutated).str())
	}
	var_args_mutated.array_set('struct', var_struct_mutated.clone())
	this.extra_permastructs.array_set(var_name, var_args_mutated.clone())
}

fn (mut this Class_WP_Rewrite) remove_permastruct(var_name rt.PhpVal) {
	this.extra_permastructs.array_unset(var_name)
}

fn (mut this Class_WP_Rewrite) flush_rules(hard bool) {
	mut hard_mutated := hard
	mut var_do_hard_later := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('wp_loaded')]))))) {
		rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Rewrite', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'flush_rules' }])])
		var_do_hard_later = rt.new_bool(if !(var_do_hard_later).is_null() { rt.is_true(var_do_hard_later) || rt.is_true(rt.new_bool(hard_mutated)) } else { hard_mutated })
		return
	}
	if !(var_do_hard_later).is_null() {
		hard_mutated = (var_do_hard_later).to_bool()
		var_do_hard_later = rt.new_null()
	}
	this.refresh_rewrite_rules()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(hard_mutated))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('flush_rewrite_rules_hard'), rt.new_bool(true)]))))) {
		return
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('save_mod_rewrite_rules')])) {
		rt.call_function('save_mod_rewrite_rules', []rt.PhpVal{})
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('iis7_save_url_rewrite_rules')])) {
		rt.call_function('iis7_save_url_rewrite_rules', []rt.PhpVal{})
	}
}

fn (mut this Class_WP_Rewrite) init() {
	this.extra_rules = rt.new_array()
	this.non_wp_rules = rt.new_array()
	this.endpoints = rt.new_array()
	this.permalink_structure = rt.call_function('get_option', [rt.new_string('permalink_structure')])
	this.front = rt.call_function('substr', [this.permalink_structure, rt.new_int(0), rt.call_function('strpos', [this.permalink_structure, rt.new_string('%')])])
	this.root = rt.new_string('')
	if this.using_index_permalinks() {
		this.root = (this.index).str() + '/'
	}
	this.author_structure = rt.new_null()
	this.date_structure = rt.new_null()
	this.page_structure = rt.new_null()
	this.search_structure = rt.new_null()
	this.feed_structure = rt.new_null()
	this.comment_feed_structure = rt.new_null()
	this.use_trailing_slashes = rt.call_function('str_ends_with', [this.permalink_structure, rt.new_string('/')])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[^%]*%(?:postname|category|tag|author)%/'), this.permalink_structure])) {
		this.use_verbose_page_rules = true
	} else {
		this.use_verbose_page_rules = false
	}
}

fn (mut this Class_WP_Rewrite) set_permalink_structure(var_permalink_structure rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.permalink_structure, var_permalink_structure)))) {
		mut var_old_permalink_structure := this.permalink_structure
		rt.call_function('update_option', [rt.new_string('permalink_structure'), var_permalink_structure.clone()])
		this.init()
		rt.call_function('do_action', [rt.new_string('permalink_structure_changed'), var_old_permalink_structure.clone(), var_permalink_structure.clone()])
	}
}

fn (mut this Class_WP_Rewrite) set_category_base(var_category_base rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('category_base')]), var_category_base)))) {
		rt.call_function('update_option', [rt.new_string('category_base'), var_category_base.clone()])
		this.init()
	}
}

fn (mut this Class_WP_Rewrite) set_tag_base(var_tag_base rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('tag_base')]), var_tag_base)))) {
		rt.call_function('update_option', [rt.new_string('tag_base'), var_tag_base.clone()])
		this.init()
	}
}

fn (mut this Class_WP_Rewrite) construct() {
	this.init()
}

fn create_wp_rewrite() &Class_WP_Rewrite {
	mut obj := &Class_WP_Rewrite{
		PhpObjectBase: rt.PhpObjectBase{}
		permalink_structure: rt.new_null()
		use_trailing_slashes: rt.new_null()
		author_base: rt.new_string('author')
		author_structure: rt.new_null()
		date_structure: rt.new_null()
		page_structure: rt.new_null()
		search_base: rt.new_string('search')
		search_structure: rt.new_null()
		comments_base: rt.new_string('comments')
		pagination_base: rt.new_string('page')
		comments_pagination_base: rt.new_string('comment-page')
		feed_base: rt.new_string('feed')
		comment_feed_structure: rt.new_null()
		feed_structure: rt.new_null()
		front: rt.new_null()
		root: rt.new_string('')
		index: rt.new_string('index.php')
		matches: ''
		rules: rt.new_null()
		extra_rules: rt.new_array()
		extra_rules_top: rt.new_array()
		non_wp_rules: rt.new_array()
		extra_permastructs: rt.new_array()
		endpoints: rt.new_null()
		use_verbose_rules: rt.new_bool(false)
		use_verbose_page_rules: false
		rewritecode: rt.new_array()
		rewritereplace: rt.new_array()
		queryreplace: rt.new_array()
		feeds: rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Rewrite) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'using_permalinks' {
			return rt.new_bool(this.using_permalinks())
		}
		'using_index_permalinks' {
			return rt.new_bool(this.using_index_permalinks())
		}
		'using_mod_rewrite_permalinks' {
			return rt.new_bool(this.using_mod_rewrite_permalinks())
		}
		'preg_index' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.preg_index(dispatch_arg_0))
		}
		'page_uri_index' {
			return this.page_uri_index()
		}
		'page_rewrite_rules' {
			return this.page_rewrite_rules()
		}
		'get_date_permastruct' {
			return rt.new_bool(this.get_date_permastruct())
		}
		'get_year_permastruct' {
			return rt.new_bool(this.get_year_permastruct())
		}
		'get_month_permastruct' {
			return rt.new_bool(this.get_month_permastruct())
		}
		'get_day_permastruct' {
			return this.get_day_permastruct()
		}
		'get_category_permastruct' {
			return this.get_category_permastruct()
		}
		'get_tag_permastruct' {
			return this.get_tag_permastruct()
		}
		'get_extra_permastruct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_extra_permastruct(dispatch_arg_0))
		}
		'get_author_permastruct' {
			return rt.new_bool(this.get_author_permastruct())
		}
		'get_search_permastruct' {
			return rt.new_bool(this.get_search_permastruct())
		}
		'get_page_permastruct' {
			return rt.new_bool(this.get_page_permastruct())
		}
		'get_feed_permastruct' {
			return rt.new_bool(this.get_feed_permastruct())
		}
		'get_comment_feed_permastruct' {
			return rt.new_bool(this.get_comment_feed_permastruct())
		}
		'add_rewrite_tag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_rewrite_tag(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'remove_rewrite_tag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_rewrite_tag(dispatch_arg_0)
			return rt.new_null()
		}
		'generate_rewrite_rules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).to_bool()
			dispatch_arg_6 := (if args.len > 6 { args[6] } else { rt.new_null() }).to_bool()
			return this.generate_rewrite_rules(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6)
		}
		'generate_rewrite_rule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.generate_rewrite_rule(dispatch_arg_0, dispatch_arg_1)
		}
		'rewrite_rules' {
			return this.rewrite_rules()
		}
		'wp_rewrite_rules' {
			return this.wp_rewrite_rules()
		}
		'refresh_rewrite_rules' {
			this.refresh_rewrite_rules()
			return rt.new_null()
		}
		'mod_rewrite_rules' {
			return rt.new_string(this.mod_rewrite_rules())
		}
		'iis7_url_rewrite_rules' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.iis7_url_rewrite_rules(dispatch_arg_0))
		}
		'add_rule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.add_rule(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'add_external_rule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_external_rule(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_endpoint' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.add_endpoint(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'add_permastruct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_permastruct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'remove_permastruct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_permastruct(dispatch_arg_0)
			return rt.new_null()
		}
		'flush_rules' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.flush_rules(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'set_permalink_structure' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_permalink_structure(dispatch_arg_0)
			return rt.new_null()
		}
		'set_category_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_category_base(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tag_base' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tag_base(dispatch_arg_0)
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Rewrite) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'permalink_structure' { return this.permalink_structure }
		'use_trailing_slashes' { return this.use_trailing_slashes }
		'author_base' { return this.author_base }
		'author_structure' { return this.author_structure }
		'date_structure' { return this.date_structure }
		'page_structure' { return this.page_structure }
		'search_base' { return this.search_base }
		'search_structure' { return this.search_structure }
		'comments_base' { return this.comments_base }
		'pagination_base' { return this.pagination_base }
		'comments_pagination_base' { return this.comments_pagination_base }
		'feed_base' { return this.feed_base }
		'comment_feed_structure' { return this.comment_feed_structure }
		'feed_structure' { return this.feed_structure }
		'front' { return this.front }
		'root' { return this.root }
		'index' { return this.index }
		'matches' { return rt.new_string(this.matches) }
		'rules' { return this.rules }
		'extra_rules' { return this.extra_rules }
		'extra_rules_top' { return this.extra_rules_top }
		'non_wp_rules' { return this.non_wp_rules }
		'extra_permastructs' { return this.extra_permastructs }
		'endpoints' { return this.endpoints }
		'use_verbose_rules' { return this.use_verbose_rules }
		'use_verbose_page_rules' { return rt.new_bool(this.use_verbose_page_rules) }
		'rewritecode' { return this.rewritecode }
		'rewritereplace' { return this.rewritereplace }
		'queryreplace' { return this.queryreplace }
		'feeds' { return this.feeds }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Rewrite) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'permalink_structure' { this.permalink_structure = val; return true }
		'use_trailing_slashes' { this.use_trailing_slashes = val; return true }
		'author_base' { this.author_base = val; return true }
		'author_structure' { this.author_structure = val; return true }
		'date_structure' { this.date_structure = val; return true }
		'page_structure' { this.page_structure = val; return true }
		'search_base' { this.search_base = val; return true }
		'search_structure' { this.search_structure = val; return true }
		'comments_base' { this.comments_base = val; return true }
		'pagination_base' { this.pagination_base = val; return true }
		'comments_pagination_base' { this.comments_pagination_base = val; return true }
		'feed_base' { this.feed_base = val; return true }
		'comment_feed_structure' { this.comment_feed_structure = val; return true }
		'feed_structure' { this.feed_structure = val; return true }
		'front' { this.front = val; return true }
		'root' { this.root = val; return true }
		'index' { this.index = val; return true }
		'matches' { this.matches = (val).str(); return true }
		'rules' { this.rules = val; return true }
		'extra_rules' { this.extra_rules = val; return true }
		'extra_rules_top' { this.extra_rules_top = val; return true }
		'non_wp_rules' { this.non_wp_rules = val; return true }
		'extra_permastructs' { this.extra_permastructs = val; return true }
		'endpoints' { this.endpoints = val; return true }
		'use_verbose_rules' { this.use_verbose_rules = val; return true }
		'use_verbose_page_rules' { this.use_verbose_page_rules = (val).to_bool(); return true }
		'rewritecode' { this.rewritecode = val; return true }
		'rewritereplace' { this.rewritereplace = val; return true }
		'queryreplace' { this.queryreplace = val; return true }
		'feeds' { this.feeds = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
