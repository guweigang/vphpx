module sessionx

import configx as cfgx

pub fn session_diagnostics(config &cfgx.VSlimConfig) map[string]string {
	session_cookie := if config != unsafe { nil } {
		config.get_string('session.cookie', '').trim_space()
	} else {
		''
	}
	session_secret_configured := if config != unsafe { nil }
		&& (config.get_string('session.secret', '').trim_space() != ''
		|| config.get_string('app.key', '').trim_space() != '') {
		'true'
	} else {
		'false'
	}
	session_secret_placeholder := if config != unsafe { nil }
		&& config.get_string('session.secret', '').trim_space() == 'change-me' {
		'true'
	} else {
		'false'
	}
	session_configured := if session_cookie != '' && session_secret_configured == 'true' {
		'true'
	} else {
		'false'
	}
	return {
		'session_cookie':             session_cookie
		'session_secret_configured':  session_secret_configured
		'session_secret_placeholder': session_secret_placeholder
		'session_configured':         session_configured
	}
}
