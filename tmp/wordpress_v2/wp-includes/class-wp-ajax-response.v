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
		rt.new_string(args), rt.create_array_from_native_map(var_defaults)])
	mut var_position := rt.call_function('preg_replace', [
		rt.new_string('/[^a-z0-9:_-]/i'),
		rt.new_string(''),
		var_parsed_args.array_get(rt.new_string('position')),
	])
	mut var_id := var_parsed_args.array_get(rt.new_string('id'))
	mut var_what := var_parsed_args.array_get(rt.new_string('what'))
	mut var_action := var_parsed_args.array_get(rt.new_string('action'))
	mut var_old_id := var_parsed_args.array_get(rt.new_string('old_id'))
	mut var_data := var_parsed_args.array_get(rt.new_string('data'))
	if rt.is_true(rt.call_function('is_wp_error', [var_id.clone()])) {
		var_data = var_id.clone()
		var_id = rt.new_int(0)
	}
	mut var_response := rt.new_string('')
	if rt.is_true(rt.call_function('is_wp_error', [var_data.clone()])) {
		mut iter_1 :=
			rt.cast_array(rt.call_method(var_data, 'get_error_codes', []rt.PhpVal{})).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_code := item_1.val
			var_response = rt.concat(var_response, rt.new_string(
				"<wp_error code='${var_code.to_string()}'><![CDATA[" +
				(rt.call_method(var_data, 'get_error_message', [var_code.clone()])).str() +
				']]></wp_error>'))
			mut var_error_data := rt.call_method(var_data, 'get_error_data', [
				var_code.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_error_data)))) {
				continue
			}
			mut var_class := rt.new_string('')
			if rt.is_true(rt.new_bool(var_error_data.clone().is_object())) {
				var_class = rt.new_string(' class="' +
					(rt.call_function('get_class', [var_error_data.clone()])).str() + '"')
				var_error_data = rt.call_function('get_object_vars', [
					var_error_data.clone()])
			}
			var_response = rt.concat(var_response,
				rt.new_string("<wp_error_data code='${var_code.to_string()}'${var_class.to_string()}>"))
			if rt.is_true(rt.call_function('is_scalar', [var_error_data.clone()])) {
				var_response = rt.concat(var_response,
					rt.new_string('<![CDATA[${var_error_data.to_string()}]]>'))
			} else if rt.is_true(rt.new_bool(var_error_data.clone().is_array())) {
				mut iter_2 := var_error_data.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_v := item_2.val
					mut var_k := item_2.key
					var_response = rt.concat(var_response,
						rt.new_string('<${var_k.to_string()}><![CDATA[${var_v.to_string()}]]></${var_k.to_string()}>'))
				}
			}
			var_response = rt.concat(var_response, rt.new_string('</wp_error_data>'))
		}
	} else {
		var_response =
			rt.new_string('<response_data><![CDATA[${var_data.to_string()}]]></response_data>')
	}
	mut var_s := rt.new_string('')
	if rt.is_true(rt.new_bool(var_parsed_args.array_get(rt.new_string('supplemental')).is_array())) {
		mut iter_3 := var_parsed_args.array_get(rt.new_string('supplemental')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_v := item_3.val
			mut var_k := item_3.key
			var_s = rt.concat(var_s,
				rt.new_string('<${var_k.to_string()}><![CDATA[${var_v.to_string()}]]></${var_k.to_string()}>'))
		}
		var_s = rt.new_string('<supplemental>${var_s.to_string()}</supplemental>')
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_action)) {
		var_action = rt.get_superglobal('_POST').array_get(rt.new_string('action'))
	}
	mut var_x := rt.new_string('')
	var_x = rt.concat(var_x,
		rt.new_string("<response action='${var_action.to_string()}_${var_id.to_string()}'>"))
	var_x = rt.concat(var_x, rt.new_string("<${var_what.to_string()} id='${var_id.to_string()}' " +
		if rt.is_true(rt.identical(rt.new_bool(false), var_old_id)) { '' } else { "old_id='${var_old_id.to_string()}' " } +
		"position='${var_position.to_string()}'>"))
	var_x = rt.concat(var_x, var_response)
	var_x = rt.concat(var_x, var_s)
	var_x = rt.concat(var_x, rt.new_string('</${var_what.to_string()}>'))
	var_x = rt.concat(var_x, rt.new_string('</response>'))
	this.responses.array_push(var_x.clone())
	return var_x.clone()
}

fn (mut this Class_WP_Ajax_Response) send() {
	rt.call_function('header', [
		rt.new_string('Content-Type: text/xml; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
	])
	print("<?xml version='1.0' encoding='" +
		(rt.call_function('get_option', [rt.new_string('blog_charset')])).str() +
		"' standalone='yes'?><wp_ajax>")
	mut iter_4 := rt.cast_array(this.responses).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_response := item_4.val
		rt.echo_val(var_response)
	}
	print('</wp_ajax>')
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		rt.call_function('wp_die', []rt.PhpVal{})
	} else {
		exit(0)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
