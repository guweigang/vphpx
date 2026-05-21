module middlewarex

import httpx
import psrx

pub fn phase_continue_response() &httpx.VSlimPsr7Response {
	return &httpx.VSlimPsr7Response{
		status:           299
		reason_phrase:    psrx.normalize_reason_phrase(299, '')
		protocol_version: '1.1'
		headers:          {
			'content-type':     ['text/plain; charset=utf-8']
			'x-vslim-continue': ['1']
		}
		header_names:     {
			'content-type':     'content-type'
			'x-vslim-continue': 'x-vslim-continue'
		}
		body_ref:         httpx.VSlimPsr7Stream.from_content('')
	}
}
