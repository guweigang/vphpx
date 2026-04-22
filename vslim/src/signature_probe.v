module main

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
pub fn (probe &VSlimPhpSignatureProbe) always_null() vphp.RequestOwnedZBox {
	return vphp.RequestOwnedZBox.new_null()
}

@[php_method: 'alwaysThrow']
@[php_return_type: 'never']
pub fn (probe &VSlimPhpSignatureProbe) always_throw() vphp.RequestOwnedZBox {
	vphp.throw_exception_class('RuntimeException', 'probe never return', 0)
	return vphp.RequestOwnedZBox.new_null()
}

@[php_method: 'acceptTrue']
@[php_arg_type: 'flag=true']
pub fn (probe &VSlimPhpSignatureProbe) accept_true(flag vphp.RequestBorrowedZBox) bool {
	raw := flag.to_zval()
	return raw.is_bool() && raw.to_bool()
}

@[php_method: 'acceptFalse']
@[php_arg_type: 'flag=false']
pub fn (probe &VSlimPhpSignatureProbe) accept_false(flag vphp.RequestBorrowedZBox) bool {
	raw := flag.to_zval()
	return raw.is_bool() && !raw.to_bool()
}

@[php_arg_type: 'value=null']
@[php_method: 'acceptNull']
pub fn (probe &VSlimPhpSignatureProbe) accept_null(value vphp.RequestBorrowedZBox) bool {
	return value.to_zval().is_null()
}

@[php_method: 'acceptCallable']
@[php_arg_type: 'cb=callable']
pub fn (probe &VSlimPhpSignatureProbe) accept_callable(cb vphp.RequestBorrowedZBox) bool {
	return cb.to_zval().is_callable()
}

@[php_method: 'optionalTail']
@[php_arg_default: 'suffix=""']
@[php_optional_args: 'suffix']
pub fn (probe &VSlimPhpSignatureProbe) optional_tail(prefix string, suffix string) string {
	if suffix == '' {
		return prefix
	}
	return '${prefix}:${suffix}'
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'makePsrResponse']
pub fn (probe &VSlimPhpSignatureProbe) make_psr_response() &VSlimPsr7Response {
	return &VSlimPsr7Response{
		status:           204
		reason_phrase:    'No Content'
		protocol_version: '1.1'
		headers:          map[string][]string{}
		header_names:     map[string]string{}
		body_ref:         new_psr7_stream('')
	}
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'makeStaticPsrResponse']
pub fn VSlimPhpSignatureProbe.make_static_psr_response() &VSlimPsr7Response {
	return &VSlimPsr7Response{
		status:           202
		reason_phrase:    'Accepted'
		protocol_version: '1.1'
		headers:          map[string][]string{}
		header_names:     map[string]string{}
		body_ref:         new_psr7_stream('')
	}
}

@[php_arg_type: 'request=Psr\\Http\\Message\\RequestInterface']
@[php_method: 'acceptPsrRequest']
pub fn (probe &VSlimPhpSignatureProbe) accept_psr_request(request vphp.RequestBorrowedZBox) bool {
	raw := request.to_zval()
	return raw.is_object() && raw.is_instance_of('Psr\\Http\\Message\\RequestInterface')
}

@[php_arg_type: 'expiration=?DateTimeInterface']
@[php_method: 'acceptDateTimeInterface']
pub fn (probe &VSlimPhpSignatureProbe) accept_datetime_interface(expiration vphp.RequestBorrowedZBox) bool {
	raw := expiration.to_zval()
	return raw.is_null() || (raw.is_object() && raw.is_instance_of('DateTimeInterface'))
}

@[php_method: 'setProvider']
@[php_arg_type: 'provider=Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (mut probe VSlimPhpSignatureProbe) set_provider(provider &VSlimPsr14ListenerProvider) &VSlimPhpSignatureProbe {
	probe.provider_ref = provider
	return &probe
}

@[php_method: 'borrowedProvider']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider() &VSlimPsr14ListenerProvider {
	return probe.provider_ref
}

@[php_method: 'borrowedProviderAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_alias() &VSlimPsr14ListenerProvider {
	provider := probe.borrowed_provider()
	return provider
}

fn (probe &VSlimPhpSignatureProbe) maybe_borrowed_provider() ?&VSlimPsr14ListenerProvider {
	if isnil(probe.provider_ref) {
		return none
	}
	return probe.provider_ref
}

@[php_method: 'borrowedProviderFromGuard']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_guard() &VSlimPsr14ListenerProvider {
	if provider := probe.maybe_borrowed_provider() {
		return provider
	}
	return probe.provider_ref
}

@[php_method: 'borrowedProviderFromIfExpr']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_if_expr(use_alias bool) &VSlimPsr14ListenerProvider {
	return if use_alias {
		provider := probe.borrowed_provider()
		provider
	} else {
		probe.provider_ref
	}
}

@[php_method: 'borrowedProviderFromIfExprAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_if_expr_alias(use_alias bool) &VSlimPsr14ListenerProvider {
	provider := if use_alias {
		probe.borrowed_provider()
	} else {
		probe.provider_ref
	}
	return provider
}

@[php_method: 'borrowedProviderFromMatchExpr']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_match_expr(use_alias bool) &VSlimPsr14ListenerProvider {
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

@[php_method: 'borrowedProviderFromMatchExprAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_match_expr_alias(use_alias bool) &VSlimPsr14ListenerProvider {
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

@[php_method: 'borrowedProviderFromOrBlock']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_or_block() &VSlimPsr14ListenerProvider {
	return probe.maybe_borrowed_provider() or { probe.provider_ref }
}

@[php_method: 'borrowedProviderFromOrBlockAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) borrowed_provider_from_or_block_alias() &VSlimPsr14ListenerProvider {
	provider := probe.maybe_borrowed_provider() or { probe.provider_ref }
	return provider
}

fn new_probe_listener_provider() &VSlimPsr14ListenerProvider {
	mut provider := &VSlimPsr14ListenerProvider{}
	provider.construct()
	return provider
}

fn (probe &VSlimPhpSignatureProbe) maybe_fresh_provider() ?&VSlimPsr14ListenerProvider {
	if isnil(probe.provider_ref) {
		return none
	}
	return new_probe_listener_provider()
}

@[php_method: 'freshProvider']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider() &VSlimPsr14ListenerProvider {
	return new_probe_listener_provider()
}

@[php_method: 'freshProviderAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_alias() &VSlimPsr14ListenerProvider {
	provider := new_probe_listener_provider()
	return provider
}

@[php_method: 'freshProviderFromIfExpr']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_if_expr(use_alias bool) &VSlimPsr14ListenerProvider {
	return if use_alias {
		provider := new_probe_listener_provider()
		provider
	} else {
		new_probe_listener_provider()
	}
}

@[php_method: 'freshProviderFromIfExprAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_if_expr_alias(use_alias bool) &VSlimPsr14ListenerProvider {
	provider := if use_alias {
		new_probe_listener_provider()
	} else {
		new_probe_listener_provider()
	}
	return provider
}

@[php_method: 'freshProviderFromMatchExpr']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_match_expr(use_alias bool) &VSlimPsr14ListenerProvider {
	return match use_alias {
		true {
			provider := new_probe_listener_provider()
			provider
		}
		false {
			new_probe_listener_provider()
		}
	}
}

@[php_method: 'freshProviderFromMatchExprAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_match_expr_alias(use_alias bool) &VSlimPsr14ListenerProvider {
	provider := match use_alias {
		true {
			new_probe_listener_provider()
		}
		false {
			new_probe_listener_provider()
		}
	}
	return provider
}

@[php_method: 'freshProviderFromOrBlock']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_or_block() &VSlimPsr14ListenerProvider {
	return probe.maybe_fresh_provider() or { new_probe_listener_provider() }
}

@[php_method: 'freshProviderFromOrBlockAlias']
@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
pub fn (probe &VSlimPhpSignatureProbe) fresh_provider_from_or_block_alias() &VSlimPsr14ListenerProvider {
	provider := probe.maybe_fresh_provider() or { new_probe_listener_provider() }
	return provider
}
