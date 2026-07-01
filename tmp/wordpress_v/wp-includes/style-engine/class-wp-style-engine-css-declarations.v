import rt

struct Class_WP_Style_Engine_CSS_Declarations {
	rt.PhpObjectBase
pub mut:
		declarations rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) construct(var_declarations rt.PhpVal)  {
	this.add_declarations(var_declarations.dup())
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) add_declaration(var_property rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_property_mutated := var_property
	mut var_value_mutated := var_value
	var_property_mutated = this.sanitize_property(var_property_mutated.dup())
	if !rt.is_true(var_property_mutated) {
		return rt.new_object('WP_Style_Engine_CSS_Declarations', []string{}, this)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string()))))) {
		return rt.new_object('WP_Style_Engine_CSS_Declarations', []string{}, this)
	}
	var_value_mutated = rt.new_string(rt.new_string(var_value_mutated.dup().to_string().trim_space()))
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) {
		return rt.new_object('WP_Style_Engine_CSS_Declarations', []string{}, this)
	}
	this.declarations.array_set(var_property_mutated, var_value_mutated.dup())
	return rt.new_object('WP_Style_Engine_CSS_Declarations', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) remove_declaration(var_property rt.PhpVal) rt.PhpVal {
	mut var_property_mutated := var_property
	this.declarations.array_unset(var_property_mutated)
	return rt.new_object('WP_Style_Engine_CSS_Declarations', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) add_declarations(var_declarations rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := var_declarations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_property := item_1.key
			this.add_declaration(var_property.dup(), var_value.dup())
		}
	}
	return rt.new_object('WP_Style_Engine_CSS_Declarations', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) remove_declarations(var_properties rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := var_properties.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			this.remove_declaration(var_property.dup())
		}
	}
	return rt.new_object('WP_Style_Engine_CSS_Declarations', []string{}, this)
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) get_declarations() rt.PhpVal {
	return this.declarations
}

fn Class_WP_Style_Engine_CSS_Declarations.filter_declaration(var_property rt.PhpVal, var_value rt.PhpVal, spacer string) string {
	mut var_property_mutated := var_property
	mut var_value_mutated := var_value
	mut spacer_mutated := spacer
	mut var_filtered_value := rt.call_function('wp_strip_all_tags', [var_value_mutated.dup(), rt.new_bool(true)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (rt.call_function('safecss_filter_attr', [rt.new_string("${var_property.to_string()}:${var_spacer.to_string()}${var_filtered_value.to_string()}")])).str()
	}
	return ''
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) get_declarations_string(should_prettify bool, indent_count i64) string {
	mut var_declarations_array := this.get_declarations()
	mut var_declarations_output := rt.new_string(rt.new_string(''))
	mut var_indent := if var_should_prettify { rt.call_function('str_repeat', [rt.new_string('\t'), rt.new_int(indent_count)]) } else { rt.new_string('') }
	mut var_suffix := rt.new_string(if var_should_prettify { rt.new_string(' ') } else { rt.new_string('') })
	var_suffix = if var_should_prettify && indent_count > 0 { rt.new_string('\n') } else { var_suffix }
	mut var_spacer := rt.new_string(if var_should_prettify { rt.new_string(' ') } else { rt.new_string('') })
	{
		mut iter_1 := var_declarations_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_property := item_1.key
			mut var_filtered_declaration := Class_WP_Style_Engine_CSS_Declarations.filter_declaration((var_property).str(), var_value.dup(), var_spacer.dup())
			if rt.is_true(var_filtered_declaration) {
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	}
	return var_declarations_output.dup().to_string().trim_right(' \t\n\r')
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) sanitize_property(var_property rt.PhpVal) rt.PhpVal {
	mut var_property_mutated := var_property
	return rt.call_function('sanitize_key', [var_property_mutated.dup()])
}

fn create_wp_style_engine_css_declarations(arg_0 rt.PhpVal) &Class_WP_Style_Engine_CSS_Declarations {
	mut obj := &Class_WP_Style_Engine_CSS_Declarations{
		PhpObjectBase: rt.PhpObjectBase{}
		declarations: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'add_declaration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_declaration(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_declaration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_declaration(dispatch_arg_0)
		}
		'add_declarations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_declarations(dispatch_arg_0)
		}
		'remove_declarations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_declarations(dispatch_arg_0)
		}
		'get_declarations' {
			return this.get_declarations()
		}
		'filter_declaration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_WP_Style_Engine_CSS_Declarations.filter_declaration(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_declarations_string' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_declarations_string(dispatch_arg_0, dispatch_arg_1))
		}
		'sanitize_property' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_property(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Style_Engine_CSS_Declarations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'declarations' { return this.declarations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Style_Engine_CSS_Declarations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'declarations' { this.declarations = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_style_engine_class_wp_style_engine_css_declarations_php() {
}
