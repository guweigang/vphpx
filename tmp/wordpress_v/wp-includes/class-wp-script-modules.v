import rt

struct Class_WP_Script_Modules {
	rt.PhpObjectBase
pub mut:
		registered rt.PhpVal = rt.new_array()
		queue rt.PhpVal = rt.new_array()
		done rt.PhpVal = rt.new_array()
		a11y_available bool
		dependents_map rt.PhpVal = rt.new_array()
		priorities rt.PhpVal = rt.new_array()
		modules_with_missing_dependencies rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Script_Modules) register(id string, src string, mut var_deps Class_array, version bool, mut var_args Class_array)  {
	mut id_mutated := id
	mut src_mutated := src
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(id_mutated))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Non-empty string required for id.')]), rt.new_string('6.9.0')])
		return rt.new_null()
	}
	if !(this.registered.array_isset(rt.new_string(id_mutated))) {
		mut var_dependencies := rt.new_array()
		{
			mut iter_1 := var_deps.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_dependency := item_1.val
				if rt.is_true(rt.new_bool(var_dependency.dup().is_array())) {
					if rt.is_true(rt.new_bool(!(var_dependency.array_isset(rt.new_string('id'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_dependency.array_get('id').is_string()))))))) {
						rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Missing required id key in entry among dependencies array.')]), rt.new_string('6.5.0')])
						continue
					}
					var_dependencies.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_dependency.array_get('id') }, rt.ArrayItem{ key: 'import', val: if rt.is_true(rt.new_bool(var_dependency.array_isset(rt.new_string('import')) && rt.is_true(rt.identical(rt.new_string('dynamic'), var_dependency.array_get('import'))))) { 'dynamic' } else { 'static' } }]))
				} else if rt.is_true(rt.new_bool(var_dependency.dup().is_string())) {
					var_dependencies.array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: var_dependency }, rt.ArrayItem{ key: 'import', val: 'static' }]))
				} else {
					rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Entries in dependencies array must be either strings or arrays with an id key.')]), rt.new_string('6.5.0')])
				}
			}
		}
		mut var_in_footer := rt.new_bool(rt.new_bool(var_args.array_isset(rt.new_string('in_footer')) && rt.is_true(// unsupported expression: Expr_Cast_Bool)))
		mut var_fetchpriority := rt.new_string(rt.new_string('auto'))
		if var_args.array_isset(rt.new_string('fetchpriority')) {
			if this.is_valid_fetchpriority(var_args.array_get('fetchpriority')) {
				var_fetchpriority = var_args.array_get('fetchpriority')
			} else {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid fetchpriority `%1$s` defined for `%2$s` during script registration.')]), if rt.is_true(rt.new_bool(var_args.array_get('fetchpriority').is_string())) { var_args.array_get('fetchpriority') } else { rt.call_function('gettype', [var_args.array_get('fetchpriority')]) }, rt.new_string(id_mutated).dup()]), rt.new_string('6.9.0')])
			}
		}
		this.registered.array_set(id_mutated, rt.create_array([rt.ArrayItem{ key: 'src', val: src_mutated }, rt.ArrayItem{ key: 'version', val: version }, rt.ArrayItem{ key: 'dependencies', val: var_dependencies }, rt.ArrayItem{ key: 'in_footer', val: var_in_footer }, rt.ArrayItem{ key: 'fetchpriority', val: var_fetchpriority }]))
	}
}

fn (mut this Class_WP_Script_Modules) get_queue() rt.PhpVal {
	return this.queue
}

fn (mut this Class_WP_Script_Modules) is_valid_fetchpriority(var_priority rt.PhpVal) bool {
	mut var_priority_mutated := var_priority
	return (rt.call_function('in_array', [var_priority_mutated.dup(), this.priorities, rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WP_Script_Modules) set_fetchpriority(id string, priority string) bool {
	mut id_mutated := id
	mut priority_mutated := priority
	if !(this.registered.array_isset(rt.new_string(id_mutated))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(priority_mutated))) {
		priority_mutated = 'auto'
	}
	if !(this.is_valid_fetchpriority(rt.new_string(priority_mutated))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid fetchpriority: %s')]), rt.new_string(priority_mutated).dup()]), rt.new_string('6.9.0')])
		return false
	}
	this.registered.array_get_mut(id_mutated).array_set('fetchpriority', priority_mutated)
	return true
}

fn (mut this Class_WP_Script_Modules) set_in_footer(id string, in_footer bool) bool {
	mut id_mutated := id
	mut in_footer_mutated := in_footer
	if !(this.registered.array_isset(rt.new_string(id_mutated))) {
		return false
	}
	this.registered.array_get_mut(id_mutated).array_set('in_footer', in_footer_mutated)
	return true
}

fn (mut this Class_WP_Script_Modules) enqueue(id string, src string, mut var_deps Class_array, version bool, mut var_args Class_array)  {
	mut id_mutated := id
	mut src_mutated := src
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(id_mutated))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Non-empty string required for id.')]), rt.new_string('6.9.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).dup(), this.queue, rt.new_bool(true)]))))) {
		this.queue.array_push(id_mutated)
	}
	if rt.is_true(rt.new_bool(!(this.registered.array_isset(rt.new_string(id_mutated))) && rt.is_true(rt.new_string(src_mutated)))) {
		this.register(id_mutated, src_mutated, mut var_deps, version, mut var_args)
	}
}

fn (mut this Class_WP_Script_Modules) dequeue(id string)  {
	mut id_mutated := id
	this.queue = rt.call_function('array_values', [rt.call_function('array_diff', [this.queue, rt.create_array([rt.ArrayItem{ key: none, val: id_mutated }])])])
}

fn (mut this Class_WP_Script_Modules) deregister(id string)  {
	mut id_mutated := id
	this.dequeue(id_mutated)
	this.registered.array_unset(rt.new_string(id_mutated))
}

fn (mut this Class_WP_Script_Modules) set_translations(id string, domain string, path string) bool {
	mut id_mutated := id
	mut domain_mutated := domain
	mut path_mutated := path
	if !(this.registered.array_isset(rt.new_string(id_mutated))) {
		return false
	}
	this.registered.array_get_mut(id_mutated).array_set('textdomain', domain_mutated)
	this.registered.array_get_mut(id_mutated).array_set('translations_path', path_mutated)
	return true
}

fn (mut this Class_WP_Script_Modules) print_script_module_translations()  {
	mut var_module_ids := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue), rt.new_null())
	mut var_set_locale_data_js_function := rt.new_string(rt.new_string('( domain, translations ) => {\n\tconst localeData = translations.locale_data[ domain ] || translations.locale_data.messages;\n\tlocaleData[""].domain = domain;\n\twp.i18n.setLocaleData( localeData, domain );\n}'))
	{
		mut iter_1 := var_module_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			mut var_domain := if !(this.registered.array_get(var_id).array_get('textdomain')).is_null() { this.registered.array_get(var_id).array_get('textdomain') } else { rt.new_string('default') }
			mut var_path := if !(this.registered.array_get(var_id).array_get('translations_path')).is_null() { this.registered.array_get(var_id).array_get('translations_path') } else { rt.new_string('') }
			mut var_json_translations := rt.call_function('load_script_module_textdomain', [var_id.dup(), var_domain.dup(), var_path.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_json_translations)))) {
				continue
			}
			mut var_output := rt.call_function('sprintf', [rt.new_string('( %s )( %s, %s );'), var_set_locale_data_js_function.dup(), rt.call_function('wp_json_encode', [var_domain.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), var_json_translations.dup()])
			mut var_script_id := rt.new_string(rt.new_string("wp-script-module-translation-data-${var_id.to_string()}"))
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [rt.new_string('wp-i18n'), rt.new_string('done')]))))) {
				rt.call_method(rt.call_function('wp_scripts', []rt.PhpVal{}), 'do_items', [rt.create_array([rt.ArrayItem{ key: none, val: 'wp-i18n' }])])
			}
			rt.call_function('wp_print_inline_script_tag', [var_output.dup(), rt.create_array([rt.ArrayItem{ key: 'id', val: var_script_id }])])
		}
	}
}

fn (mut this Class_WP_Script_Modules) add_hooks()  {
	mut var_is_block_theme := rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	mut var_position := rt.new_string(if rt.is_true(var_is_block_theme) { rt.new_string('wp_head') } else { rt.new_string('wp_footer') })
	rt.call_function('add_action', [var_position.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_import_map' }])])
	if rt.is_true(var_is_block_theme) {
		rt.call_function('add_action', [rt.new_string('wp_head'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_head_enqueued_script_modules' }])])
	}
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_enqueued_script_modules' }])])
	rt.call_function('add_action', [var_position.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_script_module_preloads' }])])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_import_map' }]), rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_enqueued_script_modules' }])])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_script_module_preloads' }])])
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_script_module_translations' }]), rt.new_int(21)])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_script_module_translations' }]), rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_script_module_data' }])])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_script_module_data' }])])
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_a11y_script_module_html' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_a11y_script_module_html' }]), rt.new_int(20)])
}

fn (mut this Class_WP_Script_Modules) get_highest_fetchpriority(mut var_ids Class_array) string {
	mut var_ids_mutated := var_ids
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.identical(rt.new_null(), var_high_priority_index)) {
		mut var_high_priority_index := rt.new_int(this.priorities.array_count() - 1)
	}
	mut var_highest_priority_index := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_ids_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			if this.registered.array_isset(var_id) {
				var_highest_priority_index = // unsupported expression: Expr_Cast_Int
				if rt.is_true(rt.identical(var_high_priority_index, var_highest_priority_index)) {
					break
				}
			}
		}
	}
	return (this.priorities.array_get(var_highest_priority_index)).str()
}

fn (mut this Class_WP_Script_Modules) print_head_enqueued_script_modules()  {
	{
		mut iter_1 := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue), rt.new_null()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			if rt.is_true(rt.new_bool(this.registered.array_isset(var_id) && rt.is_true(rt.new_bool(!(rt.is_true(this.registered.array_get(var_id).array_get('in_footer'))))))) {
				mut var_dependencies := rt.func_array_keys(this.get_dependencies(mut rt.cast_object_ptr[Class_array](rt.create_array([rt.ArrayItem{ key: none, val: var_id }])), rt.new_null()))
				{
					mut iter_2 := var_dependencies.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_dependency_id := item_2.val
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [var_dependency_id.dup(), this.queue, rt.new_bool(true)])) && this.registered.array_isset(var_dependency_id))) && rt.is_true(this.registered.array_get(var_dependency_id).array_get('in_footer')))) {
							continue
						}
					}
				}
				this.print_script_module((var_id).str())
			}
		}
	}
}

fn (mut this Class_WP_Script_Modules) print_enqueued_script_modules()  {
	{
		mut iter_1 := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue), rt.new_null()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			this.print_script_module((var_id).str())
		}
	}
}

fn (mut this Class_WP_Script_Modules) print_script_module(id string)  {
	mut id_mutated := id
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).dup(), this.done, rt.new_bool(true)])) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).dup(), this.queue, rt.new_bool(true)]))))))) {
		return rt.new_null()
	}
	this.done.array_push(id_mutated)
	mut var_src := rt.new_string(this.get_src(id_mutated))
	if rt.is_true(rt.identical(rt.new_string(''), var_src)) {
		return rt.new_null()
	}
	mut var_attributes := { 'type': rt.new_string('module'), 'src': var_src, 'id': id_mutated + '-js-module' }
	mut var_script_module := this.registered.array_get(id_mutated)
	mut var_queued_dependents := rt.call_function('array_intersect', [this.queue, this.get_recursive_dependents(id_mutated)])
	mut var_fetchpriority := rt.new_string(this.get_highest_fetchpriority(mut rt.cast_object_ptr[Class_array](rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: id_mutated }]), var_queued_dependents.dup()]))))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_attributes['fetchpriority'] = var_fetchpriority.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_attributes['data-wp-fetchpriority'] = var_script_module.array_get('fetchpriority')
	}
	rt.call_function('wp_print_script_tag', [var_attributes.dup()])
}

fn (mut this Class_WP_Script_Modules) print_script_module_preloads()  {
	mut var_dependency_ids := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue), mut rt.cast_object_ptr[Class_array](rt.create_array([rt.ArrayItem{ key: none, val: 'static' }])))
	{
		mut iter_1 := var_dependency_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_id := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_id.dup(), this.queue, rt.new_bool(true)])) {
				continue
			}
			mut var_src := rt.new_string(this.get_src((var_id).str()))
			if rt.is_true(rt.identical(rt.new_string(''), var_src)) {
				continue
			}
			mut var_enqueued_dependents := rt.call_function('array_intersect', [this.get_recursive_dependents((var_id).str()), this.queue])
			mut var_highest_fetchpriority := rt.new_string(this.get_highest_fetchpriority(mut rt.cast_object_ptr[Class_array](var_enqueued_dependents)))
			rt.call_function('printf', [rt.new_string('<link rel="modulepreload" href="%s" id="%s"'), rt.call_function('esc_url', [var_src.dup()]), rt.call_function('esc_attr', [().str() + ])])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_function('printf', [, ])
			}
			if rt.is_true(rt.new_bool(rt.is_true() && rt.is_true())) {
				
			}
			print('>\n')
		}
	}
}

fn (mut this Class_WP_Script_Modules) print_import_map()  {
}

fn (mut this Class_WP_Script_Modules) get_import_map() rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
}

fn (mut this Class_WP_Script_Modules) get_marked_for_enqueue() rt.PhpVal {
}

fn (mut this Class_WP_Script_Modules) get_dependencies(mut var_ids Class_array, mut var_import_types Class_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
}

fn (mut this Class_WP_Script_Modules) get_dependents(id string) rt.PhpVal {
	mut id_mutated := id
}

fn (mut this Class_WP_Script_Modules) get_recursive_dependents(id string) rt.PhpVal {
	mut id_mutated := id
}

fn (mut this Class_WP_Script_Modules) get_sorted_dependencies(mut var_ids Class_array, mut var_import_types Class_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
}

fn (mut this Class_WP_Script_Modules) sort_item_dependencies(id string, mut var_import_types Class_array, mut var_sorted Class_array) bool {
	mut id_mutated := id
	mut var_sorted_mutated := var_sorted
}

fn (mut this Class_WP_Script_Modules) get_registered(id string) rt.PhpVal {
	mut id_mutated := id
}

fn (mut this Class_WP_Script_Modules) get_src(id string) string {
	mut id_mutated := id
}

fn (mut this Class_WP_Script_Modules) print_script_module_data()  {
}

fn (mut this Class_WP_Script_Modules) print_a11y_script_module_html()  {
}

fn create_wp_script_modules() &Class_WP_Script_Modules {
	mut obj := &Class_WP_Script_Modules{
		PhpObjectBase: rt.PhpObjectBase{}
		registered: rt.new_array()
		queue: rt.new_array()
		done: rt.new_array()
		a11y_available: false
		dependents_map: rt.new_array()
		priorities: rt.new_array()
		modules_with_missing_dependencies: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Script_Modules) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.register(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'get_queue' {
			return this.get_queue()
		}
		'is_valid_fetchpriority' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_fetchpriority(dispatch_arg_0))
		}
		'set_fetchpriority' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_fetchpriority(dispatch_arg_0, dispatch_arg_1))
		}
		'set_in_footer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.set_in_footer(dispatch_arg_0, dispatch_arg_1))
		}
		'enqueue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_array](if args.len > 4 { args[4] } else { rt.new_null() })
			this.enqueue(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'dequeue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.dequeue(dispatch_arg_0)
			return rt.new_null()
		}
		'deregister' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.deregister(dispatch_arg_0)
			return rt.new_null()
		}
		'set_translations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_translations(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'print_script_module_translations' {
			this.print_script_module_translations()
			return rt.new_null()
		}
		'add_hooks' {
			this.add_hooks()
			return rt.new_null()
		}
		'get_highest_fetchpriority' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_highest_fetchpriority(mut dispatch_arg_0))
		}
		'print_head_enqueued_script_modules' {
			this.print_head_enqueued_script_modules()
			return rt.new_null()
		}
		'print_enqueued_script_modules' {
			this.print_enqueued_script_modules()
			return rt.new_null()
		}
		'print_script_module' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.print_script_module(dispatch_arg_0)
			return rt.new_null()
		}
		'print_script_module_preloads' {
			this.print_script_module_preloads()
			return rt.new_null()
		}
		'print_import_map' {
			this.print_import_map()
			return rt.new_null()
		}
		'get_import_map' {
			return this.get_import_map()
		}
		'get_marked_for_enqueue' {
			return this.get_marked_for_enqueue()
		}
		'get_dependencies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_dependencies(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_dependents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_dependents(dispatch_arg_0)
		}
		'get_recursive_dependents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_recursive_dependents(dispatch_arg_0)
		}
		'get_sorted_dependencies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_sorted_dependencies(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'sort_item_dependencies' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.sort_item_dependencies(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'get_registered' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_registered(dispatch_arg_0)
		}
		'get_src' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_src(dispatch_arg_0))
		}
		'print_script_module_data' {
			this.print_script_module_data()
			return rt.new_null()
		}
		'print_a11y_script_module_html' {
			this.print_a11y_script_module_html()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Script_Modules) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered' { return this.registered }
		'queue' { return this.queue }
		'done' { return this.done }
		'a11y_available' { return rt.new_bool(this.a11y_available) }
		'dependents_map' { return this.dependents_map }
		'priorities' { return this.priorities }
		'modules_with_missing_dependencies' { return this.modules_with_missing_dependencies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Script_Modules) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered' { this.registered = val; return true }
		'queue' { this.queue = val; return true }
		'done' { this.done = val; return true }
		'a11y_available' { this.a11y_available = (val).to_bool(); return true }
		'dependents_map' { this.dependents_map = val; return true }
		'priorities' { this.priorities = val; return true }
		'modules_with_missing_dependencies' { this.modules_with_missing_dependencies = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_script_modules_php() {
}
