import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment {
	rt.PhpObjectBase
pub mut:
	sComment rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) construct(sComment string, iLineNo i64) {
	this.sComment = rt.new_string(sComment).dup()
	this.setposition(rt.new_int(iLineNo))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) getcomment() rt.PhpVal {
	return this.sComment
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) setcomment(var_sComment rt.PhpVal) {
	this.sComment = var_sComment.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) render(var_oOutputFormat rt.PhpVal) string {
	return '/*' + (this.sComment).str() + '*/'
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_comment_comment(sComment string, iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment{
		PhpObjectBase: rt.PhpObjectBase{}
		sComment:      rt.new_null()
	}
	obj.construct(sComment, iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'getComment' {
			return this.getcomment()
		}
		'setComment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setcomment(dispatch_arg_0)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sComment' { return this.sComment }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Comment_Comment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sComment' {
			this.sComment = val
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_comment_comment_php() {
}
