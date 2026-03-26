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
PHP_FUNCTION(vslim_middleware_next);
PHP_FUNCTION(vslim_probe_object);
extern zend_class_entry *vslim__view_ce;
extern zend_class_entry *vslim__controller_ce;
extern zend_class_entry *vslim__app_ce;
extern zend_class_entry *vslim__routegroup_ce;
extern zend_class_entry *vslim__request_ce;
extern zend_class_entry *vslim__response_ce;
extern zend_class_entry *vslim__stream__response_ce;
extern zend_class_entry *vslim__stream__ndjsondecoder_ce;
extern zend_class_entry *vslim__stream__sseencoder_ce;
extern zend_class_entry *vslim__stream__ollamaclient_ce;
extern zend_class_entry *vslim__stream__factory_ce;
extern zend_class_entry *vslim__websocket__app_ce;
extern zend_class_entry *vslim__mcp__app_ce;
extern zend_class_entry *vslim__log__logger_ce;
extern zend_class_entry *vslim__log__level_ce;
extern zend_class_entry *vslim__live__socket_ce;
extern zend_class_entry *vslim__live__form_ce;
extern zend_class_entry *vslim__live__view_ce;
extern zend_class_entry *vslim__live__component_ce;
extern zend_class_entry *vslim__live__componentstate_ce;
extern zend_class_entry *vslim__config_ce;
extern zend_class_entry *vslim__container__containerexception_ce;
extern zend_class_entry *vslim__container__notfoundexception_ce;
extern zend_class_entry *vslim__container_ce;
#endif
