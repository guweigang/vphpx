import rt

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Subsection {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Subsection) construct(mut var_config Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_array, mut var_root_template Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface, mut var_parent Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_?ContainerInterface)  {
	if !(!rt.is_true(var_config.array_get('blockName'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_invalidargumentexception(rt.new_string('Unexpected key "blockName", this defaults to "woocommerce/product-subsection".'))))
	}
	this.Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock.construct(rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-subsection' }]), var_config]), rt.new_object('Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface', []string{}, var_root_template), rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_?ContainerInterface', []string{}, var_parent))
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_subsection(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Subsection {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Subsection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_productblock() &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_invalidargumentexception() &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Subsection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_BlockTemplates_BlockTemplateInterface](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_?ContainerInterface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Subsection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Subsection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_features_productblockeditor_producttemplates_subsection_php() {
}
