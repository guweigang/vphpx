import rt

struct Class_WC_Widget_Brand_Nav {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Brand_Nav) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_brand_nav widget_layered_nav'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Shows brands in a widget which lets you narrow down the list of products when viewing products.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_brand_nav'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('WooCommerce Brand Layered Nav'), rt.new_string('woocommerce')]))
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_subcategories_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget_Brand_Nav', ['WC_Widget'], &this) }, rt.ArrayItem{ key: none, val: 'filter_out_cats' }])])
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Brand_Nav) filter_out_cats(var_cat_args rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('filter_product_brand'))) {
		return rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: '' }])
	}
	return var_cat_args.dup()
}

fn (mut this Class_WC_Widget_Brand_Nav) get_current_taxonomy() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'taxonomy') } else { rt.new_string('') }
}

fn (mut this Class_WC_Widget_Brand_Nav) get_current_term_id() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'term_id') } else { rt.new_int(0) }])
}

fn (mut this Class_WC_Widget_Brand_Nav) get_current_term_slug() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'slug') } else { rt.new_int(0) }])
}

fn (mut this Class_WC_Widget_Brand_Nav) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	mut var_attribute_array := []rt.PhpVal{}
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		{
			mut iter_1 := var_attribute_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax := item_1.val
				mut var_taxonomy_name := rt.call_function('wc_attribute_taxonomy_name', [rt.get_property(var_tax, 'attribute_name')])
				if rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy_name.dup()])) {
					var_attribute_array << var_taxonomy_name.dup()
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_tax', [rt.call_function('array_merge', [var_attribute_array.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'product_cat' }, rt.ArrayItem{ key: none, val: 'product_tag' }, rt.ArrayItem{ key: none, val: 'product_brand' }])])]))))))) {
		return rt.new_null()
	}
	mut var__chosen_attributes := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }()
	mut var_current_term := if rt.is_true(rt.new_bool(rt.is_true(var_attribute_array) && rt.is_true(rt.call_function('is_tax', [var_attribute_array.dup()])))) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'term_id') } else { rt.new_string('') }
	mut var_current_tax := if rt.is_true(rt.new_bool(rt.is_true(var_attribute_array) && rt.is_true(rt.call_function('is_tax', [var_attribute_array.dup()])))) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'taxonomy') } else { rt.new_string('') }
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'), var_instance_mutated.array_get('title'), var_instance_mutated.dup(), rt.get_property(rt.new_object('WC_Widget_Brand_Nav', ['WC_Widget'], &this), 'id_base')])
	mut var_taxonomy := rt.new_string(rt.new_string('product_brand'))
	mut var_display_type := if var_instance_mutated.array_isset(rt.new_string('display_type')) { var_instance_mutated.array_get('display_type') } else { rt.new_string('list') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.dup()]))))) {
		return rt.new_null()
	}
	mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'hide_empty', val: true }, rt.ArrayItem{ key: 'parent', val: 0 }])])
	if !rt.is_true(var_terms) {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	this.widget_start(var_args.dup(), var_instance_mutated.dup())
	if rt.is_true(rt.identical(rt.new_string('dropdown'), var_display_type)) {
		mut var_found := this.layered_nav_dropdown(var_terms.dup(), var_taxonomy.dup(), 0)
	} else {
		var_found = this.layered_nav_list(var_terms.dup(), var_taxonomy.dup(), 0)
	}
	this.widget_end(var_args.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_tax', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(var__chosen_attributes.dup().is_array())))) && rt.is_true(rt.new_bool(var__chosen_attributes.dup().array_isset(var_taxonomy.dup()))))) {
		var_found = rt.new_bool(rt.new_bool(true))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	} else {
		rt.echo_val(rt.call_function('ob_get_clean', []rt.PhpVal{}))
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_WC_Widget_Brand_Nav) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_woocommerce := rt.new_null()
	mut var_instance := map[string]rt.PhpVal{}
	mut var_new_instance_mutated := var_new_instance
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_new_instance_mutated.array_get('title')) {
		var_new_instance_mutated.array_set('title', rt.call_function('__', [rt.new_string('Brands'), rt.new_string('woocommerce')]))
	}
	var_instance['title'] = rt.call_function('wp_strip_all_tags', [rt.call_function('stripslashes', [var_new_instance_mutated.array_get('title')])])
	var_instance['display_type'] = rt.call_function('stripslashes', [var_new_instance_mutated.array_get('display_type')])
	return var_instance.dup()
}

fn (mut this Class_WC_Widget_Brand_Nav) form(var_instance rt.PhpVal)  {
	mut var_woocommerce := rt.new_null()
	mut var_instance_mutated := var_instance
	// unsupported statement: Stmt_Global
	if !(var_instance_mutated.array_isset(rt.new_string('display_type'))) {
		var_instance_mutated.array_set('display_type', 'list')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if var_instance_mutated.array_isset(rt.new_string('title')) { rt.call_function('esc_attr', [var_instance_mutated.array_get('title')]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('display_type'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Display Type:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('display_type'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('display_type'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('display_type'), rt.new_string('list')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('List'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('display_type'), rt.new_string('dropdown')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dropdown'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Widget_Brand_Nav) get_page_base_url(var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.call_function('defined', [rt.new_string('SHOP_IS_ON_FRONT')])) {
		mut var_link := rt.call_function('home_url', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])) || rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])])))) {
		var_link = rt.call_function('get_post_type_archive_link', [rt.new_string('product')])
	} else if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) {
		var_link = rt.call_function('get_term_link', [rt.call_function('get_query_var', [rt.new_string('product_cat')]), rt.new_string('product_cat')])
	} else if rt.is_true(rt.call_function('is_product_tag', []rt.PhpVal{})) {
		var_link = rt.call_function('get_term_link', [rt.call_function('get_query_var', [rt.new_string('product_tag')]), rt.new_string('product_tag')])
	} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_queried_object.dup().is_null())) {
			var_link = rt.call_function('get_post_type_archive_link', [rt.new_string('product')])
		} else {
			var_link = rt.call_function('get_term_link', [rt.get_property(var_queried_object, 'term_id'), rt.get_property(var_queried_object, 'taxonomy')])
		}
	} else {
		var_link = rt.call_function('get_post_type_archive_link', [rt.new_string('product')])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('min_price')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('min_price'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('min_price')])]), var_link.dup()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('max_price')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('max_price'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('max_price')])]), var_link.dup()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('orderby'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('orderby')])]), var_link.dup()])
	}
	if rt.is_true(rt.call_function('get_search_query', []rt.PhpVal{})) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('s'), rt.call_function('rawurlencode', [rt.call_function('htmlspecialchars_decode', [rt.call_function('get_search_query', []rt.PhpVal{})])]), var_link.dup()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('post_type')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('post_type'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('post_type')])]), var_link.dup()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('min_rating')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('min_rating'), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('min_rating')])]), var_link.dup()])
	}
	mut var__chosen_attributes := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }()
	if rt.is_true(var__chosen_attributes) {
		{
			mut iter_1 := var__chosen_attributes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_data := item_1.val
				mut var_name := item_1.key
				if rt.is_true(rt.identical(var_name, var_taxonomy_mutated)) {
					continue
				}
				mut var_filter_name := rt.call_function('sanitize_title', [rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), var_name.dup()])])
				if !(!rt.is_true(var_data.array_get('terms'))) {
					var_link = rt.call_function('add_query_arg', ['filter_' + (var_filter_name).str(), rt.call_function('implode', [rt.new_string(','), var_data.array_get('terms')]), var_link.dup()])
				}
				if rt.is_true(rt.identical(rt.new_string('or'), var_data.array_get('query_type'))) {
					var_link = rt.call_function('add_query_arg', ['query_type_' + (var_filter_name).str(), rt.new_string('or'), var_link.dup()])
				}
			}
		}
	}
	return var_link.dup()
}

fn (mut this Class_WC_Widget_Brand_Nav) get_chosen_attributes() rt.PhpVal {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('filter_product_brand'))) {
		mut var_filter_product_brand := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('filter_product_brand')])])
		return rt.call_function('array_map', [rt.new_string('intval'), rt.call_function('explode', [rt.new_string(','), var_filter_product_brand.dup()])])
	}
	return []rt.PhpVal{}
}

fn (mut this Class_WC_Widget_Brand_Nav) layered_nav_dropdown(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, depth i64) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
	mut var_found := rt.new_bool(rt.new_bool(false))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_term_counts := this.get_filtered_term_product_counts(, .dup(), )
		mut var__chosen_attributes := 
		if  ==  {
		}
		{
			mut iter_1 := .iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_term := item_1.val
			}
		}
	}
	return .dup()
}

fn (mut this Class_WC_Widget_Brand_Nav) layered_nav_list(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, depth i64) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
}

fn (mut this Class_WC_Widget_Brand_Nav) get_filtered_term_product_counts(var_term_ids rt.PhpVal, var_taxonomy rt.PhpVal, query_type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

fn create_wc_widget_brand_nav() &Class_WC_Widget_Brand_Nav {
	mut obj := &Class_WC_Widget_Brand_Nav{
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

fn (mut this Class_WC_Widget_Brand_Nav) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'filter_out_cats' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_out_cats(dispatch_arg_0)
		}
		'get_current_taxonomy' {
			return this.get_current_taxonomy()
		}
		'get_current_term_id' {
			return this.get_current_term_id()
		}
		'get_current_term_slug' {
			return this.get_current_term_slug()
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		'get_page_base_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_page_base_url(dispatch_arg_0)
		}
		'get_chosen_attributes' {
			return this.get_chosen_attributes()
		}
		'layered_nav_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.layered_nav_dropdown(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'layered_nav_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.layered_nav_list(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_filtered_term_product_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_filtered_term_product_counts(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WC_Widget_Brand_Nav) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Brand_Nav) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_brand_nav_php() {
	// unsupported statement: Stmt_Declare
}
