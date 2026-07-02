import rt

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_selector() i64 {
	return 0
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_combined_styles() i64 {
	return 1
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.pseudo_class_matcher() string {
	return 'empty|(?:first|last|nth(?:-last)?+|only)-(?:child|of-type)|not\\([[:ascii:]]*\\)|root'
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.of_type_pseudo_class_matcher() string {
	return '(?:first|last|nth(?:-last)?+|only)-of-type'
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.combinator_matcher() string {
	return '(?:\\s++|\\s*+[>+~]\\s*+)(?=[[:alpha:]_\\-.#*:\\[])'
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.qsa_always_throw_parse_exception() string {
	return 'alwaysThrowParseException'
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner {
	rt.PhpObjectBase
pub mut:
	excludedSelectors                     rt.PhpVal = rt.new_array()
	excludedCssSelectors                  rt.PhpVal = rt.new_array()
	allowedMediaTypes                     rt.PhpVal = rt.new_array()
	caches                                rt.PhpVal = rt.new_array()
	cssSelectorConverter                  rt.PhpVal = rt.new_null()
	visitedNodes                          rt.PhpVal = rt.new_array()
	styleAttributesForNodes               rt.PhpVal = rt.new_array()
	isInlineStyleAttributesParsingEnabled bool
	isStyleBlocksParsingEnabled           bool
	selectorPrecedenceMatchers            rt.PhpVal = rt.new_array()
	matchingUninlinableCssRules           rt.PhpVal = rt.new_null()
	debug                                 rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) inlinecss(css string) rt.PhpVal {
	mut css_mutated := css
	this.clearallcaches()
	this.purgevisitednodes()
	this.normalizestyleattributesofallnodes()
	mut var_combinedCss := rt.new_string(css_mutated).clone()
	if this.isStyleBlocksParsingEnabled {
		var_combinedCss = rt.concat(var_combinedCss, this.getcssfromallstylenodes())
	}
	mut var_parsedCss := create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_cssdocument(var_combinedCss.clone(),
		this.debug)
	mut var_excludedNodes := this.getnodestoexclude()
	mut var_cssRules := this.collatecssrules(mut var_parsedCss)
	mut iter_1 := var_cssRules.array_get(rt.new_string('inlinable')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cssRule := item_1.val
		mut iter_2 := this.queryselectorall((var_cssRule.array_get(rt.new_string('selector'))).str(),
			rt.new_null()).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_node := item_2.val
			if rt.is_true(rt.call_function('in_array', [var_node.clone(),
				var_excludedNodes.clone(), rt.new_bool(true)]))
			{
				continue
			}
			this.copyinlinablecsstostyleattribute(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](this.ensurenodeiselement(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode](var_node))), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_cssRule))
		}
	}
	if this.isInlineStyleAttributesParsingEnabled {
		this.fillstyleattributeswithmergedstyles()
	}
	this.removeimportantannotationfromallinlinestyles()
	this.determinematchinguninlinablecssrules(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_cssRules.array_get(rt.new_string('uninlinable'))))
	this.copyuninlinablecsstostylenode(mut var_parsedCss)
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) disableinlinestyleattributesparsing() rt.PhpVal {
	this.isInlineStyleAttributesParsingEnabled = false
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) disablestyleblocksparsing() rt.PhpVal {
	this.isStyleBlocksParsingEnabled = false
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) addallowedmediatype(mediaName string) rt.PhpVal {
	this.allowedMediaTypes.array_set(mediaName, true)
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeallowedmediatype(mediaName string) rt.PhpVal {
	if this.allowedMediaTypes.array_isset(rt.new_string(mediaName)) {
		this.allowedMediaTypes.array_unset(rt.new_string(mediaName))
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) addexcludedselector(selector string) rt.PhpVal {
	mut selector_mutated := selector
	this.excludedSelectors.array_set(selector_mutated, true)
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeexcludedselector(selector string) rt.PhpVal {
	mut selector_mutated := selector
	if this.excludedSelectors.array_isset(rt.new_string(selector_mutated)) {
		this.excludedSelectors.array_unset(rt.new_string(selector_mutated))
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) addexcludedcssselector(selector string) rt.PhpVal {
	mut selector_mutated := selector
	this.excludedCssSelectors.array_set(selector_mutated, true)
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeexcludedcssselector(selector string) rt.PhpVal {
	mut selector_mutated := selector
	if this.excludedCssSelectors.array_isset(rt.new_string(selector_mutated)) {
		this.excludedCssSelectors.array_unset(rt.new_string(selector_mutated))
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) setdebug(debug bool) rt.PhpVal {
	this.debug = rt.new_bool(debug)
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getmatchinguninlinableselectors() rt.PhpVal {
	return rt.call_function('array_column', [this.getmatchinguninlinablecssrules(),
		rt.new_string('selector')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getmatchinguninlinablecssrules() rt.PhpVal {
	if !(this.matchingUninlinableCssRules.is_array()) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_badmethodcallexception(rt.new_string('inlineCss must be called first'),
			rt.new_int(1568385221))))
	}
	return this.matchingUninlinableCssRules
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) clearallcaches() {
	this.caches = rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_selector()
			val: rt.new_array()
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_combined_styles()
			val: rt.new_array()
		},
	])
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser{}
	mut iife_result_0 := iife_temp_0.clearcache()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) purgevisitednodes() {
	this.visitedNodes = rt.new_array()
	this.styleAttributesForNodes = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) normalizestyleattributesofallnodes() {
	mut iter_3 := this.getallnodeswithstyleattribute().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_node := item_3.val
		if this.isInlineStyleAttributesParsingEnabled {
			this.normalizestyleattributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](var_node))
		}
		rt.call_method(var_node, 'removeAttribute', [rt.new_string('style')])
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getallnodeswithstyleattribute() rt.PhpVal {
	mut var_query := rt.new_string('//*[@style]')
	mut var_matches := rt.call_method(this.getxpath(), 'query', [
		var_query.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_matches,
		'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList'))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_runtimeexception(
			'XPatch query failed: ' + var_query.str(), rt.new_int(1618577797))))
	}
	return var_matches.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) normalizestyleattributes(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement) {
	mut var_node_mutated := var_node
	mut var_declarationBlockParser :=
		create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser()
	closure_2_fn := fn [var_declarationBlockParser] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_propertyNameMatches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_normalizedOriginalStyle := rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug]), 'replaceCallback', [
		rt.new_string('/-{0,2}+[_a-zA-Z][\\w\\-]*+(?=:)/S'),
		rt.new_closure(closure_2_fn),
		rt.call_method(var_node_mutated, 'getAttribute', [rt.new_string('style')]),
	])
	mut var_nodePath := rt.call_method(var_node_mutated, 'getNodePath', []rt.PhpVal{})
	if var_nodePath.clone().is_string() && !(this.styleAttributesForNodes.array_isset(var_nodePath)) {
		this.styleAttributesForNodes.array_set(var_nodePath,
			var_declarationBlockParser.parse(var_normalizedOriginalStyle.clone()))
		this.visitedNodes.array_set(var_nodePath, var_node_mutated)
	}
	rt.call_method(var_node_mutated, 'setAttribute', [rt.new_string('style'),
		var_normalizedOriginalStyle.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getcssfromallstylenodes() string {
	mut var_styleNodes := rt.call_method(this.getxpath(), 'query', [
		rt.new_string('//style'),
	])
	if rt.is_true(rt.identical(var_styleNodes, rt.new_bool(false))) {
		return ''
	}
	mut var_css := rt.new_string('')
	mut iter_4 := var_styleNodes.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_styleNode := item_4.val
		if rt.is_true(rt.new_bool(rt.get_property(var_styleNode, 'nodeValue').is_string())) {
			var_css = rt.concat(var_css, rt.new_string('\n\n' +
				(rt.get_property(var_styleNode, 'nodeValue')).str()))
		}
		mut var_parentNode := rt.get_property(var_styleNode, 'parentNode')
		if rt.is_true(rt.new_bool(rt.instance_of(var_parentNode,
			'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode')))
		{
			rt.call_method(var_parentNode, 'removeChild', [var_styleNode.clone()])
		}
	}
	return var_css.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getnodestoexclude() rt.PhpVal {
	mut var_excludedNodes := rt.new_array()
	mut iter_5 := rt.func_array_keys(this.excludedSelectors).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_selectorToExclude := item_5.val
		mut iter_6 := this.queryselectorall(var_selectorToExclude.str(), rt.new_null()).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_node := item_6.val
			var_excludedNodes.array_push(this.ensurenodeiselement(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode](var_node)))
		}
	}
	return var_excludedNodes.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) queryselectorall(selectors string, mut var_options Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) rt.PhpVal {
	mut selectors_mutated := selectors
	mut var_result := rt.call_method(this.getxpath(), 'query', [
		rt.call_method(this.getcssselectorconverter(), 'toXPath', [
			rt.new_string(selectors_mutated).clone()]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.identical(var_result, rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_runtimeexception(
			"query failed with selector '" + selectors_mutated + "'", rt.new_int(1726533051))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_result.clone()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ParseException')
	{
		mut var_exception := var_e_1.clone()
		mut var_alwaysThrowParseException := if !(var_options.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.qsa_always_throw_parse_exception())).is_null() {
			var_options.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.qsa_always_throw_parse_exception())
		} else {
			rt.new_bool(false)
		}
		if rt.is_true(this.debug) || rt.is_true(var_alwaysThrowParseException) {
			rt.throw_exception(var_exception)
		}
		return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList',
			[]string{},
			create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_domnodelist())
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException')
	{
		var_exception = var_e_1.clone()
		if rt.is_true(this.debug) {
			rt.throw_exception(var_exception)
		}
		rt.call_function('trigger_error', [
			rt.call_method(var_exception, 'getMessage', []rt.PhpVal{}),
		])
		return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList',
			[]string{},
			create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_domnodelist())
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) ensurenodeiselement(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode) rt.PhpVal {
	mut var_node_mutated := var_node
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_node_mutated,
		'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement'))))))
	{
		mut var_path := if !(rt.call_method(var_node_mutated, 'getNodePath', []rt.PhpVal{})).is_null() {
			rt.call_method(var_node_mutated, 'getNodePath', []rt.PhpVal{})
		} else {
			rt.new_string('$node')
		}
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_unexpectedvalueexception(
			var_path.str() + ' is not a DOMElement.', rt.new_int(1617975914))))
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode',
		[]string{}, var_node_mutated)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getcssselectorconverter() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.cssSelectorConverter,
		'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter'))))))
	{
		this.cssSelectorConverter =
			create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_cssselectorconverter()
	}
	return this.cssSelectorConverter
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) collatecssrules(mut var_parsedCss Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) rt.PhpVal {
	mut var_parsedCss_mutated := var_parsedCss
	mut var_matches :=
		var_parsedCss_mutated.getstylerulesdata(rt.func_array_keys(this.allowedMediaTypes))
	mut var_preg := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug])
	mut var_cssRules := rt.create_array([
		rt.ArrayItem{ key: 'inlinable', val: rt.new_array() },
		rt.ArrayItem{ key: 'uninlinable', val: rt.new_array() },
	])
	mut iter_7 := var_matches.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_cssRule := item_7.val
		mut var_key := item_7.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cssRule,
			'hasAtLeastOneDeclaration', []rt.PhpVal{})))))
		{
			continue
		}
		mut var_mediaQuery := rt.call_method(var_cssRule, 'getContainingAtRule', []rt.PhpVal{})
		mut var_declarationsBlock := rt.call_method(var_cssRule, 'getDeclarationAsText',
			[]rt.PhpVal{})
		mut var_selectors := rt.call_method(var_cssRule, 'getSelectors', []rt.PhpVal{})
		if this.excludedCssSelectors.array_count() > 0 {
			closure_3_fn := fn [var_preg] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_selector := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.call_method(var_preg, 'replace', [rt.new_string('@\\s++@u'),
					rt.new_string(' '), var_selector.clone()])
			}
			closure_4_fn := fn [var_preg] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_selector := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.call_method(var_preg, 'replace', [rt.new_string('@\\s++@u'),
					rt.new_string(' '), var_selector.clone()])
			}
			mut var_selectorsNormalized := rt.call_function('array_map', [
				rt.new_closure(closure_3_fn),
				var_selectors.clone(),
			])
			closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_selector := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return rt.new_bool(!(this.excludedCssSelectors.array_isset(var_selector)))
			}
			var_selectors = rt.call_function('array_filter', [
				var_selectorsNormalized.clone(), rt.new_closure(closure_5_fn)])
		}
		mut iter_8 := var_selectors.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_selector := item_8.val
			mut var_hasPseudoElement := rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
				var_selector.clone(),
				rt.new_string('::'),
			]), rt.new_bool(false))))
			mut var_hasUnmatchablePseudo := rt.new_bool(rt.is_true(var_hasPseudoElement)
				|| this.hasunsupportedpseudoclass(var_selector.str()))
			mut var_parsedCssRule := rt.create_array([
				rt.ArrayItem{ key: 'media', val: var_mediaQuery },
				rt.ArrayItem{ key: 'selector', val: var_selector },
				rt.ArrayItem{ key: 'hasUnmatchablePseudo', val: var_hasUnmatchablePseudo },
				rt.ArrayItem{ key: 'declarationsBlock', val: var_declarationsBlock },
				rt.ArrayItem{ key: 'line', val: var_key },
			])
			mut var_ruleType := rt.new_string((if
				rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_cssRule, 'hasContainingAtRule', []rt.PhpVal{})))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_hasUnmatchablePseudo)))) {
				'inlinable'
			} else {
				'uninlinable'
			}).str())
			var_cssRules.array_get_mut(var_ruleType).array_push(var_parsedCssRule.clone())
		}
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_first := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_second := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		return rt.new_int(this.sortbyselectorprecedence(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_first), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_second)))
	}
	rt.call_function('usort', [var_cssRules.array_get(rt.new_string('inlinable')),
		rt.new_closure(closure_6_fn)])
	return var_cssRules.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) hasunsupportedpseudoclass(selector string) bool {
	mut selector_mutated := selector
	mut var_preg := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_preg, 'match', [
		rt.new_string('/:(?!' +
			(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.pseudo_class_matcher()).str() + ')[\\w\\-]/i'),
		rt.new_string(selector_mutated).clone(),
	]), rt.new_int(0)))))
	{
		return true
	}
	if rt.is_true(rt.identical(rt.call_method(var_preg, 'match', [
		rt.new_string('/:(?:' +
			(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.of_type_pseudo_class_matcher()).str() + ')/i'),
		rt.new_string(selector_mutated).clone(),
	]), rt.new_int(0)))
	{
		return false
	}
	mut iter_9 := rt.call_method(var_preg, 'split', [
		rt.new_string('/' +
			(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.combinator_matcher()).str() + '/'),
		rt.new_string(selector_mutated).clone(),
	]).iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_selectorPart := item_9.val
		if this.selectorparthasunsupportedoftypepseudoclass(var_selectorPart.str()) {
			return true
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) selectorparthasunsupportedoftypepseudoclass(selectorPart string) bool {
	mut var_preg := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_preg, 'match', [
		rt.new_string('/^[\\w\\-]/'),
		rt.new_string(selectorPart),
	]), rt.new_int(0)))))
	{
		return false
	}
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_preg, 'match', [
		rt.new_string('/:(?:' +
			(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.of_type_pseudo_class_matcher()).str() + ')/i'),
		rt.new_string(selectorPart),
	]), rt.new_int(0))))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) sortbyselectorprecedence(mut var_first Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array, mut var_second Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) i64 {
	mut var_precedenceOfFirst :=
		rt.new_int(this.getcssselectorprecedence((var_first.array_get(rt.new_string('selector'))).str()))
	mut var_precedenceOfSecond :=
		rt.new_int(this.getcssselectorprecedence((var_second.array_get(rt.new_string('selector'))).str()))
	mut var_precedenceForEquals := rt.new_int(if rt.is_true(rt.less(var_first.array_get(rt.new_string('line')),
		var_second.array_get(rt.new_string('line'))))
	{
		-1
	} else {
		1
	})
	mut var_precedenceForNotEquals := rt.new_int(if rt.is_true(rt.less(var_precedenceOfFirst,
		var_precedenceOfSecond))
	{
		-1
	} else {
		1
	})
	return (if rt.is_true(rt.identical(var_precedenceOfFirst, var_precedenceOfSecond)) {
		var_precedenceForEquals
	} else {
		var_precedenceForNotEquals
	}).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getcssselectorprecedence(selector string) i64 {
	mut selector_mutated := selector
	mut var_selectorKey := rt.new_string(selector_mutated).clone()
	if this.caches.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_selector()).array_isset(var_selectorKey) {
		return (this.caches.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_selector()).array_get(var_selectorKey)).to_i64()
	}
	mut var_preg := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug])
	mut var_precedence := rt.new_int(0)
	mut iter_10 := this.selectorPrecedenceMatchers.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_value := item_10.val
		mut var_matcher := item_10.key
		if rt.is_true(rt.identical(rt.new_string(selector_mutated.trim_space()), rt.new_string(''))) {
			break
		}
		mut var_count := rt.new_int(0)
		selector_mutated = (rt.call_method(var_preg, 'replace', [
			rt.new_string('/' + var_matcher.str() + '\\w+/'),
			rt.new_string(''),
			rt.new_string(selector_mutated).clone(),
			rt.new_int(-1),
			var_count.clone(),
		])).str()
		var_precedence = rt.add(var_precedence, rt.mul(var_value, var_count))
	}
	this.caches.array_get_mut(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_selector()).array_set(var_selectorKey,
		var_precedence.clone())
	return var_precedence.to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) copyinlinablecsstostyleattribute(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement, mut var_cssRule Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) {
	mut var_node_mutated := var_node
	mut var_declarationsBlock := var_cssRule.array_get(rt.new_string('declarationsBlock'))
	mut var_declarationBlockParser :=
		create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser()
	mut var_newStyleDeclarations := var_declarationBlockParser.parse(var_declarationsBlock.clone())
	if rt.is_true(rt.identical(var_newStyleDeclarations, rt.new_array())) {
		return
	}
	if rt.is_true(rt.call_method(var_node_mutated, 'hasAttribute', [
		rt.new_string('style'),
	]))
	{
		mut var_oldStyleDeclarations := var_declarationBlockParser.parse(rt.call_method(var_node_mutated,
			'getAttribute', [rt.new_string('style')]))
	} else {
		var_oldStyleDeclarations = rt.new_array()
	}
	rt.call_method(var_node_mutated, 'setAttribute', [rt.new_string('style'),
		rt.new_string(this.generatestylestringfromdeclarationsarrays(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_oldStyleDeclarations), mut
			rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_newStyleDeclarations)))])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) generatestylestringfromdeclarationsarrays(mut var_oldStyles Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array, mut var_newStyles Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) string {
	mut var_cacheKey := rt.call_function('serialize', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_oldStyles },
			rt.ArrayItem{ key: none, val: var_newStyles }]),
	])
	if this.caches.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_combined_styles()).array_isset(var_cacheKey) {
		return (this.caches.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_combined_styles()).array_get(var_cacheKey)).str()
	}
	mut iter_11 := var_oldStyles.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_attributeValue := item_11.val
		mut var_attributeName := item_11.key
		if !(var_newStyles.array_isset(var_attributeName)) {
			continue
		}
		mut var_newAttributeValue := var_newStyles.array_get(var_attributeName)
		if this.attributevalueisimportant(var_attributeValue.str())
			&& !(this.attributevalueisimportant(var_newAttributeValue.str())) {
			var_newStyles.array_unset(var_attributeName)
		} else {
			var_oldStyles.array_unset(var_attributeName)
		}
	}
	mut var_combinedStyles := rt.call_function('array_merge', [var_oldStyles, var_newStyles])
	mut var_declarationBlockParser :=
		create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser()
	mut var_style := rt.new_string('')
	mut iter_12 := var_combinedStyles.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_attributeValue := item_12.val
		mut var_attributeName := item_12.key
		mut var_trimmedAttributeName :=
			rt.new_string(var_attributeName.clone().to_string().trim_space())
		if rt.is_true(rt.identical(var_trimmedAttributeName, rt.new_string(''))) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException',
				[]string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_unexpectedvalueexception(rt.new_string('An empty property name was encountered.'),
				rt.new_int(1727046078))))
		}
		mut var_propertyName :=
			var_declarationBlockParser.normalizepropertyname(var_trimmedAttributeName.clone())
		mut var_propertyValue := rt.new_string(var_attributeValue.clone().to_string().trim_space())
		var_style = rt.concat(var_style, rt.new_string(var_propertyName.str() + ': ' +
			var_propertyValue.str() + '; '))
	}
	mut var_trimmedStyle := rt.new_string(var_style.clone().to_string().trim_right(' \t\n\r'))
	this.caches.array_get_mut(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.cache_key_combined_styles()).array_set(var_cacheKey,
		var_trimmedStyle.clone())
	return var_trimmedStyle.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) attributevalueisimportant(attributeValue string) bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug]), 'match', [rt.new_string('/!\\s*+important$/i'),
		rt.new_string(attributeValue)]), rt.new_int(0))))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) fillstyleattributeswithmergedstyles() {
	mut var_declarationBlockParser :=
		create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser()
	mut iter_13 := this.styleAttributesForNodes.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_styleAttributesForNode := item_13.val
		mut var_nodePath := item_13.key
		mut var_node := this.visitedNodes.array_get(var_nodePath)
		mut var_currentStyleAttributes := var_declarationBlockParser.parse(rt.call_method(var_node,
			'getAttribute', [rt.new_string('style')]))
		rt.call_method(var_node, 'setAttribute', [rt.new_string('style'),
			rt.new_string(this.generatestylestringfromdeclarationsarrays(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_currentStyleAttributes), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_styleAttributesForNode)))])
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeimportantannotationfromallinlinestyles() {
	mut iter_14 := this.getallnodeswithstyleattribute().iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_node := item_14.val
		this.removeimportantannotationfromnodeinlinestyle(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](var_node))
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeimportantannotationfromnodeinlinestyle(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement) {
	mut var_node_mutated := var_node
	mut var_style := rt.call_method(var_node_mutated, 'getAttribute', [
		rt.new_string('style'),
	])
	mut var_inlineStyleDeclarations := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser(),
		'parse', [if rt.is_true(var_style.to_bool()) { var_style } else { rt.new_string('') }])
	mut var_regularStyleDeclarations := rt.new_array()
	mut var_importantStyleDeclarations := rt.new_array()
	mut iter_15 := var_inlineStyleDeclarations.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_value := item_15.val
		mut var_property := item_15.key
		if this.attributevalueisimportant(var_value.str()) {
			var_importantStyleDeclarations.array_set(var_property, rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
				'throwExceptions', [this.debug]), 'replace', [
				rt.new_string('/\\s*+!\\s*+important$/i'),
				rt.new_string(''),
				var_value.clone(),
			]))
		} else {
			var_regularStyleDeclarations.array_set(var_property, var_value.clone())
		}
	}
	mut var_inlineStyleDeclarationsInNewOrder := rt.call_function('array_merge', [
		var_regularStyleDeclarations.clone(),
		var_importantStyleDeclarations.clone(),
	])
	rt.call_method(var_node_mutated, 'setAttribute', [rt.new_string('style'),
		rt.new_string(this.generatestylestringfromsingledeclarationsarray(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_inlineStyleDeclarationsInNewOrder)))])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) generatestylestringfromsingledeclarationsarray(mut var_styleDeclarations Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) string {
	return this.generatestylestringfromdeclarationsarrays(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](rt.new_array()), mut
		var_styleDeclarations)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) determinematchinguninlinablecssrules(mut var_cssRules Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) {
	mut var_cssRules_mutated := var_cssRules
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_cssRule := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	this.matchingUninlinableCssRules = rt.call_function('array_filter', [
		var_cssRules_mutated,
		rt.new_closure(closure_7_fn),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) existsmatchforselectorincssrule(mut var_cssRule Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) bool {
	mut var_selector := var_cssRule.array_get(rt.new_string('selector'))
	if rt.is_true(var_cssRule.array_get(rt.new_string('hasUnmatchablePseudo'))) {
		var_selector = rt.new_string(this.removeunmatchablepseudocomponents(var_selector.str()))
	}
	return this.existsmatchforcssselector(var_selector.str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) existsmatchforcssselector(cssSelector string) bool {
	mut var_nodesMatchingSelector := this.queryselectorall(cssSelector, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.qsa_always_throw_parse_exception()
			val: true
		},
	])))
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2,
		'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ParseException')
	{
		mut var_e := var_e_2.clone()
		if rt.is_true(this.debug) {
			rt.throw_exception(var_e)
		}
		return true
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_nodesMatchingSelector, 'length'),
		rt.new_int(0))))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeunmatchablepseudocomponents(selector string) string {
	mut selector_mutated := selector
	mut var_preg := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_matches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.replaceunmatchablenotcomponent(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_matches))
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_matches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.replaceunmatchablenotcomponent(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_matches))
	}
	mut var_selectorWithoutNots := rt.new_string(rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug]), 'replaceCallback', [
		rt.new_string('/([\\s>+~]?+):not(\\([^()]*+(?:(?2)[^()]*+)*+\\))/i'),
		rt.new_closure(closure_9_fn),
		rt.new_string(' ' + selector_mutated),
	]).to_string().trim_left(' \t\n\r'))
	mut var_selectorWithoutUnmatchablePseudoComponents := rt.new_string(this.removeselectorcomponents(
		':(?!' +
		(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.pseudo_class_matcher()).str() + '):?+[\\w\\-]++(?:\\([^\\)]*+\\))?+',
		var_selectorWithoutNots.str()))
	if rt.is_true(rt.identical(rt.call_method(var_preg, 'match', [
		rt.new_string('/:(?:' +
			(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.of_type_pseudo_class_matcher()).str() + ')/i'),
		var_selectorWithoutUnmatchablePseudoComponents.clone(),
	]), rt.new_int(0)))
	{
		return var_selectorWithoutUnmatchablePseudoComponents.str()
	}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_selectorPart := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.removeunsupportedoftypepseudoclasses(var_selectorPart)
	}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_selectorPart := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.removeunsupportedoftypepseudoclasses(var_selectorPart)
	}
	return (rt.call_function('implode', [rt.new_string(''),
		rt.call_function('array_map', [rt.new_closure(closure_10_fn),
			rt.call_method(var_preg, 'split', [
				rt.new_string('/(' +
					(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.combinator_matcher()).str() + ')/'),
				var_selectorWithoutUnmatchablePseudoComponents.clone(),
				rt.new_int(-1),
				rt.bitwise_or(rt.get_constant('PREG_SPLIT_DELIM_CAPTURE'),
					rt.get_constant('PREG_SPLIT_NO_EMPTY')),
			])])])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) replaceunmatchablenotcomponent(mut var_matches Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) string {
	mut var_notComponentWithAnyPrecedingCombinator := rt.new_null()
	mut var_anyPrecedingCombinator := rt.new_null()
	mut var_notArgumentInBrackets := rt.new_null()
	mut var_matches_mutated := var_matches
	mut list_tmp_1 := var_matches_mutated
	var_notComponentWithAnyPrecedingCombinator = list_tmp_1.array_get(0)
	var_anyPrecedingCombinator = list_tmp_1.array_get(1)
	var_notArgumentInBrackets = list_tmp_1.array_get(2)
	if this.hasunsupportedpseudoclass(var_notArgumentInBrackets.str()) {
		return if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_anyPrecedingCombinator,
			rt.new_string('')))))
		{
			var_anyPrecedingCombinator.str() + '*'
		} else {
			''
		}
	}
	return var_notComponentWithAnyPrecedingCombinator.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeselectorcomponents(matcher string, selector string) string {
	mut selector_mutated := selector
	return (rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug]), 'replace', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: '/([\\s>+~]|^)' + matcher + '/i' },
			rt.ArrayItem{ key: none, val: '/' + matcher + '/i' },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '$1*' },
			rt.ArrayItem{ key: none, val: '' },
		]),
		rt.new_string(selector_mutated).clone(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeunsupportedoftypepseudoclasses(selectorPart string) string {
	if !(this.selectorparthasunsupportedoftypepseudoclass(selectorPart)) {
		return selectorPart
	}
	return this.removeselectorcomponents(':(?:' +
		(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.of_type_pseudo_class_matcher()).str() + ')(?:\\([^\\)]*+\\))?+',
		selectorPart)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) copyuninlinablecsstostylenode(mut var_parsedCss Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) {
	mut var_parsedCss_mutated := var_parsedCss
	mut var_css := var_parsedCss_mutated.rendernonconditionalatrules()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.getmatchinguninlinablecssrules(),
		rt.new_array()))))
	{
		mut var_cssConcatenator :=
			create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_cssconcatenator()
		mut iter_16 := this.getmatchinguninlinablecssrules().iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_cssRule := item_16.val
			var_cssConcatenator.append(rt.create_array([
				rt.ArrayItem{ key: none, val: var_cssRule.array_get(rt.new_string('selector')) },
			]), var_cssRule.array_get(rt.new_string('declarationsBlock')),
				var_cssRule.array_get(rt.new_string('media')))
		}
		var_css = rt.concat(var_css, var_cssConcatenator.getcss())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_css, rt.new_string(''))))) {
		this.addstyleelementtodocument(var_css.str())
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) addstyleelementtodocument(css string) {
	mut css_mutated := css
	mut var_domDocument := this.getdomdocument()
	mut var_styleElement := rt.call_method(var_domDocument, 'createElement', [
		rt.new_string('style'),
		rt.new_string(css_mutated).clone(),
	])
	mut var_styleAttribute := rt.call_method(var_domDocument, 'createAttribute', [
		rt.new_string('type'),
	])
	rt.set_property(var_styleAttribute, 'value', rt.new_string('text/css'))
	rt.call_method(var_styleElement, 'appendChild', [var_styleAttribute.clone()])
	mut var_headElement := this.getheadelement()
	rt.call_method(var_headElement, 'appendChild', [var_styleElement.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getheadelement() rt.PhpVal {
	mut var_node := rt.call_method(rt.call_method(this.getdomdocument(), 'getElementsByTagName', [
		rt.new_string('head'),
	]), 'item', [rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_node,
		'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement'))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_unexpectedvalueexception(rt.new_string('There is no HEAD element. This should never happen.'),
			rt.new_int(1617923227))))
	}
	return var_node.clone()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_cssinliner(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner{
		PhpObjectBase:                         rt.PhpObjectBase{}
		excludedSelectors:                     rt.new_array()
		excludedCssSelectors:                  rt.new_array()
		allowedMediaTypes:                     rt.new_array()
		caches:                                rt.new_array()
		cssSelectorConverter:                  rt.new_null()
		visitedNodes:                          rt.new_array()
		styleAttributesForNodes:               rt.new_array()
		isInlineStyleAttributesParsingEnabled: false
		isStyleBlocksParsingEnabled:           false
		selectorPrecedenceMatchers:            rt.new_array()
		matchingUninlinableCssRules:           rt.new_null()
		debug:                                 rt.new_bool(false)
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_cssdocument(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_badmethodcallexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_runtimeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_domnodelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_unexpectedvalueexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_cssselectorconverter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_cssconcatenator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'inlineCss' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.inlinecss(dispatch_arg_0)
		}
		'disableInlineStyleAttributesParsing' {
			return this.disableinlinestyleattributesparsing()
		}
		'disableStyleBlocksParsing' {
			return this.disablestyleblocksparsing()
		}
		'addAllowedMediaType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.addallowedmediatype(dispatch_arg_0)
		}
		'removeAllowedMediaType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.removeallowedmediatype(dispatch_arg_0)
		}
		'addExcludedSelector' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.addexcludedselector(dispatch_arg_0)
		}
		'removeExcludedSelector' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.removeexcludedselector(dispatch_arg_0)
		}
		'addExcludedCssSelector' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.addexcludedcssselector(dispatch_arg_0)
		}
		'removeExcludedCssSelector' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.removeexcludedcssselector(dispatch_arg_0)
		}
		'setDebug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.setdebug(dispatch_arg_0)
		}
		'getMatchingUninlinableSelectors' {
			return this.getmatchinguninlinableselectors()
		}
		'getMatchingUninlinableCssRules' {
			return this.getmatchinguninlinablecssrules()
		}
		'clearAllCaches' {
			this.clearallcaches()
			return rt.new_null()
		}
		'purgeVisitedNodes' {
			this.purgevisitednodes()
			return rt.new_null()
		}
		'normalizeStyleAttributesOfAllNodes' {
			this.normalizestyleattributesofallnodes()
			return rt.new_null()
		}
		'getAllNodesWithStyleAttribute' {
			return this.getallnodeswithstyleattribute()
		}
		'normalizeStyleAttributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.normalizestyleattributes(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getCssFromAllStyleNodes' {
			return rt.new_string(this.getcssfromallstylenodes())
		}
		'getNodesToExclude' {
			return this.getnodestoexclude()
		}
		'querySelectorAll' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.queryselectorall(dispatch_arg_0, mut dispatch_arg_1)
		}
		'ensureNodeIsElement' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.ensurenodeiselement(mut dispatch_arg_0)
		}
		'getCssSelectorConverter' {
			return this.getcssselectorconverter()
		}
		'collateCssRules' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.collatecssrules(mut dispatch_arg_0)
		}
		'hasUnsupportedPseudoClass' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasunsupportedpseudoclass(dispatch_arg_0))
		}
		'selectorPartHasUnsupportedOfTypePseudoClass' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.selectorparthasunsupportedoftypepseudoclass(dispatch_arg_0))
		}
		'sortBySelectorPrecedence' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_int(this.sortbyselectorprecedence(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'getCssSelectorPrecedence' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.getcssselectorprecedence(dispatch_arg_0))
		}
		'copyInlinableCssToStyleAttribute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.copyinlinablecsstostyleattribute(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'generateStyleStringFromDeclarationsArrays' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generatestylestringfromdeclarationsarrays(mut dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'attributeValueIsImportant' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.attributevalueisimportant(dispatch_arg_0))
		}
		'fillStyleAttributesWithMergedStyles' {
			this.fillstyleattributeswithmergedstyles()
			return rt.new_null()
		}
		'removeImportantAnnotationFromAllInlineStyles' {
			this.removeimportantannotationfromallinlinestyles()
			return rt.new_null()
		}
		'removeImportantAnnotationFromNodeInlineStyle' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.removeimportantannotationfromnodeinlinestyle(mut dispatch_arg_0)
			return rt.new_null()
		}
		'generateStyleStringFromSingleDeclarationsArray' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generatestylestringfromsingledeclarationsarray(mut dispatch_arg_0))
		}
		'determineMatchingUninlinableCssRules' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.determinematchinguninlinablecssrules(mut dispatch_arg_0)
			return rt.new_null()
		}
		'existsMatchForSelectorInCssRule' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.existsmatchforselectorincssrule(mut dispatch_arg_0))
		}
		'existsMatchForCssSelector' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.existsmatchforcssselector(dispatch_arg_0))
		}
		'removeUnmatchablePseudoComponents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.removeunmatchablepseudocomponents(dispatch_arg_0))
		}
		'replaceUnmatchableNotComponent' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.replaceunmatchablenotcomponent(mut dispatch_arg_0))
		}
		'removeSelectorComponents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.removeselectorcomponents(dispatch_arg_0, dispatch_arg_1))
		}
		'removeUnsupportedOfTypePseudoClasses' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.removeunsupportedoftypepseudoclasses(dispatch_arg_0))
		}
		'copyUninlinableCssToStyleNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.copyuninlinablecsstostylenode(mut dispatch_arg_0)
			return rt.new_null()
		}
		'addStyleElementToDocument' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.addstyleelementtodocument(dispatch_arg_0)
			return rt.new_null()
		}
		'getHeadElement' {
			return this.getheadelement()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'excludedSelectors' { return this.excludedSelectors }
		'excludedCssSelectors' { return this.excludedCssSelectors }
		'allowedMediaTypes' { return this.allowedMediaTypes }
		'caches' { return this.caches }
		'cssSelectorConverter' { return this.cssSelectorConverter }
		'visitedNodes' { return this.visitedNodes }
		'styleAttributesForNodes' { return this.styleAttributesForNodes }
		'isInlineStyleAttributesParsingEnabled' { return rt.new_bool(this.isInlineStyleAttributesParsingEnabled) }
		'isStyleBlocksParsingEnabled' { return rt.new_bool(this.isStyleBlocksParsingEnabled) }
		'selectorPrecedenceMatchers' { return this.selectorPrecedenceMatchers }
		'matchingUninlinableCssRules' { return this.matchingUninlinableCssRules }
		'debug' { return this.debug }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'excludedSelectors' {
			this.excludedSelectors = val
			return true
		}
		'excludedCssSelectors' {
			this.excludedCssSelectors = val
			return true
		}
		'allowedMediaTypes' {
			this.allowedMediaTypes = val
			return true
		}
		'caches' {
			this.caches = val
			return true
		}
		'cssSelectorConverter' {
			this.cssSelectorConverter = val
			return true
		}
		'visitedNodes' {
			this.visitedNodes = val
			return true
		}
		'styleAttributesForNodes' {
			this.styleAttributesForNodes = val
			return true
		}
		'isInlineStyleAttributesParsingEnabled' {
			this.isInlineStyleAttributesParsingEnabled = val.to_bool()
			return true
		}
		'isStyleBlocksParsingEnabled' {
			this.isStyleBlocksParsingEnabled = val.to_bool()
			return true
		}
		'selectorPrecedenceMatchers' {
			this.selectorPrecedenceMatchers = val
			return true
		}
		'matchingUninlinableCssRules' {
			this.matchingUninlinableCssRules = val
			return true
		}
		'debug' {
			this.debug = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_CssConcatenator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
