import rt

struct Class_WC_Widget_Product_Categories {
	rt.PhpObjectBase
pub mut:
		cat_ancestors rt.PhpVal = rt.new_null()
		current_cat rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Widget_Product_Categories) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_product_categories'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('A list or dropdown of product categories.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_product_categories'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Product Categories'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Product categories'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'std', val: 'name' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Order by'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'order', val: rt.call_function('__', [rt.new_string('Category order'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Name'), rt.new_string('woocommerce')]) }]) }]) }, rt.ArrayItem{ key: 'dropdown', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 0 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Show as dropdown'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'count', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 0 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Show product counts'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'hierarchical', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 1 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Show hierarchy'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'show_children_only', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 0 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Only show children of the current category'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'hide_empty', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'std', val: 0 }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Hide empty categories'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'max_depth', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: '' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Maximum depth'), rt.new_string('woocommerce')]) }]) }]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Product_Categories) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_wp_query := rt.new_null()
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_count := if var_instance.array_isset(rt.new_string('count')) { var_instance.array_get('count') } else { rt.get_property(rt.new_object('WC_Widget_Product_Categories', ['WC_Widget'], &this), 'settings').array_get('count').array_get('std') }
	mut var_hierarchical := if var_instance.array_isset(rt.new_string('hierarchical')) { var_instance.array_get('hierarchical') } else { rt.get_property(rt.new_object('WC_Widget_Product_Categories', ['WC_Widget'], &this), 'settings').array_get('hierarchical').array_get('std') }
	mut var_show_children_only := if var_instance.array_isset(rt.new_string('show_children_only')) { var_instance.array_get('show_children_only') } else { rt.get_property(rt.new_object('WC_Widget_Product_Categories', ['WC_Widget'], &this), 'settings').array_get('show_children_only').array_get('std') }
	mut var_dropdown := if var_instance.array_isset(rt.new_string('dropdown')) { var_instance.array_get('dropdown') } else { rt.get_property(rt.new_object('WC_Widget_Product_Categories', ['WC_Widget'], &this), 'settings').array_get('dropdown').array_get('std') }
	mut var_orderby := if var_instance.array_isset(rt.new_string('orderby')) { var_instance.array_get('orderby') } else { rt.get_property(rt.new_object('WC_Widget_Product_Categories', ['WC_Widget'], &this), 'settings').array_get('orderby').array_get('std') }
	mut var_hide_empty := if var_instance.array_isset(rt.new_string('hide_empty')) { var_instance.array_get('hide_empty') } else { rt.get_property(rt.new_object('WC_Widget_Product_Categories', ['WC_Widget'], &this), 'settings').array_get('hide_empty').array_get('std') }
	mut var_dropdown_args := { 'hide_empty': var_hide_empty }
	mut var_list_args := { 'show_count': var_count, 'hierarchical': var_hierarchical, 'taxonomy': rt.new_string('product_cat'), 'hide_empty': var_hide_empty }
	mut var_max_depth := rt.call_function('absint', [if var_instance.array_isset(rt.new_string('max_depth')) { var_instance.array_get('max_depth') } else { rt.get_property(rt.new_object('WC_Widget_Product_Categories', ['WC_Widget'], &this), 'settings').array_get('max_depth').array_get('std') }])
	var_list_args['menu_order'] = rt.new_bool(false)
	var_dropdown_args['depth'] = var_max_depth.dup()
	var_list_args['depth'] = var_max_depth.dup()
	if rt.is_true(rt.identical(rt.new_string('order'), var_orderby)) {
		var_list_args['orderby'] = rt.new_string('meta_value_num')
		var_dropdown_args['orderby'] = rt.new_string('meta_value_num')
		var_list_args['meta_key'] = rt.new_string('order')
		var_dropdown_args['meta_key'] = rt.new_string('order')
	}
	this.current_cat = rt.new_bool(false)
	this.cat_ancestors = rt.new_array()
	if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_cat')])) {
		this.current_cat = rt.get_property(var_wp_query, 'queried_object')
		this.cat_ancestors = rt.call_function('get_ancestors', [rt.get_property(this.current_cat, 'term_id'), rt.new_string('product_cat')])
	} else if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		mut var_terms := rt.call_function('wc_get_product_terms', [rt.get_property(var_post, 'ID'), rt.new_string('product_cat'), rt.call_function('apply_filters', [rt.new_string('woocommerce_product_categories_widget_product_terms_args'), rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'parent' }, rt.ArrayItem{ key: 'order', val: 'DESC' }])])])
		if rt.is_true(var_terms) {
			mut var_main_term := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_categories_widget_main_term'), var_terms.array_get(0), var_terms.dup()])
			this.current_cat = var_main_term.dup()
			this.cat_ancestors = rt.call_function('get_ancestors', [rt.get_property(var_main_term, 'term_id'), rt.new_string('product_cat')])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_show_children_only) && rt.is_true(this.current_cat))) {
		if rt.is_true(var_hierarchical) {
			mut var_include := rt.call_function('array_merge', [this.cat_ancestors, rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(this.current_cat, 'term_id') }]), rt.call_function('get_terms', [rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'parent', val: 0 }, rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'hide_empty', val: false }])]), rt.call_function('get_terms', [rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'parent', val: rt.get_property(this.current_cat, 'term_id') }, rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'hide_empty', val: false }])])])
			if rt.is_true(this.cat_ancestors) {
				{
					mut iter_1 := this.cat_ancestors.iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_ancestor := item_1.val
						var_include = rt.call_function('array_merge', [var_include.dup(), rt.call_function('get_terms', [rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'parent', val: var_ancestor }, rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{ key: 'hide_empty', val: false }])])])
					}
				}
			}
		} else {
			var_include = rt.call_function('get_terms', [rt.new_string('product_cat'), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'parent', val: rt.get_property(this.current_cat, 'term_id') }, rt.ArrayItem{ key: 'hierarchical', val: true }, rt.ArrayItem{ key: 'hide_empty', val: false }])])
		}
		var_list_args['include'] = rt.call_function('implode', [rt.new_string(','), var_include.dup()])
		var_dropdown_args['include'] = var_list_args.array_get('include')
		if !rt.is_true(var_include) {
			return rt.new_null()
		}
	} else if rt.is_true(var_show_children_only) {
		var_dropdown_args['depth'] = rt.new_int(1)
		var_dropdown_args['child_of'] = rt.new_int(0)
		var_dropdown_args['hierarchical'] = rt.new_int(1)
		var_list_args['depth'] = rt.new_int(1)
		var_list_args['child_of'] = rt.new_int(0)
		var_list_args['hierarchical'] = rt.new_int(1)
	}
	this.widget_start(var_args.dup(), var_instance.dup())
	if rt.is_true(var_dropdown) {
		rt.call_function('wc_product_dropdown_categories', [rt.call_function('apply_filters', [rt.new_string('woocommerce_product_categories_widget_dropdown_args'), rt.call_function('wp_parse_args', [var_dropdown_args.dup(), rt.create_array([rt.ArrayItem{ key: 'show_count', val: var_count }, rt.ArrayItem{ key: 'hierarchical', val: var_hierarchical }, rt.ArrayItem{ key: 'show_uncategorized', val: 0 }, rt.ArrayItem{ key: 'selected', val: if rt.is_true(this.current_cat) { rt.get_property(this.current_cat, 'slug') } else { rt.new_string('') } }])])])])
		mut var_handle := rt.new_string(rt.new_string('wc-product-category-dropdown-widget'))
		rt.call_function('wp_register_script', [var_handle.dup(), rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }, rt.ArrayItem{ key: none, val: 'selectWoo' }]), rt.get_constant('WC_VERSION'), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
		rt.call_function('wp_enqueue_style', [rt.new_string('select2')])
		rt.call_function('wp_enqueue_script', [var_handle.dup()])
		rt.call_function('wp_add_inline_script', [var_handle.dup(), '\n\t\t\t\t\tjQuery( \'.dropdown_product_cat\' ).on( \'change\', function() {\n\t\t\t\t\t\tconst categoryValue = jQuery(this).val();\n\n\t\t\t\t\t\tif ( categoryValue ) {\n\t\t\t\t\t\t\tconst homeUrl = \'' + (rt.call_function('esc_js', [rt.call_function('home_url', [rt.new_string('/')])])).str() + '\';\n\t\t\t\t\t\t\tconst url = new URL( homeUrl, window.location.origin );\n\t\t\t\t\t\t\turl.searchParams.set( \'product_cat\', categoryValue );\n\t\t\t\t\t\t\tlocation.href = url.toString();\n\t\t\t\t\t\t} else {\n\t\t\t\t\t\t\tlocation.href = \'' + (rt.call_function('esc_js', [rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])])).str() + '\';\n\t\t\t\t\t\t}\n\t\t\t\t\t});\n\t\n\t\t\t\t\tif ( jQuery().selectWoo ) {\n\t\t\t\t\t\tvar wc_product_cat_select = function() {\n\t\t\t\t\t\t\tjQuery( \'.dropdown_product_cat\' ).selectWoo( {\n\t\t\t\t\t\t\t\tplaceholder: \'' + (rt.call_function('esc_js', [rt.call_function('__', [rt.new_string('Select a category'), rt.new_string('woocommerce')])])).str() + '\',\n\t\t\t\t\t\t\t\tminimumResultsForSearch: 5,\n\t\t\t\t\t\t\t\twidth: \'100%\',\n\t\t\t\t\t\t\t\tallowClear: true,\n\t\t\t\t\t\t\t\tlanguage: {\n\t\t\t\t\t\t\t\t\tnoResults: function() {\n\t\t\t\t\t\t\t\t\t\treturn \'' + (rt.call_function('esc_js', [rt.call_function('_x', [rt.new_string('No matches found'), rt.new_string('enhanced select'), rt.new_string('woocommerce')])])).str() + '\';\n\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t} );\n\t\t\t\t\t\t};\n\t\t\t\t\t\twc_product_cat_select();\n\t\t\t\t\t}\n\t\t\t\t'])
	} else {
		rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/includes/walkers/class-wc-product-cat-list-walker.php', '2')
		var_list_args['walker'] = create_wc_product_cat_list_walker()
		var_list_args['title_li'] = rt.new_string('')
		var_list_args['pad_counts'] = rt.new_int(1)
		var_list_args['show_option_none'] = rt.call_function('__', [rt.new_string('No product categories exist.'), rt.new_string('woocommerce')])
		var_list_args['current_category'] = if rt.is_true(this.current_cat) { rt.get_property(this.current_cat, 'term_id') } else { rt.new_string('') }
		var_list_args['current_category_ancestors'] = this.cat_ancestors
		var_list_args['max_depth'] = var_max_depth.dup()
		print('<ul class="product-categories">')
		rt.call_function('wp_list_categories', [rt.call_function('apply_filters', [rt.new_string('woocommerce_product_categories_widget_args'), var_list_args.dup()])])
		print('</ul>')
	}
	this.widget_end(var_args.dup())
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_WC_Product_Cat_List_Walker {
	rt.PhpObjectBase
}

fn create_wc_widget_product_categories() &Class_WC_Widget_Product_Categories {
	mut obj := &Class_WC_Widget_Product_Categories{
		PhpObjectBase: rt.PhpObjectBase{}
		cat_ancestors: rt.new_null()
		current_cat: rt.new_null()
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

fn create_wc_product_cat_list_walker() &Class_WC_Product_Cat_List_Walker {
	mut obj := &Class_WC_Product_Cat_List_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget_Product_Categories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
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

fn (this &Class_WC_Widget_Product_Categories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cat_ancestors' { return this.cat_ancestors }
		'current_cat' { return this.current_cat }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Widget_Product_Categories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cat_ancestors' { this.cat_ancestors = val; return true }
		'current_cat' { this.current_cat = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_Product_Cat_List_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Cat_List_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Cat_List_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_product_categories_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
