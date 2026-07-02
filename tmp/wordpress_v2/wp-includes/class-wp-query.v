import rt
import crypto.md5

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

fn (mut this Class_WP_Query) init_query_flags() {
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

fn (mut this Class_WP_Query) init() {
	this.posts = rt.new_null()
	this.query = rt.new_null()
	this.query_vars = rt.new_array()
	this.queried_object = rt.new_null()
	this.queried_object_id = rt.new_null()
	this.post_count = 0
	this.current_post = -1
	this.in_the_loop = false
	this.before_loop = true
	this.request = rt.new_null()
	this.post = rt.new_null()
	this.comments = rt.new_null()
	this.comment = rt.new_null()
	this.comment_count = 0
	this.current_comment = -1
	this.found_posts = rt.new_int(0)
	this.max_num_pages = rt.new_int(0)
	this.max_num_comment_pages = 0
	this.init_query_flags()
}

fn (mut this Class_WP_Query) parse_query_vars() {
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
	return var_query_vars_mutated.clone()
}

fn (mut this Class_WP_Query) parse_query(query string) {
	mut var_query_vars := rt.new_null()
	mut query_mutated := query
	if !(query_mutated == '') {
		this.init()
		this.query = rt.call_function('wp_parse_args', [rt.new_string(query_mutated).clone()])
		this.query_vars = this.query
	} else if !(!(this.query).is_null()) {
		this.query = this.query_vars
	}
	this.query_vars = this.fill_query_vars(this.query_vars)
	var_query_vars = this.query_vars
	this.query_vars_changed = true
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('robots')))) {
		this.is_robots = true
	} else if !(!rt.is_true(var_query_vars.array_get(rt.new_string('favicon')))) {
		this.is_favicon = true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('p'))]))))) || rt.new_int((var_query_vars.array_get(rt.new_string('p'))).to_i64()) < 0 {
		var_query_vars.array_set('p', 0)
		var_query_vars.array_set('error', '404')
	} else {
		var_query_vars.array_set('p', rt.new_int((var_query_vars.array_get(rt.new_string('p'))).to_i64()))
	}
	var_query_vars.array_set('page_id', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('page_id'))])) { rt.call_function('absint', [var_query_vars.array_get(rt.new_string('page_id'))]) } else { rt.new_int(0) })
	var_query_vars.array_set('year', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('year'))])) { rt.call_function('absint', [var_query_vars.array_get(rt.new_string('year'))]) } else { rt.new_int(0) })
	var_query_vars.array_set('monthnum', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('monthnum'))])) { rt.call_function('absint', [var_query_vars.array_get(rt.new_string('monthnum'))]) } else { rt.new_int(0) })
	var_query_vars.array_set('day', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('day'))])) { rt.call_function('absint', [var_query_vars.array_get(rt.new_string('day'))]) } else { rt.new_int(0) })
	var_query_vars.array_set('w', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('w'))])) { rt.call_function('absint', [var_query_vars.array_get(rt.new_string('w'))]) } else { rt.new_int(0) })
	var_query_vars.array_set('m', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('m'))])) { rt.call_function('preg_replace', [rt.new_string('|[^0-9]|'), rt.new_string(''), var_query_vars.array_get(rt.new_string('m'))]) } else { rt.new_string('') })
	var_query_vars.array_set('paged', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('paged'))])) { rt.call_function('absint', [var_query_vars.array_get(rt.new_string('paged'))]) } else { rt.new_int(0) })
	var_query_vars.array_set('cat', rt.call_function('preg_replace', [rt.new_string('|[^0-9,-]|'), rt.new_string(''), var_query_vars.array_get(rt.new_string('cat'))]))
	var_query_vars.array_set('author', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('author'))])) { rt.call_function('preg_replace', [rt.new_string('|[^0-9,-]|'), rt.new_string(''), var_query_vars.array_get(rt.new_string('author'))]) } else { rt.new_string('') })
	var_query_vars.array_set('pagename', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('pagename'))])) { var_query_vars.array_get(rt.new_string('pagename')).to_string().trim_space() } else { '' })
	var_query_vars.array_set('name', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('name'))])) { var_query_vars.array_get(rt.new_string('name')).to_string().trim_space() } else { '' })
	var_query_vars.array_set('title', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('title'))])) { var_query_vars.array_get(rt.new_string('title')).to_string().trim_space() } else { '' })
	if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('hour'))])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('hour')))))) {
		var_query_vars.array_set('hour', rt.call_function('absint', [var_query_vars.array_get(rt.new_string('hour'))]))
	} else {
		var_query_vars.array_set('hour', '')
	}
	if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('minute'))])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('minute')))))) {
		var_query_vars.array_set('minute', rt.call_function('absint', [var_query_vars.array_get(rt.new_string('minute'))]))
	} else {
		var_query_vars.array_set('minute', '')
	}
	if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('second'))])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('second')))))) {
		var_query_vars.array_set('second', rt.call_function('absint', [var_query_vars.array_get(rt.new_string('second'))]))
	} else {
		var_query_vars.array_set('second', '')
	}
	if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('menu_order'))])) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('menu_order')))))) {
		var_query_vars.array_set('menu_order', rt.call_function('absint', [var_query_vars.array_get(rt.new_string('menu_order'))]))
	} else {
		var_query_vars.array_set('menu_order', '')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('s'))]))))) || (!(!rt.is_true(var_query_vars.array_get(rt.new_string('s')))) && var_query_vars.array_get(rt.new_string('s')).to_string().len > 1600) {
		var_query_vars.array_set('s', '')
	}
	if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('subpost'))])) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_query_vars.array_get(rt.new_string('subpost')))))) {
		var_query_vars.array_set('attachment', var_query_vars.array_get(rt.new_string('subpost')))
	}
	if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('subpost_id'))])) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_query_vars.array_get(rt.new_string('subpost_id')))))) {
		var_query_vars.array_set('attachment_id', var_query_vars.array_get(rt.new_string('subpost_id')))
	}
	var_query_vars.array_set('attachment_id', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('attachment_id'))])) { rt.call_function('absint', [var_query_vars.array_get(rt.new_string('attachment_id'))]) } else { rt.new_int(0) })
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('attachment')))))) || !(!rt.is_true(var_query_vars.array_get(rt.new_string('attachment_id')))) {
		this.is_single = true
		this.is_attachment = true
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('name')))))) {
		this.is_single = true
	} else if rt.is_true(var_query_vars.array_get(rt.new_string('p'))) {
		this.is_single = true
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('pagename')))))) || !(!rt.is_true(var_query_vars.array_get(rt.new_string('page_id')))) {
		this.is_page = true
		this.is_single = false
	} else {
		if this.query.array_isset(rt.new_string('s')) {
			this.is_search = true
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('second')))))) {
			this.is_time = true
			this.is_date = true
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('minute')))))) {
			this.is_time = true
			this.is_date = true
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('hour')))))) {
			this.is_time = true
			this.is_date = true
		}
		if rt.is_true(var_query_vars.array_get(rt.new_string('day'))) {
			if !(this.is_date) {
				mut var_date := rt.call_function('sprintf', [rt.new_string('%04d-%02d-%02d'), var_query_vars.array_get(rt.new_string('year')), var_query_vars.array_get(rt.new_string('monthnum')), var_query_vars.array_get(rt.new_string('day'))])
				if rt.is_true(var_query_vars.array_get(rt.new_string('monthnum'))) && rt.is_true(var_query_vars.array_get(rt.new_string('year'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_checkdate', [var_query_vars.array_get(rt.new_string('monthnum')), var_query_vars.array_get(rt.new_string('day')), var_query_vars.array_get(rt.new_string('year')), var_date.clone()]))))) {
					var_query_vars.array_set('error', '404')
				} else {
					this.is_day = true
					this.is_date = true
				}
			}
		}
		if rt.is_true(var_query_vars.array_get(rt.new_string('monthnum'))) {
			if !(this.is_date) {
				if rt.is_true(rt.less(rt.new_int(12), var_query_vars.array_get(rt.new_string('monthnum')))) {
					var_query_vars.array_set('error', '404')
				} else {
					this.is_month = true
					this.is_date = true
				}
			}
		}
		if rt.is_true(var_query_vars.array_get(rt.new_string('year'))) {
			if !(this.is_date) {
				this.is_year = true
				this.is_date = true
			}
		}
		if rt.is_true(var_query_vars.array_get(rt.new_string('m'))) {
			this.is_date = true
			if var_query_vars.array_get(rt.new_string('m')).to_string().len > 9 {
				this.is_time = true
			} else if var_query_vars.array_get(rt.new_string('m')).to_string().len > 7 {
				this.is_day = true
			} else if var_query_vars.array_get(rt.new_string('m')).to_string().len > 5 {
				this.is_month = true
			} else {
				this.is_year = true
			}
		}
		if rt.is_true(var_query_vars.array_get(rt.new_string('w'))) {
			this.is_date = true
		}
		this.query_vars_hash = rt.new_bool(false)
		this.parse_tax_query(var_query_vars.clone())
		mut iter_1 := rt.get_property(this.tax_query, 'queries').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax_query := item_1.val
			if !(var_tax_query.clone().is_array()) {
				continue
			}
			if var_tax_query.array_isset(rt.new_string('operator')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('NOT IN'), var_tax_query.array_get(rt.new_string('operator')))))) {
				mut switch_val_1 := var_tax_query.array_get(rt.new_string('taxonomy'))
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('category'))) {
					this.is_category = true
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('post_tag'))) {
					this.is_tag = true
				} else {
					this.is_tax = true
				}
			}
		}
		var_tax_query = rt.new_null()
		if !rt.is_true(var_query_vars.array_get(rt.new_string('author'))) || rt.is_true(rt.equal(rt.new_string('0'), var_query_vars.array_get(rt.new_string('author')))) {
			this.is_author = false
		} else {
			this.is_author = true
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('author_name')))))) {
			this.is_author = true
		}
		if !(!rt.is_true(var_query_vars.array_get(rt.new_string('post_type')))) && !(var_query_vars.array_get(rt.new_string('post_type')).is_array()) {
			mut var_post_type_obj := rt.call_function('get_post_type_object', [var_query_vars.array_get(rt.new_string('post_type'))])
			if !(!rt.is_true(rt.get_property(var_post_type_obj, 'has_archive'))) {
				this.is_post_type_archive = true
			}
		}
		if this.is_post_type_archive || this.is_date || this.is_author || this.is_category || this.is_tag || this.is_tax {
			this.is_archive = true
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_query_vars.array_get(rt.new_string('feed')))))) {
		this.is_feed = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_query_vars.array_get(rt.new_string('embed')))))) {
		this.is_embed = true
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_query_vars.array_get(rt.new_string('tb')))))) {
		this.is_trackback = true
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_query_vars.array_get(rt.new_string('paged')))))) && rt.new_int((var_query_vars.array_get(rt.new_string('paged'))).to_i64()) > 1 {
		this.is_paged = true
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string(''), var_query_vars.array_get(rt.new_string('preview')))))) {
		this.is_preview = true
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		this.is_admin = true
	}
	if rt.is_true(rt.call_function('str_contains', [var_query_vars.array_get(rt.new_string('feed')), rt.new_string('comments-')])) {
		var_query_vars.array_set('feed', rt.call_function('str_replace', [rt.new_string('comments-'), rt.new_string(''), var_query_vars.array_get(rt.new_string('feed'))]))
		var_query_vars.array_set('withcomments', 1)
	}
	this.is_singular = this.is_single || this.is_page || this.is_attachment
	if rt.is_true(this.is_feed) && !(!rt.is_true(var_query_vars.array_get(rt.new_string('withcomments')))) || (!rt.is_true(var_query_vars.array_get(rt.new_string('withoutcomments'))) && this.is_singular) {
		this.is_comment_feed = true
	}
	if !((((((this.is_singular || this.is_archive || this.is_search || rt.is_true(this.is_feed) || (rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) && rt.is_true(this.is_main_query()))) || this.is_trackback) || this.is_404) || this.is_admin) || this.is_robots) || this.is_favicon) {
		this.is_home = true
	}
	if this.is_home && rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.call_function('get_option', [rt.new_string('page_on_front')])) {
		mut var__query := rt.call_function('wp_parse_args', [this.query])
		if var__query.array_isset(rt.new_string('pagename')) && rt.is_true(rt.identical(rt.new_string(''), var__query.array_get(rt.new_string('pagename')))) {
			var__query.array_unset(rt.new_string('pagename'))
		}
		var__query.array_unset(rt.new_string('embed'))
		if !rt.is_true(var__query) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_diff', [rt.func_array_keys(var__query.clone()), rt.create_array([rt.ArrayItem{ key: none, val: 'preview' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'paged' }, rt.ArrayItem{ key: none, val: 'cpage' }])]))))) {
			this.is_page = true
			this.is_home = false
			var_query_vars.array_set('page_id', rt.call_function('get_option', [rt.new_string('page_on_front')]))
			if !(!rt.is_true(var_query_vars.array_get(rt.new_string('paged')))) {
				var_query_vars.array_set('page', var_query_vars.array_get(rt.new_string('paged')))
				var_query_vars.array_unset(rt.new_string('paged'))
			}
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('pagename')))))) {
		this.queried_object = rt.call_function('get_page_by_path', [var_query_vars.array_get(rt.new_string('pagename'))])
		if rt.is_true(this.queried_object) && rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(this.queried_object, 'post_type'))) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[^%]*%(?:postname)%/'), rt.call_function('get_option', [rt.new_string('permalink_structure')])])) {
				mut var_post := rt.call_function('get_page_by_path', [var_query_vars.array_get(rt.new_string('pagename')), rt.get_constant('OBJECT'), rt.new_string('post')])
				if rt.is_true(var_post) {
					this.queried_object = var_post.clone()
					this.is_page = false
					this.is_single = true
				}
			}
		}
		if !(!rt.is_true(this.queried_object)) {
			this.queried_object_id = rt.new_int((rt.get_property(this.queried_object, 'ID')).to_i64())
		} else {
			this.queried_object = rt.new_null()
		}
		if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && !(this.queried_object_id).is_null() && rt.is_true(rt.equal(rt.call_function('get_option', [rt.new_string('page_for_posts')]), this.queried_object_id)) {
			this.is_page = false
			this.is_home = true
			this.is_posts_page = true
		}
		if !(this.queried_object_id).is_null() && rt.is_true(rt.equal(rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')]), this.queried_object_id)) {
			this.is_privacy_policy = true
		}
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('page_id'))) {
		if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.equal(rt.call_function('get_option', [rt.new_string('page_for_posts')]), var_query_vars.array_get(rt.new_string('page_id')))) {
			this.is_page = false
			this.is_home = true
			this.is_posts_page = true
		}
		if rt.is_true(rt.equal(rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')]), var_query_vars.array_get(rt.new_string('page_id')))) {
			this.is_privacy_policy = true
		}
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('post_type')))) {
		if rt.is_true(rt.new_bool(var_query_vars.array_get(rt.new_string('post_type')).is_array())) {
			var_query_vars.array_set('post_type', rt.call_function('array_map', [rt.new_string('sanitize_key'), rt.call_function('array_unique', [var_query_vars.array_get(rt.new_string('post_type'))])]))
			rt.call_function('sort', [var_query_vars.array_get(rt.new_string('post_type'))])
		} else {
			var_query_vars.array_set('post_type', rt.call_function('sanitize_key', [var_query_vars.array_get(rt.new_string('post_type'))]))
		}
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('post_status')))) {
		if rt.is_true(rt.new_bool(var_query_vars.array_get(rt.new_string('post_status')).is_array())) {
			var_query_vars.array_set('post_status', rt.call_function('array_map', [rt.new_string('sanitize_key'), rt.call_function('array_unique', [var_query_vars.array_get(rt.new_string('post_status'))])]))
			rt.call_function('sort', [var_query_vars.array_get(rt.new_string('post_status'))])
		} else {
			var_query_vars.array_set('post_status', rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9_,-]|'), rt.new_string(''), var_query_vars.array_get(rt.new_string('post_status'))]))
		}
	}
	if this.is_posts_page && !(var_query_vars.array_isset(rt.new_string('withcomments'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('withcomments')))))) {
		this.is_comment_feed = false
	}
	this.is_singular = this.is_single || this.is_page || this.is_attachment
	if rt.is_true(rt.equal(rt.new_string('404'), var_query_vars.array_get(rt.new_string('error')))) {
		this.set_404()
	}
	this.is_embed = this.is_embed && this.is_singular || this.is_404
	this.query_vars_hash = rt.new_string(md5.hexhash(rt.call_function('serialize', [this.query_vars]).to_string()))
	this.query_vars_changed = false
	rt.call_function('do_action_ref_array', [rt.new_string('parse_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
}

fn (mut this Class_WP_Query) parse_tax_query(var_query_vars rt.PhpVal) {
	mut var_query_vars_mutated := var_query_vars
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tax_query')))) && var_query_vars_mutated.array_get(rt.new_string('tax_query')).is_array() {
	mut var_tax_query := var_query_vars_mutated.array_get(rt.new_string('tax_query'))
	} else {
	var_tax_query = rt.new_array()
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('taxonomy')))) && !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('term')))) {
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_query_vars_mutated.array_get(rt.new_string('taxonomy')) }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: none, val: var_query_vars_mutated.array_get(rt.new_string('term')) }]) }, rt.ArrayItem{ key: 'field', val: 'slug' }]))
	}
	mut iter_2 := rt.call_function('get_taxonomies', [rt.new_array(), rt.new_string('objects')]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_t := item_2.val
		mut var_taxonomy := item_2.key
		if rt.is_true(rt.identical(rt.new_string('post_tag'), var_taxonomy)) {
			continue
		}
		if rt.is_true(rt.get_property(var_t, 'query_var')) && !(!rt.is_true(var_query_vars_mutated.array_get(rt.get_property(var_t, 'query_var')))) {
			mut var_tax_query_defaults := { 'taxonomy': var_taxonomy, 'field': rt.new_string('slug') }
			if var_query_vars_mutated.array_get(rt.get_property(var_t, 'query_var')).is_string() && !(!rt.is_true(rt.get_property(var_t, 'rewrite').array_get(rt.new_string('hierarchical')))) {
				var_query_vars_mutated.array_set(rt.get_property(var_t, 'query_var'), rt.call_function('wp_basename', [var_query_vars_mutated.array_get(rt.get_property(var_t, 'query_var'))]))
			}
			mut var_term := var_query_vars_mutated.array_get(rt.get_property(var_t, 'query_var'))
			if !(var_term.clone().is_array()) {
			var_term = rt.call_function('explode', [rt.new_string(','), var_term.clone()])
			var_term = rt.call_function('array_map', [rt.new_string('trim'), var_term.clone()])
			}
			rt.call_function('sort', [var_term.clone()])
			var_term = rt.call_function('implode', [rt.new_string(','), var_term.clone()])
			if rt.is_true(rt.call_function('str_contains', [var_term.clone(), rt.new_string('+')])) {
				mut var_terms := rt.call_function('preg_split', [rt.new_string('/[+]+/'), var_term.clone()])
				mut iter_3 := var_terms.iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_term_shadow := item_3.val
					var_tax_query.array_push(rt.call_function('array_merge', [rt.create_array_from_native_map(var_tax_query_defaults), rt.create_array([rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: none, val: var_term_shadow }]) }])]))
				}
			} else {
				var_tax_query.array_push(rt.call_function('array_merge', [rt.create_array_from_native_map(var_tax_query_defaults), rt.create_array([rt.ArrayItem{ key: 'terms', val: rt.call_function('preg_split', [rt.new_string('/[,]+/'), var_term.clone()]) }])]))
			}
		}
	}
	if rt.is_true(rt.new_bool(var_query_vars_mutated.array_get(rt.new_string('cat')).is_array())) {
		var_query_vars_mutated.array_set('cat', rt.call_function('implode', [rt.new_string(','), var_query_vars_mutated.array_get(rt.new_string('cat'))]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('cat')))) && !(this.is_singular) {
		mut var_cat_in := rt.new_array()
		mut var_cat_not_in := rt.new_array()
		mut var_cat_array := rt.call_function('preg_split', [rt.new_string('/[,\\s]+/'), rt.call_function('urldecode', [var_query_vars_mutated.array_get(rt.new_string('cat'))])])
		var_cat_array = rt.call_function('array_map', [rt.new_string('intval'), var_cat_array.clone()])
		rt.call_function('sort', [var_cat_array.clone()])
		var_query_vars_mutated.array_set('cat', rt.call_function('implode', [rt.new_string(','), var_cat_array.clone()]))
		mut iter_4 := var_cat_array.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_cat := item_4.val
			if rt.is_true(rt.greater(var_cat, rt.new_int(0))) {
				var_cat_in << var_cat.clone()
			} else if rt.is_true(rt.less(var_cat, rt.new_int(0))) {
				var_cat_not_in << rt.call_function('abs', [var_cat.clone()])
			}
		}
		if !(!rt.is_true(var_cat_in)) {
			var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' }, rt.ArrayItem{ key: 'terms', val: var_cat_in }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'include_children', val: true }]))
		}
		if !(!rt.is_true(var_cat_not_in)) {
			var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' }, rt.ArrayItem{ key: 'terms', val: var_cat_not_in }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }, rt.ArrayItem{ key: 'include_children', val: true }]))
		}
		var_cat_array = rt.new_null()
		var_cat_in = rt.new_null()
		var_cat_not_in = rt.new_null()
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('category__and')))) && 1 == rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('category__and'))).array_count() {
		var_query_vars_mutated.array_set('category__and', rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('category__and'))))
		if !(var_query_vars_mutated.array_isset(rt.new_string('category__in'))) {
			var_query_vars_mutated.array_set('category__in', rt.new_array())
		}
		var_query_vars_mutated.array_get_mut('category__in').array_push(rt.call_function('absint', [rt.call_function('reset', [var_query_vars_mutated.array_get(rt.new_string('category__and'))])]))
		var_query_vars_mutated.array_unset(rt.new_string('category__and'))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('category__in')))) {
		var_query_vars_mutated.array_set('category__in', rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('category__in')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('category__in'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('category__in')) }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'include_children', val: false }]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('category__not_in')))) {
		var_query_vars_mutated.array_set('category__not_in', rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('category__not_in')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('category__not_in'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('category__not_in')) }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }, rt.ArrayItem{ key: 'include_children', val: false }]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('category__and')))) {
		var_query_vars_mutated.array_set('category__and', rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('category__and')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('category__and'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('category__and')) }, rt.ArrayItem{ key: 'field', val: 'term_id' }, rt.ArrayItem{ key: 'operator', val: 'AND' }, rt.ArrayItem{ key: 'include_children', val: false }]))
	}
	if rt.is_true(rt.new_bool(var_query_vars_mutated.array_get(rt.new_string('tag')).is_array())) {
		var_query_vars_mutated.array_set('tag', rt.call_function('implode', [rt.new_string(','), var_query_vars_mutated.array_get(rt.new_string('tag'))]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars_mutated.array_get(rt.new_string('tag')))))) && !(this.is_singular) && this.query_vars_changed {
		if rt.is_true(rt.call_function('str_contains', [var_query_vars_mutated.array_get(rt.new_string('tag')), rt.new_string(',')])) {
			mut var_tags := rt.call_function('preg_split', [rt.new_string('/[,\\r\\n\\t ]+/'), var_query_vars_mutated.array_get(rt.new_string('tag'))])
			mut iter_5 := rt.cast_array(var_tags).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_tag := item_5.val
				var_tag = rt.call_function('sanitize_term_field', [rt.new_string('slug'), var_tag.clone(), rt.new_int(0), rt.new_string('post_tag'), rt.new_string('db')])
				var_query_vars_mutated.array_get_mut('tag_slug__in').array_push(var_tag.clone())
				rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('tag_slug__in'))])
			}
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[+\\r\\n\\t ]+/'), var_query_vars_mutated.array_get(rt.new_string('tag'))])) || !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('cat')))) {
			var_tags = rt.call_function('preg_split', [rt.new_string('/[+\\r\\n\\t ]+/'), var_query_vars_mutated.array_get(rt.new_string('tag'))])
			mut iter_6 := rt.cast_array(var_tags).iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_tag := item_6.val
				var_tag = rt.call_function('sanitize_term_field', [rt.new_string('slug'), var_tag.clone(), rt.new_int(0), rt.new_string('post_tag'), rt.new_string('db')])
				var_query_vars_mutated.array_get_mut('tag_slug__and').array_push(var_tag.clone())
			}
		} else {
			var_query_vars_mutated.array_set('tag', rt.call_function('sanitize_term_field', [rt.new_string('slug'), var_query_vars_mutated.array_get(rt.new_string('tag')), rt.new_int(0), rt.new_string('post_tag'), rt.new_string('db')]))
			var_query_vars_mutated.array_get_mut('tag_slug__in').array_push(var_query_vars_mutated.array_get(rt.new_string('tag')))
			rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('tag_slug__in'))])
		}
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tag_id')))) {
		var_query_vars_mutated.array_set('tag_id', rt.call_function('absint', [var_query_vars_mutated.array_get(rt.new_string('tag_id'))]))
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_tag' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('tag_id')) }]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tag__in')))) {
		var_query_vars_mutated.array_set('tag__in', rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('tag__in')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('tag__in'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_tag' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('tag__in')) }]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tag__not_in')))) {
		var_query_vars_mutated.array_set('tag__not_in', rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('tag__not_in')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('tag__not_in'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_tag' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('tag__not_in')) }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tag__and')))) {
		var_query_vars_mutated.array_set('tag__and', rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('tag__and')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('tag__and'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_tag' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('tag__and')) }, rt.ArrayItem{ key: 'operator', val: 'AND' }]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tag_slug__in')))) {
		var_query_vars_mutated.array_set('tag_slug__in', rt.call_function('array_map', [rt.new_string('sanitize_title_for_query'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('tag_slug__in')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('tag_slug__in'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_tag' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('tag_slug__in')) }, rt.ArrayItem{ key: 'field', val: 'slug' }]))
	}
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('tag_slug__and')))) {
		var_query_vars_mutated.array_set('tag_slug__and', rt.call_function('array_map', [rt.new_string('sanitize_title_for_query'), rt.call_function('array_unique', [rt.cast_array(var_query_vars_mutated.array_get(rt.new_string('tag_slug__and')))])]))
		rt.call_function('sort', [var_query_vars_mutated.array_get(rt.new_string('tag_slug__and'))])
		var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'post_tag' }, rt.ArrayItem{ key: 'terms', val: var_query_vars_mutated.array_get(rt.new_string('tag_slug__and')) }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'operator', val: 'AND' }]))
	}
	this.tax_query = create_wp_tax_query(var_tax_query.clone())
	rt.call_function('do_action', [rt.new_string('parse_tax_query'), rt.new_object('WP_Query', []string{}, &this)])
}

fn (mut this Class_WP_Query) parse_search(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_query_vars_mutated := var_query_vars
	mut var_search := rt.new_string('')
	var_query_vars_mutated.array_set('s', rt.call_function('stripslashes', [var_query_vars_mutated.array_get(rt.new_string('s'))]))
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('s'))) && rt.is_true(this.is_main_query()) {
		var_query_vars_mutated.array_set('s', rt.call_function('urldecode', [var_query_vars_mutated.array_get(rt.new_string('s'))]))
	}
	var_query_vars_mutated.array_set('s', rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '\r' }, rt.ArrayItem{ key: none, val: '\n' }]), rt.new_string(''), var_query_vars_mutated.array_get(rt.new_string('s'))]))
	var_query_vars_mutated.array_set('search_terms_count', 1)
	if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('sentence')))) {
		var_query_vars_mutated.array_set('search_terms', rt.create_array([rt.ArrayItem{ key: none, val: var_query_vars_mutated.array_get(rt.new_string('s')) }]))
	} else {
		if rt.is_true(rt.call_function('preg_match_all', [rt.new_string('/".*?("|$)|((?<=[\\t ",+])|^)[^\\t ",+]+/'), var_query_vars_mutated.array_get(rt.new_string('s')), rt.create_array_from_list(var_matches)])) {
			var_query_vars_mutated.array_set('search_terms_count', var_matches.array_get(rt.new_int(0)).array_count())
			var_query_vars_mutated.array_set('search_terms', this.parse_search_terms(var_matches.array_get(rt.new_int(0))))
			if !rt.is_true(var_query_vars_mutated.array_get(rt.new_string('search_terms'))) || var_query_vars_mutated.array_get(rt.new_string('search_terms')).array_count() > 9 {
				var_query_vars_mutated.array_set('search_terms', rt.create_array([rt.ArrayItem{ key: none, val: var_query_vars_mutated.array_get(rt.new_string('s')) }]))
			}
		} else {
			var_query_vars_mutated.array_set('search_terms', rt.create_array([rt.ArrayItem{ key: none, val: var_query_vars_mutated.array_get(rt.new_string('s')) }]))
		}
	}
	mut var_n := rt.new_string((if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('exact')))) { '' } else { '%' }).str())
	mut var_searchand := rt.new_string('')
	var_query_vars_mutated.array_set('search_orderby_title', rt.new_array())
	mut var_default_search_columns := ['post_title', 'post_excerpt', 'post_content']
	mut var_search_columns := if !(!rt.is_true(var_query_vars_mutated.array_get(rt.new_string('search_columns')))) { var_query_vars_mutated.array_get(rt.new_string('search_columns')) } else { var_default_search_columns }
	if !(var_search_columns.clone().is_array()) {
	var_search_columns = rt.create_array([rt.ArrayItem{ key: none, val: var_search_columns }])
	}
	var_search_columns = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('post_search_columns'), var_search_columns.clone(), var_query_vars_mutated.array_get(rt.new_string('s')), rt.new_object('WP_Query', []string{}, &this)]))
	var_search_columns = rt.call_function('array_intersect', [var_search_columns.clone(), rt.create_array_from_list(var_default_search_columns)])
	if !rt.is_true(var_search_columns) {
	var_search_columns = var_default_search_columns.clone()
	}
	mut var_exclusion_prefix := rt.call_function('apply_filters', [rt.new_string('wp_query_search_exclusion_prefix'), rt.new_string('-')])
	mut iter_7 := var_query_vars_mutated.array_get(rt.new_string('search_terms')).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_term := item_7.val
		mut var_exclude := rt.new_bool(rt.is_true(var_exclusion_prefix) && rt.is_true(rt.call_function('str_starts_with', [var_term.clone(), var_exclusion_prefix.clone()])))
		if rt.is_true(var_exclude) {
		mut var_like_op := rt.new_string('NOT LIKE')
		mut var_andor_op := rt.new_string('AND')
		var_term = rt.call_function('substr', [var_term.clone(), rt.new_int(1)])
		} else {
		var_like_op = rt.new_string('LIKE')
		var_andor_op = rt.new_string('OR')
		}
		if rt.is_true(var_n) && rt.is_true(rt.new_bool(!(rt.is_true(var_exclude)))) {
			mut var_like := rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_term.clone()])).str() + '%')
			var_query_vars_mutated.array_get_mut('search_orderby_title').array_push(rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_title LIKE %s')), var_like.clone()]))
		}
		var_like = rt.new_string((var_n).str() + (rt.call_method(var_wpdb, 'esc_like', [var_term.clone()])).str() + (var_n).str())
		mut var_search_columns_parts := rt.new_array()
		mut iter_8 := var_search_columns.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_search_column := item_8.val
			var_search_columns_parts.array_set(var_search_column, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.')), var_search_column), rt.new_string(' ')), var_like_op), rt.new_string(' %s)')), var_like.clone()]))
		}
		if !(!rt.is_true(this.allow_query_attachment_by_filename)) {
			var_search_columns_parts.array_set('attachment', rt.call_method(var_wpdb, 'prepare', [rt.new_string("(sq1.meta_value ${var_like_op.to_string()} %s)"), var_like.clone()]))
		}
		var_search = rt.concat(var_search, rt.new_string("${var_searchand.to_string()}(" + (rt.call_function('implode', [rt.new_string(" ${var_andor_op.to_string()} "), var_search_columns_parts.clone()])).str() + ')'))
	var_searchand = rt.new_string(' AND ')
	}
	if !(!rt.is_true(var_search)) {
		var_search = rt.new_string(" AND (${var_search.to_string()}) ")
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			var_search = rt.concat(var_search, rt.concat(rt.concat(rt.new_string(' AND ('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_password = \'\') ')))
		}
	}
	return var_search.clone()
}

fn (mut this Class_WP_Query) parse_search_terms(var_terms rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_strtolower := rt.new_string((if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strtolower')])) { 'mb_strtolower' } else { 'strtolower' }).str())
	mut var_checked := rt.new_array()
	mut var_stopwords := this.get_search_stopwords()
	mut iter_9 := var_terms_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_term := item_9.val
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^".+"$/'), var_term.clone()])) {
		var_term = rt.new_string(var_term.clone().to_string().trim_space())
		} else {
		var_term = rt.new_string(var_term.clone().to_string().trim_space())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) || (1 == var_term.clone().to_string().len && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z\\-]$/i'), var_term.clone()]))) {
			continue
		}
		if rt.is_true(rt.call_function('in_array', [rt.call_function('call_user_func', [var_strtolower.clone(), var_term.clone()]), var_stopwords.clone(), rt.new_bool(true)])) {
			continue
		}
		var_checked << var_term.clone()
	}
	return var_checked.clone()
}

fn (mut this Class_WP_Query) get_search_stopwords() rt.PhpVal {
	if !(this.stopwords).is_null() {
		return this.stopwords
	}
	mut var_words := rt.call_function('explode', [rt.new_string(','), rt.call_function('_x', [rt.new_string('about,an,are,as,at,be,by,com,for,from,how,in,is,it,of,on,or,that,the,this,to,was,what,when,where,who,will,with,www'), rt.new_string('Comma-separated list of search stopwords in your language')])])
	mut var_stopwords := rt.new_array()
	mut iter_10 := var_words.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_word := item_10.val
		var_word = rt.new_string(var_word.clone().to_string().trim_space())
		if rt.is_true(var_word) {
			var_stopwords.array_push(var_word.clone())
		}
	}
	this.stopwords = rt.call_function('apply_filters', [rt.new_string('wp_search_stopwords'), var_stopwords.clone()])
	return this.stopwords
}

fn (mut this Class_WP_Query) parse_search_order(var_query_vars rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	if rt.is_true(rt.greater(var_query_vars_mutated.array_get(rt.new_string('search_terms_count')), rt.new_int(1))) {
		mut var_num_terms := rt.new_int(var_query_vars_mutated.array_get(rt.new_string('search_orderby_title')).array_count())
		mut var_like := rt.new_string('')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/(?:\\s|^)\\-/'), var_query_vars_mutated.array_get(rt.new_string('s'))]))))) {
		var_like = rt.new_string('%' + (rt.call_method(var_wpdb, 'esc_like', [var_query_vars_mutated.array_get(rt.new_string('s'))])).str() + '%')
		}
		mut var_search_orderby := rt.new_string('')
		if rt.is_true(var_like) {
			var_search_orderby = rt.concat(var_search_orderby, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('WHEN '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_title LIKE %s THEN 1 ')), var_like.clone()]))
		}
		if rt.is_true(rt.less(var_num_terms, rt.new_int(7))) {
			var_search_orderby = rt.concat(var_search_orderby, rt.new_string('WHEN ' + (rt.call_function('implode', [rt.new_string(' AND '), var_query_vars_mutated.array_get(rt.new_string('search_orderby_title'))])).str() + ' THEN 2 '))
			if rt.is_true(rt.greater(var_num_terms, rt.new_int(1))) {
				var_search_orderby = rt.concat(var_search_orderby, rt.new_string('WHEN ' + (rt.call_function('implode', [rt.new_string(' OR '), var_query_vars_mutated.array_get(rt.new_string('search_orderby_title'))])).str() + ' THEN 3 '))
			}
		}
		if rt.is_true(var_like) {
			var_search_orderby = rt.concat(var_search_orderby, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('WHEN '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_excerpt LIKE %s THEN 4 ')), var_like.clone()]))
			var_search_orderby = rt.concat(var_search_orderby, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('WHEN '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_content LIKE %s THEN 5 ')), var_like.clone()]))
		}
		if rt.is_true(var_search_orderby) {
		var_search_orderby = rt.new_string('(CASE ' + (var_search_orderby).str() + 'ELSE 6 END)')
		}
	} else {
	var_search_orderby = rt.new_string((rt.call_function('reset', [var_query_vars_mutated.array_get(rt.new_string('search_orderby_title'))])).str() + ' DESC')
	}
	return var_search_orderby.clone()
}

fn (mut this Class_WP_Query) parse_orderby(var_orderby rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_orderby_mutated := var_orderby
	mut var_allowed_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'post_name' }, rt.ArrayItem{ key: none, val: 'post_author' }, rt.ArrayItem{ key: none, val: 'post_date' }, rt.ArrayItem{ key: none, val: 'post_title' }, rt.ArrayItem{ key: none, val: 'post_modified' }, rt.ArrayItem{ key: none, val: 'post_parent' }, rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'author' }, rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'modified' }, rt.ArrayItem{ key: none, val: 'parent' }, rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: 'ID' }, rt.ArrayItem{ key: none, val: 'menu_order' }, rt.ArrayItem{ key: none, val: 'comment_count' }, rt.ArrayItem{ key: none, val: 'rand' }, rt.ArrayItem{ key: none, val: 'post__in' }, rt.ArrayItem{ key: none, val: 'post_parent__in' }, rt.ArrayItem{ key: none, val: 'post_name__in' }])
	mut var_primary_meta_key := rt.new_string('')
	mut var_primary_meta_query := rt.new_bool(false)
	mut var_meta_clauses := rt.call_method(this.meta_query, 'get_clauses', []rt.PhpVal{})
	if !(!rt.is_true(var_meta_clauses)) {
		var_primary_meta_query = rt.call_function('reset', [var_meta_clauses.clone()])
		if !(!rt.is_true(var_primary_meta_query.array_get(rt.new_string('key')))) {
			var_primary_meta_key = var_primary_meta_query.array_get(rt.new_string('key'))
			var_allowed_keys.array_push(var_primary_meta_key.clone())
		}
		var_allowed_keys.array_push('meta_value')
		var_allowed_keys.array_push('meta_value_num')
	var_allowed_keys = rt.call_function('array_merge', [var_allowed_keys.clone(), rt.func_array_keys(var_meta_clauses.clone())])
	}
	mut var_rand_with_seed := rt.new_bool(false)
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/RAND\\(([0-9]+)\\)/i'), var_orderby_mutated.clone(), rt.create_array_from_list(var_matches)])) {
		var_orderby_mutated = rt.call_function('sprintf', [rt.new_string('RAND(%s)'), rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64())])
		var_allowed_keys.array_push(var_orderby_mutated.clone())
	var_rand_with_seed = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_orderby_mutated.clone(), var_allowed_keys.clone(), rt.new_bool(true)]))))) {
		return false
	}
	mut var_orderby_clause := rt.new_string('')
	mut switch_val_2 := var_orderby_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('post_name'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('post_author'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('post_date'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('post_title'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('post_modified'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('post_parent'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('post_type'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('ID'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('menu_order'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('comment_count'))) {
	var_orderby_clause = rt.new_string((rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.')), var_orderby_mutated)).str())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('rand'))) {
	var_orderby_clause = rt.new_string('RAND()')
	} else if rt.is_true(rt.equal(switch_val_2, var_primary_meta_key)) || rt.is_true(rt.equal(switch_val_2, rt.new_string('meta_value'))) {
		if !(!rt.is_true(var_primary_meta_query.array_get(rt.new_string('type')))) {
		var_orderby_clause = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST('), var_primary_meta_query.array_get(rt.new_string('alias'))), rt.new_string('.meta_value AS ')), var_primary_meta_query.array_get(rt.new_string('cast'))), rt.new_string(')'))).str())
		} else {
		var_orderby_clause = rt.new_string((rt.concat(var_primary_meta_query.array_get(rt.new_string('alias')), rt.new_string('.meta_value'))).str())
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('meta_value_num'))) {
	var_orderby_clause = rt.new_string((rt.concat(var_primary_meta_query.array_get(rt.new_string('alias')), rt.new_string('.meta_value+0'))).str())
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('post__in'))) {
		if !(!rt.is_true(this.query_vars.array_get(rt.new_string('post__in')))) {
		var_orderby_clause = rt.new_string((rt.concat(rt.concat(rt.new_string('FIELD('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID,')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), this.query_vars.array_get(rt.new_string('post__in'))])])).str() + ')').str())
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('post_parent__in'))) {
		if !(!rt.is_true(this.query_vars.array_get(rt.new_string('post_parent__in')))) {
		var_orderby_clause = rt.new_string((rt.concat(rt.concat(rt.new_string('FIELD( '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent,')) + (rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_map', [rt.new_string('absint'), this.query_vars.array_get(rt.new_string('post_parent__in'))])])).str() + ' )').str())
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('post_name__in'))) {
		if !(!rt.is_true(this.query_vars.array_get(rt.new_string('post_name__in')))) {
		mut var_post_name__in := rt.call_function('array_map', [rt.new_string('sanitize_title_for_query'), this.query_vars.array_get(rt.new_string('post_name__in'))])
		mut var_post_name__in_string := rt.new_string('\'' + (rt.call_function('implode', [rt.new_string('\',\''), var_post_name__in.clone()])).str() + '\'')
		var_orderby_clause = rt.new_string((rt.concat(rt.concat(rt.new_string('FIELD( '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_name,')) + (var_post_name__in_string).str() + ' )').str())
		}
	} else {
		if rt.is_true(rt.new_bool(var_meta_clauses.clone().array_isset(var_orderby_mutated.clone()))) {
		mut var_meta_clause := var_meta_clauses.array_get(var_orderby_mutated)
		var_orderby_clause = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CAST('), var_meta_clause.array_get(rt.new_string('alias'))), rt.new_string('.meta_value AS ')), var_meta_clause.array_get(rt.new_string('cast'))), rt.new_string(')'))).str())
		} else if rt.is_true(var_rand_with_seed) {
		var_orderby_clause = var_orderby_mutated.clone()
		} else {
		var_orderby_clause = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_')) + (rt.call_function('sanitize_key', [var_orderby_mutated.clone()])).str()).str())
		}
	}
	return (var_orderby_clause).to_bool()
}

fn (mut this Class_WP_Query) parse_order(var_order rt.PhpVal) string {
	if !(var_order.clone().is_string()) || !rt.is_true(var_order) {
		return 'DESC'
	}
	if rt.is_true(rt.identical(rt.new_string('ASC'), rt.new_string(var_order.clone().to_string().to_upper()))) {
		return 'ASC'
	} else {
		return 'DESC'
	}
	return ''
}

fn (mut this Class_WP_Query) set_404() {
	mut var_is_feed := this.is_feed
	this.init_query_flags()
	this.is_404 = true
	this.is_feed = var_is_feed.clone()
	rt.call_function('do_action_ref_array', [rt.new_string('set_404'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
}

fn (mut this Class_WP_Query) get(var_query_var rt.PhpVal, default_value string) rt.PhpVal {
	mut var_query_var_mutated := var_query_var
	return if !(this.query_vars.array_get(var_query_var_mutated)).is_null() { this.query_vars.array_get(var_query_var_mutated) } else { rt.new_string(default_value) }
}

fn (mut this Class_WP_Query) set(var_query_var rt.PhpVal, var_value rt.PhpVal) {
	mut var_query_var_mutated := var_query_var
	this.query_vars.array_set(var_query_var_mutated, var_value.clone())
}

fn (mut this Class_WP_Query) get_posts() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	this.parse_query('')
	rt.call_function('do_action_ref_array', [rt.new_string('pre_get_posts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	mut var_query_vars := this.query_vars
	var_query_vars = this.fill_query_vars(var_query_vars.clone())
	this.allow_query_attachment_by_filename = rt.call_function('apply_filters', [rt.new_string('wp_allow_query_attachment_by_filename'), rt.new_bool(false)])
	rt.call_function('remove_all_filters', [rt.new_string('wp_allow_query_attachment_by_filename')])
	this.meta_query = create_wp_meta_query()
	rt.call_method(this.meta_query, 'parse_query_vars', [var_query_vars.clone()])
	mut var_hash := rt.new_string(md5.hexhash(rt.call_function('serialize', [this.query_vars]).to_string()))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_hash, this.query_vars_hash)))) {
		this.query_vars_changed = true
		this.query_vars_hash = var_hash.clone()
	}
	var_hash = rt.new_null()
	mut var_distinct := rt.new_string('')
	mut var_whichauthor := rt.new_string('')
	mut var_whichmimetype := rt.new_string('')
	mut var_where := rt.new_string('')
	mut var_limits := rt.new_string('')
	mut var_join := rt.new_string('')
	mut var_search := rt.new_string('')
	mut var_groupby := rt.new_string('')
	mut var_post_status_join := rt.new_bool(false)
	mut var_page := rt.new_int(1)
	if var_query_vars.array_isset(rt.new_string('caller_get_posts')) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_Query'), rt.new_string('3.1.0'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is deprecated. Use %2$s instead.')]), rt.new_string('<code>caller_get_posts</code>'), rt.new_string('<code>ignore_sticky_posts</code>')])])
		if !(var_query_vars.array_isset(rt.new_string('ignore_sticky_posts'))) {
			var_query_vars.array_set('ignore_sticky_posts', var_query_vars.array_get(rt.new_string('caller_get_posts')))
		}
	}
	if !(var_query_vars.array_isset(rt.new_string('ignore_sticky_posts'))) {
		var_query_vars.array_set('ignore_sticky_posts', false)
	}
	if !(var_query_vars.array_isset(rt.new_string('suppress_filters'))) {
		var_query_vars.array_set('suppress_filters', false)
	}
	if !(var_query_vars.array_isset(rt.new_string('cache_results'))) {
		var_query_vars.array_set('cache_results', true)
	}
	if !(var_query_vars.array_isset(rt.new_string('update_post_term_cache'))) {
		var_query_vars.array_set('update_post_term_cache', true)
	}
	if !(var_query_vars.array_isset(rt.new_string('update_menu_item_cache'))) {
		var_query_vars.array_set('update_menu_item_cache', false)
	}
	if !(var_query_vars.array_isset(rt.new_string('lazy_load_term_meta'))) {
		var_query_vars.array_set('lazy_load_term_meta', var_query_vars.array_get(rt.new_string('update_post_term_cache')))
	} else if rt.is_true(var_query_vars.array_get(rt.new_string('lazy_load_term_meta'))) {
		var_query_vars.array_set('update_post_term_cache', true)
	}
	if !(var_query_vars.array_isset(rt.new_string('update_post_meta_cache'))) {
		var_query_vars.array_set('update_post_meta_cache', true)
	}
	if !(var_query_vars.array_isset(rt.new_string('post_type'))) {
		if this.is_search {
			var_query_vars.array_set('post_type', 'any')
		} else {
			var_query_vars.array_set('post_type', '')
		}
	}
	mut var_post_type := var_query_vars.array_get(rt.new_string('post_type'))
	if !rt.is_true(var_query_vars.array_get(rt.new_string('posts_per_page'))) {
		var_query_vars.array_set('posts_per_page', rt.call_function('get_option', [rt.new_string('posts_per_page')]))
	}
	if var_query_vars.array_isset(rt.new_string('showposts')) && rt.is_true(var_query_vars.array_get(rt.new_string('showposts'))) {
		var_query_vars.array_set('showposts', rt.new_int((var_query_vars.array_get(rt.new_string('showposts'))).to_i64()))
		var_query_vars.array_set('posts_per_page', var_query_vars.array_get(rt.new_string('showposts')))
	}
	if var_query_vars.array_isset(rt.new_string('posts_per_archive_page')) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_int(0), var_query_vars.array_get(rt.new_string('posts_per_archive_page')))))) && this.is_archive || this.is_search {
		var_query_vars.array_set('posts_per_page', var_query_vars.array_get(rt.new_string('posts_per_archive_page')))
	}
	if !(var_query_vars.array_isset(rt.new_string('nopaging'))) {
		if rt.is_true(rt.equal(-1, var_query_vars.array_get(rt.new_string('posts_per_page')))) {
			var_query_vars.array_set('nopaging', true)
		} else {
			var_query_vars.array_set('nopaging', false)
		}
	}
	if rt.is_true(this.is_feed) {
		if !(!rt.is_true(var_query_vars.array_get(rt.new_string('posts_per_rss')))) {
			var_query_vars.array_set('posts_per_page', var_query_vars.array_get(rt.new_string('posts_per_rss')))
		} else {
			var_query_vars.array_set('posts_per_page', rt.call_function('get_option', [rt.new_string('posts_per_rss')]))
		}
		var_query_vars.array_set('nopaging', false)
	}
	var_query_vars.array_set('posts_per_page', rt.new_int((var_query_vars.array_get(rt.new_string('posts_per_page'))).to_i64()))
	if rt.is_true(rt.less(var_query_vars.array_get(rt.new_string('posts_per_page')), -1)) {
		var_query_vars.array_set('posts_per_page', rt.call_function('abs', [var_query_vars.array_get(rt.new_string('posts_per_page'))]))
	} else if rt.is_true(rt.identical(rt.new_int(0), var_query_vars.array_get(rt.new_string('posts_per_page')))) {
		var_query_vars.array_set('posts_per_page', 1)
	}
	if !(var_query_vars.array_isset(rt.new_string('comments_per_page'))) || rt.is_true(rt.equal(rt.new_int(0), var_query_vars.array_get(rt.new_string('comments_per_page')))) {
		var_query_vars.array_set('comments_per_page', rt.call_function('get_option', [rt.new_string('comments_per_page')]))
	}
	if this.is_home && !rt.is_true(this.query) || rt.is_true(rt.identical(rt.new_string('true'), var_query_vars.array_get(rt.new_string('preview')))) && rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.call_function('get_option', [rt.new_string('page_on_front')])) {
		this.is_page = true
		this.is_home = false
		var_query_vars.array_set('page_id', rt.call_function('get_option', [rt.new_string('page_on_front')]))
	}
	if var_query_vars.array_isset(rt.new_string('page')) {
		var_query_vars.array_set('page', if rt.is_true(rt.call_function('is_scalar', [var_query_vars.array_get(rt.new_string('page'))])) { rt.call_function('absint', [rt.new_string(var_query_vars.array_get(rt.new_string('page')).to_string().trim_space())]) } else { rt.new_int(0) })
	}
	if var_query_vars.array_isset(rt.new_string('no_found_rows')) {
		var_query_vars.array_set('no_found_rows', (var_query_vars.array_get(rt.new_string('no_found_rows'))).to_bool())
	} else {
		var_query_vars.array_set('no_found_rows', false)
	}
	mut switch_val_3 := var_query_vars.array_get(rt.new_string('fields'))
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('ids'))) {
	mut var_fields := rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID'))).str())
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('id=>parent'))) {
	var_fields = rt.new_string((rt.concat(rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID, ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent'))).str())
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string(''))) {
		var_query_vars.array_set('fields', 'all')
	} else {
	var_fields = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.*'))).str())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('menu_order')))))) {
		var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.menu_order = ')) + (var_query_vars.array_get(rt.new_string('menu_order'))).str()))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('m'))) {
		var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND YEAR('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date)=')) + (rt.call_function('substr', [var_query_vars.array_get(rt.new_string('m')), rt.new_int(0), rt.new_int(4)])).str()))
		if var_query_vars.array_get(rt.new_string('m')).to_string().len > 5 {
			var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND MONTH('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date)=')) + (rt.call_function('substr', [var_query_vars.array_get(rt.new_string('m')), rt.new_int(4), rt.new_int(2)])).str()))
		}
		if var_query_vars.array_get(rt.new_string('m')).to_string().len > 7 {
			var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND DAYOFMONTH('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date)=')) + (rt.call_function('substr', [var_query_vars.array_get(rt.new_string('m')), rt.new_int(6), rt.new_int(2)])).str()))
		}
		if var_query_vars.array_get(rt.new_string('m')).to_string().len > 9 {
			var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND HOUR('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date)=')) + (rt.call_function('substr', [var_query_vars.array_get(rt.new_string('m')), rt.new_int(8), rt.new_int(2)])).str()))
		}
		if var_query_vars.array_get(rt.new_string('m')).to_string().len > 11 {
			var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND MINUTE('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date)=')) + (rt.call_function('substr', [var_query_vars.array_get(rt.new_string('m')), rt.new_int(10), rt.new_int(2)])).str()))
		}
		if var_query_vars.array_get(rt.new_string('m')).to_string().len > 13 {
			var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND SECOND('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date)=')) + (rt.call_function('substr', [var_query_vars.array_get(rt.new_string('m')), rt.new_int(12), rt.new_int(2)])).str()))
		}
	}
	mut var_date_parameters := rt.new_array()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('hour')))))) {
		var_date_parameters['hour'] = var_query_vars.array_get(rt.new_string('hour'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('minute')))))) {
		var_date_parameters['minute'] = var_query_vars.array_get(rt.new_string('minute'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('second')))))) {
		var_date_parameters['second'] = var_query_vars.array_get(rt.new_string('second'))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('year'))) {
		var_date_parameters['year'] = var_query_vars.array_get(rt.new_string('year'))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('monthnum'))) {
		var_date_parameters['monthnum'] = var_query_vars.array_get(rt.new_string('monthnum'))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('w'))) {
		var_date_parameters['week'] = var_query_vars.array_get(rt.new_string('w'))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('day'))) {
		var_date_parameters['day'] = var_query_vars.array_get(rt.new_string('day'))
	}
	if rt.is_true(var_date_parameters) {
		mut var_date_query := create_wp_date_query(rt.create_array([rt.ArrayItem{ key: none, val: var_date_parameters }]))
		var_where = rt.concat(var_where, var_date_query.get_sql())
	}
	var_date_parameters = rt.new_null()
	var_date_query = rt.new_null()
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('date_query')))) {
		this.date_query = create_wp_date_query(var_query_vars.array_get(rt.new_string('date_query')))
		var_where = rt.concat(var_where, rt.call_method(this.date_query, 'get_sql', []rt.PhpVal{}))
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('post_type')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('any'), var_query_vars.array_get(rt.new_string('post_type')))))) {
		mut iter_11 := rt.cast_array(var_query_vars.array_get(rt.new_string('post_type'))).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var__post_type := item_11.val
			mut var_ptype_obj := rt.call_function('get_post_type_object', [var__post_type.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_ptype_obj)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_ptype_obj, 'query_var'))))) || !rt.is_true(var_query_vars.array_get(rt.get_property(var_ptype_obj, 'query_var'))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_ptype_obj, 'hierarchical'))))) {
				var_query_vars.array_set('name', var_query_vars.array_get(rt.get_property(var_ptype_obj, 'query_var')))
			} else {
				var_query_vars.array_set('pagename', var_query_vars.array_get(rt.get_property(var_ptype_obj, 'query_var')))
				var_query_vars.array_set('name', '')
			}
			break
		}
		var_ptype_obj = rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('title')))))) {
		var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_title = %s')), rt.call_function('stripslashes', [var_query_vars.array_get(rt.new_string('title'))])]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('name')))))) {
		var_query_vars.array_set('name', rt.call_function('sanitize_title_for_query', [var_query_vars.array_get(rt.new_string('name'))]))
		var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_name = \'')) + (var_query_vars.array_get(rt.new_string('name'))).str() + '\''))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('pagename')))))) {
		if !(this.queried_object_id).is_null() {
		mut var_reqpage := this.queried_object_id
		} else {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), var_query_vars.array_get(rt.new_string('post_type')))))) {
				mut iter_12 := rt.cast_array(var_query_vars.array_get(rt.new_string('post_type'))).iterator()
				for {
					item_12 := iter_12.next() or { break }
					mut var__post_type := item_12.val
					mut var_ptype_obj := rt.call_function('get_post_type_object', [var__post_type.clone()])
					if rt.is_true(rt.new_bool(!(rt.is_true(var_ptype_obj)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_ptype_obj, 'hierarchical'))))) {
						continue
					}
					var_reqpage = rt.call_function('get_page_by_path', [var_query_vars.array_get(rt.new_string('pagename')), rt.get_constant('OBJECT'), var__post_type.clone()])
					if rt.is_true(var_reqpage) {
						break
					}
				}
				var_ptype_obj = rt.new_null()
			} else {
			var_reqpage = rt.call_function('get_page_by_path', [var_query_vars.array_get(rt.new_string('pagename'))])
			}
			if !(!rt.is_true(var_reqpage)) {
			var_reqpage = rt.get_property(var_reqpage, 'ID')
			} else {
			var_reqpage = rt.new_int(0)
			}
		}
		mut var_page_for_posts := rt.call_function('get_option', [rt.new_string('page_for_posts')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))))) || !rt.is_true(var_page_for_posts) || rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_reqpage, var_page_for_posts)))) {
			var_query_vars.array_set('pagename', rt.call_function('sanitize_title_for_query', [rt.call_function('wp_basename', [var_query_vars.array_get(rt.new_string('pagename'))])]))
			var_query_vars.array_set('name', var_query_vars.array_get(rt.new_string('pagename')))
			var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND ('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = \'')), var_reqpage), rt.new_string('\')')))
			mut var_reqpage_obj := rt.call_function('get_post', [var_reqpage.clone()])
			if var_reqpage_obj.clone().is_object() && rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_reqpage_obj, 'post_type'))) {
				this.is_attachment = true
				var_post_type = rt.new_string('attachment')
				var_query_vars.array_set('post_type', 'attachment')
				this.is_page = true
				var_query_vars.array_set('attachment_id', var_reqpage.clone())
			}
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('attachment')))))) {
		var_query_vars.array_set('attachment', rt.call_function('sanitize_title_for_query', [rt.call_function('wp_basename', [var_query_vars.array_get(rt.new_string('attachment'))])]))
		var_query_vars.array_set('name', var_query_vars.array_get(rt.new_string('attachment')))
		var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_name = \'')) + (var_query_vars.array_get(rt.new_string('attachment'))).str() + '\''))
	} else if var_query_vars.array_get(rt.new_string('post_name__in')).is_array() && !(!rt.is_true(var_query_vars.array_get(rt.new_string('post_name__in')))) {
		var_query_vars.array_set('post_name__in', rt.call_function('array_map', [rt.new_string('sanitize_title_for_query'), var_query_vars.array_get(rt.new_string('post_name__in'))]))
		mut var_post_name__in_for_where := rt.call_function('array_unique', [var_query_vars.array_get(rt.new_string('post_name__in'))])
		rt.call_function('sort', [var_post_name__in_for_where.clone()])
		mut var_post_name__in := rt.new_string('\'' + (rt.call_function('implode', [rt.new_string('\',\''), var_post_name__in_for_where.clone()])).str() + '\'')
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_name IN (')), var_post_name__in), rt.new_string(')')))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('attachment_id'))) {
		var_query_vars.array_set('p', rt.call_function('absint', [var_query_vars.array_get(rt.new_string('attachment_id'))]))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('p'))) {
		var_where = rt.concat(var_where, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')) + (var_query_vars.array_get(rt.new_string('p'))).str()))
	} else if rt.is_true(var_query_vars.array_get(rt.new_string('post__in'))) {
		mut var_post__in_for_where := var_query_vars.array_get(rt.new_string('post__in'))
		var_post__in_for_where = rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('absint'), var_post__in_for_where.clone()])])
		rt.call_function('sort', [var_post__in_for_where.clone()])
		mut var_post__in := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_post__in_for_where.clone()])])
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID IN (')), var_post__in), rt.new_string(')')))
	} else if rt.is_true(var_query_vars.array_get(rt.new_string('post__not_in'))) {
		rt.call_function('sort', [var_query_vars.array_get(rt.new_string('post__not_in'))])
		mut var_post__not_in := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_query_vars.array_get(rt.new_string('post__not_in'))])])
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID NOT IN (')), var_post__not_in), rt.new_string(')')))
	}
	if rt.is_true(rt.new_bool(var_query_vars.array_get(rt.new_string('post_parent')).is_long() || var_query_vars.array_get(rt.new_string('post_parent')).is_double())) {
		var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent = %d ')), var_query_vars.array_get(rt.new_string('post_parent'))]))
	} else if rt.is_true(var_query_vars.array_get(rt.new_string('post_parent__in'))) {
		mut var_post_parent__in_for_where := var_query_vars.array_get(rt.new_string('post_parent__in'))
		var_post_parent__in_for_where = rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('absint'), var_post_parent__in_for_where.clone()])])
		rt.call_function('sort', [var_post_parent__in_for_where.clone()])
		mut var_post_parent__in := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_post_parent__in_for_where.clone()])])
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent IN (')), var_post_parent__in), rt.new_string(')')))
	} else if rt.is_true(var_query_vars.array_get(rt.new_string('post_parent__not_in'))) {
		rt.call_function('sort', [var_query_vars.array_get(rt.new_string('post_parent__not_in'))])
		mut var_post_parent__not_in := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_query_vars.array_get(rt.new_string('post_parent__not_in'))])])
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent NOT IN (')), var_post_parent__not_in), rt.new_string(')')))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('page_id'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_function('get_option', [rt.new_string('page_for_posts')]), var_query_vars.array_get(rt.new_string('page_id')))))) {
			var_query_vars.array_set('p', var_query_vars.array_get(rt.new_string('page_id')))
		var_where = rt.new_string((rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')) + (var_query_vars.array_get(rt.new_string('page_id'))).str()).str())
		}
	}
	if rt.is_true(rt.new_int(var_query_vars.array_get(rt.new_string('s')).to_string().len)) {
	var_search = this.parse_search(var_query_vars.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
	var_search = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_search'), rt.create_array([rt.ArrayItem{ key: none, val: var_search }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	}
	if !(this.is_singular) {
		this.parse_tax_query(var_query_vars.clone())
		mut var_clauses := rt.call_method(this.tax_query, 'get_sql', [rt.get_property(var_wpdb, 'posts'), rt.new_string('ID')])
		var_join = rt.concat(var_join, var_clauses.array_get(rt.new_string('join')))
		var_where = rt.concat(var_where, var_clauses.array_get(rt.new_string('where')))
	}
	if this.is_tax {
		if !rt.is_true(var_post_type) {
			var_post_type = rt.new_array()
			mut var_taxonomies := rt.func_array_keys(rt.get_property(this.tax_query, 'queried_terms'))
			mut iter_13 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'exclude_from_search', val: false }])]).iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_pt := item_13.val
				mut var_object_taxonomies := if rt.is_true(rt.identical(rt.new_string('attachment'), var_pt)) { rt.call_function('get_taxonomies_for_attachments', []rt.PhpVal{}) } else { rt.call_function('get_object_taxonomies', [var_pt.clone()]) }
				if rt.is_true(rt.call_function('array_intersect', [var_taxonomies.clone(), var_object_taxonomies.clone()])) {
					var_post_type.array_push(var_pt.clone())
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
			var_post_type = rt.new_string('any')
			} else if var_post_type.clone().array_count() == 1 {
			var_post_type = var_post_type.array_get(rt.new_int(0))
			} else {
				rt.call_function('sort', [var_post_type.clone()])
			}
		var_post_status_join = rt.new_bool(true)
		} else if rt.is_true(rt.call_function('in_array', [rt.new_string('attachment'), rt.cast_array(var_post_type), rt.new_bool(true)])) {
		var_post_status_join = rt.new_bool(true)
		}
	}
	if !(!rt.is_true(rt.get_property(this.tax_query, 'queried_terms'))) {
		if !(var_query_vars.array_isset(rt.new_string('taxonomy'))) {
			mut iter_14 := rt.get_property(this.tax_query, 'queried_terms').iterator()
			for {
				item_14 := iter_14.next() or { break }
				mut var_queried_items := item_14.val
				mut var_queried_taxonomy := item_14.key
				if !rt.is_true(var_queried_items.array_get(rt.new_string('terms')).array_get(rt.new_int(0))) {
					continue
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_queried_taxonomy.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'category' }, rt.ArrayItem{ key: none, val: 'post_tag' }]), rt.new_bool(true)]))))) {
					var_query_vars.array_set('taxonomy', var_queried_taxonomy.clone())
					if rt.is_true(rt.identical(rt.new_string('slug'), var_queried_items.array_get(rt.new_string('field')))) {
						var_query_vars.array_set('term', var_queried_items.array_get(rt.new_string('terms')).array_get(rt.new_int(0)))
					} else {
						var_query_vars.array_set('term_id', var_queried_items.array_get(rt.new_string('terms')).array_get(rt.new_int(0)))
					}
					break
				}
			}
		}
		mut iter_15 := rt.get_property(this.tax_query, 'queried_terms').iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_queried_items := item_15.val
			mut var_queried_taxonomy := item_15.key
			if !rt.is_true(var_queried_items.array_get(rt.new_string('terms')).array_get(rt.new_int(0))) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('category'), var_queried_taxonomy)) {
				mut var_the_cat := rt.call_function('get_term_by', [var_queried_items.array_get(rt.new_string('field')), var_queried_items.array_get(rt.new_string('terms')).array_get(rt.new_int(0)), rt.new_string('category')])
				if rt.is_true(var_the_cat) {
					this.set(rt.new_string('cat'), rt.get_property(var_the_cat, 'term_id'))
					this.set(rt.new_string('category_name'), rt.get_property(var_the_cat, 'slug'))
				}
				var_the_cat = rt.new_null()
			}
			if rt.is_true(rt.identical(rt.new_string('post_tag'), var_queried_taxonomy)) {
				mut var_the_tag := rt.call_function('get_term_by', [var_queried_items.array_get(rt.new_string('field')), var_queried_items.array_get(rt.new_string('terms')).array_get(rt.new_int(0)), rt.new_string('post_tag')])
				if rt.is_true(var_the_tag) {
					this.set(rt.new_string('tag_id'), rt.get_property(var_the_tag, 'term_id'))
				}
				var_the_tag = rt.new_null()
			}
		}
	}
	if !(!rt.is_true(rt.get_property(this.tax_query, 'queries'))) || !(!rt.is_true(rt.get_property(this.meta_query, 'queries'))) || !(!rt.is_true(this.allow_query_attachment_by_filename)) {
	var_groupby = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID'))).str())
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('author')))) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('0'), var_query_vars.array_get(rt.new_string('author')))))) {
		var_query_vars.array_set('author', rt.call_function('wp_slash', [rt.new_string('' + (rt.call_function('urldecode', [var_query_vars.array_get(rt.new_string('author'))])).str())]))
		mut var_authors := rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('intval'), rt.call_function('preg_split', [rt.new_string('/[,\\s]+/'), var_query_vars.array_get(rt.new_string('author'))])])])
		rt.call_function('sort', [var_authors.clone()])
		mut iter_16 := var_authors.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_author := item_16.val
			mut var_key := rt.new_string((if rt.is_true(rt.greater(var_author, rt.new_int(0))) { 'author__in' } else { 'author__not_in' }).str())
			var_query_vars.array_get_mut(var_key).array_push(rt.call_function('abs', [var_author.clone()]))
		}
		var_query_vars.array_set('author', rt.call_function('implode', [rt.new_string(','), var_authors.clone()]))
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('author__not_in')))) {
		if rt.is_true(rt.new_bool(var_query_vars.array_get(rt.new_string('author__not_in')).is_array())) {
			var_query_vars.array_set('author__not_in', rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('absint'), var_query_vars.array_get(rt.new_string('author__not_in'))])]))
			rt.call_function('sort', [var_query_vars.array_get(rt.new_string('author__not_in'))])
		}
		mut var_author__not_in := rt.call_function('implode', [rt.new_string(','), rt.cast_array(var_query_vars.array_get(rt.new_string('author__not_in')))])
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author NOT IN (')), var_author__not_in), rt.new_string(') ')))
	} else if !(!rt.is_true(var_query_vars.array_get(rt.new_string('author__in')))) {
		if rt.is_true(rt.new_bool(var_query_vars.array_get(rt.new_string('author__in')).is_array())) {
			var_query_vars.array_set('author__in', rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('absint'), var_query_vars.array_get(rt.new_string('author__in'))])]))
			rt.call_function('sort', [var_query_vars.array_get(rt.new_string('author__in'))])
		}
		mut var_author__in := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('array_unique', [rt.cast_array(var_query_vars.array_get(rt.new_string('author__in')))])])])
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author IN (')), var_author__in), rt.new_string(') ')))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('author_name')))))) {
		if rt.is_true(rt.call_function('str_contains', [var_query_vars.array_get(rt.new_string('author_name')), rt.new_string('/')])) {
			var_query_vars.array_set('author_name', rt.call_function('explode', [rt.new_string('/'), var_query_vars.array_get(rt.new_string('author_name'))]))
			if rt.is_true(var_query_vars.array_get(rt.new_string('author_name')).array_get(rt.new_int(var_query_vars.array_get(rt.new_string('author_name')).array_count() - 1))) {
				var_query_vars.array_set('author_name', var_query_vars.array_get(rt.new_string('author_name')).array_get(rt.new_int(var_query_vars.array_get(rt.new_string('author_name')).array_count() - 1)))
			} else {
				var_query_vars.array_set('author_name', var_query_vars.array_get(rt.new_string('author_name')).array_get(rt.new_int(var_query_vars.array_get(rt.new_string('author_name')).array_count() - 2)))
			}
		}
		var_query_vars.array_set('author_name', rt.call_function('sanitize_title_for_query', [var_query_vars.array_get(rt.new_string('author_name'))]))
		var_query_vars.array_set('author', rt.call_function('get_user_by', [rt.new_string('slug'), var_query_vars.array_get(rt.new_string('author_name'))]))
		if rt.is_true(var_query_vars.array_get(rt.new_string('author'))) {
			var_query_vars.array_set('author', rt.get_property(var_query_vars.array_get(rt.new_string('author')), 'ID'))
		}
		var_whichauthor = rt.concat(var_whichauthor, rt.new_string(rt.concat(rt.concat(rt.new_string(' AND ('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author = ')) + (rt.call_function('absint', [var_query_vars.array_get(rt.new_string('author'))])).str() + ')'))
	}
	if var_query_vars.array_isset(rt.new_string('comment_count')) {
		if rt.is_true(rt.new_bool(var_query_vars.array_get(rt.new_string('comment_count')).is_long() || var_query_vars.array_get(rt.new_string('comment_count')).is_double())) {
			var_query_vars.array_set('comment_count', rt.create_array([rt.ArrayItem{ key: 'value', val: rt.new_int((var_query_vars.array_get(rt.new_string('comment_count'))).to_i64()) }]))
		}
		if var_query_vars.array_get(rt.new_string('comment_count')).array_isset(rt.new_string('value')) {
			var_query_vars.array_set('comment_count', rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'compare', val: '=' }]), var_query_vars.array_get(rt.new_string('comment_count'))]))
			mut var_compare_operators := ['=', '!=', '>', '>=', '<', '<=']
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_query_vars.array_get(rt.new_string('comment_count')).array_get(rt.new_string('compare')), rt.create_array_from_list(var_compare_operators), rt.new_bool(true)]))))) {
				var_query_vars.array_get_mut('comment_count').array_set('compare', '=')
			}
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.comment_count ')), var_query_vars.array_get(rt.new_string('comment_count')).array_get(rt.new_string('compare'))), rt.new_string(' %d')), var_query_vars.array_get(rt.new_string('comment_count')).array_get(rt.new_string('value'))]))
		}
	}
	if var_query_vars.array_isset(rt.new_string('post_mime_type')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_query_vars.array_get(rt.new_string('post_mime_type')))))) {
	var_whichmimetype = rt.call_function('wp_post_mime_type_where', [var_query_vars.array_get(rt.new_string('post_mime_type')), rt.get_property(var_wpdb, 'posts')])
	}
	var_where = rt.concat(var_where, rt.new_string((var_search).str() + (var_whichauthor).str() + (var_whichmimetype).str()))
	if !(!rt.is_true(this.allow_query_attachment_by_filename)) {
		var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' AS sq1 ON ( ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = sq1.post_id AND sq1.meta_key = \'_wp_attached_file\' )')))
	}
	if !(!rt.is_true(rt.get_property(this.meta_query, 'queries'))) {
		var_clauses = rt.call_method(this.meta_query, 'get_sql', [rt.new_string('post'), rt.get_property(var_wpdb, 'posts'), rt.new_string('ID'), rt.new_object('WP_Query', []string{}, &this)])
		var_join = rt.concat(var_join, var_clauses.array_get(rt.new_string('join')))
		var_where = rt.concat(var_where, var_clauses.array_get(rt.new_string('where')))
	}
	mut var_rand := rt.new_bool(var_query_vars.array_isset(rt.new_string('orderby')) && rt.is_true(rt.identical(rt.new_string('rand'), var_query_vars.array_get(rt.new_string('orderby')))))
	if !(var_query_vars.array_isset(rt.new_string('order'))) {
		var_query_vars.array_set('order', if rt.is_true(var_rand) { '' } else { 'DESC' })
	} else {
		var_query_vars.array_set('order', if rt.is_true(var_rand) { '' } else { this.parse_order(var_query_vars.array_get(rt.new_string('order'))) })
	}
	mut var_force_asc := ['post__in', 'post_name__in', 'post_parent__in']
	if var_query_vars.array_isset(rt.new_string('orderby')) && rt.is_true(rt.call_function('in_array', [var_query_vars.array_get(rt.new_string('orderby')), rt.create_array_from_list(var_force_asc), rt.new_bool(true)])) {
		var_query_vars.array_set('order', '')
	}
	if !rt.is_true(var_query_vars.array_get(rt.new_string('orderby'))) {
		if var_query_vars.array_isset(rt.new_string('orderby')) && var_query_vars.array_get(rt.new_string('orderby')).is_array() || rt.is_true(rt.identical(rt.new_bool(false), var_query_vars.array_get(rt.new_string('orderby')))) {
		mut var_orderby := rt.new_string('')
		} else {
		var_orderby = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_date ')) + (var_query_vars.array_get(rt.new_string('order'))).str()).str())
		}
	} else if rt.is_true(rt.identical(rt.new_string('none'), var_query_vars.array_get(rt.new_string('orderby')))) {
	var_orderby = rt.new_string('')
	} else {
		mut var_orderby_array := rt.new_array()
		if rt.is_true(rt.new_bool(var_query_vars.array_get(rt.new_string('orderby')).is_array())) {
			mut iter_17 := var_query_vars.array_get(rt.new_string('orderby')).iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_order := item_17.val
				mut var__orderby := item_17.key
				var_orderby = rt.call_function('wp_slash', [rt.call_function('urldecode', [var__orderby.clone()])])
				mut var_parsed := rt.new_bool(this.parse_orderby(var_orderby.clone()))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
					continue
				}
				var_orderby_array << (var_parsed).str() + ' ' + this.parse_order(var_order.clone())
			}
		var_orderby = rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_orderby_array)])
		} else {
			var_query_vars.array_set('orderby', rt.call_function('urldecode', [var_query_vars.array_get(rt.new_string('orderby'))]))
			var_query_vars.array_set('orderby', rt.call_function('wp_slash', [var_query_vars.array_get(rt.new_string('orderby'))]))
			mut iter_18 := rt.call_function('explode', [rt.new_string(' '), var_query_vars.array_get(rt.new_string('orderby'))]).iterator()
			for {
				item_18 := iter_18.next() or { break }
				mut var_orderby_shadow := item_18.val
				mut var_i := item_18.key
				mut var_parsed := rt.new_bool(this.parse_orderby(var_orderby_shadow.clone()))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_parsed)))) {
					continue
				}
				var_orderby_array << var_parsed.clone()
			}
			var_orderby = rt.call_function('implode', [rt.new_string(' ' + (var_query_vars.array_get(rt.new_string('order'))).str() + ', '), rt.create_array_from_list(var_orderby_array)])
			if !rt.is_true(var_orderby) {
			var_orderby = rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_date ')) + (var_query_vars.array_get(rt.new_string('order'))).str()).str())
			} else if !(!rt.is_true(var_query_vars.array_get(rt.new_string('order')))) {
				var_orderby = rt.concat(var_orderby, rt.concat(rt.new_string(' '), var_query_vars.array_get(rt.new_string('order'))))
			}
		}
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('s')))) {
		mut var_search_orderby := rt.new_string('')
		if (!(!rt.is_true(var_query_vars.array_get(rt.new_string('search_orderby_title')))) && !rt.is_true(var_query_vars.array_get(rt.new_string('orderby'))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_feed))))) || (var_query_vars.array_isset(rt.new_string('orderby')) && rt.is_true(rt.identical(rt.new_string('relevance'), var_query_vars.array_get(rt.new_string('orderby'))))) {
		var_search_orderby = this.parse_search_order(var_query_vars.clone())
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
		var_search_orderby = rt.call_function('apply_filters', [rt.new_string('posts_search_orderby'), var_search_orderby.clone(), rt.new_object('WP_Query', []string{}, &this)])
		}
		if rt.is_true(var_search_orderby) {
		var_orderby = if rt.is_true(var_orderby) { (var_search_orderby).str() + ', ' + (var_orderby).str() } else { var_search_orderby }
		}
	}
	if var_post_type.clone().is_array() && var_post_type.clone().array_count() > 1 {
	mut var_post_type_cap := rt.new_string('multiple_post_type')
	} else {
		if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
		var_post_type = rt.call_function('reset', [var_post_type.clone()])
		}
		mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.clone()])
		if !rt.is_true(var_post_type_object) {
		var_post_type_cap = var_post_type.clone()
		}
	}
	if var_query_vars.array_isset(rt.new_string('post_password')) {
		var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_password = %s')), var_query_vars.array_get(rt.new_string('post_password'))]))
		if !rt.is_true(var_query_vars.array_get(rt.new_string('perm'))) {
			var_query_vars.array_set('perm', 'readable')
		}
	} else if var_query_vars.array_isset(rt.new_string('has_password')) {
		var_where = rt.concat(var_where, rt.call_function('sprintf', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_password %s \'\'')), rt.new_string((if rt.is_true(var_query_vars.array_get(rt.new_string('has_password'))) { '!=' } else { '=' }).str())]))
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('comment_status')))) {
		var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.comment_status = %s ')), var_query_vars.array_get(rt.new_string('comment_status'))]))
	}
	if !(!rt.is_true(var_query_vars.array_get(rt.new_string('ping_status')))) {
		var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ping_status = %s ')), var_query_vars.array_get(rt.new_string('ping_status'))]))
	}
	mut var_skip_post_status := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_string('any'), var_post_type)) {
		mut var_in_search_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'exclude_from_search', val: false }])])
		if !rt.is_true(var_in_search_post_types) {
		mut var_post_type_where := rt.new_string(' AND 1=0 ')
		var_skip_post_status = rt.new_bool(true)
		} else {
		var_post_type_where = rt.new_string((rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type IN (\'')) + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_function('array_map', [rt.new_string('esc_sql'), var_in_search_post_types.clone()])])).str() + '\')').str())
		}
	} else if !(!rt.is_true(var_post_type)) && var_post_type.clone().is_array() {
		rt.call_function('sort', [var_post_type.clone()])
	var_post_type_where = rt.new_string((rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type IN (\'')) + (rt.call_function('implode', [rt.new_string('\', \''), rt.call_function('esc_sql', [var_post_type.clone()])])).str() + '\')').str())
	} else if !(!rt.is_true(var_post_type)) {
	var_post_type_where = rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type = %s')), var_post_type.clone()])
	var_post_type_object = rt.call_function('get_post_type_object', [var_post_type.clone()])
	} else if this.is_attachment {
	var_post_type_where = rt.new_string((rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type = \'attachment\''))).str())
	var_post_type_object = rt.call_function('get_post_type_object', [rt.new_string('attachment')])
	} else if this.is_page {
	var_post_type_where = rt.new_string((rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type = \'page\''))).str())
	var_post_type_object = rt.call_function('get_post_type_object', [rt.new_string('page')])
	} else {
	var_post_type_where = rt.new_string((rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type = \'post\''))).str())
	var_post_type_object = rt.call_function('get_post_type_object', [rt.new_string('post')])
	}
	mut var_edit_cap := rt.new_string('edit_post')
	mut var_read_cap := rt.new_string('read_post')
	if !(!rt.is_true(var_post_type_object)) {
	mut var_edit_others_cap := rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'edit_others_posts')
	mut var_read_private_cap := rt.get_property(rt.get_property(var_post_type_object, 'cap'), 'read_private_posts')
	} else {
	var_edit_others_cap = rt.new_string('edit_others_' + (var_post_type_cap).str() + 's')
	var_read_private_cap = rt.new_string('read_private_' + (var_post_type_cap).str() + 's')
	}
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut var_q_status := rt.new_array()
	if rt.is_true(var_skip_post_status) {
		var_where = rt.concat(var_where, var_post_type_where)
	} else if !(!rt.is_true(var_query_vars.array_get(rt.new_string('post_status')))) {
		var_where = rt.concat(var_where, var_post_type_where)
		mut var_statuswheres := rt.new_array()
		var_q_status = var_query_vars.array_get(rt.new_string('post_status'))
		if !(var_q_status.clone().is_array()) {
		var_q_status = rt.call_function('explode', [rt.new_string(','), var_q_status.clone()])
		}
		rt.call_function('sort', [var_q_status.clone()])
		mut var_r_status := rt.new_array()
		mut var_p_status := rt.new_array()
		mut var_e_status := rt.new_array()
		if rt.is_true(rt.call_function('in_array', [rt.new_string('any'), var_q_status.clone(), rt.new_bool(true)])) {
			mut iter_19 := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'exclude_from_search', val: true }])]).iterator()
			for {
				item_19 := iter_19.next() or { break }
				mut var_status := item_19.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.clone(), var_q_status.clone(), rt.new_bool(true)]))))) {
					var_e_status << rt.concat(rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_status <> \'')), var_status), rt.new_string('\''))
				}
			}
		} else {
			mut iter_20 := rt.call_function('get_post_stati', []rt.PhpVal{}).iterator()
			for {
				item_20 := iter_20.next() or { break }
				mut var_status := item_20.val
				if rt.is_true(rt.call_function('in_array', [var_status.clone(), var_q_status.clone(), rt.new_bool(true)])) {
					if rt.is_true(rt.identical(rt.new_string('private'), var_status)) {
						var_p_status << rt.concat(rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_status = \'')), var_status), rt.new_string('\''))
					} else {
						var_r_status.array_push(rt.concat(rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_status = \'')), var_status), rt.new_string('\'')))
					}
				}
			}
		}
		if !rt.is_true(var_query_vars.array_get(rt.new_string('perm'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('readable'), var_query_vars.array_get(rt.new_string('perm')))))) {
			var_r_status = rt.call_function('array_merge', [var_r_status.clone(), rt.create_array_from_list(var_p_status)])
			var_p_status = rt.new_null()
		}
		if !(!rt.is_true(var_e_status)) {
			var_statuswheres.array_push('(' + (rt.call_function('implode', [rt.new_string(' AND '), rt.create_array_from_list(var_e_status)])).str() + ')')
		}
		if !(!rt.is_true(var_r_status)) {
			if !(!rt.is_true(var_query_vars.array_get(rt.new_string('perm')))) && rt.is_true(rt.identical(rt.new_string('editable'), var_query_vars.array_get(rt.new_string('perm')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_others_cap.clone()]))))) {
				var_statuswheres.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author = ')), var_user_id), rt.new_string(' ')) + 'AND (' + (rt.call_function('implode', [rt.new_string(' OR '), var_r_status.clone()])).str() + '))')
			} else {
				var_statuswheres.array_push('(' + (rt.call_function('implode', [rt.new_string(' OR '), var_r_status.clone()])).str() + ')')
			}
		}
		if !(!rt.is_true(var_p_status)) {
			if !(!rt.is_true(var_query_vars.array_get(rt.new_string('perm')))) && rt.is_true(rt.identical(rt.new_string('readable'), var_query_vars.array_get(rt.new_string('perm')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_read_private_cap.clone()]))))) {
				var_statuswheres.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author = ')), var_user_id), rt.new_string(' ')) + 'AND (' + (rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_p_status)])).str() + '))')
			} else {
				var_statuswheres.array_push('(' + (rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_p_status)])).str() + ')')
			}
		}
		if rt.is_true(var_post_status_join) {
			var_join = rt.concat(var_join, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' LEFT JOIN '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS p2 ON (')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent = p2.ID) ')))
			mut iter_21 := var_statuswheres.iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_statuswhere := item_21.val
				mut var_index := item_21.key
				var_statuswheres.array_set(var_index, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('('), var_statuswhere), rt.new_string(' OR (')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'inherit\' AND ')) + (rt.call_function('str_replace', [rt.get_property(var_wpdb, 'posts'), rt.new_string('p2'), var_statuswhere.clone()])).str() + '))')
			}
		}
		mut var_where_status := rt.call_function('implode', [rt.new_string(' OR '), var_statuswheres.clone()])
		if !(!rt.is_true(var_where_status)) {
			var_where = rt.concat(var_where, rt.new_string(" AND (${var_where_status.to_string()})"))
		}
	} else if !(this.is_singular) {
		if rt.is_true(rt.identical(rt.new_string('any'), var_post_type)) {
		mut var_queried_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'exclude_from_search', val: false }])])
		} else if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
		var_queried_post_types = var_post_type.clone()
		} else if !(!rt.is_true(var_post_type)) {
		var_queried_post_types = rt.create_array([rt.ArrayItem{ key: none, val: var_post_type }])
		} else {
		var_queried_post_types = rt.create_array([rt.ArrayItem{ key: none, val: 'post' }])
		}
		if !(!rt.is_true(var_queried_post_types)) {
			rt.call_function('sort', [var_queried_post_types.clone()])
			mut var_status_type_clauses := rt.new_array()
			mut iter_22 := var_queried_post_types.iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_queried_post_type := item_22.val
				mut var_queried_post_type_object := rt.call_function('get_post_type_object', [var_queried_post_type.clone()])
				mut var_type_where := rt.new_string('(' + (rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_type = %s AND (')), var_queried_post_type.clone()])).str())
				mut var_public_statuses := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'public', val: true }])])
				mut var_status_clauses := rt.new_array()
				mut iter_23 := var_public_statuses.iterator()
				for {
					item_23 := iter_23.next() or { break }
					mut var_public_status := item_23.val
					var_status_clauses << rt.concat(rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_status = \'')), var_public_status), rt.new_string('\''))
				}
				var_type_where = rt.concat(var_type_where, rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_status_clauses)]))
				if this.is_admin {
					mut var_admin_all_statuses := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'protected', val: true }, rt.ArrayItem{ key: 'show_in_admin_all_list', val: true }])])
					mut iter_24 := var_admin_all_statuses.iterator()
					for {
						item_24 := iter_24.next() or { break }
						mut var_admin_all_status := item_24.val
						var_type_where = rt.concat(var_type_where, rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' OR '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'')), var_admin_all_status), rt.new_string('\'')))
					}
				}
				if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) && rt.is_true(rt.new_bool(rt.instance_of(var_queried_post_type_object, 'WP_Post_Type'))) {
					var_read_private_cap = rt.get_property(rt.get_property(var_queried_post_type_object, 'cap'), 'read_private_posts')
					mut var_private_statuses := rt.call_function('get_post_stati', [rt.create_array([rt.ArrayItem{ key: 'private', val: true }])])
					mut iter_25 := var_private_statuses.iterator()
					for {
						item_25 := iter_25.next() or { break }
						mut var_private_status := item_25.val
						var_type_where = rt.concat(var_type_where, if rt.is_true(rt.call_function('current_user_can', [var_read_private_cap.clone()])) { rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' \nOR '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'')), var_private_status), rt.new_string('\'')) } else { rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' \nOR ('), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author = ')), var_user_id), rt.new_string(' AND ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = \'')), var_private_status), rt.new_string('\')')) })
					}
				}
				var_type_where = rt.concat(var_type_where, rt.new_string('))'))
				var_status_type_clauses << var_type_where.clone()
			}
			if !(!rt.is_true(var_status_type_clauses)) {
				var_where = rt.concat(var_where, rt.new_string(' AND (' + (rt.call_function('implode', [rt.new_string(' OR '), rt.create_array_from_list(var_status_type_clauses)])).str() + ')'))
			}
		} else {
			var_where = rt.concat(var_where, rt.new_string(' AND 1=0 '))
		}
	} else {
		var_where = rt.concat(var_where, var_post_type_where)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
	var_where = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_where'), rt.create_array([rt.ArrayItem{ key: none, val: var_where }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_join = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_join'), rt.create_array([rt.ArrayItem{ key: none, val: var_join }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	}
	if !rt.is_true(var_query_vars.array_get(rt.new_string('nopaging'))) && !(this.is_singular) {
		var_page = rt.call_function('absint', [var_query_vars.array_get(rt.new_string('paged'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
		var_page = rt.new_int(1)
		}
		if var_query_vars.array_isset(rt.new_string('offset')) && var_query_vars.array_get(rt.new_string('offset')).is_long() || var_query_vars.array_get(rt.new_string('offset')).is_double() {
			var_query_vars.array_set('offset', rt.call_function('absint', [var_query_vars.array_get(rt.new_string('offset'))]))
		mut var_pgstrt := rt.new_string((var_query_vars.array_get(rt.new_string('offset'))).str() + ', ')
		} else {
		var_pgstrt = rt.new_string((rt.call_function('absint', [rt.mul(rt.sub(var_page, rt.new_int(1)), var_query_vars.array_get(rt.new_string('posts_per_page')))])).str() + ', ')
		}
	var_limits = rt.new_string('LIMIT ' + (var_pgstrt).str() + (var_query_vars.array_get(rt.new_string('posts_per_page'))).str())
	}
	if this.is_comment_feed && !(this.is_singular) {
		if this.is_archive || this.is_search {
		mut var_cjoin := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ON ( ')), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_post_ID = ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID ) ')), var_join), rt.new_string(' '))).str())
		mut var_cwhere := rt.new_string("WHERE comment_approved = '1' ${var_where.to_string()}")
		mut var_cgroupby := rt.new_string((rt.concat(rt.get_property(var_wpdb, 'comments'), rt.new_string('.comment_id'))).str())
		} else {
		var_cjoin = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('JOIN '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ON ( ')), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_post_ID = ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID )'))).str())
		var_cwhere = rt.new_string('WHERE ( post_status = \'publish\' OR ( post_status = \'inherit\' AND post_type = \'attachment\' ) ) AND comment_approved = \'1\'')
		var_cgroupby = rt.new_string('')
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
		var_cjoin = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_join'), rt.create_array([rt.ArrayItem{ key: none, val: var_cjoin }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		var_cwhere = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: var_cwhere }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		var_cgroupby = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_groupby'), rt.create_array([rt.ArrayItem{ key: none, val: var_cgroupby }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		mut var_corderby := rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'comment_date_gmt DESC' }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		mut var_climits := rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_limits'), rt.create_array([rt.ArrayItem{ key: none, val: 'LIMIT ' + (rt.call_function('get_option', [rt.new_string('posts_per_rss')])).str() }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		}
		var_cgroupby = rt.new_string((if !(!rt.is_true(var_cgroupby)) { 'GROUP BY ' + (var_cgroupby).str() } else { '' }).str())
		var_corderby = rt.new_string((if !(!rt.is_true(var_corderby)) { 'ORDER BY ' + (var_corderby).str() } else { '' }).str())
		var_climits = if !(!rt.is_true(var_climits)) { var_climits } else { rt.new_string('') }
		mut var_comments_request := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_distinct), rt.new_string(' ')), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_ID FROM ')), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ')), var_cjoin), rt.new_string(' ')), var_cwhere), rt.new_string(' ')), var_cgroupby), rt.new_string(' ')), var_corderby), rt.new_string(' ')), var_climits)).str())
		mut var_key := rt.new_string(md5.hexhash(var_comments_request.clone().to_string()))
		mut var_last_changed := rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_cache_get_last_changed', [rt.new_string('comment')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wp_cache_get_last_changed', [rt.new_string('posts')]) }])
		mut var_cache_key := rt.new_string("comment_feed:${var_key.to_string()}")
		mut var_comment_ids := rt.call_function('wp_cache_get_salted', [var_cache_key.clone(), rt.new_string('comment-queries'), var_last_changed.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_comment_ids)) {
			var_comment_ids = rt.call_method(var_wpdb, 'get_col', [var_comments_request.clone()])
			rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), var_comment_ids.clone(), rt.new_string('comment-queries'), var_last_changed.clone()])
		}
		rt.call_function('_prime_comment_caches', [var_comment_ids.clone()])
		this.comments = rt.call_function('array_map', [rt.new_string('get_comment'), var_comment_ids.clone()])
		this.comment_count = this.comments.array_count()
		mut var_post_ids := rt.new_array()
		mut iter_26 := this.comments.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_comment := item_26.val
			var_post_ids.array_push(rt.new_int((rt.get_property(var_comment, 'comment_post_ID')).to_i64()))
		}
		var_post_ids = rt.call_function('implode', [rt.new_string(','), var_post_ids.clone()])
		var_join = rt.new_string('')
		if rt.is_true(var_post_ids) {
		var_where = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID IN (')), var_post_ids), rt.new_string(') '))).str())
		} else {
		var_where = rt.new_string('AND 0')
		}
	}
	mut var_pieces := ['where', 'groupby', 'join', 'orderby', 'distinct', 'fields', 'limits']
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
	var_where = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_where_paged'), rt.create_array([rt.ArrayItem{ key: none, val: var_where }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_groupby = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_groupby'), rt.create_array([rt.ArrayItem{ key: none, val: var_groupby }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_join = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_join_paged'), rt.create_array([rt.ArrayItem{ key: none, val: var_join }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_orderby = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_orderby'), rt.create_array([rt.ArrayItem{ key: none, val: var_orderby }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_distinct = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_distinct'), rt.create_array([rt.ArrayItem{ key: none, val: var_distinct }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_limits = rt.call_function('apply_filters_ref_array', [rt.new_string('post_limits'), rt.create_array([rt.ArrayItem{ key: none, val: var_limits }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_fields = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_fields'), rt.create_array([rt.ArrayItem{ key: none, val: var_fields }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_clauses = rt.cast_array(rt.call_function('apply_filters_ref_array', [rt.new_string('posts_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('compact', [rt.create_array_from_list(var_pieces)]) }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])]))
	var_where = if !(var_clauses.array_get(rt.new_string('where'))).is_null() { var_clauses.array_get(rt.new_string('where')) } else { rt.new_string('') }
	var_groupby = if !(var_clauses.array_get(rt.new_string('groupby'))).is_null() { var_clauses.array_get(rt.new_string('groupby')) } else { rt.new_string('') }
	var_join = if !(var_clauses.array_get(rt.new_string('join'))).is_null() { var_clauses.array_get(rt.new_string('join')) } else { rt.new_string('') }
	var_orderby = if !(var_clauses.array_get(rt.new_string('orderby'))).is_null() { var_clauses.array_get(rt.new_string('orderby')) } else { rt.new_string('') }
	var_distinct = if !(var_clauses.array_get(rt.new_string('distinct'))).is_null() { var_clauses.array_get(rt.new_string('distinct')) } else { rt.new_string('') }
	var_fields = if !(var_clauses.array_get(rt.new_string('fields'))).is_null() { var_clauses.array_get(rt.new_string('fields')) } else { rt.new_string('') }
	var_limits = if !(var_clauses.array_get(rt.new_string('limits'))).is_null() { var_clauses.array_get(rt.new_string('limits')) } else { rt.new_string('') }
	}
	rt.call_function('do_action', [rt.new_string('posts_selection'), rt.new_string((var_where).str() + (var_groupby).str() + (var_orderby).str() + (var_limits).str() + (var_join).str())])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
	var_where = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_where_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_where }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_groupby = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_groupby_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_groupby }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_join = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_join_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_join }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_orderby = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_orderby_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_orderby }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_distinct = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_distinct_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_distinct }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_fields = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_fields_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_fields }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_limits = rt.call_function('apply_filters_ref_array', [rt.new_string('post_limits_request'), rt.create_array([rt.ArrayItem{ key: none, val: var_limits }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	var_clauses = rt.cast_array(rt.call_function('apply_filters_ref_array', [rt.new_string('posts_clauses_request'), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('compact', [rt.create_array_from_list(var_pieces)]) }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])]))
	var_where = if !(var_clauses.array_get(rt.new_string('where'))).is_null() { var_clauses.array_get(rt.new_string('where')) } else { rt.new_string('') }
	var_groupby = if !(var_clauses.array_get(rt.new_string('groupby'))).is_null() { var_clauses.array_get(rt.new_string('groupby')) } else { rt.new_string('') }
	var_join = if !(var_clauses.array_get(rt.new_string('join'))).is_null() { var_clauses.array_get(rt.new_string('join')) } else { rt.new_string('') }
	var_orderby = if !(var_clauses.array_get(rt.new_string('orderby'))).is_null() { var_clauses.array_get(rt.new_string('orderby')) } else { rt.new_string('') }
	var_distinct = if !(var_clauses.array_get(rt.new_string('distinct'))).is_null() { var_clauses.array_get(rt.new_string('distinct')) } else { rt.new_string('') }
	var_fields = if !(var_clauses.array_get(rt.new_string('fields'))).is_null() { var_clauses.array_get(rt.new_string('fields')) } else { rt.new_string('') }
	var_limits = if !(var_clauses.array_get(rt.new_string('limits'))).is_null() { var_clauses.array_get(rt.new_string('limits')) } else { rt.new_string('') }
	}
	if !(!rt.is_true(var_groupby)) {
	var_groupby = rt.new_string('GROUP BY ' + (var_groupby).str())
	}
	if !(!rt.is_true(var_orderby)) {
	var_orderby = rt.new_string('ORDER BY ' + (var_orderby).str())
	}
	mut var_found_rows := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('no_found_rows')))))) && !(!rt.is_true(var_limits)) {
	var_found_rows = rt.new_string('SQL_CALC_FOUND_ROWS')
	}
	mut var_old_request := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_found_rows), rt.new_string(' ')), var_distinct), rt.new_string(' ')), var_fields), rt.new_string('\n\t\t\t\t\t FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_join), rt.new_string('\n\t\t\t\t\t WHERE 1=1 ')), var_where), rt.new_string('\n\t\t\t\t\t ')), var_groupby), rt.new_string('\n\t\t\t\t\t ')), var_orderby), rt.new_string('\n\t\t\t\t\t ')), var_limits)).str())
	this.request = var_old_request.clone()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
		this.request = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_request'), rt.create_array([rt.ArrayItem{ key: none, val: this.request }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	}
	this.posts = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_pre_query'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	mut var_id_query_is_cacheable := rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(var_orderby.clone().to_string().to_upper()), rt.new_string(' RAND(')]))))
	mut var_cacheable_field_values := [rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.*')), rt.concat(rt.concat(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID, ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent')), rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.ID'))]
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_fields.clone(), rt.create_array_from_list(var_cacheable_field_values), rt.new_bool(true)]))))) {
	var_id_query_is_cacheable = rt.new_bool(false)
	}
	var_last_changed = rt.cast_array(rt.call_function('wp_cache_get_last_changed', [rt.new_string('posts')]))
	if !(!rt.is_true(rt.get_property(this.tax_query, 'queries'))) {
		var_last_changed.array_push(rt.call_function('wp_cache_get_last_changed', [rt.new_string('terms')]))
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('cache_results'))) && rt.is_true(var_id_query_is_cacheable) {
		mut var_new_request := rt.call_function('str_replace', [var_fields.clone(), rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.*')), this.request])
		var_cache_key = rt.new_string(this.generate_cache_key(mut rt.cast_object_ptr[Class_array](var_query_vars), var_new_request.clone()))
		mut var_cache_found := rt.new_bool(false)
		if rt.is_true(rt.identical(rt.new_null(), this.posts)) {
			mut var_cached_results := rt.call_function('wp_cache_get_salted', [var_cache_key.clone(), rt.new_string('post-queries'), var_last_changed.clone()])
			if rt.is_true(var_cached_results) {
				var_cache_found = rt.new_bool(true)
				var_post_ids = rt.call_function('array_map', [rt.new_string('intval'), var_cached_results.array_get(rt.new_string('posts'))])
				this.post_count = var_post_ids.clone().array_count()
				this.found_posts = var_cached_results.array_get(rt.new_string('found_posts'))
				this.max_num_pages = var_cached_results.array_get(rt.new_string('max_num_pages'))
				if rt.is_true(rt.identical(rt.new_string('ids'), var_query_vars.array_get(rt.new_string('fields')))) {
					this.posts = var_post_ids.clone()
					return this.posts
				} else if rt.is_true(rt.identical(rt.new_string('id=>parent'), var_query_vars.array_get(rt.new_string('fields')))) {
					rt.call_function('_prime_post_parent_id_caches', [var_post_ids.clone()])
					mut var_post_parent_cache_keys := rt.new_array()
					mut iter_27 := var_post_ids.iterator()
					for {
						item_27 := iter_27.next() or { break }
						mut var_post_id := item_27.val
						var_post_parent_cache_keys << 'post_parent:' + (var_post_id).str()
					}
					mut var_post_parents := rt.call_function('wp_cache_get_multiple', [rt.create_array_from_list(var_post_parent_cache_keys), rt.new_string('posts')])
					mut iter_28 := var_post_parents.iterator()
					for {
						item_28 := iter_28.next() or { break }
						mut var_post_parent := item_28.val
						mut var_cache_key_shadow := item_28.key
						mut var_obj := create_stdclass()
						rt.set_property(var_obj, 'ID', rt.new_int((rt.call_function('str_replace', [rt.new_string('post_parent:'), rt.new_string(''), var_cache_key_shadow.clone()])).to_i64()))
						rt.set_property(var_obj, 'post_parent', rt.new_int((var_post_parent).to_i64()))
						this.posts.array_push(var_obj)
					}
					return var_post_parents.clone()
				} else {
					rt.call_function('_prime_post_caches', [var_post_ids.clone(), var_query_vars.array_get(rt.new_string('update_post_term_cache')), var_query_vars.array_get(rt.new_string('update_post_meta_cache'))])
					this.posts = rt.call_function('array_map', [rt.new_string('get_post'), var_post_ids.clone()])
				}
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('ids'), var_query_vars.array_get(rt.new_string('fields')))) {
		if rt.is_true(rt.identical(rt.new_null(), this.posts)) {
			this.posts = rt.call_method(var_wpdb, 'get_col', [this.request])
		}
		this.posts = rt.call_function('array_map', [rt.new_string('intval'), this.posts])
		this.post_count = this.posts.array_count()
		this.set_found_posts(var_query_vars.clone(), var_limits.clone())
		if rt.is_true(var_query_vars.array_get(rt.new_string('cache_results'))) && rt.is_true(var_id_query_is_cacheable) {
			mut var_cache_value := { 'posts': this.posts, 'found_posts': this.found_posts, 'max_num_pages': this.max_num_pages }
			rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), rt.create_array_from_native_map(var_cache_value), rt.new_string('post-queries'), var_last_changed.clone()])
		}
		return this.posts
	}
	if rt.is_true(rt.identical(rt.new_string('id=>parent'), var_query_vars.array_get(rt.new_string('fields')))) {
		if rt.is_true(rt.identical(rt.new_null(), this.posts)) {
			this.posts = rt.call_method(var_wpdb, 'get_results', [this.request])
		}
		this.post_count = this.posts.array_count()
		this.set_found_posts(var_query_vars.clone(), var_limits.clone())
		var_post_parents = rt.new_array()
		var_post_ids = rt.new_array()
		mut var_post_parents_cache := rt.new_array()
		mut iter_29 := this.posts.iterator()
		for {
			item_29 := iter_29.next() or { break }
			mut var_post := item_29.val
			mut var_key_shadow := item_29.key
			rt.set_property(this.posts.array_get(var_key_shadow), 'ID', rt.new_int((rt.get_property(var_post, 'ID')).to_i64()))
			rt.set_property(this.posts.array_get(var_key_shadow), 'post_parent', rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64()))
			var_post_parents.array_set(rt.new_int((rt.get_property(var_post, 'ID')).to_i64()), rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64()))
			var_post_ids.array_push(rt.new_int((rt.get_property(var_post, 'ID')).to_i64()))
			var_post_parents_cache['post_parent:' + (rt.get_property(var_post, 'ID')).str()] = rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64())
		}
		rt.call_function('wp_cache_add_multiple', [rt.create_array_from_native_map(var_post_parents_cache), rt.new_string('posts')])
		if rt.is_true(var_query_vars.array_get(rt.new_string('cache_results'))) && rt.is_true(var_id_query_is_cacheable) {
			var_cache_value = { 'posts': var_post_ids, 'found_posts': this.found_posts, 'max_num_pages': this.max_num_pages }
			rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), rt.create_array_from_native_map(var_cache_value), rt.new_string('post-queries'), var_last_changed.clone()])
		}
		return var_post_parents.clone()
	}
	mut var_is_unfiltered_query := rt.new_bool(rt.is_true(rt.identical(var_old_request, this.request)) && rt.is_true(rt.identical(rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.*')), var_fields)))
	if rt.is_true(rt.identical(rt.new_null(), this.posts)) {
		mut var_split_the_query := rt.new_bool(rt.is_true(var_is_unfiltered_query) && rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})) || (!(!rt.is_true(var_limits)) && rt.is_true(rt.less(var_query_vars.array_get(rt.new_string('posts_per_page')), rt.new_int(500)))))
		var_split_the_query = rt.call_function('apply_filters', [rt.new_string('split_the_query'), var_split_the_query.clone(), rt.new_object('WP_Query', []string{}, &this), var_old_request.clone(), rt.call_function('compact', [rt.create_array_from_list(var_pieces)])])
		if rt.is_true(var_split_the_query) {
			this.request = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), var_found_rows), rt.new_string(' ')), var_distinct), rt.new_string(' ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID\n\t\t\t\t\t FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_join), rt.new_string('\n\t\t\t\t\t WHERE 1=1 ')), var_where), rt.new_string('\n\t\t\t\t\t ')), var_groupby), rt.new_string('\n\t\t\t\t\t ')), var_orderby), rt.new_string('\n\t\t\t\t\t ')), var_limits)
			this.request = rt.call_function('apply_filters', [rt.new_string('posts_request_ids'), this.request, rt.new_object('WP_Query', []string{}, &this)])
			var_post_ids = rt.call_method(var_wpdb, 'get_col', [this.request])
			if rt.is_true(var_post_ids) {
				this.posts = var_post_ids.clone()
				this.set_found_posts(var_query_vars.clone(), var_limits.clone())
				rt.call_function('_prime_post_caches', [var_post_ids.clone(), var_query_vars.array_get(rt.new_string('update_post_term_cache')), var_query_vars.array_get(rt.new_string('update_post_meta_cache'))])
			} else {
				this.posts = rt.new_array()
			}
		} else {
			this.posts = rt.call_method(var_wpdb, 'get_results', [this.request])
			this.set_found_posts(var_query_vars.clone(), var_limits.clone())
		}
	}
	if rt.is_true(this.posts) {
		this.posts = rt.call_function('array_map', [rt.new_string('get_post'), this.posts])
	}
	mut var_unfiltered_posts := this.posts
	if rt.is_true(var_query_vars.array_get(rt.new_string('cache_results'))) && rt.is_true(var_id_query_is_cacheable) && rt.is_true(rt.new_bool(!(rt.is_true(var_cache_found)))) {
		var_post_ids = rt.call_function('wp_list_pluck', [this.posts, rt.new_string('ID')])
		var_cache_value = { 'posts': var_post_ids, 'found_posts': this.found_posts, 'max_num_pages': this.max_num_pages }
		rt.call_function('wp_cache_set_salted', [var_cache_key.clone(), rt.create_array_from_native_map(var_cache_value), rt.new_string('post-queries'), var_last_changed.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
		this.posts = rt.call_function('apply_filters_ref_array', [rt.new_string('posts_results'), rt.create_array([rt.ArrayItem{ key: none, val: this.posts }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	}
	if !(!rt.is_true(this.posts)) && this.is_comment_feed && this.is_singular {
		var_cjoin = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_join'), rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		var_cwhere = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: rt.concat(rt.concat(rt.new_string('WHERE comment_post_ID = \''), rt.get_property(this.posts.array_get(rt.new_int(0)), 'ID')), rt.new_string('\' AND comment_approved = \'1\'')) }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		var_cgroupby = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_groupby'), rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		var_cgroupby = rt.new_string((if !(!rt.is_true(var_cgroupby)) { 'GROUP BY ' + (var_cgroupby).str() } else { '' }).str())
		var_corderby = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'comment_date_gmt DESC' }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		var_corderby = rt.new_string((if !(!rt.is_true(var_corderby)) { 'ORDER BY ' + (var_corderby).str() } else { '' }).str())
		var_climits = rt.call_function('apply_filters_ref_array', [rt.new_string('comment_feed_limits'), rt.create_array([rt.ArrayItem{ key: none, val: 'LIMIT ' + (rt.call_function('get_option', [rt.new_string('posts_per_rss')])).str() }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		var_comments_request = rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT '), rt.get_property(var_wpdb, 'comments')), rt.new_string('.comment_ID FROM ')), rt.get_property(var_wpdb, 'comments')), rt.new_string(' ')), var_cjoin), rt.new_string(' ')), var_cwhere), rt.new_string(' ')), var_cgroupby), rt.new_string(' ')), var_corderby), rt.new_string(' ')), var_climits)).str())
		mut var_comment_key := rt.new_string(md5.hexhash(var_comments_request.clone().to_string()))
		mut var_comment_last_changed := rt.call_function('wp_cache_get_last_changed', [rt.new_string('comment')])
		mut var_comment_cache_key := rt.new_string("comment_feed:${var_comment_key.to_string()}")
		var_comment_ids = rt.call_function('wp_cache_get_salted', [var_comment_cache_key.clone(), rt.new_string('comment-queries'), var_comment_last_changed.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_comment_ids)) {
			var_comment_ids = rt.call_method(var_wpdb, 'get_col', [var_comments_request.clone()])
			rt.call_function('wp_cache_set_salted', [var_comment_cache_key.clone(), var_comment_ids.clone(), rt.new_string('comment-queries'), var_comment_last_changed.clone()])
		}
		rt.call_function('_prime_comment_caches', [var_comment_ids.clone()])
		this.comments = rt.call_function('array_map', [rt.new_string('get_comment'), var_comment_ids.clone()])
		this.comment_count = this.comments.array_count()
	}
	if !(!rt.is_true(this.posts)) && this.is_single || this.is_page {
		mut var_status := rt.call_function('get_post_status', [this.posts.array_get(rt.new_int(0))])
		if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(this.posts.array_get(rt.new_int(0)), 'post_type'))) && 0 == rt.new_int((rt.get_property(this.posts.array_get(rt.new_int(0)), 'post_parent')).to_i64()) {
			this.is_page = false
			this.is_single = true
			this.is_attachment = true
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status.clone(), var_q_status.clone(), rt.new_bool(true)]))))) {
			mut var_post_status_obj := rt.call_function('get_post_status_object', [var_status.clone()])
			if rt.is_true(var_post_status_obj) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'public'))))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
					this.posts = rt.new_array()
				} else {
					if rt.is_true(rt.get_property(var_post_status_obj, 'protected')) {
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_cap.clone(), rt.get_property(this.posts.array_get(rt.new_int(0)), 'ID')]))))) {
							this.posts = rt.new_array()
						} else {
							this.is_preview = true
							if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('future'), var_status)))) {
								rt.set_property(this.posts.array_get(rt.new_int(0)), 'post_date', rt.call_function('current_time', [rt.new_string('mysql')]))
							}
						}
					} else if rt.is_true(rt.get_property(var_post_status_obj, 'private')) {
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_read_cap.clone(), rt.get_property(this.posts.array_get(rt.new_int(0)), 'ID')]))))) {
							this.posts = rt.new_array()
						}
					} else {
						this.posts = rt.new_array()
					}
				}
			} else if rt.is_true(rt.new_bool(!(rt.is_true(var_post_status_obj)))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_cap.clone(), rt.get_property(this.posts.array_get(rt.new_int(0)), 'ID')]))))) {
					this.posts = rt.new_array()
				}
			}
		}
		if this.is_preview && rt.is_true(this.posts) && rt.is_true(rt.call_function('current_user_can', [var_edit_cap.clone(), rt.get_property(this.posts.array_get(rt.new_int(0)), 'ID')])) {
			this.posts.array_set(0, rt.call_function('get_post', [rt.call_function('apply_filters_ref_array', [rt.new_string('the_preview'), rt.create_array([rt.ArrayItem{ key: none, val: this.posts.array_get(rt.new_int(0)) }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])]))
		}
	}
	mut var_sticky_posts := rt.call_function('get_option', [rt.new_string('sticky_posts')])
	if this.is_home && rt.is_true(rt.less_equal(var_page, rt.new_int(1))) && var_sticky_posts.clone().is_array() && !(!rt.is_true(var_sticky_posts)) && rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('ignore_sticky_posts')))))) {
		mut var_num_posts := rt.new_int(this.posts.array_count())
		mut var_sticky_offset := rt.new_int(0)
		mut var_i := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_i, var_num_posts))) { break }
			if rt.is_true(rt.call_function('in_array', [rt.get_property(this.posts.array_get(var_i), 'ID'), var_sticky_posts.clone(), rt.new_bool(true)])) {
				mut var_sticky_post := this.posts.array_get(var_i)
				rt.call_function('array_splice', [this.posts, var_i.clone(), rt.new_int(1)])
				rt.call_function('array_splice', [this.posts, var_sticky_offset.clone(), rt.new_int(0), rt.create_array([rt.ArrayItem{ key: none, val: var_sticky_post }])])
				rt.pre_inc(var_sticky_offset)
				mut var_offset := rt.call_function('array_search', [rt.get_property(var_sticky_post, 'ID'), var_sticky_posts.clone(), rt.new_bool(true)])
				var_sticky_posts.array_unset(var_offset)
			}
			rt.post_inc(var_i)
		}
		if !(!rt.is_true(var_sticky_posts)) && !(!rt.is_true(var_query_vars.array_get(rt.new_string('post__not_in')))) {
		var_sticky_posts = rt.call_function('array_diff', [var_sticky_posts.clone(), var_query_vars.array_get(rt.new_string('post__not_in'))])
		}
		if !(!rt.is_true(var_sticky_posts)) {
			mut var_stickies := rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post__in', val: var_sticky_posts }, rt.ArrayItem{ key: 'post_type', val: var_post_type }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'posts_per_page', val: var_sticky_posts.clone().array_count() }, rt.ArrayItem{ key: 'suppress_filters', val: var_query_vars.array_get(rt.new_string('suppress_filters')) }, rt.ArrayItem{ key: 'cache_results', val: var_query_vars.array_get(rt.new_string('cache_results')) }, rt.ArrayItem{ key: 'update_post_meta_cache', val: var_query_vars.array_get(rt.new_string('update_post_meta_cache')) }, rt.ArrayItem{ key: 'update_post_term_cache', val: var_query_vars.array_get(rt.new_string('update_post_term_cache')) }, rt.ArrayItem{ key: 'lazy_load_term_meta', val: var_query_vars.array_get(rt.new_string('lazy_load_term_meta')) }])])
			mut iter_30 := var_stickies.iterator()
			for {
				item_30 := iter_30.next() or { break }
				mut var_sticky_post_shadow := item_30.val
				rt.call_function('array_splice', [this.posts, var_sticky_offset.clone(), rt.new_int(0), rt.create_array([rt.ArrayItem{ key: none, val: var_sticky_post_shadow }])])
				rt.pre_inc(var_sticky_offset)
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query_vars.array_get(rt.new_string('suppress_filters')))))) {
		this.posts = rt.call_function('apply_filters_ref_array', [rt.new_string('the_posts'), rt.create_array([rt.ArrayItem{ key: none, val: this.posts }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	}
	if rt.is_true(this.posts) {
		this.post_count = this.posts.array_count()
		this.posts = rt.call_function('array_map', [rt.new_string('get_post'), this.posts])
		if rt.is_true(var_query_vars.array_get(rt.new_string('cache_results'))) {
			if rt.is_true(var_is_unfiltered_query) && rt.is_true(rt.identical(var_unfiltered_posts, this.posts)) {
				rt.call_function('update_post_caches', [this.posts, var_post_type.clone(), var_query_vars.array_get(rt.new_string('update_post_term_cache')), var_query_vars.array_get(rt.new_string('update_post_meta_cache'))])
			} else {
				var_post_ids = rt.call_function('wp_list_pluck', [this.posts, rt.new_string('ID')])
				rt.call_function('_prime_post_caches', [var_post_ids.clone(), var_query_vars.array_get(rt.new_string('update_post_term_cache')), var_query_vars.array_get(rt.new_string('update_post_meta_cache'))])
			}
		}
		this.post = rt.call_function('reset', [this.posts])
	} else {
		this.post_count = 0
		this.posts = rt.new_array()
	}
	if !(!rt.is_true(this.posts)) && rt.is_true(var_query_vars.array_get(rt.new_string('update_menu_item_cache'))) {
		rt.call_function('update_menu_item_cache', [this.posts])
	}
	if rt.is_true(var_query_vars.array_get(rt.new_string('lazy_load_term_meta'))) {
		rt.call_function('wp_queue_posts_for_term_meta_lazyload', [this.posts])
	}
	return this.posts
}

fn (mut this Class_WP_Query) set_found_posts(var_query_vars rt.PhpVal, var_limits rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_query_vars_mutated := var_query_vars
	mut var_limits_mutated := var_limits
	if rt.is_true(var_query_vars_mutated.array_get(rt.new_string('no_found_rows'))) || (this.posts.is_array() && rt.is_true(rt.new_bool(!(rt.is_true(this.posts))))) {
		return
	}
	if !(!rt.is_true(var_limits_mutated)) {
		mut var_found_posts_query := rt.call_function('apply_filters_ref_array', [rt.new_string('found_posts_query'), rt.create_array([rt.ArrayItem{ key: none, val: 'SELECT FOUND_ROWS()' }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		this.found_posts = rt.new_int((rt.call_method(var_wpdb, 'get_var', [var_found_posts_query.clone()])).to_i64())
	} else {
		if rt.is_true(rt.new_bool(this.posts.is_array())) {
			this.found_posts = rt.new_int(this.posts.array_count())
		} else {
			if rt.is_true(rt.identical(rt.new_null(), this.posts)) {
				this.found_posts = rt.new_int(0)
			} else {
				this.found_posts = rt.new_int(1)
			}
		}
	}
	this.found_posts = rt.new_int((rt.call_function('apply_filters_ref_array', [rt.new_string('found_posts'), rt.create_array([rt.ArrayItem{ key: none, val: this.found_posts }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])).to_i64())
	if !(!rt.is_true(var_limits_mutated)) {
		this.max_num_pages = rt.new_int((rt.call_function('ceil', [rt.div(this.found_posts, var_query_vars_mutated.array_get(rt.new_string('posts_per_page')))])).to_i64())
	}
}

fn (mut this Class_WP_Query) next_post() rt.PhpVal {
	rt.pre_inc(this.current_post)
	this.post = this.posts.array_get(this.current_post)
	return this.post
}

fn (mut this Class_WP_Query) the_post() {
	mut var_post := rt.get_superglobal('post')
	if !(this.in_the_loop) {
		if rt.is_true(rt.identical(rt.new_string('all'), this.query_vars.array_get(rt.new_string('fields')))) {
		mut var_post_objects := this.posts
		} else {
			if rt.is_true(rt.identical(rt.new_string('ids'), this.query_vars.array_get(rt.new_string('fields')))) {
			mut var_post_ids := this.posts
			} else {
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut var_post := if args.len > 1 { args[1].clone() } else { rt.new_null() }
				if !(rt.get_property(var_post, 'ID')).is_null() {
					var_carry.array_push(rt.get_property(var_post, 'ID'))
				}
				return
				}
			var_post_ids = rt.call_function('array_reduce', [this.posts, rt.new_closure(closure_1_fn), rt.new_array()])
			}
			rt.call_function('_prime_post_caches', [var_post_ids.clone(), this.query_vars.array_get(rt.new_string('update_post_term_cache')), this.query_vars.array_get(rt.new_string('update_post_meta_cache'))])
		var_post_objects = rt.call_function('array_map', [rt.new_string('get_post'), var_post_ids.clone()])
		}
		rt.call_function('update_post_author_caches', [var_post_objects.clone()])
	}
	this.in_the_loop = true
	this.before_loop = false
	if rt.is_true(rt.identical(-1, this.current_post)) {
		rt.call_function('do_action_ref_array', [rt.new_string('loop_start'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	}
	var_post = this.next_post()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), this.query_vars.array_get(rt.new_string('fields')))))) {
		if rt.is_true(rt.identical(rt.new_string('ids'), this.query_vars.array_get(rt.new_string('fields')))) {
		var_post = rt.call_function('get_post', [var_post.clone()])
		} else if !(rt.get_property(var_post, 'ID')).is_null() {
		var_post = rt.call_function('get_post', [rt.get_property(var_post, 'ID')])
		}
	}
	this.setup_postdata(var_post.clone())
}

fn (mut this Class_WP_Query) have_posts() bool {
	if rt.is_true(rt.less(rt.add(this.current_post, rt.new_int(1)), this.post_count)) {
		return true
	} else if rt.is_true(rt.identical(rt.add(this.current_post, rt.new_int(1)), this.post_count)) && this.post_count > 0 {
		rt.call_function('do_action_ref_array', [rt.new_string('loop_end'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
		this.rewind_posts()
	} else if 0 == this.post_count {
		this.before_loop = false
		rt.call_function('do_action', [rt.new_string('loop_no_results'), rt.new_object('WP_Query', []string{}, &this)])
	}
	this.in_the_loop = false
	return false
}

fn (mut this Class_WP_Query) rewind_posts() {
	this.current_post = -1
	if this.post_count > 0 {
		this.post = this.posts.array_get(rt.new_int(0))
	}
}

fn (mut this Class_WP_Query) next_comment() rt.PhpVal {
	rt.pre_inc(this.current_comment)
	this.comment = this.comments.array_get(this.current_comment)
	return this.comment
}

fn (mut this Class_WP_Query) the_comment() {
	mut var_comment := rt.get_superglobal('comment')
	var_comment = this.next_comment()
	if rt.is_true(rt.identical(rt.new_int(0), this.current_comment)) {
		rt.call_function('do_action', [rt.new_string('comment_loop_start')])
	}
}

fn (mut this Class_WP_Query) have_comments() bool {
	if rt.is_true(rt.less(rt.add(this.current_comment, rt.new_int(1)), this.comment_count)) {
		return true
	} else if rt.is_true(rt.identical(rt.add(this.current_comment, rt.new_int(1)), this.comment_count)) {
		this.rewind_comments()
	}
	return false
}

fn (mut this Class_WP_Query) rewind_comments() {
	this.current_comment = -1
	if this.comment_count > 0 {
		this.comment = this.comments.array_get(rt.new_int(0))
	}
}

fn (mut this Class_WP_Query) query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	this.init()
	this.query = rt.call_function('wp_parse_args', [var_query_mutated.clone()])
	this.query_vars = this.query
	return this.get_posts()
}

fn (mut this Class_WP_Query) get_queried_object() rt.PhpVal {
	if !(this.queried_object).is_null() {
		return this.queried_object
	}
	this.queried_object = rt.new_null()
	this.queried_object_id = rt.new_null()
	if this.is_category || this.is_tag || this.is_tax {
		if this.is_category {
			mut var_cat := this.get(rt.new_string('cat'), '')
			mut var_category_name := this.get(rt.new_string('category_name'), '')
			if rt.is_true(var_cat) {
			mut var_term := rt.call_function('get_term', [var_cat.clone(), rt.new_string('category')])
			} else if rt.is_true(var_category_name) {
			var_term = rt.call_function('get_term_by', [rt.new_string('slug'), var_category_name.clone(), rt.new_string('category')])
			}
		} else if this.is_tag {
			mut var_tag_id := this.get(rt.new_string('tag_id'), '')
			mut var_tag := this.get(rt.new_string('tag'), '')
			if rt.is_true(var_tag_id) {
			var_term = rt.call_function('get_term', [var_tag_id.clone(), rt.new_string('post_tag')])
			} else if rt.is_true(var_tag) {
			var_term = rt.call_function('get_term_by', [rt.new_string('slug'), var_tag.clone(), rt.new_string('post_tag')])
			}
		} else {
			if !(!rt.is_true(rt.get_property(this.tax_query, 'queried_terms'))) {
				mut var_queried_taxonomies := rt.func_array_keys(rt.get_property(this.tax_query, 'queried_terms'))
				mut var_matched_taxonomy := rt.call_function('reset', [var_queried_taxonomies.clone()])
				mut var_query := rt.get_property(this.tax_query, 'queried_terms').array_get(var_matched_taxonomy)
				if !(!rt.is_true(var_query.array_get(rt.new_string('terms')))) {
					if rt.is_true(rt.identical(rt.new_string('term_id'), var_query.array_get(rt.new_string('field')))) {
					var_term = rt.call_function('get_term', [rt.call_function('reset', [var_query.array_get(rt.new_string('terms'))]), var_matched_taxonomy.clone()])
					} else {
					var_term = rt.call_function('get_term_by', [var_query.array_get(rt.new_string('field')), rt.call_function('reset', [var_query.array_get(rt.new_string('terms'))]), var_matched_taxonomy.clone()])
					}
				}
			}
		}
		if !(!rt.is_true(var_term)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()]))))) {
			this.queried_object = var_term.clone()
			this.queried_object_id = rt.new_int((rt.get_property(var_term, 'term_id')).to_i64())
			if this.is_category && rt.is_true(rt.identical(rt.new_string('category'), rt.get_property(this.queried_object, 'taxonomy'))) {
				rt.call_function('_make_cat_compat', [this.queried_object])
			}
		}
	} else if this.is_post_type_archive {
		mut var_post_type := this.get(rt.new_string('post_type'), '')
		if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
		var_post_type = rt.call_function('reset', [var_post_type.clone()])
		}
		this.queried_object = rt.call_function('get_post_type_object', [var_post_type.clone()])
	} else if this.is_posts_page {
		mut var_page_for_posts := rt.call_function('get_option', [rt.new_string('page_for_posts')])
		this.queried_object = rt.call_function('get_post', [var_page_for_posts.clone()])
		this.queried_object_id = rt.new_int((rt.get_property(this.queried_object, 'ID')).to_i64())
	} else if this.is_singular && !(!rt.is_true(this.post)) {
		this.queried_object = this.post
		this.queried_object_id = rt.new_int((rt.get_property(this.post, 'ID')).to_i64())
	} else if this.is_author {
		mut var_author := rt.new_int((this.get(rt.new_string('author'), '')).to_i64())
		mut var_author_name := this.get(rt.new_string('author_name'), '')
		if rt.is_true(var_author) {
			this.queried_object_id = var_author.clone()
		} else if rt.is_true(var_author_name) {
			mut var_user := rt.call_function('get_user_by', [rt.new_string('slug'), var_author_name.clone()])
			if rt.is_true(var_user) {
				this.queried_object_id = rt.get_property(var_user, 'ID')
			}
		}
		this.queried_object = rt.call_function('get_userdata', [this.queried_object_id])
	}
	return this.queried_object
}

fn (mut this Class_WP_Query) get_queried_object_id() rt.PhpVal {
	this.get_queried_object()
	return if !(this.queried_object_id).is_null() { this.queried_object_id } else { rt.new_int(0) }
}

fn (mut this Class_WP_Query) construct(query string) {
	mut query_mutated := query
	if !(query_mutated == '') {
		this.query(rt.new_string(query_mutated))
	}
}

fn (mut this Class_WP_Query) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array', [var_name.clone(), this.compat_fields, rt.new_bool(true)])) {
		return rt.get_property(rt.new_object('WP_Query', []string{}, &this), '{"nodeType":"Expr_Variable","line":4095,"name":"name"}')
	}
	return rt.new_null()
}

fn (mut this Class_WP_Query) magic_isset(var_name rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.clone(), this.compat_fields, rt.new_bool(true)])) {
		return (rt.new_bool(!(rt.get_property(rt.new_object('WP_Query', []string{}, &this), '{"nodeType":"Expr_Variable","line":4109,"name":"name"}')).is_null())).to_bool()
	}
	return false
}

fn (mut this Class_WP_Query) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.clone(), this.compat_methods, rt.new_bool(true)])) {
		return (rt.call_method(rt.new_object('WP_Query', []string{}, &this), var_name, [var_arguments.clone()])).to_bool()
	}
	return false
}

fn (mut this Class_WP_Query) is_archive() bool {
	return this.is_archive
}

fn (mut this Class_WP_Query) is_post_type_archive(post_types string) bool {
	if post_types == '' || !(this.is_post_type_archive) {
		return this.is_post_type_archive
	}
	mut var_post_type := this.get(rt.new_string('post_type'), '')
	if rt.is_true(rt.new_bool(var_post_type.clone().is_array())) {
	var_post_type = rt.call_function('reset', [var_post_type.clone()])
	}
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
		return false
	}
	return (rt.call_function('in_array', [rt.get_property(var_post_type_object, 'name'), rt.cast_array(rt.new_string(post_types)), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WP_Query) is_attachment(attachment string) bool {
	mut attachment_mutated := attachment
	if !(this.is_attachment) {
		return false
	}
	if attachment_mutated == '' {
		return true
	}
	attachment_mutated = (rt.call_function('array_map', [rt.new_string('strval'), rt.cast_array(rt.new_string(attachment_mutated))])).str()
	mut var_post_obj := this.get_queried_object()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_obj)))) {
		return false
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string((rt.get_property(var_post_obj, 'ID')).str()), rt.new_string(attachment_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_obj, 'post_title'), rt.new_string(attachment_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_obj, 'post_name'), rt.new_string(attachment_mutated).clone(), rt.new_bool(true)])) {
		return true
	}
	return false
}

fn (mut this Class_WP_Query) is_author(author string) bool {
	mut author_mutated := author
	if !(this.is_author) {
		return false
	}
	if author_mutated == '' {
		return true
	}
	mut var_author_obj := this.get_queried_object()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_author_obj)))) {
		return false
	}
	author_mutated = (rt.call_function('array_map', [rt.new_string('strval'), rt.cast_array(rt.new_string(author_mutated))])).str()
	if rt.is_true(rt.call_function('in_array', [rt.new_string((rt.get_property(var_author_obj, 'ID')).str()), rt.new_string(author_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_author_obj, 'nickname'), rt.new_string(author_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_author_obj, 'user_nicename'), rt.new_string(author_mutated).clone(), rt.new_bool(true)])) {
		return true
	}
	return false
}

fn (mut this Class_WP_Query) is_category(category string) bool {
	mut category_mutated := category
	if !(this.is_category) {
		return false
	}
	if category_mutated == '' {
		return true
	}
	mut var_cat_obj := this.get_queried_object()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cat_obj)))) {
		return false
	}
	category_mutated = (rt.call_function('array_map', [rt.new_string('strval'), rt.cast_array(rt.new_string(category_mutated))])).str()
	if rt.is_true(rt.call_function('in_array', [rt.new_string((rt.get_property(var_cat_obj, 'term_id')).str()), rt.new_string(category_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_cat_obj, 'name'), rt.new_string(category_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_cat_obj, 'slug'), rt.new_string(category_mutated).clone(), rt.new_bool(true)])) {
		return true
	}
	return false
}

fn (mut this Class_WP_Query) is_tag(tag string) bool {
	mut tag_mutated := tag
	if !(this.is_tag) {
		return false
	}
	if tag_mutated == '' {
		return true
	}
	mut var_tag_obj := this.get_queried_object()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tag_obj)))) {
		return false
	}
	tag_mutated = (rt.call_function('array_map', [rt.new_string('strval'), rt.cast_array(rt.new_string(tag_mutated))])).str()
	if rt.is_true(rt.call_function('in_array', [rt.new_string((rt.get_property(var_tag_obj, 'term_id')).str()), rt.new_string(tag_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_tag_obj, 'name'), rt.new_string(tag_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_tag_obj, 'slug'), rt.new_string(tag_mutated).clone(), rt.new_bool(true)])) {
		return true
	}
	return false
}

fn (mut this Class_WP_Query) is_tax(taxonomy string, term string) bool {
	mut var_wp_taxonomies := rt.new_null()
	mut term_mutated := term
	if !(this.is_tax) {
		return false
	}
	if taxonomy == '' {
		return true
	}
	mut var_queried_object := this.get_queried_object()
	mut var_tax_array := rt.call_function('array_intersect', [rt.func_array_keys(var_wp_taxonomies.clone()), rt.cast_array(rt.new_string(taxonomy))])
	mut var_term_array := rt.cast_array(rt.new_string(term_mutated))
	if !(!(rt.get_property(var_queried_object, 'taxonomy')).is_null() && rt.is_true(rt.new_int(var_tax_array.clone().array_count())) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_queried_object, 'taxonomy'), var_tax_array.clone(), rt.new_bool(true)]))) {
		return false
	}
	if term_mutated == '' {
		return true
	}
	return !(rt.get_property(var_queried_object, 'term_id')).is_null() && rt.is_true(rt.new_int(rt.call_function('array_intersect', [rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_queried_object, 'term_id') }, rt.ArrayItem{ key: none, val: rt.get_property(var_queried_object, 'name') }, rt.ArrayItem{ key: none, val: rt.get_property(var_queried_object, 'slug') }]), var_term_array.clone()]).array_count()))
}

fn (mut this Class_WP_Query) is_comments_popup() bool {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('4.5.0')])
	return false
}

fn (mut this Class_WP_Query) is_date() bool {
	return this.is_date
}

fn (mut this Class_WP_Query) is_day() bool {
	return this.is_day
}

fn (mut this Class_WP_Query) is_feed(feeds string) bool {
	if feeds == '' || rt.is_true(rt.new_bool(!(rt.is_true(this.is_feed)))) {
		return (this.is_feed).to_bool()
	}
	mut var_query_var := this.get(rt.new_string('feed'), '')
	if rt.is_true(rt.identical(rt.new_string('feed'), var_query_var)) {
	var_query_var = rt.call_function('get_default_feed', []rt.PhpVal{})
	}
	return (rt.call_function('in_array', [var_query_var.clone(), rt.cast_array(rt.new_string(feeds)), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WP_Query) is_comment_feed() bool {
	return this.is_comment_feed
}

fn (mut this Class_WP_Query) is_front_page() bool {
	if rt.is_true(rt.identical(rt.new_string('posts'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && this.is_home() {
		return true
	} else if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) && rt.is_true(rt.call_function('get_option', [rt.new_string('page_on_front')])) && this.is_page((rt.call_function('get_option', [rt.new_string('page_on_front')])).str()) {
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_WP_Query) is_home() bool {
	return this.is_home
}

fn (mut this Class_WP_Query) is_privacy_policy() bool {
	if rt.is_true(rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')])) && this.is_page((rt.call_function('get_option', [rt.new_string('wp_page_for_privacy_policy')])).str()) {
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_WP_Query) is_month() bool {
	return this.is_month
}

fn (mut this Class_WP_Query) is_page(page string) bool {
	mut page_mutated := page
	if !(this.is_page) {
		return false
	}
	if page_mutated == '' {
		return true
	}
	mut var_page_obj := this.get_queried_object()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page_obj)))) {
		return false
	}
	page_mutated = (rt.call_function('array_map', [rt.new_string('strval'), rt.cast_array(rt.new_string(page_mutated))])).str()
	if rt.is_true(rt.call_function('in_array', [rt.new_string((rt.get_property(var_page_obj, 'ID')).str()), rt.new_string(page_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_page_obj, 'post_title'), rt.new_string(page_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_page_obj, 'post_name'), rt.new_string(page_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else {
		mut iter_31 := rt.new_string(page_mutated).iterator()
		for {
			item_31 := iter_31.next() or { break }
			mut var_pagepath := item_31.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [var_pagepath.clone(), rt.new_string('/')]))))) {
				continue
			}
			mut var_pagepath_obj := rt.call_function('get_page_by_path', [var_pagepath.clone()])
			if rt.is_true(var_pagepath_obj) && rt.is_true(rt.identical(rt.get_property(var_pagepath_obj, 'ID'), rt.get_property(var_page_obj, 'ID'))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_Query) is_paged() bool {
	return this.is_paged
}

fn (mut this Class_WP_Query) is_preview() bool {
	return this.is_preview
}

fn (mut this Class_WP_Query) is_robots() bool {
	return this.is_robots
}

fn (mut this Class_WP_Query) is_favicon() bool {
	return this.is_favicon
}

fn (mut this Class_WP_Query) is_search() bool {
	return this.is_search
}

fn (mut this Class_WP_Query) is_single(post string) bool {
	mut post_mutated := post
	if !(this.is_single) {
		return false
	}
	if post_mutated == '' {
		return true
	}
	mut var_post_obj := this.get_queried_object()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_obj)))) {
		return false
	}
	post_mutated = (rt.call_function('array_map', [rt.new_string('strval'), rt.cast_array(rt.new_string(post_mutated))])).str()
	if rt.is_true(rt.call_function('in_array', [rt.new_string((rt.get_property(var_post_obj, 'ID')).str()), rt.new_string(post_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_obj, 'post_title'), rt.new_string(post_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_obj, 'post_name'), rt.new_string(post_mutated).clone(), rt.new_bool(true)])) {
		return true
	} else {
		mut iter_32 := rt.new_string(post_mutated).iterator()
		for {
			item_32 := iter_32.next() or { break }
			mut var_postpath := item_32.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strpos', [var_postpath.clone(), rt.new_string('/')]))))) {
				continue
			}
			mut var_postpath_obj := rt.call_function('get_page_by_path', [var_postpath.clone(), rt.get_constant('OBJECT'), rt.get_property(var_post_obj, 'post_type')])
			if rt.is_true(var_postpath_obj) && rt.is_true(rt.identical(rt.get_property(var_postpath_obj, 'ID'), rt.get_property(var_post_obj, 'ID'))) {
				return true
			}
		}
	}
	return false
}

fn (mut this Class_WP_Query) is_singular(post_types string) bool {
	if post_types == '' || !(this.is_singular) {
		return this.is_singular
	}
	mut var_post_obj := this.get_queried_object()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_obj)))) {
		return false
	}
	return (rt.call_function('in_array', [rt.get_property(var_post_obj, 'post_type'), rt.cast_array(rt.new_string(post_types)), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WP_Query) is_time() bool {
	return this.is_time
}

fn (mut this Class_WP_Query) is_trackback() bool {
	return this.is_trackback
}

fn (mut this Class_WP_Query) is_year() bool {
	return this.is_year
}

fn (mut this Class_WP_Query) is_404() bool {
	return this.is_404
}

fn (mut this Class_WP_Query) is_embed() bool {
	return this.is_embed
}

fn (mut this Class_WP_Query) is_main_query() rt.PhpVal {
	mut var_wp_the_query := rt.new_null()
	return rt.identical(var_wp_the_query, rt.new_object('WP_Query', []string{}, &this))
}

fn (mut this Class_WP_Query) setup_postdata(var_post rt.PhpVal) bool {
	mut var_post_mutated := var_post
	mut var_id := rt.get_superglobal('id')
	mut var_authordata := rt.get_superglobal('authordata')
	mut var_currentday := rt.get_superglobal('currentday')
	mut var_currentmonth := rt.get_superglobal('currentmonth')
	mut var_page := rt.get_superglobal('page')
	mut var_pages := rt.get_superglobal('pages')
	mut var_multipage := rt.get_superglobal('multipage')
	mut var_more := rt.get_superglobal('more')
	mut var_numpages := rt.get_superglobal('numpages')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'WP_Post')))))) {
	var_post_mutated = rt.call_function('get_post', [var_post_mutated.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_mutated)))) {
		return false
	}
	mut var_elements := this.generate_postdata(var_post_mutated.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_elements)) {
		return false
	}
	var_id = var_elements.array_get(rt.new_string('id'))
	var_authordata = var_elements.array_get(rt.new_string('authordata'))
	var_currentday = var_elements.array_get(rt.new_string('currentday'))
	var_currentmonth = var_elements.array_get(rt.new_string('currentmonth'))
	var_page = var_elements.array_get(rt.new_string('page'))
	var_pages = var_elements.array_get(rt.new_string('pages'))
	var_multipage = var_elements.array_get(rt.new_string('multipage'))
	var_more = var_elements.array_get(rt.new_string('more'))
	var_numpages = var_elements.array_get(rt.new_string('numpages'))
	rt.call_function('do_action_ref_array', [rt.new_string('the_post'), rt.create_array([rt.ArrayItem{ key: none, val: var_post_mutated }, rt.ArrayItem{ key: none, val: rt.new_object('WP_Query', []string{}, &this) }])])
	return true
}

fn (mut this Class_WP_Query) generate_postdata(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'WP_Post')))))) {
	var_post_mutated = rt.call_function('get_post', [var_post_mutated.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_mutated)))) {
		return rt.new_bool(false)
	}
	mut var_id := rt.new_int((rt.get_property(var_post_mutated, 'ID')).to_i64())
	mut var_authordata := rt.call_function('get_userdata', [rt.get_property(var_post_mutated, 'post_author')])
	mut var_currentday := rt.new_bool(false)
	mut var_currentmonth := rt.new_bool(false)
	mut var_post_date := rt.get_property(var_post_mutated, 'post_date')
	if !(!rt.is_true(var_post_date)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), var_post_date)))) {
	var_currentmonth = rt.call_function('substr', [var_post_date.clone(), rt.new_int(5), rt.new_int(2)])
	mut var_day := rt.call_function('substr', [var_post_date.clone(), rt.new_int(8), rt.new_int(2)])
	mut var_year := rt.call_function('substr', [var_post_date.clone(), rt.new_int(2), rt.new_int(2)])
	var_currentday = rt.call_function('sprintf', [rt.new_string('%s.%s.%s'), var_day.clone(), var_currentmonth.clone(), var_year.clone()])
	}
	mut var_numpages := rt.new_int(1)
	mut var_multipage := rt.new_int(0)
	mut var_page := this.get(rt.new_string('page'), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
	var_page = rt.new_int(1)
	}
	if rt.is_true(rt.identical(rt.call_function('get_queried_object_id', []rt.PhpVal{}), rt.get_property(var_post_mutated, 'ID'))) && this.is_page('') || this.is_single('') {
	mut var_more := rt.new_int(1)
	} else if this.is_feed('') {
	var_more = rt.new_int(1)
	} else {
	var_more = rt.new_int(0)
	}
	mut var_content := rt.get_property(var_post_mutated, 'post_content')
	if rt.is_true(rt.call_function('str_contains', [var_content.clone(), rt.new_string('<!--nextpage-->')])) {
		var_content = rt.call_function('str_replace', [rt.new_string('\n<!--nextpage-->\n'), rt.new_string('<!--nextpage-->'), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('\n<!--nextpage-->'), rt.new_string('<!--nextpage-->'), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('<!--nextpage-->\n'), rt.new_string('<!--nextpage-->'), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('<!-- wp:nextpage -->'), rt.new_string(''), var_content.clone()])
		var_content = rt.call_function('str_replace', [rt.new_string('<!-- /wp:nextpage -->'), rt.new_string(''), var_content.clone()])
		if rt.is_true(rt.call_function('str_starts_with', [var_content.clone(), rt.new_string('<!--nextpage-->')])) {
		var_content = rt.call_function('substr', [var_content.clone(), rt.new_int(15)])
		}
	mut var_pages := rt.call_function('explode', [rt.new_string('<!--nextpage-->'), var_content.clone()])
	} else {
	var_pages = rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_post_mutated, 'post_content') }])
	}
	var_pages = rt.call_function('apply_filters', [rt.new_string('content_pagination'), var_pages.clone(), var_post_mutated.clone()])
	var_numpages = rt.new_int(var_pages.clone().array_count())
	if rt.is_true(rt.greater(var_numpages, rt.new_int(1))) {
		if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		var_more = rt.new_int(1)
		}
	var_multipage = rt.new_int(1)
	} else {
	var_multipage = rt.new_int(0)
	}
	mut var_elements := rt.call_function('compact', [rt.new_string('id'), rt.new_string('authordata'), rt.new_string('currentday'), rt.new_string('currentmonth'), rt.new_string('page'), rt.new_string('pages'), rt.new_string('multipage'), rt.new_string('more'), rt.new_string('numpages')])
	return var_elements.clone()
}

fn (mut this Class_WP_Query) generate_cache_key(mut var_args Class_array, var_sql rt.PhpVal) string {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	mut var_sql_mutated := var_sql
	var_args_mutated.array_unset(rt.new_string('cache_results'))
	var_args_mutated.array_unset(rt.new_string('fields'))
	var_args_mutated.array_unset(rt.new_string('lazy_load_term_meta'))
	var_args_mutated.array_unset(rt.new_string('update_post_meta_cache'))
	var_args_mutated.array_unset(rt.new_string('update_post_term_cache'))
	var_args_mutated.array_unset(rt.new_string('update_menu_item_cache'))
	var_args_mutated.array_unset(rt.new_string('suppress_filters'))
	if !rt.is_true(var_args_mutated.array_get(rt.new_string('post_type'))) {
		if this.is_attachment {
			var_args_mutated.array_set('post_type', 'attachment')
		} else if this.is_page {
			var_args_mutated.array_set('post_type', 'page')
		} else {
			var_args_mutated.array_set('post_type', 'post')
		}
	} else if rt.is_true(rt.identical(rt.new_string('any'), var_args_mutated.array_get(rt.new_string('post_type')))) {
		var_args_mutated.array_set('post_type', rt.call_function('array_values', [rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'exclude_from_search', val: false }])])]))
	}
	var_args_mutated.array_set('post_type', rt.cast_array(var_args_mutated.array_get(rt.new_string('post_type'))))
	rt.call_function('sort', [var_args_mutated.array_get(rt.new_string('post_type'))])
	mut var_sortable_arrays_with_int_values := ['post__in', 'post_parent__in']
	for var_key in var_sortable_arrays_with_int_values {
		if var_args_mutated.array_isset(rt.new_string(key)) && var_args_mutated.array_get(rt.new_string(key)).is_array() {
			var_args_mutated.array_set(key, rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_string('absint'), var_args_mutated.array_get(rt.new_string(key))])]))
			rt.call_function('sort', [var_args_mutated.array_get(rt.new_string(key))])
		}
	}
	if var_args_mutated.array_isset(rt.new_string('post_name__in')) && var_args_mutated.array_get(rt.new_string('post_name__in')).is_array() {
		var_args_mutated.array_set('post_name__in', rt.call_function('array_unique', [var_args_mutated.array_get(rt.new_string('post_name__in'))]))
		rt.call_function('sort', [var_args_mutated.array_get(rt.new_string('post_name__in'))])
	}
	if var_args_mutated.array_isset(rt.new_string('post_status')) {
		var_args_mutated.array_set('post_status', rt.cast_array(var_args_mutated.array_get(rt.new_string('post_status'))))
		rt.call_function('sort', [var_args_mutated.array_get(rt.new_string('post_status'))])
	}
	if !(var_args_mutated.array_isset(rt.new_string('orderby'))) {
		var_args_mutated.array_set('orderby', 'date')
	}
	mut var_placeholder := rt.call_method(var_wpdb, 'placeholder_escape', []rt.PhpVal{})
	closure_2_fn := fn [var_wpdb, var_placeholder] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if var_value.clone().is_string() && rt.is_true(rt.call_function('str_contains', [var_value.clone(), var_placeholder.clone()])) {
		var_value = rt.call_method(var_wpdb, 'remove_placeholder_escape', [var_value.clone()])
		}
		return rt.new_null()
		}
	rt.call_function('array_walk_recursive', [var_args_mutated, rt.new_closure(closure_2_fn)])
	rt.call_function('ksort', [var_args_mutated])
	var_sql_mutated = rt.call_method(var_wpdb, 'remove_placeholder_escape', [var_sql_mutated.clone()])
	mut var_key := rt.new_string(md5.hexhash((rt.call_function('serialize', [var_args_mutated])).str() + (var_sql_mutated).str()))
	this.query_cache_key = "wp_query:${var_key.to_string()}"
	return this.query_cache_key
}

fn (mut this Class_WP_Query) reset_postdata() {
	mut var_GLOBALS := rt.new_null()
	if !(!rt.is_true(this.post)) {
		var_GLOBALS.array_set('post', this.post)
		this.setup_postdata(this.post)
	}
}

fn (mut this Class_WP_Query) lazyload_term_meta(var_check rt.PhpVal, var_term_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.5.0')])
	return var_check.clone()
}

fn (mut this Class_WP_Query) lazyload_comment_meta(var_check rt.PhpVal, var_comment_id rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.5.0')])
	return var_check.clone()
}

struct Class_WP_Tax_Query {
	rt.PhpObjectBase
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_WP_Date_Query {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
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

fn create_wp_tax_query(_args ...rt.PhpVal) &Class_WP_Tax_Query {
	mut obj := &Class_WP_Tax_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_meta_query(_args ...rt.PhpVal) &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_date_query(_args ...rt.PhpVal) &Class_WP_Date_Query {
	mut obj := &Class_WP_Date_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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
			return rt.new_bool(this.is_archive())
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
			return rt.new_bool(this.is_date())
		}
		'is_day' {
			return rt.new_bool(this.is_day())
		}
		'is_feed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_feed(dispatch_arg_0))
		}
		'is_comment_feed' {
			return rt.new_bool(this.is_comment_feed())
		}
		'is_front_page' {
			return rt.new_bool(this.is_front_page())
		}
		'is_home' {
			return rt.new_bool(this.is_home())
		}
		'is_privacy_policy' {
			return rt.new_bool(this.is_privacy_policy())
		}
		'is_month' {
			return rt.new_bool(this.is_month())
		}
		'is_page' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_page(dispatch_arg_0))
		}
		'is_paged' {
			return rt.new_bool(this.is_paged())
		}
		'is_preview' {
			return rt.new_bool(this.is_preview())
		}
		'is_robots' {
			return rt.new_bool(this.is_robots())
		}
		'is_favicon' {
			return rt.new_bool(this.is_favicon())
		}
		'is_search' {
			return rt.new_bool(this.is_search())
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
			return rt.new_bool(this.is_time())
		}
		'is_trackback' {
			return rt.new_bool(this.is_trackback())
		}
		'is_year' {
			return rt.new_bool(this.is_year())
		}
		'is_404' {
			return rt.new_bool(this.is_404())
		}
		'is_embed' {
			return rt.new_bool(this.is_embed())
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


fn (mut this Class_WP_Tax_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Tax_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Tax_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Meta_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Meta_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Meta_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Date_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Date_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Date_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn main() {
	defer {
		rt.shutdown()
	}

}
