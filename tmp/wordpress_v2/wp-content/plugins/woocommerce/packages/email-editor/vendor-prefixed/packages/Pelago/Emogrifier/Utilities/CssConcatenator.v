import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator {
	rt.PhpObjectBase
pub mut:
	mediaRules rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) append(mut var_selectors Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array, declarationsBlock string, media string) {
	mut var_selectors_mutated := var_selectors
	mut declarationsBlock_mutated := declarationsBlock
	mut media_mutated := media
	mut var_selectorsAsKeys := rt.call_function('array_flip', [var_selectors_mutated])
	mut var_mediaRule := this.getorcreatemediaruletoappendto(media_mutated)
	mut var_ruleBlocks := rt.get_property(var_mediaRule, 'ruleBlocks')
	mut var_lastRuleBlock := rt.call_function('end', [var_ruleBlocks.clone()])
	mut var_hasSameDeclarationsAsLastRule := rt.new_bool(var_lastRuleBlock.clone().is_object()
		&& rt.is_true(rt.identical(rt.new_string(declarationsBlock_mutated), rt.get_property(var_lastRuleBlock, 'declarationsBlock'))))
	if rt.is_true(var_hasSameDeclarationsAsLastRule) {
		rt.get_property(var_lastRuleBlock, 'selectorsAsKeys') = rt.add(rt.get_property(var_lastRuleBlock,
			'selectorsAsKeys'), var_selectorsAsKeys)
	} else {
		mut var_lastRuleBlockSelectors := if var_lastRuleBlock.clone().is_object() {
			rt.get_property(var_lastRuleBlock, 'selectorsAsKeys')
		} else {
			rt.new_array()
		}
		mut var_hasSameSelectorsAsLastRule := rt.new_bool(var_lastRuleBlock.clone().is_object()
			&& rt.is_true(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.hasequivalentselectors(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array](var_selectorsAsKeys), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array](var_lastRuleBlockSelectors))))
		if rt.is_true(var_hasSameSelectorsAsLastRule) {
			mut var_lastDeclarationsBlockWithoutSemicolon := rt.new_string(rt.get_property(var_lastRuleBlock,
				'declarationsBlock').to_string().trim_right(' \t\n\r').trim_right(' \t\n\r'))
			rt.set_property(var_lastRuleBlock, 'declarationsBlock',

				var_lastDeclarationsBlockWithoutSemicolon.str() + ';' + declarationsBlock_mutated)
		} else {
			rt.get_property(var_mediaRule, 'ruleBlocks').array_push(rt.array_to_object(rt.call_function('compact', [
				rt.new_string('selectorsAsKeys'),
				rt.new_string('declarationsBlock'),
			])))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) getcss() string {
	return (rt.call_function('implode', [rt.new_string(''),
		rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.class()
				},
				rt.ArrayItem{ key: none, val: 'getMediaRuleCss' },
			]),
			this.mediaRules,
		])])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) getorcreatemediaruletoappendto(media string) rt.PhpVal {
	mut media_mutated := media
	mut var_lastMediaRule := rt.call_function('end', [this.mediaRules])
	if var_lastMediaRule.clone().is_object()
		&& rt.is_true(rt.identical(rt.new_string(media_mutated), rt.get_property(var_lastMediaRule, 'media'))) {
		return var_lastMediaRule.clone()
	}
	mut var_newMediaRule := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'media', val: media_mutated },
		rt.ArrayItem{ key: 'ruleBlocks', val: rt.new_array() },
	]))
	this.mediaRules.array_push(var_newMediaRule.clone())
	return var_newMediaRule.clone()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.hasequivalentselectors(mut var_selectorsAsKeys1 Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array, mut var_selectorsAsKeys2 Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array) bool {
	return var_selectorsAsKeys1.array_count() == var_selectorsAsKeys2.array_count()
		&& var_selectorsAsKeys1.array_count() == rt.add(var_selectorsAsKeys1, var_selectorsAsKeys2).array_count()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.getmediarulecss(mut var_mediaRule Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_object) string {
	mut var_mediaRule_mutated := var_mediaRule
	mut var_ruleBlocks := rt.get_property(var_mediaRule_mutated, 'ruleBlocks')
	mut var_css := rt.call_function('implode', [rt.new_string(''),
		rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.class()
				},
				rt.ArrayItem{ key: none, val: 'getRuleBlockCss' },
			]),
			var_ruleBlocks.clone(),
		])])
	mut var_media := rt.get_property(var_mediaRule_mutated, 'media')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_media, rt.new_string(''))))) {
		var_css = rt.new_string(var_media.str() + '{' + var_css.str() + '}')
	}
	return var_css.str()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.getruleblockcss(mut var_ruleBlock Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_object) string {
	mut var_selectorsAsKeys := rt.get_property(var_ruleBlock, 'selectorsAsKeys')
	mut var_selectors := rt.func_array_keys(var_selectorsAsKeys.clone())
	mut var_declarationsBlock := rt.get_property(var_ruleBlock, 'declarationsBlock')
	return (rt.call_function('implode', [rt.new_string(','), var_selectors.clone()])).str() + '{' +
		var_declarationsBlock.str() + '}'
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_cssconcatenator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator{
		PhpObjectBase: rt.PhpObjectBase{}
		mediaRules:    rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'append' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.append(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'getCss' {
			return rt.new_string(this.getcss())
		}
		'getOrCreateMediaRuleToAppendTo' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.getorcreatemediaruletoappendto(dispatch_arg_0)
		}
		'hasEquivalentSelectors' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.hasequivalentselectors(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'getMediaRuleCss' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.getmediarulecss(mut dispatch_arg_0))
		}
		'getRuleBlockCss' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator.getruleblockcss(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'mediaRules' { return this.mediaRules }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'mediaRules' {
			this.mediaRules = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
