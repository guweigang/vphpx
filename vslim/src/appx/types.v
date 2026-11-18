module appx

import cachex
import configx as cfgx
import containerx
import databasex
import eventx
import httpx
import jobx
import loggerx
import mcpx as mcp
import routex
import supportx
import vphp

@[vphp.PhpImplements(names: 'Psr\\Http\\Server\\RequestHandlerInterface')]
@[vphp.PhpClassAttribute(name: 'VHttpd\\Attribute\\Dispatchable', args: '"http"')]
@[vphp.PhpExportClass(name: 'VSlim\\App')]
@[heap]
pub struct VSlimApp {
mut:
	routes                []routex.VSlimRoute
	route_index           routex.RouteIndex                                       @[vphp.PhpIgnoreField]
	websocket_routes      []routex.VSlimRoute                                     @[vphp.PhpIgnoreField]
	websocket_conn_route  map[string]int                                          @[vphp.PhpIgnoreField]
	before_middlewares    []vphp.PhpValue                                         @[vphp.PhpIgnoreField]
	middlewares           []vphp.PhpValue                                         @[vphp.PhpIgnoreField]
	after_middlewares     []vphp.PhpValue                                         @[vphp.PhpIgnoreField]
	group_before_middle   routex.HookTable                                        @[vphp.PhpIgnoreField]
	group_middle          routex.HookTable                                        @[vphp.PhpIgnoreField]
	group_after_middle    routex.HookTable                                        @[vphp.PhpIgnoreField]
	not_found_handler     vphp.PhpCallable                                        @[vphp.PhpIgnoreField]
	error_handler         vphp.PhpCallable                                        @[vphp.PhpIgnoreField]
	container_ref         &containerx.VSlimContainer = unsafe { nil }             @[vphp.PhpIgnoreField]
	config_ref            &cfgx.VSlimConfig          = unsafe { nil }             @[vphp.PhpIgnoreField]
	mcp_ref               &mcp.VSlimMcpApp           = unsafe { nil }             @[vphp.PhpIgnoreField]
	auth_user_resolver    vphp.PhpValue              = vphp.PhpValue.invalid()    @[vphp.PhpIgnoreField]
	auth_gate_resolver    vphp.PhpCallable           = vphp.PhpCallable.invalid() @[vphp.PhpIgnoreField]
	auth_redirect_path    string                                                        @[vphp.PhpProperty; vphp.PhpProperty_name: 'authRedirectPath']
	base_path             string                                                        @[vphp.PhpProperty; vphp.PhpProperty_name: 'basePath']
	use_demo              bool                                                          @[vphp.PhpProperty; vphp.PhpProperty_name: 'useDemo']
	error_response_json   bool                                                          @[vphp.PhpProperty; vphp.PhpProperty_name: 'errorResponseJson']
	view_base_path        string                                                        @[vphp.PhpProperty; vphp.PhpProperty_name: 'viewBasePath']
	assets_prefix         string                                                        @[vphp.PhpProperty; vphp.PhpProperty_name: 'assetsPrefix']
	view_cache_enabled    bool                                                          @[vphp.PhpProperty; vphp.PhpProperty_name: 'viewCacheEnabled']
	view_cache_configured bool                                                          @[vphp.PhpProperty; vphp.PhpProperty_name: 'viewCacheConfigured']
	view_helpers          map[string]vphp.PhpCallable                                   @[vphp.PhpIgnoreField]
	logger_ref            &loggerx.VSlimLogger               = unsafe { nil }           @[vphp.PhpIgnoreField]
	psr_logger_ref        &loggerx.VSlimPsrLogger            = unsafe { nil }           @[vphp.PhpIgnoreField]
	clock_ref             vphp.PhpObject                     = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
	listener_provider_ref &eventx.VSlimPsr14ListenerProvider = unsafe { nil }           @[vphp.PhpIgnoreField]
	dispatcher_ref        &eventx.VSlimPsr14EventDispatcher  = unsafe { nil }           @[vphp.PhpIgnoreField]
	cache_ref             &cachex.VSlimPsr16Cache            = unsafe { nil }           @[vphp.PhpIgnoreField]
	cache_pool_ref        &cachex.VSlimPsr6CacheItemPool     = unsafe { nil }           @[vphp.PhpIgnoreField]
	http_client_ref       &httpx.VSlimPsr18Client            = unsafe { nil }           @[vphp.PhpIgnoreField]
	database_ref          &databasex.VSlimDatabaseManager    = unsafe { nil }           @[vphp.PhpIgnoreField]
	migrator_ref          &databasex.VSlimDatabaseMigrator   = unsafe { nil }           @[vphp.PhpIgnoreField]
	job_dispatcher_ref    &jobx.VSlimJobDispatcher           = unsafe { nil }           @[vphp.PhpIgnoreField]
	job_worker_ref        &jobx.VSlimJobWorker               = unsafe { nil }           @[vphp.PhpIgnoreField]
	providers             []vphp.PhpObject                       @[vphp.PhpIgnoreField]
	provider_classes      map[string]bool                        @[vphp.PhpIgnoreField]
	modules               []vphp.PhpObject                       @[vphp.PhpIgnoreField]
	module_classes        map[string]bool                        @[vphp.PhpIgnoreField]
	provider_boot         ComponentBootProgress                  @[vphp.PhpIgnoreField]
	module_boot           ComponentBootProgress                  @[vphp.PhpIgnoreField]
	booting               bool                                   @[vphp.PhpIgnoreField]
	bootstrap_boot_stages map[string]BootstrapBootStage          @[vphp.PhpIgnoreField]
	bootstrap_progress    map[string]&supportx.BootstrapProgress @[vphp.PhpIgnoreField]
	bootstrap_input_runs  []&BootstrapInputRun                   @[vphp.PhpIgnoreField]
	bootstrap_boot_inputs []vphp.PhpValue                        @[vphp.PhpIgnoreField]
	deferred_boot_inputs  []vphp.PhpValue                        @[vphp.PhpIgnoreField]
	booted                bool
	live_ws_sockets       map[string]vphp.PhpObject @[vphp.PhpIgnoreField]
}
