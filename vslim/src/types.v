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
	kind             MiddlewareTerminalKind = .none
	fixed_response_ref &VSlimPsr7Response = unsafe { nil }
	status           int
	message          string
	fallback_message string
	error_code       string
	allowed_methods  []string
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
	websocket_routes        []VSlimRoute
	websocket_conn_route    map[string]int
	php_before_middlewares  []vphp.PersistentOwnedZBox
	php_middlewares         []vphp.PersistentOwnedZBox
	php_after_middlewares   []vphp.PersistentOwnedZBox
	php_group_before_middle HookTable
	php_group_middle        HookTable
	php_group_after_middle  HookTable
	not_found_handler       vphp.PersistentOwnedZBox
	error_handler           vphp.PersistentOwnedZBox
	container_ref           &VSlimContainer = unsafe { nil }
	config_ref              &VSlimConfig    = unsafe { nil }
	mcp_ref                 &VSlimMcpApp    = unsafe { nil }
	base_path               string
	use_demo                bool
	error_response_json     bool
	view_base_path          string
	assets_prefix           string
	view_cache_enabled      bool
	view_cache_configured   bool
	view_helpers            map[string]vphp.PersistentOwnedZBox
	logger_ref              &VSlimLogger    = unsafe { nil }
	psr_logger_ref          &VSlimPsrLogger = unsafe { nil }
	clock_ref               vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	listener_provider_ref   &VSlimPsr14ListenerProvider = unsafe { nil }
	dispatcher_ref          &VSlimPsr14EventDispatcher  = unsafe { nil }
	cache_ref               &VSlimPsr16Cache            = unsafe { nil }
	cache_pool_ref          &VSlimPsr6CacheItemPool     = unsafe { nil }
	http_client_ref         &VSlimPsr18Client           = unsafe { nil }
	database_ref            &VSlimDatabaseManager       = unsafe { nil }
	migrator_ref            &VSlimDatabaseMigrator      = unsafe { nil }
	providers               []vphp.RetainedObject
	provider_classes        map[string]bool
	modules                 []vphp.RetainedObject
	module_classes          map[string]bool
	booted                  bool
	live_ws_sockets         map[string]vphp.PersistentOwnedZBox
}

@[heap]
struct MiddlewareChain {
	app         &VSlimApp            = unsafe { nil }
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
	app_ref &VSlimApp = unsafe { nil }
}

@[php_class: 'VSlim\\Support\\Module']
@[heap]
struct VSlimModule {
mut:
	app_ref &VSlimApp = unsafe { nil }
}

@[php_class: 'VSlim\\RouteGroup']
@[heap]
struct RouteGroup {
mut:
	app    &VSlimApp = unsafe { nil }
	prefix string
}

@[php_class: 'VSlim\\Vhttpd\\Request']
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

@[php_class: 'VSlim\\Vhttpd\\Client']
@[heap]
struct VSlimVhttpdClient {
mut:
	socket_path             string
	connect_timeout_seconds f64 = 2.0
}

@[php_class: 'VSlim\\Session\\Store']
@[heap]
struct VSlimSessionStore {
mut:
	cookie_name string = 'vslim_session'
	secret      string
	ttl_seconds int = 7200
	path        string = '/'
	domain      string
	secure      bool
	http_only   bool = true
	same_site   string = 'lax'
	values      map[string]string
	loaded      bool
	dirty       bool
	destroyed   bool
}

@[php_class: 'VSlim\\Auth\\SessionGuard']
@[heap]
struct VSlimAuthSessionGuard {
mut:
	store_ref &VSlimSessionStore = unsafe { nil }
	user_key  string             = 'auth.user_id'
}

@[php_class: 'VSlim\\Vhttpd\\Response']
@[heap]
struct VSlimResponse {
pub mut:
	status       int
	body         string
	content_type string
mut:
	headers map[string]string
}

@[php_class: 'VPhp\\VSlim\\Psr7Adapter']
@[heap]
struct VPhpVSlimPsr7Adapter {}

@[php_class: 'VSlim\\Stream\\Response']
@[heap]
struct VSlimStreamResponse {
pub mut:
	stream_type  string
	status       int
	content_type string
mut:
	headers    map[string]string
	chunks_ref vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
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
	on_open_handler    vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	on_message_handler vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	on_close_handler   vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	connections        map[string]vphp.PersistentOwnedZBox
	rooms              map[string][]string
}

@[php_attr: 'VPhp\\VHttpd\\Attribute\\Dispatchable("mcp")']
@[php_class: 'VSlim\\Mcp\\App']
@[heap]
struct VSlimMcpApp {
mut:
	method_handlers       map[string]vphp.PersistentOwnedZBox
	tool_handlers         map[string]vphp.PersistentOwnedZBox
	tool_descriptions     map[string]string
	tool_schemas          map[string]vphp.PersistentOwnedZBox
	resource_handlers     map[string]vphp.PersistentOwnedZBox
	resource_names        map[string]string
	resource_descriptions map[string]string
	resource_mime_types   map[string]string
	prompt_handlers       map[string]vphp.PersistentOwnedZBox
	prompt_descriptions   map[string]string
	prompt_arguments      map[string]vphp.PersistentOwnedZBox
	server_info           map[string]string
	server_capabilities   map[string]vphp.PersistentOwnedZBox
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

@[php_implements: 'Psr\\Log\\LoggerInterface']
@[php_class: 'VSlim\\Log\\PsrLogger']
@[heap]
struct VSlimPsrLogger {
mut:
	logger_ref &VSlimLogger = unsafe { nil }
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
	stream_ref        &VSlimPsr7Stream = unsafe { nil }
	size_hint         int              = -1
	error_code        int
	client_filename   string
	client_media_type string
	moved             bool
	target_path       string
}

@[php_implements: 'Psr\\Http\\Message\\ResponseInterface']
@[php_class: 'VSlim\\Psr7\\Response']
@[heap]
struct VSlimPsr7Response {
mut:
	status           int = 200
	reason_phrase    string
	protocol_version string = '1.1'
	headers          map[string][]string
	header_names     map[string]string
	body_ref         &VSlimPsr7Stream = unsafe { nil }
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
	request_target   string
	protocol_version string = '1.1'
	headers          map[string][]string
	header_names     map[string]string
	body_ref         &VSlimPsr7Stream = unsafe { nil }
	uri_ref          &VSlimPsr7Uri    = unsafe { nil }
}

@[php_implements: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_class: 'VSlim\\Psr7\\ServerRequest']
@[heap]
struct VSlimPsr7ServerRequest {
mut:
	method             string = 'GET'
	request_target     string
	protocol_version   string = '1.1'
	headers            map[string][]string
	header_names       map[string]string
	body_ref           &VSlimPsr7Stream         = unsafe { nil }
	uri_ref            &VSlimPsr7Uri            = unsafe { nil }
	server_params_ref  vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	cookie_params_ref  vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	query_params_ref   vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	uploaded_files_ref vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	parsed_body_ref    vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	attributes_ref     vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
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
	clock_ref           vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	namespace_prefix    string
	default_ttl_seconds int
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
	value_ref       vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	clock_ref       vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	hit             bool
	has_value       bool
	expires_at_unix i64
}

@[php_implements: 'Psr\\Cache\\CacheItemPoolInterface']
@[php_class: 'VSlim\\Psr6\\CacheItemPool']
@[heap]
struct VSlimPsr6CacheItemPool {
mut:
	entries             map[string]PsrCacheEntry
	deferred            map[string]Psr6DeferredEntry
	clock_ref           vphp.PersistentOwnedZBox = vphp.PersistentOwnedZBox.new_null()
	namespace_prefix    string
	default_ttl_seconds int
}

@[php_implements: 'Psr\\Http\\Client\\ClientExceptionInterface']
@[php_class: 'VSlim\\Psr18\\ClientException']
@[php_extends: 'Exception']
@[heap]
struct VSlimPsr18ClientException {}

@[php_implements: 'Psr\\Http\\Client\\RequestExceptionInterface']
@[php_class: 'VSlim\\Psr18\\RequestException']
@[php_extends: 'VSlim\\Psr18\\ClientException']
@[php_prop: 'request_ref']
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
	timeout_seconds int = 30
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
	pool_size       int    = 5
	pool_name       string = 'default'
	timeout_ms      int    = 1000
	upstream_socket string
}

@[php_class: 'VSlim\\Database\\Manager']
@[heap]
struct VSlimDatabaseManager {
mut:
	config_ref         &VSlimDatabaseConfig = unsafe { nil }
	vhttpd_client_ref  &VSlimVhttpdClient   = unsafe { nil }
	mysql_pool         mysql.ConnectionPool
	mysql_connected    bool
	mysql_tx_conn      mysql.DB
	mysql_tx_active    bool
	upstream_connected bool
	upstream_tx_active bool
	upstream_session_id string
	last_affected_rows u64
	last_insert_id     i64
	last_error         string
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
	manager_ref     &VSlimDatabaseManager = unsafe { nil }
	table_name      string
	kind            VSlimDatabaseQueryKind = .select_
	select_columns  []string
	where_clauses   []VSlimDatabaseWhereClause
	order_clauses   []string
	limit_count     int = -1
	offset_count    int = -1
	mutation_values map[string]string
}

@[php_class: 'VSlim\\Database\\Model']
@[heap]
struct VSlimDatabaseModel {
mut:
	manager_ref   &VSlimDatabaseManager = unsafe { nil }
	table_name    string
	primary_key   string = 'id'
	attributes    map[string]string
	exists_in_db  bool
}

@[php_class: 'VSlim\\Database\\Migration']
@[heap]
struct VSlimDatabaseMigration {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil }
	name        string
}

@[php_class: 'VSlim\\Database\\Seeder']
@[heap]
struct VSlimDatabaseSeeder {
mut:
	manager_ref &VSlimDatabaseManager = unsafe { nil }
	name        string
}

@[php_class: 'VSlim\\Database\\Migrator']
@[heap]
struct VSlimDatabaseMigrator {
mut:
	manager_ref      &VSlimDatabaseManager = unsafe { nil }
	migrations_path  string = 'database/migrations'
	seeds_path       string = 'database/seeds'
	table_name       string = 'vslim_migrations'
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
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil }
}

@[php_class: 'VSlim\\Dev\\PhpSignatureProbe']
@[heap]
struct VSlimPhpSignatureProbe {
mut:
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil }
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

@[php_class: 'VSlim\\Validate\\Validator']
@[heap]
struct VSlimValidator {
mut:
	input_data      map[string]vphp.DynValue
	rule_map        map[string][]string
	error_map       map[string][]string
	validated_data  map[string]vphp.DynValue
	validation_ran  bool
}

@[php_class: 'VSlim\\Config']
@[heap]
struct VSlimConfig {
mut:
	path   string
	loaded bool
	root   toml.Any = toml.null
}

fn (req &VSlimRequest) free() {
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

fn (res &VSlimResponse) free() {
	unsafe {
		res.body.free()
		res.content_type.free()
		res.headers.free()
	}
}
