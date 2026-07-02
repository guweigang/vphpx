import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.templates_root_dir() string {
	return 'templates'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.directory_names() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'TEMPLATES', val: 'product-form' },
		rt.ArrayItem{ key: 'TEMPLATE_PARTS', val: 'product-form/parts' }])
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_templates_directory(template_type string) rt.PhpVal {
	mut var_root_path := rt.new_string(
		(rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(4)])).str() + '/' +
		(Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.templates_root_dir()).str() +
		(rt.get_constant('DIRECTORY_SEPARATOR')).str())
	mut var_templates_directory :=
		rt.new_string(var_root_path.str() +(Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.directory_names().array_get(rt.new_string('TEMPLATES'))).str())
	mut var_template_parts_directory :=
		rt.new_string(var_root_path.str() +(Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.directory_names().array_get(rt.new_string('TEMPLATE_PARTS'))).str())
	if rt.is_true(rt.identical(rt.new_string('wp_template_part'), rt.new_string(template_type))) {
		return var_template_parts_directory.clone()
	}
	return var_templates_directory.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_block_template_path(var_slug rt.PhpVal) bool {
	mut var_directory :=
		Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_templates_directory()
	mut var_path := rt.new_string(
		(rt.call_function('trailingslashit', [var_directory.clone()])).str() + var_slug.str() +
		'.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_path.clone()])))))
	{
		return false
	}
	return var_path.to_bool()
}

fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_template_file_data(var_file_path rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_file_path.clone()])))))
	{
		return rt.new_array()
	}
	mut var_file_data := rt.call_function('get_file_data', [var_file_path.clone(),
		rt.create_array([rt.ArrayItem{ key: 'title', val: 'Title' },
			rt.ArrayItem{ key: 'slug', val: 'Slug' }, rt.ArrayItem{
				key: 'description'
				val: 'Description'
			}, rt.ArrayItem{ key: 'product_types', val: 'Product Types' }])])
	var_file_data.array_set('product_types', rt.call_function('explode', [
		rt.new_string(','),
		rt.new_string(var_file_data.array_get(rt.new_string('product_types')).to_string().trim_space()),
	]))
	return var_file_data.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_template_content(var_file_path rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_file_path.clone()])))))
	{
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file(var_file_path.to_string(), '1')
	mut var_content := rt.call_function('ob_get_contents', []rt.PhpVal{})
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	return var_content.str()
}

fn create_automattic_woocommerce_admin_features_productblockeditor_blocktemplateutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_templates_directory' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_templates_directory(dispatch_arg_0)
		}
		'get_block_template_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_block_template_path(dispatch_arg_0))
		}
		'get_template_file_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_template_file_data(dispatch_arg_0)
		}
		'get_template_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils.get_template_content(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
