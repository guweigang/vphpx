import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) get_schema() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_0 := iife_temp_0.string()
	mut iife_temp_1 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_1 := iife_temp_1.string()
	mut iife_temp_2 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_2 := iife_temp_2.string()
	mut iife_temp_3 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_3 := iife_temp_3.string()
	mut iife_temp_4 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_4 := iife_temp_4.string()
	mut iife_temp_5 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_5 := iife_temp_5.string()
	mut iife_temp_6 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_6 := iife_temp_6.string()
	mut iife_temp_7 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_7 := iife_temp_7.string()
	mut iife_temp_8 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_8 := iife_temp_8.object(rt.create_array([
		rt.ArrayItem{ key: 'fontFamily', val: rt.call_method(iife_result_0, 'nullable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fontSize', val: rt.call_method(iife_result_1, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fontStyle', val: rt.call_method(iife_result_2, 'nullable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fontWeight', val: rt.call_method(iife_result_3, 'nullable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'letterSpacing', val: rt.call_method(iife_result_4, 'nullable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'lineHeight', val: rt.call_method(iife_result_5, 'nullable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'textTransform', val: rt.call_method(iife_result_6, 'nullable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'textDecoration', val: rt.call_method(iife_result_7, 'nullable',
			[]rt.PhpVal{}) },
	]))
	mut var_typography_props := rt.call_method(iife_result_8, 'nullable', []rt.PhpVal{})
	mut iife_temp_9 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_9 := iife_temp_9.integer()
	mut iife_temp_10 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_10 := iife_temp_10.string()
	mut iife_temp_11 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_11 := iife_temp_11.string()
	mut iife_temp_12 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_12 := iife_temp_12.string()
	mut iife_temp_13 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_13 := iife_temp_13.string()
	mut iife_temp_14 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_14 := iife_temp_14.object(rt.create_array([
		rt.ArrayItem{ key: 'top', val: iife_result_10 },
		rt.ArrayItem{ key: 'right', val: iife_result_11 },
		rt.ArrayItem{ key: 'bottom', val: iife_result_12 },
		rt.ArrayItem{ key: 'left', val: iife_result_13 },
	]))
	mut iife_temp_15 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_15 := iife_temp_15.string()
	mut iife_temp_16 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_16 := iife_temp_16.object(rt.create_array([
		rt.ArrayItem{ key: 'padding', val: rt.call_method(iife_result_14, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'blockGap', val: rt.call_method(iife_result_15, 'nullable',
			[]rt.PhpVal{}) },
	]))
	mut iife_temp_17 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_17 := iife_temp_17.string()
	mut iife_temp_18 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_18 := iife_temp_18.string()
	mut iife_temp_19 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_19 := iife_temp_19.object(rt.create_array([
		rt.ArrayItem{ key: 'background', val: rt.call_method(iife_result_17, 'nullable',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'text', val: rt.call_method(iife_result_18, 'nullable', []rt.PhpVal{}) },
	]))
	mut iife_temp_20 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_20 := iife_temp_20.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_21 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_21 := iife_temp_21.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_22 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_22 := iife_temp_22.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_23 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_23 := iife_temp_23.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_24 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_24 := iife_temp_24.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_25 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_25 := iife_temp_25.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_26 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_26 := iife_temp_26.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_27 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_27 := iife_temp_27.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_28 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_28 := iife_temp_28.object(rt.create_array([
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
	]))
	mut iife_temp_29 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_29 := iife_temp_29.object(rt.create_array([
		rt.ArrayItem{ key: 'heading', val: rt.call_method(iife_result_20, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'button', val: rt.call_method(iife_result_21, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'link', val: rt.call_method(iife_result_22, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'h1', val: rt.call_method(iife_result_23, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'h2', val: rt.call_method(iife_result_24, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'h3', val: rt.call_method(iife_result_25, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'h4', val: rt.call_method(iife_result_26, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'h5', val: rt.call_method(iife_result_27, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'h6', val: rt.call_method(iife_result_28, 'nullable', []rt.PhpVal{}) },
	]))
	mut iife_temp_30 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_30 := iife_temp_30.object(rt.create_array([
		rt.ArrayItem{ key: 'spacing', val: rt.call_method(iife_result_16, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'color', val: rt.call_method(iife_result_19, 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'typography', val: var_typography_props },
		rt.ArrayItem{ key: 'elements', val: rt.call_method(iife_result_29, 'nullable',
			[]rt.PhpVal{}) },
	]))
	mut iife_temp_31 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_31 := iife_temp_31.object(rt.create_array([
		rt.ArrayItem{ key: 'version', val: iife_result_9 },
		rt.ArrayItem{ key: 'styles', val: rt.call_method(iife_result_30, 'nullable', []rt.PhpVal{}) },
	]))
	return rt.call_method(iife_result_31, 'to_array', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_email_styles_schema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_builder(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_schema' {
			return this.get_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
