import rt

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController {
	rt.PhpObjectBase
pub mut:
		product_form_templates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) init()  {
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'migrate_templates_when_plugin_updated' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) migrate_templates_when_plugin_updated(mut var_upgrader Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Upgrader, mut var_hook_extra Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array)  {
	mut var_type := if var_hook_extra.array_isset(rt.new_string('type')) { var_hook_extra.array_get('type') } else { rt.new_string('') }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_plugins := if var_hook_extra.array_isset(rt.new_string('plugins')) { var_hook_extra.array_get('plugins') } else { rt.new_array() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('woocommerce/woocommerce.php'), var_plugins.dup(), rt.new_bool(true)]))))) {
		return rt.new_null()
	}
	mut var_action := if var_hook_extra.array_isset(rt.new_string('action')) { var_hook_extra.array_get('action') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	this.migrate_product_form_posts(var_action.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) migrate_product_form_posts(var_action rt.PhpVal)  {
	mut var_action_mutated := var_action
	mut var_templates := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_form_templates'), this.product_form_templates])
	{
		mut iter_1 := var_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_slug := item_1.val
			mut var_file_path := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}; return temp.get_block_template_path(arg_0) }(var_slug.dup())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_file_path)))) {
				continue
			}
			mut var_file_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}; return temp.get_template_file_data(arg_0) }(var_file_path.dup())
			mut var_posts := rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'name', val: var_slug }, rt.ArrayItem{ key: 'post_type', val: 'product_form' }, rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }])])
			if rt.is_true(rt.identical(rt.new_string('update'), var_action_mutated)) {
				mut var_post := if !(var_posts.array_get(0)).is_null() { var_posts.array_get(0) } else { rt.new_null() }
				if !(!rt.is_true(var_post)) {
					rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_post, 'ID') }, rt.ArrayItem{ key: 'post_title', val: var_file_data.array_get('title') }, rt.ArrayItem{ key: 'post_content', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}; return temp.get_template_content(arg_0) }(var_file_path.dup()) }, rt.ArrayItem{ key: 'post_excerpt', val: var_file_data.array_get('description') }])])
				}
			}
			if !(!rt.is_true(var_posts)) {
				continue
			}
			var_post = rt.call_function('wp_insert_post', [rt.create_array([rt.ArrayItem{ key: 'post_title', val: var_file_data.array_get('title') }, rt.ArrayItem{ key: 'post_name', val: var_slug }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_type', val: 'product_form' }, rt.ArrayItem{ key: 'post_content', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}; return temp.get_template_content(arg_0) }(var_file_path.dup()) }, rt.ArrayItem{ key: 'post_excerpt', val: var_file_data.array_get('description') }])])
		}
	}
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_productblockeditor_productformscontroller() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController{
		PhpObjectBase: rt.PhpObjectBase{}
		product_form_templates: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_blocktemplateutils() &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'migrate_templates_when_plugin_updated' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Upgrader](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.migrate_templates_when_plugin_updated(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'migrate_product_form_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.migrate_product_form_posts(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'product_form_templates' { return this.product_form_templates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'product_form_templates' { this.product_form_templates = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_productblockeditor_productformscontroller_php() {
}
