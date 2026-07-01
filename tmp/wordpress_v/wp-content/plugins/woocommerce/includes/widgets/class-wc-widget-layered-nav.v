import rt

struct Class_WC_Widget_Layered_Nav {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Layered_Nav) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_layered_nav woocommerce-widget-layered-nav'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Display a list of attributes to filter products in your store.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_layered_nav'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Filter Products by Attribute'), rt.new_string('woocommerce')]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Layered_Nav) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	this.init_settings()
	return this.Class_WC_Widget.update(var_new_instance.dup(), var_old_instance.dup())
}

fn (mut this Class_WC_Widget_Layered_Nav) form(var_instance rt.PhpVal)  {
	this.init_settings()
	this.Class_WC_Widget.form(var_instance.dup())
}

fn (mut this Class_WC_Widget_Layered_Nav) init_settings()  {
	mut var_attribute_array := rt.new_array()
	mut var_std_attribute := rt.new_string(rt.new_string(''))
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		{
			mut iter_1 := var_attribute_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax := item_1.val
				if rt.is_true(rt.call_function('taxonomy_exists', [rt.call_function('wc_attribute_taxonomy_name', [rt.get_property(var_tax, 'attribute_name')])])) {
					var_attribute_array.array_set(rt.get_property(var_tax, 'attribute_name'), rt.get_property(var_tax, 'attribute_name'))
				}
			}
		}
		var_std_attribute = rt.call_function('current', [var_attribute_array.dup()])
	}
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Filter by'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'attribute', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'std', val: var_std_attribute }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Attribute'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: var_attribute_array }]) }, rt.ArrayItem{ key: 'display_type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'std', val: 'list' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Display type'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'list', val: rt.call_function('__', [rt.new_string('List'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'dropdown', val: rt.call_function('__', [rt.new_string('Dropdown'), rt.new_string('woocommerce')]) }]) }]) }, rt.ArrayItem{ key: 'query_type', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'std', val: 'and' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Query type'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'and', val: rt.call_function('__', [rt.new_string('AND'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'or', val: rt.call_function('__', [rt.new_string('OR'), rt.new_string('woocommerce')]) }]) }]) }]))
}

fn (mut this Class_WC_Widget_Layered_Nav) get_instance_taxonomy(var_instance rt.PhpVal) string {
	if var_instance.array_isset(rt.new_string('attribute')) {
		return (rt.call_function('wc_attribute_taxonomy_name', [var_instance.array_get('attribute')])).str()
	}
	mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
	if !(!rt.is_true(var_attribute_taxonomies)) {
		{
			mut iter_1 := var_attribute_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tax := item_1.val
				if rt.is_true(rt.call_function('taxonomy_exists', [rt.call_function('wc_attribute_taxonomy_name', [rt.get_property(var_tax, 'attribute_name')])])) {
					return (rt.call_function('wc_attribute_taxonomy_name', [rt.get_property(var_tax, 'attribute_name')])).str()
				}
			}
		}
	}
	return ''
}

fn (mut this Class_WC_Widget_Layered_Nav) get_instance_query_type(var_instance rt.PhpVal) rt.PhpVal {
	return if var_instance.array_isset(rt.new_string('query_type')) { var_instance.array_get('query_type') } else { rt.new_string('and') }
}

fn (mut this Class_WC_Widget_Layered_Nav) get_instance_display_type(var_instance rt.PhpVal) rt.PhpVal {
	return if var_instance.array_isset(rt.new_string('display_type')) { var_instance.array_get('display_type') } else { rt.new_string('list') }
}

fn (mut this Class_WC_Widget_Layered_Nav) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	mut var__chosen_attributes := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }()
	mut var_taxonomy := rt.new_string(this.get_instance_taxonomy(var_instance.dup()))
	mut var_query_type := this.get_instance_query_type(var_instance.dup())
	mut var_display_type := this.get_instance_display_type(var_instance.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('taxonomy_exists', [var_taxonomy.dup()]))))) {
		return rt.new_null()
	}
	mut var_terms := rt.call_function('get_terms', [var_taxonomy.dup(), rt.create_array([rt.ArrayItem{ key: 'hide_empty', val: '1' }])])
	if 0 == var_terms.dup().array_count() {
		return rt.new_null()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	this.widget_start(var_args.dup(), var_instance.dup())
	if rt.is_true(rt.identical(rt.new_string('dropdown'), var_display_type)) {
		rt.call_function('wp_enqueue_script', [rt.new_string('selectWoo')])
		rt.call_function('wp_enqueue_style', [rt.new_string('select2')])
		mut var_found := this.layered_nav_dropdown(var_terms.dup(), var_taxonomy.dup(), var_query_type.dup())
	} else {
		var_found = this.layered_nav_list(var_terms.dup(), var_taxonomy.dup(), var_query_type.dup())
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

fn (mut this Class_WC_Widget_Layered_Nav) get_current_taxonomy() rt.PhpVal {
	return if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'taxonomy') } else { rt.new_string('') }
}

fn (mut this Class_WC_Widget_Layered_Nav) get_current_term_id() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'term_id') } else { rt.new_int(0) }])
}

fn (mut this Class_WC_Widget_Layered_Nav) get_current_term_slug() rt.PhpVal {
	return rt.call_function('absint', [if rt.is_true(rt.call_function('is_tax', []rt.PhpVal{})) { rt.get_property(rt.call_function('get_queried_object', []rt.PhpVal{}), 'slug') } else { rt.new_int(0) }])
}

fn (mut this Class_WC_Widget_Layered_Nav) layered_nav_dropdown(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	mut var_wp := rt.new_null()
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
	mut var_query_type_mutated := var_query_type
	// unsupported statement: Stmt_Global
	mut var_found := rt.new_bool(rt.new_bool(false))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_term_counts := this.get_filtered_term_product_counts(rt.call_function('wp_list_pluck', [var_terms_mutated.dup(), rt.new_string('term_id')]), var_taxonomy_mutated.dup(), var_query_type_mutated.dup())
		mut var__chosen_attributes := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }()
		mut var_taxonomy_filter_name := rt.call_function('wc_attribute_taxonomy_slug', [var_taxonomy_mutated.dup()])
		mut var_taxonomy_label := rt.call_function('wc_attribute_label', [var_taxonomy_mutated.dup()])
		mut var_any_label := rt.call_function('apply_filters', [rt.new_string('woocommerce_layered_nav_any_label'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Any %s'), rt.new_string('woocommerce')]), var_taxonomy_label.dup()]), var_taxonomy_label.dup(), var_taxonomy_mutated.dup()])
		mut var_multiple := rt.identical(rt.new_string('or'), var_query_type_mutated)
		mut var_current_values := if var__chosen_attributes.array_get(var_taxonomy_mutated).array_isset(rt.new_string('terms')) { var__chosen_attributes.array_get(var_taxonomy_mutated).array_get('terms') } else { rt.new_array() }
		if rt.is_true(rt.identical(rt.new_string(''), rt.call_function('get_option', [rt.new_string('permalink_structure')]))) {
			mut var_form_action := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'paged' }]), rt.call_function('add_query_arg', [rt.get_property(var_wp, 'query_string'), rt.new_string(''), rt.call_function('home_url', [rt.get_property(var_wp, 'request')])])])
		} else {
			var_form_action = rt.call_function('preg_replace', [rt.new_string('%\\/page/[0-9]+%'), rt.new_string(''), rt.call_function('home_url', [rt.call_function('user_trailingslashit', [rt.get_property(var_wp, 'request')])])])
		}
		print('<form method="get" action="' + (rt.call_function('esc_url', [var_form_action.dup()])).str() + '" class="woocommerce-widget-layered-nav-dropdown">')
		print('<select class="woocommerce-widget-layered-nav-dropdown dropdown_layered_nav_' + (rt.call_function('esc_attr', [var_taxonomy_filter_name.dup()])).str() + '"' + if rt.is_true(var_multiple) { 'multiple="multiple"' } else { '' } + '>')
		print('<option value="">' + (rt.call_function('esc_html', [var_any_label.dup()])).str() + '</option>')
		{
			mut iter_1 := var_terms_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_term := item_1.val
				if rt.is_true(rt.identical(rt.get_property(var_term, 'term_id'), this.get_current_term_id())) {
					continue
				}
				mut var_option_is_set := rt.call_function('in_array', [rt.get_property(var_term, 'slug'), var_current_values.dup(), rt.new_bool(true)])
				mut var_count := if var_term_counts.array_isset(rt.get_property(var_term, 'term_id')) { var_term_counts.array_get(rt.get_property(var_term, 'term_id')) } else { rt.new_int(0) }
				if rt.is_true(rt.less(rt.new_int(0), var_count)) {
					var_found = rt.new_bool(rt.new_bool(true))
				} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_count)) && rt.is_true(rt.new_bool(!(rt.is_true(var_option_is_set)))))) {
					continue
				}
				print('<option value="' + (rt.call_function('esc_attr', [rt.call_function('urldecode', [rt.get_property(var_term, 'slug')])])).str() + '" ' + (rt.call_function('selected', [var_option_is_set.dup(), rt.new_bool(true), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [rt.get_property(var_term, 'name')])).str() + '</option>')
			}
		}
		print('</select>')
		if rt.is_true(var_multiple) {
			print('<button class="woocommerce-widget-layered-nav-dropdown__submit" type="submit" value="' + (rt.call_function('esc_attr__', [rt.new_string('Apply'), rt.new_string('woocommerce')])).str() + '">' + (rt.call_function('esc_html__', [rt.new_string('Apply'), rt.new_string('woocommerce')])).str() + '</button>')
		}
		if rt.is_true(rt.identical(rt.new_string('or'), var_query_type_mutated)) {
			print('<input type="hidden" name="query_type_' + (rt.call_function('esc_attr', [var_taxonomy_filter_name.dup()])).str() + '" value="or" />')
		}
		print('<input type="hidden" name="filter_' + (rt.call_function('esc_attr', [var_taxonomy_filter_name.dup()])).str() + '" value="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(','), var_current_values.dup()])])).str() + '" />')
		rt.echo_val(rt.call_function('wc_query_string_form_fields', [rt.new_null(), rt.create_array([rt.ArrayItem{ key: none, val: 'filter_' + (var_taxonomy_filter_name).str() }, rt.ArrayItem{ key: none, val: 'query_type_' + (var_taxonomy_filter_name).str() }]), rt.new_string(''), rt.new_bool(true)]))
		print('</form>')
		mut var_handle := rt.new_string('wc-widget-dropdown-layered-nav-' + (var_taxonomy_filter_name).str())
		rt.call_function('wp_register_script', [var_handle.dup(), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'selectWoo' }]), rt.get_constant('WC_VERSION'), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
		rt.call_function('wp_enqueue_script', [var_handle.dup()])
		rt.call_function('wp_add_inline_script', [var_handle.dup(), '\n\t\t\t\t\t// Update value on change.\n\t\t\t\t\tjQuery( \'.dropdown_layered_nav_' + (rt.call_function('esc_js', [var_taxonomy_filter_name.dup()])).str() + '\' ).on( \'change\', function() {\n\t\t\t\t\t\tvar slug = jQuery( this ).val();\n\t\t\t\t\t\tjQuery( \':input[name="filter_' + (rt.call_function('esc_js', [var_taxonomy_filter_name.dup()])).str() + '"]\' ).val( slug );\n\n\t\t\t\t\t\t// Submit form on change if standard dropdown.\n\t\t\t\t\t\tif ( ! jQuery( this ).attr( \'multiple\' ) ) {\n\t\t\t\t\t\t\tjQuery( this ).closest( \'form\' ).trigger( \'submit\' );\n\t\t\t\t\t\t}\n\t\t\t\t\t});\n\n\t\t\t\t\t// Use Select2 enhancement if possible\n\t\t\t\t\tif ( jQuery().selectWoo ) {\n\t\t\t\t\t\tvar wc_layered_nav_select = function() {\n\t\t\t\t\t\t\tjQuery( \'.dropdown_layered_nav_' + (rt.call_function('esc_js', [var_taxonomy_filter_name.dup()])).str() + '\' ).selectWoo( {\n\t\t\t\t\t\t\t\tplaceholder: decodeURIComponent(\'' + (rt.call_function('rawurlencode', [// unsupported expression: Expr_Cast_String])).str() + '\'),\n\t\t\t\t\t\t\t\tminimumResultsForSearch: 5,\n\t\t\t\t\t\t\t\twidth: \'100%\',\n\t\t\t\t\t\t\t\tallowClear: ' + if rt.is_true(var_multiple) { 'false' } else { 'true' } + ',\n\t\t\t\t\t\t\t\tlanguage: {\n\t\t\t\t\t\t\t\t\tnoResults: function() {\n\t\t\t\t\t\t\t\t\t\treturn \'' + (rt.call_function('esc_js', [rt.call_function('_x', [rt.new_string('No matches found'), rt.new_string('enhanced select'), rt.new_string('woocommerce')])])).str() + '\';\n\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t} );\n\t\t\t\t\t\t};\n\t\t\t\t\t\twc_layered_nav_select();\n\t\t\t\t\t}\n\t\t\t\t'])
	}
	return var_found.dup()
}

fn (mut this Class_WC_Widget_Layered_Nav) get_filtered_term_product_counts(var_term_ids rt.PhpVal, var_taxonomy rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_query_type_mutated := var_query_type
	return rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Filterer.class()]), 'get_filtered_term_product_counts', [var_term_ids.dup(), var_taxonomy_mutated.dup(), var_query_type_mutated.dup()])
}

fn (mut this Class_WC_Widget_Layered_Nav) get_main_tax_query() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_main_tax_query() }()
}

fn (mut this Class_WC_Widget_Layered_Nav) get_main_search_query_sql() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_main_search_query_sql() }()
}

fn (mut this Class_WC_Widget_Layered_Nav) get_main_meta_query() rt.PhpVal {
	return fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_main_meta_query() }()
}

fn (mut this Class_WC_Widget_Layered_Nav) layered_nav_list(var_terms rt.PhpVal, var_taxonomy rt.PhpVal, var_query_type rt.PhpVal) rt.PhpVal {
	mut var_terms_mutated := var_terms
	mut var_taxonomy_mutated := var_taxonomy
	mut var_query_type_mutated := var_query_type
	print('<ul class="woocommerce-widget-layered-nav-list">')
	mut var_term_counts := this.get_filtered_term_product_counts(rt.call_function('wp_list_pluck', [var_terms_mutated.dup(), rt.new_string('term_id')]), var_taxonomy_mutated.dup(), var_query_type_mutated.dup())
	mut var__chosen_attributes := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }()
	mut var_found := rt.new_bool(rt.new_bool(false))
	mut var_base_link := this.get_current_page_url()
	{
		mut iter_1 := var_terms_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_current_values := if var__chosen_attributes.array_get(var_taxonomy_mutated).array_isset(rt.new_string('terms')) { var__chosen_attributes.array_get(var_taxonomy_mutated).array_get('terms') } else { rt.new_array() }
			mut var_option_is_set := rt.call_function('in_array', [rt.get_property(var_term, 'slug'), var_current_values.dup(), rt.new_bool(true)])
			mut var_count := if var_term_counts.array_isset(rt.get_property(var_term, 'term_id')) { var_term_counts.array_get(rt.get_property(var_term, 'term_id')) } else { rt.new_int(0) }
			if rt.is_true(rt.identical(this.get_current_term_id(), rt.get_property(var_term, 'term_id'))) {
				continue
			}
			if rt.is_true(rt.less(rt.new_int(0), var_count)) {
				var_found = rt.new_bool(rt.new_bool(true))
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_count)) && rt.is_true(rt.new_bool(!(rt.is_true(var_option_is_set)))))) {
				continue
			}
			mut var_filter_name := rt.new_string('filter_' + (rt.call_function('wc_attribute_taxonomy_slug', [.dup()])).str())
			mut var_current_filter := if .array_isset() {  } else {  }
			var_current_filter = 
			if rt.is_true() {
			}
			
		}
	}
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
			return this.get_filtered_term_product_counts(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
		else { return none }
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_layered_nav_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
