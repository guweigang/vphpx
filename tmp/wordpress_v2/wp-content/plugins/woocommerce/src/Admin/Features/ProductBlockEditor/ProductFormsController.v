import rt

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController {
	rt.PhpObjectBase
pub mut:
	product_form_templates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) init() {
	rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'migrate_templates_when_plugin_updated' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) migrate_templates_when_plugin_updated(mut var_upgrader Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Upgrader, mut var_hook_extra Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array) {
	mut var_type := if var_hook_extra.array_isset(rt.new_string('type')) {
		var_hook_extra.array_get(rt.new_string('type'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugin'), var_type)))) {
		return
	}
	mut var_plugins := if var_hook_extra.array_isset(rt.new_string('plugins')) {
		var_hook_extra.array_get(rt.new_string('plugins'))
	} else {
		rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('woocommerce/woocommerce.php'),
		var_plugins.clone(),
		rt.new_bool(true),
	])))))
	{
		return
	}
	mut var_action := if var_hook_extra.array_isset(rt.new_string('action')) {
		var_hook_extra.array_get(rt.new_string('action'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('install'), var_action))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('update'), var_action)))) {
		return
	}
	this.migrate_product_form_posts(var_action.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController) migrate_product_form_posts(var_action rt.PhpVal) {
	mut var_action_mutated := var_action
	mut var_templates := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_form_templates'),
		this.product_form_templates,
	])
	mut iter_1 := var_templates.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_slug := item_1.val
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}
		mut iife_result_0 := iife_temp_0.get_block_template_path(var_slug.clone())
		mut var_file_path := iife_result_0
		if rt.is_true(rt.new_bool(!(rt.is_true(var_file_path)))) {
			continue
		}
		mut iife_temp_1 :=
			Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}
		mut iife_result_1 := iife_temp_1.get_template_file_data(var_file_path.clone())
		mut var_file_data := iife_result_1
		mut var_posts := rt.call_function('get_posts', [
			rt.create_array([rt.ArrayItem{ key: 'name', val: var_slug },
				rt.ArrayItem{ key: 'post_type', val: 'product_form' },
				rt.ArrayItem{ key: 'post_status', val: 'any' },
				rt.ArrayItem{ key: 'posts_per_page', val: 1 }]),
		])
		if rt.is_true(rt.identical(rt.new_string('update'), var_action_mutated)) {
			mut var_post := if !(var_posts.array_get(rt.new_int(0))).is_null() {
				var_posts.array_get(rt.new_int(0))
			} else {
				rt.new_null()
			}
			if !(!rt.is_true(var_post)) {
				mut iife_temp_2 :=
					Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}
				mut iife_result_2 := iife_temp_2.get_template_content(var_file_path.clone())
				rt.call_function('wp_update_post', [
					rt.create_array([
						rt.ArrayItem{ key: 'ID', val: rt.get_property(var_post, 'ID') },
						rt.ArrayItem{
							key: 'post_title'
							val: var_file_data.array_get(rt.new_string('title'))
						},
						rt.ArrayItem{ key: 'post_content', val: iife_result_2 },
						rt.ArrayItem{
							key: 'post_excerpt'
							val: var_file_data.array_get(rt.new_string('description'))
						},
					]),
				])
			}
		}
		if !(!rt.is_true(var_posts)) {
			continue
		}
		mut iife_temp_3 :=
			Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils{}
		mut iife_result_3 := iife_temp_3.get_template_content(var_file_path.clone())
		var_post = rt.call_function('wp_insert_post', [
			rt.create_array([
				rt.ArrayItem{
					key: 'post_title'
					val: var_file_data.array_get(rt.new_string('title'))
				},
				rt.ArrayItem{ key: 'post_name', val: var_slug },
				rt.ArrayItem{ key: 'post_status', val: 'publish' },
				rt.ArrayItem{ key: 'post_type', val: 'product_form' },
				rt.ArrayItem{ key: 'post_content', val: iife_result_3 },
				rt.ArrayItem{
					key: 'post_excerpt'
					val: var_file_data.array_get(rt.new_string('description'))
				},
			]),
		])
	}
}

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_productblockeditor_productformscontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductFormsController{
		PhpObjectBase:          rt.PhpObjectBase{}
		product_form_templates: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_productblockeditor_blocktemplateutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_BlockTemplateUtils {
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_WP_Upgrader](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.migrate_templates_when_plugin_updated(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'migrate_product_form_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.migrate_product_form_posts(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
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
		'product_form_templates' {
			this.product_form_templates = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
