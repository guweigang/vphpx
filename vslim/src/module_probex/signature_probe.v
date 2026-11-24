module module_probex

import eventx
import httpx
import streamx
import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn (mut probe VSlimPhpSignatureProbe) construct() &VSlimPhpSignatureProbe {
	return &probe
}

@[vphp.PhpExportMethod(name: 'cloneWithProperties')]
@[vphp.PhpMethodSince(version: .php85)]
pub fn (probe &VSlimPhpSignatureProbe) clone_with_properties(object vphp.PhpObject, properties vphp.PhpArray) !vphp.PhpObject {
	return object.clone_with(properties)
}

@[vphp.PhpExportMethod(name: 'alwaysTrue')]
@[vphp.PhpReturnType(php_type: 'true')]
pub fn (probe &VSlimPhpSignatureProbe) always_true() bool {
	return true
}

@[vphp.PhpExportMethod(name: 'alwaysFalse')]
@[vphp.PhpReturnType(php_type: 'false')]
pub fn (probe &VSlimPhpSignatureProbe) always_false() bool {
	return false
}

@[vphp.PhpExportMethod(name: 'alwaysNull')]
@[vphp.PhpReturnType(php_type: 'null')]
pub fn (probe &VSlimPhpSignatureProbe) always_null() vphp.PhpNull {
	return vphp.PhpNull.value()
}

@[vphp.PhpExportMethod(name: 'alwaysThrow')]
@[vphp.PhpReturnType(php_type: 'never')]
pub fn (probe &VSlimPhpSignatureProbe) always_throw() vphp.PhpNull {
	vphp.PhpException.raise_class('RuntimeException', 'probe never return', 0)
	return vphp.PhpNull.value()
}

@[vphp.PhpExportMethod(name: 'acceptTrue')]
@[vphp.PhpArgType(v_name: 'flag', php_type: 'true')]
pub fn (probe &VSlimPhpSignatureProbe) accept_true(flag vphp.PhpBool) bool {
	return flag.value()
}

@[vphp.PhpExportMethod(name: 'acceptFalse')]
@[vphp.PhpArgType(v_name: 'flag', php_type: 'false')]
pub fn (probe &VSlimPhpSignatureProbe) accept_false(flag vphp.PhpBool) bool {
	return !flag.value()
}

@[vphp.PhpArgType(v_name: 'value', php_type: 'null')]
@[vphp.PhpExportMethod(name: 'acceptNull')]
pub fn (probe &VSlimPhpSignatureProbe) accept_null(value vphp.PhpNull) bool {
	return value.is_null()
}

@[vphp.PhpExportMethod(name: 'acceptCallable')]
@[vphp.PhpArgType(v_name: 'cb', php_type: 'callable')]
pub fn (probe &VSlimPhpSignatureProbe) accept_callable(cb vphp.PhpCallable) bool {
	return cb.is_callable()
}

@[vphp.PhpExportMethod(name: 'optionalTail')]
@[vphp.PhpStringParam('suffix', php_name: 'suffix', default_value: '', optional: true)]
pub fn (probe &VSlimPhpSignatureProbe) optional_tail(prefix string, suffix string) string {
	if suffix == '' {
		return prefix
	}
	return '${prefix}:${suffix}'
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'makePsrResponse')]
pub fn (probe &VSlimPhpSignatureProbe) make_psr_response() &httpx.VSlimPsr7Response {
	return &httpx.VSlimPsr7Response{
		status:           204
		reason_phrase:    'No Content'
		protocol_version: '1.1'
		headers:          map[string][]string{}
		header_names:     map[string]string{}
		body_ref:         httpx.VSlimPsr7Stream.from_content('')
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'makeStaticPsrResponse')]
pub fn VSlimPhpSignatureProbe.make_static_psr_response() &httpx.VSlimPsr7Response {
	return &httpx.VSlimPsr7Response{
		status:           202
		reason_phrase:    'Accepted'
		protocol_version: '1.1'
		headers:          map[string][]string{}
		header_names:     map[string]string{}
		body_ref:         httpx.VSlimPsr7Stream.from_content('')
	}
}

@[params]
pub struct ProbeResponseOptions {
pub:
	enabled  bool                      = true
	response ?&httpx.VSlimPsr7Response = none
}

@[vphp.PhpExportMethod(name: 'makeFixedStatusCallback')]
pub fn (probe &VSlimPhpSignatureProbe) make_fixed_status_callback() fn (response &httpx.VSlimPsr7Response, adjustment ?int) int {
	return fn (response &httpx.VSlimPsr7Response, adjustment ?int) int {
		return response.get_status_code() + (adjustment or { 0 })
	}
}

@[vphp.PhpExportMethod(name: 'makeAdjustedStatusCallback')]
pub fn (probe &VSlimPhpSignatureProbe) make_adjusted_status_callback() fn (response &httpx.VSlimPsr7Response, offsets ...int) int {
	return fn (response &httpx.VSlimPsr7Response, offsets ...int) int {
		mut status := response.get_status_code()
		for offset in offsets {
			status += offset
		}
		return status
	}
}

@[vphp.PhpExportMethod(name: 'makeResponseStatusCallback')]
pub fn (probe &VSlimPhpSignatureProbe) make_response_status_callback() fn (ProbeResponseOptions) ?int {
	return fn (options ProbeResponseOptions) ?int {
		if !options.enabled {
			return none
		}
		if response := options.response {
			return response.get_status_code()
		}
		return 202
	}
}

@[vphp.PhpExportMethod(name: 'makePsrResponseCallback')]
pub fn (probe &VSlimPhpSignatureProbe) make_psr_response_callback() fn (ProbeResponseOptions) ?&httpx.VSlimPsr7Response {
	return fn (options ProbeResponseOptions) ?&httpx.VSlimPsr7Response {
		if !options.enabled {
			return none
		}
		return options.response or { VSlimPhpSignatureProbe.make_static_psr_response() }
	}
}

@[vphp.PhpExportMethod(name: 'makePsrResponseSelector')]
@[vphp.PhpBorrowedReturn]
pub fn (probe &VSlimPhpSignatureProbe) make_psr_response_selector() fn (...?&httpx.VSlimPsr7Response) ?&httpx.VSlimPsr7Response {
	return fn (responses ...?&httpx.VSlimPsr7Response) ?&httpx.VSlimPsr7Response {
		for response in responses {
			if item := response {
				return item
			}
		}
		return none
	}
}

@[vphp.PhpExportMethod(name: 'acceptPsrRequest')]
pub fn (probe &VSlimPhpSignatureProbe) accept_psr_request(request httpx.PsrRequest) bool {
	return request.to_object().is_valid()
}

@[vphp.PhpExportMethod(name: 'selectLastPsrRequest')]
pub fn (probe &VSlimPhpSignatureProbe) select_last_psr_request(fallback httpx.PsrRequest, alternatives ...httpx.PsrRequest) httpx.PsrRequest {
	return if alternatives.len == 0 { fallback } else { alternatives.last() }
}

@[vphp.PhpExportMethod(name: 'namedPsrRequests')]
@[vphp.PhpArgType(v_name: 'requests', php_type: 'Psr\\Http\\Message\\RequestInterface')]
pub fn (probe &VSlimPhpSignatureProbe) named_psr_requests(requests ...vphp.PhpArg) vphp.PhpArray {
	return collect_named_request_arguments(requests)
}

@[vphp.PhpExportMethod(name: 'makeNamedRequestCollector')]
pub fn (probe &VSlimPhpSignatureProbe) make_named_request_collector() fn (requests ...vphp.PhpArg) vphp.PhpArray {
	return fn (requests ...vphp.PhpArg) vphp.PhpArray {
		return collect_named_request_arguments(requests)
	}
}

@[vphp.PhpExportMethod(name: 'forwardCallbackArguments')]
pub fn (probe &VSlimPhpSignatureProbe) forward_callback_arguments(callback vphp.PhpCallable, arguments ...vphp.PhpArg) vphp.PhpValue {
	return callback.invoke_forwarded(arguments)
}

@[vphp.PhpExportMethod(name: 'recoverCallback')]
pub fn (probe &VSlimPhpSignatureProbe) recover_callback(callback vphp.PhpCallable, recover vphp.PhpCallable) vphp.PhpValue {
	mut result := callback.invoke()
	if mut exception := vphp.PhpException.take_current() {
		result.release()
		defer {
			exception.release()
		}
		return recover.invoke(exception)
	}
	return result
}

@[vphp.PhpExportMethod(name: 'echoThrowable')]
pub fn (probe &VSlimPhpSignatureProbe) echo_throwable(value ?vphp.PhpThrowable) ?vphp.PhpThrowable {
	return value
}

@[vphp.PhpExportMethod(name: 'echoEnumCase')]
pub fn (probe &VSlimPhpSignatureProbe) echo_enum_case(value ?vphp.PhpEnumCase) ?vphp.PhpEnumCase {
	return value
}

@[vphp.PhpExportMethod(name: 'echoStreamFactory')]
pub fn (probe &VSlimPhpSignatureProbe) echo_stream_factory(value ?vphp.PhpInterface[streamx.VStreamResponseFactory]) ?vphp.PhpInterface[streamx.VStreamResponseFactory] {
	return value
}

@[vphp.PhpExportMethod(name: 'makeStreamFactoryCallback')]
pub fn (probe &VSlimPhpSignatureProbe) make_stream_factory_callback() fn (value ?vphp.PhpInterface[streamx.VStreamResponseFactory]) ?vphp.PhpInterface[streamx.VStreamResponseFactory] {
	return fn (value ?vphp.PhpInterface[streamx.VStreamResponseFactory]) ?vphp.PhpInterface[streamx.VStreamResponseFactory] {
		return value
	}
}

fn collect_named_request_arguments(requests []vphp.PhpArg) vphp.PhpArray {
	mut result := vphp.PhpArray.new()
	for request in requests {
		if name := request.variadic_name() {
			result.set_value(name, request.value)
		} else {
			result.next(request.value)
		}
	}
	return result
}

@[vphp.PhpArgType(v_name: 'expiration', php_type: '?DateTimeInterface')]
@[vphp.PhpExportMethod(name: 'acceptDateTimeInterface')]
pub fn (probe &VSlimPhpSignatureProbe) accept_datetime_interface(expiration vphp.PhpValue) bool {
	return expiration.is_null() || expiration.is_instance_of('DateTimeInterface')
}

@[vphp.PhpArgType(v_name: 'provider', php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'setProvider')]
pub fn (mut probe VSlimPhpSignatureProbe) set_provider(provider &eventx.VSlimPsr14ListenerProvider) &VSlimPhpSignatureProbe {
	probe.provider_ref = provider
	return &probe
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProvider')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider() &eventx.VSlimPsr14ListenerProvider {
	return probe.provider_ref
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderAlias')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_alias() &eventx.VSlimPsr14ListenerProvider {
	provider := probe.borrowed_provider()
	return provider
}

fn (probe &VSlimPhpSignatureProbe) maybe_borrowed_provider() ?&eventx.VSlimPsr14ListenerProvider {
	if isnil(probe.provider_ref) {
		return none
	}
	return probe.provider_ref
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderFromGuard')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_guard() &eventx.VSlimPsr14ListenerProvider {
	if provider := probe.maybe_borrowed_provider() {
		return provider
	}
	return probe.provider_ref
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderFromIfExpr')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_if_expr(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	return if use_alias {
		provider := probe.borrowed_provider()
		provider
	} else {
		probe.provider_ref
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderFromIfExprAlias')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_if_expr_alias(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	provider := if use_alias {
		probe.borrowed_provider()
	} else {
		probe.provider_ref
	}
	return provider
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderFromMatchExpr')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_match_expr(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	return match use_alias {
		true {
			provider := probe.borrowed_provider()
			provider
		}
		false {
			probe.provider_ref
		}
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderFromMatchExprAlias')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_match_expr_alias(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	provider := match use_alias {
		true {
			probe.borrowed_provider()
		}
		false {
			probe.provider_ref
		}
	}

	return provider
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderFromOrBlock')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_or_block() &eventx.VSlimPsr14ListenerProvider {
	return probe.maybe_borrowed_provider() or { probe.provider_ref }
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'borrowedProviderFromOrBlockAlias')]
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_or_block_alias() &eventx.VSlimPsr14ListenerProvider {
	provider := probe.maybe_borrowed_provider() or { probe.provider_ref }
	return provider
}

fn new_signature_probe_provider() &eventx.VSlimPsr14ListenerProvider {
	mut provider := &eventx.VSlimPsr14ListenerProvider{}
	provider.construct()
	return provider
}

fn (probe &VSlimPhpSignatureProbe) maybe_fresh_provider() ?&eventx.VSlimPsr14ListenerProvider {
	if isnil(probe.provider_ref) {
		return none
	}
	return new_signature_probe_provider()
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProvider')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider() &eventx.VSlimPsr14ListenerProvider {
	return new_signature_probe_provider()
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProviderAlias')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_alias() &eventx.VSlimPsr14ListenerProvider {
	provider := new_signature_probe_provider()
	return provider
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProviderFromIfExpr')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_if_expr(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	return if use_alias {
		provider := new_signature_probe_provider()
		provider
	} else {
		new_signature_probe_provider()
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProviderFromIfExprAlias')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_if_expr_alias(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	provider := if use_alias {
		new_signature_probe_provider()
	} else {
		new_signature_probe_provider()
	}
	return provider
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProviderFromMatchExpr')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_match_expr(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	return match use_alias {
		true {
			provider := new_signature_probe_provider()
			provider
		}
		false {
			new_signature_probe_provider()
		}
	}
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProviderFromMatchExprAlias')]
@[vphp.PhpArgName(v_name: 'use_alias', php_name: 'useAlias')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_match_expr_alias(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	provider := match use_alias {
		true {
			new_signature_probe_provider()
		}
		false {
			new_signature_probe_provider()
		}
	}

	return provider
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProviderFromOrBlock')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_or_block() &eventx.VSlimPsr14ListenerProvider {
	return probe.maybe_fresh_provider() or { new_signature_probe_provider() }
}

@[vphp.PhpReturnType(php_type: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportMethod(name: 'freshProviderFromOrBlockAlias')]
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_or_block_alias() &eventx.VSlimPsr14ListenerProvider {
	provider := probe.maybe_fresh_provider() or { new_signature_probe_provider() }
	return provider
}
