import rt

struct Class_WP_HTML_Doctype_Info {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		public_identifier rt.PhpVal = rt.new_null()
		system_identifier rt.PhpVal = rt.new_null()
		indicated_compatibility_mode string
}

fn (mut this Class_WP_HTML_Doctype_Info) construct(mut var_name Class_?string, mut var_public_identifier Class_?string, mut var_system_identifier Class_?string, force_quirks_flag bool)  {
	mut var_public_identifier_mutated := var_public_identifier
	mut var_system_identifier_mutated := var_system_identifier
	this.name = var_name.dup()
	this.public_identifier = var_public_identifier_mutated.dup()
	this.system_identifier = var_system_identifier_mutated.dup()
	if var_force_quirks_flag {
		this.indicated_compatibility_mode = 'quirks'
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('html'), var_name)) && rt.is_true(rt.identical(rt.new_null(), var_public_identifier_mutated)))) && rt.is_true(rt.identical(rt.new_null(), var_system_identifier_mutated)))) {
		this.indicated_compatibility_mode = 'no-quirks'
		return
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.indicated_compatibility_mode = 'quirks'
		return
	}
	mut var_system_identifier_is_missing := rt.identical(rt.new_null(), var_system_identifier_mutated)
	var_public_identifier_mutated = rt.new_string(if rt.is_true(rt.identical(rt.new_null(), var_public_identifier_mutated)) { rt.new_string('') } else { rt.new_string(var_public_identifier_mutated.dup().to_string().to_lower()) })
	var_system_identifier_mutated = rt.new_string(if rt.is_true(rt.identical(rt.new_null(), var_system_identifier_mutated)) { rt.new_string('') } else { rt.new_string(var_system_identifier_mutated.dup().to_string().to_lower()) })
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('-//w3o//dtd w3 html strict 3.0//en//'), var_public_identifier_mutated)) || rt.is_true(rt.identical(rt.new_string('-/w3c/dtd html 4.0 transitional/en'), var_public_identifier_mutated)))) || rt.is_true(rt.identical(rt.new_string('html'), var_public_identifier_mutated)))) {
		this.indicated_compatibility_mode = 'quirks'
		return
	}
	if rt.is_true(rt.identical(rt.new_string('http://www.ibm.com/data/dtd/v11/ibmxhtml1-transitional.dtd'), var_system_identifier_mutated)) {
		this.indicated_compatibility_mode = 'quirks'
		return
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_public_identifier_mutated)) {
		this.indicated_compatibility_mode = 'no-quirks'
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('+//silmaril//dtd html pro v0r11 19970101//')])) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//as//dtd html 3.0 aswedit + extensions//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//advasoft ltd//dtd html 3.0 aswedit + extensions//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 2.0 level 1//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 2.0 level 2//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 2.0 strict level 1//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 2.0 strict level 2//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 2.0 strict//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 2.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 2.1e//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 3.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 3.2 final//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 3.2//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html 3//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html level 0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html level 1//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html level 2//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html level 3//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html strict level 0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html strict level 1//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html strict level 2//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html strict level 3//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html strict//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//ietf//dtd html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//metrius//dtd metrius presentational//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//microsoft//dtd internet explorer 2.0 html strict//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//microsoft//dtd internet explorer 2.0 html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//microsoft//dtd internet explorer 2.0 tables//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//microsoft//dtd internet explorer 3.0 html strict//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//microsoft//dtd internet explorer 3.0 html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//microsoft//dtd internet explorer 3.0 tables//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//netscape comm. corp.//dtd html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//netscape comm. corp.//dtd strict html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//o\'reilly and associates//dtd html 2.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//o\'reilly and associates//dtd html extended 1.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//o\'reilly and associates//dtd html extended relaxed 1.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//sq//dtd html 2.0 hotmetal + extensions//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//softquad software//dtd hotmetal pro 6.0::19990601::extensions to html 4.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//softquad//dtd hotmetal pro 4.0::19971010::extensions to html 4.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//spyglass//dtd html 2.0 extended//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//sun microsystems corp.//dtd hotjava html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//sun microsystems corp.//dtd hotjava strict html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 3 1995-03-24//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 3.2 draft//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 3.2 final//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 3.2//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 3.2s draft//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 4.0 frameset//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 4.0 transitional//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html experimental 19960712//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html experimental 970421//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd w3 html//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3o//dtd w3 html 3.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//webtechs//dtd mozilla html 2.0//')])))) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//webtechs//dtd mozilla html//')])))) {
		this.indicated_compatibility_mode = 'quirks'
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_system_identifier_is_missing) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 4.01 frameset//')])) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 4.01 transitional//')])))))) {
		this.indicated_compatibility_mode = 'quirks'
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd xhtml 1.0 frameset//')])) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd xhtml 1.0 transitional//')])))) {
		this.indicated_compatibility_mode = 'limited-quirks'
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_system_identifier_is_missing)))) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 4.01 frameset//')])) || rt.is_true(rt.call_function('str_starts_with', [var_public_identifier_mutated.dup(), rt.new_string('-//w3c//dtd html 4.01 transitional//')])))))) {
		this.indicated_compatibility_mode = 'limited-quirks'
		return
	}
	this.indicated_compatibility_mode = 'no-quirks'
}

fn Class_WP_HTML_Doctype_Info.from_doctype_token(doctype_html string) rt.PhpVal {
	mut doctype_html_mutated := doctype_html
	mut var_doctype_name := rt.new_null()
	mut var_doctype_public_id := rt.new_null()
	mut var_doctype_system_id := rt.new_null()
	mut var_end := rt.new_int(doctype_html_mutated.len - 1)
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_end, rt.new_int(9))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_at := rt.new_int(rt.new_int(9))
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.less(rt.add(rt.call_function('strcspn', [rt.new_string(doctype_html_mutated).dup(), rt.new_string('>'), var_at.dup()]), var_at), var_end)))) {
		return rt.new_null()
	}
	doctype_html_mutated = (rt.call_function('str_replace', [rt.new_string('\r\n'), rt.new_string('\n'), rt.new_string(doctype_html_mutated).dup()])).str()
	doctype_html_mutated = (rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string('\n'), rt.new_string(doctype_html_mutated).dup()])).str()
	var_end = rt.new_int(doctype_html_mutated.len - 1)
	// unsupported expression: Expr_AssignOp_Plus
	if rt.is_true(rt.greater_equal(var_at, var_end)) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
	}
	mut var_name_length := rt.call_function('strcspn', [rt.new_string(doctype_html_mutated).dup(), rt.new_string(' \t\n\r'), var_at.dup(), rt.sub(var_end, var_at)])
	var_doctype_name = rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), rt.new_string(rt.call_function('substr', [rt.new_string(doctype_html_mutated).dup(), var_at.dup(), var_name_length.dup()]).to_string().to_lower())])
	// unsupported expression: Expr_AssignOp_Plus
	// unsupported expression: Expr_AssignOp_Plus
	if rt.is_true(rt.greater_equal(var_at, var_end)) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(false))
	}
	if rt.is_true(rt.greater_equal(rt.add(var_at, rt.new_int(6)), var_end)) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(doctype_html_mutated).dup(), rt.new_string('PUBLIC'), var_at.dup(), rt.new_int(6), rt.new_bool(true)]))) {
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.greater_equal(var_at, var_end)) {
			return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
		}
		// unsupported statement: Stmt_Goto
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(doctype_html_mutated).dup(), rt.new_string('SYSTEM'), var_at.dup(), rt.new_int(6), rt.new_bool(true)]))) {
		// unsupported expression: Expr_AssignOp_Plus
		// unsupported expression: Expr_AssignOp_Plus
		if rt.is_true(rt.greater_equal(var_at, var_end)) {
			return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
		}
		// unsupported statement: Stmt_Goto
	}
	return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
	// unsupported statement: Stmt_Label
	mut var_closer_quote := rt.new_string(doctype_html_mutated).array_get(var_at)
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
	}
	rt.pre_inc(var_at)
	mut var_identifier_length := rt.call_function('strcspn', [rt.new_string(doctype_html_mutated).dup(), var_closer_quote.dup(), var_at.dup(), rt.sub(var_end, var_at)])
	var_doctype_public_id = rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), rt.call_function('substr', [rt.new_string(doctype_html_mutated).dup(), var_at.dup(), var_identifier_length.dup()])])
	// unsupported expression: Expr_AssignOp_Plus
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_at, var_end)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
	}
	rt.pre_inc(var_at)
	// unsupported expression: Expr_AssignOp_Plus
	if rt.is_true(rt.greater_equal(var_at, var_end)) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(false))
	}
	// unsupported statement: Stmt_Label
	var_closer_quote = rt.new_string(doctype_html_mutated).array_get(var_at)
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
	}
	rt.pre_inc(var_at)
	var_identifier_length = rt.call_function('strcspn', [rt.new_string(doctype_html_mutated).dup(), var_closer_quote.dup(), var_at.dup(), rt.sub(var_end, var_at)])
	var_doctype_system_id = rt.call_function('str_replace', [rt.new_string(''), rt.new_string('�'), rt.call_function('substr', [rt.new_string(doctype_html_mutated).dup(), var_at.dup(), var_identifier_length.dup()])])
	// unsupported expression: Expr_AssignOp_Plus
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater_equal(var_at, var_end)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(true))
	}
	return create_self(var_doctype_name.dup(), var_doctype_public_id.dup(), var_doctype_system_id.dup(), rt.new_bool(false))
}

struct Class_self {
	rt.PhpObjectBase
}

fn create_wp_html_doctype_info(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, force_quirks_flag bool) &Class_WP_HTML_Doctype_Info {
	mut obj := &Class_WP_HTML_Doctype_Info{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		public_identifier: rt.new_null()
		system_identifier: rt.new_null()
		indicated_compatibility_mode: ''
	}
	obj.construct(arg_0, arg_1, arg_2, force_quirks_flag)
	return obj
}

fn create_self() &Class_self {
	mut obj := &Class_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Doctype_Info) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'from_doctype_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WP_HTML_Doctype_Info.from_doctype_token(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_HTML_Doctype_Info) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'public_identifier' { return this.public_identifier }
		'system_identifier' { return this.system_identifier }
		'indicated_compatibility_mode' { return rt.new_string(this.indicated_compatibility_mode) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_HTML_Doctype_Info) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'public_identifier' { this.public_identifier = val; return true }
		'system_identifier' { this.system_identifier = val; return true }
		'indicated_compatibility_mode' { this.indicated_compatibility_mode = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_html_api_class_wp_html_doctype_info_php() {
}
