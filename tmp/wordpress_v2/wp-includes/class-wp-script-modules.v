import rt

struct Class_WP_Script_Modules {
	rt.PhpObjectBase
pub mut:
	registered                        rt.PhpVal = rt.new_array()
	queue                             rt.PhpVal = rt.new_array()
	done                              rt.PhpVal = rt.new_array()
	a11y_available                    bool
	dependents_map                    rt.PhpVal = rt.new_array()
	priorities                        rt.PhpVal = rt.new_array()
	modules_with_missing_dependencies rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Script_Modules) register(id string, src string, mut var_deps Class_array, version bool, mut var_args Class_array) {
	mut id_mutated := id
	mut src_mutated := src
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(id_mutated))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [rt.new_string('Non-empty string required for id.')]),
			rt.new_string('6.9.0')])
		return
	}
	if !(this.registered.array_isset(rt.new_string(id_mutated))) {
		mut var_dependencies := rt.new_array()
		mut iter_1 := var_deps.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependency := item_1.val
			if rt.is_true(rt.new_bool(var_dependency.clone().is_array())) {
				if !(var_dependency.array_isset(rt.new_string('id')))
					|| !(var_dependency.array_get(rt.new_string('id')).is_string()) {
					rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
						rt.call_function('__', [
							rt.new_string('Missing required id key in entry among dependencies array.'),
						]),
						rt.new_string('6.5.0')])
					continue
				}
				var_dependencies.array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_dependency.array_get(rt.new_string('id')) },
					rt.ArrayItem{
						key: 'import'
						val: if var_dependency.array_isset(rt.new_string('import'))
							&& rt.is_true(rt.identical(rt.new_string('dynamic'), var_dependency.array_get(rt.new_string('import')))) {
							'dynamic'
						} else {
							'static'
						}
					},
				]))
			} else if rt.is_true(rt.new_bool(var_dependency.clone().is_string())) {
				var_dependencies.array_push(rt.create_array([
					rt.ArrayItem{ key: 'id', val: var_dependency },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]))
			} else {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('__', [
						rt.new_string('Entries in dependencies array must be either strings or arrays with an id key.'),
					]),
					rt.new_string('6.5.0')])
			}
		}
		mut var_in_footer := rt.new_bool(var_args.array_isset(rt.new_string('in_footer'))
			&& rt.is_true((var_args.array_get(rt.new_string('in_footer'))).to_bool()))
		mut var_fetchpriority := rt.new_string('auto')
		if var_args.array_isset(rt.new_string('fetchpriority')) {
			if this.is_valid_fetchpriority(var_args.array_get(rt.new_string('fetchpriority'))) {
				var_fetchpriority = var_args.array_get(rt.new_string('fetchpriority'))
			} else {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Invalid fetchpriority `%1$s` defined for `%2$s` during script registration.'),
						]),
						if var_args.array_get(rt.new_string('fetchpriority')).is_string() { var_args.array_get(rt.new_string('fetchpriority')) } else { rt.call_function('gettype', [
								var_args.array_get(rt.new_string('fetchpriority')),
							]) },
						rt.new_string(id_mutated).clone(),
					]),
					rt.new_string('6.9.0')])
			}
		}
		this.registered.array_set(id_mutated, rt.create_array([
			rt.ArrayItem{ key: 'src', val: src_mutated },
			rt.ArrayItem{ key: 'version', val: version },
			rt.ArrayItem{ key: 'dependencies', val: var_dependencies },
			rt.ArrayItem{ key: 'in_footer', val: var_in_footer },
			rt.ArrayItem{ key: 'fetchpriority', val: var_fetchpriority },
		]))
	}
}

fn (mut this Class_WP_Script_Modules) get_queue() rt.PhpVal {
	return this.queue
}

fn (mut this Class_WP_Script_Modules) is_valid_fetchpriority(var_priority rt.PhpVal) bool {
	mut var_priority_mutated := var_priority
	return (rt.call_function('in_array', [var_priority_mutated.clone(), this.priorities,
		rt.new_bool(true)])).to_bool()
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
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Invalid fetchpriority: %s')]),
				rt.new_string(priority_mutated).clone(),
			]),
			rt.new_string('6.9.0')])
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

fn (mut this Class_WP_Script_Modules) enqueue(id string, src string, mut var_deps Class_array, version bool, mut var_args Class_array) {
	mut id_mutated := id
	mut src_mutated := src
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(id_mutated))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [rt.new_string('Non-empty string required for id.')]),
			rt.new_string('6.9.0')])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(id_mutated).clone(), this.queue, rt.new_bool(true)])))))
	{
		this.queue.array_push(id_mutated)
	}
	if !(this.registered.array_isset(rt.new_string(id_mutated)))
		&& rt.is_true(rt.new_string(src_mutated)) {
		this.register(id_mutated, src_mutated, mut var_deps, version, mut var_args)
	}
}

fn (mut this Class_WP_Script_Modules) dequeue(id string) {
	mut id_mutated := id
	this.queue = rt.call_function('array_values', [
		rt.call_function('array_diff', [this.queue,
			rt.create_array([rt.ArrayItem{ key: none, val: id_mutated }])]),
	])
}

fn (mut this Class_WP_Script_Modules) deregister(id string) {
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

fn (mut this Class_WP_Script_Modules) print_script_module_translations() {
	mut var_module_ids := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue),
		rt.new_null())
	mut var_set_locale_data_js_function :=
		rt.new_string('( domain, translations ) => {\n\tconst localeData = translations.locale_data[ domain ] || translations.locale_data.messages;\n\tlocaleData[""].domain = domain;\n\twp.i18n.setLocaleData( localeData, domain );\n}')
	mut iter_2 := var_module_ids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_id := item_2.val
		mut var_domain := if !(this.registered.array_get(var_id).array_get(rt.new_string('textdomain'))).is_null() {
			this.registered.array_get(var_id).array_get(rt.new_string('textdomain'))
		} else {
			rt.new_string('default')
		}
		mut var_path := if !(this.registered.array_get(var_id).array_get(rt.new_string('translations_path'))).is_null() {
			this.registered.array_get(var_id).array_get(rt.new_string('translations_path'))
		} else {
			rt.new_string('')
		}
		mut var_json_translations := rt.call_function('load_script_module_textdomain', [
			var_id.clone(),
			var_domain.clone(),
			var_path.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_json_translations)))) {
			continue
		}
		mut var_output := rt.call_function('sprintf', [
			rt.new_string('( %s )( %s, %s );'),
			var_set_locale_data_js_function.clone(),
			rt.call_function('wp_json_encode', [var_domain.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
			var_json_translations.clone(),
		])
		mut var_script_id :=
			rt.new_string('wp-script-module-translation-data-${var_id.to_string()}')
		var_output = rt.concat(var_output, rt.new_string('\n//# sourceURL=' +
			(rt.call_function('rawurlencode', [var_script_id.clone()])).str()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
			rt.new_string('wp-i18n'),
			rt.new_string('done'),
		])))))
		{
			rt.call_method(rt.call_function('wp_scripts', []rt.PhpVal{}), 'do_items', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'wp-i18n' }]),
			])
		}
		rt.call_function('wp_print_inline_script_tag', [var_output.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: var_script_id }])])
	}
}

fn (mut this Class_WP_Script_Modules) add_hooks() {
	mut var_is_block_theme := rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	mut var_position := rt.new_string((if rt.is_true(var_is_block_theme) {
		'wp_head'
	} else {
		'wp_footer'
	}).str())
	rt.call_function('add_action', [var_position.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_import_map' },
		])])
	if rt.is_true(var_is_block_theme) {
		rt.call_function('add_action', [rt.new_string('wp_head'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
				rt.ArrayItem{ key: none, val: 'print_head_enqueued_script_modules' },
			])])
	}
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_enqueued_script_modules' },
		])])
	rt.call_function('add_action', [var_position.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_script_module_preloads' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_import_map' },
		]),
		rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_enqueued_script_modules' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_script_module_preloads' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_script_module_translations' },
		]),
		rt.new_int(21)])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_script_module_translations' },
		]),
		rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_script_module_data' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_script_module_data' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_a11y_script_module_html' },
		]),
		rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Script_Modules', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'print_a11y_script_module_html' },
		]),
		rt.new_int(20)])
}

fn (mut this Class_WP_Script_Modules) get_highest_fetchpriority(mut var_ids Class_array) string {
	mut var_ids_mutated := var_ids
	mut var_high_priority_index := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_high_priority_index)) {
		var_high_priority_index = rt.new_int(this.priorities.array_count() - 1)
	}
	mut var_highest_priority_index := rt.new_int(0)
	mut iter_3 := var_ids_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_id := item_3.val
		if this.registered.array_isset(var_id) {
			var_highest_priority_index = rt.new_int((rt.call_function('max', [
				var_highest_priority_index.clone(),
				rt.new_int((rt.call_function('array_search', [
					this.registered.array_get(var_id).array_get(rt.new_string('fetchpriority')),
					this.priorities,
					rt.new_bool(true),
				])).to_i64())])).to_i64())
			if rt.is_true(rt.identical(var_high_priority_index, var_highest_priority_index)) {
				break
			}
		}
	}
	return (this.priorities.array_get(var_highest_priority_index)).str()
}

fn (mut this Class_WP_Script_Modules) print_head_enqueued_script_modules() {
	mut iter_4 := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue),
		rt.new_null()).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_id := item_4.val
		if this.registered.array_isset(var_id)
			&& rt.is_true(rt.new_bool(!(rt.is_true(this.registered.array_get(var_id).array_get(rt.new_string('in_footer')))))) {
			mut var_dependencies := rt.func_array_keys(this.get_dependencies(mut rt.cast_object_ptr[Class_array](rt.create_array([
				rt.ArrayItem{ key: none, val: var_id },
			])), rt.new_null()))
			mut iter_5 := var_dependencies.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_dependency_id := item_5.val
				if rt.is_true(rt.call_function('in_array', [var_dependency_id.clone(), this.queue, rt.new_bool(true)]))
					&& this.registered.array_isset(var_dependency_id)
					&& rt.is_true(this.registered.array_get(var_dependency_id).array_get(rt.new_string('in_footer'))) {
					continue
				}
			}
			this.print_script_module(var_id.str())
		}
	}
}

fn (mut this Class_WP_Script_Modules) print_enqueued_script_modules() {
	mut iter_6 := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue),
		rt.new_null()).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_id := item_6.val
		this.print_script_module(var_id.str())
	}
}

fn (mut this Class_WP_Script_Modules) print_script_module(id string) {
	mut id_mutated := id
	if rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).clone(), this.done, rt.new_bool(true)]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).clone(), this.queue, rt.new_bool(true)]))))) {
		return
	}
	this.done.array_push(id_mutated)
	mut var_src := rt.new_string(this.get_src(id_mutated))
	if rt.is_true(rt.identical(rt.new_string(''), var_src)) {
		return
	}
	mut var_attributes := {
		'type': rt.new_string('module')
		'src':  var_src
		'id':   id_mutated + '-js-module'
	}
	mut var_script_module := this.registered.array_get(rt.new_string(id_mutated))
	mut var_queued_dependents := rt.call_function('array_intersect', [this.queue,
		this.get_recursive_dependents(id_mutated)])
	mut var_fetchpriority := rt.new_string(this.get_highest_fetchpriority(mut rt.cast_object_ptr[Class_array](rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: id_mutated }]),
		var_queued_dependents.clone(),
	]))))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'), var_fetchpriority)))) {
		var_attributes['fetchpriority'] = var_fetchpriority.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_fetchpriority,
		var_script_module.array_get(rt.new_string('fetchpriority'))))))
	{
		var_attributes['data-wp-fetchpriority'] =
			var_script_module.array_get(rt.new_string('fetchpriority'))
	}
	rt.call_function('wp_print_script_tag', [
		rt.create_array_from_native_map(var_attributes),
	])
}

fn (mut this Class_WP_Script_Modules) print_script_module_preloads() {
	mut var_dependency_ids := this.get_sorted_dependencies(mut rt.cast_object_ptr[Class_array](this.queue), mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: 'static' },
	])))
	mut iter_7 := var_dependency_ids.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_id := item_7.val
		if rt.is_true(rt.call_function('in_array', [var_id.clone(), this.queue, rt.new_bool(true)])) {
			continue
		}
		mut var_src := rt.new_string(this.get_src(var_id.str()))
		if rt.is_true(rt.identical(rt.new_string(''), var_src)) {
			continue
		}
		mut var_enqueued_dependents := rt.call_function('array_intersect', [
			this.get_recursive_dependents(var_id.str()),
			this.queue,
		])
		mut var_highest_fetchpriority :=
			rt.new_string(this.get_highest_fetchpriority(mut rt.cast_object_ptr[Class_array](var_enqueued_dependents)))
		rt.call_function('printf', [
			rt.new_string('<link rel="modulepreload" href="%s" id="%s"'),
			rt.call_function('esc_url', [var_src.clone()]),
			rt.call_function('esc_attr', [rt.new_string(var_id.str() + '-js-modulepreload')]),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'),
			var_highest_fetchpriority))))
		{
			rt.call_function('printf', [rt.new_string(' fetchpriority="%s"'),
				rt.call_function('esc_attr', [var_highest_fetchpriority.clone()])])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_highest_fetchpriority, this.registered.array_get(var_id).array_get(rt.new_string('fetchpriority'))))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'), this.registered.array_get(var_id).array_get(rt.new_string('fetchpriority')))))) {
			rt.call_function('printf', [rt.new_string(' data-wp-fetchpriority="%s"'),
				rt.call_function('esc_attr', [
					this.registered.array_get(var_id).array_get(rt.new_string('fetchpriority')),
				])])
		}
		print('>\n')
	}
}

fn (mut this Class_WP_Script_Modules) print_import_map() {
	mut var_import_map := this.get_import_map()
	if !(!rt.is_true(var_import_map.array_get(rt.new_string('imports')))) {
		rt.call_function('wp_print_inline_script_tag', [
			rt.new_string((rt.call_function('wp_json_encode', [
				var_import_map.clone(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str()),
			rt.create_array([rt.ArrayItem{ key: 'type', val: 'importmap' },
				rt.ArrayItem{ key: 'id', val: 'wp-importmap' }]),
		])
	}
}

fn (mut this Class_WP_Script_Modules) get_import_map() rt.PhpVal {
	mut var_wp_scripts := rt.new_null()
	mut var_imports := rt.new_array()
	mut var_classic_script_module_dependencies := rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(var_wp_scripts, 'WP_Scripts'))) {
		mut var_handles := rt.call_function('array_merge', [
			rt.get_property(var_wp_scripts, 'queue'),
			rt.get_property(var_wp_scripts, 'to_do'),
			rt.get_property(var_wp_scripts, 'done'),
		])
		mut var_processed := rt.new_array()
		for !(!rt.is_true(var_handles)) {
			mut var_handle := rt.call_function('array_pop', [
				var_handles.clone()])
			if var_processed.array_isset(var_handle)
				|| !(rt.get_property(var_wp_scripts, 'registered').array_isset(var_handle)) {
				continue
			}
			var_processed.array_set(var_handle, true)
			mut var_module_dependencies := rt.call_method(var_wp_scripts, 'get_data', [
				var_handle.clone(),
				rt.new_string('module_dependencies'),
			])
			if rt.is_true(rt.new_bool(var_module_dependencies.clone().is_array())) {
				mut var_missing_module_dependencies := rt.new_array()
				mut iter_8 := var_module_dependencies.iterator()
				for {
					item_8 := iter_8.next() or { break }
					mut var_module := item_8.val
					if rt.is_true(rt.new_bool(var_module.clone().is_string())) {
						mut var_id := var_module
					} else if var_module.clone().is_array()
						&& var_module.array_isset(rt.new_string('id'))
						&& var_module.array_get(rt.new_string('id')).is_string() {
						var_id = var_module.array_get(rt.new_string('id'))
					} else {
						continue
					}
					if !(this.registered.array_isset(var_id)) {
						var_missing_module_dependencies << var_id.clone()
					} else {
						var_classic_script_module_dependencies << var_id.clone()
					}
				}
				if var_missing_module_dependencies.len > 0 {
					rt.call_function('_doing_it_wrong', [
						rt.new_string('WP_Scripts::add_data'),
						rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('The script with the handle "%1$s" was enqueued with script module dependencies ("%2$s") that are not registered: %3$s.'),
							]),
							var_handle.clone(),
							rt.new_string('module_dependencies'),
							rt.call_function('implode', [
								rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}),
								rt.create_array_from_list(var_missing_module_dependencies),
							]),
						]),
						rt.new_string('7.0.0'),
					])
				}
			}
			mut iter_9 := rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_handle),
				'deps').iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_dep := item_9.val
				if !(var_processed.array_isset(var_dep)) {
					var_handles.array_push(var_dep.clone())
				}
			}
		}
	}
	mut var_ids := rt.call_function('array_unique', [
		rt.call_function('array_merge', [
			rt.create_array_from_list(var_classic_script_module_dependencies),
			rt.func_array_keys(this.get_dependencies(mut rt.cast_object_ptr[Class_array](rt.call_function('array_merge', [
				this.queue,
				rt.create_array_from_list(var_classic_script_module_dependencies),
			])), rt.new_null())),
		]),
	])
	mut iter_10 := var_ids.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_id := item_10.val
		mut var_src := rt.new_string(this.get_src(var_id.str()))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_src)))) {
			var_imports.array_set(var_id, var_src.clone())
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'imports', val: var_imports }])
}

fn (mut this Class_WP_Script_Modules) get_marked_for_enqueue() rt.PhpVal {
	return rt.call_function('wp_array_slice_assoc', [this.registered, this.queue])
}

fn (mut this Class_WP_Script_Modules) get_dependencies(mut var_ids Class_array, mut var_import_types Class_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
	mut var_all_dependencies := rt.new_array()
	mut var_id_queue := var_ids_mutated
	for !(!rt.is_true(var_id_queue)) {
		mut var_id := rt.call_function('array_shift', [var_id_queue.clone()])
		if !(this.registered.array_isset(var_id)) {
			continue
		}
		mut iter_11 :=
			this.registered.array_get(var_id).array_get(rt.new_string('dependencies')).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_dependency := item_11.val
			if !(var_all_dependencies.array_isset(var_dependency.array_get(rt.new_string('id'))))
				&& rt.is_true(rt.call_function('in_array', [var_dependency.array_get(rt.new_string('import')), var_import_types, rt.new_bool(true)]))
				&& this.registered.array_isset(var_dependency.array_get(rt.new_string('id'))) {
				var_all_dependencies.array_set(var_dependency.array_get(rt.new_string('id')),
					this.registered.array_get(var_dependency.array_get(rt.new_string('id'))))
				var_id_queue.array_push(var_dependency.array_get(rt.new_string('id')))
			}
		}
	}
	return var_all_dependencies.clone()
}

fn (mut this Class_WP_Script_Modules) get_dependents(id string) rt.PhpVal {
	mut id_mutated := id
	if this.dependents_map.array_isset(rt.new_string(id_mutated)) {
		return this.dependents_map.array_get(rt.new_string(id_mutated))
	}
	mut var_dependents := rt.new_array()
	mut iter_12 := this.registered.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_args := item_12.val
		mut var_registered_id := item_12.key
		if rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).clone(),
			rt.call_function('wp_list_pluck', [
				var_args.array_get(rt.new_string('dependencies')),
				rt.new_string('id'),
			]),
			rt.new_bool(true)]))
		{
			var_dependents.array_push(var_registered_id.clone())
		}
	}
	this.dependents_map.array_set(id_mutated, var_dependents.clone())
	return var_dependents.clone()
}

fn (mut this Class_WP_Script_Modules) get_recursive_dependents(id string) rt.PhpVal {
	mut id_mutated := id
	mut var_dependents := rt.new_array()
	mut var_id_queue := rt.create_array([rt.ArrayItem{ key: none, val: id_mutated }])
	mut var_processed := rt.new_array()
	for !(!rt.is_true(var_id_queue)) {
		mut var_current_id := rt.call_function('array_shift', [
			var_id_queue.clone()])
		if !(this.registered.array_isset(var_current_id))
			|| var_processed.array_isset(var_current_id) {
			continue
		}
		var_processed.array_set(var_current_id, true)
		mut iter_13 := this.get_dependents(var_current_id.str()).iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_dependent_id := item_13.val
			if !(var_dependents.array_isset(var_dependent_id)) {
				var_dependents.array_set(var_dependent_id, true)
				var_id_queue.array_push(var_dependent_id.clone())
			}
		}
	}
	return rt.func_array_keys(var_dependents.clone())
}

fn (mut this Class_WP_Script_Modules) get_sorted_dependencies(mut var_ids Class_array, mut var_import_types Class_array) rt.PhpVal {
	mut var_ids_mutated := var_ids
	mut var_sorted := rt.new_array()
	mut iter_14 := var_ids_mutated.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_id := item_14.val
		this.sort_item_dependencies(var_id.str(), mut var_import_types, mut
			rt.cast_object_ptr[Class_array](var_sorted))
	}
	return rt.call_function('array_unique', [rt.create_array_from_list(var_sorted)])
}

fn (mut this Class_WP_Script_Modules) sort_item_dependencies(id string, mut var_import_types Class_array, mut var_sorted Class_array) bool {
	mut id_mutated := id
	mut var_sorted_mutated := var_sorted
	if rt.is_true(rt.call_function('in_array', [rt.new_string(id_mutated).clone(), var_sorted_mutated,
		rt.new_bool(true)]))
	{
		return true
	}
	if !(this.registered.array_isset(rt.new_string(id_mutated))) {
		return false
	}
	mut var_dependency_ids := rt.new_array()
	mut iter_15 :=
		this.registered.array_get(rt.new_string(id_mutated)).array_get(rt.new_string('dependencies')).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_dependency := item_15.val
		if rt.is_true(rt.call_function('in_array', [
			var_dependency.array_get(rt.new_string('import')),
			var_import_types,
			rt.new_bool(true),
		]))
		{
			var_dependency_ids.array_push(var_dependency.array_get(rt.new_string('id')))
		}
	}
	mut var_missing_dependencies := rt.call_function('array_diff', [
		var_dependency_ids.clone(), rt.func_array_keys(this.registered)])
	if var_missing_dependencies.clone().array_count() > 0 {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.new_string(id_mutated).clone(), this.modules_with_missing_dependencies,
			rt.new_bool(true)])))))
		{
			rt.call_function('_doing_it_wrong', [
				rt.new_string(
					(rt.call_function('get_class', [rt.new_object('WP_Script_Modules', []string{}, &this)])).str() +
					'::register'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The script module with the ID "%1$s" was enqueued with dependencies that are not registered: %2$s.'),
					]),
					rt.new_string(id_mutated).clone(),
					rt.call_function('implode', [
						rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}),
						var_missing_dependencies.clone(),
					]),
				]),
				rt.new_string('6.9.1'),
			])
			this.modules_with_missing_dependencies.array_push(id_mutated)
		}
		return false
	}
	mut iter_16 := var_dependency_ids.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_dependency_id := item_16.val
		if !(this.sort_item_dependencies(var_dependency_id.str(), mut var_import_types, mut
			var_sorted_mutated)) {
			return false
		}
	}
	var_sorted_mutated.array_push(id_mutated)
	return true
}

fn (mut this Class_WP_Script_Modules) get_registered(id string) rt.PhpVal {
	mut id_mutated := id
	return if !(this.registered.array_get(rt.new_string(id_mutated))).is_null() {
		this.registered.array_get(rt.new_string(id_mutated))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WP_Script_Modules) get_src(id string) string {
	mut id_mutated := id
	if !(this.registered.array_isset(rt.new_string(id_mutated))) {
		return ''
	}
	mut var_script_module := this.registered.array_get(rt.new_string(id_mutated))
	mut var_src := var_script_module.array_get(rt.new_string('src'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_src)))) {
		if rt.is_true(rt.identical(rt.new_bool(false),
			var_script_module.array_get(rt.new_string('version'))))
		{
			var_src = rt.call_function('add_query_arg', [rt.new_string('ver'),
				rt.call_function('get_bloginfo', [rt.new_string('version')]),
				var_src.clone()])
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
			var_script_module.array_get(rt.new_string('version'))))))
		{
			var_src = rt.call_function('add_query_arg', [rt.new_string('ver'),
				var_script_module.array_get(rt.new_string('version')),
				var_src.clone()])
		}
	}
	var_src = rt.call_function('apply_filters', [
		rt.new_string('script_module_loader_src'),
		var_src.clone(),
		rt.new_string(id_mutated).clone(),
	])
	if !(var_src.clone().is_string()) {
		var_src = rt.new_string('')
	}
	return var_src.str()
}

fn (mut this Class_WP_Script_Modules) print_script_module_data() {
	mut var_modules := rt.new_array()
	mut iter_17 := rt.call_function('array_unique', [this.queue]).iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_id := item_17.val
		if rt.is_true(rt.identical(rt.new_string('@wordpress/a11y'), var_id)) {
			this.a11y_available = true
		}
		var_modules.array_set(var_id, true)
	}
	mut iter_18 :=
		rt.func_array_keys(this.get_import_map().array_get(rt.new_string('imports'))).iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_id := item_18.val
		if rt.is_true(rt.identical(rt.new_string('@wordpress/a11y'), var_id)) {
			this.a11y_available = true
		}
		var_modules.array_set(var_id, true)
	}
	mut iter_19 := rt.func_array_keys(var_modules.clone()).iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_module_id := item_19.val
		mut var_data := rt.call_function('apply_filters', [
			rt.new_string('script_module_data_${var_module_id.to_string()}'),
			rt.new_array(),
		])
		if var_data.clone().is_array()
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_array(), var_data)))) {
			mut var_json_encode_flags := rt.new_int(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES')),
				rt.get_constant('JSON_UNESCAPED_UNICODE')),
				rt.get_constant('JSON_UNESCAPED_LINE_TERMINATORS')))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_utf8_charset',
				[]rt.PhpVal{})))))
			{
				var_json_encode_flags = rt.new_int(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')))
			}
			rt.call_function('wp_print_inline_script_tag', [
				rt.new_string((rt.call_function('wp_json_encode', [
					var_data.clone(), var_json_encode_flags.clone()])).str()),
				rt.create_array([rt.ArrayItem{ key: 'type', val: 'application/json' },
					rt.ArrayItem{
						key: 'id'
						val: 'wp-script-module-data-${var_module_id.to_string()}'
					}]),
			])
		}
	}
}

fn (mut this Class_WP_Script_Modules) print_a11y_script_module_html() {
	if !(this.a11y_available) {
		return
	}
	print(
		'<div style="position:absolute;margin:-1px;padding:0;height:1px;width:1px;overflow:hidden;clip-path:inset(50%);border:0;word-wrap:normal !important;">' +
		'<p id="a11y-speak-intro-text" class="a11y-speak-intro-text" hidden>' +
		(rt.call_function('esc_html__', [rt.new_string('Notifications')])).str() + '</p>' +
		'<div id="a11y-speak-assertive" class="a11y-speak-region" aria-live="assertive" aria-relevant="additions text" aria-atomic="true"></div>' +
		'<div id="a11y-speak-polite" class="a11y-speak-region" aria-live="polite" aria-relevant="additions text" aria-atomic="true"></div>' +
		'</div>')
}

fn create_wp_script_modules(_args ...rt.PhpVal) &Class_WP_Script_Modules {
	mut obj := &Class_WP_Script_Modules{
		PhpObjectBase:                     rt.PhpObjectBase{}
		registered:                        rt.new_array()
		queue:                             rt.new_array()
		done:                              rt.new_array()
		a11y_available:                    false
		dependents_map:                    rt.new_array()
		priorities:                        rt.new_array()
		modules_with_missing_dependencies: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Script_Modules) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_array](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			this.register(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut
				dispatch_arg_4)
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
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_array](if args.len > 4 {
				args[4]
			} else {
				rt.new_null()
			})
			this.enqueue(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3, mut
				dispatch_arg_4)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_sorted_dependencies(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'sort_item_dependencies' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.sort_item_dependencies(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
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
		else {
			return none
		}
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
		'registered' {
			this.registered = val
			return true
		}
		'queue' {
			this.queue = val
			return true
		}
		'done' {
			this.done = val
			return true
		}
		'a11y_available' {
			this.a11y_available = val.to_bool()
			return true
		}
		'dependents_map' {
			this.dependents_map = val
			return true
		}
		'priorities' {
			this.priorities = val
			return true
		}
		'modules_with_missing_dependencies' {
			this.modules_with_missing_dependencies = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
