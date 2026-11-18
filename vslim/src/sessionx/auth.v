module sessionx

import configx as cfgx
import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn (mut guard VSlimAuthSessionGuard) construct() &VSlimAuthSessionGuard {
	guard.user_key = 'auth.user_id'
	return &guard
}

pub fn VSlimAuthSessionGuard.from_store_and_config(store &VSlimSessionStore, config &cfgx.VSlimConfig) &VSlimAuthSessionGuard {
	mut guard := &VSlimAuthSessionGuard{}
	guard.construct()
	guard.set_store(store)
	guard.configure_defaults(config)
	return guard
}

@[vphp.PhpExportMethod(name: 'setStore')]
pub fn (mut guard VSlimAuthSessionGuard) set_store(store &VSlimSessionStore) &VSlimAuthSessionGuard {
	guard.store_ref = store
	return &guard
}

@[vphp.PhpExportMethod(name: '')]
pub fn (guard &VSlimAuthSessionGuard) store() &VSlimSessionStore {
	return guard.store_ref
}

@[vphp.PhpArgName(v_name: 'key', php_name: 'userKey')]
@[vphp.PhpExportMethod(name: 'setUserKey')]
pub fn (mut guard VSlimAuthSessionGuard) set_user_key(key string) &VSlimAuthSessionGuard {
	if key.trim_space() != '' {
		guard.user_key = key.trim_space()
	}
	return &guard
}

@[vphp.PhpExportMethod(name: 'userKey')]
pub fn (guard &VSlimAuthSessionGuard) user_key_value() string {
	if guard.user_key.trim_space() == '' {
		return 'auth.user_id'
	}
	return guard.user_key.trim_space()
}

@[vphp.PhpExportMethod(name: '')]
pub fn (guard &VSlimAuthSessionGuard) check() bool {
	return guard.store_ref != unsafe { nil } && guard.store_ref.has(guard.user_key_value())
}

@[vphp.PhpExportMethod(name: '')]
pub fn (guard &VSlimAuthSessionGuard) guest() bool {
	return !guard.check()
}

@[vphp.PhpExportMethod(name: '')]
pub fn (guard &VSlimAuthSessionGuard) id() string {
	if guard.store_ref == unsafe { nil } {
		return ''
	}
	return guard.store_ref.get(guard.user_key_value(), '')
}

@[vphp.PhpExportMethod(name: 'userId')]
pub fn (guard &VSlimAuthSessionGuard) user_id() string {
	return guard.id()
}

@[vphp.PhpArgName(v_name: 'user_id', php_name: 'userId')]
@[vphp.PhpBorrowedReturn]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut guard VSlimAuthSessionGuard) login(user_id string) &VSlimAuthSessionGuard {
	if guard.store_ref != unsafe { nil } {
		guard.store_ref.set(guard.user_key_value(), user_id)
	}
	return &guard
}

@[vphp.PhpBorrowedReturn]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut guard VSlimAuthSessionGuard) logout() &VSlimAuthSessionGuard {
	if guard.store_ref != unsafe { nil } {
		guard.store_ref.forget(guard.user_key_value())
	}
	return &guard
}

pub fn (mut guard VSlimAuthSessionGuard) configure_defaults(config &cfgx.VSlimConfig) {
	if config == unsafe { nil } {
		return
	}
	if config.has('auth.session_key') {
		guard.set_user_key(config.get_string('auth.session_key', guard.user_key_value()))
	}
}
