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
	return rt.create_array([
		rt.ArrayItem{ key: 'woo-commerce', val: rt.call_function('__', [
			rt.new_string('WooCommerce'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'intro', val: rt.call_function('__', [
			rt.new_string('Intro'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'featured-selling', val: rt.call_function('__', [
			rt.new_string('Featured Selling'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'about', val: rt.call_function('__', [
			rt.new_string('About'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'social-media', val: rt.call_function('__', [
			rt.new_string('Social Media'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'services', val: rt.call_function('__', [
			rt.new_string('Services'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'reviews', val: rt.call_function('__', [
			rt.new_string('Reviews'),
			rt.new_string('woocommerce'),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry) register_block_pattern(var_source rt.PhpVal, var_pattern_data rt.PhpVal) {
	mut var_pattern_data_mutated := var_pattern_data
	if !rt.is_true(var_pattern_data_mutated.array_get(rt.new_string('slug'))) {
		rt.call_function('_doing_it_wrong', [rt.new_string('register_block_patterns'),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Could not register pattern "%s" as a block pattern ("Slug" field missing)'),
						rt.new_string('woocommerce'),
					]),
					var_source.clone(),
				]),
			]),
			rt.new_string('6.0.0')])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
		Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.slug_regex(),
		var_pattern_data_mutated.array_get(rt.new_string('slug')),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string('register_block_patterns'),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Could not register pattern "%1$s" as a block pattern (invalid slug "%2$s")'),
						rt.new_string('woocommerce'),
					]),
					var_source.clone(),
					var_pattern_data_mutated.array_get(rt.new_string('slug')),
				]),
			]),
			rt.new_string('6.0.0')])
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	if rt.is_true(rt.call_method(iife_result_0, 'is_registered', [
		var_pattern_data_mutated.array_get(rt.new_string('slug')),
	]))
	{
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_1 :=
		iife_temp_1.is_enabled(var_pattern_data_mutated.array_get(rt.new_string('featureFlag')))
	if var_pattern_data_mutated.array_isset(rt.new_string('featureFlag'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_pattern_data_mutated.array_get(rt.new_string('featureFlag'))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1)))) {
		return
	}
	if !(var_pattern_data_mutated.array_isset(rt.new_string('title')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_pattern_data_mutated.array_get(rt.new_string('title')))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string('register_block_patterns'),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Could not register pattern "%s" as a block pattern ("Title" field missing)'),
						rt.new_string('woocommerce'),
					]),
					var_source.clone(),
				]),
			]),
			rt.new_string('6.0.0')])
		return
	}
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'categories' },
		rt.ArrayItem{ key: none, val: 'keywords' }, rt.ArrayItem{ key: none, val: 'blockTypes' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_property := item_1.val
		if !(!rt.is_true(var_pattern_data_mutated.array_get(var_property))) {
			if rt.is_true(rt.new_bool(var_pattern_data_mutated.array_get(var_property).is_array())) {
				closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return
				}
				closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return
				}
				closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return
				}
				closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_property := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return
				}
				var_pattern_data_mutated.array_set(var_property, rt.call_function('array_values', [
					rt.call_function('array_map', [rt.new_closure(closure_3_fn),
						var_pattern_data_mutated.array_get(var_property)]),
				]))
			} else {
				var_pattern_data_mutated.array_set(var_property, rt.call_function('array_filter', [
					rt.call_function('preg_split', [
						Class_Automattic_WooCommerce_Blocks_Patterns_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.comma_separated_regex(),
						rt.new_string((var_pattern_data_mutated.array_get(var_property)).str()),
					]),
				]))
			}
		} else {
			var_pattern_data_mutated.array_unset(var_property)
		}
	}
	mut iter_2 := rt.create_array([rt.ArrayItem{ key: none, val: 'viewportWidth' }]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_property := item_2.val
		if !(!rt.is_true(var_pattern_data_mutated.array_get(var_property))) {
			var_pattern_data_mutated.array_set(var_property,
				rt.new_int((var_pattern_data_mutated.array_get(var_property)).to_i64()))
		} else {
			var_pattern_data_mutated.array_unset(var_property)
		}
	}
	mut iter_3 := rt.create_array([rt.ArrayItem{ key: none, val: 'inserter' }]).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_property := item_3.val
		if !(!rt.is_true(var_pattern_data_mutated.array_get(var_property))) {
			var_pattern_data_mutated.array_set(var_property, rt.call_function('in_array', [
				rt.new_string(var_pattern_data_mutated.array_get(var_property).to_string().to_lower()),
				rt.create_array([rt.ArrayItem{ key: none, val: 'yes' },
					rt.ArrayItem{ key: none, val: 'true' }]),
				rt.new_bool(true),
			]))
		} else {
			var_pattern_data_mutated.array_unset(var_property)
		}
	}
	var_pattern_data_mutated.array_set('title', rt.call_function('translate_with_gettext_context', [
		var_pattern_data_mutated.array_get(rt.new_string('title')),
		rt.new_string('Pattern title'),
		rt.new_string('woocommerce'),
	]))
	if !(!rt.is_true(var_pattern_data_mutated.array_get(rt.new_string('description')))) {
		var_pattern_data_mutated.array_set('description', rt.call_function('translate_with_gettext_context', [
			var_pattern_data_mutated.array_get(rt.new_string('description')),
			rt.new_string('Pattern description'),
			rt.new_string('woocommerce'),
		]))
	}
	if !rt.is_true(var_pattern_data_mutated.array_get(rt.new_string('content'))) {
		return
	}
	mut var_category_labels := this.get_category_labels()
	if !(!rt.is_true(var_pattern_data_mutated.array_get(rt.new_string('categories')))) {
		mut iter_4 := var_pattern_data_mutated.array_get(rt.new_string('categories')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_category := item_4.val
			mut var_key := item_4.key
			mut var_category_slug := rt.call_function('_wp_to_kebab_case', [
				var_category.clone()])
			var_pattern_data_mutated.array_get_mut('categories').array_set(var_key,
				var_category_slug.clone())
			mut var_label := if !(var_category_labels.array_get(var_category_slug)).is_null() {
				var_category_labels.array_get(var_category_slug)
			} else {
				Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.kebab_to_capital_case(var_category_slug.clone())
			}
			rt.call_function('register_block_pattern_category', [
				var_category_slug.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'label', val: var_label },
				])])
		}
	}
	rt.call_function('register_block_pattern', [var_pattern_data_mutated.array_get(rt.new_string('slug')),
		var_pattern_data_mutated.clone()])
}

fn Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry.kebab_to_capital_case(var_value rt.PhpVal) rt.PhpVal {
	mut var_string := rt.call_function('str_replace', [rt.new_string('-'),
		rt.new_string(' '), var_value.clone()])
	var_string = rt.call_function('ucwords', [var_string.clone()])
	return var_string.clone()
}

struct Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_patterns_patternregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_patterns_wp_block_patterns_registry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Patterns_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
