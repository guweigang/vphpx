module taskx

import vphp

#include "php_bridge.h"

__global C.vslim__task_ce &C.zend_class_entry
__global C.vslim__taskhandle_ce &C.zend_class_entry

@[export: 'VSlimTask_new_raw']
pub fn vslimtask_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTask]()
}
@[export: 'VSlimTask_free_raw']
pub fn vslimtask_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTask](ptr)
}
@[export: 'VSlimTask_cleanup_raw']
pub fn vslimtask_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimTask_get_prop']
pub fn vslimtask_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimTask_set_prop']
pub fn vslimtask_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimTask_sync_props']
pub fn vslimtask_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimTask_list']
pub fn vphp_wrap_vslimtask_list(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimTask.list()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_VSlimTask_spawn']
pub fn vphp_wrap_vslimtask_spawn(ctx vphp.Context) voidptr {
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
@[export: 'VSlimTask_handlers']
pub fn vslimtask_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimtask_get_prop),
        write_handler: voidptr(vslimtask_set_prop),
        sync_handler: voidptr(vslimtask_sync_props),
        new_raw: voidptr(vslimtask_new_raw),
        cleanup_raw: voidptr(vslimtask_cleanup_raw),
        free_raw: voidptr(vslimtask_free_raw)
    )
}
pub fn VSlimTask.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__task_ce)
}

pub fn VSlimTask.php_object_handlers() voidptr {
    return vslimtask_handlers()
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

@[export: 'VSlimTaskHandle_new_raw']
pub fn vslimtaskhandle_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTaskHandle]()
}
@[export: 'VSlimTaskHandle_free_raw']
pub fn vslimtaskhandle_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTaskHandle](ptr)
}
@[export: 'VSlimTaskHandle_cleanup_raw']
pub fn vslimtaskhandle_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimTaskHandle(ptr)
        obj.cleanup()
    }
}
@[export: 'VSlimTaskHandle_get_prop']
pub fn vslimtaskhandle_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimTaskHandle_set_prop']
pub fn vslimtaskhandle_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimTaskHandle_sync_props']
pub fn vslimtaskhandle_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimTaskHandle_wait']
pub fn vphp_wrap_vslimtaskhandle_wait(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskHandle(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.wait()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'VSlimTaskHandle_handlers']
pub fn vslimtaskhandle_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimtaskhandle_get_prop),
        write_handler: voidptr(vslimtaskhandle_set_prop),
        sync_handler: voidptr(vslimtaskhandle_sync_props),
        new_raw: voidptr(vslimtaskhandle_new_raw),
        cleanup_raw: voidptr(vslimtaskhandle_cleanup_raw),
        free_raw: voidptr(vslimtaskhandle_free_raw)
    )
}
pub fn VSlimTaskHandle.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__taskhandle_ce)
}

pub fn VSlimTaskHandle.php_object_handlers() voidptr {
    return vslimtaskhandle_handlers()
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

