module module_probex

import eventx
import httpx
import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn (mut probe VSlimPhpSignatureProbe) construct() &VSlimPhpSignatureProbe {
	return &probe
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

@[vphp.PhpArgType(v_name: 'request', php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'acceptPsrRequest')]
pub fn (probe &VSlimPhpSignatureProbe) accept_psr_request(request vphp.PhpObject) bool {
	return request.is_instance_of('Psr\\Http\\Message\\RequestInterface')
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
