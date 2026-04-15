/* ⚠️ VPHP Compiler Generated，请勿手动修改 */
#ifndef VPHP_EXT_VSLIM_BRIDGE_H
#define VPHP_EXT_VSLIM_BRIDGE_H

#include <php.h>
#include <Zend/zend_attributes.h>
#include <Zend/zend_enum.h>
#include <ext/standard/info.h>

extern zend_module_entry vslim_module_entry;
#define phpext_vslim_ptr &vslim_module_entry

extern void* vphp_get_active_globals();

PHP_FUNCTION(vslim_handle_request);
PHP_FUNCTION(vslim_demo_dispatch);
PHP_FUNCTION(vslim_response_headers);
PHP_FUNCTION(vslim_probe_object);
extern zend_class_entry *vslim__cli__app_ce;
extern zend_class_entry *vslim__view_ce;
extern zend_class_entry *vslim__controller_ce;
extern zend_class_entry *vslim__app_ce;
extern zend_class_entry *vslim__testing__harness_ce;
extern zend_class_entry *vslim__psr15__nexthandler_ce;
extern zend_class_entry *vslim__psr15__continuehandler_ce;
extern zend_class_entry *vslim__support__serviceprovider_ce;
extern zend_class_entry *vslim__support__module_ce;
extern zend_class_entry *vslim__routegroup_ce;
extern zend_class_entry *vslim__vhttpd__request_ce;
extern zend_class_entry *vslim__vhttpd__client_ce;
extern zend_class_entry *vslim__session__store_ce;
extern zend_class_entry *vslim__auth__sessionguard_ce;
extern zend_class_entry *vslim__session__startmiddleware_ce;
extern zend_class_entry *vslim__auth__requireauthmiddleware_ce;
extern zend_class_entry *vslim__auth__guestmiddleware_ce;
extern zend_class_entry *vslim__auth__requireabilitymiddleware_ce;
extern zend_class_entry *vslim__vhttpd__response_ce;
extern zend_class_entry *vphp__vslim__psr7adapter_ce;
extern zend_class_entry *vslim__stream__response_ce;
extern zend_class_entry *vslim__stream__ndjsondecoder_ce;
extern zend_class_entry *vslim__stream__sseencoder_ce;
extern zend_class_entry *vslim__stream__ollamaclient_ce;
extern zend_class_entry *vslim__stream__factory_ce;
extern zend_class_entry *vslim__websocket__app_ce;
extern zend_class_entry *vslim__mcp__app_ce;
extern zend_class_entry *vslim__log__logger_ce;
extern zend_class_entry *vslim__log__psrlogger_ce;
extern zend_class_entry *vslim__log__level_ce;
extern zend_class_entry *vslim__psr7__stream_ce;
extern zend_class_entry *vslim__psr7__uploadedfile_ce;
extern zend_class_entry *vslim__psr7__response_ce;
extern zend_class_entry *vslim__psr7__uri_ce;
extern zend_class_entry *vslim__psr7__request_ce;
extern zend_class_entry *vslim__psr7__serverrequest_ce;
extern zend_class_entry *vslim__psr17__responsefactory_ce;
extern zend_class_entry *vslim__psr17__requestfactory_ce;
extern zend_class_entry *vslim__psr17__streamfactory_ce;
extern zend_class_entry *vslim__psr17__uploadedfilefactory_ce;
extern zend_class_entry *vslim__psr17__urifactory_ce;
extern zend_class_entry *vslim__psr17__serverrequestfactory_ce;
extern zend_class_entry *vslim__psr16__cacheexception_ce;
extern zend_class_entry *vslim__psr16__invalidargumentexception_ce;
extern zend_class_entry *vslim__psr16__cache_ce;
extern zend_class_entry *vslim__psr6__cacheexception_ce;
extern zend_class_entry *vslim__psr6__invalidargumentexception_ce;
extern zend_class_entry *vslim__psr6__cacheitem_ce;
extern zend_class_entry *vslim__psr6__cacheitempool_ce;
extern zend_class_entry *vslim__psr18__clientexception_ce;
extern zend_class_entry *vslim__psr18__requestexception_ce;
extern zend_class_entry *vslim__psr18__networkexception_ce;
extern zend_class_entry *vslim__psr18__client_ce;
extern zend_class_entry *vslim__database__config_ce;
extern zend_class_entry *vslim__database__manager_ce;
extern zend_class_entry *vslim__database__pendingresult_ce;
extern zend_class_entry *vslim__database__query_ce;
extern zend_class_entry *vslim__database__model_ce;
extern zend_class_entry *vslim__database__migration_ce;
extern zend_class_entry *vslim__database__seeder_ce;
extern zend_class_entry *vslim__database__migrator_ce;
extern zend_class_entry *vslim__psr20__clock_ce;
extern zend_class_entry *vslim__psr14__listenerprovider_ce;
extern zend_class_entry *vslim__psr14__eventdispatcher_ce;
extern zend_class_entry *vslim__dev__phpsignatureprobe_ce;
extern zend_class_entry *vslim__live__socket_ce;
extern zend_class_entry *vslim__live__form_ce;
extern zend_class_entry *vslim__live__view_ce;
extern zend_class_entry *vslim__live__component_ce;
extern zend_class_entry *vslim__live__componentstate_ce;
extern zend_class_entry *vslim__validate__validator_ce;
extern zend_class_entry *vslim__envloader_ce;
extern zend_class_entry *vslim__task_ce;
extern zend_class_entry *vslim__taskhandle_ce;
extern zend_class_entry *vslim__job__dispatcher_ce;
extern zend_class_entry *vslim__job__worker_ce;
extern zend_class_entry *vslim__config_ce;
extern zend_class_entry *vslim__container__containerexception_ce;
extern zend_class_entry *vslim__container__notfoundexception_ce;
extern zend_class_entry *vslim__container_ce;
#endif
