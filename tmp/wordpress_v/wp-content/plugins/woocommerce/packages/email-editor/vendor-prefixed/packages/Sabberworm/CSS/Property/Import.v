import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import {
	rt.PhpObjectBase
pub mut:
	oLocation   rt.PhpVal = rt.new_null()
	sMediaQuery rt.PhpVal = rt.new_null()
	aComments   rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) construct(mut var_oLocation Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL, var_sMediaQuery rt.PhpVal, iLineNo i64) {
	this.oLocation = var_oLocation.dup()
	this.sMediaQuery = var_sMediaQuery.dup()
	this.setposition(rt.new_int(iLineNo))
	this.aComments = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) setlocation(var_oLocation rt.PhpVal) {
	this.oLocation = var_oLocation.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) getlocation() rt.PhpVal {
	return this.oLocation
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) render(var_oOutputFormat rt.PhpVal) string {
	return (rt.call_method(var_oOutputFormat, 'comments', [rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import', ['AtRule', 'Positionable'], &this)])).str() + '@import ' + (rt.call_method(this.oLocation, 'render', [var_oOutputFormat.dup()])).str() + if rt.is_true(rt.identical(this.sMediaQuery, rt.new_null())) {
		''
	} else {
		' ' + (this.sMediaQuery).str()
	} + ';'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) atrulename() string {
	return 'import'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) atruleargs() rt.PhpVal {
	mut var_aResult := rt.create_array([rt.ArrayItem{ key: none, val: this.oLocation }])
	if rt.is_true(this.sMediaQuery) {
		var_aResult.dup().array_push(this.sMediaQuery)
	}
	return var_aResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) addcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array) {
	this.aComments = rt.call_function('array_merge', [this.aComments, var_aComments])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) getcomments() rt.PhpVal {
	return this.aComments
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) setcomments(mut var_aComments Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_array) {
	this.aComments = var_aComments.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) getmediaquery() rt.PhpVal {
	return this.sMediaQuery
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_property_import(arg_0 rt.PhpVal, iLineNo i64, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import{
		PhpObjectBase: rt.PhpObjectBase{}
		oLocation:     rt.new_null()
		sMediaQuery:   rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_URL](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'setLocation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setlocation(dispatch_arg_0)
			return rt.new_null()
		}
		'getLocation' {
			return this.getlocation()
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
		'getMediaQuery' {
			return this.getmediaquery()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'oLocation' { return this.oLocation }
		'sMediaQuery' { return this.sMediaQuery }
		'aComments' { return this.aComments }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Property_Import) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'oLocation' {
			this.oLocation = val
			return true
		}
		'sMediaQuery' {
			this.sMediaQuery = val
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_property_import_php() {
}
