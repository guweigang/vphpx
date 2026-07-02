import rt

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder() string {
	return '##WOO_CONTENT##'
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer {
	rt.PhpObjectBase
pub mut:
	renderer              rt.PhpVal = rt.new_null()
	personalizer          rt.PhpVal = rt.new_null()
	woo_content_processor rt.PhpVal = rt.new_null()
	template_manager      rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) construct() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{}
	mut iife_result_0 := iife_temp_0.container()
	mut var_editor_container := iife_result_0
	this.renderer = rt.call_method(var_editor_container, 'get', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer.class(),
	])
	this.personalizer = rt.call_method(var_editor_container, 'get', [
		Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer.class(),
	])
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}
	mut iife_result_1 := iife_temp_1.get_instance()
	this.template_manager = iife_result_1
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) init(mut var_woo_content_processor Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor) {
	this.woo_content_processor = var_woo_content_processor
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_blocks_renderer_initialized'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_block_renderers' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) maybe_render_block_email(mut var_wc_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) string {
	mut var_email_post := this.get_email_post_by_wc_email(mut var_wc_email)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email_post)))) {
		return (rt.new_null()).str()
	}
	mut var_woo_content := rt.call_method(this.woo_content_processor, 'get_woo_content', [
		var_wc_email,
	])
	return this.render_block_email(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WP_Post](var_email_post),
		var_woo_content.str(), mut var_wc_email)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) render_block_email(mut var_email_post Class_Automattic_WooCommerce_Internal_EmailEditor_WP_Post, woo_content string, mut var_wc_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) string {
	mut var_email_post_mutated := var_email_post
	mut woo_content_mutated := woo_content
	closure_3_fn := fn [var_wc_email] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (rt.call_function('array_merge', [var_context.clone(),
			this.build_email_context(mut rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WC_Email',
				[]string{}, var_wc_email))])).str()
	}
	mut var_filter_callback := rt.new_closure(closure_3_fn)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_email_editor_rendering_email_context'),
		var_filter_callback.clone(),
		rt.new_int(10),
		rt.new_int(1),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_subject := var_wc_email.get_subject()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_preheader := var_wc_email.get_preheader()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_rendered_email_data := rt.call_method(this.renderer, 'render', [
		var_email_post_mutated,
		var_subject.clone(),
		var_preheader.clone(),
		rt.new_string('en'),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_personalized_email := rt.call_method(this.personalizer, 'personalize_content', [
		var_rendered_email_data.array_get(rt.new_string('html')),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_rendered_email := rt.call_function('str_replace', [
		Class_Automattic_WooCommerce_Internal_EmailEditor_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer.woo_email_content_placeholder(),
		rt.new_string(woo_content_mutated).clone(),
		var_personalized_email.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_email_editor_rendering_email_context'),
		var_filter_callback.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_styles'),
		rt.create_array([rt.ArrayItem{ key: none, val: this.woo_content_processor },
			rt.ArrayItem{ key: none, val: 'prepare_css' }]),
		rt.new_int(10), rt.new_int(2)])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return var_rendered_email.str()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_EmailEditor_Exception') {
		mut var_e := var_e_1.clone()
		rt.call_function('wc_caught_exception', [var_e.clone(),
			rt.new_string(@METHOD),
			rt.create_array([
				rt.ArrayItem{ key: none, val: var_email_post_mutated },
				rt.ArrayItem{ key: none, val: woo_content_mutated },
				rt.ArrayItem{ key: none, val: var_wc_email },
			])])
		if !var_filter_callback.is_null() {
			rt.call_function('remove_filter', [
				rt.new_string('woocommerce_email_editor_rendering_email_context'),
				var_filter_callback.clone(),
			])
		}
		return (rt.new_null()).str()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) get_email_post_by_wc_email(mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) rt.PhpVal {
	return rt.call_method(this.template_manager, 'get_email_post', [
		rt.get_property(var_email, 'id'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) build_email_context(mut var_wc_email Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email) rt.PhpVal {
	mut var_recipient_raw := var_wc_email.get_recipient()
	mut var_emails := rt.call_function('array_values', [
		rt.call_function('array_filter', [
			rt.call_function('array_map', [rt.new_string('sanitize_email'),
				rt.call_function('array_map', [rt.new_string('trim'),
					rt.call_function('explode', [rt.new_string(','),
						var_recipient_raw.clone()])])]),
		]),
	])
	mut var_context := rt.create_array([
		rt.ArrayItem{
			key: 'recipient_email'
			val: if !(var_emails.array_get(rt.new_int(0))).is_null() {
				var_emails.array_get(rt.new_int(0))
			} else {
				rt.new_null()
			}
		},
	])
	if !(rt.get_property(var_wc_email, 'object')).is_null()
		&& rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_wc_email, 'object'), 'Automattic_WooCommerce_Internal_EmailEditor_WC_Order'))) {
		mut var_order := rt.get_property(var_wc_email, 'object')
		var_context.array_set('user_id',
			rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}))
	}
	return var_context.clone()
}

struct Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_blockemailrenderer() &Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer{
		PhpObjectBase:         rt.PhpObjectBase{}
		renderer:              rt.new_null()
		personalizer:          rt.new_null()
		woo_content_processor: rt.new_null()
		template_manager:      rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_emaileditor_email_editor_container(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_render_block_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.maybe_render_block_email(mut dispatch_arg_0))
		}
		'render_block_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WP_Post](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_block_email(mut dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'get_email_post_by_wc_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_email_post_by_wc_email(mut dispatch_arg_0)
		}
		'build_email_context' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WC_Email](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.build_email_context(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'renderer' { return this.renderer }
		'personalizer' { return this.personalizer }
		'woo_content_processor' { return this.woo_content_processor }
		'template_manager' { return this.template_manager }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_BlockEmailRenderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'renderer' {
			this.renderer = val
			return true
		}
		'personalizer' {
			this.personalizer = val
			return true
		}
		'woo_content_processor' {
			this.woo_content_processor = val
			return true
		}
		'template_manager' {
			this.template_manager = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Email_Editor_Container) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
