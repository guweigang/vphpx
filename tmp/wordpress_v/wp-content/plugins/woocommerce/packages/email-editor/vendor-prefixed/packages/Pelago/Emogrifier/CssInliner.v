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
	mut var_combinedCss := rt.new_string(rt.new_string(css_mutated)).dup()
	if rt.is_true(this.isStyleBlocksParsingEnabled) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_parsedCss := create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_cssdocument(var_combinedCss.dup(),
		this.debug)
	mut var_excludedNodes := this.getnodestoexclude()
	mut var_cssRules := this.collatecssrules(mut var_parsedCss)
	{
		mut iter_1 := var_cssRules.array_get('inlinable').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cssRule := item_1.val
			{
				mut iter_2 := this.queryselectorall((var_cssRule.array_get('selector')).str(),
					rt.new_null()).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_node := item_2.val
					if rt.is_true(rt.call_function('in_array', [
						var_node.dup(), var_excludedNodes.dup(),
						rt.new_bool(true)]))
					{
						continue
					}
					this.copyinlinablecsstostyleattribute(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](this.ensurenodeiselement(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode](var_node))), mut
						rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_cssRule))
				}
			}
		}
	}
	if rt.is_true(this.isInlineStyleAttributesParsingEnabled) {
		this.fillstyleattributeswithmergedstyles()
	}
	this.removeimportantannotationfromallinlinestyles()
	this.determinematchinguninlinablecssrules(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array](var_cssRules.array_get('uninlinable')))
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
	this.debug = rt.new_bool(debug).dup()
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getmatchinguninlinableselectors() rt.PhpVal {
	return rt.call_function('array_column', [this.getmatchinguninlinablecssrules(),
		rt.new_string('selector')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getmatchinguninlinablecssrules() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.matchingUninlinableCssRules.is_array()))))) {
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
	fn () rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser{}
		return temp.clearcache()
	}()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) purgevisitednodes() {
	this.visitedNodes = rt.new_array()
	this.styleAttributesForNodes = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) normalizestyleattributesofallnodes() {
	{
		mut iter_1 := this.getallnodeswithstyleattribute().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			if rt.is_true(this.isInlineStyleAttributesParsingEnabled) {
				this.normalizestyleattributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement](var_node))
			}
			rt.call_method(var_node, 'removeAttribute', [rt.new_string('style')])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getallnodeswithstyleattribute() rt.PhpVal {
	mut var_query := rt.new_string(rt.new_string('//*[@style]'))
	mut var_matches := rt.call_method(this.getxpath(), 'query', [
		var_query.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_matches,
		'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList'))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException',
			[]string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_runtimeexception(
			'XPatch query failed: ' + var_query.str(), rt.new_int(1618577797))))
	}
	return var_matches.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) normalizestyleattributes(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement) {
	mut var_node_mutated := var_node
	mut var_declarationBlockParser :=
		create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser()
	closure_1_fn := fn [var_declarationBlockParser] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_propertyNameMatches := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return var_declarationBlockParser.normalizepropertyname(var_propertyNameMatches.array_get(0))
	}
	mut var_normalizedOriginalStyle := rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'throwExceptions', [this.debug]), 'replaceCallback', [
		rt.new_string('/-{0,2}+[_a-zA-Z][\\w\\-]*+(?=:)/S'),
		rt.new_closure(closure_1_fn),
		rt.call_method(var_node_mutated, 'getAttribute', [rt.new_string('style')]),
	])
	mut var_nodePath := rt.call_method(var_node_mutated, 'getNodePath', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_nodePath.dup().is_string()))
		&& !(this.styleAttributesForNodes.array_isset(var_nodePath))))
	{
		this.styleAttributesForNodes.array_set(var_nodePath,
			var_declarationBlockParser.parse(var_normalizedOriginalStyle.dup()))
		this.visitedNodes.array_set(var_nodePath, var_node_mutated.dup())
	}
	rt.call_method(var_node_mutated, 'setAttribute', [rt.new_string('style'),
		var_normalizedOriginalStyle.dup()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getcssfromallstylenodes() string {
	mut var_styleNodes := rt.call_method(this.getxpath(), 'query', [
		rt.new_string('//style'),
	])
	if rt.is_true(rt.identical(var_styleNodes, rt.new_bool(false))) {
		return ''
	}
	mut var_css := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_styleNodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_styleNode := item_1.val
			if rt.is_true(rt.new_bool(rt.get_property(var_styleNode, 'nodeValue').is_string())) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			mut var_parentNode := rt.get_property(var_styleNode, 'parentNode')
			if rt.is_true(rt.new_bool(rt.instance_of(var_parentNode,
				'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode')))
			{
				rt.call_method(var_parentNode, 'removeChild', [
					var_styleNode.dup()])
			}
		}
	}
	return var_css.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getnodestoexclude() rt.PhpVal {
	mut var_excludedNodes := rt.new_array()
	{
		mut iter_1 := rt.func_array_keys(this.excludedSelectors).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_selectorToExclude := item_1.val
			{
				mut iter_2 :=
					this.queryselectorall(var_selectorToExclude.str(), rt.new_null()).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_node := item_2.val
					var_excludedNodes.array_push(this.ensurenodeiselement(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNode](var_node)))
				}
			}
		}
	}
	return var_excludedNodes.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) queryselectorall(selectors string, mut var_options Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) rt.PhpVal {
	mut selectors_mutated := selectors
	mut var_result := rt.call_method(this.getxpath(), 'query', [
		rt.call_method(this.getcssselectorconverter(), 'toXPath', [
			rt.new_string(selectors_mutated).dup()]),
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
	return var_result.dup()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Exception_ParseException')
	{
		mut var_exception := var_e_1.dup()
		mut var_alwaysThrowParseException := if !(var_options.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.qsa_always_throw_parse_exception())).is_null() {
			var_options.array_get(Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner.qsa_always_throw_parse_exception())
		} else {
			rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(rt.is_true(this.debug)
			|| rt.is_true(var_alwaysThrowParseException)))
		{
			rt.throw_exception(var_exception)
		}
		return create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_domnodelist()
		unsafe {
			goto end_label_1
		}
	} else if rt.instance_of(var_e_1,
		'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException')
	{
		mut var_exception := var_e_1.dup()
		if rt.is_true(this.debug) {
			rt.throw_exception(var_exception)
		}
		rt.call_function('trigger_error', [
			rt.call_method(var_exception, 'getMessage', []rt.PhpVal{}),
		])
		return create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_domnodelist()
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
	{
		mut iter_1 := var_matches.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_cssRule := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true()))) {
				continue
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) hasunsupportedpseudoclass(selector string) bool {
	mut selector_mutated := selector
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) selectorparthasunsupportedoftypepseudoclass(selectorPart string) bool {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) sortbyselectorprecedence(mut var_first Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array, mut var_second Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) i64 {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getcssselectorprecedence(selector string) i64 {
	mut selector_mutated := selector
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) copyinlinablecsstostyleattribute(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement, mut var_cssRule Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) {
	mut var_node_mutated := var_node
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) generatestylestringfromdeclarationsarrays(mut var_oldStyles Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array, mut var_newStyles Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) string {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) attributevalueisimportant(attributeValue string) bool {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) fillstyleattributeswithmergedstyles() {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeimportantannotationfromallinlinestyles() {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeimportantannotationfromnodeinlinestyle(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMElement) {
	mut var_node_mutated := var_node
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) generatestylestringfromsingledeclarationsarray(mut var_styleDeclarations Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) string {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) determinematchinguninlinablecssrules(mut var_cssRules Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) {
	mut var_cssRules_mutated := var_cssRules
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) existsmatchforselectorincssrule(mut var_cssRule Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) bool {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) existsmatchforcssselector(cssSelector string) bool {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeunmatchablepseudocomponents(selector string) string {
	mut selector_mutated := selector
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) replaceunmatchablenotcomponent(mut var_matches Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_array) string {
	mut var_notComponentWithAnyPrecedingCombinator := rt.new_null()
	mut var_anyPrecedingCombinator := rt.new_null()
	mut var_notArgumentInBrackets := rt.new_null()
	mut var_matches_mutated := var_matches
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeselectorcomponents(matcher string, selector string) string {
	mut selector_mutated := selector
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) removeunsupportedoftypepseudoclasses(selectorPart string) string {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) copyuninlinablecsstostylenode(mut var_parsedCss Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument) {
	mut var_parsedCss_mutated := var_parsedCss
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) addstyleelementtodocument(css string) {
	mut css_mutated := css
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner) getheadelement() rt.PhpVal {
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

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_cssinliner() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_CssInliner {
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

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_css_cssdocument() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Css_CssDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_badmethodcallexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_BadMethodCallException{
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

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_runtimeexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_RuntimeException{
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

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_domnodelist() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_DOMNodeList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_unexpectedvalueexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_cssselectorconverter() &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_CssSelectorConverter{
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_pelago_emogrifier_cssinliner_php() {
	// unsupported statement: Stmt_Declare
}
