module module_probex

import eventx
import httpx
import vphp

@[php_method]
pub fn (mut probe VSlimPhpSignatureProbe) construct() &VSlimPhpSignatureProbe {
	return &probe
}

@[php_method: 'alwaysTrue']
@[php_return_type: 'true']
pub fn (probe &VSlimPhpSignatureProbe) always_true() bool {
	return true
}

@[php_method: 'alwaysFalse']
@[php_return_type: 'false']
pub fn (probe &VSlimPhpSignatureProbe) always_false() bool {
	return false
}

@[php_method: 'alwaysNull']
@[php_return_type: 'null']
pub fn (probe &VSlimPhpSignatureProbe) always_null() vphp.PhpNull {
	return vphp.PhpNull.value()
}

@[php_method: 'alwaysThrow']
@[php_return_type: 'never']
pub fn (probe &VSlimPhpSignatureProbe) always_throw() vphp.PhpNull {
	vphp.PhpException.raise_class('RuntimeException', 'probe never return', 0)
	return vphp.PhpNull.value()
}

@[php_method: 'acceptTrue']
@[php_arg_type: 'flag=true']
pub fn (probe &VSlimPhpSignatureProbe) accept_true(flag vphp.PhpBool) bool {
	return flag.value()
}

@[php_method: 'acceptFalse']
@[php_arg_type: 'flag=false']
pub fn (probe &VSlimPhpSignatureProbe) accept_false(flag vphp.PhpBool) bool {
	return !flag.value()
}

@[php_arg_type: 'value=null']
@[php_method: 'acceptNull']
pub fn (probe &VSlimPhpSignatureProbe) accept_null(value vphp.PhpNull) bool {
	return value.is_null()
}

@[php_method: 'acceptCallable']
@[php_arg_type: 'cb=callable']
pub fn (probe &VSlimPhpSignatureProbe) accept_callable(cb vphp.PhpCallable) bool {
	return cb.is_callable()
}

@[php_method: 'optionalTail']
@[php_arg_default: 'suffix=""']
@[php_arg_optional: 'suffix']
pub fn (probe &VSlimPhpSignatureProbe) optional_tail(prefix string, suffix string) string {
	if suffix == '' {
		return prefix
	}
	return '${prefix}:${suffix}'
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'makePsrResponse']
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

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'makeStaticPsrResponse']
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

@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
@[php_method: 'acceptPsrRequest']
pub fn (probe &VSlimPhpSignatureProbe) accept_psr_request(request vphp.PhpObject) bool {
	return request.is_instance_of('Psr\\Http\\Message\\RequestInterface')
}

@[php_arg_type: 'expiration=?DateTimeInterface']
@[php_method: 'acceptDateTimeInterface']
pub fn (probe &VSlimPhpSignatureProbe) accept_datetime_interface(expiration vphp.PhpValue) bool {
	return expiration.is_null() || expiration.is_instance_of('DateTimeInterface')
}

@[php_arg_type: 'provider=Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'setProvider']
pub fn (mut probe VSlimPhpSignatureProbe) set_provider(provider &eventx.VSlimPsr14ListenerProvider) &VSlimPhpSignatureProbe {
	probe.provider_ref = provider
	return &probe
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProvider']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider() &eventx.VSlimPsr14ListenerProvider {
	return probe.provider_ref
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderAlias']
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

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderFromGuard']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_guard() &eventx.VSlimPsr14ListenerProvider {
	if provider := probe.maybe_borrowed_provider() {
		return provider
	}
	return probe.provider_ref
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderFromIfExpr']
@[php_arg_name: 'use_alias=useAlias']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_if_expr(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	return if use_alias {
		provider := probe.borrowed_provider()
		provider
	} else {
		probe.provider_ref
	}
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderFromIfExprAlias']
@[php_arg_name: 'use_alias=useAlias']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_if_expr_alias(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	provider := if use_alias {
		probe.borrowed_provider()
	} else {
		probe.provider_ref
	}
	return provider
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderFromMatchExpr']
@[php_arg_name: 'use_alias=useAlias']
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

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderFromMatchExprAlias']
@[php_arg_name: 'use_alias=useAlias']
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

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderFromOrBlock']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_or_block() &eventx.VSlimPsr14ListenerProvider {
	return probe.maybe_borrowed_provider() or { probe.provider_ref }
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'borrowedProviderFromOrBlockAlias']
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

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProvider']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider() &eventx.VSlimPsr14ListenerProvider {
	return new_signature_probe_provider()
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProviderAlias']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_alias() &eventx.VSlimPsr14ListenerProvider {
	provider := new_signature_probe_provider()
	return provider
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProviderFromIfExpr']
@[php_arg_name: 'use_alias=useAlias']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_if_expr(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	return if use_alias {
		provider := new_signature_probe_provider()
		provider
	} else {
		new_signature_probe_provider()
	}
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProviderFromIfExprAlias']
@[php_arg_name: 'use_alias=useAlias']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_if_expr_alias(use_alias bool) &eventx.VSlimPsr14ListenerProvider {
	provider := if use_alias {
		new_signature_probe_provider()
	} else {
		new_signature_probe_provider()
	}
	return provider
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProviderFromMatchExpr']
@[php_arg_name: 'use_alias=useAlias']
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

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProviderFromMatchExprAlias']
@[php_arg_name: 'use_alias=useAlias']
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

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProviderFromOrBlock']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_or_block() &eventx.VSlimPsr14ListenerProvider {
	return probe.maybe_fresh_provider() or { new_signature_probe_provider() }
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'freshProviderFromOrBlockAlias']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_or_block_alias() &eventx.VSlimPsr14ListenerProvider {
	provider := probe.maybe_fresh_provider() or { new_signature_probe_provider() }
	return provider
}
