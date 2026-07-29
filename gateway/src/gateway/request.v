module gateway

import net.urllib

fn parse_urlencoded(raw string) map[string]string {
	mut values := map[string]string{}
	if raw == '' {
		return values
	}
	for item in raw.split('&') {
		if item == '' {
			continue
		}
		key_raw, value_raw := item.split_once('=') or { item, '' }
		key := urllib.query_unescape(key_raw.replace('+', ' ')) or { key_raw }
		value := urllib.query_unescape(value_raw.replace('+', ' ')) or { value_raw }
		values[key] = value
	}
	return values
}

fn parse_cookies(raw string) map[string]string {
	mut cookies := map[string]string{}
	for item in raw.split(';') {
		key, value := item.trim_space().split_once('=') or { continue }
		if key != '' {
			cookies[key] = value
		}
	}
	return cookies
}
