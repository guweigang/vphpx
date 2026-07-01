import rt

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	upgrader    rt.PhpVal = rt.new_null()
	done_header bool
	done_footer bool
	result      rt.PhpVal = rt.new_bool(false)
	options     rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Upgrader_Skin) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_defaults := {
		'url':     rt.new_string('')
		'nonce':   rt.new_string('')
		'title':   rt.new_string('')
		'context': rt.new_bool(false)
	}
	this.options = rt.call_function('wp_parse_args', [var_args_mutated.dup(),
		var_defaults.dup()])
}

fn (mut this Class_WP_Upgrader_Skin) set_upgrader(var_upgrader rt.PhpVal) {
	if rt.is_true(rt.new_bool(var_upgrader.dup().is_object())) {
		// unsupported expression: Expr_AssignRef
	}
	this.add_strings()
}

fn (mut this Class_WP_Upgrader_Skin) add_strings() {
}

fn (mut this Class_WP_Upgrader_Skin) set_result(var_result rt.PhpVal) {
	this.result = var_result.dup()
}

fn (mut this Class_WP_Upgrader_Skin) request_filesystem_credentials(error bool, context string, allow_relaxed_file_ownership bool) rt.PhpVal {
	mut context_mutated := context
	mut var_url := this.options.array_get('url')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(context_mutated))))) {
		context_mutated = (this.options.array_get('context')).str()
	}
	if !(!rt.is_true(this.options.array_get('nonce'))) {
		var_url = rt.call_function('wp_nonce_url', [var_url.dup(),
			this.options.array_get('nonce')])
	}
	mut var_extra_fields := rt.new_array()
	return rt.call_function('request_filesystem_credentials', [
		var_url.dup(), rt.new_string(''), rt.new_bool(error),
		rt.new_string(context_mutated).dup(), var_extra_fields.dup(),
		rt.new_bool(allow_relaxed_file_ownership)])
}

fn (mut this Class_WP_Upgrader_Skin) header() {
	if rt.is_true(this.done_header) {
		return rt.new_null()
	}
	this.done_header = true
	print('<div class="wrap">')
	print('<h1>' + (this.options.array_get('title')).str() + '</h1>')
}

fn (mut this Class_WP_Upgrader_Skin) footer() {
	if rt.is_true(this.done_footer) {
		return rt.new_null()
	}
	this.done_footer = true
	print('</div>')
}

fn (mut this Class_WP_Upgrader_Skin) error(var_errors rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.done_header)))) {
		this.header()
	}
	if rt.is_true(rt.new_bool(var_errors.dup().is_string())) {
		this.feedback(var_errors.dup(), rt.new_null())
	} else if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('is_wp_error', [var_errors.dup()]))
		&& rt.is_true(rt.call_method(var_errors, 'has_errors', []rt.PhpVal{}))))
	{
		{
			mut iter_1 := rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_message := item_1.val
				if rt.is_true(rt.new_bool(
					rt.is_true(rt.call_method(var_errors, 'get_error_data', []rt.PhpVal{}))
					&& rt.is_true(rt.new_bool(rt.call_method(var_errors, 'get_error_data', []rt.PhpVal{}).is_string()))))
				{
					this.feedback(rt.new_string(var_message.str() + ' ' +(rt.call_function('esc_html', [rt.call_function('strip_tags', [rt.call_method(var_errors, 'get_error_data', []rt.PhpVal{})])])).str()),
						rt.new_null())
				} else {
					this.feedback(var_message.dup(), rt.new_null())
				}
			}
		}
	}
}

fn (mut this Class_WP_Upgrader_Skin) feedback(var_feedback rt.PhpVal, var_args rt.PhpVal) {
	mut var_feedback_mutated := var_feedback
	mut var_args_mutated := var_args
	if rt.get_property(this.upgrader, 'strings').array_isset(var_feedback_mutated) {
		var_feedback_mutated =
			rt.get_property(this.upgrader, 'strings').array_get(var_feedback_mutated)
	}
	if rt.is_true(rt.call_function('str_contains', [var_feedback_mutated.dup(),
		rt.new_string('%')]))
	{
		if rt.is_true(var_args_mutated) {
			var_args_mutated = rt.call_function('array_map', [
				rt.new_string('strip_tags'),
				var_args_mutated.dup(),
			])
			var_args_mutated = rt.call_function('array_map', [
				rt.new_string('esc_html'), var_args_mutated.dup()])
			var_feedback_mutated = rt.call_function('vsprintf', [
				var_feedback_mutated.dup(), var_args_mutated.dup()])
		}
	}
	if !rt.is_true(var_feedback_mutated) {
		return rt.new_null()
	}
	rt.call_function('show_message', [var_feedback_mutated.dup()])
}

fn (mut this Class_WP_Upgrader_Skin) before() {
}

fn (mut this Class_WP_Upgrader_Skin) after() {
}

fn (mut this Class_WP_Upgrader_Skin) decrement_update_count(var_type rt.PhpVal) {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.result))))
		|| rt.is_true(rt.call_function('is_wp_error', [this.result]))))
		|| rt.is_true(rt.identical(rt.new_string('up_to_date'), this.result))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('IFRAME_REQUEST')])) {
		print(
			'<script>\n\t\t\t\t\tif ( window.postMessage && JSON ) {\n\t\t\t\t\t\twindow.parent.postMessage(\n\t\t\t\t\t\t\tJSON.stringify( {\n\t\t\t\t\t\t\t\taction: "decrementUpdateCount",\n\t\t\t\t\t\t\t\tupgradeType: "' +
			var_type.str() + '"\n\t\t\t\t\t\t\t} ),\n\t\t\t\t\t\t\twindow.location.protocol + "//" +
			window.location.hostname\n\t\t\t\t\t\t\t\t+ ( "" !== window.location.port ? ":" + window.location.port : "" )\n\t\t\t\t\t\t);\n\t\t\t\t\t}\n\t\t\t\t</script>')
	} else {
		print(
			'<script>\n\t\t\t\t\t(function( wp ) {\n\t\t\t\t\t\tif ( wp && wp.updates && wp.updates.decrementCount ) {\n\t\t\t\t\t\t\twp.updates.decrementCount( "' +
			var_type.str() + '" );\n\t\t\t\t\t\t}\n\t\t\t\t\t})( window.wp );\n\t\t\t\t</script>')
	}
}

fn (mut this Class_WP_Upgrader_Skin) bulk_header() {
}

fn (mut this Class_WP_Upgrader_Skin) bulk_footer() {
}

fn (mut this Class_WP_Upgrader_Skin) hide_process_failed(var_wp_error rt.PhpVal) bool {
	return false
}

fn create_wp_upgrader_skin(arg_0 rt.PhpVal) &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
		upgrader:      rt.new_null()
		done_header:   false
		done_footer:   false
		result:        rt.new_bool(false)
		options:       rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'set_upgrader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_upgrader(dispatch_arg_0)
			return rt.new_null()
		}
		'add_strings' {
			this.add_strings()
			return rt.new_null()
		}
		'set_result' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_result(dispatch_arg_0)
			return rt.new_null()
		}
		'request_filesystem_credentials' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.request_filesystem_credentials(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'header' {
			this.header()
			return rt.new_null()
		}
		'footer' {
			this.footer()
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.error(dispatch_arg_0)
			return rt.new_null()
		}
		'feedback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.feedback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'before' {
			this.before()
			return rt.new_null()
		}
		'after' {
			this.after()
			return rt.new_null()
		}
		'decrement_update_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.decrement_update_count(dispatch_arg_0)
			return rt.new_null()
		}
		'bulk_header' {
			this.bulk_header()
			return rt.new_null()
		}
		'bulk_footer' {
			this.bulk_footer()
			return rt.new_null()
		}
		'hide_process_failed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.hide_process_failed(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'upgrader' { return this.upgrader }
		'done_header' { return rt.new_bool(this.done_header) }
		'done_footer' { return rt.new_bool(this.done_footer) }
		'result' { return this.result }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'upgrader' {
			this.upgrader = val
			return true
		}
		'done_header' {
			this.done_header = val.to_bool()
			return true
		}
		'done_footer' {
			this.done_footer = val.to_bool()
			return true
		}
		'result' {
			this.result = val
			return true
		}
		'options' {
			this.options = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_admin_includes_class_wp_upgrader_skin_php() {
}
