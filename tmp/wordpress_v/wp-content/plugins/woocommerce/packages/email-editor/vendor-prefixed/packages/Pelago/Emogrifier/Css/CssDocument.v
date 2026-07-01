import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument {
	rt.PhpObjectBase
pub mut:
		sabberwormCssDocument rt.PhpVal = rt.new_null()
		isImportRuleAllowed bool
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) construct(css string, debug bool)  {
	mut var_parserSettings := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings{}; return temp.create() }(), 'withLenientParsing', [rt.new_bool(!(var_debug) || this.hasnestedatrule(css))])
	this.sabberwormCssDocument = rt.call_method(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parser(rt.new_string(css.trim_space()), var_parserSettings.dup()), 'parse', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) hasnestedatrule(css string) bool {
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) getstylerulesdata(mut var_allowedMediaTypes Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_array) rt.PhpVal {
	mut var_ruleMatches := rt.new_array()
	{
		mut iter_1 := rt.call_method(this.sabberwormCssDocument, 'getContents', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_rule := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_rule, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList'))) {
				mut var_containingAtRule := rt.new_string(this.getfilteredatidentifierandrule(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList](var_rule), mut var_allowedMediaTypes))
				if rt.is_true(rt.new_bool(var_containingAtRule.dup().is_string())) {
					{
						mut iter_2 := rt.call_method(var_rule, 'getContents', []rt.PhpVal{}).iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_nestedRule := item_2.val
							if rt.is_true(rt.new_bool(rt.instance_of(var_nestedRule, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock'))) {
								var_ruleMatches.array_push(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_stylerule(var_nestedRule.dup(), var_containingAtRule.dup()))
							}
						}
					}
				}
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_rule, 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_DeclarationBlock'))) {
				var_ruleMatches.array_push(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_stylerule(var_rule.dup()))
			}
		}
	}
	return var_ruleMatches.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) rendernonconditionalatrules() string {
	this.isImportRuleAllowed = true
	mut var_cssContents := rt.call_method(this.sabberwormCssDocument, 'getContents', []rt.PhpVal{})
	mut var_atRules := rt.call_function('array_filter', [var_cssContents.dup(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'isValidAtRuleToRender' }])])
	if rt.is_true(rt.identical(var_atRules, rt.new_array())) {
		return ''
	}
	mut var_atRulesDocument := create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_document()
	var_atRulesDocument.setcontents(var_atRules.dup())
	return (var_atRulesDocument.render()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) getfilteredatidentifierandrule(mut var_rule Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList, mut var_allowedMediaTypes Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_array) string {
	mut var_mediaType := rt.new_null()
	mut var_result := rt.new_null()
	if rt.is_true(rt.identical(var_rule.atrulename(), rt.new_string('media'))) {
		mut var_mediaQueryList := var_rule.atruleargs()
		// unsupported assign target: Expr_List
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_allowedMediaType := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.call_function('preg_quote', [var_allowedMediaType.dup(), rt.new_string('/')])).str()
	}
	mut var_allowedMediaType := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (rt.call_function('preg_quote', [var_allowedMediaType.dup(), rt.new_string('/')])).str()
	}
			mut var_escapedAllowedMediaTypes := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_allowedMediaTypes])
			mut var_mediaTypesMatcher := rt.call_function('implode', [rt.new_string('|'), var_escapedAllowedMediaTypes.dup()])
			mut var_isAllowed := // unsupported expression: Expr_BinaryOp_NotIdentical
		} else {
			var_isAllowed = rt.new_bool(rt.new_bool(true))
		}
		if rt.is_true(var_isAllowed) {
			var_result = rt.new_string('@media ' + (var_mediaQueryList).str())
		}
	}
	return (var_result).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) isvalidatruletorender(mut var_rule Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Renderable) bool {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Renderable', []string{}, var_rule), 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset'))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Renderable', []string{}, var_rule), 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import'))) {
		return this.isImportRuleAllowed
	}
	this.isImportRuleAllowed = false
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Renderable', []string{}, var_rule), 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_AtRule')))))) {
		return false
	}
	mut switch_val_1 := var_rule.atrulename()
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('media'))) {
		mut var_result := rt.new_bool(rt.new_bool(false))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('font-face'))) {
		var_result = rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Renderable', []string{}, var_rule), 'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_RuleSet_RuleSet'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	} else {
		var_result = rt.new_bool(rt.new_bool(true))
	}
	return (var_result).to_bool()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_StyleRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_cssdocument(css string, debug bool) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument{
		PhpObjectBase: rt.PhpObjectBase{}
		sabberwormCssDocument: rt.new_null()
		isImportRuleAllowed: false
	}
	obj.construct(css, debug)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_settings() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parser() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parser {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_stylerule() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_StyleRule {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_StyleRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_document() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'hasNestedAtRule' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasnestedatrule(dispatch_arg_0))
		}
		'getStyleRulesData' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getstylerulesdata(mut dispatch_arg_0)
		}
		'renderNonConditionalAtRules' {
			return rt.new_string(this.rendernonconditionalatrules())
		}
		'getFilteredAtIdentifierAndRule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_AtRuleBlockList](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.getfilteredatidentifierandrule(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'isValidAtRuleToRender' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Renderable](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.isvalidatruletorender(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sabberwormCssDocument' { return this.sabberwormCssDocument }
		'isImportRuleAllowed' { return rt.new_bool(this.isImportRuleAllowed) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sabberwormCssDocument' { this.sabberwormCssDocument = val; return true }
		'isImportRuleAllowed' { this.isImportRuleAllowed = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_StyleRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_StyleRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_StyleRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_pelago_emogrifier_css_cssdocument_php() {
	// unsupported statement: Stmt_Declare
}
