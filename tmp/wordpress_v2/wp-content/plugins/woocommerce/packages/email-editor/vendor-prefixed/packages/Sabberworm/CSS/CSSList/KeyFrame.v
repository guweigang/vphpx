import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame {
	rt.PhpObjectBase
pub mut:
	vendorKeyFrame rt.PhpVal = rt.new_null()
	animationName  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) construct(iLineNo i64) {
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList.construct(rt.new_int(iLineNo))
	this.vendorKeyFrame = rt.new_null()
	this.animationName = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) setvendorkeyframe(var_vendorKeyFrame rt.PhpVal) {
	this.vendorKeyFrame = var_vendorKeyFrame.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) getvendorkeyframe() rt.PhpVal {
	return this.vendorKeyFrame
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) setanimationname(var_animationName rt.PhpVal) {
	this.animationName = var_animationName.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) getanimationname() rt.PhpVal {
	return this.animationName
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) magic_tostring() rt.PhpVal {
	return this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) render(var_oOutputFormat rt.PhpVal) rt.PhpVal {
	mut var_sResult := rt.call_method(var_oOutputFormat, 'comments', [
		rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame', [
			'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList',
			'AtRule',
		], &this),
	])
	var_sResult = rt.concat(var_sResult, rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('@'),
		this.vendorKeyFrame), rt.new_string(' ')), this.animationName), rt.call_method(var_oOutputFormat,
		'spaceBeforeOpeningBrace', []rt.PhpVal{})), rt.new_string('{')))
	var_sResult = rt.concat(var_sResult, this.renderlistcontents(var_oOutputFormat.clone()))
	var_sResult = rt.concat(var_sResult, rt.new_string('}'))
	return var_sResult.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) isrootlist() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) atrulename() rt.PhpVal {
	return this.vendorKeyFrame
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) atruleargs() rt.PhpVal {
	return this.animationName
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_keyframe(iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame{
		PhpObjectBase:  rt.PhpObjectBase{}
		vendorKeyFrame: rt.new_null()
		animationName:  rt.new_null()
	}
	obj.construct(iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_csslist_csslist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_CSSList{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'setVendorKeyFrame' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setvendorkeyframe(dispatch_arg_0)
			return rt.new_null()
		}
		'getVendorKeyFrame' {
			return this.getvendorkeyframe()
		}
		'setAnimationName' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setanimationname(dispatch_arg_0)
			return rt.new_null()
		}
		'getAnimationName' {
			return this.getanimationname()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		'isRootList' {
			return rt.new_bool(this.isrootlist())
		}
		'atRuleName' {
			return this.atrulename()
		}
		'atRuleArgs' {
			return this.atruleargs()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'vendorKeyFrame' { return this.vendorKeyFrame }
		'animationName' { return this.animationName }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_CSSList_KeyFrame) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'vendorKeyFrame' {
			this.vendorKeyFrame = val
			return true
		}
		'animationName' {
			this.animationName = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
