import rt

struct Class_WC_Widget {
	rt.PhpObjectBase
pub mut:
	widget_cssclass    rt.PhpVal = rt.new_null()
	widget_description rt.PhpVal = rt.new_null()
	widget_id          rt.PhpVal = rt.new_null()
	widget_name        rt.PhpVal = rt.new_null()
	settings           rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Widget) construct() {
	mut var_widget_ops := {
		'classname':                   this.widget_cssclass
		'description':                 this.widget_description
		'customize_selective_refresh': rt.new_bool(true)
		'show_instance_in_rest':       rt.new_bool(true)
	}
	this.Class_WP_Widget.construct(this.widget_id, this.widget_name, var_widget_ops.clone())
	rt.call_function('add_action', [rt.new_string('save_post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget', ['WP_Widget'], &this) },
			rt.ArrayItem{ key: none, val: 'flush_widget_cache' },
		])])
	rt.call_function('add_action', [rt.new_string('deleted_post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget', ['WP_Widget'], &this) },
			rt.ArrayItem{ key: none, val: 'flush_widget_cache' },
		])])
	rt.call_function('add_action', [rt.new_string('switch_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget', ['WP_Widget'], &this) },
			rt.ArrayItem{ key: none, val: 'flush_widget_cache' },
		])])
}

fn (mut this Class_WC_Widget) get_cached_widget(var_args rt.PhpVal) bool {
	if !rt.is_true(var_args.array_get(rt.new_string('widget_id'))) {
		return false
	}
	mut var_cache := rt.call_function('wp_cache_get', [
		this.get_widget_id_for_cache(this.widget_id, ''),
		rt.new_string('widget'),
	])
	if !(var_cache.clone().is_array()) {
		var_cache = rt.new_array()
	}
	if var_cache.array_isset(this.get_widget_id_for_cache(var_args.array_get(rt.new_string('widget_id')),
		''))
	{
		rt.echo_val(var_cache.array_get(this.get_widget_id_for_cache(var_args.array_get(rt.new_string('widget_id')),
			'')))
		return true
	}
	return false
}

fn (mut this Class_WC_Widget) cache_widget(var_args rt.PhpVal, var_content rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_args.array_get(rt.new_string('widget_id'))) {
		return var_content.clone()
	}
	mut var_cache := rt.call_function('wp_cache_get', [
		this.get_widget_id_for_cache(this.widget_id, ''),
		rt.new_string('widget'),
	])
	if !(var_cache.clone().is_array()) {
		var_cache = rt.new_array()
	}
	var_cache.array_set(this.get_widget_id_for_cache(var_args.array_get(rt.new_string('widget_id')),
		''), var_content.clone())
	rt.call_function('wp_cache_set', [this.get_widget_id_for_cache(this.widget_id, ''),
		var_cache.clone(), rt.new_string('widget')])
	return var_content.clone()
}

fn (mut this Class_WC_Widget) flush_widget_cache() {
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'https' },
		rt.ArrayItem{ key: none, val: 'http' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_scheme := item_1.val
		rt.call_function('wp_cache_delete', [
			this.get_widget_id_for_cache(this.widget_id, var_scheme.str()),
			rt.new_string('widget'),
		])
	}
}

fn (mut this Class_WC_Widget) get_instance_title(var_instance rt.PhpVal) string {
	mut var_instance_mutated := var_instance
	if var_instance_mutated.array_isset(rt.new_string('title')) {
		return (var_instance_mutated.array_get(rt.new_string('title'))).str()
	}
	if !(this.settings).is_null() && this.settings.array_isset(rt.new_string('title'))
		&& this.settings.array_get(rt.new_string('title')).array_isset(rt.new_string('std')) {
		return (this.settings.array_get(rt.new_string('title')).array_get(rt.new_string('std'))).str()
	}
	return ''
}

fn (mut this Class_WC_Widget) widget_start(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	rt.echo_val(var_args.array_get(rt.new_string('before_widget')))
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'),
		rt.new_string(this.get_instance_title(var_instance_mutated.clone())),
		var_instance_mutated.clone(),
		rt.get_property(rt.new_object('WC_Widget', [
			'WP_Widget',
		], &this), 'id_base')])
	if rt.is_true(var_title) {
		print((var_args.array_get(rt.new_string('before_title'))).str() + var_title.str() +
			(var_args.array_get(rt.new_string('after_title'))).str())
	}
}

fn (mut this Class_WC_Widget) widget_end(var_args rt.PhpVal) {
	rt.echo_val(var_args.array_get(rt.new_string('after_widget')))
}

fn (mut this Class_WC_Widget) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := var_old_instance
	if !rt.is_true(this.settings) {
		return var_instance.clone()
	}
	mut iter_2 := this.settings.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_setting := item_2.val
		mut var_key := item_2.key
		if !(var_setting.array_isset(rt.new_string('type'))) {
			continue
		}
		mut switch_val_1 := var_setting.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('number'))) {
			var_instance.array_set(var_key, rt.call_function('absint', [
				var_new_instance.array_get(var_key),
			]))
			if var_setting.array_isset(rt.new_string('min'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_setting.array_get(rt.new_string('min')))))) {
				var_instance.array_set(var_key, rt.call_function('max', [
					var_instance.array_get(var_key),
					var_setting.array_get(rt.new_string('min')),
				]))
			}
			if var_setting.array_isset(rt.new_string('max'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_setting.array_get(rt.new_string('max')))))) {
				var_instance.array_set(var_key, rt.call_function('min', [
					var_instance.array_get(var_key),
					var_setting.array_get(rt.new_string('max')),
				]))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('textarea'))) {
			var_instance.array_set(var_key, rt.call_function('wp_kses', [
				rt.new_string(rt.call_function('wp_unslash', [
					var_new_instance.array_get(var_key)]).to_string().trim_space()),
				rt.call_function('wp_kses_allowed_html', [rt.new_string('post')]),
			]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkbox'))) {
			var_instance.array_set(var_key, if !rt.is_true(var_new_instance.array_get(var_key)) {
				0
			} else {
				1
			})
		} else {
			var_instance.array_set(var_key, if var_new_instance.array_isset(var_key) { rt.call_function('sanitize_text_field', [
					var_new_instance.array_get(var_key),
				]) } else { var_setting.array_get(rt.new_string('std')) })
		}
		var_instance.array_set(var_key, rt.call_function('apply_filters', [
			rt.new_string('woocommerce_widget_settings_sanitize_option'),
			var_instance.array_get(var_key),
			var_new_instance.clone(),
			var_key.clone(),
			var_setting.clone(),
		]))
	}
	this.flush_widget_cache()
	return var_instance.clone()
}

fn (mut this Class_WC_Widget) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	if !rt.is_true(this.settings) {
		return
	}
	mut iter_3 := this.settings.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_setting := item_3.val
		mut var_key := item_3.key
		mut var_class := if var_setting.array_isset(rt.new_string('class')) {
			var_setting.array_get(rt.new_string('class'))
		} else {
			rt.new_string('')
		}
		mut var_value := if var_instance_mutated.array_isset(var_key) {
			var_instance_mutated.array_get(var_key)
		} else {
			var_setting.array_get(rt.new_string('std'))
		}
		mut switch_val_2 := var_setting.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('text'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				var_setting.array_get(rt.new_string('label')),
			]))
			// unsupported statement: Stmt_InlineHTML
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('number'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_setting.array_get(rt.new_string('label')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [
				var_setting.array_get(rt.new_string('step')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_setting.array_get(rt.new_string('min'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_setting.array_get(rt.new_string('max'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('select'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_setting.array_get(rt.new_string('label')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			mut iter_4 := var_setting.array_get(rt.new_string('options')).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_option_value := item_4.val
				mut var_option_key := item_4.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_option_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [var_option_key.clone(),
					var_value.clone()])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_option_value.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('textarea'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_setting.array_get(rt.new_string('label')))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_textarea', [var_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
			if var_setting.array_isset(rt.new_string('desc')) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_setting.array_get(rt.new_string('desc')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_class.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('checked', [var_value.clone(), rt.new_int(1)])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(var_key.clone())]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_setting.array_get(rt.new_string('label')))
			// unsupported statement: Stmt_InlineHTML
		} else {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_widget_field_' +
					(var_setting.array_get(rt.new_string('type'))).str()),
				var_key.clone(),
				var_value.clone(),
				var_setting.clone(),
				var_instance_mutated.clone(),
			])
		}
	}
}

fn (mut this Class_WC_Widget) get_current_page_url() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_defined(rt.new_string('SHOP_IS_ON_FRONT'))
	if rt.is_true(iife_result_0) {
		mut var_link := rt.call_function('home_url', []rt.PhpVal{})
	} else if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) {
		var_link = rt.call_function('get_permalink', [
			rt.call_function('wc_get_page_id', [rt.new_string('shop')]),
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
	} else {
		mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		var_link = rt.call_function('get_term_link', [
			rt.get_property(var_queried_object, 'slug'),
			rt.get_property(var_queried_object, 'taxonomy'),
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
		if rt.is_true(rt.call_function('is_shop', []rt.PhpVal{})) {
			var_link = rt.call_function('remove_query_arg', [
				rt.new_string('page_id'), var_link.clone()])
		}
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('rating_filter')) {
		var_link = rt.call_function('add_query_arg', [rt.new_string('rating_filter'),
			rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_GET').array_get(rt.new_string('rating_filter')),
				]),
			]),
			var_link.clone()])
	}
	mut iife_temp_1 := Class_WC_Query{}
	mut iife_result_1 := iife_temp_1.get_layered_nav_chosen_attributes()
	mut var__chosen_attributes := iife_result_1
	if rt.is_true(var__chosen_attributes) {
		mut iter_5 := var__chosen_attributes.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_data := item_5.val
			mut var_name := item_5.key
			mut var_filter_name := rt.call_function('wc_attribute_taxonomy_slug', [
				var_name.clone(),
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
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_widget_get_current_page_url'),
		var_link.clone(),
		rt.new_object('WC_Widget', ['WP_Widget'], &this),
	])
}

fn (mut this Class_WC_Widget) get_widget_id_for_cache(var_widget_id rt.PhpVal, scheme string) rt.PhpVal {
	if var_scheme.len > 0 && var_scheme != '0' {
		mut var_widget_id_for_cache := rt.new_string(var_widget_id.str() + '-' + scheme)
	} else {
		var_widget_id_for_cache = rt.new_string(var_widget_id.str() + '-' +
			if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) { 'https' } else { 'http' })
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_cached_widget_id'),
		var_widget_id_for_cache.clone(),
	])
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Query {
	rt.PhpObjectBase
}

fn create_wc_widget() &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase:      rt.PhpObjectBase{}
		widget_cssclass:    rt.new_null()
		widget_description: rt.new_null()
		widget_id:          rt.new_null()
		widget_name:        rt.new_null()
		settings:           rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_widget(_args ...rt.PhpVal) &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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

fn (mut this Class_WC_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_cached_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_cached_widget(dispatch_arg_0))
		}
		'cache_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.cache_widget(dispatch_arg_0, dispatch_arg_1)
		}
		'flush_widget_cache' {
			this.flush_widget_cache()
			return rt.new_null()
		}
		'get_instance_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_instance_title(dispatch_arg_0))
		}
		'widget_start' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget_start(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'widget_end' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.widget_end(dispatch_arg_0)
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
		'get_current_page_url' {
			return this.get_current_page_url()
		}
		'get_widget_id_for_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_widget_id_for_cache(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'widget_cssclass' { return this.widget_cssclass }
		'widget_description' { return this.widget_description }
		'widget_id' { return this.widget_id }
		'widget_name' { return this.widget_name }
		'settings' { return this.settings }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'widget_cssclass' {
			this.widget_cssclass = val
			return true
		}
		'widget_description' {
			this.widget_description = val
			return true
		}
		'widget_id' {
			this.widget_id = val
			return true
		}
		'widget_name' {
			this.widget_name = val
			return true
		}
		'settings' {
			this.settings = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
