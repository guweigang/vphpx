import rt
import crypto.md5

struct Class_Snoopy {
	rt.PhpObjectBase
pub mut:
			host rt.PhpVal = rt.new_string('www.php.net')
			port rt.PhpVal = rt.new_int(80)
			proxy_host rt.PhpVal = rt.new_string('')
			proxy_port rt.PhpVal = rt.new_string('')
			proxy_user rt.PhpVal = rt.new_string('')
			proxy_pass rt.PhpVal = rt.new_string('')
			agent rt.PhpVal = rt.new_string('Snoopy v1.2.4')
			referer rt.PhpVal = rt.new_string('')
			cookies rt.PhpVal = rt.new_array()
			rawheaders rt.PhpVal = rt.new_array()
			maxredirs rt.PhpVal = rt.new_int(5)
			lastredirectaddr rt.PhpVal = rt.new_string('')
			offsiteok rt.PhpVal = rt.new_bool(true)
			maxframes rt.PhpVal = rt.new_int(0)
			expandlinks rt.PhpVal = rt.new_bool(true)
			passcookies rt.PhpVal = rt.new_bool(true)
			user rt.PhpVal = rt.new_string('')
			pass rt.PhpVal = rt.new_string('')
			accept rt.PhpVal = rt.new_string('image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*')
			results rt.PhpVal = rt.new_string('')
			error string
			response_code rt.PhpVal = rt.new_string('')
			headers rt.PhpVal = rt.new_array()
			maxlength rt.PhpVal = rt.new_int(500000)
			read_timeout rt.PhpVal = rt.new_int(0)
			timed_out bool
			status rt.PhpVal = rt.new_int(0)
			temp_dir rt.PhpVal = rt.new_string('/tmp')
			curl_path rt.PhpVal = rt.new_string('/usr/local/bin/curl')
			_maxlinelen rt.PhpVal = rt.new_int(4096)
			_httpmethod rt.PhpVal = rt.new_string('GET')
			_httpversion rt.PhpVal = rt.new_string('HTTP/1.0')
			_submit_method rt.PhpVal = rt.new_string('POST')
			_submit_type string
			_mime_boundary rt.PhpVal = rt.new_string('')
			_redirectaddr rt.PhpVal = rt.new_bool(false)
			_redirectdepth rt.PhpVal = rt.new_int(0)
			_frameurls rt.PhpVal = rt.new_array()
			_framedepth rt.PhpVal = rt.new_int(0)
			_isproxy bool
			_fp_timeout rt.PhpVal = rt.new_int(30)
}

fn (mut this Class_Snoopy) fetch(var_URI rt.PhpVal) bool {
	mut var_fp := rt.new_null()
	mut var_URI_mutated := var_URI
	mut var_URI_PARTS := rt.call_function('parse_url', [var_URI_mutated.clone()])
	if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('user')))) {
		this.user = var_URI_PARTS.array_get(rt.new_string('user'))
	}
	if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('pass')))) {
		this.pass = var_URI_PARTS.array_get(rt.new_string('pass'))
	}
	if !rt.is_true(var_URI_PARTS.array_get(rt.new_string('query'))) {
		var_URI_PARTS.array_set('query', '')
	}
	if !rt.is_true(var_URI_PARTS.array_get(rt.new_string('path'))) {
		var_URI_PARTS.array_set('path', '')
	}
	mut switch_val_1 := rt.new_string(var_URI_PARTS.array_get(rt.new_string('scheme')).to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('http'))) {
		this.host = var_URI_PARTS.array_get(rt.new_string('host'))
		if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('port')))) {
			this.port = var_URI_PARTS.array_get(rt.new_string('port'))
		}
		if this._connect(var_fp.clone()) {
			if this._isproxy {
				this._httprequest(var_URI_mutated.clone(), var_fp.clone(), var_URI_mutated.clone(), this._httpmethod, '', '')
			} else {
				mut var_path := rt.new_string((var_URI_PARTS.array_get(rt.new_string('path'))).str() + if rt.is_true(var_URI_PARTS.array_get(rt.new_string('query'))) { '?' + (var_URI_PARTS.array_get(rt.new_string('query'))).str() } else { '' })
				this._httprequest(var_path.clone(), var_fp.clone(), var_URI_mutated.clone(), this._httpmethod, '', '')
			}
			this._disconnect(var_fp.clone())
			if rt.is_true(this._redirectaddr) {
				if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
					if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i'), this._redirectaddr])) || rt.is_true(this.offsiteok) {
						rt.post_inc(this._redirectdepth)
						this.lastredirectaddr = this._redirectaddr
						this.fetch(this._redirectaddr)
					}
				}
			}
			if rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0 {
				mut var_frameurls := this._frameurls
				this._frameurls = rt.new_array()
				mut iter_1 := var_frameurls.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_frameurl := item_1.val
					if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
						this.fetch(var_frameurl.clone())
						rt.post_inc(this._framedepth)
					} else {
					}
				}
			}
		} else {
			return false
		}
		return true
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('https'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.curl_path)))) {
			return false
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_executable')])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_executable', [this.curl_path]))))) {
				return false
			}
		}
		this.host = var_URI_PARTS.array_get(rt.new_string('host'))
		if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('port')))) {
			this.port = var_URI_PARTS.array_get(rt.new_string('port'))
		}
		if this._isproxy {
			this._httpsrequest(var_URI_mutated.clone(), var_URI_mutated.clone(), this._httpmethod, '', '')
		} else {
			var_path = rt.new_string((var_URI_PARTS.array_get(rt.new_string('path'))).str() + if rt.is_true(var_URI_PARTS.array_get(rt.new_string('query'))) { '?' + (var_URI_PARTS.array_get(rt.new_string('query'))).str() } else { '' })
			this._httpsrequest(var_path.clone(), var_URI_mutated.clone(), this._httpmethod, '', '')
		}
		if rt.is_true(this._redirectaddr) {
			if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i'), this._redirectaddr])) || rt.is_true(this.offsiteok) {
					rt.post_inc(this._redirectdepth)
					this.lastredirectaddr = this._redirectaddr
					this.fetch(this._redirectaddr)
				}
			}
		}
		if rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0 {
			var_frameurls = this._frameurls
			this._frameurls = rt.new_array()
			mut iter_2 := var_frameurls.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_frameurl := item_2.val
				if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
					this.fetch(var_frameurl.clone())
					rt.post_inc(this._framedepth)
				} else {
				}
			}
		}
		return true
	} else {
		this.error = 'Invalid protocol "' + (var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '"\\n'
		return false
	}
	return true
}

fn (mut this Class_Snoopy) submit(var_URI rt.PhpVal, formvars string, formfiles string) bool {
	mut var_fp := rt.new_null()
	mut var_URI_mutated := var_URI
	var_postdata = rt.new_null()
	mut var_postdata := this._prepare_post_body(rt.new_string(formvars), rt.new_string(formfiles))
	mut var_URI_PARTS := rt.call_function('parse_url', [var_URI_mutated.clone()])
	if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('user')))) {
		this.user = var_URI_PARTS.array_get(rt.new_string('user'))
	}
	if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('pass')))) {
		this.pass = var_URI_PARTS.array_get(rt.new_string('pass'))
	}
	if !rt.is_true(var_URI_PARTS.array_get(rt.new_string('query'))) {
		var_URI_PARTS.array_set('query', '')
	}
	if !rt.is_true(var_URI_PARTS.array_get(rt.new_string('path'))) {
		var_URI_PARTS.array_set('path', '')
	}
	mut switch_val_2 := rt.new_string(var_URI_PARTS.array_get(rt.new_string('scheme')).to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('http'))) {
		this.host = var_URI_PARTS.array_get(rt.new_string('host'))
		if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('port')))) {
			this.port = var_URI_PARTS.array_get(rt.new_string('port'))
		}
		if this._connect(var_fp.clone()) {
			if this._isproxy {
				this._httprequest(var_URI_mutated.clone(), var_fp.clone(), var_URI_mutated.clone(), this._submit_method, this._submit_type, (var_postdata).str())
			} else {
				mut var_path := rt.new_string((var_URI_PARTS.array_get(rt.new_string('path'))).str() + if rt.is_true(var_URI_PARTS.array_get(rt.new_string('query'))) { '?' + (var_URI_PARTS.array_get(rt.new_string('query'))).str() } else { '' })
				this._httprequest(var_path.clone(), var_fp.clone(), var_URI_mutated.clone(), this._submit_method, this._submit_type, (var_postdata).str())
			}
			this._disconnect(var_fp.clone())
			if rt.is_true(this._redirectaddr) {
				if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^' + (var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://|'), this._redirectaddr]))))) {
						this._redirectaddr = this._expandlinks(this._redirectaddr, rt.new_string((var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://' + (var_URI_PARTS.array_get(rt.new_string('host'))).str()))
					}
					if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i'), this._redirectaddr])) || rt.is_true(this.offsiteok) {
						rt.post_inc(this._redirectdepth)
						this.lastredirectaddr = this._redirectaddr
						if rt.is_true(rt.greater(rt.call_function('strpos', [this._redirectaddr, rt.new_string('?')]), rt.new_int(0))) {
							this.fetch(this._redirectaddr)
						} else {
							this.submit(this._redirectaddr, formvars, formfiles)
						}
					}
				}
			}
			if rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0 {
				mut var_frameurls := this._frameurls
				this._frameurls = rt.new_array()
				mut iter_3 := var_frameurls.iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_frameurl := item_3.val
					if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
						this.fetch(var_frameurl.clone())
						rt.post_inc(this._framedepth)
					} else {
					}
				}
			}
		} else {
			return false
		}
		return true
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('https'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.curl_path)))) {
			return false
		}
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('is_executable')])) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_executable', [this.curl_path]))))) {
				return false
			}
		}
		this.host = var_URI_PARTS.array_get(rt.new_string('host'))
		if !(!rt.is_true(var_URI_PARTS.array_get(rt.new_string('port')))) {
			this.port = var_URI_PARTS.array_get(rt.new_string('port'))
		}
		if this._isproxy {
			this._httpsrequest(var_URI_mutated.clone(), var_URI_mutated.clone(), this._submit_method, this._submit_type, (var_postdata).str())
		} else {
			var_path = rt.new_string((var_URI_PARTS.array_get(rt.new_string('path'))).str() + if rt.is_true(var_URI_PARTS.array_get(rt.new_string('query'))) { '?' + (var_URI_PARTS.array_get(rt.new_string('query'))).str() } else { '' })
			this._httpsrequest(var_path.clone(), var_URI_mutated.clone(), this._submit_method, this._submit_type, (var_postdata).str())
		}
		if rt.is_true(this._redirectaddr) {
			if rt.is_true(rt.greater(this.maxredirs, this._redirectdepth)) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^' + (var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://|'), this._redirectaddr]))))) {
					this._redirectaddr = this._expandlinks(this._redirectaddr, rt.new_string((var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://' + (var_URI_PARTS.array_get(rt.new_string('host'))).str()))
				}
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i'), this._redirectaddr])) || rt.is_true(this.offsiteok) {
					rt.post_inc(this._redirectdepth)
					this.lastredirectaddr = this._redirectaddr
					if rt.is_true(rt.greater(rt.call_function('strpos', [this._redirectaddr, rt.new_string('?')]), rt.new_int(0))) {
						this.fetch(this._redirectaddr)
					} else {
						this.submit(this._redirectaddr, formvars, formfiles)
					}
				}
			}
		}
		if rt.is_true(rt.less(this._framedepth, this.maxframes)) && this._frameurls.array_count() > 0 {
			var_frameurls = this._frameurls
			this._frameurls = rt.new_array()
			mut iter_4 := var_frameurls.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_frameurl := item_4.val
				if rt.is_true(rt.less(this._framedepth, this.maxframes)) {
					this.fetch(var_frameurl.clone())
					rt.post_inc(this._framedepth)
				} else {
				}
			}
		}
		return true
	} else {
		this.error = 'Invalid protocol "' + (var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '"\\n'
		return false
	}
	return true
}

fn (mut this Class_Snoopy) fetchlinks(var_URI rt.PhpVal) bool {
	mut var_URI_mutated := var_URI
	if this.fetch(var_URI_mutated.clone()) {
		if rt.is_true(this.lastredirectaddr) {
		var_URI_mutated = this.lastredirectaddr
		}
		if rt.is_true(rt.new_bool(this.results.is_array())) {
			mut var_x := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_x, rt.new_int(this.results.array_count())))) { break }
				this.results.array_set(var_x, this._striplinks(this.results.array_get(var_x)))
				rt.post_inc(var_x)
			}
		} else {
			this.results = this._striplinks(this.results)
		}
		if rt.is_true(this.expandlinks) {
			this.results = this._expandlinks(this.results, var_URI_mutated.clone())
		}
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_Snoopy) fetchform(var_URI rt.PhpVal) bool {
	mut var_URI_mutated := var_URI
	if this.fetch(var_URI_mutated.clone()) {
		if rt.is_true(rt.new_bool(this.results.is_array())) {
			mut var_x := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_x, rt.new_int(this.results.array_count())))) { break }
				this.results.array_set(var_x, this._stripform(this.results.array_get(var_x)))
				rt.post_inc(var_x)
			}
		} else {
			this.results = this._stripform(this.results)
		}
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_Snoopy) fetchtext(var_URI rt.PhpVal) bool {
	mut var_URI_mutated := var_URI
	if this.fetch(var_URI_mutated.clone()) {
		if rt.is_true(rt.new_bool(this.results.is_array())) {
			mut var_x := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_x, rt.new_int(this.results.array_count())))) { break }
				this.results.array_set(var_x, this._striptext(this.results.array_get(var_x)))
				rt.post_inc(var_x)
			}
		} else {
			this.results = this._striptext(this.results)
		}
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_Snoopy) submitlinks(var_URI rt.PhpVal, formvars string, formfiles string) bool {
	mut var_URI_mutated := var_URI
	if this.submit(var_URI_mutated.clone(), formvars, formfiles) {
		if rt.is_true(this.lastredirectaddr) {
		var_URI_mutated = this.lastredirectaddr
		}
		if rt.is_true(rt.new_bool(this.results.is_array())) {
			mut var_x := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_x, rt.new_int(this.results.array_count())))) { break }
				this.results.array_set(var_x, this._striplinks(this.results.array_get(var_x)))
				if rt.is_true(this.expandlinks) {
					this.results.array_set(var_x, this._expandlinks(this.results.array_get(var_x), var_URI_mutated.clone()))
				}
				rt.post_inc(var_x)
			}
		} else {
			this.results = this._striplinks(this.results)
			if rt.is_true(this.expandlinks) {
				this.results = this._expandlinks(this.results, var_URI_mutated.clone())
			}
		}
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_Snoopy) submittext(var_URI rt.PhpVal, formvars string, formfiles string) bool {
	mut var_URI_mutated := var_URI
	if this.submit(var_URI_mutated.clone(), formvars, formfiles) {
		if rt.is_true(this.lastredirectaddr) {
		var_URI_mutated = this.lastredirectaddr
		}
		if rt.is_true(rt.new_bool(this.results.is_array())) {
			mut var_x := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_x, rt.new_int(this.results.array_count())))) { break }
				this.results.array_set(var_x, this._striptext(this.results.array_get(var_x)))
				if rt.is_true(this.expandlinks) {
					this.results.array_set(var_x, this._expandlinks(this.results.array_get(var_x), var_URI_mutated.clone()))
				}
				rt.post_inc(var_x)
			}
		} else {
			this.results = this._striptext(this.results)
			if rt.is_true(this.expandlinks) {
				this.results = this._expandlinks(this.results, var_URI_mutated.clone())
			}
		}
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_Snoopy) set_submit_multipart() {
	this._submit_type = 'multipart/form-data'
}

fn (mut this Class_Snoopy) set_submit_normal() {
	this._submit_type = 'application/x-www-form-urlencoded'
}

fn (mut this Class_Snoopy) _striplinks(var_document rt.PhpVal) rt.PhpVal {
	mut var_links := []rt.PhpVal{}
	mut var_match := rt.new_null()
	rt.call_function('preg_match_all', [rt.new_string('\'<\\s*a\\s.*?href\\s*=\\s*\t\t\t# find <a href=\n\t\t\t\t\t\t(["\\\'])?\t\t\t\t\t# find single or double quote\n\t\t\t\t\t\t(?(1) (.*?)\\1 | ([^\\s\\>]+))\t\t# if quote found, match up to next matching\n\t\t\t\t\t\t\t\t\t\t\t\t\t# quote, otherwise match up to next space\n\t\t\t\t\t\t\'isx'), var_document.clone(), rt.create_array_from_list(var_links)])
	mut iter_5 := var_links.array_get(rt.new_int(2)).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_val := item_5.val
		mut var_key := item_5.key
		if !(!rt.is_true(var_val)) {
			var_match.array_push(var_val.clone())
		}
	}
	mut iter_6 := var_links.array_get(rt.new_int(3)).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_val := item_6.val
		mut var_key := item_6.key
		if !(!rt.is_true(var_val)) {
			var_match.array_push(var_val.clone())
		}
	}
	return var_match.clone()
}

fn (mut this Class_Snoopy) _stripform(var_document rt.PhpVal) rt.PhpVal {
	mut var_elements := []rt.PhpVal{}
	rt.call_function('preg_match_all', [rt.new_string('\'<\\/?(FORM|INPUT|SELECT|TEXTAREA|(OPTION))[^<>]*>(?(2)(.*(?=<\\/?(option|select)[^<>]*>[\r\n]*)|(?=[\r\n]*))|(?=[\r\n]*))\'Usi'), var_document.clone(), rt.create_array_from_list(var_elements)])
	mut var_match := rt.call_function('implode', [rt.new_string('\r\n'), var_elements.array_get(rt.new_int(0))])
	return var_match.clone()
}

fn (mut this Class_Snoopy) _striptext(var_document rt.PhpVal) rt.PhpVal {
	mut var_search := ['\'<script[^>]*?>.*?</script>\'si', '\'<[\\/\\!]*?[^<>]*?>\'si', '\'([\r\n])[\\s]+\'', '\'&(quot|#34|#034|#x22);\'i', '\'&(amp|#38|#038|#x26);\'i', '\'&(lt|#60|#060|#x3c);\'i', '\'&(gt|#62|#062|#x3e);\'i', '\'&(nbsp|#160|#xa0);\'i', '\'&(iexcl|#161);\'i', '\'&(cent|#162);\'i', '\'&(pound|#163);\'i', '\'&(copy|#169);\'i', '\'&(reg|#174);\'i', '\'&(deg|#176);\'i', '\'&(#39|#039|#x27);\'', '\'&(euro|#8364);\'i', '\'&a(uml|UML);\'', '\'&o(uml|UML);\'', '\'&u(uml|UML);\'', '\'&A(uml|UML);\'', '\'&O(uml|UML);\'', '\'&U(uml|UML);\'', '\'&szlig;\'i']
	mut var_replace := [rt.new_string(''), rt.new_string(''), rt.new_string('\\1'), rt.new_string('"'), rt.new_string('&'), rt.new_string('<'), rt.new_string('>'), rt.new_string(' '), rt.call_function('chr', [rt.new_int(161)]), rt.call_function('chr', [rt.new_int(162)]), rt.call_function('chr', [rt.new_int(163)]), rt.call_function('chr', [rt.new_int(169)]), rt.call_function('chr', [rt.new_int(174)]), rt.call_function('chr', [rt.new_int(176)]), rt.call_function('chr', [rt.new_int(39)]), rt.call_function('chr', [rt.new_int(128)]), rt.call_function('chr', [rt.new_int(228)]), rt.call_function('chr', [rt.new_int(246)]), rt.call_function('chr', [rt.new_int(252)]), rt.call_function('chr', [rt.new_int(196)]), rt.call_function('chr', [rt.new_int(214)]), rt.call_function('chr', [rt.new_int(220)]), rt.call_function('chr', [rt.new_int(223)])]
	mut var_text := rt.call_function('preg_replace', [rt.create_array_from_list(var_search), rt.create_array_from_list(var_replace), var_document.clone()])
	return var_text.clone()
}

fn (mut this Class_Snoopy) _expandlinks(var_links rt.PhpVal, var_URI rt.PhpVal) rt.PhpVal {
	mut var_URI_mutated := var_URI
	rt.call_function('preg_match', [rt.new_string('/^[^\\?]+/'), var_URI_mutated.clone(), var_match.clone()])
	mut var_match := rt.call_function('preg_replace', [rt.new_string('|/[^\\/\\.]+\\.[^\\/\\.]+$|'), rt.new_string(''), var_match.array_get(rt.new_int(0))])
	var_match = rt.call_function('preg_replace', [rt.new_string('|/$|'), rt.new_string(''), var_match.clone()])
	mut var_match_part := rt.call_function('parse_url', [var_match.clone()])
	mut var_match_root := rt.new_string((var_match_part.array_get(rt.new_string('scheme'))).str() + '://' + (var_match_part.array_get(rt.new_string('host'))).str())
	mut var_search := ['|^http://' + (rt.call_function('preg_quote', [this.host])).str() + '|i', '|^(\\/)|i', '|^(?!http://)(?!mailto:)|i', '|/\\./|', '|/[^\\/]+/\\.\\./|']
	mut var_replace := [rt.new_string(''), (var_match_root).str() + '/', (var_match).str() + '/', rt.new_string('/'), rt.new_string('/')]
	mut var_expandedLinks := rt.call_function('preg_replace', [rt.create_array_from_list(var_search), rt.create_array_from_list(var_replace), var_links.clone()])
	return var_expandedLinks.clone()
}

fn (mut this Class_Snoopy) _httprequest(var_url rt.PhpVal, var_fp rt.PhpVal, var_URI rt.PhpVal, var_http_method rt.PhpVal, content_type string, body string) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_status := []rt.PhpVal{}
	mut var_match := rt.new_null()
	mut var_url_mutated := var_url
	mut var_fp_mutated := var_fp
	mut var_URI_mutated := var_URI
	mut var_cookie_headers := rt.new_string('')
	if rt.is_true(this.passcookies) && rt.is_true(this._redirectaddr) {
		this.setcookies()
	}
	mut var_URI_PARTS := rt.call_function('parse_url', [var_URI_mutated.clone()])
	if !rt.is_true(var_url_mutated) {
	var_url_mutated = rt.new_string('/')
	}
	mut var_headers := rt.new_string((var_http_method).str() + ' ' + (var_url_mutated).str() + ' ' + (this._httpversion).str() + '\r\n')
	if !(!rt.is_true(this.agent)) {
		var_headers = rt.concat(var_headers, rt.new_string('User-Agent: ' + (this.agent).str() + '\r\n'))
	}
	if !(!rt.is_true(this.host)) && !(this.rawheaders.array_isset(rt.new_string('Host'))) {
		var_headers = rt.concat(var_headers, rt.new_string('Host: ' + (this.host).str()))
		if !(!rt.is_true(this.port)) && rt.is_true(rt.new_bool(!rt.is_true(rt.equal(this.port, rt.new_int(80))))) {
			var_headers = rt.concat(var_headers, rt.new_string(':' + (this.port).str()))
		}
		var_headers = rt.concat(var_headers, rt.new_string('\r\n'))
	}
	if !(!rt.is_true(this.accept)) {
		var_headers = rt.concat(var_headers, rt.new_string('Accept: ' + (this.accept).str() + '\r\n'))
	}
	if !(!rt.is_true(this.referer)) {
		var_headers = rt.concat(var_headers, rt.new_string('Referer: ' + (this.referer).str() + '\r\n'))
	}
	if !(!rt.is_true(this.cookies)) {
		if !(this.cookies.is_array()) {
			this.cookies = rt.cast_array(this.cookies)
		}
		rt.call_function('reset', [this.cookies])
		if this.cookies.array_count() > 0 {
			var_cookie_headers = rt.concat(var_cookie_headers, rt.new_string('Cookie: '))
			mut iter_7 := this.cookies.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_cookieVal := item_7.val
				mut var_cookieKey := item_7.key
				var_cookie_headers = rt.concat(var_cookie_headers, rt.new_string((var_cookieKey).str() + '=' + (rt.call_function('urlencode', [var_cookieVal.clone()])).str() + '; '))
			}
			var_headers = rt.concat(var_headers, rt.new_string((rt.call_function('substr', [var_cookie_headers.clone(), rt.new_int(0), rt.new_int(-2)])).str() + '\r\n'))
		}
	}
	if !(!rt.is_true(this.rawheaders)) {
		if !(this.rawheaders.is_array()) {
			this.rawheaders = rt.cast_array(this.rawheaders)
		}
		mut iter_8 := this.rawheaders.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_headerVal := item_8.val
			mut var_headerKey := item_8.key
			var_headers = rt.concat(var_headers, rt.new_string((var_headerKey).str() + ': ' + (var_headerVal).str() + '\r\n'))
		}
	}
	if !(content_type == '') {
		var_headers = rt.concat(var_headers, rt.new_string("Content-Type: ${var_content_type}"))
		if rt.is_true(rt.equal(rt.new_string(content_type), rt.new_string('multipart/form-data'))) {
			var_headers = rt.concat(var_headers, rt.new_string('; boundary=' + (this._mime_boundary).str()))
		}
		var_headers = rt.concat(var_headers, rt.new_string('\r\n'))
	}
	if !(body == '') {
		var_headers = rt.concat(var_headers, rt.new_string('Content-Length: ' + body.len.str() + '\r\n'))
	}
	if !(!rt.is_true(this.user)) || !(!rt.is_true(this.pass)) {
		var_headers = rt.concat(var_headers, rt.new_string('Authorization: Basic ' + (rt.call_function('base64_encode', [rt.new_string((this.user).str() + ':' + (this.pass).str())])).str() + '\r\n'))
	}
	if !(!rt.is_true(this.proxy_user)) {
		var_headers = rt.concat(var_headers, rt.new_string('Proxy-Authorization: ' + 'Basic ' + (rt.call_function('base64_encode', [rt.new_string((this.proxy_user).str() + ':' + (this.proxy_pass).str())])).str() + '\r\n'))
	}
	var_headers = rt.concat(var_headers, rt.new_string('\r\n'))
	if rt.is_true(rt.greater(this.read_timeout, rt.new_int(0))) {
		rt.call_function('socket_set_timeout', [var_fp_mutated.clone(), this.read_timeout])
	}
	this.timed_out = false
	rt.call_function('fwrite', [var_fp_mutated.clone(), rt.new_string((var_headers).str() + body), rt.new_int((var_headers).str() + body.len)])
	this._redirectaddr = rt.new_bool(false)
	this.headers = rt.new_null()
	mut var_currentHeader := rt.call_function('fgets', [var_fp_mutated.clone(), this._maxlinelen])
	for rt.is_true(var_currentHeader) {
		if rt.is_true(rt.greater(this.read_timeout, rt.new_int(0))) && this._check_timeout(var_fp_mutated.clone()) {
			this.status = -100
			return false
		}
		if rt.is_true(rt.equal(var_currentHeader, rt.new_string('\r\n'))) {
			break
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(Location:|URI:)/i'), var_currentHeader.clone()])) {
			rt.call_function('preg_match', [rt.new_string('/^(Location:|URI:)[ ]+(.*)/i'), rt.new_string(var_currentHeader.clone().to_string().trim_right(' \t\n\r')), rt.create_array_from_list(var_matches)])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|\\:\\/\\/|'), var_matches.array_get(rt.new_int(2))]))))) {
				this._redirectaddr = (var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://' + (this.host).str() + ':' + (this.port).str()
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^/|'), var_matches.array_get(rt.new_int(2))]))))) {
					this._redirectaddr = rt.concat(this._redirectaddr, rt.new_string('/' + (var_matches.array_get(rt.new_int(2))).str()))
				} else {
					this._redirectaddr = rt.concat(this._redirectaddr, var_matches.array_get(rt.new_int(2)))
				}
			} else {
				this._redirectaddr = var_matches.array_get(rt.new_int(2))
			}
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^HTTP/|'), var_currentHeader.clone()])) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^HTTP/[^\\s]*\\s(.*?)\\s|'), var_currentHeader.clone(), rt.create_array_from_list(var_status)])) {
				this.status = var_status.array_get(rt.new_int(1))
			}
			this.response_code = var_currentHeader.clone()
		}
		this.headers.array_push(var_currentHeader.clone())
	}
	mut var_results := rt.new_string('')
	for {
		mut var__data := rt.call_function('fread', [var_fp_mutated.clone(), this.maxlength])
		if var__data.clone().to_string().len == 0 {
			break
		}
		var_results = rt.concat(var_results, var__data)
		if !(true) {
			break
		}
	}
	if rt.is_true(rt.greater(this.read_timeout, rt.new_int(0))) && this._check_timeout(var_fp_mutated.clone()) {
		this.status = -100
		return false
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('\'<meta[\\s]*http-equiv[^>]*?content[\\s]*=[\\s]*["\\\']?\\d+;[\\s]*URL[\\s]*=[\\s]*([^"\\\']*?)["\\\']?>\'i'), var_results.clone(), var_match.clone()])) {
		this._redirectaddr = this._expandlinks(var_match.array_get(rt.new_int(1)), var_URI_mutated.clone())
	}
	if rt.is_true(rt.less(this._framedepth, this.maxframes)) && rt.is_true(rt.call_function('preg_match_all', [rt.new_string('\'<frame\\s+.*src[\\s]*=[\\\'"]?([^\\\'"\\>]+)\'i'), var_results.clone(), var_match.clone()])) {
		this.results.array_push(var_results.clone())
		mut var_x := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_x, rt.new_int(var_match.array_get(rt.new_int(1)).array_count())))) { break }
			this._frameurls.array_push(this._expandlinks(var_match.array_get(rt.new_int(1)).array_get(var_x), rt.new_string((var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://' + (this.host).str())))
			rt.post_inc(var_x)
		}
	} else if rt.is_true(rt.new_bool(this.results.is_array())) {
		this.results.array_push(var_results.clone())
	} else {
		this.results = var_results.clone()
	}
	return true
}

fn (mut this Class_Snoopy) _httpsrequest(var_url rt.PhpVal, var_URI rt.PhpVal, var_http_method rt.PhpVal, content_type string, body string) bool {
	mut var_return := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_match := rt.new_null()
	mut var_url_mutated := var_url
	mut var_URI_mutated := var_URI
	if rt.is_true(this.passcookies) && rt.is_true(this._redirectaddr) {
		this.setcookies()
	}
	mut var_headers := rt.new_array()
	mut var_URI_PARTS := rt.call_function('parse_url', [var_URI_mutated.clone()])
	if !rt.is_true(var_url_mutated) {
	var_url_mutated = rt.new_string('/')
	}
	if !(!rt.is_true(this.agent)) {
		var_headers.array_push('User-Agent: ' + (this.agent).str())
	}
	if !(!rt.is_true(this.host)) {
		if !(!rt.is_true(this.port)) {
			var_headers.array_push('Host: ' + (this.host).str() + ':' + (this.port).str())
		} else {
			var_headers.array_push('Host: ' + (this.host).str())
		}
	}
	if !(!rt.is_true(this.accept)) {
		var_headers.array_push('Accept: ' + (this.accept).str())
	}
	if !(!rt.is_true(this.referer)) {
		var_headers.array_push('Referer: ' + (this.referer).str())
	}
	if !(!rt.is_true(this.cookies)) {
		if !(this.cookies.is_array()) {
			this.cookies = rt.cast_array(this.cookies)
		}
		rt.call_function('reset', [this.cookies])
		if this.cookies.array_count() > 0 {
			mut var_cookie_str := rt.new_string('Cookie: ')
			mut iter_9 := this.cookies.iterator()
			for {
				item_9 := iter_9.next() or { break }
				mut var_cookieVal := item_9.val
				mut var_cookieKey := item_9.key
				var_cookie_str = rt.concat(var_cookie_str, rt.new_string((var_cookieKey).str() + '=' + (rt.call_function('urlencode', [var_cookieVal.clone()])).str() + '; '))
			}
			var_headers.array_push(rt.call_function('substr', [var_cookie_str.clone(), rt.new_int(0), rt.new_int(-2)]))
		}
	}
	if !(!rt.is_true(this.rawheaders)) {
		if !(this.rawheaders.is_array()) {
			this.rawheaders = rt.cast_array(this.rawheaders)
		}
		mut iter_10 := this.rawheaders.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_headerVal := item_10.val
			mut var_headerKey := item_10.key
			var_headers.array_push((var_headerKey).str() + ': ' + (var_headerVal).str())
		}
	}
	if !(content_type == '') {
		if rt.is_true(rt.equal(rt.new_string(content_type), rt.new_string('multipart/form-data'))) {
			var_headers.array_push("Content-Type: ${var_content_type}; boundary=" + (this._mime_boundary).str())
		} else {
			var_headers.array_push("Content-Type: ${var_content_type}")
		}
	}
	if !(body == '') {
		var_headers.array_push('Content-Length: ' + body.len.str())
	}
	if !(!rt.is_true(this.user)) || !(!rt.is_true(this.pass)) {
		var_headers.array_push('Authorization: BASIC ' + (rt.call_function('base64_encode', [rt.new_string((this.user).str() + ':' + (this.pass).str())])).str())
	}
	mut var_headerfile := rt.call_function('tempnam', [this.temp_dir, rt.new_string('sno')])
	mut var_cmdline_params := rt.new_string('-k -D ' + (rt.call_function('escapeshellarg', [var_headerfile.clone()])).str())
	mut iter_11 := var_headers.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_header := item_11.val
		var_cmdline_params = rt.concat(var_cmdline_params, rt.new_string(' -H ' + (rt.call_function('escapeshellarg', [var_header.clone()])).str()))
	}
	if !(body == '') {
		var_cmdline_params = rt.concat(var_cmdline_params, rt.new_string(' -d ' + (rt.call_function('escapeshellarg', [rt.new_string(body)])).str()))
	}
	if rt.is_true(rt.greater(this.read_timeout, rt.new_int(0))) {
		var_cmdline_params = rt.concat(var_cmdline_params, rt.new_string(' -m ' + (rt.call_function('escapeshellarg', [this.read_timeout])).str()))
	}
	rt.call_function('exec', [rt.new_string((this.curl_path).str() + ' ' + (var_cmdline_params).str() + ' ' + (rt.call_function('escapeshellarg', [var_URI_mutated.clone()])).str()), var_results.clone(), var_return.clone()])
	if rt.is_true(var_return) {
		this.error = "Error: cURL could not retrieve the document, error ${var_return.to_string()}."
		return false
	}
	mut var_results := rt.call_function('implode', [rt.new_string('\r\n'), var_results.clone()])
	mut var_result_headers := rt.call_function('file', [rt.new_string("${var_headerfile.to_string()}")])
	this._redirectaddr = rt.new_bool(false)
	this.headers = rt.new_null()
	mut var_currentHeader := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_currentHeader, rt.new_int(var_result_headers.clone().array_count())))) { break }
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(Location: |URI: )/i'), var_result_headers.array_get(var_currentHeader)])) {
			rt.call_function('preg_match', [rt.new_string('/^(Location: |URI:)\\s+(.*)/'), rt.new_string(var_result_headers.array_get(var_currentHeader).to_string().trim_right(' \t\n\r')), rt.create_array_from_list(var_matches)])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|\\:\\/\\/|'), var_matches.array_get(rt.new_int(2))]))))) {
				this._redirectaddr = (var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://' + (this.host).str() + ':' + (this.port).str()
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^/|'), var_matches.array_get(rt.new_int(2))]))))) {
					this._redirectaddr = rt.concat(this._redirectaddr, rt.new_string('/' + (var_matches.array_get(rt.new_int(2))).str()))
				} else {
					this._redirectaddr = rt.concat(this._redirectaddr, var_matches.array_get(rt.new_int(2)))
				}
			} else {
				this._redirectaddr = var_matches.array_get(rt.new_int(2))
			}
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('|^HTTP/|'), var_result_headers.array_get(var_currentHeader)])) {
			this.response_code = var_result_headers.array_get(var_currentHeader)
		}
		this.headers.array_push(var_result_headers.array_get(var_currentHeader))
		rt.post_inc(var_currentHeader)
	}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('\'<meta[\\s]*http-equiv[^>]*?content[\\s]*=[\\s]*["\\\']?\\d+;[\\s]*URL[\\s]*=[\\s]*([^"\\\']*?)["\\\']?>\'i'), var_results.clone(), var_match.clone()])) {
		this._redirectaddr = this._expandlinks(var_match.array_get(rt.new_int(1)), var_URI_mutated.clone())
	}
	if rt.is_true(rt.less(this._framedepth, this.maxframes)) && rt.is_true(rt.call_function('preg_match_all', [rt.new_string('\'<frame\\s+.*src[\\s]*=[\\\'"]?([^\\\'"\\>]+)\'i'), var_results.clone(), var_match.clone()])) {
		this.results.array_push(var_results.clone())
		mut var_x := rt.new_int(0)
		for {
			if !(rt.is_true(rt.less(var_x, rt.new_int(var_match.array_get(rt.new_int(1)).array_count())))) { break }
			this._frameurls.array_push(this._expandlinks(var_match.array_get(rt.new_int(1)).array_get(var_x), rt.new_string((var_URI_PARTS.array_get(rt.new_string('scheme'))).str() + '://' + (this.host).str())))
			rt.post_inc(var_x)
		}
	} else if rt.is_true(rt.new_bool(this.results.is_array())) {
		this.results.array_push(var_results.clone())
	} else {
		this.results = var_results.clone()
	}
	rt.call_function('unlink', [rt.new_string("${var_headerfile.to_string()}")])
	return true
}

fn (mut this Class_Snoopy) setcookies() {
	mut var_match := rt.new_null()
	mut var_x := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_x, rt.new_int(this.headers.array_count())))) { break }
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^set-cookie:[\\s]+([^=]+)=([^;]+)/i'), this.headers.array_get(var_x), var_match.clone()])) {
			this.cookies.array_set(var_match.array_get(rt.new_int(1)), rt.call_function('urldecode', [var_match.array_get(rt.new_int(2))]))
		}
		rt.post_inc(var_x)
	}
}

fn (mut this Class_Snoopy) _check_timeout(var_fp rt.PhpVal) bool {
	mut var_fp_mutated := var_fp
	if rt.is_true(rt.greater(this.read_timeout, rt.new_int(0))) {
		mut var_fp_status := rt.call_function('socket_get_status', [var_fp_mutated.clone()])
		if rt.is_true(var_fp_status.array_get(rt.new_string('timed_out'))) {
			this.timed_out = true
			return true
		}
	}
	return false
}

fn (mut this Class_Snoopy) _connect(var_fp rt.PhpVal) bool {
	mut var_errno := rt.new_null()
	mut var_errstr := rt.new_null()
	mut var_fp_mutated := var_fp
	if !(!rt.is_true(this.proxy_host)) && !(!rt.is_true(this.proxy_port)) {
		this._isproxy = true
	mut var_host := this.proxy_host
	mut var_port := this.proxy_port
	} else {
	var_host = this.host
	var_port = this.port
	}
	this.status = rt.new_int(0)
	var_fp_mutated = rt.call_function('fsockopen', [var_host.clone(), var_port.clone(), var_errno.clone(), var_errstr.clone(), this._fp_timeout])
	if rt.is_true(var_fp_mutated) {
		return true
	} else {
		this.status = var_errno.clone()
		mut switch_val_3 := var_errno
		if rt.is_true(rt.equal(switch_val_3, -3)) {
			this.error = 'socket creation failed (-3)'
		} else if rt.is_true(rt.equal(switch_val_3, -4)) {
			this.error = 'dns lookup failure (-4)'
		} else if rt.is_true(rt.equal(switch_val_3, -5)) {
			this.error = 'connection refused or timed out (-5)'
		} else {
			this.error = 'connection failed (' + (var_errno).str() + ')'
		}
		return false
	}
	return false
}

fn (mut this Class_Snoopy) _disconnect(var_fp rt.PhpVal) rt.PhpVal {
	mut var_fp_mutated := var_fp
	return rt.call_function('fclose', [var_fp_mutated.clone()])
}

fn (mut this Class_Snoopy) _prepare_post_body(var_formvars rt.PhpVal, var_formfiles rt.PhpVal) rt.PhpVal {
	rt.call_function('settype', [var_formvars.clone(), rt.new_string('array')])
	rt.call_function('settype', [var_formfiles.clone(), rt.new_string('array')])
	mut var_postdata := rt.new_string('')
	if var_formvars.clone().array_count() == 0 && var_formfiles.clone().array_count() == 0 {
		return rt.new_null()
	}
	mut switch_val_4 := this._submit_type
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('application/x-www-form-urlencoded'))) {
		rt.call_function('reset', [var_formvars.clone()])
		mut iter_12 := var_formvars.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_val := item_12.val
			mut var_key := item_12.key
			if var_val.clone().is_array() || var_val.clone().is_object() {
				mut iter_13 := var_val.iterator()
				for {
					item_13 := iter_13.next() or { break }
					mut var_cur_val := item_13.val
					mut var_cur_key := item_13.key
					var_postdata = rt.concat(var_postdata, rt.new_string((rt.call_function('urlencode', [var_key.clone()])).str() + '[]=' + (rt.call_function('urlencode', [var_cur_val.clone()])).str() + '&'))
				}
			} else {
				var_postdata = rt.concat(var_postdata, rt.new_string((rt.call_function('urlencode', [var_key.clone()])).str() + '=' + (rt.call_function('urlencode', [var_val.clone()])).str() + '&'))
			}
		}
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('multipart/form-data'))) {
		this._mime_boundary = 'Snoopy' + md5.hexhash(rt.call_function('uniqid', [rt.call_function('microtime', []rt.PhpVal{})]).to_string())
		rt.call_function('reset', [var_formvars.clone()])
		mut iter_14 := var_formvars.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_val := item_14.val
			mut var_key := item_14.key
			if var_val.clone().is_array() || var_val.clone().is_object() {
				mut iter_15 := var_val.iterator()
				for {
					item_15 := iter_15.next() or { break }
					mut var_cur_val := item_15.val
					mut var_cur_key := item_15.key
					var_postdata = rt.concat(var_postdata, rt.new_string('--' + (this._mime_boundary).str() + '\r\n'))
					var_postdata = rt.concat(var_postdata, rt.new_string("Content-Disposition: form-data; name=\"${var_key.to_string()}\\[\\]\"\r\n\r\n"))
					var_postdata = rt.concat(var_postdata, rt.new_string("${var_cur_val.to_string()}\r\n"))
				}
			} else {
				var_postdata = rt.concat(var_postdata, rt.new_string('--' + (this._mime_boundary).str() + '\r\n'))
				var_postdata = rt.concat(var_postdata, rt.new_string("Content-Disposition: form-data; name=\"${var_key.to_string()}\"\r\n\r\n"))
				var_postdata = rt.concat(var_postdata, rt.new_string("${var_val.to_string()}\r\n"))
			}
		}
		rt.call_function('reset', [var_formfiles.clone()])
		mut iter_16 := var_formfiles.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_file_names := item_16.val
			mut var_field_name := item_16.key
			rt.call_function('settype', [var_file_names.clone(), rt.new_string('array')])
			mut iter_17 := var_file_names.iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_file_name := item_17.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_file_name.clone()]))))) {
					continue
				}
				mut var_fp := rt.call_function('fopen', [var_file_name.clone(), rt.new_string('r')])
				mut var_file_content := rt.call_function('fread', [var_fp.clone(), rt.call_function('filesize', [var_file_name.clone()])])
				rt.call_function('fclose', [var_fp.clone()])
				mut var_base_name := rt.call_function('basename', [var_file_name.clone()])
				var_postdata = rt.concat(var_postdata, rt.new_string('--' + (this._mime_boundary).str() + '\r\n'))
				var_postdata = rt.concat(var_postdata, rt.new_string("Content-Disposition: form-data; name=\"${var_field_name.to_string()}\"; filename=\"${var_base_name.to_string()}\"\r\n\r\n"))
				var_postdata = rt.concat(var_postdata, rt.new_string("${var_file_content.to_string()}\r\n"))
			}
		}
		var_postdata = rt.concat(var_postdata, rt.new_string('--' + (this._mime_boundary).str() + '--\r\n'))
	}
	return var_postdata.clone()
}

fn create_snoopy(_args ...rt.PhpVal) &Class_Snoopy {
	mut obj := &Class_Snoopy{
		PhpObjectBase: rt.PhpObjectBase{}
		host: rt.new_string('www.php.net')
		port: rt.new_int(80)
		proxy_host: rt.new_string('')
		proxy_port: rt.new_string('')
		proxy_user: rt.new_string('')
		proxy_pass: rt.new_string('')
		agent: rt.new_string('Snoopy v1.2.4')
		referer: rt.new_string('')
		cookies: rt.new_array()
		rawheaders: rt.new_array()
		maxredirs: rt.new_int(5)
		lastredirectaddr: rt.new_string('')
		offsiteok: rt.new_bool(true)
		maxframes: rt.new_int(0)
		expandlinks: rt.new_bool(true)
		passcookies: rt.new_bool(true)
		user: rt.new_string('')
		pass: rt.new_string('')
		accept: rt.new_string('image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*')
		results: rt.new_string('')
		error: ''
		response_code: rt.new_string('')
		headers: rt.new_array()
		maxlength: rt.new_int(500000)
		read_timeout: rt.new_int(0)
		timed_out: false
		status: rt.new_int(0)
		temp_dir: rt.new_string('/tmp')
		curl_path: rt.new_string('/usr/local/bin/curl')
		_maxlinelen: rt.new_int(4096)
		_httpmethod: rt.new_string('GET')
		_httpversion: rt.new_string('HTTP/1.0')
		_submit_method: rt.new_string('POST')
		_submit_type: ''
		_mime_boundary: rt.new_string('')
		_redirectaddr: rt.new_bool(false)
		_redirectdepth: rt.new_int(0)
		_frameurls: rt.new_array()
		_framedepth: rt.new_int(0)
		_isproxy: false
		_fp_timeout: rt.new_int(30)
	}
	return obj
}

fn (mut this Class_Snoopy) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fetch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetch(dispatch_arg_0))
		}
		'submit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.submit(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'fetchlinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetchlinks(dispatch_arg_0))
		}
		'fetchform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetchform(dispatch_arg_0))
		}
		'fetchtext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.fetchtext(dispatch_arg_0))
		}
		'submitlinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.submitlinks(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'submittext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.submittext(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'set_submit_multipart' {
			this.set_submit_multipart()
			return rt.new_null()
		}
		'set_submit_normal' {
			this.set_submit_normal()
			return rt.new_null()
		}
		'_striplinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._striplinks(dispatch_arg_0)
		}
		'_stripform' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._stripform(dispatch_arg_0)
		}
		'_striptext' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._striptext(dispatch_arg_0)
		}
		'_expandlinks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._expandlinks(dispatch_arg_0, dispatch_arg_1)
		}
		'_httprequest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return rt.new_bool(this._httprequest(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'_httpsrequest' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_bool(this._httpsrequest(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'setcookies' {
			this.setcookies()
			return rt.new_null()
		}
		'_check_timeout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._check_timeout(dispatch_arg_0))
		}
		'_connect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._connect(dispatch_arg_0))
		}
		'_disconnect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._disconnect(dispatch_arg_0)
		}
		'_prepare_post_body' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._prepare_post_body(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Snoopy) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'host' { return this.host }
		'port' { return this.port }
		'proxy_host' { return this.proxy_host }
		'proxy_port' { return this.proxy_port }
		'proxy_user' { return this.proxy_user }
		'proxy_pass' { return this.proxy_pass }
		'agent' { return this.agent }
		'referer' { return this.referer }
		'cookies' { return this.cookies }
		'rawheaders' { return this.rawheaders }
		'maxredirs' { return this.maxredirs }
		'lastredirectaddr' { return this.lastredirectaddr }
		'offsiteok' { return this.offsiteok }
		'maxframes' { return this.maxframes }
		'expandlinks' { return this.expandlinks }
		'passcookies' { return this.passcookies }
		'user' { return this.user }
		'pass' { return this.pass }
		'accept' { return this.accept }
		'results' { return this.results }
		'error' { return rt.new_string(this.error) }
		'response_code' { return this.response_code }
		'headers' { return this.headers }
		'maxlength' { return this.maxlength }
		'read_timeout' { return this.read_timeout }
		'timed_out' { return rt.new_bool(this.timed_out) }
		'status' { return this.status }
		'temp_dir' { return this.temp_dir }
		'curl_path' { return this.curl_path }
		'_maxlinelen' { return this._maxlinelen }
		'_httpmethod' { return this._httpmethod }
		'_httpversion' { return this._httpversion }
		'_submit_method' { return this._submit_method }
		'_submit_type' { return rt.new_string(this._submit_type) }
		'_mime_boundary' { return this._mime_boundary }
		'_redirectaddr' { return this._redirectaddr }
		'_redirectdepth' { return this._redirectdepth }
		'_frameurls' { return this._frameurls }
		'_framedepth' { return this._framedepth }
		'_isproxy' { return rt.new_bool(this._isproxy) }
		'_fp_timeout' { return this._fp_timeout }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Snoopy) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'host' { this.host = val; return true }
		'port' { this.port = val; return true }
		'proxy_host' { this.proxy_host = val; return true }
		'proxy_port' { this.proxy_port = val; return true }
		'proxy_user' { this.proxy_user = val; return true }
		'proxy_pass' { this.proxy_pass = val; return true }
		'agent' { this.agent = val; return true }
		'referer' { this.referer = val; return true }
		'cookies' { this.cookies = val; return true }
		'rawheaders' { this.rawheaders = val; return true }
		'maxredirs' { this.maxredirs = val; return true }
		'lastredirectaddr' { this.lastredirectaddr = val; return true }
		'offsiteok' { this.offsiteok = val; return true }
		'maxframes' { this.maxframes = val; return true }
		'expandlinks' { this.expandlinks = val; return true }
		'passcookies' { this.passcookies = val; return true }
		'user' { this.user = val; return true }
		'pass' { this.pass = val; return true }
		'accept' { this.accept = val; return true }
		'results' { this.results = val; return true }
		'error' { this.error = (val).str(); return true }
		'response_code' { this.response_code = val; return true }
		'headers' { this.headers = val; return true }
		'maxlength' { this.maxlength = val; return true }
		'read_timeout' { this.read_timeout = val; return true }
		'timed_out' { this.timed_out = (val).to_bool(); return true }
		'status' { this.status = val; return true }
		'temp_dir' { this.temp_dir = val; return true }
		'curl_path' { this.curl_path = val; return true }
		'_maxlinelen' { this._maxlinelen = val; return true }
		'_httpmethod' { this._httpmethod = val; return true }
		'_httpversion' { this._httpversion = val; return true }
		'_submit_method' { this._submit_method = val; return true }
		'_submit_type' { this._submit_type = (val).str(); return true }
		'_mime_boundary' { this._mime_boundary = val; return true }
		'_redirectaddr' { this._redirectaddr = val; return true }
		'_redirectdepth' { this._redirectdepth = val; return true }
		'_frameurls' { this._frameurls = val; return true }
		'_framedepth' { this._framedepth = val; return true }
		'_isproxy' { this._isproxy = (val).to_bool(); return true }
		'_fp_timeout' { this._fp_timeout = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('_deprecated_file', [rt.call_function('basename', [rt.new_string(@FILE)]), rt.new_string('3.0.0'), rt.new_string((rt.get_constant('WPINC')).str() + '/http.php')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Snoopy'), rt.new_bool(false)]))))) {
	}
}
