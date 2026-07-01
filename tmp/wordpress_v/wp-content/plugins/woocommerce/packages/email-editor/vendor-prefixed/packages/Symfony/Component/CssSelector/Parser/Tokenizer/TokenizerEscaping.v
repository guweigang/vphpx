import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping {
	rt.PhpObjectBase
pub mut:
		patterns rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) construct(mut var_patterns Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns)  {
	this.patterns = var_patterns.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) escapeunicode(value string) string {
	mut value_mutated := value
	value_mutated = this.replaceunicodesequences(value_mutated)
	return (rt.call_function('preg_replace', [rt.call_method(this.patterns, 'getSimpleEscapePattern', []rt.PhpVal{}), rt.new_string('$1'), rt.new_string(value_mutated).dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) escapeunicodeandnewline(value string) string {
	mut value_mutated := value
	value_mutated = (rt.call_function('preg_replace', [rt.call_method(this.patterns, 'getNewLineEscapePattern', []rt.PhpVal{}), rt.new_string(''), rt.new_string(value_mutated).dup()])).str()
	return this.escapeunicode(value_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) replaceunicodesequences(value string) string {
	mut value_mutated := value
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_match := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_c := rt.call_function('hexdec', [var_match.array_get(1)])
	if rt.is_true(rt.greater(rt.new_int(128), // unsupported expression: Expr_AssignOp_Mod)) {
		return (rt.call_function('chr', [var_c.dup()])).str()
	}
	if rt.is_true(rt.greater(rt.new_int(2048), var_c)) {
		return (rt.call_function('chr', [192 | rt.shift_right(var_c, rt.new_int(6))])).str() + (rt.call_function('chr', [128 | rt.bitwise_and(var_c, rt.new_int(63))])).str()
	}
	if rt.is_true(rt.greater(rt.new_int(65536), var_c)) {
		return (rt.call_function('chr', [224 | rt.shift_right(var_c, rt.new_int(12))])).str() + (rt.call_function('chr', [128 | rt.shift_right(var_c, rt.new_int(6)) & 63])).str() + (rt.call_function('chr', [128 | rt.bitwise_and(var_c, rt.new_int(63))])).str()
	}
	return ''
	}
	return (rt.call_function('preg_replace_callback', [rt.call_method(this.patterns, 'getUnicodeEscapePattern', []rt.PhpVal{}), rt.new_closure(closure_1_fn), rt.new_string(value_mutated).dup()])).str()
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_parser_tokenizer_tokenizerescaping(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping{
		PhpObjectBase: rt.PhpObjectBase{}
		patterns: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerPatterns](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'escapeUnicode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.escapeunicode(dispatch_arg_0))
		}
		'escapeUnicodeAndNewLine' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.escapeunicodeandnewline(dispatch_arg_0))
		}
		'replaceUnicodeSequences' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.replaceunicodesequences(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'patterns' { return this.patterns }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Parser_Tokenizer_TokenizerEscaping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'patterns' { this.patterns = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_symfony_component_cssselector_parser_tokenizer_tokenizerescaping_php() {
}
