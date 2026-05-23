module sessionx

import configx as cfgx

@[php_method]
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

@[php_method: 'setStore']
pub fn (mut guard VSlimAuthSessionGuard) set_store(store &VSlimSessionStore) &VSlimAuthSessionGuard {
	guard.store_ref = store
	return &guard
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) store() &VSlimSessionStore {
	return guard.store_ref
}

@[php_arg_name: 'key=userKey']
@[php_method: 'setUserKey']
pub fn (mut guard VSlimAuthSessionGuard) set_user_key(key string) &VSlimAuthSessionGuard {
	if key.trim_space() != '' {
		guard.user_key = key.trim_space()
	}
	return &guard
}

@[php_method: 'userKey']
pub fn (guard &VSlimAuthSessionGuard) user_key_value() string {
	if guard.user_key.trim_space() == '' {
		return 'auth.user_id'
	}
	return guard.user_key.trim_space()
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) check() bool {
	return guard.store_ref != unsafe { nil } && guard.store_ref.has(guard.user_key_value())
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) guest() bool {
	return !guard.check()
}

@[php_method]
pub fn (guard &VSlimAuthSessionGuard) id() string {
	if guard.store_ref == unsafe { nil } {
		return ''
	}
	return guard.store_ref.get(guard.user_key_value(), '')
}

@[php_method: 'userId']
pub fn (guard &VSlimAuthSessionGuard) user_id() string {
	return guard.id()
}

@[php_arg_name: 'user_id=userId']
@[php_borrowed_return; php_method]
pub fn (mut guard VSlimAuthSessionGuard) login(user_id string) &VSlimAuthSessionGuard {
	if guard.store_ref != unsafe { nil } {
		guard.store_ref.set(guard.user_key_value(), user_id)
	}
	return &guard
}

@[php_borrowed_return; php_method]
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
