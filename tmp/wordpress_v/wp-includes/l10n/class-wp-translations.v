import rt

struct Class_WP_Translations {
	rt.PhpObjectBase
pub mut:
		textdomain string
		controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Translations) construct(mut var_controller Class_WP_Translation_Controller, textdomain string)  {
	this.controller = var_controller.dup()
	this.textdomain = textdomain
}

fn (mut this Class_WP_Translations) magic_get(name string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('entries'), rt.new_string(name))) {
		mut var_entries := rt.call_method(this.controller, 'get_entries', [this.textdomain])
		mut var_result := []rt.PhpVal{}
		{
			mut iter_1 := var_entries.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_translations := item_1.val
				mut var_original := item_1.key
				var_result << this.make_entry(var_original.dup(), var_translations.dup())
			}
		}
		return var_result.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('headers'), rt.new_string(name))) {
		return rt.call_method(this.controller, 'get_headers', [this.textdomain])
	}
	return rt.new_null()
}

fn (mut this Class_WP_Translations) make_entry(var_original rt.PhpVal, var_translations rt.PhpVal) rt.PhpVal {
	mut var_original_mutated := var_original
	mut var_entry := create_translation_entry()
	mut var_parts := rt.call_function('explode', [rt.new_string(''), var_original_mutated.dup()])
	if var_parts.array_isset(rt.new_int(1)) {
		var_original_mutated = var_parts.array_get(1)
		rt.set_property(var_entry, 'context', var_parts.array_get(0))
	}
	rt.set_property(var_entry, 'singular', var_original_mutated.dup())
	rt.set_property(var_entry, 'translations', rt.call_function('explode', [rt.new_string(''), var_translations.dup()]))
	rt.set_property(var_entry, 'is_plural', rt.new_bool(rt.get_property(var_entry, 'translations').array_count() > 1))
	return mut var_entry
}

fn (mut this Class_WP_Translations) translate_plural(var_singular rt.PhpVal, var_plural rt.PhpVal, count i64, context string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_singular)) || rt.is_true(rt.identical(rt.new_null(), var_plural)))) {
		return var_singular.dup()
	}
	mut var_translation := rt.call_method(this.controller, 'translate_plural', [rt.create_array([rt.ArrayItem{ key: none, val: var_singular }, rt.ArrayItem{ key: none, val: var_plural }]), // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_String, this.textdomain])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_translation.dup()
	}
	return if rt.is_true(rt.identical(rt.new_int(1), // unsupported expression: Expr_Cast_Int)) { var_singular } else { var_plural }
}

fn (mut this Class_WP_Translations) translate(var_singular rt.PhpVal, context string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), var_singular)) {
		return rt.new_null()
	}
	mut var_translation := rt.call_method(this.controller, 'translate', [var_singular.dup(), // unsupported expression: Expr_Cast_String, this.textdomain])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_translation.dup()
	}
	return var_singular.dup()
}

struct Class_Translation_Entry {
	rt.PhpObjectBase
}

fn create_wp_translations(arg_0 rt.PhpVal, textdomain string) &Class_WP_Translations {
	mut obj := &Class_WP_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
		textdomain: ''
		controller: rt.new_null()
	}
	obj.construct(arg_0, textdomain)
	return obj
}

fn create_translation_entry() &Class_Translation_Entry {
	mut obj := &Class_Translation_Entry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Translation_Controller](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.magic_get(dispatch_arg_0)
		}
		'make_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.make_entry(dispatch_arg_0, dispatch_arg_1)
		}
		'translate_plural' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.translate_plural(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'translate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.translate(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'textdomain' { return rt.new_string(this.textdomain) }
		'controller' { return this.controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'textdomain' { this.textdomain = (val).str(); return true }
		'controller' { this.controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Translation_Entry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Translation_Entry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Translation_Entry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_l10n_class_wp_translations_php() {
}
