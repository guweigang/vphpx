import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section) construct(var_id rt.PhpVal, var_plugin_id rt.PhpVal, var_additional_args rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component.construct(var_id.clone(),
		var_plugin_id.clone(), var_additional_args.clone())
	this.dispatch_set_prop('required_arguments', rt.create_array([
		rt.ArrayItem{ key: none, val: 'title' },
	]))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section{}
	mut iife_result_0 := iife_temp_0.get_missing_arguments(var_additional_args.clone())
	mut var_missing_arguments := iife_result_0
	if var_missing_arguments.clone().array_count() > 0 {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductForm_Exception',
			[]string{}, create_automattic_woocommerce_internal_admin_productform_exception(rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('You are missing required arguments of WooCommerce ProductForm Section: %1$s'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('join', [
				rt.new_string(', '),
				var_missing_arguments.clone(),
			]),
		]))))
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_productform_section(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_internal_admin_productform_component(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productform_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
