import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList {
	rt.PhpObjectBase
pub mut:
	aComponents rt.PhpVal = rt.new_null()
	sSeparator  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) construct(var_aComponents rt.PhpVal, sSeparator string, iLineNo i64) {
	mut var_aComponents_mutated := var_aComponents
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value.construct(rt.new_int(iLineNo))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_aComponents_mutated.dup().is_array()))))) {
		var_aComponents_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: var_aComponents_mutated },
		])
	}
	this.aComponents = var_aComponents_mutated.dup()
	this.sSeparator = rt.new_string(sSeparator).dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) addlistcomponent(var_mComponent rt.PhpVal) {
	this.aComponents.array_push(var_mComponent.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) getlistcomponents() rt.PhpVal {
	return this.aComponents
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) setlistcomponents(mut var_aComponents Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_array) {
	mut var_aComponents_mutated := var_aComponents
	this.aComponents = var_aComponents_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) getlistseparator() rt.PhpVal {
	return this.sSeparator
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) setlistseparator(var_sSeparator rt.PhpVal) {
	this.sSeparator = var_sSeparator.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) magic_tostring() rt.PhpVal {
	return this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) render(var_oOutputFormat rt.PhpVal) rt.PhpVal {
	return rt.call_method(var_oOutputFormat, 'implode', [
			(rt.call_method(var_oOutputFormat, 'spaceBeforeListArgumentSeparator', [this.sSeparator])).str() +
			(this.sSeparator).str() +(rt.call_method(var_oOutputFormat, 'spaceAfterListArgumentSeparator', [this.sSeparator])).str(),
		this.aComponents,
	])
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_valuelist(arg_0 rt.PhpVal, sSeparator string, iLineNo i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList{
		PhpObjectBase: rt.PhpObjectBase{}
		aComponents:   rt.new_null()
		sSeparator:    rt.new_null()
	}
	obj.construct(arg_0, sSeparator, iLineNo)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_value() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'addListComponent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.addlistcomponent(dispatch_arg_0)
			return rt.new_null()
		}
		'getListComponents' {
			return this.getlistcomponents()
		}
		'setListComponents' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setlistcomponents(mut dispatch_arg_0)
			return rt.new_null()
		}
		'getListSeparator' {
			return this.getlistseparator()
		}
		'setListSeparator' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setlistseparator(dispatch_arg_0)
			return rt.new_null()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'aComponents' { return this.aComponents }
		'sSeparator' { return this.sSeparator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'aComponents' {
			this.aComponents = val
			return true
		}
		'sSeparator' {
			this.sSeparator = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_value_valuelist_php() {
}
