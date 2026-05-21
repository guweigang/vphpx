module clockx

import vphp

#include "php_bridge.h"

__global C.vslim__psr20__clock_ce &C.zend_class_entry

@[export: 'VSlimPsr20Clock_new_raw']
pub fn vslimpsr20clock_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr20Clock]()
}
@[export: 'VSlimPsr20Clock_free_raw']
pub fn vslimpsr20clock_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr20Clock](ptr)
}
@[export: 'VSlimPsr20Clock_cleanup_raw']
pub fn vslimpsr20clock_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPsr20Clock_get_prop']
pub fn vslimpsr20clock_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPsr20Clock_set_prop']
pub fn vslimpsr20clock_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPsr20Clock_sync_props']
pub fn vslimpsr20clock_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPsr20Clock_construct']
pub fn vphp_wrap_vslimpsr20clock_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr20Clock(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPsr20Clock_now']
pub fn vphp_wrap_vslimpsr20clock_now(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr20Clock(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.now()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'VSlimPsr20Clock_handlers']
pub fn vslimpsr20clock_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimpsr20clock_get_prop),
        write_handler: voidptr(vslimpsr20clock_set_prop),
        sync_handler: voidptr(vslimpsr20clock_sync_props),
        new_raw: voidptr(vslimpsr20clock_new_raw),
        cleanup_raw: voidptr(vslimpsr20clock_cleanup_raw),
        free_raw: voidptr(vslimpsr20clock_free_raw)
    )
}
pub fn VSlimPsr20Clock.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr20__clock_ce)
}

pub fn VSlimPsr20Clock.php_object_handlers() voidptr {
    return vslimpsr20clock_handlers()
}

pub fn VSlimPsr20Clock.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr20Clock](v_ptr, ownership)
}

pub fn (obj &VSlimPsr20Clock) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr20Clock](obj)
}

pub fn (obj &VSlimPsr20Clock) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr20Clock](obj)
}

pub fn (obj &VSlimPsr20Clock) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr20Clock](obj)
}

pub fn (obj &VSlimPsr20Clock) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr20Clock](obj)
}

