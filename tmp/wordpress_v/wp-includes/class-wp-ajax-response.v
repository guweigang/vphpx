import rt

struct Class_WP_Ajax_Response {
	rt.PhpObjectBase
pub mut:
	responses rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Ajax_Response) construct(args string) {
	if !(args == '') {
		this.add(args)
	}
}

fn (mut this Class_WP_Ajax_Response) add(args string) rt.PhpVal {
	mut var_defaults := {
		'what':         rt.new_string('object')
		'action':       rt.new_bool(false)
		'id':           rt.new_string('0')
		'old_id':       rt.new_bool(false)
		'position':     rt.new_int(1)
		'data':         rt.new_string('')
		'supplemental': map[string]rt.PhpVal{}
	}
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		rt.new_string(args), var_defaults.dup()])
	mut var_position := rt.call_function('preg_replace', [
		rt.new_string('/[^a-z0-9:_-]/i'),
		rt.new_string(''),
		var_parsed_args.array_get('position'),
	])
	mut var_id := var_parsed_args.array_get('id')
	mut var_what := var_parsed_args.array_get('what')
	mut var_action := var_parsed_args.array_get('action')
	mut var_old_id := var_parsed_args.array_get('old_id')
	mut var_data := var_parsed_args.array_get('data')
	if rt.is_true(rt.call_function('is_wp_error', [var_id.dup()])) {
		var_data = var_id.dup()
		var_id = rt.new_int(rt.new_int(0))
	}
	mut var_response := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
		{
			mut iter_1 :=
				rt.cast_array(rt.call_method(var_data, 'get_error_codes', []rt.PhpVal{})).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_code := item_1.val
				// unsupported expression: Expr_AssignOp_Concat
				mut var_error_data := rt.call_method(var_data, 'get_error_data', [
					var_code.dup(),
				])
				if rt.is_true(rt.new_bool(!(rt.is_true(var_error_data)))) {
					continue
				}
				mut var_class := rt.new_string(rt.new_string(''))
				if rt.is_true(rt.new_bool(var_error_data.dup().is_object())) {
					var_class = rt.new_string(' class="' +
						(rt.call_function('get_class', [var_error_data.dup()])).str() + '"')
					var_error_data = rt.call_function('get_object_vars', [
						var_error_data.dup()])
				}
				// unsupported expression: Expr_AssignOp_Concat
				if rt.is_true(rt.call_function('is_scalar', [
					var_error_data.dup()]))
				{
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.new_bool(var_error_data.dup().is_array())) {
					{
						mut iter_2 := var_error_data.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_v := item_2.val
							mut var_k := item_2.key
							// unsupported expression: Expr_AssignOp_Concat
						}
					}
				}
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
	} else {
		var_response =
			rt.new_string(rt.new_string('<response_data><![CDATA[${var_data.to_string()}]]></response_data>'))
	}
	mut var_s := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(var_parsed_args.array_get('supplemental').is_array())) {
		{
			mut iter_1 := var_parsed_args.array_get('supplemental').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_v := item_1.val
				mut var_k := item_1.key
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		var_s = rt.new_string(rt.new_string('<supplemental>${var_s.to_string()}</supplemental>'))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_action)) {
		var_action = rt.get_superglobal('_POST').array_get('action')
	}
	mut var_x := rt.new_string(rt.new_string(''))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	this.responses.array_push(var_x.dup())
	return var_x.dup()
}

fn (mut this Class_WP_Ajax_Response) send() {
	rt.call_function('header', [
		'Content-Type: text/xml; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str(),
	])
	print("<?xml version='1.0' encoding='" +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() +
		"' standalone='yes'?><wp_ajax>")
	{
		mut iter_1 := rt.cast_array(this.responses).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_response := item_1.val
			rt.echo_val(var_response)
		}
	}
	print('</wp_ajax>')
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		rt.call_function('wp_die', []rt.PhpVal{})
	} else {
		// unsupported expression: Expr_Exit
	}
}

fn create_wp_ajax_response(args string) &Class_WP_Ajax_Response {
	mut obj := &Class_WP_Ajax_Response{
		PhpObjectBase: rt.PhpObjectBase{}
		responses:     rt.new_array()
	}
	obj.construct(args)
	return obj
}

fn (mut this Class_WP_Ajax_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'add' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.add(dispatch_arg_0)
		}
		'send' {
			this.send()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Ajax_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'responses' { return this.responses }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Ajax_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'responses' {
			this.responses = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_class_wp_ajax_response_php() {
}
