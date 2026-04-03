module main

import vphp

#include "php_bridge.h"

@[php_method]
pub fn (mut app VSlimApp) set_base_path(base_path string) &VSlimApp {
	app.base_path = RoutePath.normalize_base_path(base_path)
	return app
}

@[php_method]
pub fn (app &VSlimApp) has_container() bool {
	return app.container_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_container(container &VSlimContainer) &VSlimApp {
	app.container_ref = container
	app.container_ref.app_ref = &app
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) container() &VSlimContainer {
	if app.container_ref == unsafe { nil } {
		app.container_ref = new_vslim_container()
	}
	app.container_ref.app_ref = &app
	app.sync_standard_services_to_container()
	return app.container_ref
}

@[php_method]
pub fn (app &VSlimApp) has_config() bool {
	return app.config_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_config(config &VSlimConfig) &VSlimApp {
	app.config_ref = config
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) config() &VSlimConfig {
	if app.config_ref == unsafe { nil } {
		mut created := &VSlimConfig{}
		created.construct()
		app.config_ref = created
		app.sync_standard_services_to_container()
	}
	return app.config_ref
}

@[php_method]
pub fn (mut app VSlimApp) load_config(path string) &VSlimApp {
	mut cfg := app.config()
	cfg.load(path)
	app.sync_standard_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) load_config_text(text string) &VSlimApp {
	mut cfg := app.config()
	cfg.load_text(text)
	app.sync_standard_services_to_container()
	return app
}

fn (mut app VSlimApp) sync_standard_services_to_container() {
	if app.container_ref == unsafe { nil } {
		return
	}
	app.container_ref.app_ref = &app
}

fn (mut app VSlimApp) sync_config_service_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_clock_service_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_logger_services_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_event_services_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_cache_services_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_http_client_service_to_container() {
	app.sync_standard_services_to_container()
}

fn (mut app VSlimApp) sync_clock_dependent_services() {
	clock_value := vphp.BorrowedValue.from_zval(app.clock().to_zval())
	if app.cache_ref != unsafe { nil } {
		app.cache_ref.set_clock(clock_value)
	}
	if app.cache_pool_ref != unsafe { nil } {
		app.cache_pool_ref.set_clock(clock_value)
	}
}

@[php_method]
pub fn (app &VSlimApp) has_mcp() bool {
	return app.mcp_ref != unsafe { nil }
}

@[php_method]
pub fn (mut app VSlimApp) set_mcp(mcp &VSlimMcpApp) &VSlimApp {
	app.mcp_ref = mcp
	return app
}

@[php_method]
pub fn (mut app VSlimApp) mcp() &VSlimMcpApp {
	if app.mcp_ref == unsafe { nil } {
		mut created := &VSlimMcpApp{}
		created.construct()
		app.mcp_ref = created
	}
	return app.mcp_ref
}

@[php_method]
pub fn (app &VSlimApp) handle_mcp_dispatch(frame vphp.BorrowedValue) vphp.Value {
	if app.mcp_ref == unsafe { nil } {
		return vphp.Value.new_null()
	}
	return vphp.Value.from_zval(app.mcp_ref.handle_mcp_dispatch(frame).to_zval())
}

@[php_method]
pub fn (app &VSlimApp) has_logger() bool {
	return app.logger_ref != unsafe { nil }
}

@[php_arg_type: 'clock=Psr\\Clock\\ClockInterface']
@[php_method: 'setClock']
pub fn (mut app VSlimApp) set_clock(clock vphp.BorrowedValue) &VSlimApp {
	if !psr20_is_clock(clock.to_zval()) {
		vphp.throw_exception_class('InvalidArgumentException', 'clock must implement Psr\\Clock\\ClockInterface',
			0)
		return app
	}
	mut old := app.clock_ref
	old.release()
	app.clock_ref = vphp.PersistentOwnedZVal.from_zval(clock.to_zval())
	app.sync_clock_dependent_services()
	app.sync_clock_service_to_container()
	return app
}

@[php_return_type: 'Psr\\Clock\\ClockInterface']
@[php_method]
pub fn (mut app VSlimApp) clock() vphp.Value {
	if !psr20_is_clock(app.clock_ref.to_zval()) {
		mut old := app.clock_ref
		old.release()
		app.clock_ref = new_psr20_system_clock_ref()
		app.sync_clock_service_to_container()
	}
	return vphp.Value.from_zval(app.clock_ref.clone_request_owned().to_zval())
}

@[php_method]
pub fn (mut app VSlimApp) set_logger(logger &VSlimLogger) &VSlimApp {
	app.logger_ref = logger
	if app.psr_logger_ref != unsafe { nil } {
		app.psr_logger_ref.set_logger(logger)
	}
	app.sync_logger_services_to_container()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) logger() &VSlimLogger {
	if app.logger_ref == unsafe { nil } {
		mut created := &VSlimLogger{}
		created.construct()
		created.set_channel('vslim.app')
		app.logger_ref = created
	}
	return app.logger_ref
}

@[php_return_type: 'Psr\\Log\\LoggerInterface']
@[php_method: 'psrLogger']
pub fn (mut app VSlimApp) psr_logger() &VSlimPsrLogger {
	if app.psr_logger_ref == unsafe { nil } {
		mut created := &VSlimPsrLogger{}
		created.construct()
		created.set_logger(app.logger())
		app.psr_logger_ref = created
	} else {
		app.psr_logger_ref.set_logger(app.logger())
	}
	return app.psr_logger_ref
}

@[php_arg_type: 'provider=Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'setListenerProvider']
pub fn (mut app VSlimApp) set_listener_provider(provider &VSlimPsr14ListenerProvider) &VSlimApp {
	app.listener_provider_ref = provider
	if app.dispatcher_ref != unsafe { nil } {
		app.dispatcher_ref.set_provider(provider)
	}
	app.sync_event_services_to_container()
	return app
}

@[php_return_type: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_method: 'listenerProvider']
pub fn (mut app VSlimApp) listener_provider() &VSlimPsr14ListenerProvider {
	if app.listener_provider_ref == unsafe { nil } {
		mut created := &VSlimPsr14ListenerProvider{}
		created.construct()
		app.listener_provider_ref = created
	}
	if app.dispatcher_ref != unsafe { nil } {
		app.dispatcher_ref.set_provider(app.listener_provider_ref)
	}
	return app.listener_provider_ref
}

@[php_arg_type: 'dispatcher=Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method: 'setDispatcher']
pub fn (mut app VSlimApp) set_dispatcher(dispatcher &VSlimPsr14EventDispatcher) &VSlimApp {
	app.dispatcher_ref = dispatcher
	unsafe {
		mut writable := &VSlimPsr14EventDispatcher(dispatcher)
		app.listener_provider_ref = writable.provider()
	}
	app.sync_event_services_to_container()
	return app
}

@[php_return_type: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method]
pub fn (mut app VSlimApp) dispatcher() &VSlimPsr14EventDispatcher {
	if app.dispatcher_ref == unsafe { nil } {
		mut created := &VSlimPsr14EventDispatcher{}
		created.construct()
		created.set_provider(app.listener_provider())
		app.dispatcher_ref = created
	} else {
		app.dispatcher_ref.set_provider(app.listener_provider())
	}
	return app.dispatcher_ref
}

@[php_return_type: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_method: 'events']
pub fn (mut app VSlimApp) events() &VSlimPsr14EventDispatcher {
	return app.dispatcher()
}

@[php_arg_type: 'cache=Psr\\SimpleCache\\CacheInterface']
@[php_method: 'setCache']
pub fn (mut app VSlimApp) set_cache(cache &VSlimPsr16Cache) &VSlimApp {
	unsafe {
		mut writable := &VSlimPsr16Cache(cache)
		writable.set_clock(vphp.BorrowedValue.from_zval(app.clock().to_zval()))
	}
	app.cache_ref = cache
	app.sync_cache_services_to_container()
	return app
}

@[php_return_type: 'Psr\\SimpleCache\\CacheInterface']
@[php_method]
pub fn (mut app VSlimApp) cache() &VSlimPsr16Cache {
	if app.cache_ref == unsafe { nil } {
		mut created := &VSlimPsr16Cache{}
		created.construct()
		created.set_clock(vphp.BorrowedValue.from_zval(app.clock().to_zval()))
		app.cache_ref = created
	}
	return app.cache_ref
}

@[php_arg_type: 'pool=Psr\\Cache\\CacheItemPoolInterface']
@[php_method: 'setCachePool']
pub fn (mut app VSlimApp) set_cache_pool(pool &VSlimPsr6CacheItemPool) &VSlimApp {
	unsafe {
		mut writable := &VSlimPsr6CacheItemPool(pool)
		writable.set_clock(vphp.BorrowedValue.from_zval(app.clock().to_zval()))
	}
	app.cache_pool_ref = pool
	app.sync_cache_services_to_container()
	return app
}

@[php_return_type: 'Psr\\Cache\\CacheItemPoolInterface']
@[php_method: 'cachePool']
pub fn (mut app VSlimApp) cache_pool() &VSlimPsr6CacheItemPool {
	if app.cache_pool_ref == unsafe { nil } {
		mut created := &VSlimPsr6CacheItemPool{}
		created.construct()
		created.set_clock(vphp.BorrowedValue.from_zval(app.clock().to_zval()))
		app.cache_pool_ref = created
	}
	return app.cache_pool_ref
}

@[php_arg_type: 'client=Psr\\Http\\Client\\ClientInterface']
@[php_method: 'setHttpClient']
pub fn (mut app VSlimApp) set_http_client(client &VSlimPsr18Client) &VSlimApp {
	app.http_client_ref = client
	app.sync_http_client_service_to_container()
	return app
}

@[php_return_type: 'Psr\\Http\\Client\\ClientInterface']
@[php_method: 'httpClient']
pub fn (mut app VSlimApp) http_client() &VSlimPsr18Client {
	if app.http_client_ref == unsafe { nil } {
		mut created := &VSlimPsr18Client{}
		created.construct()
		app.http_client_ref = created
	}
	return app.http_client_ref
}
