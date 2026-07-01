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
	return (rt.call_function('preg_match', ['#^/*' + (this.index).str() + '#', this.permalink_structure])).to_bool()
}

fn (mut this Class_WP_Rewrite) using_mod_rewrite_permalinks() bool {
	return this.using_permalinks() && !(this.using_index_permalinks())
}

fn (mut this Class_WP_Rewrite) preg_index(var_number rt.PhpVal) string {
	mut var_match_prefix := rt.new_string(rt.new_string('$'))
	mut var_match_suffix := rt.new_string(rt.new_string(''))
	if !(this.matches == '') {
		var_match_prefix = rt.new_string('$' + this.matches + '[')
		var_match_suffix = rt.new_string(rt.new_string(']'))
	}
	return "${var_match_prefix.to_string()}${var_number.to_string()}${var_match_suffix.to_string()}"
}

fn (mut this Class_WP_Rewrite) page_uri_index() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_pages := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_name, post_parent FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'page\' AND post_status != \'auto-draft\''))])
	mut var_posts := rt.call_function('get_page_hierarchy', [var_pages.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_posts)))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: rt.new_array() }, rt.ArrayItem{ key: none, val: rt.new_array() }])
	}
	var_posts = rt.call_function('array_reverse', [var_posts.dup(), rt.new_bool(true)])
	mut var_page_uris := rt.new_array()
	mut var_page_attachment_uris := rt.new_array()
	{
		mut iter_1 := var_posts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			mut var_id := item_1.key
			mut var_uri := rt.call_function('get_page_uri', [var_id.dup()])
			mut var_attachments := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID, post_name, post_parent FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_type = \'attachment\' AND post_parent = %d')), var_id.dup()])])
			if !(!rt.is_true(var_attachments)) {
				{
					mut iter_2 := var_attachments.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_attachment := item_2.val
						mut var_attach_uri := rt.call_function('get_page_uri', [rt.get_property(var_attachment, 'ID')])
						var_page_attachment_uris.array_set(var_attach_uri, rt.get_property(var_attachment, 'ID'))
					}
				}
			}
			var_page_uris.array_set(var_uri, var_id.dup())
		}
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
	mut var_date_endian := rt.new_string(rt.new_string(''))
	for var_endian in var_endians {
		if rt.is_true(rt.call_function('str_contains', [this.permalink_structure, rt.new_string(endian)])) {
			var_date_endian = rt.new_string(rt.new_string(endian))
			break
		}
	}
	if !rt.is_true(var_date_endian) {
		var_date_endian = rt.new_string(rt.new_string('%year%/%monthnum%/%day%'))
	}
	mut var_front := this.front
	rt.call_function('preg_match_all', [rt.new_string('/%.+?%/'), this.permalink_structure, var_tokens.dup()])
	mut var_tok_index := rt.new_int(rt.new_int(1))
	{
		mut iter_1 := rt.cast_array(var_tokens.array_get(0)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('%post_id%'), var_token)) && rt.is_true(rt.less_equal(var_tok_index, rt.new_int(3))))) {
				var_front = rt.new_string((var_front).str() + 'date/')
				break
			}
			rt.pre_inc(var_tok_index)
		}
	}
	this.date_structure = rt.concat(var_front, var_date_endian)
	return (this.date_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_year_permastruct() bool {
	mut var_structure := rt.new_bool(this.get_date_permastruct())
	if !rt.is_true(var_structure) {
		return false
	}
	var_structure = rt.call_function('str_replace', [rt.new_string('%monthnum%'), rt.new_string(''), var_structure.dup()])
	var_structure = rt.call_function('str_replace', [rt.new_string('%day%'), rt.new_string(''), var_structure.dup()])
	var_structure = rt.call_function('preg_replace', [rt.new_string('#/+#'), rt.new_string('/'), var_structure.dup()])
	return (var_structure).to_bool()
}

fn (mut this Class_WP_Rewrite) get_month_permastruct() bool {
	mut var_structure := rt.new_bool(this.get_date_permastruct())
	if !rt.is_true(var_structure) {
		return false
	}
	var_structure = rt.call_function('str_replace', [rt.new_string('%day%'), rt.new_string(''), var_structure.dup()])
	var_structure = rt.call_function('preg_replace', [rt.new_string('#/+#'), rt.new_string('/'), var_structure.dup()])
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
		return (this.extra_permastructs.array_get(var_name).array_get('struct')).to_bool()
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

fn (mut this Class_WP_Rewrite) add_rewrite_tag(var_tag rt.PhpVal, var_regex rt.PhpVal, var_query rt.PhpVal)  {
	mut var_query_mutated := var_query
	mut var_position := rt.call_function('array_search', [var_tag.dup(), this.rewritecode, rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.rewritereplace.array_set(var_position, var_regex.dup())
		this.queryreplace.array_set(var_position, var_query_mutated.dup())
	} else {
		this.rewritecode.array_push(var_tag.dup())
		this.rewritereplace.array_push(var_regex.dup())
		this.queryreplace.array_push(var_query_mutated.dup())
	}
}

fn (mut this Class_WP_Rewrite) remove_rewrite_tag(var_tag rt.PhpVal)  {
	mut var_position := rt.call_function('array_search', [var_tag.dup(), this.rewritecode, rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.rewritecode.array_unset(var_position)
		this.rewritereplace.array_unset(var_position)
		this.queryreplace.array_unset(var_position)
	}
}

fn (mut this Class_WP_Rewrite) generate_rewrite_rules(var_permalink_structure rt.PhpVal, var_ep_mask rt.PhpVal, paged bool, feed bool, forcomments bool, walk_dirs bool, endpoints bool) rt.PhpVal {
	mut var_tokens := []rt.PhpVal{}
	mut var_toks := rt.new_null()
	mut var_feedregex2 := rt.new_string()
	{
		mut iter_1 := .iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_feed_name := item_1.val
		}
	}
}

fn (mut this Class_WP_Rewrite) generate_rewrite_rule(var_permalink_structure rt.PhpVal, walk_dirs bool) rt.PhpVal {
}

fn (mut this Class_WP_Rewrite) rewrite_rules() rt.PhpVal {
}

fn (mut this Class_WP_Rewrite) wp_rewrite_rules() rt.PhpVal {
}

fn (mut this Class_WP_Rewrite) refresh_rewrite_rules()  {
}

fn (mut this Class_WP_Rewrite) mod_rewrite_rules() string {
}

fn (mut this Class_WP_Rewrite) iis7_url_rewrite_rules(add_parent_tags bool) string {
}

fn (mut this Class_WP_Rewrite) add_rule(var_regex rt.PhpVal, var_query rt.PhpVal, after string)  {
	mut var_query_mutated := var_query
}

fn (mut this Class_WP_Rewrite) add_external_rule(var_regex rt.PhpVal, var_query rt.PhpVal)  {
	mut var_query_mutated := var_query
}

fn (mut this Class_WP_Rewrite) add_endpoint(var_name rt.PhpVal, var_places rt.PhpVal, query_var bool)  {
	mut var_wp := rt.new_null()
	mut query_var_mutated := query_var
}

fn (mut this Class_WP_Rewrite) add_permastruct(var_name rt.PhpVal, var_struct rt.PhpVal, var_args rt.PhpVal)  {
	mut var_struct_mutated := var_struct
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Rewrite) remove_permastruct(var_name rt.PhpVal)  {
}

fn (mut this Class_WP_Rewrite) flush_rules(hard bool)  {
	mut hard_mutated := hard
}

fn (mut this Class_WP_Rewrite) init()  {
}

fn (mut this Class_WP_Rewrite) set_permalink_structure(var_permalink_structure rt.PhpVal)  {
}

fn (mut this Class_WP_Rewrite) set_category_base(var_category_base rt.PhpVal)  {
}

fn (mut this Class_WP_Rewrite) set_tag_base(var_tag_base rt.PhpVal)  {
}

fn (mut this Class_WP_Rewrite) construct()  {
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




pub fn init_wp_includes_class_wp_rewrite_php() {
}
