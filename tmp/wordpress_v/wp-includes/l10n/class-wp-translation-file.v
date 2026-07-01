import rt

struct Class_WP_Translation_File {
	rt.PhpObjectBase
pub mut:
		headers rt.PhpVal = rt.new_array()
		parsed rt.PhpVal = rt.new_bool(false)
		error rt.PhpVal = rt.new_null()
		file string
		entries rt.PhpVal = rt.new_array()
		plural_forms rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Translation_File) construct(file string)  {
	this.file = file
}

fn Class_WP_Translation_File.create(file string, mut var_filetype Class_?string) bool {
	mut var_filetype_mutated := var_filetype
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [rt.new_string(file)]))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), var_filetype_mutated)) {
		mut var_pos := rt.call_function('strrpos', [rt.new_string(file), rt.new_string('.')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_filetype_mutated = rt.call_function('substr', [rt.new_string(file), rt.add(var_pos, rt.new_int(1))])
		}
	}
	mut switch_val_1 := var_filetype_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('mo'))) {
		return (create_wp_translation_file_mo(rt.new_string(file).dup())).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('php'))) {
		return (create_wp_translation_file_php(rt.new_string(file).dup())).to_bool()
	} else {
		return false
	}
	return false
}

fn Class_WP_Translation_File.transform(file string, filetype string) bool {
	mut filetype_mutated := filetype
	mut var_source := Class_WP_Translation_File.create(file)
	if rt.is_true(rt.identical(rt.new_bool(false), var_source)) {
		return false
	}
	mut switch_val_2 := rt.new_string(filetype_mutated)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('mo'))) {
		mut var_destination := create_wp_translation_file_mo(rt.new_string(''))
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('php'))) {
		var_destination = create_wp_translation_file_php(rt.new_string(''))
	} else {
		return false
	}
	mut var_success := rt.call_method(var_destination, 'import', [var_source.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_success)))) {
		return false
	}
	return (rt.call_method(var_destination, 'export', []rt.PhpVal{})).to_bool()
}

fn (mut this Class_WP_Translation_File) headers() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed)))) {
		this.parse_file()
	}
	return this.headers
}

fn (mut this Class_WP_Translation_File) entries() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed)))) {
		this.parse_file()
	}
	return this.entries
}

fn (mut this Class_WP_Translation_File) error() rt.PhpVal {
	return this.error
}

fn (mut this Class_WP_Translation_File) get_file() string {
	return this.file
}

fn (mut this Class_WP_Translation_File) translate(text string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed)))) {
		this.parse_file()
	}
	return if !(this.entries.array_get(text)).is_null() { this.entries.array_get(text) } else { rt.new_bool(false) }
}

fn (mut this Class_WP_Translation_File) get_plural_form(number i64) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.parsed)))) {
		this.parse_file()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), this.plural_forms)) && this.headers.array_isset(rt.new_string('plural-forms')))) {
		mut var_expression := rt.new_string(this.get_plural_expression_from_header((this.headers.array_get('plural-forms')).str()))
		this.plural_forms = this.make_plural_form_function((var_expression).str())
	}
	if rt.is_true(rt.call_function('is_callable', [this.plural_forms])) {
		mut var_result := rt.call_function('call_user_func', [this.plural_forms, rt.new_int(number)])
		return (var_result).to_i64()
	}
	return if 1 == number { 0 } else { 1 }
}

fn (mut this Class_WP_Translation_File) get_plural_expression_from_header(header string) string {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\s*nplurals\\s*=\\s*(\\d+)\\s*;\\s+plural\\s*=\\s*(.+)$/'), rt.new_string(header), var_matches.dup()])) {
		return var_matches.array_get(2).to_string().trim_space()
	}
	return 'n != 1'
}

fn (mut this Class_WP_Translation_File) make_plural_form_function(expression string) rt.PhpVal {
	mut expression_mutated := expression
	mut var_handler := create_plural_forms(rt.new_string(expression_mutated.trim_right(' \t\n\r')))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return rt.create_array([rt.ArrayItem{ key: none, val: var_handler }, rt.ArrayItem{ key: none, val: 'get' }])
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		return this.make_plural_form_function('n != 1')
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return rt.new_null()
}

fn (mut this Class_WP_Translation_File) import(mut var_source Class_WP_Translation_File) bool {
	mut var_source_mutated := var_source
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return false
	}
	this.headers = rt.call_method(var_source_mutated, 'headers', []rt.PhpVal{})
	this.entries = rt.call_method(var_source_mutated, 'entries', []rt.PhpVal{})
	this.error = rt.call_method(var_source_mutated, 'error', []rt.PhpVal{})
	return (rt.identical(rt.new_null(), this.error)).to_bool()
}

fn (mut this Class_WP_Translation_File) parse_file()  {
}

fn (mut this Class_WP_Translation_File) export()  {
}

struct Class_WP_Translation_File_MO {
	rt.PhpObjectBase
}

struct Class_WP_Translation_File_PHP {
	rt.PhpObjectBase
}

struct Class_Plural_Forms {
	rt.PhpObjectBase
}

fn create_wp_translation_file(file string) &Class_WP_Translation_File {
	mut obj := &Class_WP_Translation_File{
		PhpObjectBase: rt.PhpObjectBase{}
		headers: rt.new_array()
		parsed: rt.new_bool(false)
		error: rt.new_null()
		file: ''
		entries: rt.new_array()
		plural_forms: rt.new_null()
	}
	obj.construct(file)
	return obj
}

fn create_wp_translation_file_mo() &Class_WP_Translation_File_MO {
	mut obj := &Class_WP_Translation_File_MO{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_translation_file_php() &Class_WP_Translation_File_PHP {
	mut obj := &Class_WP_Translation_File_PHP{
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

fn (mut this Class_WP_Translation_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'create' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(Class_WP_Translation_File.create(dispatch_arg_0, mut dispatch_arg_1))
		}
		'transform' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_Translation_File.transform(dispatch_arg_0, dispatch_arg_1))
		}
		'headers' {
			return this.headers()
		}
		'entries' {
			return this.entries()
		}
		'error' {
			return this.error()
		}
		'get_file' {
			return rt.new_string(this.get_file())
		}
		'translate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.translate(dispatch_arg_0)
		}
		'get_plural_form' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.get_plural_form(dispatch_arg_0))
		}
		'get_plural_expression_from_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_plural_expression_from_header(dispatch_arg_0))
		}
		'make_plural_form_function' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.make_plural_form_function(dispatch_arg_0)
		}
		'import' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Translation_File](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.import(mut dispatch_arg_0))
		}
		'parse_file' {
			this.parse_file()
			return rt.new_null()
		}
		'export' {
			this.export()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Translation_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'headers' { return this.headers }
		'parsed' { return this.parsed }
		'error' { return this.error }
		'file' { return rt.new_string(this.file) }
		'entries' { return this.entries }
		'plural_forms' { return this.plural_forms }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Translation_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'headers' { this.headers = val; return true }
		'parsed' { this.parsed = val; return true }
		'error' { this.error = val; return true }
		'file' { this.file = (val).str(); return true }
		'entries' { this.entries = val; return true }
		'plural_forms' { this.plural_forms = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Translation_File_MO) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translation_File_MO) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_File_MO) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Translation_File_PHP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Translation_File_PHP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Translation_File_PHP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_l10n_class_wp_translation_file_php() {
}
