module loggerx

import vphp

#include "php_bridge.h"

__global C.vslim__log__logger_ce &C.zend_class_entry
__global C.vslim__log__psrlogger_ce &C.zend_class_entry
__global C.vslim__log__level_ce &C.zend_class_entry

@[export: 'vslim_logger_new_raw']
pub fn vslim_logger_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLogger]()
}
@[export: 'vslim_logger_free_raw']
pub fn vslim_logger_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLogger](ptr)
}
@[export: 'vslim_logger_cleanup_raw']
pub fn vslim_logger_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_logger_get_prop']
pub fn vslim_logger_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_logger_set_prop']
pub fn vslim_logger_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_logger_sync_props']
pub fn vslim_logger_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_logger_construct']
pub fn vphp_wrap_vslim_logger_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_disabled_level']
pub fn vphp_wrap_vslim_logger_disabled_level(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogger.disabled_level()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_fatal_level']
pub fn vphp_wrap_vslim_logger_fatal_level(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogger.fatal_level()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_error_level']
pub fn vphp_wrap_vslim_logger_error_level(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogger.error_level()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_warn_level']
pub fn vphp_wrap_vslim_logger_warn_level(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogger.warn_level()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_info_level']
pub fn vphp_wrap_vslim_logger_info_level(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogger.info_level()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_debug_level']
pub fn vphp_wrap_vslim_logger_debug_level(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogger.debug_level()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_set_level']
pub fn vphp_wrap_vslim_logger_set_level(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'level', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'level').as_v[string]()
    res := recv.set_level(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_level']
pub fn vphp_wrap_vslim_logger_level(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.level()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_set_channel']
pub fn vphp_wrap_vslim_logger_set_channel(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'channel', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'channel').as_v[string]()
    res := recv.set_channel(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_channel']
pub fn vphp_wrap_vslim_logger_channel(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.channel()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_set_context']
pub fn vphp_wrap_vslim_logger_set_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'context').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_context(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_context']
pub fn vphp_wrap_vslim_logger_context(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.context()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_logger_with_context']
pub fn vphp_wrap_vslim_logger_with_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    res := recv.with_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_clear_context']
pub fn vphp_wrap_vslim_logger_clear_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_context()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_set_local_time']
pub fn vphp_wrap_vslim_logger_set_local_time(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'enabled', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'enabled').as_v[bool]()
    res := recv.set_local_time(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_set_short_tag']
pub fn vphp_wrap_vslim_logger_set_short_tag(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'enabled', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'enabled').as_v[bool]()
    res := recv.set_short_tag(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_set_output_file']
pub fn vphp_wrap_vslim_logger_set_output_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.set_output_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_output_file']
pub fn vphp_wrap_vslim_logger_output_file(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.output_file()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_use_stdout']
pub fn vphp_wrap_vslim_logger_use_stdout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.use_stdout()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_use_stderr']
pub fn vphp_wrap_vslim_logger_use_stderr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.use_stderr()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_output_target']
pub fn vphp_wrap_vslim_logger_output_target(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.output_target()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_logger_log']
pub fn vphp_wrap_vslim_logger_log(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'level', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'level').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'message').as_v[string]()
    res := recv.log(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_log_context']
pub fn vphp_wrap_vslim_logger_log_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'level', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'level').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'message').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'context').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return unsafe { nil }
    }
    res := recv.log_context(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_debug']
pub fn vphp_wrap_vslim_logger_debug(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.debug(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_debug_context']
pub fn vphp_wrap_vslim_logger_debug_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.debug_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_info']
pub fn vphp_wrap_vslim_logger_info(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.info(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_info_context']
pub fn vphp_wrap_vslim_logger_info_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.info_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_warn']
pub fn vphp_wrap_vslim_logger_warn(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.warn(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_warn_context']
pub fn vphp_wrap_vslim_logger_warn_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.warn_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_error']
pub fn vphp_wrap_vslim_logger_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_error_context']
pub fn vphp_wrap_vslim_logger_error_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.error_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_warning']
pub fn vphp_wrap_vslim_logger_warning(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.warning(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_warning_context']
pub fn vphp_wrap_vslim_logger_warning_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.warning_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_notice']
pub fn vphp_wrap_vslim_logger_notice(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.notice(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_notice_context']
pub fn vphp_wrap_vslim_logger_notice_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.notice_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_critical']
pub fn vphp_wrap_vslim_logger_critical(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.critical(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_critical_context']
pub fn vphp_wrap_vslim_logger_critical_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.critical_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_alert']
pub fn vphp_wrap_vslim_logger_alert(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.alert(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_alert_context']
pub fn vphp_wrap_vslim_logger_alert_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.alert_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_emergency']
pub fn vphp_wrap_vslim_logger_emergency(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.emergency(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_emergency_context']
pub fn vphp_wrap_vslim_logger_emergency_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'context').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return unsafe { nil }
    }
    res := recv.emergency_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_logger_str']
pub fn vphp_wrap_vslim_logger_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'vslim_logger_handlers']
pub fn vslim_logger_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_logger_get_prop),
        write_handler: voidptr(vslim_logger_set_prop),
        sync_handler: voidptr(vslim_logger_sync_props),
        new_raw: voidptr(vslim_logger_new_raw),
        cleanup_raw: voidptr(vslim_logger_cleanup_raw),
        free_raw: voidptr(vslim_logger_free_raw)
    )
}
pub fn VSlimLogger.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__log__logger_ce)
}

pub fn VSlimLogger.php_object_handlers() voidptr {
    return vslim_logger_handlers()
}

pub fn VSlimLogger.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimLogger](v_ptr, ownership)
}

pub fn (obj &VSlimLogger) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimLogger](obj)
}

pub fn (obj &VSlimLogger) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimLogger](obj)
}

pub fn (obj &VSlimLogger) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimLogger](obj)
}

pub fn (obj &VSlimLogger) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimLogger](obj)
}

@[export: 'vslim_psr_logger_new_raw']
pub fn vslim_psr_logger_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsrLogger]()
}
@[export: 'vslim_psr_logger_free_raw']
pub fn vslim_psr_logger_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsrLogger](ptr)
}
@[export: 'vslim_psr_logger_cleanup_raw']
pub fn vslim_psr_logger_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_psr_logger_get_prop']
pub fn vslim_psr_logger_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr_logger_set_prop']
pub fn vslim_psr_logger_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr_logger_sync_props']
pub fn vslim_psr_logger_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr_logger_construct']
pub fn vphp_wrap_vslim_psr_logger_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_set_logger']
pub fn vphp_wrap_vslim_psr_logger_set_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'inner', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &loggerx.VSlimLogger(php_args.at_named_or_index(0, 'inner').raw_obj()) }
    res := recv.set_logger(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_logger']
pub fn vphp_wrap_vslim_psr_logger_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.logger()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_set_level']
pub fn vphp_wrap_vslim_psr_logger_set_level(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'level', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'level').as_v[string]()
    res := recv.set_level(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_set_channel']
pub fn vphp_wrap_vslim_psr_logger_set_channel(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'channel', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'channel').as_v[string]()
    res := recv.set_channel(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_set_context']
pub fn vphp_wrap_vslim_psr_logger_set_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'context').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return unsafe { nil }
    }
    res := recv.set_context(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_with_context']
pub fn vphp_wrap_vslim_psr_logger_with_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    res := recv.with_context(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_clear_context']
pub fn vphp_wrap_vslim_psr_logger_clear_context(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_context()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_set_output_file']
pub fn vphp_wrap_vslim_psr_logger_set_output_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.set_output_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_use_stdout']
pub fn vphp_wrap_vslim_psr_logger_use_stdout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.use_stdout()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_use_stderr']
pub fn vphp_wrap_vslim_psr_logger_use_stderr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.use_stderr()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr_logger_log']
pub fn vphp_wrap_vslim_psr_logger_log(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'level', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'level').value
    arg_1 := php_args.at_named_or_index(1, 'message').value
    arg_2_params_context := if php_args.has_named_or_index(2, 'context') {
        php_args.at_named_or_index(2, 'context').array() or {
            vphp.throw_exception('argument 2 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_2_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_2_params_context
    }
    recv.log(arg_0, arg_1, arg_2_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_emergency']
pub fn vphp_wrap_vslim_psr_logger_emergency(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.emergency(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_alert']
pub fn vphp_wrap_vslim_psr_logger_alert(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.alert(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_critical']
pub fn vphp_wrap_vslim_psr_logger_critical(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.critical(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_error']
pub fn vphp_wrap_vslim_psr_logger_error(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.error(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_warning']
pub fn vphp_wrap_vslim_psr_logger_warning(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.warning(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_notice']
pub fn vphp_wrap_vslim_psr_logger_notice(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.notice(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_info']
pub fn vphp_wrap_vslim_psr_logger_info(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.info(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_debug']
pub fn vphp_wrap_vslim_psr_logger_debug(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'context', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').value
    arg_1_params_context := if php_args.has_named_or_index(1, 'context') {
        php_args.at_named_or_index(1, 'context').array() or {
            vphp.throw_exception('argument 1 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_1_params := loggerx.VSlimPsrLoggerContextParams{
        context: arg_1_params_context
    }
    recv.debug(arg_0, arg_1_params)
}
@[export: 'vphp_wrap_vslim_psr_logger_str']
pub fn vphp_wrap_vslim_psr_logger_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsrLogger(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'vslim_psr_logger_handlers']
pub fn vslim_psr_logger_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr_logger_get_prop),
        write_handler: voidptr(vslim_psr_logger_set_prop),
        sync_handler: voidptr(vslim_psr_logger_sync_props),
        new_raw: voidptr(vslim_psr_logger_new_raw),
        cleanup_raw: voidptr(vslim_psr_logger_cleanup_raw),
        free_raw: voidptr(vslim_psr_logger_free_raw)
    )
}
pub fn VSlimPsrLogger.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__log__psrlogger_ce)
}

pub fn VSlimPsrLogger.php_object_handlers() voidptr {
    return vslim_psr_logger_handlers()
}

pub fn VSlimPsrLogger.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsrLogger](v_ptr, ownership)
}

pub fn (obj &VSlimPsrLogger) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsrLogger](obj)
}

pub fn (obj &VSlimPsrLogger) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsrLogger](obj)
}

pub fn (obj &VSlimPsrLogger) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsrLogger](obj)
}

pub fn (obj &VSlimPsrLogger) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsrLogger](obj)
}

@[export: 'vslim_log_level_new_raw']
pub fn vslim_log_level_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimLogLevel]()
}
@[export: 'vslim_log_level_free_raw']
pub fn vslim_log_level_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimLogLevel](ptr)
}
@[export: 'vslim_log_level_cleanup_raw']
pub fn vslim_log_level_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_log_level_get_prop']
pub fn vslim_log_level_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_log_level_set_prop']
pub fn vslim_log_level_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_log_level_sync_props']
pub fn vslim_log_level_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
pub fn VSlimLogLevel.consts() VSlimLogLevelConsts {
    return vslim_log_level_consts
}
@[export: 'vphp_wrap_vslim_log_level_disabled']
pub fn vphp_wrap_vslim_log_level_disabled(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogLevel.disabled()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_log_level_fatal']
pub fn vphp_wrap_vslim_log_level_fatal(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogLevel.fatal()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_log_level_error']
pub fn vphp_wrap_vslim_log_level_error(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogLevel.error()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_log_level_warn']
pub fn vphp_wrap_vslim_log_level_warn(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogLevel.warn()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_log_level_info']
pub fn vphp_wrap_vslim_log_level_info(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogLevel.info()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_log_level_debug']
pub fn vphp_wrap_vslim_log_level_debug(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogLevel.debug()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_log_level_all']
pub fn vphp_wrap_vslim_log_level_all(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimLogLevel.all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vslim_log_level_handlers']
pub fn vslim_log_level_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_log_level_get_prop),
        write_handler: voidptr(vslim_log_level_set_prop),
        sync_handler: voidptr(vslim_log_level_sync_props),
        new_raw: voidptr(vslim_log_level_new_raw),
        cleanup_raw: voidptr(vslim_log_level_cleanup_raw),
        free_raw: voidptr(vslim_log_level_free_raw)
    )
}
pub fn VSlimLogLevel.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__log__level_ce)
}

pub fn VSlimLogLevel.php_object_handlers() voidptr {
    return vslim_log_level_handlers()
}

pub fn VSlimLogLevel.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimLogLevel](v_ptr, ownership)
}

pub fn (obj &VSlimLogLevel) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimLogLevel](obj)
}

pub fn (obj &VSlimLogLevel) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimLogLevel](obj)
}

pub fn (obj &VSlimLogLevel) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimLogLevel](obj)
}

pub fn (obj &VSlimLogLevel) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimLogLevel](obj)
}

