module module_probex

import vphp
import vphp.object

import eventx
import httpx
import streamx

#include "php_bridge.h"

__global C.vslim__dev__phpsignatureprobe_ce &C.zend_class_entry
__global C.vslim__debug__objectprobe_ce &C.zend_class_entry
__global C.vslim__dev__cloneresponseprobe_ce &C.zend_class_entry
__global C.vslim__dev__serializableuriprobe_ce &C.zend_class_entry

@[export: 'vslim_php_signature_probe_new_raw']
pub fn vslim_php_signature_probe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPhpSignatureProbe]()
}
@[export: 'vslim_php_signature_probe_free_raw']
pub fn vslim_php_signature_probe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPhpSignatureProbe](ptr)
}
@[export: 'vslim_php_signature_probe_cleanup_raw']
pub fn vslim_php_signature_probe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_php_signature_probe_get_prop']
pub fn vslim_php_signature_probe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_php_signature_probe_set_prop']
pub fn vslim_php_signature_probe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_php_signature_probe_sync_props']
pub fn vslim_php_signature_probe_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_php_signature_probe_construct']
pub fn vphp_wrap_vslim_php_signature_probe_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    ctx.return().return_v_object[VSlimPhpSignatureProbe](res, .borrowed)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_clone_with_properties']
pub fn vphp_wrap_vslim_php_signature_probe_clone_with_properties(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'object' },
        vphp.PhpArgMeta{ index: 1, name: 'properties' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    arg_1 := php_args.at(1).array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    ctx.return().from_result[vphp.PhpObject](fn [arg_0, arg_1, recv] () !vphp.PhpObject {
        return recv.clone_with_properties(arg_0, arg_1)!
    })
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_true']
pub fn vphp_wrap_vslim_php_signature_probe_always_true(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_true()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_false']
pub fn vphp_wrap_vslim_php_signature_probe_always_false(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_false()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_null']
pub fn vphp_wrap_vslim_php_signature_probe_always_null(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_null()
    ctx.return().v[vphp.PhpNull](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_throw']
pub fn vphp_wrap_vslim_php_signature_probe_always_throw(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_throw()
    ctx.return().v[vphp.PhpNull](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_true']
pub fn vphp_wrap_vslim_php_signature_probe_accept_true(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'flag' },
    ])
    arg_0 := php_args.at(0).bool_value() or {
        vphp.throw_exception('argument 0 must be bool', 0)
        return
    }
    res := recv.accept_true(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_false']
pub fn vphp_wrap_vslim_php_signature_probe_accept_false(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'flag' },
    ])
    arg_0 := php_args.at(0).bool_value() or {
        vphp.throw_exception('argument 0 must be bool', 0)
        return
    }
    res := recv.accept_false(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_null']
pub fn vphp_wrap_vslim_php_signature_probe_accept_null(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).null_value() or {
        vphp.throw_exception('argument 0 must be null', 0)
        return
    }
    res := recv.accept_null(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_callable']
pub fn vphp_wrap_vslim_php_signature_probe_accept_callable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'cb' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    res := recv.accept_callable(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_optional_tail']
pub fn vphp_wrap_vslim_php_signature_probe_optional_tail(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
        vphp.PhpArgMeta{ index: 1, name: 'suffix', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.optional_tail(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_make_psr_response']
pub fn vphp_wrap_vslim_php_signature_probe_make_psr_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_psr_response()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_make_static_psr_response']
pub fn vphp_wrap_vslim_php_signature_probe_make_static_psr_response(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimPhpSignatureProbe.make_static_psr_response()
    return voidptr(res)
}
__global C.struct_closure_arginfo_vslimphpsignatureprobe_make_fixed_status_callback voidptr

pub type VPhpFixedClosureVSlimPhpSignatureProbeMakeFixedStatusCallback = fn (&httpx.VSlimPsr7Response, ?int) int

fn vphp_fixed_closure_bridge_vslimphpsignatureprobe_make_fixed_status_callback(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpFixedClosureVSlimPhpSignatureProbeMakeFixedStatusCallback(v_ptr))
        arg_count := ctx.num_args()
        if arg_count > 2 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure accepts at most 2 arguments', 0)
            return
        }
        if arg_count < 1 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least 1 argument', 0)
            return
        }
        field_0_arg := vphp.PhpArg.from_zval(0, 'response', ctx.arg_val(0))
        field_0 := field_0_arg.bound_v_object[httpx.VSlimPsr7Response]() or {
            vphp.PhpException.raise_class('TypeError', err.msg(), 0)
            return
        }
        field_1 := if arg_count > 1 {
            mut provided_1 := ?int(none)
            if !ctx.arg_val(1).is_null() {
                provided_1 = ctx.closure_arg_to_v[int](1) or {
                    if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (adjustment): ${err.msg()}', 0) }
                    return
                }
            }
            provided_1
        } else {
            none
        }
        res := cb(field_0, field_1)
        ctx.return().v[int](res)
    }
}

fn vphp_wrap_fixed_closure_vslimphpsignatureprobe_make_fixed_status_callback(ctx vphp.Context, cb VPhpFixedClosureVSlimPhpSignatureProbeMakeFixedStatusCallback) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpFixedClosureVSlimPhpSignatureProbeMakeFixedStatusCallback](cb, vphp_fixed_closure_bridge_vslimphpsignatureprobe_make_fixed_status_callback, 2, 1, C.struct_closure_arginfo_vslimphpsignatureprobe_make_fixed_status_callback)
}

@[export: 'vphp_wrap_vslim_php_signature_probe_make_fixed_status_callback']
pub fn vphp_wrap_vslim_php_signature_probe_make_fixed_status_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_fixed_status_callback()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_fixed_closure_vslimphpsignatureprobe_make_fixed_status_callback(ctx, res)
}
__global C.struct_closure_arginfo_vslimphpsignatureprobe_make_adjusted_status_callback voidptr

pub type VPhpFixedClosureVSlimPhpSignatureProbeMakeAdjustedStatusCallback = fn (&httpx.VSlimPsr7Response, ...int) int

fn vphp_fixed_closure_bridge_vslimphpsignatureprobe_make_adjusted_status_callback(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpFixedClosureVSlimPhpSignatureProbeMakeAdjustedStatusCallback(v_ptr))
        arg_count := ctx.num_args()
        if arg_count < 1 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least 1 argument', 0)
            return
        }
        field_0_arg := vphp.PhpArg.from_zval(0, 'response', ctx.arg_val(0))
        field_0 := field_0_arg.bound_v_object[httpx.VSlimPsr7Response]() or {
            vphp.PhpException.raise_class('TypeError', err.msg(), 0)
            return
        }
        args := ctx.variadic_closure_args_from[int](1) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', err.msg(), 0) }
            return
        }
        res := cb(field_0, ...args)
        ctx.return().v[int](res)
    }
}

fn vphp_wrap_fixed_closure_vslimphpsignatureprobe_make_adjusted_status_callback(ctx vphp.Context, cb VPhpFixedClosureVSlimPhpSignatureProbeMakeAdjustedStatusCallback) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpFixedClosureVSlimPhpSignatureProbeMakeAdjustedStatusCallback](cb, vphp_fixed_closure_bridge_vslimphpsignatureprobe_make_adjusted_status_callback, 2, 1, C.struct_closure_arginfo_vslimphpsignatureprobe_make_adjusted_status_callback)
}

@[export: 'vphp_wrap_vslim_php_signature_probe_make_adjusted_status_callback']
pub fn vphp_wrap_vslim_php_signature_probe_make_adjusted_status_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_adjusted_status_callback()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_fixed_closure_vslimphpsignatureprobe_make_adjusted_status_callback(ctx, res)
}
__global C.struct_closure_arginfo_vslimphpsignatureprobe_make_response_status_callback voidptr

pub type VPhpStructClosureVSlimPhpSignatureProbeMakeResponseStatusCallback = fn (ProbeResponseOptions) ?int

fn vphp_struct_closure_bridge_vslimphpsignatureprobe_make_response_status_callback(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVSlimPhpSignatureProbeMakeResponseStatusCallback(v_ptr))
        arg_count := ctx.num_args()
        field_0 := if arg_count > 0 {
            provided_0 := ctx.closure_arg_to_v[bool](0) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (enabled): ${err.msg()}', 0) }
                return
            }
            provided_0
        } else {
            true
        }
        field_1 := if arg_count > 1 {
            provided_1_arg := vphp.PhpArg.from_zval(1, 'response', ctx.arg_val(1))
            provided_1 := if !provided_1_arg.is_present() || provided_1_arg.zval().is_null() {
                ?&httpx.VSlimPsr7Response(none)
            } else {
                bound_value := provided_1_arg.bound_v_object[httpx.VSlimPsr7Response]() or {
                    vphp.PhpException.raise_class('TypeError', err.msg(), 0)
                    return
                }
                ?&httpx.VSlimPsr7Response(bound_value)
            }
            provided_1
        } else {
            none
        }
        args := ProbeResponseOptions{
            enabled: field_0
            response: field_1
        }
        ctx.return().from_option[int](fn [cb, args] () ?int {
            return cb(args)
        })
    }
}

fn vphp_wrap_struct_closure_vslimphpsignatureprobe_make_response_status_callback(ctx vphp.Context, cb VPhpStructClosureVSlimPhpSignatureProbeMakeResponseStatusCallback) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVSlimPhpSignatureProbeMakeResponseStatusCallback](cb, vphp_struct_closure_bridge_vslimphpsignatureprobe_make_response_status_callback, 2, 0, C.struct_closure_arginfo_vslimphpsignatureprobe_make_response_status_callback)
}

@[export: 'vphp_wrap_vslim_php_signature_probe_make_response_status_callback']
pub fn vphp_wrap_vslim_php_signature_probe_make_response_status_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_response_status_callback()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_struct_closure_vslimphpsignatureprobe_make_response_status_callback(ctx, res)
}
__global C.struct_closure_arginfo_vslimphpsignatureprobe_make_psr_response_callback voidptr

pub type VPhpStructClosureVSlimPhpSignatureProbeMakePsrResponseCallback = fn (ProbeResponseOptions) ?&httpx.VSlimPsr7Response

fn vphp_struct_closure_bridge_vslimphpsignatureprobe_make_psr_response_callback(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVSlimPhpSignatureProbeMakePsrResponseCallback(v_ptr))
        arg_count := ctx.num_args()
        field_0 := if arg_count > 0 {
            provided_0 := ctx.closure_arg_to_v[bool](0) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (enabled): ${err.msg()}', 0) }
                return
            }
            provided_0
        } else {
            true
        }
        field_1 := if arg_count > 1 {
            provided_1_arg := vphp.PhpArg.from_zval(1, 'response', ctx.arg_val(1))
            provided_1 := if !provided_1_arg.is_present() || provided_1_arg.zval().is_null() {
                ?&httpx.VSlimPsr7Response(none)
            } else {
                bound_value := provided_1_arg.bound_v_object[httpx.VSlimPsr7Response]() or {
                    vphp.PhpException.raise_class('TypeError', err.msg(), 0)
                    return
                }
                ?&httpx.VSlimPsr7Response(bound_value)
            }
            provided_1
        } else {
            none
        }
        args := ProbeResponseOptions{
            enabled: field_0
            response: field_1
        }
        ctx.return().from_option_object[httpx.VSlimPsr7Response](fn [cb, args] () ?&httpx.VSlimPsr7Response {
            return cb(args)
        }, .owned_request)
    }
}

fn vphp_wrap_struct_closure_vslimphpsignatureprobe_make_psr_response_callback(ctx vphp.Context, cb VPhpStructClosureVSlimPhpSignatureProbeMakePsrResponseCallback) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVSlimPhpSignatureProbeMakePsrResponseCallback](cb, vphp_struct_closure_bridge_vslimphpsignatureprobe_make_psr_response_callback, 2, 0, C.struct_closure_arginfo_vslimphpsignatureprobe_make_psr_response_callback)
}

@[export: 'vphp_wrap_vslim_php_signature_probe_make_psr_response_callback']
pub fn vphp_wrap_vslim_php_signature_probe_make_psr_response_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_psr_response_callback()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_struct_closure_vslimphpsignatureprobe_make_psr_response_callback(ctx, res)
}
__global C.struct_closure_arginfo_vslimphpsignatureprobe_make_psr_response_selector voidptr

pub type VPhpVariadicClosureVSlimPhpSignatureProbeMakePsrResponseSelector = fn (...?&httpx.VSlimPsr7Response) ?&httpx.VSlimPsr7Response

fn vphp_variadic_closure_bridge_vslimphpsignatureprobe_make_psr_response_selector(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVSlimPhpSignatureProbeMakePsrResponseSelector(v_ptr))
        php_args := ctx.args()
        mut args := []?&httpx.VSlimPsr7Response{}
        for index in 0 .. php_args.len() {
            item := if !php_args.at(index).is_present() || php_args.at(index).zval().is_null() {
                ?&httpx.VSlimPsr7Response(none)
            } else {
                bound_value := php_args.at(index).bound_v_object[httpx.VSlimPsr7Response]() or {
                    vphp.PhpException.raise_class('TypeError', err.msg(), 0)
                    return
                }
                ?&httpx.VSlimPsr7Response(bound_value)
            }
            args << item
        }
        ctx.return().from_option_object[httpx.VSlimPsr7Response](fn [cb, args] () ?&httpx.VSlimPsr7Response {
            return cb(...args)
        }, .borrowed)
    }
}

fn vphp_wrap_variadic_closure_vslimphpsignatureprobe_make_psr_response_selector(ctx vphp.Context, cb VPhpVariadicClosureVSlimPhpSignatureProbeMakePsrResponseSelector) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVSlimPhpSignatureProbeMakePsrResponseSelector](cb, vphp_variadic_closure_bridge_vslimphpsignatureprobe_make_psr_response_selector, 1, 0, C.struct_closure_arginfo_vslimphpsignatureprobe_make_psr_response_selector)
}

@[export: 'vphp_wrap_vslim_php_signature_probe_make_psr_response_selector']
pub fn vphp_wrap_vslim_php_signature_probe_make_psr_response_selector(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_psr_response_selector()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_variadic_closure_vslimphpsignatureprobe_make_psr_response_selector(ctx, res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_psr_request']
pub fn vphp_wrap_vslim_php_signature_probe_accept_psr_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request' },
    ])
    arg_0 := php_args.at(0).zval().to_v[httpx.PsrRequest]() or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return
    }
    res := recv.accept_psr_request(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_select_last_psr_request']
pub fn vphp_wrap_vslim_php_signature_probe_select_last_psr_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    if !ctx.reject_named_variadic_args() {
        return
    }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'fallback' },
        vphp.PhpArgMeta{ index: 1, name: 'alternatives' },
    ])
    arg_0 := php_args.at(0).zval().to_v[httpx.PsrRequest]() or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return
    }
    mut arg_1 := []httpx.PsrRequest{}
    for arg_1_index in 1 .. php_args.len() {
        arg_1_item := php_args.at(arg_1_index).zval().to_v[httpx.PsrRequest]() or {
            vphp.PhpException.raise_class('TypeError', err.msg(), 0)
            return
        }
        arg_1 << arg_1_item
    }
    res := recv.select_last_psr_request(arg_0, ...arg_1)
    ctx.return().v[httpx.PsrRequest](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_named_psr_requests']
pub fn vphp_wrap_vslim_php_signature_probe_named_psr_requests(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'requests' },
    ])
    arg_0 := ctx.variadic_php_args(php_args, 0) or {
        return
    }
    res := recv.named_psr_requests(...arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
__global C.struct_closure_arginfo_vslimphpsignatureprobe_make_named_request_collector voidptr

pub type VPhpVariadicClosureVSlimPhpSignatureProbeMakeNamedRequestCollector = fn (...vphp.PhpArg) vphp.PhpArray

fn vphp_variadic_closure_bridge_vslimphpsignatureprobe_make_named_request_collector(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVSlimPhpSignatureProbeMakeNamedRequestCollector(v_ptr))
        args := ctx.variadic_closure_args_from[vphp.PhpArg](0) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', err.msg(), 0) }
            return
        }
        res := cb(...args)
        ctx.return().v[vphp.PhpArray](res)
    }
}

fn vphp_wrap_variadic_closure_vslimphpsignatureprobe_make_named_request_collector(ctx vphp.Context, cb VPhpVariadicClosureVSlimPhpSignatureProbeMakeNamedRequestCollector) {
    ctx.create_saved_named_variadic_closure[VPhpVariadicClosureVSlimPhpSignatureProbeMakeNamedRequestCollector](cb, vphp_variadic_closure_bridge_vslimphpsignatureprobe_make_named_request_collector, 1, 0, C.struct_closure_arginfo_vslimphpsignatureprobe_make_named_request_collector)
}

@[export: 'vphp_wrap_vslim_php_signature_probe_make_named_request_collector']
pub fn vphp_wrap_vslim_php_signature_probe_make_named_request_collector(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_named_request_collector()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_variadic_closure_vslimphpsignatureprobe_make_named_request_collector(ctx, res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_forward_callback_arguments']
pub fn vphp_wrap_vslim_php_signature_probe_forward_callback_arguments(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
        vphp.PhpArgMeta{ index: 1, name: 'arguments' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := ctx.variadic_php_args(php_args, 1) or {
        return
    }
    res := recv.forward_callback_arguments(arg_0, ...arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_recover_callback']
pub fn vphp_wrap_vslim_php_signature_probe_recover_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
        vphp.PhpArgMeta{ index: 1, name: 'recover' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := php_args.at(1).callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return
    }
    res := recv.recover_callback(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_echo_throwable']
pub fn vphp_wrap_vslim_php_signature_probe_echo_throwable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).throwable()
    ctx.return().from_option[vphp.PhpThrowable](fn [arg_0, recv] () ?vphp.PhpThrowable {
        return recv.echo_throwable(arg_0)
    })
}
@[export: 'vphp_wrap_vslim_php_signature_probe_echo_enum_case']
pub fn vphp_wrap_vslim_php_signature_probe_echo_enum_case(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).enum_case()
    ctx.return().from_option[vphp.PhpEnumCase](fn [arg_0, recv] () ?vphp.PhpEnumCase {
        return recv.echo_enum_case(arg_0)
    })
}
@[export: 'vphp_wrap_vslim_php_signature_probe_echo_stream_factory']
pub fn vphp_wrap_vslim_php_signature_probe_echo_stream_factory(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := if !php_args.at(0).is_present() || php_args.at(0).zval().is_null() {
        ?vphp.PhpInterface[streamx.VStreamResponseFactory](none)
    } else {
        bound_value := php_args.at(0).zval().to_v[vphp.PhpInterface[streamx.VStreamResponseFactory]]() or {
            vphp.PhpException.raise_class('TypeError', err.msg(), 0)
            return
        }
        ?vphp.PhpInterface[streamx.VStreamResponseFactory](bound_value)
    }
    ctx.return().from_option[vphp.PhpInterface[streamx.VStreamResponseFactory]](fn [arg_0, recv] () ?vphp.PhpInterface[streamx.VStreamResponseFactory] {
        return recv.echo_stream_factory(arg_0)
    })
}
__global C.struct_closure_arginfo_vslimphpsignatureprobe_make_stream_factory_callback voidptr

pub type VPhpFixedClosureVSlimPhpSignatureProbeMakeStreamFactoryCallback = fn (?vphp.PhpInterface[streamx.VStreamResponseFactory]) ?vphp.PhpInterface[streamx.VStreamResponseFactory]

fn vphp_fixed_closure_bridge_vslimphpsignatureprobe_make_stream_factory_callback(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpFixedClosureVSlimPhpSignatureProbeMakeStreamFactoryCallback(v_ptr))
        arg_count := ctx.num_args()
        if arg_count > 1 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure accepts at most 1 arguments', 0)
            return
        }
        field_0 := if arg_count > 0 {
            mut provided_0 := ?vphp.PhpInterface[streamx.VStreamResponseFactory](none)
            if !ctx.arg_val(0).is_null() {
                provided_0 = ctx.closure_arg_to_v[vphp.PhpInterface[streamx.VStreamResponseFactory]](0) or {
                    if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (value): ${err.msg()}', 0) }
                    return
                }
            }
            provided_0
        } else {
            none
        }
        ctx.return().from_option[vphp.PhpInterface[streamx.VStreamResponseFactory]](fn [cb, field_0] () ?vphp.PhpInterface[streamx.VStreamResponseFactory] {
            return cb(field_0)
        })
    }
}

fn vphp_wrap_fixed_closure_vslimphpsignatureprobe_make_stream_factory_callback(ctx vphp.Context, cb VPhpFixedClosureVSlimPhpSignatureProbeMakeStreamFactoryCallback) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpFixedClosureVSlimPhpSignatureProbeMakeStreamFactoryCallback](cb, vphp_fixed_closure_bridge_vslimphpsignatureprobe_make_stream_factory_callback, 1, 0, C.struct_closure_arginfo_vslimphpsignatureprobe_make_stream_factory_callback)
}

@[export: 'vphp_wrap_vslim_php_signature_probe_make_stream_factory_callback']
pub fn vphp_wrap_vslim_php_signature_probe_make_stream_factory_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_stream_factory_callback()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_fixed_closure_vslimphpsignatureprobe_make_stream_factory_callback(ctx, res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_datetime_interface']
pub fn vphp_wrap_vslim_php_signature_probe_accept_datetime_interface(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'expiration' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.accept_datetime_interface(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_set_provider']
pub fn vphp_wrap_vslim_php_signature_probe_set_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'provider' },
    ])
    arg_0 := php_args.at(0).bound_v_object[eventx.VSlimPsr14ListenerProvider]() or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return unsafe { nil }
    }
    res := recv.set_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_guard']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_guard(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_guard()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.borrowed_provider_from_if_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.borrowed_provider_from_if_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.borrowed_provider_from_match_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.borrowed_provider_from_match_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.fresh_provider_from_if_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.fresh_provider_from_if_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.fresh_provider_from_match_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    res := recv.fresh_provider_from_match_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'vslim_php_signature_probe_handlers']
pub fn vslim_php_signature_probe_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_php_signature_probe_get_prop,
        write_handler: vslim_php_signature_probe_set_prop,
        sync_handler: vslim_php_signature_probe_sync_props,
        new_raw: vslim_php_signature_probe_new_raw,
        cleanup_raw: vslim_php_signature_probe_cleanup_raw,
        free_raw: vslim_php_signature_probe_free_raw
    )
}
pub fn VSlimPhpSignatureProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__dev__phpsignatureprobe_ce)
}

pub fn VSlimPhpSignatureProbe.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_php_signature_probe_handlers())
}

pub fn VSlimPhpSignatureProbe.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPhpSignatureProbe](v_ptr, ownership)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPhpSignatureProbe](obj)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPhpSignatureProbe](obj)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPhpSignatureProbe](obj)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPhpSignatureProbe](obj)
}

pub fn (val VSlimPhpSignatureProbe) php_class_name() string {
    return 'VSlim\\Dev\\PhpSignatureProbe'
}

@[export: 'vslim_debug_object_probe_new_raw']
pub fn vslim_debug_object_probe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDebugObjectProbe]()
}
@[export: 'vslim_debug_object_probe_free_raw']
pub fn vslim_debug_object_probe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDebugObjectProbe](ptr)
}
@[export: 'vslim_debug_object_probe_cleanup_raw']
pub fn vslim_debug_object_probe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_debug_object_probe_get_prop']
pub fn vslim_debug_object_probe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_debug_object_probe_set_prop']
pub fn vslim_debug_object_probe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_debug_object_probe_sync_props']
pub fn vslim_debug_object_probe_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_debug_object_probe_probe']
pub fn vphp_wrap_vslim_debug_object_probe_probe(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'obj' },
        vphp.PhpArgMeta{ index: 1, name: 'className' },
        vphp.PhpArgMeta{ index: 2, name: 'methodName' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    res := VSlimDebugObjectProbe.probe(arg_0, arg_1, arg_2)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_debug_object_probe_psr7_lifecycle_counters']
pub fn vphp_wrap_vslim_debug_object_probe_psr7_lifecycle_counters(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rounds' },
    ])
    arg_0 := php_args.at(0).as_v[int]()
    res := VSlimDebugObjectProbe.psr7_lifecycle_counters(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vslim_debug_object_probe_handlers']
pub fn vslim_debug_object_probe_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_debug_object_probe_get_prop,
        write_handler: vslim_debug_object_probe_set_prop,
        sync_handler: vslim_debug_object_probe_sync_props,
        new_raw: vslim_debug_object_probe_new_raw,
        cleanup_raw: vslim_debug_object_probe_cleanup_raw,
        free_raw: vslim_debug_object_probe_free_raw
    )
}
pub fn VSlimDebugObjectProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__debug__objectprobe_ce)
}

pub fn VSlimDebugObjectProbe.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_debug_object_probe_handlers())
}

pub fn VSlimDebugObjectProbe.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDebugObjectProbe](v_ptr, ownership)
}

pub fn (obj &VSlimDebugObjectProbe) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDebugObjectProbe](obj)
}

pub fn (obj &VSlimDebugObjectProbe) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDebugObjectProbe](obj)
}

pub fn (obj &VSlimDebugObjectProbe) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDebugObjectProbe](obj)
}

pub fn (obj &VSlimDebugObjectProbe) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDebugObjectProbe](obj)
}

pub fn (val VSlimDebugObjectProbe) php_class_name() string {
    return 'VSlim\\Debug\\ObjectProbe'
}

@[export: 'vslim_clone_response_probe_new_raw']
pub fn vslim_clone_response_probe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimCloneResponseProbe]()
}
@[export: 'vslim_clone_response_probe_free_raw']
pub fn vslim_clone_response_probe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    mut obj := unsafe { &VSlimCloneResponseProbe(ptr) }
    vphp.generic_release_fields(mut obj.VSlimPsr7Response)
    vphp.generic_free_raw[VSlimCloneResponseProbe](ptr)
}
@[export: 'vslim_clone_response_probe_cleanup_raw']
pub fn vslim_clone_response_probe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimCloneResponseProbe(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_clone_response_probe_clone_into_raw']
pub fn vslim_clone_response_probe_clone_into_raw(source voidptr, target voidptr) {
    unsafe {
        src := &VSlimCloneResponseProbe(source)
        mut dst := &VSlimCloneResponseProbe(target)
        src.clone_into(mut dst)
    }
}
@[export: 'vslim_clone_response_probe_get_prop']
pub fn vslim_clone_response_probe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimCloneResponseProbe(ptr)
        if name == 'label' {
            ret.v[string](obj.label)
            return
        }
        if name == 'status' {
            ret.v[i64](i64(obj.VSlimPsr7Response.status))
            return
        }
    }
}
@[export: 'vslim_clone_response_probe_set_prop']
pub fn vslim_clone_response_probe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimCloneResponseProbe(ptr)
        if name == 'label' {
            obj.label = arg.get_string()
            return
        }
        if name == 'status' {
            obj.VSlimPsr7Response.status = int(arg.get_int())
            return
        }
    }
}
@[export: 'vslim_clone_response_probe_sync_props']
pub fn vslim_clone_response_probe_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimCloneResponseProbe(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'label', obj.label)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'status', obj.VSlimPsr7Response.status)
    }
}
@[export: 'vslim_clone_response_probe_handlers']
pub fn vslim_clone_response_probe_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_clone_response_probe_get_prop,
        write_handler: vslim_clone_response_probe_set_prop,
        sync_handler: vslim_clone_response_probe_sync_props,
        new_raw: vslim_clone_response_probe_new_raw,
        cleanup_raw: vslim_clone_response_probe_cleanup_raw,
        free_raw: vslim_clone_response_probe_free_raw,
        init_php_state: vslim_clone_response_probe_init_php_state
    )
}
fn vslim_clone_response_probe_init_php_state(ptr voidptr) {
    unsafe {
        mut obj := &VSlimCloneResponseProbe(ptr)
        obj.init_php_state()
    }
}
pub fn VSlimCloneResponseProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__dev__cloneresponseprobe_ce)
}

pub fn VSlimCloneResponseProbe.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_clone_response_probe_handlers())
}

pub fn VSlimCloneResponseProbe.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimCloneResponseProbe](v_ptr, ownership)
}

pub fn (obj &VSlimCloneResponseProbe) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimCloneResponseProbe](obj)
}

pub fn (obj &VSlimCloneResponseProbe) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimCloneResponseProbe](obj)
}

pub fn (obj &VSlimCloneResponseProbe) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimCloneResponseProbe](obj)
}

pub fn (obj &VSlimCloneResponseProbe) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimCloneResponseProbe](obj)
}

pub fn (val VSlimCloneResponseProbe) php_class_name() string {
    return 'VSlim\\Dev\\CloneResponseProbe'
}

@[export: 'vslim_serializable_uri_probe_new_raw']
pub fn vslim_serializable_uri_probe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimSerializableUriProbe]()
}
@[export: 'vslim_serializable_uri_probe_free_raw']
pub fn vslim_serializable_uri_probe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    mut obj := unsafe { &VSlimSerializableUriProbe(ptr) }
    vphp.generic_release_fields(mut obj.VSlimPsr7Uri)
    vphp.generic_free_raw[VSlimSerializableUriProbe](ptr)
}
@[export: 'vslim_serializable_uri_probe_cleanup_raw']
pub fn vslim_serializable_uri_probe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_serializable_uri_probe_get_prop']
pub fn vslim_serializable_uri_probe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimSerializableUriProbe(ptr)
        if name == 'label' {
            ret.v[string](obj.label)
            return
        }
        if name == 'scheme' {
            ret.v[string](obj.VSlimPsr7Uri.scheme)
            return
        }
        if name == 'user' {
            ret.v[string](obj.VSlimPsr7Uri.user)
            return
        }
        if name == 'password' {
            ret.v[string](obj.VSlimPsr7Uri.password)
            return
        }
        if name == 'host' {
            ret.v[string](obj.VSlimPsr7Uri.host)
            return
        }
        if name == 'port' {
            ret.v[i64](i64(obj.VSlimPsr7Uri.port))
            return
        }
        if name == 'path' {
            ret.v[string](obj.VSlimPsr7Uri.path)
            return
        }
        if name == 'query' {
            ret.v[string](obj.VSlimPsr7Uri.query)
            return
        }
        if name == 'fragment' {
            ret.v[string](obj.VSlimPsr7Uri.fragment)
            return
        }
    }
}
@[export: 'vslim_serializable_uri_probe_set_prop']
pub fn vslim_serializable_uri_probe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimSerializableUriProbe(ptr)
        if name == 'label' {
            obj.label = arg.get_string()
            return
        }
        if name == 'scheme' {
            obj.VSlimPsr7Uri.scheme = arg.get_string()
            return
        }
        if name == 'user' {
            obj.VSlimPsr7Uri.user = arg.get_string()
            return
        }
        if name == 'password' {
            obj.VSlimPsr7Uri.password = arg.get_string()
            return
        }
        if name == 'host' {
            obj.VSlimPsr7Uri.host = arg.get_string()
            return
        }
        if name == 'port' {
            obj.VSlimPsr7Uri.port = int(arg.get_int())
            return
        }
        if name == 'path' {
            obj.VSlimPsr7Uri.path = arg.get_string()
            return
        }
        if name == 'query' {
            obj.VSlimPsr7Uri.query = arg.get_string()
            return
        }
        if name == 'fragment' {
            obj.VSlimPsr7Uri.fragment = arg.get_string()
            return
        }
    }
}
@[export: 'vslim_serializable_uri_probe_sync_props']
pub fn vslim_serializable_uri_probe_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimSerializableUriProbe(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'label', obj.label)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'scheme', obj.VSlimPsr7Uri.scheme)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'user', obj.VSlimPsr7Uri.user)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'password', obj.VSlimPsr7Uri.password)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'host', obj.VSlimPsr7Uri.host)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'port', obj.VSlimPsr7Uri.port)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'path', obj.VSlimPsr7Uri.path)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'query', obj.VSlimPsr7Uri.query)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'fragment', obj.VSlimPsr7Uri.fragment)
    }
}
@[export: 'vphp_wrap_vslim_serializable_uri_probe_serialize_probe_state']
pub fn vphp_wrap_vslim_serializable_uri_probe_serialize_probe_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSerializableUriProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.serialize_probe_state()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_serializable_uri_probe_unserialize_probe_state']
pub fn vphp_wrap_vslim_serializable_uri_probe_unserialize_probe_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSerializableUriProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    recv.unserialize_probe_state(arg_0)
}
@[export: 'vslim_serializable_uri_probe_handlers']
pub fn vslim_serializable_uri_probe_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vslim_serializable_uri_probe_get_prop,
        write_handler: vslim_serializable_uri_probe_set_prop,
        sync_handler: vslim_serializable_uri_probe_sync_props,
        new_raw: vslim_serializable_uri_probe_new_raw,
        cleanup_raw: vslim_serializable_uri_probe_cleanup_raw,
        free_raw: vslim_serializable_uri_probe_free_raw
    )
}
pub fn VSlimSerializableUriProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__dev__serializableuriprobe_ce)
}

pub fn VSlimSerializableUriProbe.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_serializable_uri_probe_handlers())
}

pub fn VSlimSerializableUriProbe.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimSerializableUriProbe](v_ptr, ownership)
}

pub fn (obj &VSlimSerializableUriProbe) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimSerializableUriProbe](obj)
}

pub fn (obj &VSlimSerializableUriProbe) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimSerializableUriProbe](obj)
}

pub fn (obj &VSlimSerializableUriProbe) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimSerializableUriProbe](obj)
}

pub fn (obj &VSlimSerializableUriProbe) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimSerializableUriProbe](obj)
}

pub fn (val VSlimSerializableUriProbe) php_class_name() string {
    return 'VSlim\\Dev\\SerializableUriProbe'
}

@[export: 'vphp_wrap_vslim_userland_counter_methods_advance']
pub fn vphp_wrap_vslim_userland_counter_methods_advance(ctx vphp.Context)  {
    mut recv := VSlimUserlandCounterMethods{}
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'amount', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := ctx
    arg_1 := php_args.at(0).as_v[int]()
    res := recv.advance(arg_0, arg_1)
    ctx.return().v[int](res)
}

@[export: 'vphp_wrap_vslim_legacy_signature_trait_legacy_signature']
pub fn vphp_wrap_vslim_legacy_signature_trait_legacy_signature(ctx vphp.Context)  {
    mut recv := VSlimLegacySignatureTrait{}
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.legacy_signature()
    ctx.return().v[string](res)
}

