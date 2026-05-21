module appx

import cachex
import clockx
import configx as cfgx
import containerx
import controllerx
import databasex
import eventx
import httpx
import jobx
import loggerx
import mcpx as mcp
import sessionx
import testingx
import vphp
import viewx

fn (mut app VSlimApp) sync_standard_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	app.sync_config_service_to_container()
	app.sync_clock_service_to_container()
	app.sync_logger_services_to_container()
	app.sync_event_services_to_container()
	app.sync_cache_services_to_container()
	app.sync_http_client_service_to_container()
	app.sync_database_service_to_container()
	app.sync_view_service_to_container()
	app.sync_auth_services_to_container()
	app.sync_testing_services_to_container()
	app.sync_controller_services_to_container()
}

fn (mut app VSlimApp) sync_config_service_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	if app.config_ref == unsafe { nil } {
		app.config_ref = cfgx.VSlimConfig.new_default()
		app.configure_default_auth_settings(app.config_ref)
	}
	app.container_ref.set_borrowed_object[cfgx.VSlimConfig](cfgx.service_config, app.config_ref)
}

fn (mut app VSlimApp) sync_auth_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	if app.auth_user_resolver.is_valid() {
		mut provider := app.auth_user_resolver.owned()
		app.container_ref.set(sessionx.service_auth_user_provider, provider)
		provider.release()
	}
	if app.auth_gate_resolver.is_valid() {
		mut gate := app.auth_gate_resolver.retain().to_value()
		app.container_ref.set(sessionx.service_auth_gate_resolver, gate)
		gate.release()
	}
}

fn (mut app VSlimApp) sync_clock_service_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	if !clockx.psr20_clock_is_valid(app.clock_ref) {
		mut old := app.clock_ref
		old.release()
		app.clock_ref = clockx.new_psr20_system_clock_ref()
	}
	mut clock_value := app.clock_ref.to_request_owned().take_value()
	app.container_ref.set(clockx.service_clock, clock_value)
	app.container_ref.set(clockx.service_psr_clock, clock_value)
	clock_value.release()
}

fn (mut app VSlimApp) sync_logger_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	app.container_ref.set_borrowed_object[loggerx.VSlimLogger](loggerx.service_logger, app.logger())
	app.container_ref.set_borrowed_object[loggerx.VSlimPsrLogger](loggerx.service_psr_logger,
		app.psr_logger())
}

fn (mut app VSlimApp) sync_event_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	provider := app.listener_provider()
	app.container_ref.set_borrowed_object[eventx.VSlimPsr14ListenerProvider](eventx.service_listener_provider,
		provider)
	app.container_ref.set_borrowed_object[eventx.VSlimPsr14ListenerProvider](eventx.service_events_provider,
		provider)
	app.container_ref.set_borrowed_object[eventx.VSlimPsr14ListenerProvider](eventx.service_psr_listener_provider,
		provider)
	dispatcher := app.dispatcher()
	app.container_ref.set_borrowed_object[eventx.VSlimPsr14EventDispatcher](eventx.service_events,
		dispatcher)
	app.container_ref.set_borrowed_object[eventx.VSlimPsr14EventDispatcher](eventx.service_dispatcher,
		dispatcher)
	app.container_ref.set_borrowed_object[eventx.VSlimPsr14EventDispatcher](eventx.service_psr_dispatcher,
		dispatcher)
}

fn (mut app VSlimApp) sync_cache_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	cache := app.cache()
	app.container_ref.set_borrowed_object[cachex.VSlimPsr16Cache](cachex.service_cache, cache)
	app.container_ref.set_borrowed_object[cachex.VSlimPsr16Cache](cachex.service_psr_simple_cache,
		cache)
	pool := app.cache_pool()
	app.container_ref.set_borrowed_object[cachex.VSlimPsr6CacheItemPool](cachex.service_cache_pool,
		pool)
	app.container_ref.set_borrowed_object[cachex.VSlimPsr6CacheItemPool](cachex.service_psr_cache_pool,
		pool)
}

fn (mut app VSlimApp) sync_http_client_service_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	client := app.http_client()
	app.container_ref.set_borrowed_object[httpx.VSlimPsr18Client](httpx.service_http, client)
	app.container_ref.set_borrowed_object[httpx.VSlimPsr18Client](httpx.service_http_client, client)
	app.container_ref.set_borrowed_object[httpx.VSlimPsr18Client](httpx.service_psr_http_client,
		client)
}

fn (mut app VSlimApp) sync_database_service_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	db := app.database()
	app.container_ref.set_borrowed_object[databasex.VSlimDatabaseManager](databasex.service_database,
		db)
	app.container_ref.set_borrowed_object[databasex.VSlimDatabaseManager](databasex.service_db, db)
	app.container_ref.set_borrowed_object[databasex.VSlimDatabaseManager](databasex.service_database_manager_class,
		db)
}

fn (mut app VSlimApp) sync_view_service_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	mut view := app.make_view()
	app.container_ref.set_owned_object[viewx.VSlimView](viewx.service_view, view)
}

fn (mut app VSlimApp) sync_testing_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	mut value := app.self_value()
	app.container_ref.set(testingx.service_app, value)
	value.release()
}

fn (mut app VSlimApp) sync_controller_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	mut value := app.self_value()
	app.container_ref.set(controllerx.service_app, value)
	value.release()
}

fn (mut app VSlimApp) configure_default_auth_settings(config &cfgx.VSlimConfig) {
	app.auth_redirect_path = sessionx.auth_redirect_path_from_config(config, app.auth_redirect_to())
}

fn (mut app VSlimApp) sync_clock_dependent_services() {
	mut clock := app.clock()
	defer {
		clock.release()
	}
	clock_value := clock.to_borrowed()
	if app.cache_ref != unsafe { nil } {
		app.cache_ref.set_clock(clock_value)
	}
	if app.cache_pool_ref != unsafe { nil } {
		app.cache_pool_ref.set_clock(clock_value)
	}
}

@[php_method: 'hasMcp']
pub fn (app &VSlimApp) has_mcp() bool {
	return app.mcp_ref != unsafe { nil }
}

@[php_method: 'setMcp']
pub fn (mut app VSlimApp) set_mcp(server &mcp.VSlimMcpApp) &VSlimApp {
	app.mcp_ref = server
	return app
}

@[php_method]
pub fn (mut app VSlimApp) mcp() &mcp.VSlimMcpApp {
	if app.mcp_ref == unsafe { nil } {
		app.mcp_ref = mcp.VSlimMcpApp.new_default()
	}
	return app.mcp_ref
}

@[php_method: 'handleMcpDispatch']
pub fn (app &VSlimApp) handle_mcp_dispatch(frame vphp.PhpArray) vphp.PhpArray {
	if app.mcp_ref == unsafe { nil } {
		return vphp.PhpArray.new()
	}
	return app.mcp_ref.handle_mcp_dispatch(frame)
}

@[php_method: 'hasLogger']
pub fn (app &VSlimApp) has_logger() bool {
	return app.logger_ref != unsafe { nil }
}

@[php_arg_type: 'clock=Psr\\Clock\\ClockInterface']
@[php_method: 'setClock']
pub fn (mut app VSlimApp) set_clock(clock vphp.PhpObject) &VSlimApp {
	if !clockx.psr20_clock_is_valid(clock) {
		vphp.PhpException.raise_class('InvalidArgumentException',
			'clock must implement Psr\\Clock\\ClockInterface', 0)
		return app
	}
	mut old := app.clock_ref
	old.release()
	app.clock_ref = clock.retain()
	app.sync_clock_dependent_services()
	app.sync_clock_service_to_container()
	return app
}

@[php_return_type: 'Psr\\Clock\\ClockInterface']
@[php_method]
pub fn (mut app VSlimApp) clock() vphp.PhpObject {
	if !clockx.psr20_clock_is_valid(app.clock_ref) {
		mut old := app.clock_ref
		old.release()
		app.clock_ref = clockx.new_psr20_system_clock_ref()
		app.sync_clock_service_to_container()
	}
	return app.clock_ref.to_request_owned()
}

@[php_method: 'setLogger']
pub fn (mut app VSlimApp) set_logger(log_writer &loggerx.VSlimLogger) &VSlimApp {
	app.logger_ref = log_writer
	if app.psr_logger_ref != unsafe { nil } {
		app.psr_logger_ref.set_logger(log_writer)
	}
	app.sync_logger_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) logger() &loggerx.VSlimLogger {
	if app.logger_ref == unsafe { nil } {
		app.logger_ref = loggerx.VSlimLogger.app_default(app.config_ref)
	}
	return app.logger_ref
}

@[php_return_type: 'Psr\\Log\\LoggerInterface']
@[php_method: 'psrLogger']
pub fn (mut app VSlimApp) psr_logger() &loggerx.VSlimPsrLogger {
	if app.psr_logger_ref == unsafe { nil } {
		app.psr_logger_ref = loggerx.VSlimPsrLogger.from_logger(app.logger())
	} else {
		app.psr_logger_ref.set_logger(app.logger())
	}
	return app.psr_logger_ref
}

@[php_arg_type: 'provider=Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'setListenerProvider']
pub fn (mut app VSlimApp) set_listener_provider(provider &eventx.VSlimPsr14ListenerProvider) &VSlimApp {
	app.listener_provider_ref = provider
	if app.dispatcher_ref != unsafe { nil } {
		app.dispatcher_ref.set_provider(provider)
	}
	app.sync_event_services_to_container()
	return app
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'listenerProvider']
pub fn (mut app VSlimApp) listener_provider() &eventx.VSlimPsr14ListenerProvider {
	if app.listener_provider_ref == unsafe { nil } {
		app.listener_provider_ref = eventx.VSlimPsr14ListenerProvider.new_default()
	}
	if app.dispatcher_ref != unsafe { nil } {
		app.dispatcher_ref.set_provider(app.listener_provider_ref)
	}
	return app.listener_provider_ref
}

@[php_arg_type: 'dispatcher=Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method: 'setDispatcher']
pub fn (mut app VSlimApp) set_dispatcher(dispatcher &eventx.VSlimPsr14EventDispatcher) &VSlimApp {
	app.dispatcher_ref = dispatcher
	unsafe {
		mut writable := &eventx.VSlimPsr14EventDispatcher(dispatcher)
		app.listener_provider_ref = writable.provider()
	}
	app.sync_event_services_to_container()
	return app
}

@[php_return_type: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method]
pub fn (mut app VSlimApp) dispatcher() &eventx.VSlimPsr14EventDispatcher {
	if app.dispatcher_ref == unsafe { nil } {
		app.dispatcher_ref = eventx.VSlimPsr14EventDispatcher.from_provider(app.listener_provider())
	} else {
		app.dispatcher_ref.set_provider(app.listener_provider())
	}
	return app.dispatcher_ref
}

@[php_return_type: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method: 'events']
pub fn (mut app VSlimApp) events() &eventx.VSlimPsr14EventDispatcher {
	return app.dispatcher()
}

@[php_arg_type: 'cache=Psr\\SimpleCache\\CacheInterface']
@[php_method: 'setCache']
pub fn (mut app VSlimApp) set_cache(cache &cachex.VSlimPsr16Cache) &VSlimApp {
	mut clock := app.clock()
	defer {
		clock.release()
	}
	unsafe {
		mut writable := &cachex.VSlimPsr16Cache(cache)
		writable.set_clock(clock.to_borrowed())
	}
	app.cache_ref = cache
	app.sync_cache_services_to_container()
	return app
}

@[php_return_type: 'Psr\\SimpleCache\\CacheInterface']
@[php_method]
pub fn (mut app VSlimApp) cache() &cachex.VSlimPsr16Cache {
	if app.cache_ref == unsafe { nil } {
		mut clock := app.clock()
		defer {
			clock.release()
		}
		app.cache_ref = cachex.VSlimPsr16Cache.from_clock_and_config(clock.to_borrowed(),
			app.config_ref)
	}
	return app.cache_ref
}

@[php_arg_type: 'pool=Psr\\Cache\\CacheItemPoolInterface']
@[php_method: 'setCachePool']
pub fn (mut app VSlimApp) set_cache_pool(pool &cachex.VSlimPsr6CacheItemPool) &VSlimApp {
	mut clock := app.clock()
	defer {
		clock.release()
	}
	unsafe {
		mut writable := &cachex.VSlimPsr6CacheItemPool(pool)
		writable.set_clock(clock.to_borrowed())
	}
	app.cache_pool_ref = pool
	app.sync_cache_services_to_container()
	return app
}

@[php_return_type: 'Psr\\Cache\\CacheItemPoolInterface']
@[php_method: 'cachePool']
pub fn (mut app VSlimApp) cache_pool() &cachex.VSlimPsr6CacheItemPool {
	if app.cache_pool_ref == unsafe { nil } {
		mut clock := app.clock()
		defer {
			clock.release()
		}
		app.cache_pool_ref = cachex.VSlimPsr6CacheItemPool.from_clock_and_config(clock.to_borrowed(),
			app.config_ref)
	}
	return app.cache_pool_ref
}

@[php_arg_type: 'client=Psr\\Http\\Client\\ClientInterface']
@[php_method: 'setHttpClient']
pub fn (mut app VSlimApp) set_http_client(client &httpx.VSlimPsr18Client) &VSlimApp {
	app.http_client_ref = client
	app.sync_http_client_service_to_container()
	return app
}

@[php_return_type: 'Psr\\Http\\Client\\ClientInterface']
@[php_method: 'httpClient']
pub fn (mut app VSlimApp) http_client() &httpx.VSlimPsr18Client {
	if app.http_client_ref == unsafe { nil } {
		app.http_client_ref = httpx.VSlimPsr18Client.from_config(app.config_ref)
	}
	return app.http_client_ref
}

@[php_method: 'hasDatabase']
pub fn (app &VSlimApp) has_database() bool {
	return app.database_ref != unsafe { nil }
}

@[php_method: 'setDatabase']
pub fn (mut app VSlimApp) set_database(database &databasex.VSlimDatabaseManager) &VSlimApp {
	app.database_ref = database
	app.sync_database_service_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) database() &databasex.VSlimDatabaseManager {
	if app.database_ref == unsafe { nil } {
		app.database_ref = databasex.VSlimDatabaseManager.from_config(app.config_ref)
	}
	return app.database_ref
}

@[php_method]
pub fn (mut app VSlimApp) db() &databasex.VSlimDatabaseManager {
	return app.database()
}

@[php_method: 'jobDispatcher']
pub fn (mut app VSlimApp) job_dispatcher() &jobx.VSlimJobDispatcher {
	if app.job_dispatcher_ref == unsafe { nil } {
		app.job_dispatcher_ref = jobx.VSlimJobDispatcher.from_manager(app.database())
	}
	return app.job_dispatcher_ref
}

@[php_method: 'jobWorker']
pub fn (mut app VSlimApp) job_worker() &jobx.VSlimJobWorker {
	if app.job_worker_ref == unsafe { nil } {
		app.job_worker_ref = jobx.VSlimJobWorker.from_manager(app.database())
	}
	return app.job_worker_ref
}

@[php_method: 'hasMigrator']
pub fn (app &VSlimApp) has_migrator() bool {
	return app.migrator_ref != unsafe { nil }
}

@[php_method: 'setMigrator']
pub fn (mut app VSlimApp) set_migrator(migrator &databasex.VSlimDatabaseMigrator) &VSlimApp {
	app.migrator_ref = migrator
	app.migrator_ref.set_manager(app.database())
	app.migrator_ref.configure_project_paths(app.migrator_project_root())
	return &app
}

@[php_method]
pub fn (mut app VSlimApp) migrator() &databasex.VSlimDatabaseMigrator {
	if app.migrator_ref == unsafe { nil } {
		app.migrator_ref = databasex.VSlimDatabaseMigrator.from_manager(app.database())
	}
	app.migrator_ref.set_manager(app.database())
	app.migrator_ref.configure_project_paths(app.migrator_project_root())
	return app.migrator_ref
}
