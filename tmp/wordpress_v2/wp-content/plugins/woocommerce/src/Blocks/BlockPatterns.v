import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockPatterns.categories_prefixes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '_woo_' },
		rt.ArrayItem{ key: none, val: '_dotcom_imported_' }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockPatterns {
	rt.PhpObjectBase
pub mut:
	patterns_path      rt.PhpVal = rt.new_null()
	pattern_registry   rt.PhpVal = rt.new_null()
	ptk_patterns_store rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) construct(mut var_package Class_Automattic_WooCommerce_Blocks_Domain_Package, mut var_pattern_registry Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry, mut var_ptk_patterns_store Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore) {
	this.patterns_path = var_package.get_path(rt.new_string('patterns'))
	this.pattern_registry = var_pattern_registry
	this.ptk_patterns_store = var_ptk_patterns_store
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockPatterns',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_block_patterns' },
		])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('pattern-toolkit-full-composability'))
	if rt.is_true(iife_result_0) {
		rt.call_function('add_action', [rt.new_string('init'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockPatterns',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'register_ptk_patterns' },
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) load_pattern_content(var_pattern_path rt.PhpVal) string {
	mut var_pattern_path_mutated := var_pattern_path
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_pattern_path_mutated.clone()])))))
	{
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file(var_pattern_path_mutated.to_string(), '1')
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) register_block_patterns() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Block_Patterns_Registry'),
	])))))
	{
		return
	}
	mut var_patterns := this.get_block_patterns()
	mut iter_1 := var_patterns.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_pattern := item_1.val
		mut var_pattern_path := rt.new_string((this.patterns_path).str() + '/' +
			(var_pattern.array_get(rt.new_string('source'))).str())
		var_pattern.array_set('source', var_pattern_path.clone())
		mut var_content := rt.new_string(this.load_pattern_content(var_pattern_path.clone()))
		var_pattern.array_set('content', var_content.clone())
		rt.call_method(this.pattern_registry, 'register_block_pattern', [
			var_pattern_path.clone(), var_pattern.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) get_block_patterns() rt.PhpVal {
	mut var_pattern_data := rt.new_bool(this.get_pattern_cache())
	if rt.is_true(rt.new_bool(var_pattern_data.clone().is_array())) {
		return var_pattern_data.clone()
	}
	mut var_default_headers := rt.create_array([
		rt.ArrayItem{ key: 'title', val: 'Title' },
		rt.ArrayItem{ key: 'slug', val: 'Slug' },
		rt.ArrayItem{ key: 'description', val: 'Description' },
		rt.ArrayItem{ key: 'viewportWidth', val: 'Viewport Width' },
		rt.ArrayItem{ key: 'categories', val: 'Categories' },
		rt.ArrayItem{ key: 'keywords', val: 'Keywords' },
		rt.ArrayItem{ key: 'blockTypes', val: 'Block Types' },
		rt.ArrayItem{ key: 'inserter', val: 'Inserter' },
		rt.ArrayItem{ key: 'featureFlag', val: 'Feature Flag' },
		rt.ArrayItem{ key: 'templateTypes', val: 'Template Types' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		this.patterns_path,
	])))))
	{
		return rt.new_array()
	}
	mut var_files := rt.call_function('glob', [
		rt.new_string((this.patterns_path).str() + '/*.php'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_files)))) {
		return rt.new_array()
	}
	mut var_patterns := rt.new_array()
	mut iter_2 := var_files.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_file := item_2.val
		mut var_data := rt.call_function('get_file_data', [var_file.clone(),
			var_default_headers.clone()])
		var_data.array_set('source', rt.call_function('str_replace', [
			rt.new_string((this.patterns_path).str() + '/'),
			rt.new_string(''),
			var_file.clone(),
		]))
		var_patterns.array_push(var_data.clone())
	}
	this.set_pattern_cache(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](var_patterns))
	return var_patterns.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) get_pattern_cache() bool {
	mut var_pattern_data := rt.call_function('get_site_transient', [
		rt.new_string('woocommerce_blocks_patterns'),
	])
	if var_pattern_data.clone().is_array()
		&& rt.is_true(rt.identical(rt.get_constant('WOOCOMMERCE_VERSION'), var_pattern_data.array_get(rt.new_string('version')))) {
		return (var_pattern_data.array_get(rt.new_string('patterns'))).to_bool()
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) set_pattern_cache(mut var_patterns Class_Automattic_WooCommerce_Blocks_array) {
	mut var_patterns_mutated := var_patterns
	mut var_pattern_data := rt.create_array([
		rt.ArrayItem{ key: 'version', val: rt.get_constant('WOOCOMMERCE_VERSION') },
		rt.ArrayItem{ key: 'patterns', val: var_patterns_mutated },
	])
	rt.call_function('set_site_transient', [rt.new_string('woocommerce_blocks_patterns'),
		var_pattern_data.clone(), rt.get_constant('MONTH_IN_SECONDS')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) register_ptk_patterns() {
	mut var_allow_tracking := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_allow_tracking'),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allow_tracking)))) {
		return
	}
	mut var_has_scheduled_action := rt.new_string((if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('as_has_scheduled_action'),
	]))
	{ 'as_has_scheduled_action' } else { 'as_next_scheduled_action' }).str())
	mut var_patterns := rt.call_method(this.ptk_patterns_store, 'get_patterns', []rt.PhpVal{})
	if !rt.is_true(var_patterns) || !(var_patterns.clone().is_array()) {
		mut var_transient_key := rt.new_string('wc_ptk_pattern_store_warning')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_transient', [var_transient_key.clone()])))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('call_user_func', [var_has_scheduled_action.clone(), rt.new_string('fetch_patterns')]))))) {
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
				rt.call_function('__', [
					rt.new_string('Empty patterns received from the PTK Pattern Store'),
					rt.new_string('woocommerce'),
				]),
			])
			rt.call_function('set_transient', [var_transient_key.clone(),
				rt.new_bool(true), rt.get_constant('DAY_IN_SECONDS')])
		}
		return
	}
	var_patterns =
		this.parse_categories(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](var_patterns))
	mut iter_3 := var_patterns.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_pattern := item_3.val
		var_pattern.array_set('slug', var_pattern.array_get(rt.new_string('name')))
		var_pattern.array_set('content', var_pattern.array_get(rt.new_string('html')))
		rt.call_method(this.pattern_registry, 'register_block_pattern', [
			var_pattern.array_get(rt.new_string('ID')),
			var_pattern.clone(),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) parse_categories(mut var_patterns Class_Automattic_WooCommerce_Blocks_array) rt.PhpVal {
	mut var_patterns_mutated := var_patterns
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_pattern := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_pattern.array_isset(rt.new_string('categories'))) {
			var_pattern.array_set('categories', rt.new_array())
		}
		mut var_values := rt.call_function('array_values', [
			var_pattern.array_get(rt.new_string('categories')),
		])
		mut iter_4 := var_values.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_value := item_4.val
			if !(var_value.array_isset(rt.new_string('title')))
				|| !(var_value.array_isset(rt.new_string('slug'))) {
				var_pattern.array_set('categories', rt.new_array())
			}
		}
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_category := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iter_5 :=
				Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_BlockPatterns.categories_prefixes().iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_prefix := item_5.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					var_category.array_get(rt.new_string('title')),
					var_prefix.clone(),
				]), rt.new_bool(false)))))
				{
					mut var_parsed_category := rt.call_function('str_replace', [
						var_prefix.clone(),
						rt.new_string(''),
						var_category.array_get(rt.new_string('title')),
					])
					var_parsed_category = rt.call_function('str_replace', [
						rt.new_string('_'),
						rt.new_string(' '),
						var_parsed_category.clone(),
					])
					var_category.array_set('title', rt.call_function('ucfirst', [
						var_parsed_category.clone(),
					]))
				}
			}
			return var_category.clone()
		}
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_category := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iter_6 :=
				Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_BlockPatterns.categories_prefixes().iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_prefix := item_6.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					var_category.array_get(rt.new_string('title')),
					var_prefix.clone(),
				]), rt.new_bool(false)))))
				{
					mut var_parsed_category := rt.call_function('str_replace', [
						var_prefix.clone(),
						rt.new_string(''),
						var_category.array_get(rt.new_string('title')),
					])
					var_parsed_category = rt.call_function('str_replace', [
						rt.new_string('_'),
						rt.new_string(' '),
						var_parsed_category.clone(),
					])
					var_category.array_set('title', rt.call_function('ucfirst', [
						var_parsed_category.clone(),
					]))
				}
			}
			return var_category.clone()
		}
		var_pattern.array_set('categories', rt.call_function('array_map', [
			rt.new_closure(closure_3_fn),
			var_pattern.array_get(rt.new_string('categories')),
		]))
		return var_pattern.clone()
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_pattern := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_pattern.array_isset(rt.new_string('categories'))) {
			var_pattern.array_set('categories', rt.new_array())
		}
		mut var_values := rt.call_function('array_values', [
			var_pattern.array_get(rt.new_string('categories')),
		])
		mut iter_7 := var_values.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_value := item_7.val
			if !(var_value.array_isset(rt.new_string('title')))
				|| !(var_value.array_isset(rt.new_string('slug'))) {
				var_pattern.array_set('categories', rt.new_array())
			}
		}
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_category := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iter_8 :=
				Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_BlockPatterns.categories_prefixes().iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_prefix := item_8.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					var_category.array_get(rt.new_string('title')),
					var_prefix.clone(),
				]), rt.new_bool(false)))))
				{
					mut var_parsed_category := rt.call_function('str_replace', [
						var_prefix.clone(),
						rt.new_string(''),
						var_category.array_get(rt.new_string('title')),
					])
					var_parsed_category = rt.call_function('str_replace', [
						rt.new_string('_'),
						rt.new_string(' '),
						var_parsed_category.clone(),
					])
					var_category.array_set('title', rt.call_function('ucfirst', [
						var_parsed_category.clone(),
					]))
				}
			}
			return var_category.clone()
		}
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_category := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut iter_9 :=
				Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_BlockPatterns.categories_prefixes().iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_prefix := item_9.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
					var_category.array_get(rt.new_string('title')),
					var_prefix.clone(),
				]), rt.new_bool(false)))))
				{
					mut var_parsed_category := rt.call_function('str_replace', [
						var_prefix.clone(),
						rt.new_string(''),
						var_category.array_get(rt.new_string('title')),
					])
					var_parsed_category = rt.call_function('str_replace', [
						rt.new_string('_'),
						rt.new_string(' '),
						var_parsed_category.clone(),
					])
					var_category.array_set('title', rt.call_function('ucfirst', [
						var_parsed_category.clone(),
					]))
				}
			}
			return var_category.clone()
		}
		var_pattern.array_set('categories', rt.call_function('array_map', [
			rt.new_closure(closure_6_fn),
			var_pattern.array_get(rt.new_string('categories')),
		]))
		return var_pattern.clone()
	}
	return rt.call_function('array_map', [rt.new_closure(closure_4_fn), var_patterns_mutated])
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blockpatterns(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockPatterns {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockPatterns{
		PhpObjectBase:      rt.PhpObjectBase{}
		patterns_path:      rt.new_null()
		pattern_registry:   rt.new_null()
		ptk_patterns_store: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Package](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_PatternRegistry](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Patterns_PTKPatternsStore](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'load_pattern_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.load_pattern_content(dispatch_arg_0))
		}
		'register_block_patterns' {
			this.register_block_patterns()
			return rt.new_null()
		}
		'get_block_patterns' {
			return this.get_block_patterns()
		}
		'get_pattern_cache' {
			return rt.new_bool(this.get_pattern_cache())
		}
		'set_pattern_cache' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_pattern_cache(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register_ptk_patterns' {
			this.register_ptk_patterns()
			return rt.new_null()
		}
		'parse_categories' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.parse_categories(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockPatterns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'patterns_path' { return this.patterns_path }
		'pattern_registry' { return this.pattern_registry }
		'ptk_patterns_store' { return this.ptk_patterns_store }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockPatterns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'patterns_path' {
			this.patterns_path = val
			return true
		}
		'pattern_registry' {
			this.pattern_registry = val
			return true
		}
		'ptk_patterns_store' {
			this.ptk_patterns_store = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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
