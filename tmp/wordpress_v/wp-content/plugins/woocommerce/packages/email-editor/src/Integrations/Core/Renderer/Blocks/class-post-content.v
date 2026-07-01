import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content) render_stateless(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_post_id := if !(rt.get_property(var_block, 'context').array_get('postId')).is_null() {
		rt.get_property(var_block, 'context').array_get('postId')
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return ''
	}
	mut var_email_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_email_post))))
		|| !rt.is_true(rt.get_property(var_email_post, 'post_content'))))
	{
		return ''
	}
	// unsupported statement: Stmt_Global
	mut var_backup_post := var_post.dup()
	mut var_backup_query := var_wp_query.dup()
	mut var_post := var_email_post.dup()
	mut var_wp_query := create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_query(rt.create_array([
		rt.ArrayItem{ key: 'p', val: var_post_id },
	]))
	mut var_post_content := rt.get_property(var_email_post, 'post_content')
	if rt.is_true(rt.call_function('has_block', [rt.new_string('core/nextpage'),
		var_email_post.dup()]))
	{
		// unsupported expression: Expr_AssignOp_Concat
	}
	var_post_content = rt.call_function('apply_filters', [rt.new_string('the_content'),
		rt.call_function('str_replace', [rt.new_string(']]>'),
			rt.new_string(']]&gt;'), var_post_content.dup()])])
	var_post = var_backup_post.dup()
	var_wp_query = var_backup_query.dup()
	if !rt.is_true(var_post_content) {
		return ''
	}
	return var_post_content.str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_post_content() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_wp_query() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Query {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_stateless' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render_stateless(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Post_Content) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_core_renderer_blocks_class_post_content_php() {
	// unsupported statement: Stmt_Declare
}
