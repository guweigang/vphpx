module middlewarex

import vphp
import vphp.object

import httpx

#include "php_bridge.h"

__global C.vslim__psr15__nexthandler_ce &C.zend_class_entry
__global C.vslim__psr15__continuehandler_ce &C.zend_class_entry

@[export: 'vslim_psr15_next_handler_new_raw']
pub fn vslim_psr15_next_handler_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr15NextHandler]()
}
@[export: 'vslim_psr15_next_handler_free_raw']
pub fn vslim_psr15_next_handler_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr15NextHandler](ptr)
}
@[export: 'vslim_psr15_next_handler_cleanup_raw']
pub fn vslim_psr15_next_handler_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_psr15_next_handler_get_prop']
pub fn vslim_psr15_next_handler_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr15_next_handler_set_prop']
pub fn vslim_psr15_next_handler_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr15_next_handler_sync_props']
pub fn vslim_psr15_next_handler_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr15_next_handler_handle']
pub fn vphp_wrap_vslim_psr15_next_handler_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr15NextHandler(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'vslim_psr15_next_handler_handlers']
pub fn vslim_psr15_next_handler_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr15_next_handler_get_prop),
        write_handler: voidptr(vslim_psr15_next_handler_set_prop),
        sync_handler: voidptr(vslim_psr15_next_handler_sync_props),
        new_raw: voidptr(vslim_psr15_next_handler_new_raw),
        cleanup_raw: voidptr(vslim_psr15_next_handler_cleanup_raw),
        free_raw: voidptr(vslim_psr15_next_handler_free_raw)
    )
}
pub fn VSlimPsr15NextHandler.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr15__nexthandler_ce)
}

pub fn VSlimPsr15NextHandler.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr15_next_handler_handlers())
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

pub fn (val VSlimPsr15NextHandler) php_class_name() string {
    return 'VSlim\\Psr15\\NextHandler'
}

@[export: 'vslim_psr15_continue_handler_new_raw']
pub fn vslim_psr15_continue_handler_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr15ContinueHandler]()
}
@[export: 'vslim_psr15_continue_handler_free_raw']
pub fn vslim_psr15_continue_handler_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr15ContinueHandler](ptr)
}
@[export: 'vslim_psr15_continue_handler_cleanup_raw']
pub fn vslim_psr15_continue_handler_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_psr15_continue_handler_get_prop']
pub fn vslim_psr15_continue_handler_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr15_continue_handler_set_prop']
pub fn vslim_psr15_continue_handler_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr15_continue_handler_sync_props']
pub fn vslim_psr15_continue_handler_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr15_continue_handler_handle']
pub fn vphp_wrap_vslim_psr15_continue_handler_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr15ContinueHandler(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'vslim_psr15_continue_handler_handlers']
pub fn vslim_psr15_continue_handler_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr15_continue_handler_get_prop),
        write_handler: voidptr(vslim_psr15_continue_handler_set_prop),
        sync_handler: voidptr(vslim_psr15_continue_handler_sync_props),
        new_raw: voidptr(vslim_psr15_continue_handler_new_raw),
        cleanup_raw: voidptr(vslim_psr15_continue_handler_cleanup_raw),
        free_raw: voidptr(vslim_psr15_continue_handler_free_raw)
    )
}
pub fn VSlimPsr15ContinueHandler.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr15__continuehandler_ce)
}

pub fn VSlimPsr15ContinueHandler.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr15_continue_handler_handlers())
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

pub fn (val VSlimPsr15ContinueHandler) php_class_name() string {
    return 'VSlim\\Psr15\\ContinueHandler'
}

