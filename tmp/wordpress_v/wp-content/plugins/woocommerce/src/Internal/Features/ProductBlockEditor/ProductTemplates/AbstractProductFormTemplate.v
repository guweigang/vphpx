import rt

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) get_area() string {
	return 'product-form'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) get_group_by_id(group_id string) rt.PhpVal {
	mut var_group := this.get_block(rt.new_string(group_id))
	if rt.is_true(rt.new_bool(rt.is_true(var_group)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_group, 'Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplates_GroupInterface'))))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException',
			[]string{},
			create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_unexpectedvalueexception(rt.new_string('Block with specified ID is not a group.'))))
	}
	return var_group.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) get_section_by_id(section_id string) rt.PhpVal {
	mut var_section := this.get_block(rt.new_string(section_id))
	if rt.is_true(rt.new_bool(rt.is_true(var_section)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_section, 'Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplates_SectionInterface'))))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException',
			[]string{},
			create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_unexpectedvalueexception(rt.new_string('Block with specified ID is not a section.'))))
	}
	return var_section.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) get_subsection_by_id(subsection_id string) rt.PhpVal {
	mut var_subsection := this.get_block(rt.new_string(subsection_id))
	if rt.is_true(rt.new_bool(rt.is_true(var_subsection)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_subsection, 'Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplates_SubsectionInterface'))))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException',
			[]string{},
			create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_unexpectedvalueexception(rt.new_string('Block with specified ID is not a subsection.'))))
	}
	return var_subsection.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) get_block_by_id(block_id string) rt.PhpVal {
	return this.get_block(rt.new_string(block_id))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) add_group(mut var_block_config Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_array) rt.PhpVal {
	mut var_block := create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_group(var_block_config.dup(),
		this.get_root_template(), rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate', [
		'Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate',
		'ProductFormTemplateInterface',
	], &this).dup())
	return this.add_inner_block(rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Group',
		[]string{}, var_block))
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Group {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_abstractproductformtemplate() &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_abstractblocktemplate() &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_unexpectedvalueexception() &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_group() &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Group {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Group{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_area' {
			return rt.new_string(this.get_area())
		}
		'get_group_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_group_by_id(dispatch_arg_0)
		}
		'get_section_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_section_by_id(dispatch_arg_0)
		}
		'get_subsection_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_subsection_by_id(dispatch_arg_0)
		}
		'get_block_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_block_by_id(dispatch_arg_0)
		}
		'add_group' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_group(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlockTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_UnexpectedValueException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Group) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Group) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_Group) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_features_productblockeditor_producttemplates_abstractproductformtemplate_php() {
}
