module sessionx

import httpx

pub fn (session &VSlimSessionStore) cookie_header_value() string {
	if session.is_destroyed() {
		return httpx.build_set_cookie_header(session.cookie_name_value(), '', session.path_value(),
			session.domain_value(), -1, session.secure_value(), session.http_only_value(),
			session.same_site_value())
	}
	return httpx.build_set_cookie_header(session.cookie_name_value(), session.encoded_value(),
		session.path_value(), session.domain_value(), session.ttl_seconds_value(),
		session.secure_value(), session.http_only_value(), session.same_site_value())
}

pub fn (mut session VSlimSessionStore) commit_psr_response(response &httpx.VSlimPsr7Response) &httpx.VSlimPsr7Response {
	if !session.should_commit() {
		return response
	}
	mut headers := httpx.clone_header_values(response.headers)
	mut header_names := httpx.clone_header_names(response.header_names)
	headers['set-cookie'] = [session.cookie_header_value()]
	header_names['set-cookie'] = 'Set-Cookie'
	session.mark_clean()
	return response.clone_with(response.protocol_version, headers, header_names,
		response.body_or_empty(), response.status, response.reason_phrase)
}
