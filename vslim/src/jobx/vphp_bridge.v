module jobx

import vphp

import databasex

#include "php_bridge.h"

__global C.vslim__job__dispatcher_ce &C.zend_class_entry
__global C.vslim__job__worker_ce &C.zend_class_entry

@[export: 'VSlimJobDispatcher_new_raw']
pub fn vslimjobdispatcher_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimJobDispatcher]()
}
@[export: 'VSlimJobDispatcher_free_raw']
pub fn vslimjobdispatcher_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimJobDispatcher](ptr)
}
@[export: 'VSlimJobDispatcher_cleanup_raw']
pub fn vslimjobdispatcher_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimJobDispatcher_get_prop']
pub fn vslimjobdispatcher_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimJobDispatcher_set_prop']
pub fn vslimjobdispatcher_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimJobDispatcher_sync_props']
pub fn vslimjobdispatcher_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimJobDispatcher_construct']
pub fn vphp_wrap_vslimjobdispatcher_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobDispatcher_set_manager']
pub fn vphp_wrap_vslimjobdispatcher_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'manager', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(php_args.at_named_or_index(0, 'manager').raw_obj()) }
    res := recv.set_manager(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobDispatcher_manager']
pub fn vphp_wrap_vslimjobdispatcher_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.manager()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobDispatcher_dispatch']
pub fn vphp_wrap_vslimjobdispatcher_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimJobDispatcher(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'jobClass', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'payload', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'queue', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'delaySeconds', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'maxAttempts', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'jobClass').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'payload').value
    arg_2 := php_args.at_named_or_index(2, 'queue').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'delaySeconds').as_v[int]()
    arg_4 := php_args.at_named_or_index(4, 'maxAttempts').as_v[int]()
    res := recv.dispatch(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return().v[i64](res)
}
@[export: 'VSlimJobDispatcher_handlers']
pub fn vslimjobdispatcher_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimjobdispatcher_get_prop),
        write_handler: voidptr(vslimjobdispatcher_set_prop),
        sync_handler: voidptr(vslimjobdispatcher_sync_props),
        new_raw: voidptr(vslimjobdispatcher_new_raw),
        cleanup_raw: voidptr(vslimjobdispatcher_cleanup_raw),
        free_raw: voidptr(vslimjobdispatcher_free_raw)
    )
}
pub fn VSlimJobDispatcher.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__job__dispatcher_ce)
}

pub fn VSlimJobDispatcher.php_object_handlers() voidptr {
    return vslimjobdispatcher_handlers()
}

pub fn VSlimJobDispatcher.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimJobDispatcher](v_ptr, ownership)
}

pub fn (obj &VSlimJobDispatcher) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimJobDispatcher](obj)
}

pub fn (obj &VSlimJobDispatcher) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimJobDispatcher](obj)
}

pub fn (obj &VSlimJobDispatcher) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimJobDispatcher](obj)
}

pub fn (obj &VSlimJobDispatcher) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimJobDispatcher](obj)
}

@[export: 'VSlimJobWorker_new_raw']
pub fn vslimjobworker_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimJobWorker]()
}
@[export: 'VSlimJobWorker_free_raw']
pub fn vslimjobworker_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimJobWorker](ptr)
}
@[export: 'VSlimJobWorker_cleanup_raw']
pub fn vslimjobworker_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimJobWorker_get_prop']
pub fn vslimjobworker_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimJobWorker_set_prop']
pub fn vslimjobworker_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimJobWorker_sync_props']
pub fn vslimjobworker_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimJobWorker_construct']
pub fn vphp_wrap_vslimjobworker_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobWorker_set_manager']
pub fn vphp_wrap_vslimjobworker_set_manager(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'manager', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(php_args.at_named_or_index(0, 'manager').raw_obj()) }
    res := recv.set_manager(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobWorker_set_worker_id']
pub fn vphp_wrap_vslimjobworker_set_worker_id(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'workerId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'workerId').as_v[string]()
    res := recv.set_worker_id(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobWorker_worker_id_value']
pub fn vphp_wrap_vslimjobworker_worker_id_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.worker_id_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimJobWorker_set_retry_delay_seconds']
pub fn vphp_wrap_vslimjobworker_set_retry_delay_seconds(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'seconds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'seconds').as_v[int]()
    res := recv.set_retry_delay_seconds(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobWorker_set_reserve_timeout_seconds']
pub fn vphp_wrap_vslimjobworker_set_reserve_timeout_seconds(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'seconds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'seconds').as_v[int]()
    res := recv.set_reserve_timeout_seconds(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimJobWorker_run_once']
pub fn vphp_wrap_vslimjobworker_run_once(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'queue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'queue').as_v[string]()
    res := recv.run_once(arg_0)
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimJobWorker_run']
pub fn vphp_wrap_vslimjobworker_run(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimJobWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'queue', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'maxJobs', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'sleepMs', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'stopWhenEmpty', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'queue').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'maxJobs').as_v[int]()
    arg_2 := php_args.at_named_or_index(2, 'sleepMs').as_v[int]()
    arg_3 := php_args.at_named_or_index(3, 'stopWhenEmpty').as_v[bool]()
    res := recv.run(arg_0, arg_1, arg_2, arg_3)
    ctx.return().v[int](res)
}
@[export: 'VSlimJobWorker_handlers']
pub fn vslimjobworker_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimjobworker_get_prop),
        write_handler: voidptr(vslimjobworker_set_prop),
        sync_handler: voidptr(vslimjobworker_sync_props),
        new_raw: voidptr(vslimjobworker_new_raw),
        cleanup_raw: voidptr(vslimjobworker_cleanup_raw),
        free_raw: voidptr(vslimjobworker_free_raw)
    )
}
pub fn VSlimJobWorker.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__job__worker_ce)
}

pub fn VSlimJobWorker.php_object_handlers() voidptr {
    return vslimjobworker_handlers()
}

pub fn VSlimJobWorker.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimJobWorker](v_ptr, ownership)
}

pub fn (obj &VSlimJobWorker) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimJobWorker](obj)
}

pub fn (obj &VSlimJobWorker) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimJobWorker](obj)
}

pub fn (obj &VSlimJobWorker) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimJobWorker](obj)
}

pub fn (obj &VSlimJobWorker) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimJobWorker](obj)
}

