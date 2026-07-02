import rt

struct Class_Akismet_Widget {
	rt.PhpObjectBase
}

fn (mut this Class_Akismet_Widget) construct() {
	this.Class_WP_Widget.construct(rt.new_string('akismet_widget'), rt.call_function('__', [
		rt.new_string('Akismet Widget'),
		rt.new_string('akismet'),
	]), rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Display the number of spam comments Akismet has caught'),
			rt.new_string('akismet'),
		]) },
	]))
}

fn (mut this Class_Akismet_Widget) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	if rt.is_true(var_instance_mutated) && var_instance_mutated.array_isset(rt.new_string('title')) {
		mut var_title := var_instance_mutated.array_get(rt.new_string('title'))
	} else {
		var_title = rt.call_function('__', [rt.new_string('Spam Blocked'),
			rt.new_string('akismet')])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('title')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:'), rt.new_string('akismet')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Akismet_Widget) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := map[string]rt.PhpVal{}
	var_instance['title'] = rt.call_function('sanitize_text_field', [
		var_new_instance.array_get(rt.new_string('title')),
	])
	return var_instance.clone()
}

fn (mut this Class_Akismet_Widget) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_count := rt.call_function('get_option', [rt.new_string('akismet_spam_count')])
	if !(var_instance_mutated.array_isset(rt.new_string('title'))) {
		var_instance_mutated.array_set('title', rt.call_function('__', [
			rt.new_string('Spam Blocked'),
			rt.new_string('akismet'),
		]))
	}
	rt.echo_val(var_args.array_get(rt.new_string('before_widget')))
	if !(!rt.is_true(var_instance_mutated.array_get(rt.new_string('title')))) {
		rt.echo_val(var_args.array_get(rt.new_string('before_title')))
		rt.echo_val(rt.call_function('esc_html',
			[var_instance_mutated.array_get(rt.new_string('title'))]))
		rt.echo_val(var_args.array_get(rt.new_string('after_title')))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [
		rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('<strong class="count">%1$s spam</strong> blocked by <strong>Akismet</strong>'),
				rt.new_string('<strong class="count">%1$s spam</strong> blocked by <strong>Akismet</strong>'),
				var_count.clone(),
				rt.new_string('akismet'),
			]),
			rt.call_function('number_format_i18n', [
				var_count.clone(),
			]),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'strong', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: true },
			]) },
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_args.array_get(rt.new_string('after_widget')))
}

fn akismet_register_widgets() {
	rt.call_function('register_widget', [rt.new_string('Akismet_Widget')])
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_akismet_widget() &Class_Akismet_Widget {
	mut obj := &Class_Akismet_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_widget(_args ...rt.PhpVal) &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Akismet_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('widgets_init'),
		rt.new_string('akismet_register_widgets')])
}
