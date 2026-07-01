import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction {
	rt.PhpObjectBase
pub mut:
	sName rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) construct(var_sName rt.PhpVal, var_aArguments rt.PhpVal, sSeparator string, iLineNo i64) {
	mut var_aArguments_mutated := var_aArguments
	mut sSeparator_mutated := sSeparator
	if rt.is_true(rt.new_bool(rt.instance_of(var_aArguments_mutated,
		'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_RuleValueList')))
	{
		sSeparator_mutated = (rt.call_method(var_aArguments_mutated, 'getListSeparator',
			[]rt.PhpVal{})).str()
		var_aArguments_mutated = rt.call_method(var_aArguments_mutated, 'getListComponents',
			[]rt.PhpVal{})
	}
	this.sName = var_sName.dup()
	this.setposition(rt.new_int(iLineNo))
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList.construct(var_aArguments_mutated.dup(),
		rt.new_string(sSeparator_mutated), rt.new_int(iLineNo))
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction.parse(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, bIgnoreCase bool) rt.PhpVal {
	mut var_mResult := var_oParserState.parseidentifier(rt.new_bool(bIgnoreCase))
	var_oParserState.consume(rt.new_string('('))
	mut var_aArguments := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value{}
		return temp.parsevalue(arg_0, arg_1)
	}(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState',
		[]string{}, var_oParserState), rt.create_array([
		rt.ArrayItem{ key: none, val: '=' },
		rt.ArrayItem{ key: none, val: ' ' },
		rt.ArrayItem{ key: none, val: ',' },
	]))
	var_mResult = create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssfunction(var_mResult,
		var_aArguments, rt.new_string(','), var_oParserState.currentline())
	var_oParserState.consume(rt.new_string(')'))
	return var_mResult.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) getname() rt.PhpVal {
	return this.sName
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) setname(var_sName rt.PhpVal) {
	this.sName = var_sName.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) getarguments() rt.PhpVal {
	return rt.get_property(rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction', [
		'Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList',
	], &this), 'aComponents')
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) render(var_oOutputFormat rt.PhpVal) string {
	mut var_aArguments :=
		this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList.render(var_oOutputFormat.dup())
	return rt.concat(rt.concat(rt.concat(this.sName, rt.new_string('(')), var_aArguments),
		rt.new_string(')'))
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Value {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_cssfunction(sSeparator string, iLineNo i64, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction{
		PhpObjectBase: rt.PhpObjectBase{}
		sName:         rt.new_null()
	}
	obj.construct(sSeparator, iLineNo, arg_2, arg_3)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_valuelist() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction.parse(mut dispatch_arg_0,
				dispatch_arg_1)
		}
		'getName' {
			return this.getname()
		}
		'setName' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setname(dispatch_arg_0)
			return rt.new_null()
		}
		'getArguments' {
			return this.getarguments()
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

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sName' { return this.sName }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_CSSFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sName' {
			this.sName = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_ValueList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_value_cssfunction_php() {
}
