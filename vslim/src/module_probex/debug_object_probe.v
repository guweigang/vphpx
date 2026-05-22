module module_probex

import httpx
import vphp

fn probe_object_info(obj vphp.PhpObject, class_name string, method_name string) vphp.PhpValue {
	mut out := vphp.PhpArray.empty()
	if !obj.is_valid() {
		out.string('is_object', 'false')
		return out.take_value()
	}
	mut class_arg := vphp.PhpString.of(class_name)
	mut autoload_arg := vphp.PhpBool.of(true)
	mut method_arg := vphp.PhpString.of(method_name)
	defer {
		class_arg.release()
		autoload_arg.release()
		method_arg.release()
	}
	out.string('is_object', 'true')
	out.string('class', obj.class_name())
	out.string('is_instance_of', obj.is_instance_of(class_name).str())
	out.string('is_subclass_of', obj.is_subclass_of(class_name).str())
	out.string('method_exists', obj.method_exists(method_name).str())
	out.string('php_is_a',
		vphp.PhpFunction.named('is_a').result_bool(obj, class_arg, autoload_arg).str())
	out.string('php_method_exists', vphp.PhpFunction.named('method_exists').result_bool(obj,
		method_arg).str())
	return out.take_value()
}

@[php_arg_name: 'class_name=className,method_name=methodName']
@[php_method]
pub fn VSlimDebugObjectProbe.probe(obj vphp.PhpObject, class_name string, method_name string) vphp.PhpValue {
	return probe_object_info(obj, class_name, method_name)
}

@[php_method: 'psr7LifecycleCounters']
pub fn VSlimDebugObjectProbe.psr7_lifecycle_counters(rounds int) string {
	total_rounds := if rounds <= 0 { 1 } else { rounds }
	before := vphp.runtime_counters()
	mut scope := vphp.PhpScope.request()
	mut server_params := vphp.PhpArray.empty()
	server_params.string('REQUEST_METHOD', 'POST')
	mut req := httpx.VSlimPsr7ServerRequest.from_string('POST', '/debug/lifecycle?probe=1',
		server_params)
	server_params.release()
	mut checksum := 0
	for i in 0 .. total_rounds {
		mut parsed := vphp.PhpArray.empty()
		parsed.string('message', 'hello-${i}')
		parsed.int('round', i)
		mut tags := vphp.PhpArray.empty()
		tags.push_string('alpha')
		tags.push_string('beta')
		parsed.set('tags', tags)
		tags.release()
		req = req.with_parsed_body(parsed.to_borrowed().to_value())

		mut attr_name := vphp.PhpString.of('studio.payload')
		req = req.with_attribute(attr_name.to_borrowed().to_value(),
			parsed.to_borrowed().to_value())
		attr_name.release()
		parsed.release()

		mut attrs := req.get_attributes()
		checksum += attrs.count()
		attrs.release()
		mut parsed_copy := req.get_parsed_body()
		if parsed_array := parsed_copy.as_array() {
			checksum += parsed_array.count()
			parsed_array.release()
		}
		parsed_copy.release()
	}
	scope.close()
	after := vphp.runtime_counters()
	return 'rounds=${total_rounds};checksum=${checksum};autorelease_delta=${after.autorelease_len - before.autorelease_len};owned_delta=${after.owned_len - before.owned_len};fallback_delta=${after.persistent_fallback_zval_len - before.persistent_fallback_zval_len}'
}
