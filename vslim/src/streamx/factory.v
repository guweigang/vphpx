module streamx

import vphp

@[php_method]
pub fn VSlimStreamFactory.text(chunks vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('text', chunks)
}

@[php_arg_name(content_type: 'contentType')]
@[php_method: 'textWith']
pub fn VSlimStreamFactory.text_with(chunks vphp.PhpValue, status int, content_type string, headers vphp.PhpArray) vphp.PhpValue {
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		status_arg.release()
	}
	mut content_type_arg := vphp.PhpString.of(content_type)
	defer {
		content_type_arg.release()
	}
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('textWith', chunks,
		status_arg, content_type_arg, headers)
}

@[php_method]
pub fn VSlimStreamFactory.sse(events vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('sse', events)
}

@[php_method: 'sseWith']
pub fn VSlimStreamFactory.sse_with(events vphp.PhpValue, status int, headers vphp.PhpArray) vphp.PhpValue {
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		status_arg.release()
	}
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('sseWith', events,
		status_arg, headers)
}

@[php_arg_name(batch_size: 'batchSize', delay_ms: 'delayMs')]
@[php_arg_default(batch_size: '1', delay_ms: '0')]
@[php_arg_optional(batch_size: true, delay_ms: true)]
@[php_method: 'dispatchSse']
pub fn VSlimStreamFactory.dispatch_sse(events vphp.PhpValue, status int, headers vphp.PhpArray, batch_size int, delay_ms int) vphp.PhpValue {
	mut stream_type_arg := vphp.PhpString.of('sse')
	mut status_arg := vphp.PhpInt.of(status)
	mut content_type_arg := vphp.PhpString.of('text/event-stream')
	mut batch_arg := vphp.PhpInt.of(batch_size)
	mut delay_arg := vphp.PhpInt.of(delay_ms)
	defer {
		stream_type_arg.release()
		status_arg.release()
		content_type_arg.release()
		batch_arg.release()
		delay_arg.release()
	}
	return vphp.PhpClass.named('VHttpd\\PhpWorker\\StreamApp').call_static('fromSequence',
		stream_type_arg, events, status_arg, content_type_arg, headers, batch_arg, delay_arg)
}

@[php_arg_name(batch_size: 'batchSize', delay_ms: 'delayMs')]
@[php_arg_default(batch_size: '1', delay_ms: '0')]
@[php_arg_optional(batch_size: true, delay_ms: true)]
@[php_method: 'dispatchResponse']
pub fn VSlimStreamFactory.dispatch_response(response vphp.PhpObject, batch_size int, delay_ms int) vphp.PhpValue {
	mut batch_arg := vphp.PhpInt.of(batch_size)
	mut delay_arg := vphp.PhpInt.of(delay_ms)
	defer {
		batch_arg.release()
		delay_arg.release()
	}
	return vphp.PhpClass.named('VHttpd\\PhpWorker\\StreamApp').call_static('fromStreamResponse',
		response, batch_arg, delay_arg)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaText']
pub fn VSlimStreamFactory.ollama_text(request_payload vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_env().text_response_from_request(request_payload)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaTextWith']
pub fn VSlimStreamFactory.ollama_text_with(request_payload vphp.PhpValue, options vphp.PhpArray) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_options(options).text_response_from_request(request_payload)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaSse']
pub fn VSlimStreamFactory.ollama_sse(request_payload vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_env().sse_response_from_request(request_payload)
}

@[php_arg_name(request_payload: 'requestPayload')]
@[php_method: 'ollamaSseWith']
pub fn VSlimStreamFactory.ollama_sse_with(request_payload vphp.PhpValue, options vphp.PhpArray) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_options(options).sse_response_from_request(request_payload)
}

