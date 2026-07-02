import rt

struct Class_WC_Widget_Layered_Nav {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Layered_Nav) construct() {
	this.dispatch_set_prop('widget_cssclass',
		rt.new_string('woocommerce widget_layered_nav woocommerce-widget-layered-nav'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [
		rt.new_string('Display a list of attributes to filter products in your store.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_layered_nav'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [
		rt.new_string('Filter Products by Attribute'),
		rt.new_string('woocommerce'),
	]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Layered_Nav) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	this.init_settings()
	return this.Class_WC_Widget.update(var_new_instance.clone(), var_old_instance.clone())
}

fn (mut this Class_WC_Widget_Layered_Nav) form(var_instance rt.PhpVal) {
	this.init_settings()
	this.Class_WC_Widget.form(var_instance.clone())
}

fn (mut this Class_WC_Widget_Layered_Nav) init_settings() {
	mut var_attribute_array := rt.new_array()
	mut var_std_attribute := rt.new_string('')
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		mut iter_1 := var_attribute_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			if rt.is_true(rt.call_function('taxonomy_exists', [
				rt.call_function('wc_attribute_taxonomy_name', [
					rt.get_property(var_tax, 'attribute_name'),
				]),
			]))
			{
				var_attribute_array.array_set(rt.get_property(var_tax, 'attribute_name'), rt.get_property(var_tax,
					'attribute_name'))
			}
		}
		var_std_attribute = rt.call_function('current', [var_attribute_array.clone()])
	}
	this.dispatch_set_prop('settings', rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'std', val: rt.call_function('__', [
				rt.new_string('Filter by'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Title'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'attribute', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'std', val: var_std_attribute },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Attribute'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'options', val: var_attribute_array },
		]) },
		rt.ArrayItem{ key: 'display_type', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'std', val: 'list' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Display type'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'list', val: rt.call_function('__', [
					rt.new_string('List'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'dropdown', val: rt.call_function('__', [
					rt.new_string('Dropdown'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'query_type', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'std', val: 'and' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Query type'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'and', val: rt.call_function('__', [
					rt.new_string('AND'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'or', val: rt.call_function('__', [
					rt.new_string('OR'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
	]))
}

fn (mut this Class_WC_Widget_Layered_Nav) get_instance_taxonomy(var_instance rt.PhpVal) string {
	if var_instance.array_isset(rt.new_string('attribute')) {
		return (rt.call_function('wc_attribute_taxonomy_name', [
			var_instance.array_get(rt.new_string('attribute')),
		])).str()
	}
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		mut iter_2 := var_attribute_taxonomies.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tax := item_2.val
			if rt.is_true(rt.call_function('taxonomy_exists', [
				rt.call_function('wc_attribute_taxonomy_name', [
					rt.get_property(var_tax, 'attribute_name'),
				]),
			]))
			{
				return (rt.call_function('wc_attribute_taxonomy_name', [
					rt.get_property(var_tax, 'attribute_name'),
				])).str()
			}
		}
	}
	return ''
}

fn (mut this Class_WC_Widget_Layered_Nav) get_instance_query_type(var_instance rt.PhpVal) rt.PhpVal {
	return if var_instance.array_isset(rt.new_string('query_type')) {
		var_instance.array_get(rt.new_string('query_type'))
	} else {
		rt.new_string('and')
	}
}

fn (mut this Class_WC_Widget_Layered_Nav) get_instance_display_type(var_instance rt.PhpVal) rt.PhpVal {
	return if var_instance.array_isset(rt.new_string('display_type')) {
		var_instance.array_get(rt.new_string('display_type'))
	} else {
		rt.new_string('list')
	}
}

fn (mut this Class_WC_Widget_Layered_Nav) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))) {
		return
	}
	mut iife_temp_0 := Class_WC_Query{}
	mut iife_result_0 := iife_temp_0.get_layered_nav_chosen_attributes()
	mut var__chosen_attributes := iife_result_0
	mut var_taxonomy := rt.new_string(this.get_instance_taxonomy(var_instance.clone()))
	mut var_query_type := this.get_instance_query_type(var_instance.clone())
	mut var_display_type := this.get_instance_display_type(var_instance.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [
		var_taxonomy.clone(),
	])))))
	{
		return
	}
	mut var_terms := rt.call_function('get_terms', [var_taxonomy.clone(),
		rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: '1' }])])
	if 0 == var_terms.clone().array_count() {
		return
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	this.widget_start(var_args.clone(), var_instance.clone())
	if rt.is_true(rt.identical(rt.new_string('dropdown'), var_display_type)) {
		rt.call_function('wp_enqueue_script', [rt.new_string('selectWoo')])
		rt.call_function('wp_enqueue_style', [rt.new_string('select2')])
		mut var_found := this.layered_nav_dropdown(var_terms.clone(), var_taxonomy.clone(),
			var_query_type.clone())
	} else {
		var_found = this.layered_nav_list(var_terms.clone(), var_taxonomy.clone(),
			var_query_type.clone())
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

fn (mut this Class_WC_Widget_Layered_Nav) get_current_taxonomy() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'taxonomy')
	} else {
		rt.new_string('')
	}
}

fn (mut this Class_WC_Widget_Layered_Nav) get_current_term_id() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'term_id')
	} else {
		rt.new_int(0)
	}])
}

fn (mut this Class_WC_Widget_Layered_Nav) get_current_term_slug() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) {
		rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'slug')
	} else {
		rt.new_int(0)
	}])
}

fn (mut this Class_WC_Widget_Layered_Nav) layered_nav_dropdown(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	mut var_wp := rt.new_null()
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
	mut var_query_type_mutated := var_query_type
	mut var_found := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_taxonomy_mutated,
		this.get_current_taxonomy()))))
	{
		mut var_term_counts := this.get_filtered_term_product_counts(rt.call_function('wp_list_pluck', [
			var_terms_mutated.clone(),
			rt.new_string('term_id'),
		]), var_taxonomy_mutated.clone(), var_query_type_mutated.clone())
		mut iife_temp_1 := Class_WC_Query{}
		mut iife_result_1 := iife_temp_1.get_layered_nav_chosen_attributes()
		mut var__chosen_attributes := iife_result_1
		mut var_taxonomy_filter_name := rt.call_function('wc_attribute_taxonomy_slug', [
			var_taxonomy_mutated.clone(),
		])
		mut var_taxonomy_label := rt.call_function('wc_attribute_label', [
			var_taxonomy_mutated.clone()])
		mut var_any_label := rt.call_function('apply_filters', [
			rt.new_string('woocommerce_layered_nav_any_label'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Any %s'),
					rt.new_string('woocommerce')]),
				var_taxonomy_label.clone(),
			]),
			var_taxonomy_label.clone(),
			var_taxonomy_mutated.clone(),
		])
		mut var_multiple := rt.identical(rt.new_string('or'), var_query_type_mutated)
		mut var_current_values := if var__chosen_attributes.array_get(var_taxonomy_mutated).array_isset(rt.new_string('terms')) {
			var__chosen_attributes.array_get(var_taxonomy_mutated).array_get(rt.new_string('terms'))
		} else {
			rt.new_array()
		}
		if rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [
			rt.new_string('permalink_structure'),
		])))
		{
			mut var_form_action := rt.call_function('remove_query_arg', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'page' },
					rt.ArrayItem{ key: none, val: 'paged' }]),
				rt.call_function('add_query_arg', [rt.get_property(var_wp, 'query_string'),
					rt.new_string(''),
					rt.call_function('home_url', [
						rt.get_property(var_wp, 'request'),
					])]),
			])
		} else {
			var_form_action = rt.call_function('preg_replace', [
				rt.new_string('%\\/page/[0-9]+%'),
				rt.new_string(''),
				rt.call_function('home_url', [
					rt.call_function('user_trailingslashit', [
						rt.get_property(var_wp, 'request'),
					]),
				]),
			])
		}
		print('<form method="get" action="' +
			(rt.call_function('esc_url', [var_form_action.clone()])).str() +
			'" class="woocommerce-widget-layered-nav-dropdown">')
		print('<select class="woocommerce-widget-layered-nav-dropdown dropdown_layered_nav_' +
			(rt.call_function('esc_attr', [var_taxonomy_filter_name.clone()])).str() + '"' +
			if rt.is_true(var_multiple) { 'multiple="multiple"' } else { '' } + '>')
		print('<option value="">' + (rt.call_function('esc_html', [var_any_label.clone()])).str() +
			'</option>')
		mut iter_3 := var_terms_mutated.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_term := item_3.val
			if rt.is_true(rt.identical(rt.get_property(var_term, 'term_id'),
				this.get_current_term_id()))
			{
				continue
			}
			mut var_option_is_set := rt.call_function('in_array', [
				rt.get_property(var_term, 'slug'),
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
				(rt.call_function('esc_attr', [rt.call_function('urldecode', [rt.get_property(var_term, 'slug')])])).str() +
				'" ' +
				(rt.call_function('selected', [var_option_is_set.clone(), rt.new_bool(true), rt.new_bool(false)])).str() +
				'>' + (rt.call_function('esc_html', [rt.get_property(var_term, 'name')])).str() +
				'</option>')
		}
		print('</select>')
		if rt.is_true(var_multiple) {
			print(
				'<button class="woocommerce-widget-layered-nav-dropdown__submit" type="submit" value="' +
				(rt.call_function('esc_attr__', [rt.new_string('Apply'), rt.new_string('woocommerce')])).str() +
				'">' +
				(rt.call_function('esc_html__', [rt.new_string('Apply'), rt.new_string('woocommerce')])).str() +
				'</button>')
		}
		if rt.is_true(rt.identical(rt.new_string('or'), var_query_type_mutated)) {
			print('<input type="hidden" name="query_type_' +
				(rt.call_function('esc_attr', [var_taxonomy_filter_name.clone()])).str() +
				'" value="or" />')
		}
		print('<input type="hidden" name="filter_' +
			(rt.call_function('esc_attr', [var_taxonomy_filter_name.clone()])).str() + '" value="' +
			(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(','), var_current_values.clone()])])).str() +
			'" />')
		rt.echo_val(rt.call_function('wc_query_string_form_fields', [
			rt.new_null(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'filter_' + var_taxonomy_filter_name.str() },
				rt.ArrayItem{ key: none, val: 'query_type_' + var_taxonomy_filter_name.str() },
			]),
			rt.new_string(''), rt.new_bool(true)]))
		print('</form>')
		mut var_handle := rt.new_string('wc-widget-dropdown-layered-nav-' +
			var_taxonomy_filter_name.str())
		rt.call_function('wp_register_script', [var_handle.clone(),
			rt.new_string(''),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' },
				rt.ArrayItem{ key: none, val: 'selectWoo' }]),
			rt.get_constant('WC_VERSION'),
			rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
		rt.call_function('wp_enqueue_script', [var_handle.clone()])
		rt.call_function('wp_add_inline_script', [var_handle.clone(),
			rt.new_string(
				"\n\t\t\t\t\t// Update value on change.\n\t\t\t\t\tjQuery( '.dropdown_layered_nav_" +
				(rt.call_function('esc_js', [var_taxonomy_filter_name.clone()])).str() +
				'\' ).on( \'change\', function() {\n\t\t\t\t\t\tvar slug = jQuery( this ).val();\n\t\t\t\t\t\tjQuery( \':input[name="filter_' +
				(rt.call_function('esc_js', [var_taxonomy_filter_name.clone()])).str() +
				'"]\' ).val( slug );\n\n\t\t\t\t\t\t// Submit form on change if standard dropdown.\n\t\t\t\t\t\tif ( ! jQuery( this ).attr( \'multiple\' ) ) {\n\t\t\t\t\t\t\tjQuery( this ).closest( \'form\' ).trigger( \'submit\' );\n\t\t\t\t\t\t}\n\t\t\t\t\t});\n\n\t\t\t\t\t// Use Select2 enhancement if possible\n\t\t\t\t\tif ( jQuery().selectWoo ) {\n\t\t\t\t\t\tvar wc_layered_nav_select = function() {\n\t\t\t\t\t\t\tjQuery( \'.dropdown_layered_nav_' +
				(rt.call_function('esc_js', [var_taxonomy_filter_name.clone()])).str() +
				"' ).selectWoo( {\n\t\t\t\t\t\t\t\tplaceholder: decodeURIComponent('" +
				(rt.call_function('rawurlencode', [rt.new_string((rt.call_function('wp_specialchars_decode', [var_any_label.clone()])).str())])).str() +
				"'),\n\t\t\t\t\t\t\t\tminimumResultsForSearch: 5,\n\t\t\t\t\t\t\t\twidth: '100%',\n\t\t\t\t\t\t\t\tallowClear: " +
				if rt.is_true(var_multiple) { 'false' } else { 'true' } +
				",\n\t\t\t\t\t\t\t\tlanguage: {\n\t\t\t\t\t\t\t\t\tnoResults: function() {\n\t\t\t\t\t\t\t\t\t\treturn '" +
				(rt.call_function('esc_js', [rt.call_function('_x', [rt.new_string('No matches found'), rt.new_string('enhanced select'), rt.new_string('woocommerce')])])).str() +
				"';\n\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t} );\n\t\t\t\t\t\t};\n\t\t\t\t\t\twc_layered_nav_select();\n\t\t\t\t\t}\n\t\t\t\t")])
	}
	return var_found.clone()
}

fn (mut this Class_WC_Widget_Layered_Nav) get_filtered_term_product_counts(var_term_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_query_type_mutated := var_query_type
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer.class(),
	]), 'get_filtered_term_product_counts', [var_term_ids.clone(),
		var_taxonomy_mutated.clone(), var_query_type_mutated.clone()])
}

fn (mut this Class_WC_Widget_Layered_Nav) get_main_tax_query() rt.PhpVal {
	mut iife_temp_2 := Class_WC_Query{}
	mut iife_result_2 := iife_temp_2.get_main_tax_query()
	return iife_result_2
}

fn (mut this Class_WC_Widget_Layered_Nav) get_main_search_query_sql() rt.PhpVal {
	mut iife_temp_3 := Class_WC_Query{}
	mut iife_result_3 := iife_temp_3.get_main_search_query_sql()
	return iife_result_3
}

fn (mut this Class_WC_Widget_Layered_Nav) get_main_meta_query() rt.PhpVal {
	mut iife_temp_4 := Class_WC_Query{}
	mut iife_result_4 := iife_temp_4.get_main_meta_query()
	return iife_result_4
}

fn (mut this Class_WC_Widget_Layered_Nav) layered_nav_list(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
	mut var_query_type_mutated := var_query_type
	print('<ul class="woocommerce-widget-layered-nav-list">')
	mut var_term_counts := this.get_filtered_term_product_counts(rt.call_function('wp_list_pluck', [
		var_terms_mutated.clone(),
		rt.new_string('term_id'),
	]), var_taxonomy_mutated.clone(), var_query_type_mutated.clone())
	mut iife_temp_5 := Class_WC_Query{}
	mut iife_result_5 := iife_temp_5.get_layered_nav_chosen_attributes()
	mut var__chosen_attributes := iife_result_5
	mut var_found := rt.new_bool(false)
	mut var_base_link := this.get_current_page_url()
	mut iter_4 := var_terms_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_term := item_4.val
		mut var_current_values := if var__chosen_attributes.array_get(var_taxonomy_mutated).array_isset(rt.new_string('terms')) {
			var__chosen_attributes.array_get(var_taxonomy_mutated).array_get(rt.new_string('terms'))
		} else {
			rt.new_array()
		}
		mut var_option_is_set := rt.call_function('in_array', [
			rt.get_property(var_term, 'slug'),
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
		mut var_filter_name := rt.new_string('filter_' +
			(rt.call_function('wc_attribute_taxonomy_slug', [var_taxonomy_mutated.clone()])).str())
		mut var_current_filter := if rt.get_superglobal('_GET').array_isset(var_filter_name) { rt.call_function('explode', [
				rt.new_string(','),
				rt.call_function('wc_clean', [
					rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(var_filter_name)]),
				]),
			]) } else { rt.new_array() }
		var_current_filter = rt.call_function('array_map', [
			rt.new_string('sanitize_title'),
			var_current_filter.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_term, 'slug'),
			var_current_filter.clone(),
			rt.new_bool(true),
		])))))
		{
			var_current_filter.array_push(rt.get_property(var_term, 'slug'))
		}
		mut var_link := rt.call_function('remove_query_arg', [
			var_filter_name.clone(), var_base_link.clone()])
		mut iter_5 := var_current_filter.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_value := item_5.val
			mut var_key := item_5.key
			if rt.is_true(rt.identical(var_value, this.get_current_term_slug())) {
				var_current_filter.array_unset(var_key)
			}
			if rt.is_true(var_option_is_set)
				&& rt.is_true(rt.identical(var_value, rt.get_property(var_term, 'slug'))) {
				var_current_filter.array_unset(var_key)
			}
		}
		if !(!rt.is_true(var_current_filter)) {
			rt.call_function('asort', [var_current_filter.clone()])
			var_link = rt.call_function('add_query_arg', [var_filter_name.clone(),
				rt.call_function('implode', [rt.new_string(','),
					var_current_filter.clone()]),
				var_link.clone()])
			if rt.is_true(rt.identical(rt.new_string('or'), var_query_type_mutated))
				&& !(1 == var_current_filter.clone().array_count() && rt.is_true(var_option_is_set)) {
				var_link = rt.call_function('add_query_arg', [
					rt.new_string('query_type_' +(rt.call_function('wc_attribute_taxonomy_slug', [var_taxonomy_mutated.clone()])).str()),
					rt.new_string('or'),
					var_link.clone(),
				])
			}
			var_link = rt.call_function('str_replace', [rt.new_string('%2C'),
				rt.new_string(','), var_link.clone()])
		}
		if rt.is_true(rt.greater(var_count, rt.new_int(0))) || rt.is_true(var_option_is_set) {
			var_link = rt.call_function('apply_filters', [
				rt.new_string('woocommerce_layered_nav_link'),
				var_link.clone(),
				var_term.clone(),
				var_taxonomy_mutated.clone(),
			])
			mut var_term_html := rt.new_string('<a rel="nofollow" href="' +
				(rt.call_function('esc_url', [var_link.clone()])).str() + '">' +
				(rt.call_function('esc_html', [rt.get_property(var_term, 'name')])).str() + '</a>')
		} else {
			var_link = rt.new_bool(false)
			var_term_html = rt.new_string('<span>' +
				(rt.call_function('esc_html', [rt.get_property(var_term, 'name')])).str() +
				'</span>')
		}
		var_term_html = rt.concat(var_term_html, rt.new_string(' ' +
			(rt.call_function('apply_filters', [rt.new_string('woocommerce_layered_nav_count'), rt.new_string('<span class="count">(' + (rt.call_function('absint', [var_count.clone()])).str() +
			')</span>'), var_count.clone(), var_term.clone()])).str()))
		print('<li class="woocommerce-widget-layered-nav-list__item wc-layered-nav-term ' +
			if rt.is_true(var_option_is_set) { 'woocommerce-widget-layered-nav-list__item--chosen chosen' } else { '' } +
			'">')
		rt.echo_val(rt.call_function('apply_filters', [
			rt.new_string('woocommerce_layered_nav_term_html'),
			var_term_html.clone(),
			var_term.clone(),
			var_link.clone(),
			var_count.clone(),
		]))
		print('</li>')
	}
	print('</ul>')
	return var_found.clone()
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

fn create_wc_widget_layered_nav() &Class_WC_Widget_Layered_Nav {
	mut obj := &Class_WC_Widget_Layered_Nav{
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

fn (mut this Class_WC_Widget_Layered_Nav) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
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
		'init_settings' {
			this.init_settings()
			return rt.new_null()
		}
		'get_instance_taxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_instance_taxonomy(dispatch_arg_0))
		}
		'get_instance_query_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_instance_query_type(dispatch_arg_0)
		}
		'get_instance_display_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_instance_display_type(dispatch_arg_0)
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
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
		'layered_nav_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.layered_nav_dropdown(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_filtered_term_product_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_filtered_term_product_counts(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'get_main_tax_query' {
			return this.get_main_tax_query()
		}
		'get_main_search_query_sql' {
			return this.get_main_search_query_sql()
		}
		'get_main_meta_query' {
			return this.get_main_meta_query()
		}
		'layered_nav_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.layered_nav_list(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Widget_Layered_Nav) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Layered_Nav) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
