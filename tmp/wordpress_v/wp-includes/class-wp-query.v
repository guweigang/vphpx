import rt

struct Class_WP_Query {
	rt.PhpObjectBase
pub mut:
		query rt.PhpVal = rt.new_null()
		query_vars rt.PhpVal = rt.new_array()
		tax_query rt.PhpVal = rt.new_null()
		meta_query rt.PhpVal = rt.new_bool(false)
		date_query rt.PhpVal = rt.new_bool(false)
		queried_object rt.PhpVal = rt.new_null()
		queried_object_id rt.PhpVal = rt.new_null()
		request rt.PhpVal = rt.new_null()
		posts rt.PhpVal = rt.new_null()
		post_count i64
		current_post rt.PhpVal = rt.new_null()
		before_loop bool
		in_the_loop bool
		post rt.PhpVal = rt.new_null()
		comments rt.PhpVal = rt.new_null()
		comment_count i64
		current_comment rt.PhpVal = rt.new_null()
		comment rt.PhpVal = rt.new_null()
		found_posts rt.PhpVal = rt.new_int(0)
		max_num_pages rt.PhpVal = rt.new_int(0)
		max_num_comment_pages i64
		is_single bool
		is_preview bool
		is_page bool
		is_archive bool
		is_date bool
		is_year bool
		is_month bool
		is_day bool
		is_time bool
		is_author bool
		is_category bool
		is_tag bool
		is_tax bool
		is_search bool
		is_feed rt.PhpVal = rt.new_bool(false)
		is_comment_feed bool
		is_trackback bool
		is_home bool
		is_privacy_policy bool
		is_404 bool
		is_embed bool
		is_paged bool
		is_admin bool
		is_attachment bool
		is_singular bool
		is_robots bool
		is_favicon bool
		is_posts_page bool
		is_post_type_archive bool
		query_vars_hash rt.PhpVal = rt.new_bool(false)
		query_vars_changed bool
		thumbnails_cached rt.PhpVal = rt.new_bool(false)
		allow_query_attachment_by_filename rt.PhpVal = rt.new_bool(false)
		stopwords rt.PhpVal = rt.new_null()
		compat_fields rt.PhpVal = rt.new_array()
		compat_methods rt.PhpVal = rt.new_array()
		query_cache_key string
}

fn (mut this Class_WP_Query) init_query_flags()  {
	this.is_single = false
	this.is_preview = false
	this.is_page = false
	this.is_archive = false
	this.is_date = false
	this.is_year = false
	this.is_month = false
	this.is_day = false
	this.is_time = false
	this.is_author = false
	this.is_category = false
	this.is_tag = false
	this.is_tax = false
	this.is_search = false
	this.is_feed = rt.new_bool(false)
	this.is_comment_feed = false
	this.is_trackback = false
	this.is_home = false
	this.is_privacy_policy = false
	this.is_404 = false
	this.is_paged = false
	this.is_admin = false
	this.is_attachment = false
	this.is_singular = false
	this.is_robots = false
	this.is_favicon = false
	this.is_posts_page = false
	this.is_post_type_archive = false
}

fn (mut this Class_WP_Query) init()  {
	this.posts = rt.new_null()
	this.query = rt.new_null()
	this.query_vars = rt.new_array()
	this.queried_object = rt.new_null()
	this.queried_object_id = rt.new_null()
	this.post_count = 0
	this.current_post = // unsupported expression: Expr_UnaryMinus
	this.in_the_loop = false
	this.before_loop = true
	this.request = rt.new_null()
	this.post = rt.new_null()
	this.comments = rt.new_null()
	this.comment = rt.new_null()
	this.comment_count = 0
	this.current_comment = // unsupported expression: Expr_UnaryMinus
	this.found_posts = rt.new_int(0)
	this.max_num_pages = rt.new_int(0)
	this.max_num_comment_pages = 0
	this.init_query_flags()
}

fn (mut this Class_WP_Query) parse_query_vars()  {
	this.parse_query('')
}

fn (mut this Class_WP_Query) fill_query_vars(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_query_vars_mutated := var_query_vars
	mut var_keys := ['error', 'm', 'p', 'post_parent', 'subpost', 'subpost_id', 'attachment', 'attachment_id', 'name', 'pagename', 'page_id', 'second', 'minute', 'hour', 'day', 'monthnum', 'year', 'w', 'category_name', 'tag', 'cat', 'tag_id', 'author', 'author_name', 'feed', 'tb', 'paged', 'meta_key', 'meta_value', 'preview', 's', 'sentence', 'title', 'fields', 'menu_order', 'embed']
	for var_key in var_keys {
		if !(var_query_vars_mutated.array_isset(rt.new_string(key))) {
			var_query_vars_mutated.array_set(key, '')
		}
	}
	mut var_array_keys := ['category__in', 'category__not_in', 'category__and', 'post__in', 'post__not_in', 'post_name__in', 'tag__in', 'tag__not_in', 'tag__and', 'tag_slug__in', 'tag_slug__and', 'post_parent__in', 'post_parent__not_in', 'author__in', 'author__not_in', 'search_columns']
	for var_key in var_array_keys {
		if !(var_query_vars_mutated.array_isset(rt.new_string(key))) {
			var_query_vars_mutated.array_set(key, rt.new_array())
		}
	}
	return var_query_vars_mutated.dup()
}

fn (mut this Class_WP_Query) parse_query(query string)  {
	mut var_query_vars := rt.new_null()
	mut query_mutated := query
	if !(query_mutated == '') {
		this.init()
		this.query = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).dup()])
		this.query_vars = this.query
	} else if !(!(this.query).is_null()) {
		this.query = this.query_vars
	}
	this.query_vars = this.fill_query_vars(this.query_vars)
	// unsupported expression: Expr_AssignRef
	this.query_vars_changed = true
	if !(!rt.is_true(var_query_vars.array_get('robots'))) {
		this.is_robots = true
	} else if !(!rt.is_true(var_query_vars.array_get('favicon'))) {
		this.is_favicon = true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('p')]))))) || rt.is_true(rt.less(// unsupported expression: Expr_Cast_Int, rt.new_int(0))))) {
		var_query_vars.array_set('p', 0)
		var_query_vars.array_set('error', '404')
	} else {
		var_query_vars.array_set('p', // unsupported expression: Expr_Cast_Int)
	}
	var_query_vars.array_set('page_id', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('page_id')])) { rt.call_function('absint', [var_query_vars.array_get('page_id')]) } else { rt.new_int(0) })
	var_query_vars.array_set('year', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('year')])) { rt.call_function('absint', [var_query_vars.array_get('year')]) } else { rt.new_int(0) })
	var_query_vars.array_set('monthnum', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('monthnum')])) { rt.call_function('absint', [var_query_vars.array_get('monthnum')]) } else { rt.new_int(0) })
	var_query_vars.array_set('day', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('day')])) { rt.call_function('absint', [var_query_vars.array_get('day')]) } else { rt.new_int(0) })
	var_query_vars.array_set('w', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('w')])) { rt.call_function('absint', [var_query_vars.array_get('w')]) } else { rt.new_int(0) })
	var_query_vars.array_set('m', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('m')])) { rt.call_function('preg_replace', [rt.new_string('|[^0-9]|'), rt.new_string(''), var_query_vars.array_get('m')]) } else { rt.new_string('') })
	var_query_vars.array_set('paged', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('paged')])) { rt.call_function('absint', [var_query_vars.array_get('paged')]) } else { rt.new_int(0) })
	var_query_vars.array_set('cat', rt.call_function('preg_replace', [rt.new_string('|[^0-9,-]|'), rt.new_string(''), var_query_vars.array_get('cat')]))
	var_query_vars.array_set('author', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('author')])) { rt.call_function('preg_replace', [rt.new_string('|[^0-9,-]|'), rt.new_string(''), var_query_vars.array_get('author')]) } else { rt.new_string('') })
	var_query_vars.array_set('pagename', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('pagename')])) { var_query_vars.array_get('pagename').to_string().trim_space() } else { '' })
	var_query_vars.array_set('name', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('name')])) { var_query_vars.array_get('name').to_string().trim_space() } else { '' })
	var_query_vars.array_set('title', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('title')])) { var_query_vars.array_get('title').to_string().trim_space() } else { '' })
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('hour')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_set('hour', rt.call_function('absint', [var_query_vars.array_get('hour')]))
	} else {
		var_query_vars.array_set('hour', '')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('minute')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_set('minute', rt.call_function('absint', [var_query_vars.array_get('minute')]))
	} else {
		var_query_vars.array_set('minute', '')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('second')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_set('second', rt.call_function('absint', [var_query_vars.array_get('second')]))
	} else {
		var_query_vars.array_set('second', '')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('menu_order')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_query_vars.array_set('menu_order', rt.call_function('absint', [var_query_vars.array_get('menu_order')]))
	} else {
		var_query_vars.array_set('menu_order', '')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('s')]))))) || !(!rt.is_true(var_query_vars.array_get('s'))) && var_query_vars.array_get('s').to_string().len > 1600)) {
		var_query_vars.array_set('s', '')
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('subpost')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		var_query_vars.array_set('attachment', var_query_vars.array_get('subpost'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('subpost_id')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		var_query_vars.array_set('attachment_id', var_query_vars.array_get('subpost_id'))
	}
	var_query_vars.array_set('attachment_id', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get('attachment_id')])) { rt.call_function('absint', [var_query_vars.array_get('attachment_id')]) } else { rt.new_int(0) })
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !(!rt.is_true(var_query_vars.array_get('attachment_id'))))) {
		this.is_single = true
		this.is_attachment = true
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.is_single = true
	} else if rt.is_true(var_query_vars.array_get('p')) {
		this.is_single = true
	} else if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !(!rt.is_true(var_query_vars.array_get('page_id'))))) {
		this.is_page = true
		this.is_single = 
	} else {
		if .array_isset() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		if rt.is_true() {
		}
		
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP_Query) parse_tax_query(var_query_vars rt.PhpVal)  {
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WP_Query) parse_search(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WP_Query) parse_search_terms(var_terms rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
}

fn (mut this Class_WP_Query) get_search_stopwords() rt.PhpVal {
}

fn (mut this Class_WP_Query) parse_search_order(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
}

fn (mut this Class_WP_Query) parse_orderby(var_orderby rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_orderby_mutated := var_orderby
}

fn (mut this Class_WP_Query) parse_order(var_order rt.PhpVal) string {
	return ''
}

fn (mut this Class_WP_Query) set_404()  {
}

fn (mut this Class_WP_Query) get(var_query_var rt.PhpVal, default_value string) rt.PhpVal {
	mut var_query_var_mutated := var_query_var
}

fn (mut this Class_WP_Query) set(var_query_var rt.PhpVal, var_value rt.PhpVal)  {
	mut var_query_var_mutated := var_query_var
}

fn (mut this Class_WP_Query) get_posts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_Query) set_found_posts(var_query_vars rt.PhpVal, var_limits rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_limits_mutated := var_limits
}

fn (mut this Class_WP_Query) next_post() rt.PhpVal {
}

fn (mut this Class_WP_Query) the_post()  {
}

fn (mut this Class_WP_Query) have_posts() bool {
}

fn (mut this Class_WP_Query) rewind_posts()  {
}

fn (mut this Class_WP_Query) next_comment() rt.PhpVal {
}

fn (mut this Class_WP_Query) the_comment()  {
}

fn (mut this Class_WP_Query) have_comments() bool {
}

fn (mut this Class_WP_Query) rewind_comments()  {
}

fn (mut this Class_WP_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
}

fn (mut this Class_WP_Query) get_queried_object() rt.PhpVal {
}

fn (mut this Class_WP_Query) get_queried_object_id() rt.PhpVal {
}

fn (mut this Class_WP_Query) construct(query string)  {
	mut query_mutated := query
}

fn (mut this Class_WP_Query) magic_get(var_name rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Query) magic_isset(var_name rt.PhpVal) bool {
}

fn (mut this Class_WP_Query) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
}

fn (mut this Class_WP_Query) is_archive() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_post_type_archive(post_types string) bool {
}

fn (mut this Class_WP_Query) is_attachment(attachment string) bool {
	mut attachment_mutated := attachment
}

fn (mut this Class_WP_Query) is_author(author string) bool {
	mut author_mutated := author
}

fn (mut this Class_WP_Query) is_category(category string) bool {
	mut category_mutated := category
}

fn (mut this Class_WP_Query) is_tag(tag string) bool {
	mut tag_mutated := tag
}

fn (mut this Class_WP_Query) is_tax(taxonomy string, term string) bool {
	mut var_wp_taxonomies := rt.new_null()
	mut term_mutated := term
}

fn (mut this Class_WP_Query) is_comments_popup() bool {
}

fn (mut this Class_WP_Query) is_date() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_day() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_feed(feeds string) rt.PhpVal {
}

fn (mut this Class_WP_Query) is_comment_feed() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_front_page() bool {
	return false
}

fn (mut this Class_WP_Query) is_home() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_privacy_policy() bool {
	return false
}

fn (mut this Class_WP_Query) is_month() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_page(page string) bool {
	mut page_mutated := page
}

fn (mut this Class_WP_Query) is_paged() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_preview() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_robots() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_favicon() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_search() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_single(post string) bool {
	mut post_mutated := post
}

fn (mut this Class_WP_Query) is_singular(post_types string) bool {
}

fn (mut this Class_WP_Query) is_time() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_trackback() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_year() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_404() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_embed() rt.PhpVal {
}

fn (mut this Class_WP_Query) is_main_query() rt.PhpVal {
	mut var_wp_the_query := rt.new_null()
}

fn (mut this Class_WP_Query) setup_postdata(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Query) generate_postdata(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Query) generate_cache_key(mut var_args Class_array, var_sql rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_sql_mutated := var_sql
}

fn (mut this Class_WP_Query) reset_postdata()  {
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_WP_Query) lazyload_term_meta(var_check rt.PhpVal, var_term_id rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Query) lazyload_comment_meta(var_check rt.PhpVal, var_comment_id rt.PhpVal) rt.PhpVal {
}

fn create_wp_query(query string) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
		query: rt.new_null()
		query_vars: rt.new_array()
		tax_query: rt.new_null()
		meta_query: rt.new_bool(false)
		date_query: rt.new_bool(false)
		queried_object: rt.new_null()
		queried_object_id: rt.new_null()
		request: rt.new_null()
		posts: rt.new_null()
		post_count: i64(0)
		current_post: rt.new_null()
		before_loop: false
		in_the_loop: false
		post: rt.new_null()
		comments: rt.new_null()
		comment_count: i64(0)
		current_comment: rt.new_null()
		comment: rt.new_null()
		found_posts: rt.new_int(0)
		max_num_pages: rt.new_int(0)
		max_num_comment_pages: i64(0)
		is_single: false
		is_preview: false
		is_page: false
		is_archive: false
		is_date: false
		is_year: false
		is_month: false
		is_day: false
		is_time: false
		is_author: false
		is_category: false
		is_tag: false
		is_tax: false
		is_search: false
		is_feed: rt.new_bool(false)
		is_comment_feed: false
		is_trackback: false
		is_home: false
		is_privacy_policy: false
		is_404: false
		is_embed: false
		is_paged: false
		is_admin: false
		is_attachment: false
		is_singular: false
		is_robots: false
		is_favicon: false
		is_posts_page: false
		is_post_type_archive: false
		query_vars_hash: rt.new_bool(false)
		query_vars_changed: false
		thumbnails_cached: rt.new_bool(false)
		allow_query_attachment_by_filename: rt.new_bool(false)
		stopwords: rt.new_null()
		compat_fields: rt.new_array()
		compat_methods: rt.new_array()
		query_cache_key: ''
	}
	obj.construct(query)
	return obj
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init_query_flags' {
			this.init_query_flags()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'parse_query_vars' {
			this.parse_query_vars()
			return rt.new_null()
		}
		'fill_query_vars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fill_query_vars(dispatch_arg_0)
		}
		'parse_query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.parse_query(dispatch_arg_0)
			return rt.new_null()
		}
		'parse_tax_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.parse_tax_query(dispatch_arg_0)
			return rt.new_null()
		}
		'parse_search' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_search(dispatch_arg_0)
		}
		'parse_search_terms' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_search_terms(dispatch_arg_0)
		}
		'get_search_stopwords' {
			return this.get_search_stopwords()
		}
		'parse_search_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_search_order(dispatch_arg_0)
		}
		'parse_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.parse_orderby(dispatch_arg_0))
		}
		'parse_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parse_order(dispatch_arg_0))
		}
		'set_404' {
			this.set_404()
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_posts' {
			return this.get_posts()
		}
		'set_found_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_found_posts(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'next_post' {
			return this.next_post()
		}
		'the_post' {
			this.the_post()
			return rt.new_null()
		}
		'have_posts' {
			return rt.new_bool(this.have_posts())
		}
		'rewind_posts' {
			this.rewind_posts()
			return rt.new_null()
		}
		'next_comment' {
			return this.next_comment()
		}
		'the_comment' {
			this.the_comment()
			return rt.new_null()
		}
		'have_comments' {
			return rt.new_bool(this.have_comments())
		}
		'rewind_comments' {
			this.rewind_comments()
			return rt.new_null()
		}
		'query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.query(dispatch_arg_0)
		}
		'get_queried_object' {
			return this.get_queried_object()
		}
		'get_queried_object_id' {
			return this.get_queried_object_id()
		}
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		'is_archive' {
			return this.is_archive()
		}
		'is_post_type_archive' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_post_type_archive(dispatch_arg_0))
		}
		'is_attachment' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_attachment(dispatch_arg_0))
		}
		'is_author' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_author(dispatch_arg_0))
		}
		'is_category' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_category(dispatch_arg_0))
		}
		'is_tag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_tag(dispatch_arg_0))
		}
		'is_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_tax(dispatch_arg_0, dispatch_arg_1))
		}
		'is_comments_popup' {
			return rt.new_bool(this.is_comments_popup())
		}
		'is_date' {
			return this.is_date()
		}
		'is_day' {
			return this.is_day()
		}
		'is_feed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.is_feed(dispatch_arg_0)
		}
		'is_comment_feed' {
			return this.is_comment_feed()
		}
		'is_front_page' {
			return rt.new_bool(this.is_front_page())
		}
		'is_home' {
			return this.is_home()
		}
		'is_privacy_policy' {
			return rt.new_bool(this.is_privacy_policy())
		}
		'is_month' {
			return this.is_month()
		}
		'is_page' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_page(dispatch_arg_0))
		}
		'is_paged' {
			return this.is_paged()
		}
		'is_preview' {
			return this.is_preview()
		}
		'is_robots' {
			return this.is_robots()
		}
		'is_favicon' {
			return this.is_favicon()
		}
		'is_search' {
			return this.is_search()
		}
		'is_single' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_single(dispatch_arg_0))
		}
		'is_singular' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_singular(dispatch_arg_0))
		}
		'is_time' {
			return this.is_time()
		}
		'is_trackback' {
			return this.is_trackback()
		}
		'is_year' {
			return this.is_year()
		}
		'is_404' {
			return this.is_404()
		}
		'is_embed' {
			return this.is_embed()
		}
		'is_main_query' {
			return this.is_main_query()
		}
		'setup_postdata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.setup_postdata(dispatch_arg_0))
		}
		'generate_postdata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.generate_postdata(dispatch_arg_0)
		}
		'generate_cache_key' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.generate_cache_key(mut dispatch_arg_0, dispatch_arg_1))
		}
		'reset_postdata' {
			this.reset_postdata()
			return rt.new_null()
		}
		'lazyload_term_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.lazyload_term_meta(dispatch_arg_0, dispatch_arg_1)
		}
		'lazyload_comment_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.lazyload_comment_meta(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'query' { return this.query }
		'query_vars' { return this.query_vars }
		'tax_query' { return this.tax_query }
		'meta_query' { return this.meta_query }
		'date_query' { return this.date_query }
		'queried_object' { return this.queried_object }
		'queried_object_id' { return this.queried_object_id }
		'request' { return this.request }
		'posts' { return this.posts }
		'post_count' { return rt.new_int(this.post_count) }
		'current_post' { return this.current_post }
		'before_loop' { return rt.new_bool(this.before_loop) }
		'in_the_loop' { return rt.new_bool(this.in_the_loop) }
		'post' { return this.post }
		'comments' { return this.comments }
		'comment_count' { return rt.new_int(this.comment_count) }
		'current_comment' { return this.current_comment }
		'comment' { return this.comment }
		'found_posts' { return this.found_posts }
		'max_num_pages' { return this.max_num_pages }
		'max_num_comment_pages' { return rt.new_int(this.max_num_comment_pages) }
		'is_single' { return rt.new_bool(this.is_single) }
		'is_preview' { return rt.new_bool(this.is_preview) }
		'is_page' { return rt.new_bool(this.is_page) }
		'is_archive' { return rt.new_bool(this.is_archive) }
		'is_date' { return rt.new_bool(this.is_date) }
		'is_year' { return rt.new_bool(this.is_year) }
		'is_month' { return rt.new_bool(this.is_month) }
		'is_day' { return rt.new_bool(this.is_day) }
		'is_time' { return rt.new_bool(this.is_time) }
		'is_author' { return rt.new_bool(this.is_author) }
		'is_category' { return rt.new_bool(this.is_category) }
		'is_tag' { return rt.new_bool(this.is_tag) }
		'is_tax' { return rt.new_bool(this.is_tax) }
		'is_search' { return rt.new_bool(this.is_search) }
		'is_feed' { return this.is_feed }
		'is_comment_feed' { return rt.new_bool(this.is_comment_feed) }
		'is_trackback' { return rt.new_bool(this.is_trackback) }
		'is_home' { return rt.new_bool(this.is_home) }
		'is_privacy_policy' { return rt.new_bool(this.is_privacy_policy) }
		'is_404' { return rt.new_bool(this.is_404) }
		'is_embed' { return rt.new_bool(this.is_embed) }
		'is_paged' { return rt.new_bool(this.is_paged) }
		'is_admin' { return rt.new_bool(this.is_admin) }
		'is_attachment' { return rt.new_bool(this.is_attachment) }
		'is_singular' { return rt.new_bool(this.is_singular) }
		'is_robots' { return rt.new_bool(this.is_robots) }
		'is_favicon' { return rt.new_bool(this.is_favicon) }
		'is_posts_page' { return rt.new_bool(this.is_posts_page) }
		'is_post_type_archive' { return rt.new_bool(this.is_post_type_archive) }
		'query_vars_hash' { return this.query_vars_hash }
		'query_vars_changed' { return rt.new_bool(this.query_vars_changed) }
		'thumbnails_cached' { return this.thumbnails_cached }
		'allow_query_attachment_by_filename' { return this.allow_query_attachment_by_filename }
		'stopwords' { return this.stopwords }
		'compat_fields' { return this.compat_fields }
		'compat_methods' { return this.compat_methods }
		'query_cache_key' { return rt.new_string(this.query_cache_key) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'query' { this.query = val; return true }
		'query_vars' { this.query_vars = val; return true }
		'tax_query' { this.tax_query = val; return true }
		'meta_query' { this.meta_query = val; return true }
		'date_query' { this.date_query = val; return true }
		'queried_object' { this.queried_object = val; return true }
		'queried_object_id' { this.queried_object_id = val; return true }
		'request' { this.request = val; return true }
		'posts' { this.posts = val; return true }
		'post_count' { this.post_count = (val).to_i64(); return true }
		'current_post' { this.current_post = val; return true }
		'before_loop' { this.before_loop = (val).to_bool(); return true }
		'in_the_loop' { this.in_the_loop = (val).to_bool(); return true }
		'post' { this.post = val; return true }
		'comments' { this.comments = val; return true }
		'comment_count' { this.comment_count = (val).to_i64(); return true }
		'current_comment' { this.current_comment = val; return true }
		'comment' { this.comment = val; return true }
		'found_posts' { this.found_posts = val; return true }
		'max_num_pages' { this.max_num_pages = val; return true }
		'max_num_comment_pages' { this.max_num_comment_pages = (val).to_i64(); return true }
		'is_single' { this.is_single = (val).to_bool(); return true }
		'is_preview' { this.is_preview = (val).to_bool(); return true }
		'is_page' { this.is_page = (val).to_bool(); return true }
		'is_archive' { this.is_archive = (val).to_bool(); return true }
		'is_date' { this.is_date = (val).to_bool(); return true }
		'is_year' { this.is_year = (val).to_bool(); return true }
		'is_month' { this.is_month = (val).to_bool(); return true }
		'is_day' { this.is_day = (val).to_bool(); return true }
		'is_time' { this.is_time = (val).to_bool(); return true }
		'is_author' { this.is_author = (val).to_bool(); return true }
		'is_category' { this.is_category = (val).to_bool(); return true }
		'is_tag' { this.is_tag = (val).to_bool(); return true }
		'is_tax' { this.is_tax = (val).to_bool(); return true }
		'is_search' { this.is_search = (val).to_bool(); return true }
		'is_feed' { this.is_feed = val; return true }
		'is_comment_feed' { this.is_comment_feed = (val).to_bool(); return true }
		'is_trackback' { this.is_trackback = (val).to_bool(); return true }
		'is_home' { this.is_home = (val).to_bool(); return true }
		'is_privacy_policy' { this.is_privacy_policy = (val).to_bool(); return true }
		'is_404' { this.is_404 = (val).to_bool(); return true }
		'is_embed' { this.is_embed = (val).to_bool(); return true }
		'is_paged' { this.is_paged = (val).to_bool(); return true }
		'is_admin' { this.is_admin = (val).to_bool(); return true }
		'is_attachment' { this.is_attachment = (val).to_bool(); return true }
		'is_singular' { this.is_singular = (val).to_bool(); return true }
		'is_robots' { this.is_robots = (val).to_bool(); return true }
		'is_favicon' { this.is_favicon = (val).to_bool(); return true }
		'is_posts_page' { this.is_posts_page = (val).to_bool(); return true }
		'is_post_type_archive' { this.is_post_type_archive = (val).to_bool(); return true }
		'query_vars_hash' { this.query_vars_hash = val; return true }
		'query_vars_changed' { this.query_vars_changed = (val).to_bool(); return true }
		'thumbnails_cached' { this.thumbnails_cached = val; return true }
		'allow_query_attachment_by_filename' { this.allow_query_attachment_by_filename = val; return true }
		'stopwords' { this.stopwords = val; return true }
		'compat_fields' { this.compat_fields = val; return true }
		'compat_methods' { this.compat_methods = val; return true }
		'query_cache_key' { this.query_cache_key = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_class_wp_query_php() {
}
