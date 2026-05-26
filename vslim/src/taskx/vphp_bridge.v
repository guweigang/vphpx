module taskx

import vphp

#include "php_bridge.h"

__global C.vslim__task_ce &C.zend_class_entry
__global C.vslim__taskhandle_ce &C.zend_class_entry

@[export: 'vslim_task_new_raw']
pub fn vslim_task_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTask]()
}
@[export: 'vslim_task_free_raw']
pub fn vslim_task_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTask](ptr)
}
@[export: 'vslim_task_cleanup_raw']
pub fn vslim_task_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_task_get_prop']
pub fn vslim_task_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_task_set_prop']
pub fn vslim_task_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_task_sync_props']
pub fn vslim_task_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_task_list']
pub fn vphp_wrap_vslim_task_list(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimTask.list()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_task_spawn']
pub fn vphp_wrap_vslim_task_spawn(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'target', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'target').value
    arg_1 := php_args.at_named_or_index(1, 'params').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := VSlimTask.@spawn(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vslim_task_handlers']
pub fn vslim_task_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_task_get_prop),
        write_handler: voidptr(vslim_task_set_prop),
        sync_handler: voidptr(vslim_task_sync_props),
        new_raw: voidptr(vslim_task_new_raw),
        cleanup_raw: voidptr(vslim_task_cleanup_raw),
        free_raw: voidptr(vslim_task_free_raw)
    )
}
pub fn VSlimTask.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__task_ce)
}

pub fn VSlimTask.php_object_handlers() voidptr {
    return vslim_task_handlers()
}

pub fn VSlimTask.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimTask](v_ptr, ownership)
}

pub fn (obj &VSlimTask) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimTask](obj)
}

pub fn (obj &VSlimTask) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimTask](obj)
}

pub fn (obj &VSlimTask) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimTask](obj)
}

pub fn (obj &VSlimTask) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimTask](obj)
}

pub fn (val VSlimTask) php_class_name() string {
    return 'VSlim\\Task'
}

@[export: 'vslim_task_handle_new_raw']
pub fn vslim_task_handle_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTaskHandle]()
}
@[export: 'vslim_task_handle_free_raw']
pub fn vslim_task_handle_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTaskHandle](ptr)
}
@[export: 'vslim_task_handle_cleanup_raw']
pub fn vslim_task_handle_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimTaskHandle(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_task_handle_get_prop']
pub fn vslim_task_handle_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_task_handle_set_prop']
pub fn vslim_task_handle_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_task_handle_sync_props']
pub fn vslim_task_handle_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_task_handle_wait']
pub fn vphp_wrap_vslim_task_handle_wait(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskHandle(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.wait()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vslim_task_handle_handlers']
pub fn vslim_task_handle_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_task_handle_get_prop),
        write_handler: voidptr(vslim_task_handle_set_prop),
        sync_handler: voidptr(vslim_task_handle_sync_props),
        new_raw: voidptr(vslim_task_handle_new_raw),
        cleanup_raw: voidptr(vslim_task_handle_cleanup_raw),
        free_raw: voidptr(vslim_task_handle_free_raw)
    )
}
pub fn VSlimTaskHandle.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__taskhandle_ce)
}

pub fn VSlimTaskHandle.php_object_handlers() voidptr {
    return vslim_task_handle_handlers()
}

pub fn VSlimTaskHandle.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimTaskHandle](v_ptr, ownership)
}

pub fn (obj &VSlimTaskHandle) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimTaskHandle](obj)
}

pub fn (obj &VSlimTaskHandle) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimTaskHandle](obj)
}

pub fn (obj &VSlimTaskHandle) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimTaskHandle](obj)
}

pub fn (obj &VSlimTaskHandle) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimTaskHandle](obj)
}

pub fn (val VSlimTaskHandle) php_class_name() string {
    return 'VSlim\\TaskHandle'
}

