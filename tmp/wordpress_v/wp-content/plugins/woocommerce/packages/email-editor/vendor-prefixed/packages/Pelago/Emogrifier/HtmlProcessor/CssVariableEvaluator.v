import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator {
	rt.PhpObjectBase
pub mut:
		currentVariableDefinitions rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) evaluatevariables() rt.PhpVal {
	return this.evaluatevariablesinelementanddescendants(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](this.gethtmlelement()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](rt.new_array()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) getvariabledefinitionsfromdeclarations(mut var_declarations Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array) rt.PhpVal {
	mut var_declarations_mutated := var_declarations
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.identical(rt.call_function('substr', [var_key.dup(), rt.new_int(0), rt.new_int(2)]), rt.new_string('--'))
	}
	return rt.call_function('array_filter', [var_declarations_mutated.dup(), rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) getpropertyvaluereplacement(mut var_matches Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array) string {
	mut var_variableName := var_matches.array_get(1)
	if this.currentVariableDefinitions.array_isset(var_variableName) {
		mut var_variableValue := this.currentVariableDefinitions.array_get(var_variableName)
	} else {
		mut var_fallbackValueSeparator := if !(var_matches.array_get(2)).is_null() { var_matches.array_get(2) } else { rt.new_string('') }
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			mut var_fallbackValue := var_matches.array_get(3)
			var_variableValue = rt.new_string(this.replacevariablesinpropertyvalue((var_fallbackValue).str()))
		} else {
			var_variableValue = var_matches.array_get(0)
		}
	}
	return (var_variableValue).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) replacevariablesinpropertyvalue(propertyValue string) string {
	return (rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'replaceCallback', [rt.new_string('/\n                var\\(\n                    \\s*+\n                    # capture variable name including `--` prefix\n                    (\n                        --[^\\s\\),]++\n                    )\n                    \\s*+\n                    # capture optional fallback value\n                    (?:\n                        # capture separator to confirm there is a fallback value\n                        (,)\\s*\n                        # begin capture with named group that can be used recursively\n                        (?<recursable>\n                            # begin named group to match sequence without parentheses, except in strings\n                            (?<noparentheses>\n                                # repeated zero or more times:\n                                (?:\n                                    # sequence without parentheses or quotes\n                                    [^\\(\\)\'"]++\n                                    |\n                                    # string in double quotes\n                                    "(?>[^"\\\\]++|\\\\.)*"\n                                    |\n                                    # string in single quotes\n                                    \'(?>[^\'\\\\]++|\\\\.)*\'\n                                )*+\n                            )\n                            # repeated zero or more times:\n                            (?:\n                                # sequence in parentheses\n                                \\(\n                                    # using the named recursable pattern\n                                    (?&recursable)\n                                \\)\n                                # sequence without parentheses, except in strings\n                                (?&noparentheses)\n                            )*+\n                        )\n                    )?+\n                \\)\n            /x'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Closure{}; return temp.fromcallable(arg_0) }(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator', ['Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor'], &this) }, rt.ArrayItem{ key: none, val: 'getPropertyValueReplacement' }])), rt.new_string(propertyValue)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) replacevariablesindeclarations(mut var_declarations Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array) rt.PhpVal {
	mut var_declarations_mutated := var_declarations
	mut var_substitutionsMade := rt.new_bool(rt.new_bool(false))
	closure_3_fn := fn [mut var_substitutionsMade] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [mut var_substitutionsMade] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_propertyValue := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_newPropertyValue := rt.new_string(this.replacevariablesinpropertyvalue(var_propertyValue))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_substitutionsMade = rt.new_bool(rt.new_bool(true))
	}
	return var_newPropertyValue.dup()
	}
	mut var_propertyValue := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_newPropertyValue := rt.new_string(this.replacevariablesinpropertyvalue(var_propertyValue))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_substitutionsMade = rt.new_bool(rt.new_bool(true))
	}
	return var_newPropertyValue.dup()
	}
	mut var_result := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_declarations_mutated.dup()])
	return if rt.is_true(var_substitutionsMade) { var_result } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) getdeclarationsasstring(mut var_declarations Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array) string {
	mut var_declarations_mutated := var_declarations
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_value := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (var_key).str() + ': ' + (var_value).str()
	}
	mut var_key := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_value := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return (var_key).str() + ': ' + (var_value).str()
	}
	mut var_declarationStrings := rt.call_function('array_map', [rt.new_closure(closure_4_fn), rt.func_array_keys(var_declarations_mutated.dup()), rt.call_function('array_values', [var_declarations_mutated.dup()])])
	return (rt.call_function('implode', [rt.new_string('; '), var_declarationStrings.dup()])).str() + ';'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) evaluatevariablesinelementanddescendants(mut var_element Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement, mut var_ancestorVariableDefinitions Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array) rt.PhpVal {
	mut var_style := var_element.getattribute(rt.new_string('style'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_declarations := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser(), 'parse', [var_style.dup()])
		mut var_variableDefinitions := this.currentVariableDefinitions = rt.add(this.getvariabledefinitionsfromdeclarations(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](var_declarations)), var_ancestorVariableDefinitions)
		mut var_newDeclarations := this.replacevariablesindeclarations(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](var_declarations))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_element.setattribute(rt.new_string('style'), rt.new_string(this.getdeclarationsasstring(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](var_newDeclarations))))
		}
	} else {
		var_variableDefinitions = var_ancestorVariableDefinitions
	}
	{
		mut iter_1 := rt.get_property(var_element, 'childNodes').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_child, 'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement'))) {
				this.evaluatevariablesinelementanddescendants(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](var_child), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](var_variableDefinitions))
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator', []string{}, this)
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Closure {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_cssvariableevaluator() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator{
		PhpObjectBase: rt.PhpObjectBase{}
		currentVariableDefinitions: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_closure() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Closure {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Closure{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'evaluateVariables' {
			return this.evaluatevariables()
		}
		'getVariableDefinitionsFromDeclarations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvariabledefinitionsfromdeclarations(mut dispatch_arg_0)
		}
		'getPropertyValueReplacement' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.getpropertyvaluereplacement(mut dispatch_arg_0))
		}
		'replaceVariablesInPropertyValue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.replacevariablesinpropertyvalue(dispatch_arg_0))
		}
		'replaceVariablesInDeclarations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.replacevariablesindeclarations(mut dispatch_arg_0)
		}
		'getDeclarationsAsString' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.getdeclarationsasstring(mut dispatch_arg_0))
		}
		'evaluateVariablesInElementAndDescendants' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.evaluatevariablesinelementanddescendants(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'currentVariableDefinitions' { return this.currentVariableDefinitions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssVariableEvaluator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'currentVariableDefinitions' { this.currentVariableDefinitions = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Closure) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Closure) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Closure) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_pelago_emogrifier_htmlprocessor_cssvariableevaluator_php() {
	// unsupported statement: Stmt_Declare
}
