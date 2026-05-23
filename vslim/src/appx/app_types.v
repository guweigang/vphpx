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
import vphp

@[php_implements: 'Psr\\Http\\Server\\RequestHandlerInterface']
@[php_attr: 'VHttpd\\Attribute\\Dispatchable("http")']
@[php_class: 'VSlim\\App']
@[heap]
pub struct VSlimApp {
mut:
	routes                []routex.VSlimRoute
	websocket_routes      []routex.VSlimRoute                @[php_ignore]
	websocket_conn_route  map[string]int                     @[php_ignore]
	before_middlewares    []vphp.PhpValue                    @[php_ignore]
	middlewares           []vphp.PhpValue                    @[php_ignore]
	after_middlewares     []vphp.PhpValue                    @[php_ignore]
	group_before_middle   routex.HookTable                   @[php_ignore]
	group_middle          routex.HookTable                   @[php_ignore]
	group_after_middle    routex.HookTable                   @[php_ignore]
	not_found_handler     vphp.PhpCallable                   @[php_ignore]
	error_handler         vphp.PhpCallable                   @[php_ignore]
	container_ref         &containerx.VSlimContainer = unsafe { nil }         @[php_ignore]
	config_ref            &cfgx.VSlimConfig          = unsafe { nil }                  @[php_ignore]
	mcp_ref               &mcp.VSlimMcpApp           = unsafe { nil }                   @[php_ignore]
	auth_user_resolver    vphp.PhpValue              = vphp.PhpValue.invalid()                      @[php_ignore]
	auth_gate_resolver    vphp.PhpCallable           = vphp.PhpCallable.invalid()                   @[php_ignore]
	auth_redirect_path    string                             @[php_prop: authRedirectPath]
	base_path             string                             @[php_prop: basePath]
	use_demo              bool                               @[php_prop: useDemo]
	error_response_json   bool                               @[php_prop: errorResponseJson]
	view_base_path        string                             @[php_prop: viewBasePath]
	assets_prefix         string                             @[php_prop: assetsPrefix]
	view_cache_enabled    bool                               @[php_prop: viewCacheEnabled]
	view_cache_configured bool                               @[php_prop: viewCacheConfigured]
	view_helpers          map[string]vphp.PhpCallable        @[php_ignore]
	logger_ref            &loggerx.VSlimLogger                = unsafe { nil }                @[php_ignore]
	psr_logger_ref        &loggerx.VSlimPsrLogger             = unsafe { nil }             @[php_ignore]
	clock_ref             vphp.PhpObject                     = vphp.PhpObject.invalid()                     @[php_ignore]
	listener_provider_ref &eventx.VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
	dispatcher_ref        &eventx.VSlimPsr14EventDispatcher  = unsafe { nil }  @[php_ignore]
	cache_ref             &cachex.VSlimPsr16Cache            = unsafe { nil }            @[php_ignore]
	cache_pool_ref        &cachex.VSlimPsr6CacheItemPool     = unsafe { nil }     @[php_ignore]
	http_client_ref       &httpx.VSlimPsr18Client            = unsafe { nil }            @[php_ignore]
	database_ref          &databasex.VSlimDatabaseManager    = unsafe { nil }    @[php_ignore]
	migrator_ref          &databasex.VSlimDatabaseMigrator   = unsafe { nil }   @[php_ignore]
	job_dispatcher_ref    &jobx.VSlimJobDispatcher            = unsafe { nil }            @[php_ignore]
	job_worker_ref        &jobx.VSlimJobWorker                = unsafe { nil }                @[php_ignore]
	providers             []vphp.PhpObject                   @[php_ignore]
	provider_classes      map[string]bool                    @[php_ignore]
	modules               []vphp.PhpObject                   @[php_ignore]
	module_classes        map[string]bool                    @[php_ignore]
	booted                bool
	live_ws_sockets       map[string]vphp.PhpObject @[php_ignore]
}
