import rt

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.absolute_size_units() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'px' }, rt.ArrayItem{ key: none, val: 'pt' }, rt.ArrayItem{ key: none, val: 'pc' }, rt.ArrayItem{ key: none, val: 'cm' }, rt.ArrayItem{ key: none, val: 'mm' }, rt.ArrayItem{ key: none, val: 'mozmm' }, rt.ArrayItem{ key: none, val: 'in' }, rt.ArrayItem{ key: none, val: 'vh' }, rt.ArrayItem{ key: none, val: 'dvh' }, rt.ArrayItem{ key: none, val: 'svh' }, rt.ArrayItem{ key: none, val: 'lvh' }, rt.ArrayItem{ key: none, val: 'vw' }, rt.ArrayItem{ key: none, val: 'vmin' }, rt.ArrayItem{ key: none, val: 'vmax' }, rt.ArrayItem{ key: none, val: 'rem' }])
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.relative_size_units() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '%' }, rt.ArrayItem{ key: none, val: 'em' }, rt.ArrayItem{ key: none, val: 'ex' }, rt.ArrayItem{ key: none, val: 'ch' }, rt.ArrayItem{ key: none, val: 'fr' }])
}
pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.non_size_units() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'deg' }, rt.ArrayItem{ key: none, val: 'grad' }, rt.ArrayItem{ key: none, val: 'rad' }, rt.ArrayItem{ key: none, val: 's' }, rt.ArrayItem{ key: none, val: 'ms' }, rt.ArrayItem{ key: none, val: 'turn' }, rt.ArrayItem{ key: none, val: 'Hz' }, rt.ArrayItem{ key: none, val: 'kHz' }])
}
struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size {
	rt.PhpObjectBase
pub mut:
		SIZE_UNITS rt.PhpVal = rt.new_null()
		fSize rt.PhpVal = rt.new_null()
		sUnit rt.PhpVal = rt.new_null()
		bIsColorComponent rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) construct(var_fSize rt.PhpVal, var_sUnit rt.PhpVal, bIsColorComponent bool, iLineNo i64)  {
	mut var_sUnit_mutated := var_sUnit
	this.Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue.construct(rt.new_int(iLineNo))
	this.fSize = // unsupported expression: Expr_Cast_Double
	this.sUnit = var_sUnit_mutated.dup()
	this.bIsColorComponent = rt.new_bool(bIsColorComponent).dup()
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.parse(mut var_oParserState Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState, bIsColorComponent bool) rt.PhpVal {
	mut var_sSize := rt.new_string(rt.new_string(''))
	if rt.is_true(var_oParserState.comes(rt.new_string('-'))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	for rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_oParserState.peek().is_long() || var_oParserState.peek().is_double())) || rt.is_true(var_oParserState.comes(rt.new_string('.'))))) || rt.is_true(var_oParserState.comes(rt.new_string('e'), rt.new_bool(true))))) {
		if rt.is_true(var_oParserState.comes(rt.new_string('.'))) {
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(var_oParserState.comes(rt.new_string('e'), rt.new_bool(true))) {
			mut var_sLookahead := var_oParserState.peek(rt.new_int(1), rt.new_int(1))
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_sLookahead.dup().is_long() || var_sLookahead.dup().is_double())) || rt.is_true(rt.identical(var_sLookahead, rt.new_string('+'))))) || rt.is_true(rt.identical(var_sLookahead, rt.new_string('-'))))) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				break
				// unsupported statement: Stmt_Nop
			}
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_sUnit := rt.new_null()
	mut var_aSizeUnits := Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.getsizeunits()
	{
		mut iter_1 := var_aSizeUnits.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_aValues := item_1.val
			mut var_iLength := item_1.key
			mut var_sKey := rt.new_string(rt.new_string(var_oParserState.peek(var_iLength.dup()).to_string().to_lower()))
			if rt.is_true(rt.new_bool(var_aValues.dup().array_isset(var_sKey.dup()))) {
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_oParserState.consume(var_iLength.dup())
					break
				}
			}
		}
	}
	return create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_size(// unsupported expression: Expr_Cast_Double, var_sUnit, bIsColorComponent, var_oParserState.currentline())
}

fn Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.getsizeunits() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_array()))))) {
		// unsupported assign target: Expr_StaticPropertyFetch
		{
			mut iter_1 := rt.call_function('array_merge', [Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.absolute_size_units(), Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.relative_size_units(), Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.non_size_units()]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_val := item_1.val
				mut var_iSize := rt.new_int(rt.new_int(var_val.dup().to_string().len))
				if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_iSize)) {
					// unsupported expression: Expr_StaticPropertyFetch.array_set(var_iSize, rt.new_array())
				}
				// unsupported expression: Expr_StaticPropertyFetch.array_get_mut(var_iSize).array_set(var_val.dup().to_string().to_lower(), var_val.dup())
			}
		}
		rt.call_function('krsort', [// unsupported expression: Expr_StaticPropertyFetch, rt.get_constant('SORT_NUMERIC')])
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) setunit(var_sUnit rt.PhpVal)  {
	mut var_sUnit_mutated := var_sUnit
	this.sUnit = var_sUnit_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) getunit() rt.PhpVal {
	return this.sUnit
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) setsize(var_fSize rt.PhpVal)  {
	this.fSize = // unsupported expression: Expr_Cast_Double
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) getsize() rt.PhpVal {
	return this.fSize
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) iscolorcomponent() rt.PhpVal {
	return this.bIsColorComponent
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) issize() bool {
	if rt.is_true(rt.call_function('in_array', [this.sUnit, Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.non_size_units(), rt.new_bool(true)])) {
		return false
	}
	return !(rt.is_true(this.iscolorcomponent()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) isrelative() bool {
	if rt.is_true(rt.call_function('in_array', [this.sUnit, Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.relative_size_units(), rt.new_bool(true)])) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(this.sUnit, rt.new_null())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual))) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) magic_tostring() rt.PhpVal {
	return rt.new_string(this.render(create_automattic_woocommerce_emaileditorvendor_sabberworm_css_outputformat()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) render(var_oOutputFormat rt.PhpVal) string {
	mut var_l := rt.call_function('localeconv', []rt.PhpVal{})
	mut var_sPoint := rt.call_function('preg_quote', [var_l.array_get('decimal_point'), rt.new_string('/')])
	mut var_sSize := if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[\\d\\.]+e[+-]?\\d+/i'), // unsupported expression: Expr_Cast_String])) { rt.call_function('preg_replace', [rt.concat(rt.concat(rt.new_string('/'), var_sPoint), rt.new_string('?0+$/')), rt.new_string(''), rt.call_function('sprintf', [rt.new_string('%f'), this.fSize])]) } else { // unsupported expression: Expr_Cast_String }
	return (rt.call_function('preg_replace', [rt.create_array([rt.ArrayItem{ key: none, val: "/${var_sPoint.to_string()}/" }, rt.ArrayItem{ key: none, val: '/^(-?)0\\./' }]), rt.create_array([rt.ArrayItem{ key: none, val: '.' }, rt.ArrayItem{ key: none, val: '$1.' }]), var_sSize.dup()])).str() + (if rt.is_true(rt.identical(this.sUnit, rt.new_null())) { rt.new_string('') } else { this.sUnit }).str()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_OutputFormat {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_size(arg_0 rt.PhpVal, bIsColorComponent bool, iLineNo i64, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size{
		PhpObjectBase: rt.PhpObjectBase{}
		SIZE_UNITS: rt.new_null()
		fSize: rt.new_null()
		sUnit: rt.new_null()
		bIsColorComponent: rt.new_null()
	}
	obj.construct(arg_0, bIsColorComponent, iLineNo, arg_3)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_sabberworm_css_value_primitivevalue() &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue{
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

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'parse' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Parsing_ParserState](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.parse(mut dispatch_arg_0, dispatch_arg_1)
		}
		'getSizeUnits' {
			return Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size.getsizeunits()
		}
		'setUnit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setunit(dispatch_arg_0)
			return rt.new_null()
		}
		'getUnit' {
			return this.getunit()
		}
		'setSize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setsize(dispatch_arg_0)
			return rt.new_null()
		}
		'getSize' {
			return this.getsize()
		}
		'isColorComponent' {
			return this.iscolorcomponent()
		}
		'isSize' {
			return rt.new_bool(this.issize())
		}
		'isRelative' {
			return rt.new_bool(this.isrelative())
		}
		'__toString' {
			return this.magic_tostring()
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'SIZE_UNITS' { return this.SIZE_UNITS }
		'fSize' { return this.fSize }
		'sUnit' { return this.sUnit }
		'bIsColorComponent' { return this.bIsColorComponent }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_Size) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'SIZE_UNITS' { this.SIZE_UNITS = val; return true }
		'fSize' { this.fSize = val; return true }
		'sUnit' { this.sUnit = val; return true }
		'bIsColorComponent' { this.bIsColorComponent = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Sabberworm_CSS_Value_PrimitiveValue) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_sabberworm_css_value_size_php() {
}
