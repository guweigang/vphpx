module sessionx

import configx as cfgx

pub fn auth_redirect_path_from_config(config &cfgx.VSlimConfig, fallback string) string {
	clean_fallback := fallback.trim_space()
	if config == unsafe { nil } {
		return clean_fallback
	}
	if config.has('auth.redirect_to') {
		return config.get_string('auth.redirect_to', clean_fallback).trim_space()
	}
	if config.has('auth.redirectTo') {
		return config.get_string('auth.redirectTo', clean_fallback).trim_space()
	}
	return clean_fallback
}
