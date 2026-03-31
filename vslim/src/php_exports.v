module main

import vphp

@[php_function]
@[php_optional_args: 'raw_path,body']
fn vslim_handle_request(method_or_envelope vphp.BorrowedValue, raw_path string, body string) vphp.Value {
	mut res := VSlimResponse{}
	raw := method_or_envelope.to_zval()
	if raw.is_string() {
		res = dispatch_demo_request(new_vslim_request(raw.to_string(), raw_path, body).to_vslim_request())
	} else {
		res = dispatch_demo_request(request_from_envelope(raw))
	}
	return vphp.Value.from_zval(vphp.new_zval_from[map[string]string]({
		'status': '${res.status}'
		'body': res.body
		'content_type': res.content_type
	}) or {
		vphp.ZVal.new_null()
	})
}

@[php_function]
@[php_optional_args: 'raw_path,body']
fn vslim_demo_dispatch(method_or_envelope vphp.BorrowedValue, raw_path string, body string) vphp.Value {
	return vslim_handle_request(method_or_envelope, raw_path, body)
}

@[php_function]
fn vslim_response_headers(ctx vphp.Context) {
	raw := ctx.arg_raw(0)
	if !raw.is_valid() || !raw.is_object() {
		ctx.return_map(map[string]string{})
		return
	}
	if resp := raw.to_object[VSlimResponse]() {
		ctx.return_val(resp.headers())
		return
	}
	ctx.return_map(map[string]string{})
}
