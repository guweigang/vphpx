import rt

struct Class_WP_Translation_Controller {
	rt.PhpObjectBase
pub mut:
		current_locale rt.PhpVal = rt.new_string('en_US')
		loaded_translations rt.PhpVal = rt.new_array()
		loaded_files rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn Class_WP_Translation_Controller.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WP_Translation_Controller) get_locale() string {
	return (this.current_locale).str()
}

fn (mut this Class_WP_Translation_Controller) set_locale(locale string)  {
	mut locale_mutated := locale
	this.current_locale = rt.new_string(locale_mutated).dup()
}

fn (mut this Class_WP_Translation_Controller) load_file(translation_file string, textdomain string, mut var_locale Class_?string) bool {
	mut translation_file_mutated := translation_file
	mut var_locale_mutated := var_locale
	if rt.is_true(rt.identical(rt.new_null(), var_locale_mutated)) {
		var_locale_mutated = this.current_locale
	}
	translation_file_mutated = (rt.call_function('realpath', [rt.new_string(translation_file_mutated).dup()])).str()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_string(translation_file_mutated))) {
		return false
	}
	if rt.is_true(rt.new_bool(this.loaded_files.array_get(translation_file_mutated).array_get(var_locale_mutated).array_isset(rt.new_string(textdomain)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return (rt.identical(rt.new_null(), rt.call_method(this.loaded_files.array_get(translation_file_mutated).array_get(var_locale_mutated).array_get(textdomain), 'error', []rt.PhpVal{}))).to_bool()
	}
	if rt.is_true(rt.new_bool(this.loaded_files.array_get(translation_file_mutated).array_isset(var_locale_mutated) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_moe := rt.call_function('reset', [this.loaded_files.array_get(translation_file_mutated).array_get(var_locale_mutated)])
	} else {
		var_moe = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Translation_File{}; return temp.create(arg_0) }(rt.new_string(translation_file_mutated))
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_moe)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_moe = rt.new_bool(rt.new_bool(false))
		}
	}
	this.loaded_files.array_get_mut(translation_file_mutated).array_get_mut(var_locale_mutated).array_set(textdomain, var_moe.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_moe, 'WP_Translation_File')))))) {
		return false
	}
	if !(this.loaded_translations.array_get(var_locale_mutated).array_isset(rt.new_string(textdomain))) {
		this.loaded_translations.array_get_mut(var_locale_mutated).array_set(textdomain, rt.new_array())
	}
	this.loaded_translations.array_get_mut(var_locale_mutated).array_get_mut(textdomain).array_push(var_moe.dup())
	return true
}

fn (mut this Class_WP_Translation_Controller) unload_file(var_file rt.PhpVal, textdomain string, mut var_locale Class_?string) bool {
	mut var_file_mutated := var_file
	mut var_locale_mutated := var_locale
	if rt.is_true(rt.new_bool(var_file_mutated.dup().is_string())) {
		var_file_mutated = rt.call_function('realpath', [var_file_mutated.dup()])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if this.loaded_translations.array_get(var_locale_mutated).array_isset(rt.new_string(textdomain)) {
			{
				mut iter_1 := this.loaded_translations.array_get(var_locale_mutated).array_get(textdomain).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_moe := item_1.val
					mut var_i := item_1.key
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_file_mutated, var_moe)) || rt.is_true(rt.identical(var_file_mutated, rt.call_method(var_moe, 'get_file', []rt.PhpVal{}))))) {
						this.loaded_translations.array_get(var_locale_mutated).array_get(textdomain).array_unset(var_i)
						this.loaded_files.array_get(rt.call_method(var_moe, 'get_file', []rt.PhpVal{})).array_get(var_locale_mutated).array_unset(rt.new_string(textdomain))
						return true
					}
				}
			}
		}
		return true
	}
	{
		mut iter_1 := this.loaded_translations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_domains := item_1.val
			mut var_l := item_1.key
			if !(var_domains.array_isset(rt.new_string(textdomain))) {
				continue
			}
			{
				mut iter_2 := var_domains.array_get(textdomain).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_moe := item_2.val
					mut var_i := item_2.key
					if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_file_mutated, var_moe)) || rt.is_true(rt.identical(var_file_mutated, rt.call_method(var_moe, 'get_file', []rt.PhpVal{}))))) {
						this.loaded_translations.array_get(var_l).array_get(textdomain).array_unset(var_i)
						this.loaded_files.array_get(rt.call_method(var_moe, 'get_file', []rt.PhpVal{})).array_get(var_l).array_unset(rt.new_string(textdomain))
						return true
					}
				}
			}
		}
	}
	return false
}

fn (mut this Class_WP_Translation_Controller) unload_textdomain(textdomain string, mut var_locale Class_?string) bool {
	mut var_locale_mutated := var_locale
	mut var_unloaded := rt.new_bool(rt.new_bool(false))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if this.loaded_translations.array_get(var_locale_mutated).array_isset(rt.new_string(textdomain)) {
			var_unloaded = rt.new_bool(rt.new_bool(true))
			{
				mut iter_1 := this.loaded_translations.array_get(var_locale_mutated).array_get(textdomain).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_moe := item_1.val
					this.loaded_files.array_get(rt.call_method(var_moe, 'get_file', []rt.PhpVal{})).array_get(var_locale_mutated).array_unset(rt.new_string(textdomain))
				}
			}
		}
		this.loaded_translations.array_get(var_locale_mutated).array_unset(rt.new_string(textdomain))
		return (var_unloaded).to_bool()
	}
	{
		mut iter_1 := this.loaded_translations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_domains := item_1.val
			mut var_l := item_1.key
			if !(var_domains.array_isset(rt.new_string(textdomain))) {
				continue
			}
			var_unloaded = rt.new_bool(rt.new_bool(true))
			{
				mut iter_2 := var_domains.array_get(textdomain).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_moe := item_2.val
					this.loaded_files.array_get(rt.call_method(var_moe, 'get_file', []rt.PhpVal{})).array_get(var_l).array_unset(rt.new_string(textdomain))
				}
			}
			this.loaded_translations.array_get(var_l).array_unset(rt.new_string(textdomain))
		}
	}
	return (var_unloaded).to_bool()
}

fn (mut this Class_WP_Translation_Controller) is_textdomain_loaded(textdomain string, mut var_locale Class_?string) bool {
	mut var_locale_mutated := var_locale
	if rt.is_true(rt.identical(rt.new_null(), var_locale_mutated)) {
		var_locale_mutated = this.current_locale
	}
	return this.loaded_translations.array_get(var_locale_mutated).array_isset(rt.new_string(textdomain)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)
}

fn (mut this Class_WP_Translation_Controller) translate(text string, context string, textdomain string, mut var_locale Class_?string) bool {
	mut text_mutated := text
	mut var_locale_mutated := var_locale
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_translation := this.locate_translation("${var_context}${var_text.to_string()}", textdomain, mut var_locale_mutated)
	if rt.is_true(rt.identical(rt.new_bool(false), var_translation)) {
		return false
	}
	return (var_translation.array_get('entries').array_get(0)).to_bool()
}

fn (mut this Class_WP_Translation_Controller) translate_plural(mut var_plurals Class_array, number i64, context string, textdomain string, mut var_locale Class_?string) bool {
	mut var_locale_mutated := var_locale
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_text := rt.call_function('implode', [rt.new_string(''), var_plurals])
	mut var_translation := this.locate_translation("${var_context}${var_text.to_string()}", textdomain, mut var_locale_mutated)
	if rt.is_true(rt.identical(rt.new_bool(false), var_translation)) {
		var_text = var_plurals.array_get(0)
		var_translation = this.locate_translation("${var_context}${var_text.to_string()}", textdomain, mut var_locale_mutated)
		if rt.is_true(rt.identical(rt.new_bool(false), var_translation)) {
			return false
		}
	}
	mut var_source := var_translation.array_get('source')
	mut var_num := rt.call_method(var_source, 'get_plural_form', [rt.new_int(number)])
	return (if !(var_translation.array_get('entries').array_get(var_num)).is_null() { var_translation.array_get('entries').array_get(var_num) } else { var_translation.array_get('entries').array_get(0) }).to_bool()
}

fn (mut this Class_WP_Translation_Controller) get_headers(textdomain string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_array(), this.loaded_translations)) {
		return rt.new_array()
	}
	mut var_headers := rt.new_array()
	{
		mut iter_1 := this.get_files(textdomain, rt.new_null()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_moe := item_1.val
			{
				mut iter_2 := rt.call_method(var_moe, 'headers', []rt.PhpVal{}).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_value := item_2.val
					mut var_header := item_2.key
					var_headers.array_set(this.normalize_header((var_header).str()), var_value.dup())
				}
			}
		}
	}
	return var_headers.dup()
}

fn (mut this Class_WP_Translation_Controller) normalize_header(header string) string {
	mut var_parts := rt.call_function('explode', [rt.new_string('-'), rt.new_string(header)])
	var_parts = rt.call_function('array_map', [rt.new_string('ucfirst'), var_parts.dup()])
	return (rt.call_function('implode', [rt.new_string('-'), var_parts.dup()])).str()
}

fn (mut this Class_WP_Translation_Controller) get_entries(textdomain string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_array(), this.loaded_translations)) {
		return rt.new_array()
	}
	mut var_entries := rt.new_array()
	{
		mut iter_1 := this.get_files(textdomain, rt.new_null()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_moe := item_1.val
			var_entries = rt.call_function('array_merge', [var_entries.dup(), rt.call_method(var_moe, 'entries', []rt.PhpVal{})])
		}
	}
	return var_entries.dup()
}

fn (mut this Class_WP_Translation_Controller) locate_translation(singular string, textdomain string, mut var_locale Class_?string) rt.PhpVal {
	mut var_locale_mutated := var_locale
	if rt.is_true(rt.identical(rt.new_array(), this.loaded_translations)) {
		return rt.new_bool(false)
	}
	{
		mut iter_1 := this.get_files(textdomain, mut var_locale_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_moe := item_1.val
			mut var_translation := rt.call_method(var_moe, 'translate', [rt.new_string(singular)])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return rt.create_array([rt.ArrayItem{ key: 'entries', val: rt.call_function('explode', [rt.new_string(''), var_translation.dup()]) }, rt.ArrayItem{ key: 'source', val: var_moe }])
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				this.unload_file(var_moe.dup(), textdomain, mut var_locale_mutated)
			}
		}
	}
	return rt.new_bool(false)
}

fn (mut this Class_WP_Translation_Controller) get_files(textdomain string, mut var_locale Class_?string) rt.PhpVal {
	mut var_locale_mutated := var_locale
	if rt.is_true(rt.identical(rt.new_null(), var_locale_mutated)) {
		var_locale_mutated = this.current_locale
	}
	return if !(this.loaded_translations.array_get(var_locale_mutated).array_get(textdomain)).is_null() { this.loaded_translations.array_get(var_locale_mutated).array_get(textdomain) } else { rt.new_array() }
}

fn (mut this Class_WP_Translation_Controller) has_translation(singular string, textdomain string, mut var_locale Class_?string) bool {
	mut var_locale_mutated := var_locale
	if rt.is_true(rt.identical(rt.new_null(), var_locale_mutated)) {
		var_locale_mutated = this.current_locale
	}
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

struct Class_WP_Translation_File {
	rt.PhpObjectBase
}

fn create_wp_translation_controller() &Class_WP_Translation_Controller {
	mut obj := &Class_WP_Translation_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		current_locale: rt.new_string('en_US')
		loaded_translations: rt.new_array()
		loaded_files: rt.new_array()
		instance: rt.new_null()
	}
	return obj
}

fn create_wp_translation_file() &Class_WP_Translation_File {
	mut obj := &Class_WP_Translation_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Translation_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_WP_Translation_Controller.get_instance()
		}
		'get_locale' {
			return rt.new_string(this.get_locale())
		}
		'set_locale' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_locale(dispatch_arg_0)
			return rt.new_null()
		}
		'load_file' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.load_file(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'unload_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.unload_file(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'unload_textdomain' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.unload_textdomain(dispatch_arg_0, mut dispatch_arg_1))
		}
		'is_textdomain_loaded' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.is_textdomain_loaded(dispatch_arg_0, mut dispatch_arg_1))
		}
		'translate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_bool(this.translate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3))
		}
		'translate_plural' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			return rt.new_bool(this.translate_plural(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, mut dispatch_arg_4))
		}
		'get_headers' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_headers(dispatch_arg_0)
		}
		'normalize_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_header(dispatch_arg_0))
		}
		'get_entries' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_entries(dispatch_arg_0)
		}
		'locate_translation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.locate_translation(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_files' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_files(dispatch_arg_0, mut dispatch_arg_1)
		}
		'has_translation' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.has_translation(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_WP_Translation_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'current_locale' { return this.current_locale }
		'loaded_translations' { return this.loaded_translations }
		'loaded_files' { return this.loaded_files }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Translation_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'current_locale' { this.current_locale = val; return true }
		'loaded_translations' { this.loaded_translations = val; return true }
		'loaded_files' { this.loaded_files = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Translation_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translation_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_l10n_class_wp_translation_controller_php() {
}
