module main

import vphp

pub type VSlimHandler = fn (VSlimRequest) VSlimResponse

pub type VSlimNext = fn (VSlimRequest) VSlimResponse

pub type VSlimMiddleware = fn (VSlimRequest, VSlimNext) VSlimResponse

pub enum VSlimRouteHandlerType {
	native
	php_callable
}

pub struct VSlimRoute {
pub mut:
	method                   string
	name                     string
	pattern                  string
	handler_type             VSlimRouteHandlerType
	v_handler                VSlimHandler  = unsafe { nil }
	handler_ref              vphp.PhpValue = vphp.PhpValue.invalid()
	resource_action          string
	resource_missing_handler vphp.PhpCallable = vphp.PhpCallable.invalid()
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
	handlers []vphp.PhpValue
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
	route_handler            vphp.PhpValue = vphp.PhpValue.invalid()
	resource_action          string
	resource_missing_handler vphp.PhpCallable = vphp.PhpCallable.invalid()
}

struct PipelineRequestContext {
mut:
	path         string
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	route_params map[string]string
}

struct PipelineDispatchResult {
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
}

@[php_implements: 'Psr\\Http\\Server\\RequestHandlerInterface']
@[php_attr: 'VHttpd\\Attribute\\Dispatchable("http")']
@[php_class: 'VSlim\\App']
@[heap]
struct VSlimApp {
mut:
	routes                []VSlimRoute
	websocket_routes      []VSlimRoute                @[php_ignore]
	websocket_conn_route  map[string]int              @[php_ignore]
	before_middlewares    []vphp.PhpValue             @[php_ignore]
	middlewares           []vphp.PhpValue             @[php_ignore]
	after_middlewares     []vphp.PhpValue             @[php_ignore]
	group_before_middle   HookTable                   @[php_ignore]
	group_middle          HookTable                   @[php_ignore]
	group_after_middle    HookTable                   @[php_ignore]
	not_found_handler     vphp.PhpCallable            @[php_ignore]
	error_handler         vphp.PhpCallable            @[php_ignore]
	container_ref         &VSlimContainer  = unsafe { nil }             @[php_ignore]
	config_ref            &VSlimConfig     = unsafe { nil }                @[php_ignore]
	mcp_ref               &VSlimMcpApp     = unsafe { nil }                @[php_ignore]
	auth_user_resolver    vphp.PhpValue    = vphp.PhpValue.invalid()               @[php_ignore]
	auth_gate_resolver    vphp.PhpCallable = vphp.PhpCallable.invalid()            @[php_ignore]
	auth_redirect_path    string                      @[php_prop: authRedirectPath]
	base_path             string                      @[php_prop: basePath]
	use_demo              bool                        @[php_prop: useDemo]
	error_response_json   bool                        @[php_prop: errorResponseJson]
	view_base_path        string                      @[php_prop: viewBasePath]
	assets_prefix         string                      @[php_prop: assetsPrefix]
	view_cache_enabled    bool                        @[php_prop: viewCacheEnabled]
	view_cache_configured bool                        @[php_prop: viewCacheConfigured]
	view_helpers          map[string]vphp.PhpCallable @[php_ignore]
	logger_ref            &VSlimLogger                = unsafe { nil }                @[php_ignore]
	psr_logger_ref        &VSlimPsrLogger             = unsafe { nil }             @[php_ignore]
	clock_ref             vphp.PhpObject              = vphp.PhpObject.invalid()              @[php_ignore]
	listener_provider_ref &VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
	dispatcher_ref        &VSlimPsr14EventDispatcher  = unsafe { nil }  @[php_ignore]
	cache_ref             &VSlimPsr16Cache            = unsafe { nil }            @[php_ignore]
	cache_pool_ref        &VSlimPsr6CacheItemPool     = unsafe { nil }     @[php_ignore]
	http_client_ref       &VSlimPsr18Client           = unsafe { nil }           @[php_ignore]
	database_ref          &VSlimDatabaseManager       = unsafe { nil }       @[php_ignore]
	migrator_ref          &VSlimDatabaseMigrator      = unsafe { nil }      @[php_ignore]
	job_dispatcher_ref    &VSlimJobDispatcher         = unsafe { nil }         @[php_ignore]
	job_worker_ref        &VSlimJobWorker             = unsafe { nil }             @[php_ignore]
	providers             []vphp.PhpObject            @[php_ignore]
	provider_classes      map[string]bool             @[php_ignore]
	modules               []vphp.PhpObject            @[php_ignore]
	module_classes        map[string]bool             @[php_ignore]
	booted                bool
	live_ws_sockets       map[string]vphp.PhpObject @[php_ignore]
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
	middlewares []vphp.PhpValue
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
	server_params_ref  vphp.PhpArray
	cookie_params_ref  vphp.PhpArray
	query_params_ref   vphp.PhpArray
	uploaded_files_ref vphp.PhpArray
	parsed_body_ref    vphp.PhpValue
	attributes_ref     vphp.PhpValue
}

struct VSlimBeforeMiddlewareResult {
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
}

struct PhaseMiddlewareDispatchResult {
	response_ref vphp.PhpValue = vphp.PhpValue.null()
	payload_ref  vphp.PhpValue = vphp.PhpValue.null()
	continued    bool
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
