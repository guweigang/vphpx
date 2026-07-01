import rt

struct Class_WC_Breadcrumb {
	rt.PhpObjectBase
pub mut:
		crumbs rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Breadcrumb) add_crumb(var_name rt.PhpVal, link string)  {
	this.crumbs.array_push(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [var_name.dup()]) }, rt.ArrayItem{ key: none, val: link }]))
}

fn (mut this Class_WC_Breadcrumb) reset()  {
	this.crumbs = rt.new_array()
}

fn (mut this Class_WC_Breadcrumb) get_breadcrumb() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_breadcrumb'), this.crumbs, rt.new_object('WC_Breadcrumb', []string{}, &this)])
}

fn (mut this Class_WC_Breadcrumb) generate() rt.PhpVal {
	mut var_conditionals := ['is_home', 'is_404', 'is_attachment', 'is_single', 'is_product_category', 'is_product_tag', 'is_shop', 'is_page', 'is_post_type_archive', 'is_category', 'is_tag', 'is_author', 'is_date', 'is_tax']
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_type_archive', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_int(rt.call_function('get_option', [rt.new_string('page_on_front')]).to_i64()), rt.call_function('wc_get_page_id', [rt.new_string('shop')])))))))))) || rt.is_true(rt.call_function('is_paged', []rt.PhpVal{})))) {
		for var_conditional in var_conditionals {
			if rt.is_true(rt.call_function('call_user_func', [rt.new_string(conditional)])) {
				rt.call_function('call_user_func', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Breadcrumb', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_crumbs_' + (rt.call_function('substr', [rt.new_string(conditional), rt.new_int(3)])).str() }])])
				break
			}
		}
		this.search_trail()
		this.paged_trail()
		return this.get_breadcrumb()
	}
	return rt.new_array()
}

fn (mut this Class_WC_Breadcrumb) prepend_shop_page()  {
	mut var_permalinks := rt.call_function('wc_get_permalink_structure', []rt.PhpVal{})
	mut var_shop_page_id := rt.call_function('wc_get_page_id', [rt.new_string('shop')])
	mut var_shop_page := rt.call_function('get_post', [var_shop_page_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_shop_page_id) && rt.is_true(var_shop_page))) && var_permalinks.array_isset(rt.new_string('product_base')))) && rt.is_true(rt.call_function('strstr', [var_permalinks.array_get('product_base'), '/' + (rt.get_property(var_shop_page, 'post_name')).str()])))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.add_crumb(rt.call_function('get_the_title', [var_shop_page.dup()]), (rt.call_function('get_permalink', [var_shop_page.dup()])).str())
	}
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_home()  {
	this.add_crumb(rt.call_function('single_post_title', [rt.new_string(''), rt.new_bool(false)]), '')
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_404()  {
	this.add_crumb(rt.call_function('__', [rt.new_string('Error 404'), rt.new_string('woocommerce')]), '')
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_attachment()  {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	this.add_crumbs_single((rt.get_property(var_post, 'post_parent')).to_i64(), (rt.call_function('get_permalink', [rt.get_property(var_post, 'post_parent')])).str())
	this.add_crumb(rt.call_function('get_the_title', []rt.PhpVal{}), (rt.call_function('get_permalink', []rt.PhpVal{})).str())
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_single(post_id i64, permalink string)  {
	mut permalink_mutated := permalink
	if !(var_post_id != 0) {
		// unsupported statement: Stmt_Global
	} else {
		mut var_post := rt.call_function('get_post', [rt.new_int(post_id)])
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(permalink_mutated))))) {
		permalink_mutated = (rt.call_function('get_permalink', [var_post.dup()])).str()
	}
	if rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [var_post.dup()]))) {
		this.prepend_shop_page()
		mut var_terms := rt.call_function('wc_get_product_terms', [rt.get_property(var_post, 'ID'), rt.new_string('product_cat'), rt.call_function('apply_filters', [rt.new_string('woocommerce_breadcrumb_product_terms_args'), rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'parent' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])])])
		if rt.is_true(var_terms) {
			mut var_main_term := rt.call_function('apply_filters', [rt.new_string('woocommerce_breadcrumb_main_term'), var_terms.array_get(0), var_terms.dup()])
			this.term_ancestors(rt.get_property(var_main_term, 'term_id'), rt.new_string('product_cat'))
			this.add_crumb(rt.get_property(var_main_term, 'name'), (rt.call_function('get_term_link', [var_main_term.dup()])).str())
		}
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_post_type := rt.call_function('get_post_type_object', [rt.call_function('get_post_type', [var_post.dup()])])
		if !(!rt.is_true(rt.get_property(var_post_type, 'has_archive'))) {
			this.add_crumb(rt.get_property(rt.get_property(var_post_type, 'labels'), 'singular_name'), (rt.call_function('get_post_type_archive_link', [rt.call_function('get_post_type', [var_post.dup()])])).str())
		}
	} else {
		mut var_cat := rt.call_function('current', [rt.call_function('get_the_category', [var_post.dup()])])
		if rt.is_true(var_cat) {
			this.term_ancestors(rt.get_property(var_cat, 'term_id'), rt.new_string('category'))
			this.add_crumb(rt.get_property(var_cat, 'name'), (rt.call_function('get_term_link', [var_cat.dup()])).str())
		}
	}
	this.add_crumb(rt.call_function('get_the_title', [var_post.dup()]), permalink_mutated)
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_page()  {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.get_property(var_post, 'post_parent')) {
		mut var_parent_crumbs := rt.new_array()
		mut var_parent_id := rt.get_property(var_post, 'post_parent')
		for rt.is_true(var_parent_id) {
			mut var_page := rt.call_function('get_post', [var_parent_id.dup()])
			var_parent_id = rt.get_property(var_page, 'post_parent')
			var_parent_crumbs.array_push(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_the_title', [rt.get_property(var_page, 'ID')]) }, rt.ArrayItem{ key: none, val: rt.call_function('get_permalink', [rt.get_property(var_page, 'ID')]) }]))
		}
		var_parent_crumbs = rt.call_function('array_reverse', [var_parent_crumbs.dup()])
		{
			mut iter_1 := var_parent_crumbs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_crumb := item_1.val
				this.add_crumb(var_crumb.array_get(0), (var_crumb.array_get(1)).str())
			}
		}
	}
	mut var_permalink := rt.call_function('get_permalink', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) {
		this.add_crumb(rt.get_property(var_post, 'post_title'), (if rt.is_true(var_permalink) { var_permalink } else { rt.new_string('') }).str())
	} else {
		this.add_crumb(rt.call_function('get_the_title', []rt.PhpVal{}), (if rt.is_true(var_permalink) { var_permalink } else { rt.new_string('') }).str())
	}
	this.endpoint_trail()
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_product_category()  {
	mut var_GLOBALS := rt.new_null()
	mut var_current_term := rt.call_method(var_GLOBALS.array_get('wp_query'), 'get_queried_object', []rt.PhpVal{})
	this.prepend_shop_page()
	this.term_ancestors(rt.get_property(var_current_term, 'term_id'), rt.new_string('product_cat'))
	this.add_crumb(rt.get_property(var_current_term, 'name'), (rt.call_function('get_term_link', [var_current_term.dup(), rt.new_string('product_cat')])).str())
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_product_tag()  {
	mut var_GLOBALS := rt.new_null()
	mut var_current_term := rt.call_method(var_GLOBALS.array_get('wp_query'), 'get_queried_object', []rt.PhpVal{})
	this.prepend_shop_page()
	this.add_crumb(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Products tagged &ldquo;%s&rdquo;'), rt.new_string('woocommerce')]), rt.get_property(var_current_term, 'name')]), (rt.call_function('get_term_link', [var_current_term.dup(), rt.new_string('product_tag')])).str())
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_shop()  {
	if rt.is_true(rt.identical(rt.new_int(rt.call_function('get_option', [rt.new_string('page_on_front')]).to_i64()), rt.call_function('wc_get_page_id', [rt.new_string('shop')]))) {
		return rt.new_null()
	}
	mut var__name := if rt.is_true(rt.call_function('wc_get_page_id', [rt.new_string('shop')])) { rt.call_function('get_the_title', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var__name)))) {
		mut var_product_post_type := rt.call_function('get_post_type_object', [rt.new_string('product')])
		var__name = rt.get_property(rt.get_property(var_product_post_type, 'labels'), 'name')
	}
	this.add_crumb(var__name.dup(), (rt.call_function('get_post_type_archive_link', [rt.new_string('product')])).str())
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_post_type_archive()  {
	mut var_post_type := rt.call_function('get_post_type_object', [rt.call_function('get_post_type', []rt.PhpVal{})])
	if rt.is_true(var_post_type) {
		this.add_crumb(rt.get_property(rt.get_property(var_post_type, 'labels'), 'name'), (rt.call_function('get_post_type_archive_link', [rt.call_function('get_post_type', []rt.PhpVal{})])).str())
	}
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_category()  {
	mut var_GLOBALS := rt.new_null()
	mut var_this_category := rt.call_function('get_category', [rt.call_method(var_GLOBALS.array_get('wp_query'), 'get_queried_object', []rt.PhpVal{})])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_this_category.dup()])) || rt.is_true(rt.new_bool(!(rt.is_true(var_this_category)))))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.term_ancestors(rt.get_property(var_this_category, 'term_id'), rt.new_string('category'))
	}
	this.add_crumb(rt.call_function('single_cat_title', [rt.new_string(''), rt.new_bool(false)]), (rt.call_function('get_category_link', [rt.get_property(var_this_category, 'term_id')])).str())
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_tag()  {
	mut var_GLOBALS := rt.new_null()
	mut var_queried_object := rt.call_method(var_GLOBALS.array_get('wp_query'), 'get_queried_object', []rt.PhpVal{})
	this.add_crumb(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Posts tagged &ldquo;%s&rdquo;'), rt.new_string('woocommerce')]), rt.call_function('single_tag_title', [rt.new_string(''), rt.new_bool(false)])]), (rt.call_function('get_tag_link', [rt.get_property(var_queried_object, 'term_id')])).str())
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_date()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_year', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_month', []rt.PhpVal{})))) || rt.is_true(rt.call_function('is_day', []rt.PhpVal{})))) {
		this.add_crumb(rt.call_function('get_the_time', [rt.new_string('Y')]), (rt.call_function('get_year_link', [rt.call_function('get_the_time', [rt.new_string('Y')])])).str())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_month', []rt.PhpVal{})) || rt.is_true(rt.call_function('is_day', []rt.PhpVal{})))) {
		this.add_crumb(rt.call_function('get_the_time', [rt.new_string('F')]), (rt.call_function('get_month_link', [rt.call_function('get_the_time', [rt.new_string('Y')]), rt.call_function('get_the_time', [rt.new_string('m')])])).str())
	}
	if rt.is_true(rt.call_function('is_day', []rt.PhpVal{})) {
		this.add_crumb(rt.call_function('get_the_time', [rt.new_string('d')]), '')
	}
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_tax()  {
	mut var_GLOBALS := rt.new_null()
	mut var_this_term := rt.call_method(var_GLOBALS.array_get('wp_query'), 'get_queried_object', []rt.PhpVal{})
	mut var_taxonomy := rt.call_function('get_taxonomy', [rt.get_property(var_this_term, 'taxonomy')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.add_crumb(rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'name'), '')
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.term_ancestors(rt.get_property(var_this_term, 'term_id'), rt.get_property(var_this_term, 'taxonomy'))
	}
	this.add_crumb(rt.call_function('single_term_title', [rt.new_string(''), rt.new_bool(false)]), (rt.call_function('get_term_link', [rt.get_property(var_this_term, 'term_id'), rt.get_property(var_this_term, 'taxonomy')])).str())
}

fn (mut this Class_WC_Breadcrumb) add_crumbs_author()  {
	mut var_author := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_userdata := rt.call_function('get_userdata', [var_author.dup()])
	this.add_crumb(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Author: %s'), rt.new_string('woocommerce')]), rt.get_property(var_userdata, 'display_name')]), '')
}

fn (mut this Class_WC_Breadcrumb) term_ancestors(var_term_id rt.PhpVal, var_taxonomy rt.PhpVal)  {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_ancestors := rt.call_function('get_ancestors', [var_term_id.dup(), var_taxonomy_mutated.dup()])
	var_ancestors = rt.call_function('array_reverse', [var_ancestors.dup()])
	{
		mut iter_1 := var_ancestors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_ancestor := item_1.val
			var_ancestor = rt.call_function('get_term', [var_ancestor.dup(), var_taxonomy_mutated.dup()])
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_ancestor.dup()]))))) && rt.is_true(var_ancestor))) {
				this.add_crumb(rt.get_property(var_ancestor, 'name'), (rt.call_function('get_term_link', [var_ancestor.dup()])).str())
			}
		}
	}
}

fn (mut this Class_WC_Breadcrumb) endpoint_trail()  {
	mut var_action := if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('action')])]) } else { rt.new_string('') }
	mut var_endpoint := if rt.is_true(rt.call_function('is_wc_endpoint_url', []rt.PhpVal{})) { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_current_endpoint', []rt.PhpVal{}) } else { rt.new_string('') }
	mut var_endpoint_title := if rt.is_true(var_endpoint) { rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_endpoint_title', [var_endpoint.dup(), var_action.dup()]) } else { rt.new_string('') }
	if rt.is_true(var_endpoint_title) {
		this.add_crumb(var_endpoint_title.dup(), '')
	}
}

fn (mut this Class_WC_Breadcrumb) search_trail()  {
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		this.add_crumb(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Search results for &ldquo;%s&rdquo;'), rt.new_string('woocommerce')]), rt.call_function('get_search_query', []rt.PhpVal{})]), (rt.call_function('remove_query_arg', [rt.new_string('paged')])).str())
	}
}

fn (mut this Class_WC_Breadcrumb) paged_trail()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('get_query_var', [rt.new_string('paged')])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.add_crumb(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page %d'), rt.new_string('woocommerce')]), rt.call_function('get_query_var', [rt.new_string('paged')])]), '')
	}
}

fn create_wc_breadcrumb() &Class_WC_Breadcrumb {
	mut obj := &Class_WC_Breadcrumb{
		PhpObjectBase: rt.PhpObjectBase{}
		crumbs: rt.new_array()
	}
	return obj
}

fn (mut this Class_WC_Breadcrumb) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_crumb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.add_crumb(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'reset' {
			this.reset()
			return rt.new_null()
		}
		'get_breadcrumb' {
			return this.get_breadcrumb()
		}
		'generate' {
			return this.generate()
		}
		'prepend_shop_page' {
			this.prepend_shop_page()
			return rt.new_null()
		}
		'add_crumbs_home' {
			this.add_crumbs_home()
			return rt.new_null()
		}
		'add_crumbs_404' {
			this.add_crumbs_404()
			return rt.new_null()
		}
		'add_crumbs_attachment' {
			this.add_crumbs_attachment()
			return rt.new_null()
		}
		'add_crumbs_single' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.add_crumbs_single(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_crumbs_page' {
			this.add_crumbs_page()
			return rt.new_null()
		}
		'add_crumbs_product_category' {
			this.add_crumbs_product_category()
			return rt.new_null()
		}
		'add_crumbs_product_tag' {
			this.add_crumbs_product_tag()
			return rt.new_null()
		}
		'add_crumbs_shop' {
			this.add_crumbs_shop()
			return rt.new_null()
		}
		'add_crumbs_post_type_archive' {
			this.add_crumbs_post_type_archive()
			return rt.new_null()
		}
		'add_crumbs_category' {
			this.add_crumbs_category()
			return rt.new_null()
		}
		'add_crumbs_tag' {
			this.add_crumbs_tag()
			return rt.new_null()
		}
		'add_crumbs_date' {
			this.add_crumbs_date()
			return rt.new_null()
		}
		'add_crumbs_tax' {
			this.add_crumbs_tax()
			return rt.new_null()
		}
		'add_crumbs_author' {
			this.add_crumbs_author()
			return rt.new_null()
		}
		'term_ancestors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.term_ancestors(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'endpoint_trail' {
			this.endpoint_trail()
			return rt.new_null()
		}
		'search_trail' {
			this.search_trail()
			return rt.new_null()
		}
		'paged_trail' {
			this.paged_trail()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Breadcrumb) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'crumbs' { return this.crumbs }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Breadcrumb) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'crumbs' { this.crumbs = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_breadcrumb_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
