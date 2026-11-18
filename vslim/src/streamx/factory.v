module streamx

import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn VSlimStreamFactory.text(chunks vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('text', chunks)
}

@[vphp.PhpArgName(v_name: 'content_type', php_name: 'contentType')]
@[vphp.PhpExportMethod(name: 'textWith')]
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

@[vphp.PhpExportMethod(name: '')]
pub fn VSlimStreamFactory.sse(events vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('sse', events)
}

@[vphp.PhpExportMethod(name: 'sseWith')]
pub fn VSlimStreamFactory.sse_with(events vphp.PhpValue, status int, headers vphp.PhpArray) vphp.PhpValue {
	mut status_arg := vphp.PhpInt.of(status)
	defer {
		status_arg.release()
	}
	return vphp.PhpClass.named('VSlim\\Stream\\Response').call_static('sseWith', events,
		status_arg, headers)
}

@[vphp.PhpArgNames(names: 'batch_size=batchSize,delay_ms=delayMs')]
@[vphp.PhpArgDefaults(defaults: 'batch_size=1,delay_ms=0')]
@[vphp.PhpExportMethod(name: 'dispatchSse')]
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

@[vphp.PhpArgNames(names: 'batch_size=batchSize,delay_ms=delayMs')]
@[vphp.PhpArgDefaults(defaults: 'batch_size=1,delay_ms=0')]
@[vphp.PhpExportMethod(name: 'dispatchResponse')]
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

@[vphp.PhpArgName(v_name: 'request_payload', php_name: 'requestPayload')]
@[vphp.PhpExportMethod(name: 'ollamaText')]
pub fn VSlimStreamFactory.ollama_text(request_payload vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_env().text_response_from_request(request_payload)
}

@[vphp.PhpArgName(v_name: 'request_payload', php_name: 'requestPayload')]
@[vphp.PhpExportMethod(name: 'ollamaTextWith')]
pub fn VSlimStreamFactory.ollama_text_with(request_payload vphp.PhpValue, options vphp.PhpArray) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_options(options).text_response_from_request(request_payload)
}

@[vphp.PhpArgName(v_name: 'request_payload', php_name: 'requestPayload')]
@[vphp.PhpExportMethod(name: 'ollamaSse')]
pub fn VSlimStreamFactory.ollama_sse(request_payload vphp.PhpValue) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_env().sse_response_from_request(request_payload)
}

@[vphp.PhpArgName(v_name: 'request_payload', php_name: 'requestPayload')]
@[vphp.PhpExportMethod(name: 'ollamaSseWith')]
pub fn VSlimStreamFactory.ollama_sse_with(request_payload vphp.PhpValue, options vphp.PhpArray) vphp.PhpValue {
	return VSlimStreamOllamaClient.from_options(options).sse_response_from_request(request_payload)
}
