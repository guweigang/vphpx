import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email {
	rt.PhpObjectBase
pub mut:
	renderer     rt.PhpVal = rt.new_null()
	personalizer rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) construct(mut var_renderer Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer, mut var_personalizer Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer) {
	this.renderer = var_renderer
	this.personalizer = var_personalizer
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) send_preview_email(var_data rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(var_data.clone().is_bool())) {
		return var_data.to_bool()
	}
	this.validate_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_data))
	mut var_email := var_data.array_get(rt.new_string('email'))
	mut var_post_id := var_data.array_get(rt.new_string('postId'))
	mut var_post := this.fetch_post(var_post_id.clone())
	mut var_subject := rt.new_string(this.get_preview_email_subject(var_post.clone()))
	mut var_email_html_content := rt.new_string(this.render_html(var_post.clone()))
	return this.send_email(var_email.str(), var_subject.str(), var_email_html_content.str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) render_html(var_post rt.PhpVal) string {
	mut var_post_mutated := var_post
	mut var_subject := rt.new_string(this.get_preview_email_subject(var_post_mutated.clone()))
	mut var_language := rt.call_function('get_bloginfo', [rt.new_string('language')])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_email_editor_rendering_email_context'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_preview_context' },
		]),
	])
	mut var_rendered_data := rt.call_method(this.renderer, 'render', [
		var_post_mutated.clone(), var_subject.clone(),
		rt.call_function('__', [
			rt.new_string('Preview'),
			rt.new_string('woocommerce'),
		]),
		var_language.clone()])
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_email_editor_rendering_email_context'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_preview_context' },
		]),
	])
	var_rendered_data = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_send_preview_email_rendered_data'),
		var_rendered_data.clone(),
		var_post_mutated.clone(),
	])
	return this.set_personalize_content((var_rendered_data.array_get(rt.new_string('html'))).str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) get_preview_email_subject(var_post rt.PhpVal) string {
	mut var_post_mutated := var_post
	mut var_subject := rt.new_string((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_send_preview_email_subject'),
		rt.get_property(var_post_mutated, 'post_title'),
		var_post_mutated.clone(),
	])).str())
	return var_subject.str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) add_preview_context(var_email_context rt.PhpVal) rt.PhpVal {
	mut var_email_context_mutated := var_email_context
	var_email_context_mutated.array_set('is_user_preview', true)
	return var_email_context_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) set_personalize_content(content string) string {
	mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	mut var_subscriber := if !(!rt.is_true(rt.get_property(var_current_user, 'ID'))) {
		var_current_user
	} else {
		rt.new_null()
	}
	mut var_personalizer_context := rt.create_array([
		rt.ArrayItem{
			key: 'recipient_email'
			val: if rt.is_true(var_subscriber) {
				rt.get_property(var_subscriber, 'user_email')
			} else {
				rt.new_null()
			}
		},
		rt.ArrayItem{ key: 'is_user_preview', val: true },
	])
	var_personalizer_context = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_send_preview_email_personalizer_context'),
		var_personalizer_context.clone(),
	])
	rt.call_method(this.personalizer, 'set_context', [var_personalizer_context.clone()])
	return (rt.call_method(this.personalizer, 'personalize_content', [
		rt.new_string(content),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) send_email(to string, subject string, body string) bool {
	mut subject_mutated := subject
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_editor_send_preview_email_before_wp_mail'),
		rt.new_string(to),
		rt.new_string(subject_mutated).clone(),
		rt.new_string(body),
	])
	rt.call_function('add_filter', [rt.new_string('wp_mail_content_type'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_mail_content_type' },
		])])
	mut var_result := rt.call_function('wp_mail', [rt.new_string(to),
		rt.new_string(subject_mutated).clone(), rt.new_string(body)])
	rt.call_function('remove_filter', [rt.new_string('wp_mail_content_type'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'set_mail_content_type' },
		])])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_email_editor_send_preview_email_after_wp_mail'),
		rt.new_string(to),
		rt.new_string(subject_mutated).clone(),
		rt.new_string(body),
		var_result.clone(),
	])
	return var_result.to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) set_mail_content_type(content_type string) string {
	return 'text/html'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) validate_data(mut var_data Class_Automattic_WooCommerce_EmailEditor_Engine_array) {
	if !rt.is_true(var_data.array_get(rt.new_string('email')))
		|| !rt.is_true(var_data.array_get(rt.new_string('postId'))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_invalidargumentexception(rt.call_function('esc_html__', [
			rt.new_string('Missing required data'),
			rt.new_string('woocommerce'),
		]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
		var_data.array_get(rt.new_string('email')),
	])))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_invalidargumentexception(rt.call_function('esc_html__', [
			rt.new_string('Invalid email'),
			rt.new_string('woocommerce'),
		]))))
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) fetch_post(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	mut var_post := rt.call_function('get_post', [
		rt.new_int(var_post_id_mutated.clone().to_i64()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post,
		'Automattic_WooCommerce_EmailEditor_Engine_WP_Post'))))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Exception',
			[]string{}, create_automattic_woocommerce_emaileditor_engine_exception(rt.call_function('esc_html__', [
			rt.new_string('Invalid post'),
			rt.new_string('woocommerce'),
		]))))
	}
	return var_post.clone()
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_send_preview_email(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email{
		PhpObjectBase: rt.PhpObjectBase{}
		renderer:      rt.new_null()
		personalizer:  rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_Renderer](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Personalizer](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'send_preview_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.send_preview_email(dispatch_arg_0))
		}
		'render_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_html(dispatch_arg_0))
		}
		'get_preview_email_subject' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_preview_email_subject(dispatch_arg_0))
		}
		'add_preview_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_preview_context(dispatch_arg_0)
		}
		'set_personalize_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.set_personalize_content(dispatch_arg_0))
		}
		'send_email' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.send_email(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'set_mail_content_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.set_mail_content_type(dispatch_arg_0))
		}
		'validate_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.validate_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'fetch_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fetch_post(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'renderer' { return this.renderer }
		'personalizer' { return this.personalizer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Send_Preview_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'renderer' {
			this.renderer = val
			return true
		}
		'personalizer' {
			this.personalizer = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
