module main

import log
import toml
import vphp

pub type VSlimHandler = fn (VSlimRequest) VSlimResponse

pub type VSlimNext = fn (VSlimRequest) VSlimResponse

pub type VSlimMiddleware = fn (VSlimRequest, VSlimNext) VSlimResponse

pub enum VSlimRouteHandlerType {
	v_native
	php_callable
}

pub struct VSlimRoute {
pub mut:
	method                   string
	name                     string
	pattern                  string
	handler_type             VSlimRouteHandlerType
	v_handler                VSlimHandler             = unsafe { nil }
	php_handler              vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
	resource_action          string
	resource_missing_handler vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
}

pub struct RoutePath {}

pub struct VSlimRuntime {
mut:
	routes      []VSlimRoute
	middlewares []VSlimMiddleware
}

struct RouteHook {
	prefix  string
	handler vphp.PersistentOwnedZVal
}

@[php_attr: 'VPhp\\VHttpd\\Attribute\\Dispatchable("http")']
@[php_class: 'VSlim\\App']
@[heap]
struct VSlimApp {
mut:
	routes                []VSlimRoute
	websocket_routes      []VSlimRoute
	websocket_conn_route  map[string]int
	php_before_hooks      []vphp.PersistentOwnedZVal
	php_after_hooks       []vphp.PersistentOwnedZVal
	php_middlewares       []vphp.PersistentOwnedZVal
	php_group_before      []RouteHook
	php_group_after       []RouteHook
	php_group_middle      []RouteHook
	not_found_handler     vphp.PersistentOwnedZVal
	error_handler         vphp.PersistentOwnedZVal
	container_ref         &VSlimContainer = unsafe { nil }
	config_ref            &VSlimConfig    = unsafe { nil }
	mcp_ref               &VSlimMcpApp    = unsafe { nil }
	base_path             string
	use_demo              bool
	error_response_json   bool
	view_base_path        string
	assets_prefix         string
	view_cache_enabled    bool
	view_cache_configured bool
	view_helpers          map[string]vphp.PersistentOwnedZVal
	logger_ref            &VSlimLogger = unsafe { nil }
	live_ws_sockets       map[string]vphp.PersistentOwnedZVal
}

struct MiddlewareChain {
mut:
	app               &VSlimApp = unsafe { nil }
	path              string
	middlewares       []vphp.RequestOwnedZVal
	route_handler     vphp.RequestOwnedZVal
	index             int
	has_terminal      bool
	terminal_response VSlimResponse
}

@[php_class: 'VSlim\\RouteGroup']
@[heap]
struct RouteGroup {
mut:
	app    &VSlimApp = unsafe { nil }
	prefix string
}

@[php_class: 'VSlim\\Request']
@[heap]
struct VSlimRequest {
pub mut:
	method           string
	raw_path         string
	path             string
	body             string
	query_string     string
	scheme           string
	host             string
	port             string
	protocol_version string
	remote_addr      string
mut:
	query          map[string]string
	headers        map[string]string
	cookies        map[string]string
	attributes     map[string]string
	server         map[string]string
	uploaded_files []string
	params         map[string]string
}

@[php_class: 'VSlim\\Response']
@[heap]
struct VSlimResponse {
pub mut:
	status       int
	body         string
	content_type string
mut:
	headers map[string]string
}

@[php_class: 'VSlim\\Stream\\Response']
@[heap]
struct VSlimStreamResponse {
pub mut:
	stream_type  string
	status       int
	content_type string
mut:
	headers    map[string]string
	chunks_ref vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
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
	chat_url      string
	default_model string
	api_key       string
	fixture_path  string
}

@[php_class: 'VSlim\\Stream\\Factory']
@[heap]
struct VSlimStreamFactory {}

@[php_attr: 'VPhp\\VHttpd\\Attribute\\Dispatchable("websocket")']
@[php_class: 'VSlim\\WebSocket\\App']
@[heap]
struct VSlimWebSocketApp {
mut:
	on_open_handler    vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
	on_message_handler vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
	on_close_handler   vphp.PersistentOwnedZVal = vphp.PersistentOwnedZVal.new_null()
	connections        map[string]vphp.PersistentOwnedZVal
	rooms              map[string][]string
}

@[php_attr: 'VPhp\\VHttpd\\Attribute\\Dispatchable("mcp")']
@[php_class: 'VSlim\\Mcp\\App']
@[heap]
struct VSlimMcpApp {
mut:
	method_handlers       map[string]vphp.PersistentOwnedZVal
	tool_handlers         map[string]vphp.PersistentOwnedZVal
	tool_descriptions     map[string]string
	tool_schemas          map[string]vphp.PersistentOwnedZVal
	resource_handlers     map[string]vphp.PersistentOwnedZVal
	resource_names        map[string]string
	resource_descriptions map[string]string
	resource_mime_types   map[string]string
	prompt_handlers       map[string]vphp.PersistentOwnedZVal
	prompt_descriptions   map[string]string
	prompt_arguments      map[string]vphp.PersistentOwnedZVal
	server_info           map[string]string
	server_capabilities   map[string]vphp.PersistentOwnedZVal
}

@[php_class: 'VSlim\\Log\\Logger']
@[heap]
struct VSlimLogger {
mut:
	engine_ref         &log.Log = unsafe { nil }
	channel            string
	context            map[string]string
	level_name         string
	output_file        string
	console_target     string
	local_time_enabled bool = true
	short_tag_enabled  bool
}

@[php_const: 'vslim_log_level_consts']
@[php_class: 'VSlim\\Log\\Level']
@[heap]
struct VSlimLogLevel {}

struct VSlimLogLevelConsts {
	disabled string
	fatal    string
	error    string
	warn     string
	info     string
	debug    string
}

@[php_class: 'VSlim\\Live\\Socket']
@[heap]
struct VSlimLiveSocket {
mut:
	id          string
	connected   bool
	redirect_to string
	navigate_to string
	raw_path    string
	root_id     string
	assigns     map[string]string
	patches     []map[string]string
	events      []map[string]string
	flashes     []map[string]string
	pubsub      []map[string]string
}

@[php_class: 'VSlim\\Live\\Form']
@[heap]
struct VSlimLiveForm {
mut:
	name             string
	socket_ref       &VSlimLiveSocket = unsafe { nil }
	fields           []string
	last_error_count int
	validated        bool
}

@[php_class: 'VSlim\\Live\\View']
@[heap]
struct VSlimLiveView {
mut:
	host    VSlimViewHost
	root_id string
	sockets map[string]&VSlimLiveSocket
}

@[php_class: 'VSlim\\Live\\Component']
@[heap]
struct VSlimLiveComponent {
mut:
	host       VSlimViewHost
	id         string
	assigns    map[string]string
	socket_ref &VSlimLiveSocket = unsafe { nil }
}

@[php_class: 'VSlim\\Live\\ComponentState']
@[heap]
struct VSlimLiveComponentState {
mut:
	component_id string
	socket_ref   &VSlimLiveSocket = unsafe { nil }
}

@[php_class: 'VSlim\\Config']
@[heap]
struct VSlimConfig {
mut:
	path   string
	loaded bool
	root   toml.Any = toml.null
}

fn (mut req VSlimRequest) free() {
	unsafe {
		req.method.free()
		req.raw_path.free()
		req.path.free()
		req.body.free()
		req.query_string.free()
		req.scheme.free()
		req.host.free()
		req.port.free()
		req.protocol_version.free()
		req.remote_addr.free()
		req.query.free()
		req.headers.free()
		req.cookies.free()
		req.attributes.free()
		req.server.free()
		req.uploaded_files.free()
		req.params.free()
	}
}

fn (mut res VSlimResponse) free() {
	unsafe {
		res.body.free()
		res.content_type.free()
		res.headers.free()
	}
}
