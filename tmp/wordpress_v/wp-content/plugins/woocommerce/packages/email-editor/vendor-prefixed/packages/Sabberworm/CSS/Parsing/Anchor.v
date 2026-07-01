import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor {
	rt.PhpObjectBase
pub mut:
	iPosition    rt.PhpVal = rt.new_null()
	oParserState rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor) construct(var_iPosition rt.PhpVal, mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState) {
	this.iPosition = var_iPosition.dup()
	this.oParserState = var_oParserState.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor) backtrack() {
	rt.call_method(this.oParserState, 'setPosition', [this.iPosition])
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_parsing_anchor(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor{
		PhpObjectBase: rt.PhpObjectBase{}
		iPosition:     rt.new_null()
		oParserState:  rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'backtrack' {
			this.backtrack()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'iPosition' { return this.iPosition }
		'oParserState' { return this.oParserState }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_Anchor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'iPosition' {
			this.iPosition = val
			return true
		}
		'oParserState' {
			this.oParserState = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_parsing_anchor_php() {
}
