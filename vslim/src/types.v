module main

import db.mysql
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
	php_handler              vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	resource_action          string
	resource_missing_handler vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
}

pub struct RoutePath {}

pub struct VSlimRuntime {
mut:
	routes      []VSlimRoute
	middlewares []VSlimMiddleware
}

struct HookTable {
mut:
	prefixes []string
	handlers []vphp.PersistentOwnedZBox
}

enum MiddlewareRegistrationKind {
	standard
	before
	after
}

enum MiddlewareTerminalKind {
	none
	fixed_response
	not_found
	method_not_allowed
	error_response
}

struct MiddlewareTerminalMeta {
mut:
	kind               MiddlewareTerminalKind = .none
	fixed_response_ref &VSlimPsr7Response     = unsafe { nil }
	status             int
	message            string
	fallback_message   string
	error_code         string
	allowed_methods    []string
}

struct RawDispatchPlan {
mut:
	route_params             map[string]string
	terminal_meta            MiddlewareTerminalMeta
	route_handler            vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	resource_action          string
	resource_missing_handler vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
}

struct PipelineRequestContext {
mut:
	path         string
	payload_ref  vphp.RequestOwnedZBox = vphp.RequestOwnedZBox.new_null()
	route_params map[string]string
}

@[php_attr: 'VPhp\\VHttpd\\Attribute\\Dispatchable("http")']
@[php_implements: 'Psr\\Http\\Server\\RequestHandlerInterface']
@[php_class: 'VSlim\\App']
@[heap]
struct VSlimApp {
mut:
	routes                  []VSlimRoute
	websocket_routes        []VSlimRoute             @[php_ignore]
	websocket_conn_route    map[string]int           @[php_ignore]
	php_before_middlewares  []vphp.PersistentOwnedZBox @[php_ignore]
	php_middlewares         []vphp.PersistentOwnedZBox @[php_ignore]
	php_after_middlewares   []vphp.PersistentOwnedZBox @[php_ignore]
	php_group_before_middle HookTable               @[php_ignore]
	php_group_middle        HookTable               @[php_ignore]
	php_group_after_middle  HookTable               @[php_ignore]
	not_found_handler       vphp.PersistentOwnedZBox @[php_ignore]
	error_handler           vphp.PersistentOwnedZBox @[php_ignore]
	container_ref           &VSlimContainer          = unsafe { nil } @[php_ignore]
	config_ref              &VSlimConfig             = unsafe { nil } @[php_ignore]
	mcp_ref                 &VSlimMcpApp             = unsafe { nil } @[php_ignore]
	auth_user_resolver      vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	auth_gate_resolver      vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	auth_redirect_path      string @[php_prop: authRedirectPath]
	base_path               string @[php_prop: basePath]
	use_demo                bool   @[php_prop: useDemo]
	error_response_json     bool   @[php_prop: errorResponseJson]
	view_base_path          string @[php_prop: viewBasePath]
	assets_prefix           string @[php_prop: assetsPrefix]
	view_cache_enabled      bool   @[php_prop: viewCacheEnabled]
	view_cache_configured   bool   @[php_prop: viewCacheConfigured]
	view_helpers            map[string]vphp.PersistentOwnedZBox @[php_ignore]
	logger_ref              &VSlimLogger                = unsafe { nil } @[php_ignore]
	psr_logger_ref          &VSlimPsrLogger             = unsafe { nil } @[php_ignore]
	clock_ref               vphp.PersistentOwnedZBox    = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	listener_provider_ref   &VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
	dispatcher_ref          &VSlimPsr14EventDispatcher  = unsafe { nil } @[php_ignore]
	cache_ref               &VSlimPsr16Cache            = unsafe { nil } @[php_ignore]
	cache_pool_ref          &VSlimPsr6CacheItemPool     = unsafe { nil } @[php_ignore]
	http_client_ref         &VSlimPsr18Client           = unsafe { nil } @[php_ignore]
	database_ref            &VSlimDatabaseManager       = unsafe { nil } @[php_ignore]
	migrator_ref            &VSlimDatabaseMigrator      = unsafe { nil } @[php_ignore]
	job_dispatcher_ref      &VSlimJobDispatcher         = unsafe { nil } @[php_ignore]
	job_worker_ref          &VSlimJobWorker             = unsafe { nil } @[php_ignore]
	providers               []vphp.RetainedObject      @[php_ignore]
	provider_classes        map[string]bool            @[php_ignore]
	modules                 []vphp.RetainedObject      @[php_ignore]
	module_classes          map[string]bool            @[php_ignore]
	booted                  bool
	live_ws_sockets         map[string]vphp.PersistentOwnedZBox @[php_ignore]
}

@[php_class: 'VSlim\\Testing\\Harness']
@[heap]
struct VSlimTestingHarness {
mut:
	app_ref &VSlimApp = unsafe { nil } @[php_ignore]
	cookies map[string]string
}

@[heap]
struct MiddlewareChain {
	app         &VSlimApp = unsafe { nil }
	request_ctx PipelineRequestContext
mut:
	middlewares []vphp.RequestOwnedZBox
	plan        RawDispatchPlan
	index       int
}

enum Psr15NextHandlerMode {
	middleware_chain
	fixed_response
	continue_marker
}

struct Psr15NextHandlerState {
mut:
	mode                  Psr15NextHandlerMode = .continue_marker
	chain_ref             &MiddlewareChain     = unsafe { nil }
	fixed_response_ref    &VSlimPsr7Response   = unsafe { nil }
	has_forwarded_request bool
}

@[php_implements: 'Psr\\Http\\Server\\RequestHandlerInterface']
@[php_class: 'VSlim\\Psr15\\NextHandler']
@[heap]
struct VSlimPsr15NextHandler {
mut:
	state Psr15NextHandlerState
}

@[php_implements: 'Psr\\Http\\Server\\RequestHandlerInterface']
@[php_class: 'VSlim\\Psr15\\ContinueHandler']
@[heap]
struct VSlimPsr15ContinueHandler {
mut:
	state Psr15NextHandlerState
}

struct PhaseForwardedServerRequestSnapshot {
	method             string
	request_target     string
	protocol_version   string
	headers            map[string][]string
	body_content       string
	body_position      int
	body_detached      bool
	body_metadata      map[string]string
	uri_scheme         string
	uri_user           string
	uri_password       string
	uri_host           string
	uri_port           int = -1
	uri_path           string
	uri_query          string
	uri_fragment       string
	header_names       map[string]string
	server_params_ref  vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	cookie_params_ref  vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	query_params_ref   vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	uploaded_files_ref vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	parsed_body_ref    vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	attributes_ref     vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
}

struct VSlimBeforeMiddlewareResult {
	response_ref vphp.RequestOwnedZBox = vphp.RequestOwnedZBox.new_null()
	payload_ref  vphp.RequestOwnedZBox = vphp.RequestOwnedZBox.new_null()
}

struct PhaseMiddlewareDispatchResult {
	raw_response_ref vphp.RequestOwnedZBox = vphp.RequestOwnedZBox.new_null()
	payload_ref      vphp.RequestOwnedZBox = vphp.RequestOwnedZBox.new_null()
	continued        bool
}

@[php_class: 'VSlim\\Support\\ServiceProvider']
@[heap]
struct VSlimServiceProvider {
mut:
	app_ref &VSlimApp = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Support\\Module']
@[heap]
struct VSlimModule {
mut:
	app_ref &VSlimApp = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\RouteGroup']
@[heap]
struct RouteGroup {
mut:
	app    &VSlimApp = unsafe { nil }
	prefix string
}

@[php_class: 'VSlim\\VHttpd\\Request']
@[heap]
struct VSlimRequest {
pub mut:
	method           string
	raw_path         string @[php_prop: rawPath]
	body             string
	scheme           string
	host             string
	port             string
	protocol_version string @[php_prop: protocolVersion]
	remote_addr      string @[php_prop: remoteAddr]
mut:
	path           string @[php_ignore]
	query_string   string @[php_ignore]
	query          map[string]string
	headers        map[string]string
	cookies        map[string]string
	attributes     map[string]string
	server         map[string]string
	uploaded_files []string @[php_prop: uploadedFiles]
	params         map[string]string
}

@[php_class: 'VSlim\\VHttpd\\Client']
@[heap]
struct VSlimVhttpdClient {
mut:
	socket_path             string @[php_prop: socketPath]
	connect_timeout_seconds f64    = 2.0 @[php_prop: connectTimeoutSeconds]
}

@[php_class: 'VSlim\\Session\\Store']
@[heap]
struct VSlimSessionStore {
mut:
	cookie_name string = 'vslim_session' @[php_prop: cookieName]
	secret      string
	ttl_seconds int    = 7200 @[php_prop: ttlSeconds]
	path        string = '/'
	domain      string
	secure      bool
	http_only   bool   = true @[php_prop: httpOnly]
	same_site   string = 'lax' @[php_prop: sameSite]
	values      map[string]string @[php_ignore]
	loaded      bool
	dirty       bool @[php_ignore]
	destroyed   bool @[php_ignore]
}

@[php_class: 'VSlim\\Auth\\SessionGuard']
@[heap]
struct VSlimAuthSessionGuard {
mut:
	store_ref &VSlimSessionStore = unsafe { nil } @[php_ignore]
	user_key  string             = 'auth.user_id' @[php_prop: userKey]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Session\\StartMiddleware']
@[heap]
struct VSlimSessionStartMiddleware {
mut:
	app_ref &VSlimApp = unsafe { nil } @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\RequireAuthMiddleware']
@[heap]
struct VSlimAuthRequireMiddleware {
mut:
	app_ref       &VSlimApp = unsafe { nil } @[php_ignore]
	redirect_path string    @[php_prop: redirectPath]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\GuestMiddleware']
@[heap]
struct VSlimAuthGuestMiddleware {
mut:
	app_ref       &VSlimApp = unsafe { nil } @[php_ignore]
	redirect_path string    @[php_prop: redirectPath]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\RequireAbilityMiddleware']
@[heap]
struct VSlimAuthRequireAbilityMiddleware {
mut:
	app_ref &VSlimApp = unsafe { nil } @[php_ignore]
	ability string
	status  int = 403
	message string
}

@[php_class: 'VSlim\\VHttpd\\Response']
@[heap]
struct VSlimResponse {
pub mut:
	status       int
	body         string
	content_type string @[php_prop: contentType]
mut:
	headers map[string]string
}

@[php_class: 'VSlim\\Psr7Adapter']
@[heap]
struct VSlimPsr7Adapter {}

@[php_class: 'VSlim\\Debug\\ObjectProbe']
@[heap]
struct VSlimDebugObjectProbe {}

@[php_class: 'VSlim\\Stream\\Response']
@[heap]
struct VSlimStreamResponse {
pub mut:
	stream_type  string @[php_prop: streamType]
	status       int
	content_type string @[php_prop: contentType]
mut:
	headers    map[string]string
	chunks_ref vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
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

@[php_attr: 'VPhp\\VHttpd\\Attribute\\Dispatchable("websocket")']
@[php_class: 'VSlim\\WebSocket\\App']
@[heap]
struct VSlimWebSocketApp {
mut:
	on_open_handler    vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	on_message_handler vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	on_close_handler   vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	connections        map[string]vphp.PersistentOwnedZBox
	rooms              map[string][]string
}

@[php_attr: 'VPhp\\VHttpd\\Attribute\\Dispatchable("mcp")']
@[php_class: 'VSlim\\Mcp\\App']
@[heap]
struct VSlimMcpApp {
mut:
	method_handlers       map[string]vphp.PersistentOwnedZBox @[php_ignore]
	tool_handlers         map[string]vphp.PersistentOwnedZBox @[php_ignore]
	tool_descriptions     map[string]string @[php_ignore]
	tool_schemas          map[string]vphp.PersistentOwnedZBox @[php_ignore]
	resource_handlers     map[string]vphp.PersistentOwnedZBox @[php_ignore]
	resource_names        map[string]string @[php_ignore]
	resource_descriptions map[string]string @[php_ignore]
	resource_mime_types   map[string]string @[php_ignore]
	prompt_handlers       map[string]vphp.PersistentOwnedZBox @[php_ignore]
	prompt_descriptions   map[string]string @[php_ignore]
	prompt_arguments      map[string]vphp.PersistentOwnedZBox @[php_ignore]
	server_info           map[string]string @[php_ignore]
	server_capabilities   map[string]vphp.PersistentOwnedZBox @[php_ignore]
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
	local_time_enabled bool   = true @[php_prop: localTimeEnabled]
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

@[php_implements: 'Psr\\Http\\Message\\StreamInterface']
@[php_class: 'VSlim\\Psr7\\Stream']
@[heap]
struct VSlimPsr7Stream {
mut:
	content  string
	position int
	detached bool
	metadata map[string]string
}

@[php_implements: 'Psr\\Http\\Message\\UploadedFileInterface']
@[php_class: 'VSlim\\Psr7\\UploadedFile']
@[heap]
struct VSlimPsr7UploadedFile {
mut:
	stream_ref        &VSlimPsr7Stream = unsafe { nil } @[php_ignore]
	size_hint         int              = -1 @[php_ignore]
	error_code        int              @[php_ignore]
	client_filename   string           @[php_ignore]
	client_media_type string           @[php_ignore]
	moved             bool
	target_path       string @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\ResponseInterface']
@[php_class: 'VSlim\\Psr7\\Response']
@[heap]
struct VSlimPsr7Response {
mut:
	status           int = 200
	reason_phrase    string @[php_ignore]
	protocol_version string = '1.1' @[php_ignore]
	headers          map[string][]string @[php_ignore]
	header_names     map[string]string @[php_ignore]
	body_ref         &VSlimPsr7Stream = unsafe { nil } @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\UriInterface']
@[php_class: 'VSlim\\Psr7\\Uri']
@[heap]
struct VSlimPsr7Uri {
mut:
	scheme   string
	user     string
	password string
	host     string
	port     int = -1
	path     string
	query    string
	fragment string
}

@[php_implements: 'Psr\\Http\\Message\\RequestInterface']
@[php_class: 'VSlim\\Psr7\\Request']
@[heap]
struct VSlimPsr7Request {
mut:
	method           string = 'GET'
	request_target   string @[php_ignore]
	protocol_version string = '1.1' @[php_ignore]
	headers          map[string][]string @[php_ignore]
	header_names     map[string]string @[php_ignore]
	body_ref         &VSlimPsr7Stream = unsafe { nil } @[php_ignore]
	uri_ref          &VSlimPsr7Uri    = unsafe { nil } @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_class: 'VSlim\\Psr7\\ServerRequest']
@[heap]
struct VSlimPsr7ServerRequest {
mut:
	method             string = 'GET'
	request_target     string @[php_ignore]
	protocol_version   string = '1.1' @[php_ignore]
	headers            map[string][]string @[php_ignore]
	header_names       map[string]string @[php_ignore]
	body_ref           &VSlimPsr7Stream         = unsafe { nil } @[php_ignore]
	uri_ref            &VSlimPsr7Uri            = unsafe { nil } @[php_ignore]
	server_params_ref  vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	cookie_params_ref  vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	query_params_ref   vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	uploaded_files_ref vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	parsed_body_ref    vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	attributes_ref     vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\ResponseFactoryInterface']
@[php_class: 'VSlim\\Psr17\\ResponseFactory']
@[heap]
struct VSlimPsr17ResponseFactory {}

@[php_implements: 'Psr\\Http\\Message\\RequestFactoryInterface']
@[php_class: 'VSlim\\Psr17\\RequestFactory']
@[heap]
struct VSlimPsr17RequestFactory {}

@[php_implements: 'Psr\\Http\\Message\\StreamFactoryInterface']
@[php_class: 'VSlim\\Psr17\\StreamFactory']
@[heap]
struct VSlimPsr17StreamFactory {}

@[php_implements: 'Psr\\Http\\Message\\UploadedFileFactoryInterface']
@[php_class: 'VSlim\\Psr17\\UploadedFileFactory']
@[heap]
struct VSlimPsr17UploadedFileFactory {}

@[php_implements: 'Psr\\Http\\Message\\UriFactoryInterface']
@[php_class: 'VSlim\\Psr17\\UriFactory']
@[heap]
struct VSlimPsr17UriFactory {}

@[php_implements: 'Psr\\Http\\Message\\ServerRequestFactoryInterface']
@[php_class: 'VSlim\\Psr17\\ServerRequestFactory']
@[heap]
struct VSlimPsr17ServerRequestFactory {}

struct PsrCacheEntry {
mut:
	value           vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	expires_at_unix i64
}

struct Psr6DeferredEntry {
mut:
	value           vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	has_value       bool
	expires_at_unix i64
}

@[php_implements: 'Psr\\SimpleCache\\CacheException']
@[php_class: 'VSlim\\Psr16\\CacheException']
@[php_extends: 'Exception']
@[heap]
struct VSlimPsr16CacheException {}

@[php_implements: 'Psr\\SimpleCache\\InvalidArgumentException']
@[php_class: 'VSlim\\Psr16\\InvalidArgumentException']
@[php_extends: 'VSlim\\Psr16\\CacheException']
@[heap]
struct VSlimPsr16InvalidArgumentException {}

@[php_implements: 'Psr\\SimpleCache\\CacheInterface']
@[php_class: 'VSlim\\Psr16\\Cache']
@[heap]
struct VSlimPsr16Cache {
mut:
	entries             map[string]PsrCacheEntry
	clock_ref           vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	namespace_prefix    string @[php_prop: namespacePrefix]
	default_ttl_seconds int    @[php_prop: defaultTtlSeconds]
}

@[php_class: 'VSlim\\Psr6\\CacheException']
@[php_implements: 'Psr\\Cache\\CacheException']
@[php_extends: 'Exception']
@[heap]
struct VSlimPsr6CacheException {}

@[php_class: 'VSlim\\Psr6\\InvalidArgumentException']
@[php_implements: 'Psr\\Cache\\InvalidArgumentException']
@[php_extends: 'VSlim\\Psr6\\CacheException']
@[heap]
struct VSlimPsr6InvalidArgumentException {}

@[php_implements: 'Psr\\Cache\\CacheItemInterface']
@[php_class: 'VSlim\\Psr6\\CacheItem']
@[heap]
struct VSlimPsr6CacheItem {
mut:
	key             string
	value_ref       vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	clock_ref       vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	hit             bool
	has_value       bool @[php_prop: hasValue]
	expires_at_unix i64  @[php_prop: expiresAtUnix]
}

@[php_implements: 'Psr\\Cache\\CacheItemPoolInterface']
@[php_class: 'VSlim\\Psr6\\CacheItemPool']
@[heap]
struct VSlimPsr6CacheItemPool {
mut:
	entries             map[string]PsrCacheEntry
	deferred            map[string]Psr6DeferredEntry
	clock_ref           vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
	namespace_prefix    string @[php_prop: namespacePrefix]
	default_ttl_seconds int    @[php_prop: defaultTtlSeconds]
}

@[php_implements: 'Psr\\Http\\Client\\ClientExceptionInterface']
@[php_class: 'VSlim\\Psr18\\ClientException']
@[php_extends: 'Exception']
@[heap]
struct VSlimPsr18ClientException {}

@[php_implements: 'Psr\\Http\\Client\\RequestExceptionInterface']
@[php_class: 'VSlim\\Psr18\\RequestException']
@[php_extends: 'VSlim\\Psr18\\ClientException']
@[php_prop: 'requestRef']
@[heap]
struct VSlimPsr18RequestException {}

@[php_implements: 'Psr\\Http\\Client\\NetworkExceptionInterface']
@[php_extends: 'VSlim\\Psr18\\RequestException']
@[php_class: 'VSlim\\Psr18\\NetworkException']
@[heap]
struct VSlimPsr18NetworkException {}

@[php_implements: 'Psr\\Http\\Client\\ClientInterface']
@[php_class: 'VSlim\\Psr18\\Client']
@[heap]
struct VSlimPsr18Client {
mut:
	timeout_seconds int = 30 @[php_prop: timeoutSeconds]
}

@[php_class: 'VSlim\\Database\\Config']
@[heap]
struct VSlimDatabaseConfig {
mut:
	driver          string = 'mysql'
	transport       string = 'direct'
	host            string = '127.0.0.1'
	port            int    = 3306
	username        string
	password        string
	database        string
	pool_size       int    = 5 @[php_prop: poolSize]
	pool_name       string = 'default' @[php_prop: poolName]
	timeout_ms      int    = 1000 @[php_prop: timeoutMs]
	upstream_socket string @[php_prop: upstreamSocket]
}

@[php_class: 'VSlim\\Database\\Manager']
@[heap]
struct VSlimDatabaseManager {
mut:
	config_ref          &VSlimDatabaseConfig = unsafe { nil } @[php_ignore]
	vhttpd_client_ref   &VSlimVhttpdClient   = unsafe { nil } @[php_ignore]
	mysql_pool          mysql.ConnectionPool @[php_ignore]
	mysql_connected     bool @[php_ignore]
	mysql_tx_conn       mysql.DB @[php_ignore]
	mysql_tx_active     bool @[php_ignore]
	upstream_connected  bool @[php_ignore]
	upstream_tx_active  bool @[php_ignore]
	upstream_session_id string @[php_ignore]
	last_affected_rows  u64 @[php_prop: lastAffectedRows]
	last_insert_id      i64 @[php_prop: lastInsertId]
	last_error          string @[php_prop: lastError]
}

enum VSlimDatabaseAsyncKind {
	query
	execute
}

struct VSlimDatabaseAsyncJob {
mut:
	config VSlimDatabaseConfig
	kind   VSlimDatabaseAsyncKind
	query  string
	params []string
}

@[php_class: 'VSlim\\Database\\PendingResult']
@[heap]
struct VSlimDatabasePendingResult {
mut:
	async_ref      &VSlimAsyncHandle = unsafe { nil } @[php_ignore]
	active         bool
	resolved       bool
	kind           VSlimDatabaseAsyncKind = .query
	affected_rows  u64 @[php_prop: affectedRows]
	last_insert_id i64 @[php_prop: lastInsertId]
	last_error     string @[php_prop: lastError]
	result_box     vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
}

pub enum VSlimDatabaseQueryKind {
	select_
	insert
	update
	delete_
}

struct VSlimDatabaseWhereClause {
	column string
	op     string
	value  string
}

@[php_class: 'VSlim\\Database\\Query']
@[heap]
struct VSlimDatabaseQuery {
mut:
	manager_ref     &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	table_name      string @[php_prop: tableName]
	kind            VSlimDatabaseQueryKind = .select_
	select_columns  []string @[php_ignore]
	where_clauses   []VSlimDatabaseWhereClause @[php_ignore]
	order_clauses   []string @[php_ignore]
	limit_count     int = -1 @[php_prop: limitCount]
	offset_count    int = -1 @[php_prop: offsetCount]
	mutation_values map[string]string @[php_ignore]
}

@[php_class: 'VSlim\\Database\\Model']
@[heap]
struct VSlimDatabaseModel {
mut:
	manager_ref  &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	table_name   string @[php_prop: tableName]
	primary_key  string = 'id' @[php_prop: primaryKey]
	attributes   map[string]string @[php_ignore]
	exists_in_db bool @[php_prop: existsInDb]
}

@[php_class: 'VSlim\\Database\\Migration']
@[heap]
struct VSlimDatabaseMigration {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	name        string
}

@[php_class: 'VSlim\\Database\\Seeder']
@[heap]
struct VSlimDatabaseSeeder {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	name        string
}

@[php_class: 'VSlim\\Database\\Migrator']
@[heap]
struct VSlimDatabaseMigrator {
mut:
	manager_ref     &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	migrations_path string                = 'database/migrations' @[php_prop: migrationsPath]
	seeds_path      string                = 'database/seeds' @[php_prop: seedsPath]
	table_name      string                = 'vslim_migrations' @[php_prop: tableName]
}

@[php_implements: 'Psr\\Clock\\ClockInterface']
@[php_class: 'VSlim\\Psr20\\Clock']
@[heap]
struct VSlimPsr20Clock {}

@[php_implements: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_class: 'VSlim\\Psr14\\ListenerProvider']
@[heap]
struct VSlimPsr14ListenerProvider {
mut:
	listeners map[string][]vphp.PersistentOwnedZBox
}

@[php_implements: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_class: 'VSlim\\Psr14\\EventDispatcher']
@[heap]
struct VSlimPsr14EventDispatcher {
mut:
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Dev\\PhpSignatureProbe']
@[heap]
struct VSlimPhpSignatureProbe {
mut:
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
}

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
	redirect_to string @[php_prop: redirectTo]
	navigate_to string @[php_prop: navigateTo]
	raw_path    string @[php_prop: rawPath]
	root_id     string @[php_prop: rootId]
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
	socket_ref       &VSlimLiveSocket = unsafe { nil } @[php_ignore]
	fields           []string
	last_error_count int @[php_prop: lastErrorCount]
	validated        bool
}

@[php_class: 'VSlim\\Live\\View']
@[heap]
struct VSlimLiveView {
mut:
	host    VSlimViewHost
	root_id string @[php_prop: rootId]
	sockets map[string]&VSlimLiveSocket
}

@[php_class: 'VSlim\\Live\\Component']
@[heap]
struct VSlimLiveComponent {
mut:
	host       VSlimViewHost
	id         string
	assigns    map[string]string
	socket_ref &VSlimLiveSocket = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Live\\ComponentState']
@[heap]
struct VSlimLiveComponentState {
mut:
	component_id string           @[php_prop: componentId]
	socket_ref   &VSlimLiveSocket = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Validate\\Validator']
@[heap]
struct VSlimValidator {
mut:
	input_data     map[string]vphp.DynValue  @[php_prop: inputData]
	rule_map       map[string][]string       @[php_prop: ruleMap]
	error_map      map[string][]string       @[php_prop: errorMap]
	validated_data map[string]vphp.DynValue  @[php_prop: validatedData]
	validation_ran bool                      @[php_prop: validationRan]
}

@[php_class: 'VSlim\\EnvLoader']
@[heap]
struct VSlimEnvLoader {}

@[php_class: 'VSlim\\Task']
@[heap]
struct VSlimTask {}

@[php_class: 'VSlim\\TaskHandle']
@[heap]
struct VSlimTaskHandle {
mut:
	async_ref &vphp.AsyncResult = unsafe { nil } @[php_ignore]
	// Task handles are request-scoped PHP objects, but the callable / params /
	// cached result must outlive the spawn() stack frame and survive until a
	// later wait() or object cleanup(). We therefore retain them with
	// PersistentOwnedZBox under explicit handle ownership and release them from
	// cleanup()/generic_free_raw(), rather than borrowing transient request zvals.
	callable   vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	params     []vphp.PersistentOwnedZBox
	resolved   bool
	result_box vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null() @[php_ignore]
}

@[php_class: 'VSlim\\Job\\Dispatcher']
@[heap]
struct VSlimJobDispatcher {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Job\\Worker']
@[heap]
struct VSlimJobWorker {
mut:
	manager_ref          &VSlimDatabaseManager = unsafe { nil } @[php_ignore]
	worker_id            string                = 'default' @[php_prop: workerId]
	retry_delay_seconds  int                   = 60 @[php_prop: retryDelaySeconds]
	reserve_timeout_secs int                   = 300 @[php_prop: reserveTimeoutSeconds]
}

@[php_class: 'VSlim\\Config']
@[heap]
struct VSlimConfig {
mut:
	path   string
	loaded bool
	root   toml.Any = toml.null
}

pub fn (req &VSlimRequest) free() {
	_ = req
}

pub fn (res &VSlimResponse) free() {
	_ = res
}
