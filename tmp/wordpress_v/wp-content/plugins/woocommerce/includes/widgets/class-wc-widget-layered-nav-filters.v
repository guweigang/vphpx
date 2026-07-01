import rt

struct Class_WC_Widget_Layered_Nav_Filters {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Layered_Nav_Filters) construct()  {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_layered_nav_filters'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [rt.new_string('Display a list of active product filters.'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_layered_nav_filters'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [rt.new_string('Active Product Filters'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('settings', rt.create_array([rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'std', val: rt.call_function('__', [rt.new_string('Active filters'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }]) }]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Layered_Nav_Filters) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))))) {
		return rt.new_null()
	}
	mut var__chosen_attributes := fn () rt.PhpVal { mut temp := Class_WC_Query{}; return temp.get_layered_nav_chosen_attributes() }()
	mut var_min_price := if rt.get_superglobal('_GET').array_isset(rt.new_string('min_price')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('min_price')])]) } else { rt.new_int(0) }
	mut var_max_price := if rt.get_superglobal('_GET').array_isset(rt.new_string('max_price')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('max_price')])]) } else { rt.new_int(0) }
	mut var_rating_filter := if rt.get_superglobal('_GET').array_isset(rt.new_string('rating_filter')) { rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('absint'), rt.call_function('explode', [rt.new_string(','), rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('rating_filter')])])])]) } else { rt.new_array() }
	mut var_base_link := this.get_current_page_url()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(0 < var__chosen_attributes.dup().array_count() || rt.is_true(rt.less(rt.new_int(0), var_min_price)))) || rt.is_true(rt.less(rt.new_int(0), var_max_price)))) || !(!rt.is_true(var_rating_filter)))) {
		this.widget_start(var_args.dup(), var_instance.dup())
		print('<ul>')
		rt.call_function('do_action', [rt.new_string('woocommerce_widget_layered_nav_filters_start'), var_args.dup(), var_instance.dup()])
		if !(!rt.is_true(var__chosen_attributes)) {
			{
				mut iter_1 := var__chosen_attributes.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_data := item_1.val
					mut var_taxonomy := item_1.key
					{
						mut iter_2 := var_data.array_get('terms').iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_term_slug := item_2.val
							mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_term_slug.dup(), var_taxonomy.dup()])
							if rt.is_true(rt.new_bool(!(rt.is_true(var_term)))) {
								continue
							}
							mut var_filter_name := rt.new_string('filter_' + (rt.call_function('wc_attribute_taxonomy_slug', [var_taxonomy.dup()])).str())
							mut var_current_filter := if rt.get_superglobal('_GET').array_isset(var_filter_name) { rt.call_function('explode', [rt.new_string(','), rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(var_filter_name)])])]) } else { rt.new_array() }
							var_current_filter = rt.call_function('array_map', [rt.new_string('sanitize_title'), var_current_filter.dup()])
							mut var_new_filter := rt.call_function('array_diff', [var_current_filter.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_term_slug }])])
							mut var_link := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'add-to-cart' }, rt.ArrayItem{ key: none, val: var_filter_name }]), var_base_link.dup()])
							if var_new_filter.dup().array_count() > 0 {
								var_link = rt.call_function('add_query_arg', [var_filter_name.dup(), rt.call_function('implode', [rt.new_string(','), var_new_filter.dup()]), var_link.dup()])
							}
							mut var_filter_classes := ['chosen', 'chosen-' + (rt.call_function('sanitize_html_class', [rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), var_taxonomy.dup()])])).str(), 'chosen-' + (rt.call_function('sanitize_html_class', [(rt.call_function('str_replace', [rt.new_string('pa_'), rt.new_string(''), var_taxonomy.dup()])).str() + '-' + (var_term_slug).str()])).str()]
							mut var_anchor_text := rt.call_function('apply_filters', [rt.new_string('woocommerce_widget_layered_nav_term_anchor_text'), rt.get_property(var_term, 'name'), var_term.dup(), var_taxonomy.dup()])
							print('<li class="' + (rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), var_filter_classes.dup()])])).str() + '"><a rel="nofollow" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Remove filter'), rt.new_string('woocommerce')])).str() + '" href="' + (rt.call_function('esc_url', [var_link.dup()])).str() + '">' + (rt.call_function('esc_html', [var_anchor_text.dup()])).str() + '</a></li>')
						}
					}
				}
			}
		}
		if rt.is_true(var_min_price) {
			mut var_link := rt.call_function('remove_query_arg', [rt.new_string('min_price'), var_base_link.dup()])
			print('<li class="chosen"><a rel="nofollow" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Remove filter'), rt.new_string('woocommerce')])).str() + '" href="' + (rt.call_function('esc_url', [var_link.dup()])).str() + '">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Min %s'), rt.new_string('woocommerce')]), rt.call_function('wc_price', [var_min_price.dup()])])).str() + '</a></li>')
			// unsupported statement: Stmt_Nop
		}
		if rt.is_true(var_max_price) {
			var_link = rt.call_function('remove_query_arg', [rt.new_string('max_price'), var_base_link.dup()])
			print('<li class="chosen"><a rel="nofollow" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Remove filter'), rt.new_string('woocommerce')])).str() + '" href="' + (rt.call_function('esc_url', [var_link.dup()])).str() + '">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Max %s'), rt.new_string('woocommerce')]), rt.call_function('wc_price', [var_max_price.dup()])])).str() + '</a></li>')
			// unsupported statement: Stmt_Nop
		}
		if !(!rt.is_true(var_rating_filter)) {
			{
				mut iter_1 := var_rating_filter.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_rating := item_1.val
					mut var_link_ratings := rt.call_function('implode', [rt.new_string(','), rt.call_function('array_diff', [var_rating_filter.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_rating }])])])
					var_link = if rt.is_true(var_link_ratings) { rt.call_function('add_query_arg', [rt.new_string('rating_filter'), var_link_ratings.dup()]) } else { rt.call_function('remove_query_arg', [rt.new_string('rating_filter'), var_base_link.dup()]) }
					print('<li class="chosen"><a rel="nofollow" aria-label="' + (rt.call_function('esc_attr__', [rt.new_string('Remove filter'), rt.new_string('woocommerce')])).str() + '" href="' + (rt.call_function('esc_url', [var_link.dup()])).str() + '">' + (rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Rated %s out of 5'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_rating.dup()])])).str() + '</a></li>')
				}
			}
		}
		rt.call_function('do_action', [rt.new_string('woocommerce_widget_layered_nav_filters_end'), var_args.dup(), var_instance.dup()])
		print('</ul>')
		this.widget_end(var_args.dup())
	}
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

fn create_wc_widget_layered_nav_filters() &Class_WC_Widget_Layered_Nav_Filters {
	mut obj := &Class_WC_Widget_Layered_Nav_Filters{
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

fn (mut this Class_WC_Widget_Layered_Nav_Filters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WC_Widget_Layered_Nav_Filters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Layered_Nav_Filters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_layered_nav_filters_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
