module main

import log
import vphp

@[php_class: 'VSlim\\Stream\\Response']
@[heap]
struct VSlimStreamResponse {
pub mut:
	stream_type  string @[php_prop: streamType]
	status       int
	content_type string @[php_prop: contentType]
mut:
	headers    map[string]string
	chunks_ref vphp.PhpValue = vphp.PhpValue.invalid() @[php_ignore]
}

@[php_class: 'VSlim\\Stream\\NdjsonDecoder']
@[heap]
struct VSlimStreamNdjsonDecoder {}

@[php_class: 'VSlim\\Stream\\SseEncoder']
@[heap]
struct VSlimStreamSseEncoder {}

@[php_class: 'VSlim\\Stream\\OllamaClient']
@[heap]
struct VSlimStreamOllamaClient {
mut:
	chat_url      string @[php_prop: chatUrl]
	default_model string @[php_prop: defaultModel]
	api_key       string @[php_prop: apiKey]
	fixture_path  string @[php_prop: fixturePath]
}

@[php_class: 'VSlim\\Stream\\Factory']
@[heap]
struct VSlimStreamFactory {}

@[php_attr: 'VHttpd\\Attribute\\Dispatchable("websocket")']
@[php_class: 'VSlim\\WebSocket\\App']
@[heap]
struct VSlimWebSocketApp {
mut:
	on_open_handler    vphp.PhpCallable = vphp.PhpCallable.invalid() @[php_ignore]
	on_message_handler vphp.PhpCallable = vphp.PhpCallable.invalid() @[php_ignore]
	on_close_handler   vphp.PhpCallable = vphp.PhpCallable.invalid() @[php_ignore]
	connections        map[string]vphp.PhpObject
	rooms              map[string][]string
}

@[php_attr: 'VHttpd\\Attribute\\Dispatchable("mcp")']
@[php_class: 'VSlim\\Mcp\\App']
@[heap]
struct VSlimMcpApp {
mut:
	method_handlers       map[string]vphp.PhpCallable @[php_ignore]
	tool_handlers         map[string]vphp.PhpCallable @[php_ignore]
	tool_descriptions     map[string]string           @[php_ignore]
	tool_schemas          map[string]vphp.PhpArray    @[php_ignore]
	resource_handlers     map[string]vphp.PhpCallable @[php_ignore]
	resource_names        map[string]string           @[php_ignore]
	resource_descriptions map[string]string           @[php_ignore]
	resource_mime_types   map[string]string           @[php_ignore]
	prompt_handlers       map[string]vphp.PhpCallable @[php_ignore]
	prompt_descriptions   map[string]string           @[php_ignore]
	prompt_arguments      map[string]vphp.PhpArray    @[php_ignore]
	server_info           map[string]string           @[php_ignore]
	server_capabilities   map[string]vphp.PhpArray    @[php_ignore]
}

@[php_class: 'VSlim\\Log\\Logger']
@[heap]
struct VSlimLogger {
mut:
	engine_ref         &log.Log = unsafe { nil } @[php_ignore]
	channel            string
	context            map[string]string
	level_name         string @[php_prop: levelName]
	output_file        string @[php_prop: outputFile]
	console_target     string @[php_prop: consoleTarget]
	local_time_enabled bool = true   @[php_prop: localTimeEnabled]
	short_tag_enabled  bool   @[php_prop: shortTagEnabled]
}

@[php_implements: 'Psr\\Log\\LoggerInterface']
@[php_class: 'VSlim\\Log\\PsrLogger']
@[heap]
struct VSlimPsrLogger {
mut:
	logger_ref &VSlimLogger = unsafe { nil } @[php_ignore]
}

@[php_const: 'vslim_log_level_consts']
@[php_class: 'VSlim\\Log\\Level']
@[heap]
struct VSlimLogLevel {}
