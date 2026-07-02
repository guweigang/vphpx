import rt

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) construct(iLineNo i64) {
	this.Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList.construct(rt.new_int(iLineNo))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) alldeclarationblocks(mut var_aResult Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array) {
	mut var_aResult_mutated := var_aResult
	mut iter_1 := rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList', [
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList',
	], &this), 'aContents').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_mContent := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_mContent,
			'Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_DeclarationBlock')))
		{
			var_aResult_mutated.array_push(var_mContent.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_mContent,
			'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList')))
		{
			rt.call_method(var_mContent, 'allDeclarationBlocks', [var_aResult_mutated])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) allrulesets(mut var_aResult Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array) {
	mut var_aResult_mutated := var_aResult
	mut iter_2 := rt.get_property(rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList', [
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList',
	], &this), 'aContents').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_mContent := item_2.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_mContent,
			'Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet')))
		{
			var_aResult_mutated.array_push(var_mContent.clone())
		} else if rt.is_true(rt.new_bool(rt.instance_of(var_mContent,
			'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList')))
		{
			rt.call_method(var_mContent, 'allRuleSets', [var_aResult_mutated])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) getallvalues(var_element rt.PhpVal, var_ruleSearchPatternOrSearchInFunctionArguments rt.PhpVal, searchInFunctionArguments bool) rt.PhpVal {
	mut var_element_mutated := var_element
	mut searchInFunctionArguments_mutated := searchInFunctionArguments
	if rt.is_true(rt.new_bool(var_ruleSearchPatternOrSearchInFunctionArguments.clone().is_bool())) {
		searchInFunctionArguments_mutated =
			var_ruleSearchPatternOrSearchInFunctionArguments.to_bool()
		mut var_searchString := rt.new_null()
	} else {
		var_searchString = var_ruleSearchPatternOrSearchInFunctionArguments
	}
	if rt.is_true(rt.identical(var_element_mutated, rt.new_null())) {
		var_element_mutated = rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList', [
			'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList',
		], &this)
	} else if rt.is_true(rt.new_bool(var_element_mutated.clone().is_string())) {
		var_searchString = var_element_mutated.clone()
		var_element_mutated = rt.new_object('Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList', [
			'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList',
		], &this)
	}
	mut var_result := rt.new_array()
	this.allvalues(var_element_mutated.clone(), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array](var_result),
		var_searchString.clone(), searchInFunctionArguments_mutated)
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) allvalues(var_oElement rt.PhpVal, mut var_aResult Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array, var_sSearchString rt.PhpVal, bSearchInFunctionArguments bool) {
	mut var_aResult_mutated := var_aResult
	if rt.is_true(rt.new_bool(rt.instance_of(var_oElement,
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList')))
	{
		mut iter_3 := rt.call_method(var_oElement, 'getContents', []rt.PhpVal{}).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_oContent := item_3.val
			this.allvalues(var_oContent.clone(), mut var_aResult_mutated,
				var_sSearchString.clone(), bSearchInFunctionArguments)
		}
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_oElement,
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_RuleSet_RuleSet')))
	{
		mut iter_4 := rt.call_method(var_oElement, 'getRules', [
			var_sSearchString.clone()]).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_oRule := item_4.val
			this.allvalues(var_oRule.clone(), mut var_aResult_mutated, var_sSearchString.clone(),
				bSearchInFunctionArguments)
		}
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_oElement,
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Rule_Rule')))
	{
		this.allvalues(rt.call_method(var_oElement, 'getValue', []rt.PhpVal{}), mut
			var_aResult_mutated, var_sSearchString.clone(), bSearchInFunctionArguments)
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_oElement,
		'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_ValueList')))
	{
		if var_bSearchInFunctionArguments
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_oElement, 'Automattic_WooCommerce_Vendor_Sabberworm_CSS_Value_CSSFunction')))))) {
			mut iter_5 :=
				rt.call_method(var_oElement, 'getListComponents', []rt.PhpVal{}).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_mComponent := item_5.val
				this.allvalues(var_mComponent.clone(), mut var_aResult_mutated,
					var_sSearchString.clone(), bSearchInFunctionArguments)
			}
		}
	} else {
		var_aResult_mutated.array_push(var_oElement.clone())
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) allselectors(mut var_aResult Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array, var_sSpecificitySearch rt.PhpVal) {
	mut var_aResult_mutated := var_aResult
	mut var_aDeclarationBlocks := rt.new_array()
	this.alldeclarationblocks(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array](var_aDeclarationBlocks))
	mut iter_6 := var_aDeclarationBlocks.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_oBlock := item_6.val
		mut iter_7 := rt.call_method(var_oBlock, 'getSelectors', []rt.PhpVal{}).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_oSelector := item_7.val
			if rt.is_true(rt.identical(var_sSpecificitySearch, rt.new_null())) {
				var_aResult_mutated.array_push(var_oSelector.clone())
			} else {
				mut var_sComparator := rt.new_string('===')
				mut var_aSpecificitySearch := rt.call_function('explode', [
					rt.new_string(' '),
					var_sSpecificitySearch.clone(),
				])
				mut var_iTargetSpecificity := var_aSpecificitySearch.array_get(rt.new_int(0))
				if var_aSpecificitySearch.clone().array_count() > 1 {
					var_sComparator = var_aSpecificitySearch.array_get(rt.new_int(0))
					var_iTargetSpecificity = var_aSpecificitySearch.array_get(rt.new_int(1))
				}
				var_iTargetSpecificity = rt.new_int(var_iTargetSpecificity.to_i64())
				mut var_iSelectorSpecificity := rt.call_method(var_oSelector, 'getSpecificity',
					[]rt.PhpVal{})
				mut var_bMatches := rt.new_bool(false)
				mut switch_val_1 := var_sComparator
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('<='))) {
					var_bMatches = rt.less_equal(var_iSelectorSpecificity, var_iTargetSpecificity)
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('<'))) {
					var_bMatches = rt.less(var_iSelectorSpecificity, var_iTargetSpecificity)
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('>='))) {
					var_bMatches = rt.greater_equal(var_iSelectorSpecificity,
						var_iTargetSpecificity)
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('>'))) {
					var_bMatches = rt.greater(var_iSelectorSpecificity, var_iTargetSpecificity)
				} else {
					var_bMatches = rt.identical(var_iSelectorSpecificity, var_iTargetSpecificity)
				}
				if rt.is_true(var_bMatches) {
					var_aResult_mutated.array_push(var_oSelector.clone())
				}
			}
		}
	}
}

struct Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_sabberworm_css_csslist_cssblocklist(iLineNo i64) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_vendor_sabberworm_css_csslist_csslist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'allDeclarationBlocks' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.alldeclarationblocks(mut dispatch_arg_0)
			return rt.new_null()
		}
		'allRuleSets' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.allrulesets(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getAllValues' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.getallvalues(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'allValues' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			this.allvalues(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'allSelectors' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.allselectors(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Sabberworm_CSS_CSSList_CSSList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
