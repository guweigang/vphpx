import rt

struct Class_WC_Shortcode_Products {
	rt.PhpObjectBase
pub mut:
		prop_type rt.PhpVal = rt.new_string('products')
		attributes rt.PhpVal = rt.new_array()
		query_args rt.PhpVal = rt.new_array()
		custom_visibility bool
}

fn (mut this Class_WC_Shortcode_Products) construct(var_attributes rt.PhpVal, type string)  {
	mut var_attributes_mutated := var_attributes
	this.prop_type = rt.new_string(type).dup()
	this.attributes = this.parse_attributes(var_attributes_mutated.dup())
	this.query_args = this.parse_query_args()
}

fn (mut this Class_WC_Shortcode_Products) get_attributes() rt.PhpVal {
	return this.attributes
}

fn (mut this Class_WC_Shortcode_Products) get_query_args() rt.PhpVal {
	return this.query_args
}

fn (mut this Class_WC_Shortcode_Products) get_type() rt.PhpVal {
	return this.prop_type
}

fn (mut this Class_WC_Shortcode_Products) get_content() rt.PhpVal {
	return rt.new_string(this.product_loop())
}

fn (mut this Class_WC_Shortcode_Products) parse_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	var_attributes_mutated = this.parse_legacy_attributes(var_attributes_mutated.dup())
	var_attributes_mutated = rt.call_function('shortcode_atts', [rt.create_array([rt.ArrayItem{ key: 'limit', val: '-1' }, rt.ArrayItem{ key: 'columns', val: '' }, rt.ArrayItem{ key: 'rows', val: '' }, rt.ArrayItem{ key: 'orderby', val: '' }, rt.ArrayItem{ key: 'order', val: '' }, rt.ArrayItem{ key: 'ids', val: '' }, rt.ArrayItem{ key: 'skus', val: '' }, rt.ArrayItem{ key: 'category', val: '' }, rt.ArrayItem{ key: 'cat_operator', val: 'IN' }, rt.ArrayItem{ key: 'attribute', val: '' }, rt.ArrayItem{ key: 'terms', val: '' }, rt.ArrayItem{ key: 'terms_operator', val: 'IN' }, rt.ArrayItem{ key: 'tag', val: '' }, rt.ArrayItem{ key: 'tag_operator', val: 'IN' }, rt.ArrayItem{ key: 'visibility', val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible() }, rt.ArrayItem{ key: 'class', val: '' }, rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'paginate', val: false }, rt.ArrayItem{ key: 'cache', val: true }]), var_attributes_mutated.dup(), this.prop_type])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('absint', [var_attributes_mutated.array_get('columns')]))))) {
		var_attributes_mutated.array_set('columns', rt.call_function('wc_get_default_products_per_row', []rt.PhpVal{}))
	}
	return var_attributes_mutated.dup()
}

fn (mut this Class_WC_Shortcode_Products) parse_legacy_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	mut var_mapping := { 'per_page': 'limit', 'operator': 'cat_operator', 'filter': 'terms' }
	for var_old, var_new in var_mapping {
		if var_attributes_mutated.array_isset(rt.new_string(old)) {
			var_attributes_mutated.array_set(new, var_attributes_mutated.array_get(old))
			var_attributes_mutated.array_unset(rt.new_string(old))
		}
	}
	return var_attributes_mutated.dup()
}

fn (mut this Class_WC_Shortcode_Products) parse_query_args() rt.PhpVal {
	mut var_query_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'ignore_sticky_posts', val: true }, rt.ArrayItem{ key: 'no_found_rows', val: rt.identical(rt.new_bool(false), rt.call_function('wc_string_to_bool', [this.attributes.array_get('paginate')])) }, rt.ArrayItem{ key: 'orderby', val: if !rt.is_true(rt.get_superglobal('_GET').array_get('orderby')) { this.attributes.array_get('orderby') } else { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('orderby')])]) } }])
	mut var_orderby_value := rt.call_function('explode', [rt.new_string('-'), var_query_args.array_get('orderby')])
	mut var_orderby := rt.call_function('esc_attr', [var_orderby_value.array_get(0)])
	mut var_order := if !(!rt.is_true(var_orderby_value.array_get(1))) { var_orderby_value.array_get(1) } else { rt.new_string(this.attributes.array_get('order').to_string().to_upper()) }
	var_query_args.array_set('orderby', var_orderby.dup())
	var_query_args.array_set('order', var_order.dup())
	if rt.is_true(rt.call_function('wc_string_to_bool', [this.attributes.array_get('paginate')])) {
		this.attributes.array_set('page', rt.call_function('absint', [if !rt.is_true(rt.get_superglobal('_GET').array_get('product-page')) { rt.new_int(1) } else { rt.get_superglobal('_GET').array_get('product-page') }]))
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(this.attributes.array_get('rows'))) {
		this.attributes.array_set('limit', rt.mul(this.attributes.array_get('columns'), this.attributes.array_get('rows')))
	}
	mut var_ordering_args := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_catalog_ordering_args', [var_query_args.array_get('orderby'), var_query_args.array_get('order')])
	var_query_args.array_set('orderby', var_ordering_args.array_get('orderby'))
	var_query_args.array_set('order', var_ordering_args.array_get('order'))
	if rt.is_true(var_ordering_args.array_get('meta_key')) {
		var_query_args.array_set('meta_key', var_ordering_args.array_get('meta_key'))
		// unsupported statement: Stmt_Nop
	}
	var_query_args.array_set('posts_per_page', this.attributes.array_get('limit').to_i64())
	if rt.is_true(rt.less(rt.new_int(1), this.attributes.array_get('page'))) {
		var_query_args.array_set('paged', rt.call_function('absint', [this.attributes.array_get('page')]))
	}
	var_query_args.array_set('meta_query', rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_meta_query', []rt.PhpVal{}))
	var_query_args.array_set('tax_query', rt.new_array())
	this.set_visibility_query_args(var_query_args.dup())
	this.set_skus_query_args(var_query_args.dup())
	this.set_ids_query_args(var_query_args.dup())
	if rt.is_true(rt.call_function('method_exists', [rt.new_object('WC_Shortcode_Products', []string{}, &this), rt.concat(rt.concat(rt.new_string('set_'), this.prop_type), rt.new_string('_query_args'))])) {
		rt.call_method(rt.new_object('WC_Shortcode_Products', []string{}, &this), rt.concat(rt.concat(rt.new_string('set_'), this.prop_type), rt.new_string('_query_args')), [var_query_args.dup()])
	}
	this.set_attributes_query_args(var_query_args.dup())
	this.set_categories_query_args(var_query_args.dup())
	this.set_tags_query_args(var_query_args.dup())
	var_query_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_shortcode_products_query'), var_query_args.dup(), this.attributes, this.prop_type])
	var_query_args.array_set('fields', 'ids')
	return var_query_args.dup()
}

fn (mut this Class_WC_Shortcode_Products) set_skus_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	if !(!rt.is_true(this.attributes.array_get('skus'))) {
		mut var_skus := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), this.attributes.array_get('skus')])])
		var_query_args_mutated.array_get_mut('meta_query').array_push(rt.create_array([rt.ArrayItem{ key: 'key', val: '_sku' }, rt.ArrayItem{ key: 'value', val: if 1 == var_skus.dup().array_count() { var_skus.array_get(0) } else { var_skus } }, rt.ArrayItem{ key: 'compare', val: if 1 == var_skus.dup().array_count() { '=' } else { 'IN' } }]))
	}
}

fn (mut this Class_WC_Shortcode_Products) set_ids_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	if !(!rt.is_true(this.attributes.array_get('ids'))) {
		mut var_ids := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), this.attributes.array_get('ids')])])
		if 1 == var_ids.dup().array_count() {
			var_query_args_mutated.array_set('p', var_ids.array_get(0))
		} else {
			var_query_args_mutated.array_set('post__in', var_ids.dup())
		}
	}
}

fn (mut this Class_WC_Shortcode_Products) set_attributes_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	if !(!rt.is_true(this.attributes.array_get('attribute'))) || !(!rt.is_true(this.attributes.array_get('terms'))) {
		mut var_taxonomy := if rt.is_true(rt.call_function('strstr', [this.attributes.array_get('attribute'), rt.new_string('pa_')])) { rt.call_function('sanitize_title', [this.attributes.array_get('attribute')]) } else { 'pa_' + (rt.call_function('sanitize_title', [this.attributes.array_get('attribute')])).str() }
		mut var_terms := if rt.is_true(this.attributes.array_get('terms')) { rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.call_function('explode', [rt.new_string(','), this.attributes.array_get('terms')])]) } else { rt.new_array() }
		mut var_field := rt.new_string(rt.new_string('slug'))
		if rt.is_true(rt.new_bool(rt.is_true(var_terms) && rt.is_true(rt.new_bool(var_terms.array_get(0).is_long() || var_terms.array_get(0).is_double())))) {
			var_field = rt.new_string(rt.new_string('term_id'))
			var_terms = rt.call_function('array_map', [rt.new_string('absint'), var_terms.dup()])
			{
				mut iter_1 := var_terms.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_term := item_1.val
					mut var_the_term := rt.call_function('get_term_by', [rt.new_string('slug'), var_term.dup(), var_taxonomy.dup()])
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_terms.array_push(rt.get_property(var_the_term, 'term_id'))
					}
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
			var_terms = rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'fields', val: 'ids' }])])
			var_field = rt.new_string(rt.new_string('term_id'))
		}
		var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'terms', val: var_terms }, rt.ArrayItem{ key: 'field', val: var_field }, rt.ArrayItem{ key: 'operator', val: this.attributes.array_get('terms_operator') }]))
	}
}

fn (mut this Class_WC_Shortcode_Products) set_categories_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	if !(!rt.is_true(this.attributes.array_get('category'))) {
		mut var_categories := rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.call_function('explode', [rt.new_string(','), this.attributes.array_get('category')])])
		mut var_field := rt.new_string(rt.new_string('slug'))
		if rt.is_true(rt.new_bool(var_categories.array_get(0).is_long() || var_categories.array_get(0).is_double())) {
			var_field = rt.new_string(rt.new_string('term_id'))
			var_categories = rt.call_function('array_map', [rt.new_string('absint'), var_categories.dup()])
			{
				mut iter_1 := var_categories.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_cat := item_1.val
					mut var_the_cat := rt.call_function('get_term_by', [rt.new_string('slug'), var_cat.dup(), rt.new_string('product_cat')])
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_categories.array_push(rt.get_property(var_the_cat, 'term_id'))
					}
				}
			}
		}
		var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_cat' }, rt.ArrayItem{ key: 'terms', val: var_categories }, rt.ArrayItem{ key: 'field', val: var_field }, rt.ArrayItem{ key: 'operator', val: this.attributes.array_get('cat_operator') }, rt.ArrayItem{ key: 'include_children', val: if rt.is_true(rt.identical(rt.new_string('AND'), this.attributes.array_get('cat_operator'))) { false } else { true } }]))
	}
}

fn (mut this Class_WC_Shortcode_Products) set_tags_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	if !(!rt.is_true(this.attributes.array_get('tag'))) {
		var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_tag' }, rt.ArrayItem{ key: 'terms', val: rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.call_function('explode', [rt.new_string(','), this.attributes.array_get('tag')])]) }, rt.ArrayItem{ key: 'field', val: 'slug' }, rt.ArrayItem{ key: 'operator', val: this.attributes.array_get('tag_operator') }]))
	}
}

fn (mut this Class_WC_Shortcode_Products) set_sale_products_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	var_query_args_mutated.array_set('post__in', rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 0 }]), rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{})]))
}

fn (mut this Class_WC_Shortcode_Products) set_best_selling_products_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	var_query_args_mutated.array_set('meta_key', 'total_sales')
	var_query_args_mutated.array_set('order', 'DESC')
	var_query_args_mutated.array_set('orderby', 'meta_value_num')
}

fn (mut this Class_WC_Shortcode_Products) set_top_rated_products_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	var_query_args_mutated.array_set('meta_key', '_wc_average_rating')
	var_query_args_mutated.array_set('order', 'DESC')
	var_query_args_mutated.array_set('orderby', 'meta_value_num')
}

fn (mut this Class_WC_Shortcode_Products) set_visibility_hidden_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	this.custom_visibility = true
	var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: none, val: 'exclude-from-catalog' }, rt.ArrayItem{ key: none, val: 'exclude-from-search' }]) }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'operator', val: 'AND' }, rt.ArrayItem{ key: 'include_children', val: false }]))
}

fn (mut this Class_WC_Shortcode_Products) set_visibility_catalog_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	this.custom_visibility = true
	var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'terms', val: 'exclude-from-search' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'operator', val: 'IN' }, rt.ArrayItem{ key: 'include_children', val: false }]))
	var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'terms', val: 'exclude-from-catalog' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }, rt.ArrayItem{ key: 'include_children', val: false }]))
}

fn (mut this Class_WC_Shortcode_Products) set_visibility_search_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	this.custom_visibility = true
	var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'terms', val: 'exclude-from-catalog' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'operator', val: 'IN' }, rt.ArrayItem{ key: 'include_children', val: false }]))
	var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'terms', val: 'exclude-from-search' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'operator', val: 'NOT IN' }, rt.ArrayItem{ key: 'include_children', val: false }]))
}

fn (mut this Class_WC_Shortcode_Products) set_visibility_featured_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	var_query_args_mutated.array_set('tax_query', rt.call_function('array_merge', [var_query_args_mutated.array_get('tax_query'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_tax_query', []rt.PhpVal{})]))
	var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' }, rt.ArrayItem{ key: 'terms', val: 'featured' }, rt.ArrayItem{ key: 'field', val: 'name' }, rt.ArrayItem{ key: 'operator', val: 'IN' }, rt.ArrayItem{ key: 'include_children', val: false }]))
}

fn (mut this Class_WC_Shortcode_Products) set_visibility_query_args(var_query_args rt.PhpVal)  {
	mut var_query_args_mutated := var_query_args
	if rt.is_true(rt.call_function('method_exists', [rt.new_object('WC_Shortcode_Products', []string{}, &this), 'set_visibility_' + (this.attributes.array_get('visibility')).str() + '_query_args'])) {
		rt.call_method(rt.new_object('WC_Shortcode_Products', []string{}, &this), 'set_visibility_' + (this.attributes.array_get('visibility')).str() + '_query_args', [var_query_args_mutated.dup()])
	} else {
		var_query_args_mutated.array_set('tax_query', rt.call_function('array_merge', [var_query_args_mutated.array_get('tax_query'), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'), 'get_tax_query', []rt.PhpVal{})]))
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_WC_Shortcode_Products) set_product_as_visible(var_visibility rt.PhpVal) rt.PhpVal {
	return if rt.is_true(this.custom_visibility) { rt.new_bool(true) } else { var_visibility }
}

fn (mut this Class_WC_Shortcode_Products) get_wrapper_classes(var_columns rt.PhpVal) rt.PhpVal {
	mut var_columns_mutated := var_columns
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce' }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_classes.array_push('columns-' + (var_columns_mutated).str())
	}
	var_classes.array_push(this.attributes.array_get('class'))
	return var_classes.dup()
}

fn (mut this Class_WC_Shortcode_Products) get_transient_name() rt.PhpVal {
	mut var_transient_name := rt.new_string( + )
	if rt.is_true(rt.identical(, )) {
		
	}
	return .dup()
}

fn (mut this Class_WC_Shortcode_Products) get_query_results() rt.PhpVal {
}

fn (mut this Class_WC_Shortcode_Products) product_loop() string {
	mut var_GLOBALS := rt.new_null()
}

fn Class_WC_Shortcode_Products.order_by_rating_post_clauses(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
}

fn create_wc_shortcode_products(arg_0 rt.PhpVal, type string) &Class_WC_Shortcode_Products {
	mut obj := &Class_WC_Shortcode_Products{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type: rt.new_string('products')
		attributes: rt.new_array()
		query_args: rt.new_array()
		custom_visibility: false
	}
	obj.construct(arg_0, type)
	return obj
}

fn (mut this Class_WC_Shortcode_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_attributes' {
			return this.get_attributes()
		}
		'get_query_args' {
			return this.get_query_args()
		}
		'get_type' {
			return this.get_type()
		}
		'get_content' {
			return this.get_content()
		}
		'parse_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_attributes(dispatch_arg_0)
		}
		'parse_legacy_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_legacy_attributes(dispatch_arg_0)
		}
		'parse_query_args' {
			return this.parse_query_args()
		}
		'set_skus_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_skus_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_ids_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_ids_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_attributes_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_attributes_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_categories_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_categories_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tags_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tags_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_sale_products_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_sale_products_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_best_selling_products_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_best_selling_products_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_top_rated_products_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_top_rated_products_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visibility_hidden_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visibility_hidden_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visibility_catalog_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visibility_catalog_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visibility_search_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visibility_search_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visibility_featured_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visibility_featured_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visibility_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visibility_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_as_visible' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_product_as_visible(dispatch_arg_0)
		}
		'get_wrapper_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_wrapper_classes(dispatch_arg_0)
		}
		'get_transient_name' {
			return this.get_transient_name()
		}
		'get_query_results' {
			return this.get_query_results()
		}
		'product_loop' {
			return rt.new_string(this.product_loop())
		}
		'order_by_rating_post_clauses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Shortcode_Products.order_by_rating_post_clauses(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Shortcode_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'attributes' { return this.attributes }
		'query_args' { return this.query_args }
		'custom_visibility' { return rt.new_bool(this.custom_visibility) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shortcode_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' { this.prop_type = val; return true }
		'attributes' { this.attributes = val; return true }
		'query_args' { this.query_args = val; return true }
		'custom_visibility' { this.custom_visibility = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_shortcodes_class_wc_shortcode_products_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
