module middlewarex

import vphp

import httpx

#include "php_bridge.h"

__global C.vslim__psr15__nexthandler_ce &C.zend_class_entry
__global C.vslim__psr15__continuehandler_ce &C.zend_class_entry

@[export: 'VSlimPsr15NextHandler_new_raw']
pub fn vslimpsr15nexthandler_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr15NextHandler]()
}
@[export: 'VSlimPsr15NextHandler_free_raw']
pub fn vslimpsr15nexthandler_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr15NextHandler](ptr)
}
@[export: 'VSlimPsr15NextHandler_cleanup_raw']
pub fn vslimpsr15nexthandler_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr15NextHandler_get_prop']
pub fn vslimpsr15nexthandler_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr15NextHandler_set_prop']
pub fn vslimpsr15nexthandler_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr15NextHandler_sync_props']
pub fn vslimpsr15nexthandler_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr15NextHandler_handle']
pub fn vphp_wrap_vslimpsr15nexthandler_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr15NextHandler(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr15NextHandler_handlers']
pub fn vslimpsr15nexthandler_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr15nexthandler_get_prop),
        write_handler: voidptr(vslimpsr15nexthandler_set_prop),
        sync_handler: voidptr(vslimpsr15nexthandler_sync_props),
        new_raw: voidptr(vslimpsr15nexthandler_new_raw),
        cleanup_raw: voidptr(vslimpsr15nexthandler_cleanup_raw),
        free_raw: voidptr(vslimpsr15nexthandler_free_raw)
    )
}
pub fn VSlimPsr15NextHandler.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr15__nexthandler_ce)
}

pub fn VSlimPsr15NextHandler.php_object_handlers() voidptr {
    return vslimpsr15nexthandler_handlers()
}

pub fn VSlimPsr15NextHandler.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr15NextHandler](v_ptr, ownership)
}

pub fn (obj &VSlimPsr15NextHandler) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr15NextHandler](obj)
}

pub fn (obj &VSlimPsr15NextHandler) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr15NextHandler](obj)
}

pub fn (obj &VSlimPsr15NextHandler) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr15NextHandler](obj)
}

pub fn (obj &VSlimPsr15NextHandler) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr15NextHandler](obj)
}

@[export: 'VSlimPsr15ContinueHandler_new_raw']
pub fn vslimpsr15continuehandler_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr15ContinueHandler]()
}
@[export: 'VSlimPsr15ContinueHandler_free_raw']
pub fn vslimpsr15continuehandler_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr15ContinueHandler](ptr)
}
@[export: 'VSlimPsr15ContinueHandler_cleanup_raw']
pub fn vslimpsr15continuehandler_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr15ContinueHandler_get_prop']
pub fn vslimpsr15continuehandler_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr15ContinueHandler_set_prop']
pub fn vslimpsr15continuehandler_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr15ContinueHandler_sync_props']
pub fn vslimpsr15continuehandler_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr15ContinueHandler_handle']
pub fn vphp_wrap_vslimpsr15continuehandler_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr15ContinueHandler(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'VSlimPsr15ContinueHandler_handlers']
pub fn vslimpsr15continuehandler_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr15continuehandler_get_prop),
        write_handler: voidptr(vslimpsr15continuehandler_set_prop),
        sync_handler: voidptr(vslimpsr15continuehandler_sync_props),
        new_raw: voidptr(vslimpsr15continuehandler_new_raw),
        cleanup_raw: voidptr(vslimpsr15continuehandler_cleanup_raw),
        free_raw: voidptr(vslimpsr15continuehandler_free_raw)
    )
}
pub fn VSlimPsr15ContinueHandler.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr15__continuehandler_ce)
}

pub fn VSlimPsr15ContinueHandler.php_object_handlers() voidptr {
    return vslimpsr15continuehandler_handlers()
}

pub fn VSlimPsr15ContinueHandler.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr15ContinueHandler](v_ptr, ownership)
}

pub fn (obj &VSlimPsr15ContinueHandler) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr15ContinueHandler](obj)
}

pub fn (obj &VSlimPsr15ContinueHandler) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr15ContinueHandler](obj)
}

pub fn (obj &VSlimPsr15ContinueHandler) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr15ContinueHandler](obj)
}

pub fn (obj &VSlimPsr15ContinueHandler) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr15ContinueHandler](obj)
}

