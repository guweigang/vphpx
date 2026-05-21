module sessionx

import vphp

pub fn is_auth_user_provider(provider vphp.PhpValue) bool {
	if !provider.is_valid() {
		return false
	}
	if provider.is_callable() {
		return true
	}
	return provider.with_object[bool](fn (object vphp.PhpObject) bool {
		return object.method_exists('findById') || object.method_exists('resolve')
	}) or { false }
}

pub fn resolve_auth_user(resolver vphp.PhpValue, user_id string) vphp.PhpValue {
	normalized_id := user_id.trim_space()
	if normalized_id == '' {
		return vphp.PhpValue.null()
	}
	if !resolver.is_valid() {
		return vphp.PhpString.of(normalized_id).take_value()
	}
	mut normalized_id_arg := vphp.PhpString.of(normalized_id)
	defer {
		normalized_id_arg.release()
	}
	if result := resolver.with_callable[vphp.PhpValue](fn [normalized_id_arg] (callable vphp.PhpCallable) vphp.PhpValue {
		return callable.invoke(normalized_id_arg)
	})
	{
		return result
	}
	if result := resolver.with_object[vphp.PhpValue](fn [normalized_id_arg, normalized_id] (provider vphp.PhpObject) vphp.PhpValue {
		return resolve_auth_user_from_object(provider, normalized_id_arg, normalized_id)
	})
	{
		return result
	}
	return vphp.PhpString.of(normalized_id).take_value()
}

fn resolve_auth_user_from_object(provider vphp.PhpObject, normalized_id_arg vphp.PhpString, normalized_id string) vphp.PhpValue {
	if provider.method_exists('findById') {
		return provider.call_method('findById', normalized_id_arg)
	}
	if provider.method_exists('resolve') {
		return provider.call_method('resolve', normalized_id_arg)
	}
	return vphp.PhpString.of(normalized_id).take_value()
}
