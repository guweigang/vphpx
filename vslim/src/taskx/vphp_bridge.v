module taskx

import vphp
import vphp.object

#include "php_bridge.h"

__global C.vslim__taskchannel_ce &C.zend_class_entry
__global C.vslim__task_ce &C.zend_class_entry
__global C.vslim__taskcancelledexception_ce &C.zend_class_entry
__global C.vslim__tasktimeoutexception_ce &C.zend_class_entry
__global C.vslim__taskhandle_ce &C.zend_class_entry

@[export: 'vslim_task_channel_new_raw']
pub fn vslim_task_channel_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTaskChannel]()
}
@[export: 'vslim_task_channel_free_raw']
pub fn vslim_task_channel_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTaskChannel](ptr)
}
@[export: 'vslim_task_channel_cleanup_raw']
pub fn vslim_task_channel_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_task_channel_get_prop']
pub fn vslim_task_channel_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_task_channel_set_prop']
pub fn vslim_task_channel_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_task_channel_sync_props']
pub fn vslim_task_channel_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_task_channel_construct']
pub fn vphp_wrap_vslim_task_channel_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskChannel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    recv.construct()
}
@[export: 'vphp_wrap_vslim_task_channel_send']
pub fn vphp_wrap_vslim_task_channel_send(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskChannel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).as_v[i64]()
    ctx.return().from_result[VSlimTaskChannelStatus](fn [arg_0, arg_1, recv] () !VSlimTaskChannelStatus {
        return recv.send(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_channel_receive']
pub fn vphp_wrap_vslim_task_channel_receive(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskChannel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[i64]()
    ctx.return().from_result[vphp.PhpArray](fn [arg_0, recv] () !vphp.PhpArray {
        return recv.receive(arg_0)!
    })
}
@[export: 'vphp_wrap_vslim_task_channel_close']
pub fn vphp_wrap_vslim_task_channel_close(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskChannel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_result[bool](fn [recv] () !bool {
        return recv.close()!
    })
}
@[export: 'vphp_wrap_vslim_task_channel_get_iterator']
pub fn vphp_wrap_vslim_task_channel_get_iterator(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskChannel(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_result[vphp.PhpIterator](fn [recv] () !vphp.PhpIterator {
        return recv.get_iterator()!
    })
}
@[export: 'vslim_task_channel_handlers']
pub fn vslim_task_channel_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_task_channel_get_prop,
        write_handler: vslim_task_channel_set_prop,
        sync_handler: vslim_task_channel_sync_props,
        new_raw: vslim_task_channel_new_raw,
        cleanup_raw: vslim_task_channel_cleanup_raw,
        free_raw: vslim_task_channel_free_raw
    )
}
pub fn VSlimTaskChannel.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__taskchannel_ce)
}

pub fn VSlimTaskChannel.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_task_channel_handlers())
}

pub fn VSlimTaskChannel.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimTaskChannel](v_ptr, ownership)
}

pub fn (obj &VSlimTaskChannel) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimTaskChannel](obj)
}

pub fn (obj &VSlimTaskChannel) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimTaskChannel](obj)
}

pub fn (obj &VSlimTaskChannel) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimTaskChannel](obj)
}

pub fn (obj &VSlimTaskChannel) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimTaskChannel](obj)
}

pub fn (val VSlimTaskChannel) php_class_name() string {
    return 'VSlim\\TaskChannel'
}

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
@[export: 'vphp_wrap_vslim_task_channel']
pub fn vphp_wrap_vslim_task_channel(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'capacity' },
    ])
    arg_0 := php_args.at(0).as_v[i64]()
    ctx.return().from_result[vphp.PhpValue](fn [arg_0] () !vphp.PhpValue {
        return VSlimTask.channel(arg_0)!
    })
}
@[export: 'vphp_wrap_vslim_task_list']
pub fn vphp_wrap_vslim_task_list(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimTask.list()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_task_spawn']
pub fn vphp_wrap_vslim_task_spawn(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'target' },
        vphp.PhpArgMeta{ index: 1, name: 'params' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, arg_1] () !vphp.PhpValue {
        return VSlimTask.@spawn(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_wait_all']
pub fn vphp_wrap_vslim_task_wait_all(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'tasks' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, arg_1] () !vphp.PhpValue {
        return VSlimTask.wait_all(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_wait_all_settled']
pub fn vphp_wrap_vslim_task_wait_all_settled(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'tasks' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, arg_1] () !vphp.PhpValue {
        return VSlimTask.wait_all_settled(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_wait_any']
pub fn vphp_wrap_vslim_task_wait_any(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'tasks' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, arg_1] () !vphp.PhpValue {
        return VSlimTask.wait_any(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_await_readable']
pub fn vphp_wrap_vslim_task_await_readable(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'stream' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    ctx.return().from_result[bool](fn [arg_0, arg_1] () !bool {
        return VSlimTask.await_readable(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_await_writable']
pub fn vphp_wrap_vslim_task_await_writable(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'stream' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    ctx.return().from_result[bool](fn [arg_0, arg_1] () !bool {
        return VSlimTask.await_writable(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_wait_streams']
pub fn vphp_wrap_vslim_task_wait_streams(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'read', use_php_default: true },
        vphp.PhpArgMeta{ index: 1, name: 'write', use_php_default: true },
        vphp.PhpArgMeta{ index: 2, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at(1).array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    arg_2 := php_args.at(2).as_v[i64]()
    ctx.return().from_result[vphp.PhpArray](fn [arg_0, arg_1, arg_2] () !vphp.PhpArray {
        return VSlimTask.wait_streams(arg_0, arg_1, arg_2)!
    })
}
@[export: 'vphp_wrap_vslim_task_accept']
pub fn vphp_wrap_vslim_task_accept(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'listener' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, arg_1] () !vphp.PhpValue {
        return VSlimTask.accept(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_connect']
pub fn vphp_wrap_vslim_task_connect(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'address' },
        vphp.PhpArgMeta{ index: 1, name: 'timeoutMs', use_php_default: true },
        vphp.PhpArgMeta{ index: 2, name: 'context', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[i64]()
    arg_2 := php_args.at(2).value
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, arg_1, arg_2] () !vphp.PhpValue {
        return VSlimTask.connect(arg_0, arg_1, arg_2)!
    })
}
@[export: 'vphp_wrap_vslim_task_listen']
pub fn vphp_wrap_vslim_task_listen(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'address' },
        vphp.PhpArgMeta{ index: 1, name: 'context', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).value
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, arg_1] () !vphp.PhpValue {
        return VSlimTask.listen(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_task_copy_stream']
pub fn vphp_wrap_vslim_task_copy_stream(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'source' },
        vphp.PhpArgMeta{ index: 1, name: 'destination' },
        vphp.PhpArgMeta{ index: 2, name: 'length', use_php_default: true },
        vphp.PhpArgMeta{ index: 3, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return
    }
    arg_1 := php_args.at(1).resource() or {
        vphp.throw_exception('argument 1 must be resource', 0)
        return
    }
    arg_2 := php_args.at(2).as_v[i64]()
    arg_3 := php_args.at(3).as_v[i64]()
    ctx.return().from_result[i64](fn [arg_0, arg_1, arg_2, arg_3] () !i64 {
        return VSlimTask.copy_stream(arg_0, arg_1, arg_2, arg_3)!
    })
}
@[export: 'vphp_wrap_vslim_task_read_exactly']
pub fn vphp_wrap_vslim_task_read_exactly(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'stream' },
        vphp.PhpArgMeta{ index: 1, name: 'length' },
        vphp.PhpArgMeta{ index: 2, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    arg_2 := php_args.at(2).as_v[i64]()
    ctx.return().from_result[string](fn [arg_0, arg_1, arg_2] () !string {
        return VSlimTask.read_exactly(arg_0, arg_1, arg_2)!
    })
}
@[export: 'vphp_wrap_vslim_task_read_line']
pub fn vphp_wrap_vslim_task_read_line(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'stream' },
        vphp.PhpArgMeta{ index: 1, name: 'maxBytes' },
        vphp.PhpArgMeta{ index: 2, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[i64]()
    arg_2 := php_args.at(2).as_v[i64]()
    ctx.return().from_result[string](fn [arg_0, arg_1, arg_2] () !string {
        return VSlimTask.read_line(arg_0, arg_1, arg_2)!
    })
}
@[export: 'vphp_wrap_vslim_task_write_all']
pub fn vphp_wrap_vslim_task_write_all(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'stream' },
        vphp.PhpArgMeta{ index: 1, name: 'data' },
        vphp.PhpArgMeta{ index: 2, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).resource() or {
        vphp.throw_exception('argument 0 must be resource', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[i64]()
    ctx.return().from_result[i64](fn [arg_0, arg_1, arg_2] () !i64 {
        return VSlimTask.write_all(arg_0, arg_1, arg_2)!
    })
}
@[export: 'vphp_wrap_vslim_task_sleep']
pub fn vphp_wrap_vslim_task_sleep(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'milliseconds' },
    ])
    arg_0 := php_args.at(0).as_v[i64]()
    ctx.return().from_result_void(fn [arg_0] () ! {
        VSlimTask.sleep(arg_0)!
    })
}
@[export: 'vslim_task_handlers']
pub fn vslim_task_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_task_get_prop,
        write_handler: vslim_task_set_prop,
        sync_handler: vslim_task_sync_props,
        new_raw: vslim_task_new_raw,
        cleanup_raw: vslim_task_cleanup_raw,
        free_raw: vslim_task_free_raw
    )
}
pub fn VSlimTask.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__task_ce)
}

pub fn VSlimTask.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_task_handlers())
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

@[export: 'vslim_task_cancelled_exception_new_raw']
pub fn vslim_task_cancelled_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTaskCancelledException]()
}
@[export: 'vslim_task_cancelled_exception_free_raw']
pub fn vslim_task_cancelled_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTaskCancelledException](ptr)
}
@[export: 'vslim_task_cancelled_exception_cleanup_raw']
pub fn vslim_task_cancelled_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
pub fn vslim_task_cancelled_exception_load_from_php(php_obj vphp.ZendObject) VSlimTaskCancelledException {
    return VSlimTaskCancelledException{
    }
}
pub fn vslim_task_cancelled_exception_snapshot(recv VSlimTaskCancelledException) VSlimTaskCancelledException {
    return recv
}
pub fn vslim_task_cancelled_exception_sync_to_php(php_obj vphp.ZendObject, original VSlimTaskCancelledException, recv VSlimTaskCancelledException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_task_cancelled_exception_get_prop']
pub fn vslim_task_cancelled_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_task_cancelled_exception_set_prop']
pub fn vslim_task_cancelled_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_task_cancelled_exception_sync_props']
pub fn vslim_task_cancelled_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_task_cancelled_exception_handlers']
pub fn vslim_task_cancelled_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_task_cancelled_exception_get_prop,
        write_handler: vslim_task_cancelled_exception_set_prop,
        sync_handler: vslim_task_cancelled_exception_sync_props,
        new_raw: vslim_task_cancelled_exception_new_raw,
        cleanup_raw: vslim_task_cancelled_exception_cleanup_raw,
        free_raw: vslim_task_cancelled_exception_free_raw
    )
}
pub fn VSlimTaskCancelledException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__taskcancelledexception_ce)
}

pub fn VSlimTaskCancelledException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_task_cancelled_exception_handlers())
}

pub fn VSlimTaskCancelledException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimTaskCancelledException](v_ptr, ownership)
}

pub fn (obj &VSlimTaskCancelledException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimTaskCancelledException](obj)
}

pub fn (obj &VSlimTaskCancelledException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimTaskCancelledException](obj)
}

pub fn (obj &VSlimTaskCancelledException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimTaskCancelledException](obj)
}

pub fn (obj &VSlimTaskCancelledException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimTaskCancelledException](obj)
}

pub fn (val VSlimTaskCancelledException) php_class_name() string {
    return 'VSlim\\TaskCancelledException'
}

@[export: 'vslim_task_timeout_exception_new_raw']
pub fn vslim_task_timeout_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimTaskTimeoutException]()
}
@[export: 'vslim_task_timeout_exception_free_raw']
pub fn vslim_task_timeout_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimTaskTimeoutException](ptr)
}
@[export: 'vslim_task_timeout_exception_cleanup_raw']
pub fn vslim_task_timeout_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
pub fn vslim_task_timeout_exception_load_from_php(php_obj vphp.ZendObject) VSlimTaskTimeoutException {
    return VSlimTaskTimeoutException{
    }
}
pub fn vslim_task_timeout_exception_snapshot(recv VSlimTaskTimeoutException) VSlimTaskTimeoutException {
    return recv
}
pub fn vslim_task_timeout_exception_sync_to_php(php_obj vphp.ZendObject, original VSlimTaskTimeoutException, recv VSlimTaskTimeoutException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_task_timeout_exception_get_prop']
pub fn vslim_task_timeout_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_task_timeout_exception_set_prop']
pub fn vslim_task_timeout_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_task_timeout_exception_sync_props']
pub fn vslim_task_timeout_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_task_timeout_exception_handlers']
pub fn vslim_task_timeout_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_task_timeout_exception_get_prop,
        write_handler: vslim_task_timeout_exception_set_prop,
        sync_handler: vslim_task_timeout_exception_sync_props,
        new_raw: vslim_task_timeout_exception_new_raw,
        cleanup_raw: vslim_task_timeout_exception_cleanup_raw,
        free_raw: vslim_task_timeout_exception_free_raw
    )
}
pub fn VSlimTaskTimeoutException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__tasktimeoutexception_ce)
}

pub fn VSlimTaskTimeoutException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_task_timeout_exception_handlers())
}

pub fn VSlimTaskTimeoutException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimTaskTimeoutException](v_ptr, ownership)
}

pub fn (obj &VSlimTaskTimeoutException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimTaskTimeoutException](obj)
}

pub fn (obj &VSlimTaskTimeoutException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimTaskTimeoutException](obj)
}

pub fn (obj &VSlimTaskTimeoutException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimTaskTimeoutException](obj)
}

pub fn (obj &VSlimTaskTimeoutException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimTaskTimeoutException](obj)
}

pub fn (val VSlimTaskTimeoutException) php_class_name() string {
    return 'VSlim\\TaskTimeoutException'
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
@[export: 'vphp_wrap_vslim_task_handle_status']
pub fn vphp_wrap_vslim_task_handle_status(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskHandle(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_result[VSlimTaskStatus](fn [recv] () !VSlimTaskStatus {
        return recv.status()!
    })
}
@[export: 'vphp_wrap_vslim_task_handle_outcome']
pub fn vphp_wrap_vslim_task_handle_outcome(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskHandle(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    ctx.return().from_result[vphp.PhpValue](fn [recv] () !vphp.PhpValue {
        return recv.outcome()!
    })
}
@[export: 'vphp_wrap_vslim_task_handle_wait']
pub fn vphp_wrap_vslim_task_handle_wait(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskHandle(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'timeoutMs', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[i64]()
    ctx.return().from_result[vphp.PhpValue](fn [arg_0, recv] () !vphp.PhpValue {
        return recv.wait(arg_0)!
    })
}
@[export: 'vphp_wrap_vslim_task_handle_cancel']
pub fn vphp_wrap_vslim_task_handle_cancel(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimTaskHandle(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'reason', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).throwable()
    ctx.return().from_result[bool](fn [arg_0, recv] () !bool {
        return recv.cancel(arg_0)!
    })
}
@[export: 'vslim_task_handle_handlers']
pub fn vslim_task_handle_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_task_handle_get_prop,
        write_handler: vslim_task_handle_set_prop,
        sync_handler: vslim_task_handle_sync_props,
        new_raw: vslim_task_handle_new_raw,
        cleanup_raw: vslim_task_handle_cleanup_raw,
        free_raw: vslim_task_handle_free_raw
    )
}
pub fn VSlimTaskHandle.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__taskhandle_ce)
}

pub fn VSlimTaskHandle.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_task_handle_handlers())
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

pub fn (val VSlimTaskChannelStatus) php_class_name() string {
    return 'VSlim\\TaskChannelStatus'
}
pub fn (val VSlimTaskChannelStatus) php_enum_case_name() string {
    if val == .ready { return 'Ready' }
    if val == .closed { return 'Closed' }
    if val == .timed_out { return 'TimedOut' }
    return val.str()
}

pub fn (val VSlimTaskStatus) php_class_name() string {
    return 'VSlim\\TaskStatus'
}
pub fn (val VSlimTaskStatus) php_enum_case_name() string {
    if val == .pending { return 'Pending' }
    if val == .fulfilled { return 'Fulfilled' }
    if val == .rejected { return 'Rejected' }
    return val.str()
}

