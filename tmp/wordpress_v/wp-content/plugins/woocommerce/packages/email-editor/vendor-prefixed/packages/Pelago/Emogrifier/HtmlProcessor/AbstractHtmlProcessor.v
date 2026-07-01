import rt

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.default_document_type() string {
	return '<!DOCTYPE html>'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.content_type_meta_tag() string {
	return '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.php_unrecognized_void_tagname_matcher() string {
	return '(?:command|embed|keygen|source|track|wbr)'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.tagname_allowed_before_body_matcher() string {
	return '(?:html|head|base|command|link|meta|noscript|script|style|template|title)'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.html_comment_pattern() string {
	return '/<!--[^-]*+(?:-(?!->)[^-]*+)*+(?:-->|$)/'
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.html_template_element_pattern() string {
	return '%<template[\\s>][^<]*+(?:<(?!/template>)[^<]*+)*+(?:</template>|$)%i'
}
struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	rt.PhpObjectBase
pub mut:
		domDocument rt.PhpVal = rt.new_null()
		xPath rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) construct()  {
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.fromhtml(unprocessedHtml string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(unprocessedHtml), rt.new_string(''))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_InvalidArgumentException', []string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_invalidargumentexception(rt.new_string('The provided HTML must not be empty.'), rt.new_int(1515763647))))
	}
	mut var_instance := create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_static()
	var_instance.sethtml(rt.new_string(unprocessedHtml))
	return mut var_instance
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.fromdomdocument(mut var_document Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument) rt.PhpVal {
	mut var_instance := create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_static()
	var_instance.setdomdocument(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument', []string{}, var_document))
	return mut var_instance
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) sethtml(html string)  {
	this.createunifieddomdocument(html)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) getdomdocument() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.domDocument, 'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument')))))) {
		mut var_message := rt.new_string((Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.class()).str() + '::setDomDocument() has not yet been called on ' + (Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static.class()).str())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException', []string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_unexpectedvalueexception(var_message.dup(), rt.new_int(1570472239))))
	}
	return this.domDocument
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) setdomdocument(mut var_domDocument Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument)  {
	mut var_domDocument_mutated := var_domDocument
	this.domDocument = var_domDocument_mutated.dup()
	this.xPath = create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_domxpath(this.domDocument)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) getxpath() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.xPath, 'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMXPath')))))) {
		mut var_message := rt.new_string((Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.class()).str() + '::setDomDocument() has not yet been called on ' + (Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static.class()).str())
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException', []string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_unexpectedvalueexception(var_message.dup(), rt.new_int(1617819086))))
	}
	return this.xPath
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) render() string {
	mut var_htmlWithPossibleErroneousClosingTags := rt.call_method(this.getdomdocument(), 'saveHTML', []rt.PhpVal{})
	return this.removeselfclosingtagsclosingtags((var_htmlWithPossibleErroneousClosingTags).str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) renderbodycontent() string {
	mut var_htmlWithPossibleErroneousClosingTags := rt.call_method(this.getdomdocument(), 'saveHTML', [this.getbodyelement()])
	mut var_bodyNodeHtml := rt.new_string(this.removeselfclosingtagsclosingtags((var_htmlWithPossibleErroneousClosingTags).str()))
	return (rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'replace', [rt.new_string('%</?+body(?:\\s[^>]*+)?+>%'), rt.new_string(''), var_bodyNodeHtml.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) removeselfclosingtagsclosingtags(html string) string {
	return (rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'replace', ['%</' + (Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.php_unrecognized_void_tagname_matcher()).str() + '>%', rt.new_string(''), rt.new_string(html)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) gethtmlelement() rt.PhpVal {
	mut var_htmlElement := rt.call_method(rt.call_method(this.getdomdocument(), 'getElementsByTagName', [rt.new_string('html')]), 'item', [rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_htmlElement, 'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException', []string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_unexpectedvalueexception(rt.new_string('There is no HTML element although there should be one.'), rt.new_int(1569930853))))
	}
	return var_htmlElement.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) getbodyelement() rt.PhpVal {
	mut var_node := rt.call_method(rt.call_method(this.getdomdocument(), 'getElementsByTagName', [rt.new_string('body')]), 'item', [rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_node, 'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException', []string{}, create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_runtimeexception(rt.new_string('There is no body element.'), rt.new_int(1617922607))))
	}
	return var_node.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) createunifieddomdocument(html string)  {
	this.createrawdomdocument(html)
	this.ensureexistenceofbodyelement()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) createrawdomdocument(html string)  {
	mut var_domDocument := create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_domdocument()
	rt.set_property(var_domDocument, 'strictErrorChecking', rt.new_bool(false))
	rt.set_property(var_domDocument, 'formatOutput', rt.new_bool(false))
	mut var_libXmlState := rt.call_function('libxml_use_internal_errors', [rt.new_bool(true)])
	var_domDocument.loadhtml(rt.new_string(this.preparehtmlfordomconversion(html)))
	rt.call_function('libxml_clear_errors', []rt.PhpVal{})
	rt.call_function('libxml_use_internal_errors', [var_libXmlState.dup()])
	this.setdomdocument(mut var_domDocument)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) preparehtmlfordomconversion(html string) string {
	mut var_htmlWithSelfClosingSlashes := rt.new_string(this.ensurephpunrecognizedselfclosingtagsarexml(html))
	mut var_htmlWithDocumentType := rt.new_string(this.ensuredocumenttype((var_htmlWithSelfClosingSlashes).str()))
	return this.addcontenttypemetatag((var_htmlWithDocumentType).str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) ensuredocumenttype(html string) string {
	mut var_hasDocumentType := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(var_hasDocumentType) {
		return this.normalizedocumenttype(html)
	}
	return (Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.default_document_type()).str() + html
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) normalizedocumenttype(html string) string {
	return (rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'replace', [rt.new_string('/<!DOCTYPE\\s++html(?=[\\s>])/i'), rt.new_string('<!DOCTYPE html'), rt.new_string(html), rt.new_int(1)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) addcontenttypemetatag(html string) string {
	if this.hascontenttypemetataginhead(html) {
		return html
	}
	mut var_hasHeadTag := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_hasHtmlTag := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(var_hasHeadTag) {
		mut var_reworkedHtml := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'replace', [rt.new_string('/<head(?=[\\s>])([^>]*+)>/i'), '<head$1>' + (Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.content_type_meta_tag()).str(), rt.new_string(html)])
	} else if rt.is_true(var_hasHtmlTag) {
		var_reworkedHtml = rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'replace', [rt.new_string('/<html(.*?)>/is'), '<html$1><head>' + (Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.content_type_meta_tag()).str() + '</head>', rt.new_string(html)])
	} else {
		var_reworkedHtml = rt.new_string((Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.content_type_meta_tag()).str() + html)
	}
	return (var_reworkedHtml).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) hascontenttypemetataginhead(html string) bool {
	mut var_matches := rt.new_null()
	rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'match', [rt.new_string('%^.*?(?=<meta(?=\\s)[^>]*\\shttp-equiv=(["\']?+)Content-Type\\g{-1}[\\s/>])%is'), rt.new_string(html), var_matches.dup()])
	if var_matches.array_isset(rt.new_int(0)) {
		mut var_htmlBefore := var_matches.array_get(0)
		mut var_hasContentTypeMetaTagInHead := rt.new_bool(rt.new_bool(!(this.hasendofheadelement((var_htmlBefore).str()))))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException') {
			mut var_exception := var_e_1.dup()
			rt.call_function('trigger_error', [rt.call_method(var_exception, 'getMessage', []rt.PhpVal{})])
			var_hasContentTypeMetaTagInHead = rt.new_bool(rt.new_bool(true))
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	} else {
		var_hasContentTypeMetaTagInHead = rt.new_bool(rt.new_bool(false))
	}
	return (var_hasContentTypeMetaTagInHead).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) hasendofheadelement(html string) bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_htmlWithoutCommentsOrTemplates := rt.new_string(this.removehtmltemplateelements(this.removehtmlcomments(html)))
		mut var_hasEndOfHeadElement := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(var_htmlWithoutCommentsOrTemplates, rt.new_string(html))) || this.hasendofheadelement((var_htmlWithoutCommentsOrTemplates).str())))
	} else {
		var_hasEndOfHeadElement = rt.new_bool(rt.new_bool(false))
	}
	return (var_hasEndOfHeadElement).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) removehtmlcomments(html string) string {
	return (rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'throwExceptions', [rt.new_bool(true)]), 'replace', [Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.html_comment_pattern(), rt.new_string(''), rt.new_string(html)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) removehtmltemplateelements(html string) string {
	return (rt.call_method(rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'throwExceptions', [rt.new_bool(true)]), 'replace', [Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.html_template_element_pattern(), rt.new_string(''), rt.new_string(html)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) ensurephpunrecognizedselfclosingtagsarexml(html string) string {
	return (rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(), 'replace', ['%<' + (Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.php_unrecognized_void_tagname_matcher()).str() + '\\b[^>]*+(?<!/)(?=>)%', rt.new_string('$0/'), rt.new_string(html)])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) ensureexistenceofbodyelement()  {
	if rt.is_true(rt.new_bool(rt.instance_of(rt.call_method(rt.call_method(this.getdomdocument(), 'getElementsByTagName', [rt.new_string('body')]), 'item', [rt.new_int(0)]), 'Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement'))) {
		return rt.new_null()
	}
	rt.call_method(this.gethtmlelement(), 'appendChild', [rt.call_method(this.getdomdocument(), 'createElement', [rt.new_string('body')])])
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMXPath {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		domDocument: rt.new_null()
		xPath: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_invalidargumentexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_static() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_unexpectedvalueexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_domxpath() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMXPath {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMXPath{
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

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_runtimeexception() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_domdocument() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'fromHtml' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.fromhtml(dispatch_arg_0)
		}
		'fromDomDocument' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor.fromdomdocument(mut dispatch_arg_0)
		}
		'setHtml' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.sethtml(dispatch_arg_0)
			return rt.new_null()
		}
		'getDomDocument' {
			return this.getdomdocument()
		}
		'setDomDocument' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setdomdocument(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getXPath' {
			return this.getxpath()
		}
		'render' {
			return rt.new_string(this.render())
		}
		'renderBodyContent' {
			return rt.new_string(this.renderbodycontent())
		}
		'removeSelfClosingTagsClosingTags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.removeselfclosingtagsclosingtags(dispatch_arg_0))
		}
		'getHtmlElement' {
			return this.gethtmlelement()
		}
		'getBodyElement' {
			return this.getbodyelement()
		}
		'createUnifiedDomDocument' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.createunifieddomdocument(dispatch_arg_0)
			return rt.new_null()
		}
		'createRawDomDocument' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.createrawdomdocument(dispatch_arg_0)
			return rt.new_null()
		}
		'prepareHtmlForDomConversion' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.preparehtmlfordomconversion(dispatch_arg_0))
		}
		'ensureDocumentType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.ensuredocumenttype(dispatch_arg_0))
		}
		'normalizeDocumentType' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalizedocumenttype(dispatch_arg_0))
		}
		'addContentTypeMetaTag' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.addcontenttypemetatag(dispatch_arg_0))
		}
		'hasContentTypeMetaTagInHead' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hascontenttypemetataginhead(dispatch_arg_0))
		}
		'hasEndOfHeadElement' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.hasendofheadelement(dispatch_arg_0))
		}
		'removeHtmlComments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.removehtmlcomments(dispatch_arg_0))
		}
		'removeHtmlTemplateElements' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.removehtmltemplateelements(dispatch_arg_0))
		}
		'ensurePhpUnrecognizedSelfClosingTagsAreXml' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.ensurephpunrecognizedselfclosingtagsarexml(dispatch_arg_0))
		}
		'ensureExistenceOfBodyElement' {
			this.ensureexistenceofbodyelement()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'domDocument' { return this.domDocument }
		'xPath' { return this.xPath }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'domDocument' { this.domDocument = val; return true }
		'xPath' { this.xPath = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMXPath) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMXPath) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMXPath) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor_php() {
	// unsupported statement: Stmt_Declare
}
