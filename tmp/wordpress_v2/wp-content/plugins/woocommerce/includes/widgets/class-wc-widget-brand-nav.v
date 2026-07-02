import rt
import crypto.md5

struct Class_WC_Widget_Brand_Nav {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Brand_Nav) construct() {
	this.dispatch_set_prop('widget_cssclass',
		rt.new_string('woocommerce widget_brand_nav widget_layered_nav'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [
		rt.new_string('Shows brands in a widget which lets you narrow down the list of products when viewing products.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_brand_nav'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [
		rt.new_string('WooCommerce Brand Layered Nav'),
		rt.new_string('woocommerce'),
	]))
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_product_subcategories_args'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget_Brand_Nav', [
				'WC_Widget',
			], &this) },
			rt.ArrayItem{ key: none, val: 'filter_out_cats' },
		]),
	])
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Brand_Nav) filter_out_cats(var_cat_args rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filter_product_brand')))) {
		return rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: '' }])
	}
	return var_cat_args.clone()
}

fn (mut this Class_WC_Widget_Brand_Nav) get_current_taxonomy() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'taxonomy')
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WC_Widget_Brand_Nav) get_current_term_id() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'term_id')
	} else {
		rt.new_int(0)
	}])
}

fn (mut this Class_WC_Widget_Brand_Nav) get_current_term_slug() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'slug')
	} else {
		rt.new_int(0)
	}])
}

fn (mut this Class_WC_Widget_Brand_Nav) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_attribute_array := []rt.PhpVal{}
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		mut iter_1 := var_attribute_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			mut var_taxonomy_name := rt.call_function('wc_attribute_taxonomy_name', [
				rt.get_property(var_tax, 'attribute_name'),
			])
			if rt.is_true(rt.call_function('taxonomy_exists', [
				var_taxonomy_name.clone()]))
			{
				var_attribute_array << var_taxonomy_name.clone()
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_tax', [rt.call_function('array_merge', [rt.create_array_from_list(var_attribute_array), rt.create_array([rt.ArrayItem{
		key: none
		val: 'product_cat'
	}, rt.ArrayItem{ key: none, val: 'product_tag' }, rt.ArrayItem{ key: none, val: 'product_brand' }])])]))))) {
		return
	}
	mut iife_temp_0 := Class_WC_Query{}
	mut iife_result_0 := iife_temp_0.get_layered_nav_chosen_attributes()
	mut var__chosen_attributes := iife_result_0
	mut var_current_term := if rt.is_true(var_attribute_array)
		&& rt.is_true(rt.call_function('is_tax', [rt.create_array_from_list(var_attribute_array)])) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'term_id')
	} else {
		rt.new_string('')
	}
	mut var_current_tax := if rt.is_true(var_attribute_array)
		&& rt.is_true(rt.call_function('is_tax', [rt.create_array_from_list(var_attribute_array)])) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'taxonomy')
	} else {
		rt.new_string('')
	}
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'),
		var_instance_mutated.array_get(rt.new_string('title')),
		var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WC_Widget_Brand_Nav', [
			'WC_Widget',
		], &this), 'id_base')])
	mut var_taxonomy := rt.new_string('product_brand')
	mut var_display_type := if var_instance_mutated.array_isset(rt.new_string('display_type')) {
		var_instance_mutated.array_get(rt.new_string('display_type'))
	} else {
		rt.new_string('list')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		return
	}
	mut var_terms := rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
			rt.ArrayItem{ key: 'hide_empty', val: true }, rt.ArrayItem{ key: 'parent', val: 0 }]),
	])
	if !rt.is_true(var_terms) {
		return
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	this.widget_start(var_args.clone(), var_instance_mutated.clone())
	if rt.is_true(rt.identical(rt.new_string('dropdown'), var_display_type)) {
		mut var_found := this.layered_nav_dropdown(var_terms.clone(), var_taxonomy.clone(), 0)
	} else {
		var_found = this.layered_nav_list(var_terms.clone(), var_taxonomy.clone(), 0)
	}
	this.widget_end(var_args.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})))))
		&& var__chosen_attributes.clone().is_array()
		&& rt.is_true(rt.new_bool(var__chosen_attributes.clone().array_isset(var_taxonomy.clone()))) {
		var_found = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	} else {
		rt.echo_val(rt.call_function('ob_get_clean', []rt.PhpVal{}))
	}
}

fn (mut this Class_WC_Widget_Brand_Nav) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_woocommerce := rt.new_null()
	mut var_instance := map[string]rt.PhpVal{}
	mut var_new_instance_mutated := var_new_instance
	if !rt.is_true(var_new_instance_mutated.array_get(rt.new_string('title'))) {
		var_new_instance_mutated.array_set('title', rt.call_function('__', [
			rt.new_string('Brands'),
			rt.new_string('woocommerce'),
		]))
	}
	var_instance['title'] = rt.call_function('wp_strip_all_tags', [
		rt.call_function('stripslashes',
			[var_new_instance_mutated.array_get(rt.new_string('title'))]),
	])
	var_instance['display_type'] = rt.call_function('stripslashes', [
		var_new_instance_mutated.array_get(rt.new_string('display_type')),
	])
	return var_instance.clone()
}

fn (mut this Class_WC_Widget_Brand_Nav) form(var_instance rt.PhpVal) {
	mut var_woocommerce := rt.new_null()
	mut var_instance_mutated := var_instance
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
	rt.echo_val(if var_instance_mutated.array_isset(rt.new_string('title')) { rt.call_function('esc_attr', [
			var_instance_mutated.array_get(rt.new_string('title')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		this.get_field_id(rt.new_string('display_type')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Display Type:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		this.get_field_id(rt.new_string('display_type')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		this.get_field_name(rt.new_string('display_type')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get(rt.new_string('display_type')),
		rt.new_string('list')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('List'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get(rt.new_string('display_type')),
		rt.new_string('dropdown')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dropdown'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Widget_Brand_Nav) get_page_base_url(var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	if rt.is_true(rt.call_function('defined', [rt.new_string('SHOP_IS_ON_FRONT')])) {
		mut var_link := rt.call_function('home_url', []rt.PhpVal{})
	} else if rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))
		|| rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])])) {
		var_link = rt.call_function('get_post_type_archive_link', [
			rt.new_string('product'),
		])
	} else if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) {
		var_link = rt.call_function('get_term_link', [
			rt.call_function('get_query_var', [rt.new_string('product_cat')]),
			rt.new_string('product_cat'),
		])
	} else if rt.is_true(rt.call_function('is_product_tag', []rt.PhpVal{})) {
		var_link = rt.call_function('get_term_link', [
			rt.call_function('get_query_var', [rt.new_string('product_tag')]),
			rt.new_string('product_tag'),
		])
	} else if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(var_queried_object.clone().is_null())) {
			var_link = rt.call_function('get_post_type_archive_link', [
				rt.new_string('product'),
			])
		} else {
			var_link = rt.call_function('get_term_link', [
				rt.get_property(var_queried_object, 'term_id'),
				rt.get_property(var_queried_object, 'taxonomy'),
			])
		}
	} else {
		var_link = rt.call_function('get_post_type_archive_link', [
			rt.new_string('product'),
		])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('min_price')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('min_price'),
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('min_price'))]),
			]),
			var_link.clone()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('max_price')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('max_price'),
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('max_price'))]),
			]),
			var_link.clone()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('orderby'),
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))]),
			]),
			var_link.clone()])
	}
	if rt.is_true(rt.call_function('get_search_query', []rt.PhpVal{})) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('s'),
			rt.call_function('rawurlencode', [
				rt.call_function('htmlspecialchars_decode', [
					rt.call_function('get_search_query', []rt.PhpVal{}),
				]),
			]),
			var_link.clone()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('post_type')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('post_type'),
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))]),
			]),
			var_link.clone()])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('min_rating')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('min_rating'),
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('min_rating')),
				]),
			]),
			var_link.clone()])
	}
	mut iife_temp_1 := Class_WC_Query{}
	mut iife_result_1 := iife_temp_1.get_layered_nav_chosen_attributes()
	mut var__chosen_attributes := iife_result_1
	if rt.is_true(var__chosen_attributes) {
		mut iter_2 := var__chosen_attributes.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_data := item_2.val
			mut var_name := item_2.key
			if rt.is_true(rt.identical(var_name, var_taxonomy_mutated)) {
				continue
			}
			mut var_filter_name := rt.call_function('sanitize_title', [
				rt.call_function('str_replace', [rt.new_string('pa_'),
					rt.new_string(''), var_name.clone()]),
			])
			if !(!rt.is_true(var_data.array_get(rt.new_string('terms')))) {
				var_link = rt.call_function('add_query_arg', [
					rt.new_string('filter_' + var_filter_name.str()),
					rt.call_function('implode', [rt.new_string(','),
						var_data.array_get(rt.new_string('terms'))]),
					var_link.clone(),
				])
			}
			if rt.is_true(rt.identical(rt.new_string('or'),
				var_data.array_get(rt.new_string('query_type'))))
			{
				var_link = rt.call_function('add_query_arg', [
					rt.new_string('query_type_' + var_filter_name.str()),
					rt.new_string('or'),
					var_link.clone(),
				])
			}
		}
	}
	return var_link.clone()
}

fn (mut this Class_WC_Widget_Brand_Nav) get_chosen_attributes() rt.PhpVal {
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('filter_product_brand')))) {
		mut var_filter_product_brand := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_GET').array_get(rt.new_string('filter_product_brand')),
			]),
		])
		return rt.call_function('array_map', [rt.new_string('intval'),
			rt.call_function('explode', [rt.new_string(','), var_filter_product_brand.clone()])])
	}
	return []rt.PhpVal{}
}

fn (mut this Class_WC_Widget_Brand_Nav) layered_nav_dropdown(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, depth i64) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
	mut var_found := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_taxonomy_mutated,
		this.get_current_taxonomy()))))
	{
		mut var_term_counts := this.get_filtered_term_product_counts(rt.call_function('wp_list_pluck', [
			var_terms_mutated.clone(),
			rt.new_string('term_id'),
		]), var_taxonomy_mutated.clone(), 'or')
		mut var__chosen_attributes := this.get_chosen_attributes()
		if 0 == depth {
			print('<select class="wc-brand-dropdown-layered-nav-' +
				(rt.call_function('esc_attr', [var_taxonomy_mutated.clone()])).str() + '">')
			print('<option value="">' +
				(rt.call_function('esc_html__', [rt.new_string('Any Brand'), rt.new_string('woocommerce')])).str() +
				'</option>')
		}
		mut iter_3 := var_terms_mutated.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_term := item_3.val
			if rt.is_true(rt.identical(rt.get_property(var_term, 'term_id'),
				this.get_current_term_id()))
			{
				continue
			}
			mut var_current_values := if !(!rt.is_true(var__chosen_attributes)) {
				var__chosen_attributes
			} else {
				[]rt.PhpVal{}
			}
			mut var_option_is_set := rt.call_function('in_array', [
				rt.get_property(var_term, 'term_id'),
				var_current_values.clone(),
				rt.new_bool(true),
			])
			mut var_count := if var_term_counts.array_isset(rt.get_property(var_term, 'term_id')) {
				var_term_counts.array_get(rt.get_property(var_term, 'term_id'))
			} else {
				rt.new_int(0)
			}
			if rt.is_true(rt.less(rt.new_int(0), var_count)) {
				var_found = rt.new_bool(true)
			} else if rt.is_true(rt.identical(rt.new_int(0), var_count))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_option_is_set)))) {
				continue
			}
			print('<option value="' +
				(rt.call_function('esc_attr', [rt.get_property(var_term, 'term_id')])).str() +
				'" ' +
				(rt.call_function('selected', [var_option_is_set.clone(), rt.new_bool(true), rt.new_bool(false)])).str() +
				'>' +
				(rt.call_function('esc_html', [rt.new_string((rt.call_function('str_repeat', [rt.new_string('&nbsp;'), rt.new_int(2 * depth)])).str() +
				(rt.get_property(var_term, 'name')).str())])).str() + '</option>')
			mut var_child_terms := rt.call_function('get_terms', [
				rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_mutated },
					rt.ArrayItem{ key: 'hide_empty', val: true },
					rt.ArrayItem{ key: 'parent', val: rt.get_property(var_term, 'term_id') },
				]),
			])
			if !(!rt.is_true(var_child_terms)) {
				rt.new_null()
			}
		}
		if 0 == depth {
			mut var_link := this.get_page_base_url(var_taxonomy_mutated.clone())
			print('</select>')
			mut var_handle := rt.new_string('wc-brand-widget-dropdown-layered-nav-' +
				var_taxonomy_mutated.str())
			rt.call_function('wp_register_script', [var_handle.clone(),
				rt.new_string(''), []rt.PhpVal{}, rt.get_constant('WC_VERSION'),
				rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
			rt.call_function('wp_enqueue_script', [var_handle.clone()])
			mut var_redirect_url := rt.call_function('add_query_arg', [
				rt.new_string('filtering'),
				rt.new_string('1'),
				rt.call_function('preg_replace', [rt.new_string('%\\/page\\/[0-9]+%'),
					rt.new_string(''), rt.call_function('esc_url_raw', [
						var_link.clone()])]),
			])
			rt.call_function('wp_add_inline_script', [var_handle.clone(),
				rt.new_string(
					"\n                    (function() {\n                        'use strict';\n                        const dropdown = document.querySelector( '.wc-brand-dropdown-layered-nav-" + (rt.call_function('esc_js', [var_taxonomy_mutated.clone()])).str() +
					"' );\n                        if ( dropdown ) {\n                            dropdown.addEventListener( 'change', function() {\n                                const slug = this.value;\n                                location.href = '" +
					(rt.call_function('esc_js', [var_redirect_url.clone()])).str() + '&filter_' +
					(rt.call_function('esc_js', [var_taxonomy_mutated.clone()])).str() + "=' +
					slug;\n                            } );\n                        }\n                    })();\n                    ")])
		}
	}
	return var_found.clone()
}

fn (mut this Class_WC_Widget_Brand_Nav) layered_nav_list(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, depth i64) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
	print('<ul class="' + if 0 == depth { '' } else { 'children ' } + 'wc-brand-list-layered-nav-' +
		(rt.call_function('esc_attr', [var_taxonomy_mutated.clone()])).str() + '">')
	mut var_term_counts := this.get_filtered_term_product_counts(rt.call_function('wp_list_pluck', [
		var_terms_mutated.clone(),
		rt.new_string('term_id'),
	]), var_taxonomy_mutated.clone(), 'or')
	mut var__chosen_attributes := this.get_chosen_attributes()
	mut var_current_values := if !(!rt.is_true(var__chosen_attributes)) {
		var__chosen_attributes
	} else {
		[]rt.PhpVal{}
	}
	mut var_found := rt.new_bool(false)
	mut var_filter_name := rt.new_string('filter_' + var_taxonomy_mutated.str())
	mut iter_4 := var_terms_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_term := item_4.val
		mut var_option_is_set := rt.call_function('in_array', [
			rt.get_property(var_term, 'term_id'),
			var_current_values.clone(),
			rt.new_bool(true),
		])
		mut var_count := if var_term_counts.array_isset(rt.get_property(var_term, 'term_id')) {
			var_term_counts.array_get(rt.get_property(var_term, 'term_id'))
		} else {
			rt.new_int(0)
		}
		if rt.is_true(rt.identical(this.get_current_term_id(), rt.get_property(var_term, 'term_id'))) {
			continue
		}
		if rt.is_true(rt.less(rt.new_int(0), var_count)) {
			var_found = rt.new_bool(true)
		} else if rt.is_true(rt.identical(rt.new_int(0), var_count))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_option_is_set)))) {
			continue
		}
		mut var_current_filter := if rt.get_superglobal('_GET').array_isset(var_filter_name) { rt.call_function('explode', [
				rt.new_string(','),
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(var_filter_name)]),
				]),
			]) } else { []rt.PhpVal{} }
		var_current_filter = rt.call_function('array_map', [rt.new_string('intval'),
			var_current_filter.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_term, 'term_id'),
			var_current_filter.clone(),
			rt.new_bool(true),
		])))))
		{
			var_current_filter.array_push(rt.get_property(var_term, 'term_id'))
		}
		mut var_link := this.get_page_base_url(var_taxonomy_mutated.clone())
		mut iter_5 := var_current_filter.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_value := item_5.val
			mut var_key := item_5.key
			if rt.is_true(rt.identical(var_value, this.get_current_term_id())) {
				var_current_filter.array_unset(var_key)
			}
			if rt.is_true(var_option_is_set)
				&& rt.is_true(rt.identical(var_value, rt.get_property(var_term, 'term_id'))) {
				var_current_filter.array_unset(var_key)
			}
		}
		if !(!rt.is_true(var_current_filter)) {
			var_link = rt.call_function('add_query_arg', [
				rt.create_array([rt.ArrayItem{ key: 'filtering', val: '1' },
					rt.ArrayItem{ key: var_filter_name, val: rt.call_function('implode', [
						rt.new_string(','),
						var_current_filter.clone(),
					]) }]),
				var_link.clone(),
			])
		}
		print('<li class="wc-layered-nav-term ' +
			if rt.is_true(var_option_is_set) { 'chosen' } else { '' } + '">')
		print(if rt.is_true(rt.greater(var_count, rt.new_int(0))) || rt.is_true(var_option_is_set) {
			'<a href="' +
				(rt.call_function('esc_url', [rt.call_function('apply_filters', [rt.new_string('woocommerce_layered_nav_link'), var_link.clone()])])).str() +
				'">'
		} else {
			'<span>'
		})
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_term, 'name')]))
		print(if rt.is_true(rt.greater(var_count, rt.new_int(0))) || rt.is_true(var_option_is_set) {
			'</a> '
		} else {
			'</span> '
		})
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_layered_nav_count'),
				rt.new_string('<span class="count">(' +
					(rt.call_function('absint', [var_count.clone()])).str() + ')</span>'),
				var_count.clone(),
				var_term.clone(),
			]),
		]))
		mut var_child_terms := rt.call_function('get_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_mutated },
				rt.ArrayItem{ key: 'hide_empty', val: true },
				rt.ArrayItem{ key: 'parent', val: rt.get_property(var_term, 'term_id') }]),
		])
		if !(!rt.is_true(var_child_terms)) {
			rt.new_null()
		}
		print('</li>')
	}
	print('</ul>')
	return var_found.clone()
}

fn (mut this Class_WC_Widget_Brand_Nav) get_filtered_term_product_counts(var_term_ids rt.PhpVal, var_taxonomy rt.PhpVal, query_type string) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_taxonomy_mutated := var_taxonomy
	mut iife_temp_2 := Class_WC_Query{}
	mut iife_result_2 := iife_temp_2.get_main_tax_query()
	mut var_tax_query := iife_result_2
	mut iife_temp_3 := Class_WC_Query{}
	mut iife_result_3 := iife_temp_3.get_main_meta_query()
	mut var_meta_query := iife_result_3
	if rt.is_true(rt.identical(rt.new_string('or'), rt.new_string(query_type))) {
		mut iter_6 := var_tax_query.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_query := item_6.val
			mut var_key := item_6.key
			if var_query.clone().is_array()
				&& rt.is_true(rt.identical(var_taxonomy_mutated, var_query.array_get(rt.new_string('taxonomy')))) {
				var_tax_query.array_unset(var_key)
			}
		}
	}
	var_meta_query = create_wp_meta_query(var_meta_query.clone())
	var_tax_query = create_wp_tax_query(var_tax_query.clone())
	mut var_meta_query_sql := rt.call_method(var_meta_query, 'get_sql', [
		rt.new_string('post'),
		rt.get_property(var_wpdb, 'posts'),
		rt.new_string('ID'),
	])
	mut var_tax_query_sql := rt.call_method(var_tax_query, 'get_sql', [
		rt.get_property(var_wpdb, 'posts'),
		rt.new_string('ID'),
	])
	mut var_query := []rt.PhpVal{}
	var_query.array_set('select', rt.concat(rt.concat(rt.new_string('SELECT COUNT( DISTINCT '), rt.get_property(var_wpdb,
		'posts')), rt.new_string('.ID ) as term_count, terms.term_id as term_count_id')))
	var_query.array_set('from', rt.concat(rt.new_string('FROM '),
		rt.get_property(var_wpdb, 'posts')))
	var_query.array_set('join',
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tINNER JOIN '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS term_relationships ON ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = term_relationships.object_id\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' AS term_taxonomy USING( term_taxonomy_id )\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'terms')), rt.new_string(' AS terms USING( term_id )\n\t\t\t')) +
		(var_tax_query_sql.array_get(rt.new_string('join'))).str() +
		(var_meta_query_sql.array_get(rt.new_string('join'))).str())
	var_query.array_set('where',
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tWHERE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(".post_type IN ( 'product' )\n\t\t\tAND ")), rt.get_property(var_wpdb, 'posts')), rt.new_string(".post_status = 'publish'\n\t\t\t")) +
		(var_tax_query_sql.array_get(rt.new_string('where'))).str() + (var_meta_query_sql.array_get(rt.new_string('where'))).str() + '\n\t\t\tAND terms.term_id IN (' + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('absint'), var_term_ids.clone()])])).str() +
		')\n\t\t')
	var_query.array_set('group_by', 'GROUP BY terms.term_id')
	var_query = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_filtered_term_product_counts_query'),
		var_query.clone(),
	])
	var_query = rt.call_function('implode', [rt.new_string(' '),
		var_query.clone()])
	mut var_query_hash := rt.new_string(md5.hexhash(var_query.clone().to_string()))
	mut var_cache := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_layered_nav_count_maybe_cache'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.identical(rt.new_bool(true), var_cache)) {
		mut var_cached_counts := rt.cast_array(rt.call_function('get_transient', [
			rt.new_string('wc_layered_nav_counts_' +
				(rt.call_function('sanitize_title', [var_taxonomy_mutated.clone()])).str()),
		]))
	} else {
		var_cached_counts = []rt.PhpVal{}
	}
	if !(var_cached_counts.array_isset(var_query_hash)) {
		mut var_results := rt.call_method(var_wpdb, 'get_results', [
			var_query.clone(), rt.get_constant('ARRAY_A')])
		mut var_counts := rt.call_function('array_map', [rt.new_string('absint'),
			rt.call_function('wp_list_pluck', [var_results.clone(),
				rt.new_string('term_count'), rt.new_string('term_count_id')])])
		var_cached_counts.array_set(var_query_hash, var_counts.clone())
		if rt.is_true(rt.identical(rt.new_bool(true), var_cache)) {
			rt.call_function('set_transient', [
				rt.new_string('wc_layered_nav_counts_' +
					(rt.call_function('sanitize_title', [var_taxonomy_mutated.clone()])).str()),
				var_cached_counts.clone(),
				rt.get_constant('HOUR_IN_SECONDS'),
			])
		}
	}
	return rt.call_function('array_map', [rt.new_string('absint'),
		rt.cast_array(var_cached_counts.array_get(var_query_hash))])
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

fn create_wc_widget_brand_nav() &Class_WC_Widget_Brand_Nav {
	mut obj := &Class_WC_Widget_Brand_Nav{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_widget(_args ...rt.PhpVal) &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_query(_args ...rt.PhpVal) &Class_WC_Query {
	mut obj := &Class_WC_Query{
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

fn create_wp_tax_query(_args ...rt.PhpVal) &Class_WP_Tax_Query {
	mut obj := &Class_WP_Tax_Query{
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
			return this.get_filtered_term_product_counts(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
