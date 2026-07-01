import rt

struct Class_Translations {
	rt.PhpObjectBase
pub mut:
			entries rt.PhpVal = rt.new_array()
			headers rt.PhpVal = rt.new_array()
}

fn (mut this Class_Translations) add_entry(var_entry rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	if rt.is_true(rt.new_bool(var_entry_mutated.is_array())) {
		var_entry_mutated = create_translation_entry(var_entry_mutated.dup())
	}
	mut var_key := var_entry_mutated.key()
	if rt.is_true(rt.identical(rt.new_bool(false), var_key)) {
		return false
	}
	// unsupported expression: Expr_AssignRef
	return true
}

fn (mut this Class_Translations) add_entry_or_merge(var_entry rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	if rt.is_true(rt.new_bool(var_entry_mutated.is_array())) {
		var_entry_mutated = create_translation_entry(var_entry_mutated.dup())
	}
	mut var_key := var_entry_mutated.key()
	if rt.is_true(rt.identical(rt.new_bool(false), var_key)) {
		return false
	}
	if this.entries.array_isset(var_key) {
		rt.call_method(this.entries.array_get(var_key), 'merge_with', [var_entry_mutated])
	} else {
		// unsupported expression: Expr_AssignRef
	}
	return true
}

fn (mut this Class_Translations) set_header(var_header rt.PhpVal, var_value rt.PhpVal)  {
	this.headers.array_set(var_header, var_value.dup())
}

fn (mut this Class_Translations) set_headers(var_headers rt.PhpVal)  {
	mut var_headers_mutated := var_headers
	{
		mut iter_1 := var_headers_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_header := item_1.key
			this.set_header(var_header.dup(), var_value.dup())
		}
	}
}

fn (mut this Class_Translations) get_header(var_header rt.PhpVal) rt.PhpVal {
	return if !(this.headers.array_get(var_header)).is_null() { this.headers.array_get(var_header) } else { rt.new_bool(false) }
}

fn (mut this Class_Translations) translate_entry(var_entry rt.PhpVal) rt.PhpVal {
	mut var_entry_mutated := var_entry
	mut var_key := var_entry_mutated.key()
	return if !(this.entries.array_get(var_key)).is_null() { this.entries.array_get(var_key) } else { rt.new_bool(false) }
}

fn (mut this Class_Translations) translate(var_singular rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_entry := create_translation_entry(rt.create_array([rt.ArrayItem{ key: 'singular', val: var_singular }, rt.ArrayItem{ key: 'context', val: var_context }]))
	mut var_translated := this.translate_entry(rt.new_object('Translation_Entry', []string{}, var_entry))
	return if rt.is_true(rt.new_bool(rt.is_true(var_translated) && !(!rt.is_true(rt.get_property(var_translated, 'translations'))))) { rt.get_property(var_translated, 'translations').array_get(0) } else { var_singular }
}

fn (mut this Class_Translations) select_plural_form(var_count rt.PhpVal) i64 {
	return if rt.is_true(rt.identical(rt.new_int(1), // unsupported expression: Expr_Cast_Int)) { 0 } else { 1 }
}

fn (mut this Class_Translations) get_plural_forms_count() i64 {
	return 2
}

fn (mut this Class_Translations) translate_plural(var_singular rt.PhpVal, var_plural rt.PhpVal, var_count rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_entry := create_translation_entry(rt.create_array([rt.ArrayItem{ key: 'singular', val: var_singular }, rt.ArrayItem{ key: 'plural', val: var_plural }, rt.ArrayItem{ key: 'context', val: var_context }]))
	mut var_translated := this.translate_entry(rt.new_object('Translation_Entry', []string{}, var_entry))
	mut var_index := rt.new_int(this.select_plural_form(var_count.dup()))
	mut var_total_plural_forms := rt.new_int(this.get_plural_forms_count())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_translated) && rt.is_true(rt.less_equal(rt.new_int(0), var_index)))) && rt.is_true(rt.less(var_index, var_total_plural_forms)))) && rt.is_true(rt.new_bool(rt.get_property(var_translated, 'translations').is_array())))) && rt.get_property(var_translated, 'translations').array_isset(var_index))) {
		return rt.get_property(var_translated, 'translations').array_get(var_index)
	} else {
		return if rt.is_true(rt.identical(rt.new_int(1), // unsupported expression: Expr_Cast_Int)) { var_singular } else { var_plural }
	}
	return rt.new_null()
}

fn (mut this Class_Translations) merge_with(var_other rt.PhpVal)  {
	{
		mut iter_1 := rt.get_property(var_other, 'entries').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entry := item_1.val
			this.entries.array_set(rt.call_method(var_entry, 'key', []rt.PhpVal{}), var_entry.dup())
		}
	}
}

fn (mut this Class_Translations) merge_originals_with(var_other rt.PhpVal)  {
	{
		mut iter_1 := rt.get_property(var_other, 'entries').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entry := item_1.val
			if !(this.entries.array_isset(rt.call_method(var_entry, 'key', []rt.PhpVal{}))) {
				this.entries.array_set(rt.call_method(var_entry, 'key', []rt.PhpVal{}), var_entry.dup())
			} else {
				rt.call_method(this.entries.array_get(rt.call_method(var_entry, 'key', []rt.PhpVal{})), 'merge_with', [var_entry.dup()])
			}
		}
	}
}

struct Class_Gettext_Translations {
	Class_Translations
pub mut:
			_nplurals rt.PhpVal = rt.new_null()
			_gettext_select_plural_form rt.PhpVal = rt.new_null()
}

fn (mut this Class_Gettext_Translations) gettext_select_plural_form(var_count rt.PhpVal) rt.PhpVal {
	mut var_nplurals := rt.new_null()
	mut var_expression := rt.new_null()
	if rt.is_true(rt.new_bool(!(!(this._gettext_select_plural_form).is_null()) || rt.is_true(rt.new_bool(this._gettext_select_plural_form.is_null())))) {
		// unsupported assign target: Expr_List
		this._nplurals = var_nplurals.dup()
		this._gettext_select_plural_form = this.make_plural_form_function(var_nplurals.dup(), var_expression.dup())
	}
	return rt.call_function('call_user_func', [this._gettext_select_plural_form, var_count.dup()])
}

fn (mut this Class_Gettext_Translations) nplurals_and_expression_from_header(var_header rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*nplurals\\s*=\\s*(\\d+)\\s*;\\s+plural\\s*=\\s*(.+)$/'), var_header.dup(), var_matches.dup()])) {
		mut var_nplurals := // unsupported expression: Expr_Cast_Int
		mut var_expression := rt.new_string(rt.new_string(var_matches.array_get(2).to_string().trim_space()))
		return rt.create_array([rt.ArrayItem{ key: none, val: var_nplurals }, rt.ArrayItem{ key: none, val: var_expression }])
	} else {
		return rt.create_array([rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 'n != 1' }])
	}
	return rt.new_null()
}

fn (mut this Class_Gettext_Translations) make_plural_form_function(var_nplurals rt.PhpVal, var_expression rt.PhpVal) rt.PhpVal {
	mut var_nplurals_mutated := var_nplurals
	mut var_expression_mutated := var_expression
	mut var_handler := create_plural_forms(rt.new_string(var_expression_mutated.dup().to_string().trim_right(' \t\n\r')))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.create_array([rt.ArrayItem{ key: none, val: var_handler }, rt.ArrayItem{ key: none, val: 'get' }])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return this.make_plural_form_function(rt.new_int(2), rt.new_string('n != 1'))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Gettext_Translations) parenthesize_plural_exression(var_expression rt.PhpVal) string {
	mut var_expression_mutated := var_expression
	// unsupported expression: Expr_AssignOp_Concat
	mut var_res := rt.new_string(rt.new_string(''))
	mut var_depth := rt.new_int(rt.new_int(0))
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(var_expression_mutated.dup().to_string().len)))) { break }
			mut var_char := var_expression_mutated.array_get(var_i)
			mut switch_val_1 := var_char
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('?'))) {
				// unsupported expression: Expr_AssignOp_Concat
				rt.pre_inc(var_depth)
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(':'))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(';'))) {
				// unsupported expression: Expr_AssignOp_Concat
				var_depth = rt.new_int(rt.new_int(0))
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
			rt.pre_inc(var_i)
		}
	}
	return var_res.dup().to_string().trim_right(' \t\n\r')
}

fn (mut this Class_Gettext_Translations) make_headers(var_translation rt.PhpVal) rt.PhpVal {
	mut var_translation_mutated := var_translation
	mut var_headers := map[string]rt.PhpVal{}
	var_translation_mutated = rt.call_function('str_replace', [rt.new_string('\\n'), rt.new_string('\n'), var_translation_mutated.dup()])
	mut var_lines := rt.call_function('explode', [rt.new_string('\n'), var_translation_mutated.dup()])
	{
		mut iter_1 := var_lines.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line := item_1.val
			mut var_parts := rt.call_function('explode', [rt.new_string(':'), var_line.dup(), rt.new_int(2)])
			if !(var_parts.array_isset(rt.new_int(1))) {
				continue
			}
			var_headers[var_parts.array_get(0).to_string().trim_space()] = var_parts.array_get(1).to_string().trim_space()
		}
	}
	return var_headers.dup()
}

fn (mut this Class_Gettext_Translations) set_header(var_header rt.PhpVal, var_value rt.PhpVal)  {
	mut var_nplurals := rt.new_null()
	mut var_expression := rt.new_null()
	this.Class_Translations.set_header(var_header.dup(), var_value.dup())
	if rt.is_true(rt.identical(rt.new_string('Plural-Forms'), var_header)) {
		// unsupported assign target: Expr_List
		this._nplurals = var_nplurals.dup()
		this._gettext_select_plural_form = this.make_plural_form_function(var_nplurals.dup(), var_expression.dup())
	}
}

struct Class_NOOP_Translations {
	rt.PhpObjectBase
pub mut:
			entries rt.PhpVal = rt.new_array()
			headers rt.PhpVal = rt.new_array()
}

fn (mut this Class_NOOP_Translations) add_entry(var_entry rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	return true
}

fn (mut this Class_NOOP_Translations) set_header(var_header rt.PhpVal, var_value rt.PhpVal)  {
}

fn (mut this Class_NOOP_Translations) set_headers(var_headers rt.PhpVal)  {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_NOOP_Translations) get_header(var_header rt.PhpVal) bool {
	return false
}

fn (mut this Class_NOOP_Translations) translate_entry(var_entry rt.PhpVal) bool {
	mut var_entry_mutated := var_entry
	return false
}

fn (mut this Class_NOOP_Translations) translate(var_singular rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	return var_singular.dup()
}

fn (mut this Class_NOOP_Translations) select_plural_form(var_count rt.PhpVal) i64 {
	return if rt.is_true(rt.identical(rt.new_int(1), // unsupported expression: Expr_Cast_Int)) { 0 } else { 1 }
}

fn (mut this Class_NOOP_Translations) get_plural_forms_count() i64 {
	return 2
}

fn (mut this Class_NOOP_Translations) translate_plural(var_singular rt.PhpVal, var_plural rt.PhpVal, var_count rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.identical(rt.new_int(1), // unsupported expression: Expr_Cast_Int)) { var_singular } else { var_plural }
}

fn (mut this Class_NOOP_Translations) merge_with(var_other rt.PhpVal)  {
}

struct Class_Translation_Entry {
	rt.PhpObjectBase
}

struct Class_Plural_Forms {
	rt.PhpObjectBase
}

fn create_translations() &Class_Translations {
	mut obj := &Class_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
		entries: rt.new_array()
		headers: rt.new_array()
	}
	return obj
}

fn create_gettext_translations() &Class_Gettext_Translations {
	mut obj := &Class_Gettext_Translations{
		Class_Translations: Class_Translations{
			PhpObjectBase: rt.PhpObjectBase{}
			entries: rt.new_array()
			headers: rt.new_array()
		}
		_nplurals: rt.new_null()
		_gettext_select_plural_form: rt.new_null()
	}
	return obj
}

fn create_noop_translations() &Class_NOOP_Translations {
	mut obj := &Class_NOOP_Translations{
		PhpObjectBase: rt.PhpObjectBase{}
		entries: rt.new_array()
		headers: rt.new_array()
	}
	return obj
}

fn create_translation_entry() &Class_Translation_Entry {
	mut obj := &Class_Translation_Entry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plural_forms() &Class_Plural_Forms {
	mut obj := &Class_Plural_Forms{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_entry(dispatch_arg_0))
		}
		'add_entry_or_merge' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_entry_or_merge(dispatch_arg_0))
		}
		'set_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'get_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_header(dispatch_arg_0)
		}
		'translate_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.translate_entry(dispatch_arg_0)
		}
		'translate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.translate(dispatch_arg_0, dispatch_arg_1)
		}
		'select_plural_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.select_plural_form(dispatch_arg_0))
		}
		'get_plural_forms_count' {
			return rt.new_int(this.get_plural_forms_count())
		}
		'translate_plural' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.translate_plural(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'merge_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.merge_with(dispatch_arg_0)
			return rt.new_null()
		}
		'merge_originals_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.merge_originals_with(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'entries' { return this.entries }
		'headers' { return this.headers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'entries' { this.entries = val; return true }
		'headers' { this.headers = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Gettext_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'gettext_select_plural_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.gettext_select_plural_form(dispatch_arg_0)
		}
		'nplurals_and_expression_from_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.nplurals_and_expression_from_header(dispatch_arg_0)
		}
		'make_plural_form_function' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.make_plural_form_function(dispatch_arg_0, dispatch_arg_1)
		}
		'parenthesize_plural_exression' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.parenthesize_plural_exression(dispatch_arg_0))
		}
		'make_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.make_headers(dispatch_arg_0)
		}
		'set_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_entry(dispatch_arg_0))
		}
		'add_entry_or_merge' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_entry_or_merge(dispatch_arg_0))
		}
		'set_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'get_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_header(dispatch_arg_0)
		}
		'translate_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.translate_entry(dispatch_arg_0)
		}
		'translate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.translate(dispatch_arg_0, dispatch_arg_1)
		}
		'select_plural_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.select_plural_form(dispatch_arg_0))
		}
		'get_plural_forms_count' {
			return rt.new_int(this.get_plural_forms_count())
		}
		'translate_plural' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.translate_plural(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'merge_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.merge_with(dispatch_arg_0)
			return rt.new_null()
		}
		'merge_originals_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.merge_originals_with(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Gettext_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'entries' { return this.Class_Translations.entries }
		'headers' { return this.Class_Translations.headers }
		'_nplurals' { return this._nplurals }
		'_gettext_select_plural_form' { return this._gettext_select_plural_form }
		else { return this.Class_Translations.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Gettext_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'entries' { this.Class_Translations.entries = val; return true }
		'headers' { this.Class_Translations.headers = val; return true }
		'_nplurals' { this._nplurals = val; return true }
		'_gettext_select_plural_form' { this._gettext_select_plural_form = val; return true }
		else { return this.Class_Translations.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_NOOP_Translations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.add_entry(dispatch_arg_0))
		}
		'set_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_header(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'get_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_header(dispatch_arg_0))
		}
		'translate_entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.translate_entry(dispatch_arg_0))
		}
		'translate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.translate(dispatch_arg_0, dispatch_arg_1)
		}
		'select_plural_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.select_plural_form(dispatch_arg_0))
		}
		'get_plural_forms_count' {
			return rt.new_int(this.get_plural_forms_count())
		}
		'translate_plural' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.translate_plural(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'merge_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.merge_with(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_NOOP_Translations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'entries' { return this.entries }
		'headers' { return this.headers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_NOOP_Translations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'entries' { this.entries = val; return true }
		'headers' { this.headers = val; return true }
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


fn (mut this Class_Plural_Forms) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plural_Forms) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plural_Forms) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_pomo_translations_php() {
	rt.include_file(@DIR + '/plural-forms.php', '4')
	rt.include_file(@DIR + '/entry.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Translations'), rt.new_bool(false)]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('NOOP_Translations'), rt.new_bool(false)]))))) {
	}
}
