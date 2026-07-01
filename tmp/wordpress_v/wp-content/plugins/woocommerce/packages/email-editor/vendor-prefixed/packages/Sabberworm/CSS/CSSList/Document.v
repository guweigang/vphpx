import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) construct(iLineNo i64) {
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList.construct(rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document.parse(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) rt.PhpVal {
	mut var_oDocument :=
		create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_document(var_oParserState.currentline())
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList{}
		return temp.parselist(arg_0, arg_1)
	}(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
		[]string{}, var_oParserState), rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document',
		[]string{}, var_oDocument))
	return mut var_oDocument
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) getalldeclarationblocks() rt.PhpVal {
	mut var_aResult := rt.new_array()
	this.alldeclarationblocks(var_aResult.dup())
	return var_aResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) getallselectors() rt.PhpVal {
	return this.getalldeclarationblocks()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) getallrulesets() rt.PhpVal {
	mut var_aResult := rt.new_array()
	this.allrulesets(var_aResult.dup())
	return var_aResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) getselectorsbyspecificity(var_sSpecificitySearch rt.PhpVal) rt.PhpVal {
	mut var_aResult := rt.new_array()
	this.allselectors(var_aResult.dup(), var_sSpecificitySearch.dup())
	return var_aResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) expandshorthands() {
	{
		mut iter_1 := this.getalldeclarationblocks().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_oDeclaration := item_1.val
			rt.call_method(var_oDeclaration, 'expandShorthands', []rt.PhpVal{})
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) createshorthands() {
	{
		mut iter_1 := this.getalldeclarationblocks().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_oDeclaration := item_1.val
			rt.call_method(var_oDeclaration, 'createShorthands', []rt.PhpVal{})
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) render(var_oOutputFormat rt.PhpVal) string {
	mut var_oOutputFormat_mutated := var_oOutputFormat
	if rt.is_true(rt.identical(var_oOutputFormat_mutated, rt.new_null())) {
		var_oOutputFormat_mutated =
			create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()
	}
	return
		(var_oOutputFormat_mutated.comments(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document', []string{}, this))).str() +
		(this.renderlistcontents(var_oOutputFormat_mutated)).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) isrootlist() bool {
	return true
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_document(iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_cssblocklist() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_csslist() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document.parse(mut dispatch_arg_0)
		}
		'getAllDeclarationBlocks' {
			return this.getalldeclarationblocks()
		}
		'getAllSelectors' {
			return this.getallselectors()
		}
		'getAllRuleSets' {
			return this.getallrulesets()
		}
		'getSelectorsBySpecificity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getselectorsbyspecificity(dispatch_arg_0)
		}
		'expandShorthands' {
			this.expandshorthands()
			return rt.new_null()
		}
		'createShorthands' {
			this.createshorthands()
			return rt.new_null()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		'isRootList' {
			return rt.new_bool(this.isrootlist())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_Document) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSBlockList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_csslist_document_php() {
}
