import rt

struct Class_Translation_Entry {
	rt.PhpObjectBase
pub mut:
			is_plural bool
			context rt.PhpVal = rt.new_null()
			singular rt.PhpVal = rt.new_null()
			plural rt.PhpVal = rt.new_null()
			translations rt.PhpVal = rt.new_array()
			translator_comments rt.PhpVal = rt.new_string('')
			extracted_comments rt.PhpVal = rt.new_string('')
			references rt.PhpVal = rt.new_array()
			flags rt.PhpVal = rt.new_array()
}

fn (mut this Class_Translation_Entry) construct(var_args rt.PhpVal)  {
	if !(var_args.array_isset(rt.new_string('singular'))) {
		return
	}
	{
		mut iter_1 := var_args.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_varname := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":61,"name":"varname"}', var_value.dup())
		}
	}
	if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('plural')) && rt.is_true(var_args.array_get('plural')))) {
		this.is_plural = true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.translations.is_array()))))) {
		this.translations = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.references.is_array()))))) {
		this.references = rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.flags.is_array()))))) {
		this.flags = rt.new_array()
	}
}

fn (mut this Class_Translation_Entry) translation_entry(var_args rt.PhpVal)  {
	rt.call_function('_deprecated_constructor', [Class_Translation_Entry.class(), rt.new_string('5.4.0'), Class_static.class()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Translation_Entry{}; temp.construct(arg_0); return rt.new_null() }(var_args.dup())
}

fn (mut this Class_Translation_Entry) key() bool {
	if rt.is_true(rt.identical(rt.new_null(), this.singular)) {
		return false
	}
	mut var_key := if rt.is_true(rt.new_bool(!(rt.is_true(this.context)))) { this.singular } else { (this.context).str() + '' + (this.singular).str() }
	var_key = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '\r\n' }, rt.ArrayItem{ key: none, val: '\r' }]), rt.new_string('\n'), var_key.dup()])
	return (var_key).to_bool()
}

fn (mut this Class_Translation_Entry) merge_with(var_other rt.PhpVal)  {
	this.flags = rt.call_function('array_unique', [rt.call_function('array_merge', [this.flags, rt.get_property(var_other, 'flags')])])
	this.references = rt.call_function('array_unique', [rt.call_function('array_merge', [this.references, rt.get_property(var_other, 'references')])])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
}

fn create_translation_entry(arg_0 rt.PhpVal) &Class_Translation_Entry {
	mut obj := &Class_Translation_Entry{
		PhpObjectBase: rt.PhpObjectBase{}
		is_plural: false
		context: rt.new_null()
		singular: rt.new_null()
		plural: rt.new_null()
		translations: rt.new_array()
		translator_comments: rt.new_string('')
		extracted_comments: rt.new_string('')
		references: rt.new_array()
		flags: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Translation_Entry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'Translation_Entry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.translation_entry(dispatch_arg_0)
			return rt.new_null()
		}
		'key' {
			return rt.new_bool(this.key())
		}
		'merge_with' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.merge_with(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Translation_Entry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_plural' { return rt.new_bool(this.is_plural) }
		'context' { return this.context }
		'singular' { return this.singular }
		'plural' { return this.plural }
		'translations' { return this.translations }
		'translator_comments' { return this.translator_comments }
		'extracted_comments' { return this.extracted_comments }
		'references' { return this.references }
		'flags' { return this.flags }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Translation_Entry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_plural' { this.is_plural = (val).to_bool(); return true }
		'context' { this.context = val; return true }
		'singular' { this.singular = val; return true }
		'plural' { this.plural = val; return true }
		'translations' { this.translations = val; return true }
		'translator_comments' { this.translator_comments = val; return true }
		'extracted_comments' { this.extracted_comments = val; return true }
		'references' { this.references = val; return true }
		'flags' { this.flags = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_pomo_entry_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Translation_Entry'), rt.new_bool(false)]))))) {
	}
}
