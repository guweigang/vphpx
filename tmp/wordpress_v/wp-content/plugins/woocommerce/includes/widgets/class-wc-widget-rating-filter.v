import rt

struct Class_WC_Widget_Rating_Filter {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Rating_Filter) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_rating_filter'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Display a list of star ratings to filter products in your store.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_rating_filter'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Filter Products by Rating'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Average rating'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Rating_Filter) get_filtered_product_count(var_rating rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_rating_mutated := var_rating
	// unsupported statement: Stmt_Global
	mut var_tax_query := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_main_tax_query() }()
	mut var_meta_query := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_main_meta_query() }()
	{
		mut iter_1 := var_tax_query.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_query := item_1.val
			mut var_key := item_1.key
			if !(!rt.is_true(var_query.array_get('rating_filter'))) {
				var_tax_query.array_unset(var_key)
				break
			}
		}
	}
	mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids', []rt.PhpVal{})
	var_tax_query.array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' }, rt.ArrayItem{ key: 'terms', val: var_product_visibility_terms.array_get('rated-' + (var_rating_mutated).str()) }, rt.ArrayItem{ key: 'operator', val: 'IN' }, rt.ArrayItem{ key: 'rating_filter', val: true }]))
	var_meta_query = create_wp_meta_query(var_meta_query.dup())
	var_tax_query = create_wp_tax_query(var_tax_query.dup())
	mut var_meta_query_sql := rt.call_method(var_meta_query, 'get_sql', [rt.new_string('post'), rt.get_property(var_wpdb, 'posts'), rt.new_string('ID')])
	mut var_tax_query_sql := rt.call_method(var_tax_query, 'get_sql', [rt.get_property(var_wpdb, 'posts'), rt.new_string('ID')])
	mut var_sql := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT COUNT( DISTINCT '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID ) FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	mut var_search := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_main_search_query_sql() }()
	if rt.is_true(var_search) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [var_sql.dup()])])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_WC_Widget_Rating_Filter) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_main_query', []rt.PhpVal{}), 'post_count'))))) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_found := rt.new_bool(rt.new_bool(false))
	mut var_rating_filter := if rt.get_superglobal('_GET').array_isset(rt.new_string('rating_filter')) { rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('explode', [rt.new_string(','), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('rating_filter')])])])]) } else { rt.new_array() }
	mut var_base_link := rt.call_function('remove_query_arg', [rt.new_string('paged'), this.get_current_page_url()])
	this.widget_start(var_args.dup(), var_instance.dup())
	print('<ul>')
	{
		mut var_rating := rt.new_int(rt.new_int(5))
		for {
			if !(rt.is_true(rt.greater_equal(var_rating, rt.new_int(1)))) { break }
			mut var_count := this.get_filtered_product_count(var_rating.dup())
			if !rt.is_true(var_count) {
				continue
			}
			var_found = rt.new_bool(rt.new_bool(true))
			mut var_link := var_base_link.dup()
			if rt.is_true(rt.call_function('in_array', [var_rating.dup(), var_rating_filter.dup(), rt.new_bool(true)])) {
				mut var_link_ratings := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_diff', [var_rating_filter.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating }])])])
			} else {
				var_link_ratings = rt.call_function('implode', [rt.new_string(','), rt.call_function('array_merge', [var_rating_filter.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating }])])])
			}
			mut var_class := rt.new_string(if rt.is_true(rt.call_function('in_array', [var_rating.dup(), var_rating_filter.dup(), rt.new_bool(true)])) { rt.new_string('wc-layered-nav-rating chosen') } else { rt.new_string('wc-layered-nav-rating') })
			var_link = rt.call_function('apply_filters', [rt.new_string('woocommerce_rating_filter_link'), if rt.is_true(var_link_ratings) { rt.call_function('add_query_arg', [rt.new_string('rating_filter'), var_link_ratings.dup(), var_link.dup()]) } else { rt.call_function('remove_query_arg', [rt.new_string('rating_filter')]) }])
			mut var_rating_html := rt.call_function('wc_get_star_rating_html', [var_rating.dup()])
			mut var_count_html := rt.call_function('wp_kses', [rt.call_function('apply_filters', [rt.new_string('woocommerce_rating_filter_count'), rt.new_string("(${var_count.to_string()})"), var_count.dup(), var_rating.dup()]), rt.create_array([rt.ArrayItem{ key: 'em', val: rt.new_array() }, rt.ArrayItem{ key: 'span', val: rt.new_array() }, rt.ArrayItem{ key: 'strong', val: rt.new_array() }])])
			rt.call_function('printf', [rt.new_string('<li class="%s"><a href="%s"><span class="star-rating">%s</span> %s</a></li>'), rt.call_function('esc_attr', [var_class.dup()]), rt.call_function('esc_url', [var_link.dup()]), var_rating_html.dup(), var_count_html.dup()])
			// unsupported statement: Stmt_Nop
			rt.post_dec(var_rating)
		}
	}
	print('</ul>')
	this.widget_end(var_args.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	} else {
		rt.echo_val(rt.call_function('ob_get_clean', []rt.PhpVal{}))
		// unsupported statement: Stmt_Nop
	}
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

struct Class_WP_Meta_Query {
	rt.PhpObjectBase
}

struct Class_WP_Tax_Query {
	rt.PhpObjectBase
}

fn create_wc_widget_rating_filter() &Class_WC_Widget_Rating_Filter {
	mut obj := &Class_WC_Widget_Rating_Filter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_widget() &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_query() &Class_WC_Query {
	mut obj := &Class_WC_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_meta_query() &Class_WP_Meta_Query {
	mut obj := &Class_WP_Meta_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_tax_query() &Class_WP_Tax_Query {
	mut obj := &Class_WP_Tax_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget_Rating_Filter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_filtered_product_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_filtered_product_count(dispatch_arg_0)
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Widget_Rating_Filter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Rating_Filter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Tax_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Tax_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Tax_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_rating_filter_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
