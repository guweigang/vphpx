import rt

pub fn Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.slug_regex() string {
	return '/^[A-z0-9\\/_-]+$/'
}
pub fn Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.comma_separated_regex() string {
	return '/[\\s,]+/'
}
struct Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) get_category_labels() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'woo-commerce', val: rt.call_function('__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'intro', val: rt.call_function('__', [rt.new_string('Intro'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'featured-selling', val: rt.call_function('__', [rt.new_string('Featured Selling'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'about', val: rt.call_function('__', [rt.new_string('About'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'social-media', val: rt.call_function('__', [rt.new_string('Social Media'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'services', val: rt.call_function('__', [rt.new_string('Services'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'reviews', val: rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) register_block_pattern(var_source rt.PhpVal, var_pattern_data rt.PhpVal)  {
	mut var_pattern_data_mutated := var_pattern_data
	if !rt.is_true(var_pattern_data_mutated.array_get('slug')) {
		rt.call_function('_doing_it_wrong', [rt.new_string('register_block_patterns'), rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not register pattern "%s" as a block pattern ("Slug" field missing)'), rt.new_string('woocommerce')]), var_source.dup()])]), rt.new_string('6.0.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.slug_regex(), var_pattern_data_mutated.array_get('slug')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string('register_block_patterns'), rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not register pattern "%1$s" as a block pattern (invalid slug "%2$s")'), rt.new_string('woocommerce')]), var_source.dup(), var_pattern_data_mutated.array_get('slug')])]), rt.new_string('6.0.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry{}; return temp.get_instance() }(), 'is_registered', [var_pattern_data_mutated.array_get('slug')])) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_pattern_data_mutated.array_isset(rt.new_string('featureFlag')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(var_pattern_data_mutated.array_get('featureFlag')))))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(var_pattern_data_mutated.array_isset(rt.new_string('title'))) || rt.is_true(rt.new_bool(!(rt.is_true(var_pattern_data_mutated.array_get('title'))))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string('register_block_patterns'), rt.call_function('esc_html', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Could not register pattern "%s" as a block pattern ("Title" field missing)'), rt.new_string('woocommerce')]), var_source.dup()])]), rt.new_string('6.0.0')])
		return rt.new_null()
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'categories' }, rt.ArrayItem{ key: none, val: 'keywords' }, rt.ArrayItem{ key: none, val: 'blockTypes' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			if !(!rt.is_true(var_pattern_data_mutated.array_get(var_property))) {
				if rt.is_true(rt.new_bool(var_pattern_data_mutated.array_get(var_property).is_array())) {
					closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_property := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_property.array_get('title')
	}
	mut var_property := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_property.array_get('title')
	}
	mut var_property := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_property.array_get('title')
	}
	mut var_property := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return var_property.array_get('title')
	}
					var_pattern_data_mutated.array_set(var_property, rt.call_function('array_values', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_pattern_data_mutated.array_get(var_property)])]))
				} else {
					var_pattern_data_mutated.array_set(var_property, rt.call_function('array_filter', [rt.call_function('preg_split', [Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.comma_separated_regex(), // unsupported expression: Expr_Cast_String])]))
				}
			} else {
				var_pattern_data_mutated.array_unset(var_property)
			}
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'viewportWidth' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			if !(!rt.is_true(var_pattern_data_mutated.array_get(var_property))) {
				var_pattern_data_mutated.array_set(var_property, // unsupported expression: Expr_Cast_Int)
			} else {
				var_pattern_data_mutated.array_unset(var_property)
			}
		}
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'inserter' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			if !(!rt.is_true(var_pattern_data_mutated.array_get(var_property))) {
				var_pattern_data_mutated.array_set(var_property, rt.call_function('in_array', [rt.new_string(var_pattern_data_mutated.array_get(var_property).to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'yes' }, rt.ArrayItem{ key: none, val: 'true' }]), rt.new_bool(true)]))
			} else {
				var_pattern_data_mutated.array_unset(var_property)
			}
		}
	}
	var_pattern_data_mutated.array_set('title', rt.call_function('translate_with_gettext_context', [var_pattern_data_mutated.array_get('title'), rt.new_string('Pattern title'), rt.new_string('woocommerce')]))
	if !(!rt.is_true(var_pattern_data_mutated.array_get('description'))) {
		var_pattern_data_mutated.array_set('description', rt.call_function('translate_with_gettext_context', [var_pattern_data_mutated.array_get('description'), rt.new_string('Pattern description'), rt.new_string('woocommerce')]))
	}
	if !rt.is_true(var_pattern_data_mutated.array_get('content')) {
		return rt.new_null()
	}
	mut var_category_labels := this.get_category_labels()
	if !(!rt.is_true(var_pattern_data_mutated.array_get('categories'))) {
		{
			mut iter_1 := var_pattern_data_mutated.array_get('categories').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_category := item_1.val
				mut var_key := item_1.key
				mut var_category_slug := rt.call_function('_wp_to_kebab_case', [var_category.dup()])
				var_pattern_data_mutated.array_get_mut('categories').array_set(var_key, var_category_slug.dup())
				mut var_label := if !(var_category_labels.array_get(var_category_slug)).is_null() { var_category_labels.array_get(var_category_slug) } else { Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.kebab_to_capital_case(var_category_slug.dup()) }
				rt.call_function('register_block_pattern_category', [var_category_slug.dup(), rt.create_array([rt.ArrayItem{ key: 'label', val: var_label }])])
			}
		}
	}
	rt.call_function('register_block_pattern', [var_pattern_data_mutated.array_get('slug'), var_pattern_data_mutated.dup()])
}

fn Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.kebab_to_capital_case(var_value rt.PhpVal) rt.PhpVal {
	mut var_string := rt.call_function('str_replace', [rt.new_string('-'), rt.new_string(' '), var_value.dup()])
	var_string = rt.call_function('ucwords', [var_string.dup()])
	return var_string.dup()
}

struct Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_patterns_patternregistry() &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_patterns_wp_block_patterns_registry() &Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_category_labels' {
			return this.get_category_labels()
		}
		'register_block_pattern' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.register_block_pattern(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'kebab_to_capital_case' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.kebab_to_capital_case(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_patterns_patternregistry_php() {
}
