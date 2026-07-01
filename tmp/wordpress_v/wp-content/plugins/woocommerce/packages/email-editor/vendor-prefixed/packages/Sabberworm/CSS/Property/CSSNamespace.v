import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace {
	rt.PhpObjectBase
pub mut:
	mUrl      rt.PhpVal = rt.new_null()
	sPrefix   rt.PhpVal = rt.new_null()
	iLineNo   rt.PhpVal = rt.new_null()
	aComments rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) construct(var_mUrl rt.PhpVal, var_sPrefix rt.PhpVal, iLineNo i64) {
	this.mUrl = var_mUrl.dup()
	this.sPrefix = var_sPrefix.dup()
	this.setposition(rt.new_int(iLineNo))
	this.aComments = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) render(var_oOutputFormat rt.PhpVal) string {
	return '@namespace ' + if rt.is_true(rt.identical(this.sPrefix, rt.new_null())) {
		''
	} else {
		(this.sPrefix).str() + ' '
	} + (rt.call_method(this.mUrl, 'render', [var_oOutputFormat.dup()])).str() + ';'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) geturl() rt.PhpVal {
	return this.mUrl
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) getprefix() rt.PhpVal {
	return this.sPrefix
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) seturl(var_mUrl rt.PhpVal) {
	this.mUrl = var_mUrl.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) setprefix(var_sPrefix rt.PhpVal) {
	this.sPrefix = var_sPrefix.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) atrulename() string {
	return 'namespace'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) atruleargs() rt.PhpVal {
	mut var_aResult := rt.create_array([rt.ArrayItem{ key: none, val: this.mUrl }])
	if rt.is_true(this.sPrefix) {
		rt.call_function('array_unshift', [var_aResult.dup(), this.sPrefix])
	}
	return var_aResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) addcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array) {
	this.aComments = rt.call_function('array_merge', [this.aComments, var_aComments])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) getcomments() rt.PhpVal {
	return this.aComments
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) setcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array) {
	this.aComments = var_aComments.dup()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_cssnamespace(arg_0 rt.PhpVal, iLineNo i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace{
		PhpObjectBase: rt.PhpObjectBase{}
		mUrl:          rt.new_null()
		sPrefix:       rt.new_null()
		iLineNo:       rt.new_null()
		aComments:     rt.new_null()
	}
	obj.construct(arg_0, iLineNo, arg_2)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		'getUrl' {
			return this.geturl()
		}
		'getPrefix' {
			return this.getprefix()
		}
		'setUrl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.seturl(dispatch_arg_0)
			return rt.new_null()
		}
		'setPrefix' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setprefix(dispatch_arg_0)
			return rt.new_null()
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

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'mUrl' { return this.mUrl }
		'sPrefix' { return this.sPrefix }
		'iLineNo' { return this.iLineNo }
		'aComments' { return this.aComments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_CSSNamespace) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'mUrl' {
			this.mUrl = val
			return true
		}
		'sPrefix' {
			this.sPrefix = val
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_property_cssnamespace_php() {
}
