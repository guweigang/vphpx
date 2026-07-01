import rt

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter {
	rt.PhpObjectBase
pub mut:
	cssToHtmlMap rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) convertcsstovisualattributes() rt.PhpVal {
	mut var_declarationBlockParser :=
		create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser()
	{
		mut iter_1 := this.getallnodeswithstyleattribute().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_node := item_1.val
			mut var_inlineStyleDeclarations := var_declarationBlockParser.parse(rt.call_method(var_node,
				'getAttribute', [rt.new_string('style')]))
			this.mapcsstohtmlattributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](var_inlineStyleDeclarations), mut
				rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](var_node))
		}
	}
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter',
		[]string{}, this)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) getallnodeswithstyleattribute() rt.PhpVal {
	return rt.call_method(this.getxpath(), 'query', [rt.new_string('//*[@style]')])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapcsstohtmlattributes(mut var_styles Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array, mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement) {
	mut var_styles_mutated := var_styles
	{
		mut iter_1 := var_styles_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_property := item_1.key
			var_value = rt.new_string(rt.new_string(rt.call_function('str_replace', [
				rt.new_string('!important'),
				rt.new_string(''),
				var_value.dup(),
			]).to_string().trim_space()))
			this.mapcsstohtmlattribute(var_property.str(), var_value.str(), mut var_node)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapcsstohtmlattribute(property string, value string, mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement) {
	mut value_mutated := value
	if !(this.mapsimplecssproperty(property, value_mutated, mut var_node)) {
		this.mapcomplexcssproperty(property, value_mutated, mut var_node)
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapsimplecssproperty(property string, value string, mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement) bool {
	mut value_mutated := value
	if !(this.cssToHtmlMap.array_isset(rt.new_string(property))) {
		return false
	}
	mut var_mapping := this.cssToHtmlMap.array_get(property)
	mut var_nodesMatch := rt.new_bool(rt.new_bool(
		!(var_mapping.array_isset(rt.new_string('nodes')))
		|| rt.is_true(rt.call_function('in_array', [rt.get_property(var_node, 'nodeName'), var_mapping.array_get('nodes'), rt.new_bool(true)]))))
	mut var_valuesMatch := rt.new_bool(rt.new_bool(
		!(var_mapping.array_isset(rt.new_string('values')))
		|| rt.is_true(rt.call_function('in_array', [rt.new_string(value_mutated).dup(), var_mapping.array_get('values'), rt.new_bool(true)]))))
	mut var_canBeMapped := rt.new_bool(rt.new_bool(rt.is_true(var_nodesMatch)
		&& rt.is_true(var_valuesMatch)))
	if rt.is_true(var_canBeMapped) {
		var_node.setattribute(var_mapping.array_get('attribute'), rt.new_string(value_mutated))
	}
	return var_canBeMapped.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapcomplexcssproperty(property string, value string, mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement) {
	mut value_mutated := value
	mut switch_val_1 := rt.new_string(property)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('background'))) {
		this.mapbackgroundproperty(mut var_node, value_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('width')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('height'))) {
		this.mapwidthorheightproperty(mut var_node, value_mutated, property)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('margin'))) {
		this.mapmarginproperty(mut var_node, value_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('border'))) {
		this.mapborderproperty(mut var_node, value_mutated)
	} else {
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapbackgroundproperty(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement, value string) {
	mut value_mutated := value
	mut var_styles := rt.call_function('explode', [rt.new_string(' '),
		rt.new_string(value_mutated).dup(), rt.new_int(2)])
	mut var_first := var_styles.array_get(0)
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_first.array_get(0).is_long()
		|| var_first.array_get(0).is_double()))
		|| rt.is_true(rt.identical(rt.call_function('strncmp', [var_first.dup(), rt.new_string('url'), rt.new_int(3)]), rt.new_int(0)))))
	{
		return rt.new_null()
	}
	var_node.setattribute(rt.new_string('bgcolor'), var_first.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapwidthorheightproperty(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement, value string, property string) {
	mut value_mutated := value
	mut var_preg :=
		create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg()
	if rt.is_true(rt.identical(var_preg.match(rt.new_string('/^(\\d+)(\\.(\\d+))?(px|%)$/'),
		rt.new_string(value_mutated)), rt.new_int(0)))
	{
		return rt.new_null()
	}
	mut var_number := var_preg.replace(rt.new_string('/[^0-9.%]/'), rt.new_string(''),
		rt.new_string(value_mutated))
	var_node.setattribute(rt.new_string(property), var_number.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapmarginproperty(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement, value string) {
	mut value_mutated := value
	if !(this.istableorimagenode(mut var_node)) {
		return rt.new_null()
	}
	mut var_margins := this.parsecssshorthandvalue(value_mutated)
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(var_margins.array_get('left'), rt.new_string('auto')))
		&& rt.is_true(rt.identical(var_margins.array_get('right'), rt.new_string('auto')))))
	{
		var_node.setattribute(rt.new_string('align'), rt.new_string('center'))
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) mapborderproperty(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement, value string) {
	mut value_mutated := value
	if !(this.istableorimagenode(mut var_node)) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.identical(rt.new_string(value_mutated), rt.new_string('none')))
		|| rt.is_true(rt.identical(rt.new_string(value_mutated), rt.new_string('0')))))
	{
		var_node.setattribute(rt.new_string('border'), rt.new_string('0'))
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) istableorimagenode(mut var_node Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement) bool {
	return rt.is_true(rt.identical(rt.get_property(var_node, 'nodeName'), rt.new_string('table')))
		|| rt.is_true(rt.identical(rt.get_property(var_node, 'nodeName'), rt.new_string('img')))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) parsecssshorthandvalue(value string) rt.PhpVal {
	mut value_mutated := value
	mut var_values := rt.call_method(create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg(),
		'split', [rt.new_string('/\\s+/'), rt.new_string(value_mutated).dup()])
	mut var_css := rt.new_array()
	var_css.array_set('top', var_values.array_get(0))
	var_css.array_set('right', if var_values.dup().array_count() > 1 {
		var_values.array_get(1)
	} else {
		var_css.array_get('top')
	})
	var_css.array_set('bottom', if var_values.dup().array_count() > 2 {
		var_values.array_get(2)
	} else {
		var_css.array_get('top')
	})
	var_css.array_set('left', if var_values.dup().array_count() > 3 {
		var_values.array_get(3)
	} else {
		var_css.array_get('right')
	})
	return var_css.dup()
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_csstoattributeconverter() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter{
		PhpObjectBase: rt.PhpObjectBase{}
		cssToHtmlMap:  rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_htmlprocessor_abstracthtmlprocessor() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_declarationblockparser() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_pelago_emogrifier_utilities_preg() &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'convertCssToVisualAttributes' {
			return this.convertcsstovisualattributes()
		}
		'getAllNodesWithStyleAttribute' {
			return this.getallnodeswithstyleattribute()
		}
		'mapCssToHtmlAttributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.mapcsstohtmlattributes(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'mapCssToHtmlAttribute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.mapcsstohtmlattribute(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'mapSimpleCssProperty' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.mapsimplecssproperty(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'mapComplexCssProperty' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.mapcomplexcssproperty(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'mapBackgroundProperty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.mapbackgroundproperty(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'mapWidthOrHeightProperty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.mapwidthorheightproperty(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'mapMarginProperty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.mapmarginproperty(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'mapBorderProperty' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.mapborderproperty(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'isTableOrImageNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_DOMElement](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.istableorimagenode(mut dispatch_arg_0))
		}
		'parseCssShorthandValue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parsecssshorthandvalue(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cssToHtmlMap' { return this.cssToHtmlMap }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_CssToAttributeConverter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cssToHtmlMap' {
			this.cssToHtmlMap = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_HtmlProcessor_AbstractHtmlProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_DeclarationBlockParser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Pelago_Emogrifier_Utilities_Preg) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_packages_pelago_emogrifier_htmlprocessor_csstoattributeconverter_php() {
	// unsupported statement: Stmt_Declare
}
