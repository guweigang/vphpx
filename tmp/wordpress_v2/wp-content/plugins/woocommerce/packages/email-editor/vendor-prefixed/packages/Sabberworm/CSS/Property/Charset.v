import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset {
	rt.PhpObjectBase
pub mut:
	oCharset  rt.PhpVal = rt.new_null()
	iLineNo   rt.PhpVal = rt.new_null()
	aComments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) construct(mut var_oCharset Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString, iLineNo i64) {
	this.oCharset = var_oCharset
	this.setposition(rt.new_int(iLineNo))
	this.aComments = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) setcharset(var_sCharset rt.PhpVal) {
	mut var_sCharset_mutated := var_sCharset
	var_sCharset_mutated = if rt.is_true(rt.new_bool(rt.instance_of(var_sCharset_mutated,
		'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString')))
	{
		var_sCharset_mutated
	} else {
		create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssstring(var_sCharset_mutated.clone())
	}
	this.oCharset = var_sCharset_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) getcharset() rt.PhpVal {
	return rt.call_method(this.oCharset, 'getString', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) render(var_oOutputFormat rt.PhpVal) string {
	return rt.concat(rt.concat(rt.concat(rt.call_method(var_oOutputFormat, 'comments', [
		rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset', [
			'AtRule',
			'Positionable',
		], &this),
	]), rt.new_string('@charset ')), rt.call_method(this.oCharset, 'render', [
		var_oOutputFormat.clone()])), rt.new_string(';'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) atrulename() string {
	return 'charset'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) atruleargs() rt.PhpVal {
	return this.oCharset
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) addcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array) {
	this.aComments = rt.call_function('array_merge', [this.aComments, var_aComments])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) getcomments() rt.PhpVal {
	return this.aComments
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) setcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array) {
	this.aComments = var_aComments
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_charset(arg_0 rt.PhpVal, iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset{
		PhpObjectBase: rt.PhpObjectBase{}
		oCharset:      rt.new_null()
		iLineNo:       rt.new_null()
		aComments:     rt.new_null()
	}
	obj.construct(arg_0, iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssstring(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'setCharset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setcharset(dispatch_arg_0)
			return rt.new_null()
		}
		'getCharset' {
			return this.getcharset()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		'atRuleName' {
			return rt.new_string(this.atrulename())
		}
		'atRuleArgs' {
			return this.atruleargs()
		}
		'addComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.addcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getComments' {
			return this.getcomments()
		}
		'setComments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setcomments(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'oCharset' { return this.oCharset }
		'iLineNo' { return this.iLineNo }
		'aComments' { return this.aComments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Charset) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'oCharset' {
			this.oCharset = val
			return true
		}
		'iLineNo' {
			this.iLineNo = val
			return true
		}
		'aComments' {
			this.aComments = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
