module streamx

import httpx
import vphp

const psr7_worker_chunk_size = 8192

fn resume_psr7_worker_body(input vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
	if exception := input.exception {
		return vphp.PhpGeneratorStep.throw_exception(exception)
	}
	stream := input.capture.require_object()!
	if input.kind == .start && stream.with_method_result[vphp.PhpBool, bool]('isSeekable',
		fn (result vphp.PhpBool) bool {
			return result.value()
		})! {
		mut rewound := stream.call_method('rewind')
		rewound.release()
		if vphp.PhpException.has_current() {
			return error('Unable to rewind the response body')
		}
	}
	mut length := vphp.PhpInt.of(psr7_worker_chunk_size)
	defer {
		length.release()
	}
	content := stream.with_method_result[vphp.PhpString, string]('read',
		fn (result vphp.PhpString) string {
			return result.value()
		}, length)!
	if content != '' {
		mut chunk := vphp.PhpValue.string(content)
		return vphp.PhpGeneratorStep.yield_value(chunk.move_to_request_scope())
	}
	if stream.with_method_result[vphp.PhpBool, bool]('eof', fn (result vphp.PhpBool) bool {
		return result.value()
	})! {
		return vphp.PhpGeneratorStep.finish(vphp.PhpValue.null())
	}
	return error('Response body returned no bytes before reaching EOF')
}

pub fn psr7_worker_response(response &httpx.VSlimPsr7Response, head bool) !vphp.PhpValue {
	metadata := response.without_body_projection()
	if head || httpx.response_forbids_body(metadata.status) {
		return httpx.vslim_response_to_value(metadata)
	}
	stream_body := response.worker_body_stream()
	if vphp.PhpException.has_current() {
		return error('Unable to acquire the response body')
	}
	if stream := stream_body {
		chunks := vphp.PhpGenerator.from_producer(
			capture: stream
			resume:  resume_psr7_worker_body
		)!
		mut headers := vphp.PhpValue.from_v[map[string]string](metadata.headers)!
		defer {
			headers.release()
		}
		return new_php_response('text', chunks.to_value(), metadata.status, metadata.content_type,
			headers)
	}
	return httpx.vslim_response_to_value(response.to_vslim_response())
}

pub fn suppress_worker_stream_body(response vphp.PhpValue, head bool) vphp.PhpValue {
	object := response.as_object() or { return response }
	mut status := object.prop_value('status')
	defer {
		status.release()
	}
	if !head && !httpx.response_forbids_body(status.to_int()) {
		return response
	}
	mut content_type := object.prop_value('contentType')
	mut header_value := if object.method_exists('headers') {
		object.call_method('headers')
	} else {
		object.prop_value('headers')
	}
	defer {
		content_type.release()
		header_value.release()
	}
	return httpx.vslim_response_to_value(httpx.VSlimResponse{
		status:       status.to_int()
		content_type: content_type.to_string()
		headers:      value_subject(header_value).stream_headers()
	})
}
