import rt
import crypto.md5

struct Class_WP_Textdomain_Registry {
	rt.PhpObjectBase
pub mut:
		all rt.PhpVal = rt.new_array()
		current rt.PhpVal = rt.new_array()
		custom_paths rt.PhpVal = rt.new_array()
		cached_mo_files rt.PhpVal = rt.new_array()
		domains_with_translations rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Textdomain_Registry) init()  {
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Textdomain_Registry', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'invalidate_mo_files_cache' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WP_Textdomain_Registry) get(var_domain rt.PhpVal, var_locale rt.PhpVal) rt.PhpVal {
	mut var_path := if !(this.all.array_get(var_domain).array_get(var_locale)).is_null() { this.all.array_get(var_domain).array_get(var_locale) } else { this.get_path_from_lang_dir(var_domain.dup(), var_locale.dup()) }
	return rt.call_function('apply_filters', [rt.new_string('lang_dir_for_domain'), var_path.dup(), var_domain.dup(), var_locale.dup()])
}

fn (mut this Class_WP_Textdomain_Registry) has(var_domain rt.PhpVal) bool {
	return this.current.array_isset(var_domain) || !rt.is_true(this.all.array_get(var_domain)) || rt.is_true(rt.call_function('in_array', [var_domain.dup(), this.domains_with_translations, rt.new_bool(true)]))
}

fn (mut this Class_WP_Textdomain_Registry) set(var_domain rt.PhpVal, var_locale rt.PhpVal, var_path rt.PhpVal)  {
	mut var_path_mutated := var_path
	this.all.array_get_mut(var_domain).array_set(var_locale, if rt.is_true(var_path_mutated) { var_path_mutated.dup().to_string().trim_right(' \t\n\r') + '/' } else { rt.new_bool(false) })
	this.current.array_set(var_domain, this.all.array_get(var_domain).array_get(var_locale))
}

fn (mut this Class_WP_Textdomain_Registry) set_custom_path(var_domain rt.PhpVal, var_path rt.PhpVal)  {
	mut var_path_mutated := var_path
	if this.all.array_isset(var_domain) {
		this.all.array_set(var_domain, rt.call_function('array_filter', [this.all.array_get(var_domain)]))
	}
	if !rt.is_true(this.current.array_get(var_domain)) {
		this.current.array_unset(var_domain)
	}
	this.custom_paths.array_set(var_domain, var_path_mutated.dup().to_string().trim_right(' \t\n\r'))
}

fn (mut this Class_WP_Textdomain_Registry) get_language_files_from_path(var_path rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	var_path_mutated = rt.new_string(var_path_mutated.dup().to_string().trim_right(' \t\n\r') + '/')
	mut var_files := rt.call_function('apply_filters', [rt.new_string('pre_get_language_files_from_path'), rt.new_null(), var_path_mutated.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_files.dup()
	}
	mut var_cache_key := rt.new_string(rt.new_string(md5.hexhash(var_path_mutated.dup().to_string())))
	var_files = rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string('translation_files')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_files)) {
		var_files = rt.call_function('glob', [(var_path_mutated).str() + '*.mo'])
		if rt.is_true(rt.identical(rt.new_bool(false), var_files)) {
			var_files = rt.new_array()
		}
		mut var_php_files := rt.call_function('glob', [(var_path_mutated).str() + '*.l10n.php'])
		if rt.is_true(rt.new_bool(var_php_files.dup().is_array())) {
			var_files = rt.call_function('array_merge', [var_files.dup(), var_php_files.dup()])
		}
		rt.call_function('wp_cache_set', [var_cache_key.dup(), var_files.dup(), rt.new_string('translation_files'), rt.get_constant('HOUR_IN_SECONDS')])
	}
	return var_files.dup()
}

fn (mut this Class_WP_Textdomain_Registry) invalidate_mo_files_cache(var_upgrader rt.PhpVal, var_hook_extra rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_hook_extra.array_isset(rt.new_string('type'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) || rt.is_true(rt.identical(rt.new_array(), var_hook_extra.array_get('translations'))))) {
		return rt.new_null()
	}
	mut var_translation_types := rt.call_function('array_unique', [rt.call_function('wp_list_pluck', [var_hook_extra.array_get('translations'), rt.new_string('type')])])
	{
		mut iter_1 := var_translation_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			mut switch_val_1 := var_type
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin'))) {
				rt.call_function('wp_cache_delete', [rt.new_string(md5.hexhash((rt.get_constant('WP_LANG_DIR')).str() + '/plugins/')), rt.new_string('translation_files')])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
				rt.call_function('wp_cache_delete', [rt.new_string(md5.hexhash((rt.get_constant('WP_LANG_DIR')).str() + '/themes/')), rt.new_string('translation_files')])
			} else {
				rt.call_function('wp_cache_delete', [rt.new_string(md5.hexhash((rt.get_constant('WP_LANG_DIR')).str() + '/')), rt.new_string('translation_files')])
			}
		}
	}
}

fn (mut this Class_WP_Textdomain_Registry) get_paths_for_domain(var_domain rt.PhpVal) rt.PhpVal {
	mut var_locations := rt.create_array([rt.ArrayItem{ key: none, val: (rt.get_constant('WP_LANG_DIR')).str() + '/plugins' }, rt.ArrayItem{ key: none, val: (rt.get_constant('WP_LANG_DIR')).str() + '/themes' }])
	if this.custom_paths.array_isset(var_domain) {
		var_locations.array_push(this.custom_paths.array_get(var_domain))
	}
	return var_locations.dup()
}

fn (mut this Class_WP_Textdomain_Registry) get_path_from_lang_dir(var_domain rt.PhpVal, var_locale rt.PhpVal) bool {
	mut var_locations := this.get_paths_for_domain(var_domain.dup())
	mut var_found_location := rt.new_bool(rt.new_bool(false))
	{
		mut iter_1 := var_locations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_location := item_1.val
			mut var_files := this.get_language_files_from_path(var_location.dup())
			mut var_mo_path := rt.new_string(rt.new_string("${var_location.to_string()}/${var_domain.to_string()}-${var_locale.to_string()}.mo"))
			mut var_php_path := rt.new_string(rt.new_string("${var_location.to_string()}/${var_domain.to_string()}-${var_locale.to_string()}.l10n.php"))
			{
				mut iter_2 := var_files.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_file_path := item_2.val
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_domain.dup(), this.domains_with_translations, rt.new_bool(true)]))))) && rt.is_true(rt.call_function('str_starts_with', [rt.call_function('str_replace', [rt.new_string("${var_location.to_string()}/"), rt.new_string(''), var_file_path.dup()]), rt.new_string("${var_domain.to_string()}-")])))) {
						this.domains_with_translations.array_push(var_domain.dup())
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_file_path, var_mo_path)) || rt.is_true(rt.identical(var_file_path, var_php_path)))) {
						var_found_location = rt.new_string(var_location.dup().to_string().trim_right(' \t\n\r') + '/')
						break
					}
				}
			}
		}
	}
	if rt.is_true(var_found_location) {
		this.set(var_domain.dup(), var_locale.dup(), var_found_location.dup())
		return (var_found_location).to_bool()
	}
	if this.custom_paths.array_isset(var_domain) {
		mut var_fallback_location := rt.new_string(this.custom_paths.array_get(var_domain).to_string().trim_right(' \t\n\r') + '/')
		this.set(var_domain.dup(), var_locale.dup(), var_fallback_location.dup())
		return (var_fallback_location).to_bool()
	}
	this.set(var_domain.dup(), var_locale.dup(), rt.new_bool(false))
	return false
}

fn create_wp_textdomain_registry() &Class_WP_Textdomain_Registry {
	mut obj := &Class_WP_Textdomain_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		all: rt.new_array()
		current: rt.new_array()
		custom_paths: rt.new_array()
		cached_mo_files: rt.new_array()
		domains_with_translations: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Textdomain_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		'has' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has(dispatch_arg_0))
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'set_custom_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_custom_path(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_language_files_from_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_language_files_from_path(dispatch_arg_0)
		}
		'invalidate_mo_files_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.invalidate_mo_files_cache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_paths_for_domain' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_paths_for_domain(dispatch_arg_0)
		}
		'get_path_from_lang_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.get_path_from_lang_dir(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WP_Textdomain_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'all' { return this.all }
		'current' { return this.current }
		'custom_paths' { return this.custom_paths }
		'cached_mo_files' { return this.cached_mo_files }
		'domains_with_translations' { return this.domains_with_translations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Textdomain_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'all' { this.all = val; return true }
		'current' { this.current = val; return true }
		'custom_paths' { this.custom_paths = val; return true }
		'cached_mo_files' { this.cached_mo_files = val; return true }
		'domains_with_translations' { this.domains_with_translations = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_textdomain_registry_php() {
}
