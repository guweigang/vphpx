module main

import vphp
import vphp.object

#include "php_bridge.h"

__global C.abstractreport_ce &C.zend_class_entry
__global C.dailyreport_ce &C.zend_class_entry
__global C.author_ce &C.zend_class_entry
__global C.post_ce &C.zend_class_entry
__global C.article_ce &C.zend_class_entry
__global C.story_ce &C.zend_class_entry
__global C.contentcontract_ce &C.zend_class_entry
__global C.demo__contracts__namedcontract_ce &C.zend_class_entry
__global C.demo__contracts__aliascontract_ce &C.zend_class_entry
__global C.demo__contracts__aliasbase_ce &C.zend_class_entry
__global C.aliasworker_ce &C.zend_class_entry
__global C.runtimedemo__baseexception_ce &C.zend_class_entry
__global C.runtimedemo__childexception_ce &C.zend_class_entry
__global C.callableprocessor_ce &C.zend_class_entry
__global C.finder_ce &C.zend_class_entry
__global C.readonlyrecord_ce &C.zend_class_entry
__global C.vphp__compiler__moduleprobecontract_ce &C.zend_class_entry
__global C.vphp__compiler__moduleprobekind_ce &C.zend_class_entry
__global C.vphp__compiler__otherprobekind_ce &C.zend_class_entry
__global C.vphp__compiler__moduleprobereadonlybox_ce &C.zend_class_entry
__global C.vphp__compiler__moduleprobebox_ce &C.zend_class_entry
__global C.vphp__compiler__copyablebox_ce &C.zend_class_entry
__global C.vphp__compiler__taggedbox_ce &C.zend_class_entry
__global C.vphp__compiler__numberedbox_ce &C.zend_class_entry
__global C.vphp__compiler__moduleprobetypedconsts_ce &C.zend_class_entry
__global C.vphp__compiler__moduleprobewrapperbox_ce &C.zend_class_entry
__global C.traitpost_ce &C.zend_class_entry
__global C.validator_ce &C.zend_class_entry
__global C.dispatchablesample_ce &C.zend_class_entry
__global C.articlestatus_ce &C.zend_class_entry
__global C.vphp__task_ce &C.zend_class_entry
__global C.stringablebox_ce &C.zend_class_entry

@[export: 'abstract_report_new_raw']
pub fn abstract_report_new_raw() voidptr {
    return vphp.generic_new_raw[AbstractReport]()
}
@[export: 'abstract_report_free_raw']
pub fn abstract_report_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[AbstractReport](ptr)
}
@[export: 'abstract_report_cleanup_raw']
pub fn abstract_report_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'abstract_report_get_prop']
pub fn abstract_report_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &AbstractReport(ptr)
        if name == 'title' {
            ret.v[string](obj.title)
            return
        }
    }
}
@[export: 'abstract_report_set_prop']
pub fn abstract_report_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &AbstractReport(ptr)
        if name == 'title' {
            obj.title = arg.get_string()
            return
        }
    }
}
@[export: 'abstract_report_sync_props']
pub fn abstract_report_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &AbstractReport(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'title', obj.title)
    }
}
@[export: 'vphp_wrap_abstract_report_label']
pub fn vphp_wrap_abstract_report_label(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AbstractReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.label()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_abstract_report_summarize']
pub fn vphp_wrap_abstract_report_summarize(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AbstractReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.summarize()
    ctx.return().v[string](res)
}
@[export: 'abstract_report_handlers']
pub fn abstract_report_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: abstract_report_get_prop,
        write_handler: abstract_report_set_prop,
        sync_handler: abstract_report_sync_props,
        new_raw: abstract_report_new_raw,
        cleanup_raw: abstract_report_cleanup_raw,
        free_raw: abstract_report_free_raw
    )
}
pub fn AbstractReport.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.abstractreport_ce)
}

pub fn AbstractReport.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(abstract_report_handlers())
}

pub fn AbstractReport.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[AbstractReport](v_ptr, ownership)
}

pub fn (obj &AbstractReport) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[AbstractReport](obj)
}

pub fn (obj &AbstractReport) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[AbstractReport](obj)
}

pub fn (obj &AbstractReport) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[AbstractReport](obj)
}

pub fn (obj &AbstractReport) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[AbstractReport](obj)
}

pub fn (val AbstractReport) php_class_name() string {
    return 'AbstractReport'
}

@[export: 'daily_report_new_raw']
pub fn daily_report_new_raw() voidptr {
    return vphp.generic_new_raw[DailyReport]()
}
@[export: 'daily_report_free_raw']
pub fn daily_report_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[DailyReport](ptr)
}
@[export: 'daily_report_cleanup_raw']
pub fn daily_report_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'daily_report_get_prop']
pub fn daily_report_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &DailyReport(ptr)
        if name == 'summary' {
            ret.v[string](obj.summary)
            return
        }
    }
}
@[export: 'daily_report_set_prop']
pub fn daily_report_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &DailyReport(ptr)
        if name == 'summary' {
            obj.summary = arg.get_string()
            return
        }
    }
}
@[export: 'daily_report_sync_props']
pub fn daily_report_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &DailyReport(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'summary', obj.summary)
    }
}
@[export: 'vphp_wrap_daily_report_construct']
pub fn vphp_wrap_daily_report_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &DailyReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title' },
        vphp.PhpArgMeta{ index: 1, name: 'summary' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.construct(arg_0, arg_1)
    ctx.return().return_v_object[DailyReport](res, .borrowed)
}
@[export: 'vphp_wrap_daily_report_summarize']
pub fn vphp_wrap_daily_report_summarize(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &DailyReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.summarize()
    ctx.return().v[string](res)
}
@[export: 'daily_report_handlers']
pub fn daily_report_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: daily_report_get_prop,
        write_handler: daily_report_set_prop,
        sync_handler: daily_report_sync_props,
        new_raw: daily_report_new_raw,
        cleanup_raw: daily_report_cleanup_raw,
        free_raw: daily_report_free_raw
    )
}
pub fn DailyReport.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.dailyreport_ce)
}

pub fn DailyReport.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(daily_report_handlers())
}

pub fn DailyReport.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[DailyReport](v_ptr, ownership)
}

pub fn (obj &DailyReport) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[DailyReport](obj)
}

pub fn (obj &DailyReport) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[DailyReport](obj)
}

pub fn (obj &DailyReport) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[DailyReport](obj)
}

pub fn (obj &DailyReport) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[DailyReport](obj)
}

pub fn (val DailyReport) php_class_name() string {
    return 'DailyReport'
}

@[export: 'author_new_raw']
pub fn author_new_raw() voidptr {
    return vphp.generic_new_raw[Author]()
}
@[export: 'author_free_raw']
pub fn author_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Author](ptr)
}
@[export: 'author_cleanup_raw']
pub fn author_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'author_get_prop']
pub fn author_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &Author(ptr)
        if name == 'name' {
            ret.v[string](obj.name)
            return
        }
    }
}
@[export: 'author_set_prop']
pub fn author_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &Author(ptr)
        if name == 'name' {
            obj.name = arg.get_string()
            return
        }
    }
}
@[export: 'author_sync_props']
pub fn author_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Author(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'name', obj.name)
    }
}
@[export: 'vphp_wrap_author_create']
pub fn vphp_wrap_author_create(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := Author.create(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_author_get_name']
pub fn vphp_wrap_author_get_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Author(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_name()
    ctx.return().v[string](res)
}
@[export: 'author_handlers']
pub fn author_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: author_get_prop,
        write_handler: author_set_prop,
        sync_handler: author_sync_props,
        new_raw: author_new_raw,
        cleanup_raw: author_cleanup_raw,
        free_raw: author_free_raw
    )
}
pub fn Author.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.author_ce)
}

pub fn Author.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(author_handlers())
}

pub fn Author.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[Author](v_ptr, ownership)
}

pub fn (obj &Author) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[Author](obj)
}

pub fn (obj &Author) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[Author](obj)
}

pub fn (obj &Author) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[Author](obj)
}

pub fn (obj &Author) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[Author](obj)
}

pub fn (val Author) php_class_name() string {
    return 'Author'
}

@[export: 'post_new_raw']
pub fn post_new_raw() voidptr {
    return vphp.generic_new_raw[Post]()
}
@[export: 'post_free_raw']
pub fn post_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Post](ptr)
}
@[export: 'post_cleanup_raw']
pub fn post_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'post_get_prop']
pub fn post_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &Post(ptr)
        if name == 'post_id' {
            ret.v[i64](i64(obj.post_id))
            return
        }
    }
}
@[export: 'post_set_prop']
pub fn post_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &Post(ptr)
        if name == 'post_id' {
            obj.post_id = int(arg.get_int())
            return
        }
    }
}
@[export: 'post_sync_props']
pub fn post_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Post(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'post_id', obj.post_id)
    }
}
@[export: 'vphp_wrap_post_set_author']
pub fn vphp_wrap_post_set_author(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Post(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'author' },
    ])
    arg_0 := php_args.at(0).bound_v_object[Author]() or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return
    }
    recv.set_author(arg_0)
}
@[export: 'vphp_wrap_post_get_author']
pub fn vphp_wrap_post_get_author(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &Post(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_author()
    return voidptr(res)
}
@[export: 'post_handlers']
pub fn post_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: post_get_prop,
        write_handler: post_set_prop,
        sync_handler: post_sync_props,
        new_raw: post_new_raw,
        cleanup_raw: post_cleanup_raw,
        free_raw: post_free_raw
    )
}
pub fn Post.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.post_ce)
}

pub fn Post.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(post_handlers())
}

pub fn Post.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[Post](v_ptr, ownership)
}

pub fn (obj &Post) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[Post](obj)
}

pub fn (obj &Post) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[Post](obj)
}

pub fn (obj &Post) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[Post](obj)
}

pub fn (obj &Post) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[Post](obj)
}

pub fn (val Post) php_class_name() string {
    return 'Post'
}

@[export: 'article_new_raw']
pub fn article_new_raw() voidptr {
    return vphp.generic_new_raw[Article]()
}
@[export: 'article_free_raw']
pub fn article_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Article](ptr)
}
@[export: 'article_cleanup_raw']
pub fn article_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'article_get_prop']
pub fn article_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &Article(ptr)
        if name == 'created_at' {
            ret.v[i64](i64(obj.created_at))
            return
        }
        if name == 'id' {
            ret.v[i64](i64(obj.id))
            return
        }
        if name == 'title' {
            ret.v[string](obj.title)
            return
        }
        if name == 'is_top' {
            ret.v[bool](obj.is_top)
            return
        }
    }
}
@[export: 'article_set_prop']
pub fn article_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &Article(ptr)
        if name == 'id' {
            obj.id = int(arg.get_int())
            return
        }
        if name == 'title' {
            obj.title = arg.get_string()
            return
        }
        if name == 'is_top' {
            obj.is_top = arg.get_bool()
            return
        }
    }
}
@[export: 'article_sync_props']
pub fn article_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Article(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'created_at', obj.created_at)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'id', obj.id)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'title', obj.title)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'is_top', obj.is_top)
    }
}
pub fn Article.consts() ArticleConsts {
    return article_consts
}
pub fn Article.statics() &ArticleStatics {
    return vphp_article_static_state(vphp.current_static_sync_class(vphp_article_static_state_from_php))
}
fn vphp_article_static_state(raw_ce voidptr) &ArticleStatics {
    key := vphp.static_shadow_state_key("vphp_article_static_state", raw_ce, "Article", "total_count\x00")
    return vphp.request_static_state[ArticleStatics](key, fn () ArticleStatics {
        return article_statics
    })
}
pub fn Article.sync_statics_to_php(ctx vphp.Context) {
    vphp_article_static_state_to_php(ctx.static_sync_class_entry().raw_ptr())
}
fn vphp_article_static_state_to_php(raw_ce voidptr) {
    ce := vphp.ZendClassEntry(vphp.ZendClassEntry.from_ptr(raw_ce))
    if !ce.is_valid() { return }
    s := vphp_article_static_state(raw_ce)
    ce.set_static_prop("total_count", s.total_count)
}
pub fn Article.sync_statics_from_php(ctx vphp.Context) {
    vphp_article_static_state_from_php(ctx.static_sync_class_entry().raw_ptr())
}
fn vphp_article_static_state_from_php(raw_ce voidptr) {
    ce := vphp.ZendClassEntry(vphp.ZendClassEntry.from_ptr(raw_ce))
    if !ce.is_valid() { return }
    mut s := vphp_article_static_state(raw_ce)
    s.total_count = ce.static_prop[int]("total_count")
}
@[export: 'vphp_wrap_article_construct']
pub fn vphp_wrap_article_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title' },
        vphp.PhpArgMeta{ index: 1, name: 'id' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[int]()
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    res := recv.construct(arg_0, arg_1)
    ctx.return().return_v_object[Article](res, .borrowed)
}
@[export: 'vphp_wrap_article_internal_format']
pub fn vphp_wrap_article_internal_format(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    res := recv.internal_format()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_article_create']
pub fn vphp_wrap_article_create(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    res := Article.create(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_article_get_formatted_title']
pub fn vphp_wrap_article_get_formatted_title(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    res := recv.get_formatted_title()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_article_save']
pub fn vphp_wrap_article_save(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    res := recv.save()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_article_dump_properties']
pub fn vphp_wrap_article_dump_properties(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data' },
    ])
    arg_0 := php_args.at(0).zval()
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    recv.dump_properties(arg_0)
}
@[export: 'vphp_wrap_article_process_with_callback']
pub fn vphp_wrap_article_process_with_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    res := recv.process_with_callback(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_article_restore_author']
pub fn vphp_wrap_article_restore_author(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'authorVal' },
    ])
    arg_0 := php_args.at(0).zval()
    mut vphp_static_sync := vphp.begin_static_sync(ctx, vphp_article_static_state_from_php, vphp_article_static_state_to_php)
    defer { vphp_static_sync.close() }
    res := Article.restore_author(arg_0)
    return voidptr(res)
}
@[export: 'article_handlers']
pub fn article_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: article_get_prop,
        write_handler: article_set_prop,
        sync_handler: article_sync_props,
        new_raw: article_new_raw,
        cleanup_raw: article_cleanup_raw,
        free_raw: article_free_raw
    )
}
pub fn Article.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.article_ce)
}

pub fn Article.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(article_handlers())
}

pub fn Article.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[Article](v_ptr, ownership)
}

pub fn (obj &Article) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[Article](obj)
}

pub fn (obj &Article) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[Article](obj)
}

pub fn (obj &Article) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[Article](obj)
}

pub fn (obj &Article) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[Article](obj)
}

pub fn (val Article) php_class_name() string {
    return 'Article'
}

@[export: 'story_new_raw']
pub fn story_new_raw() voidptr {
    return vphp.generic_new_raw[Story]()
}
@[export: 'story_free_raw']
pub fn story_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Story](ptr)
}
@[export: 'story_cleanup_raw']
pub fn story_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'story_get_prop']
pub fn story_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &Story(ptr)
        if name == 'chapter_count' {
            ret.v[i64](i64(obj.chapter_count))
            return
        }
    }
}
@[export: 'story_set_prop']
pub fn story_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &Story(ptr)
        if name == 'chapter_count' {
            obj.chapter_count = int(arg.get_int())
            return
        }
    }
}
@[export: 'story_sync_props']
pub fn story_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Story(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'chapter_count', obj.chapter_count)
    }
}
@[export: 'vphp_wrap_story_create']
pub fn vphp_wrap_story_create(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'author' },
        vphp.PhpArgMeta{ index: 1, name: 'chapters' },
    ])
    arg_0 := php_args.at(0).bound_v_object[Author]() or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return unsafe { nil }
    }
    arg_1 := php_args.at(1).as_v[int]()
    res := Story.create(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_story_tell']
pub fn vphp_wrap_story_tell(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Story(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.tell()
    ctx.return().v[string](res)
}
@[export: 'story_handlers']
pub fn story_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: story_get_prop,
        write_handler: story_set_prop,
        sync_handler: story_sync_props,
        new_raw: story_new_raw,
        cleanup_raw: story_cleanup_raw,
        free_raw: story_free_raw
    )
}
pub fn Story.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.story_ce)
}

pub fn Story.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(story_handlers())
}

pub fn Story.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[Story](v_ptr, ownership)
}

pub fn (obj &Story) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[Story](obj)
}

pub fn (obj &Story) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[Story](obj)
}

pub fn (obj &Story) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[Story](obj)
}

pub fn (obj &Story) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[Story](obj)
}

pub fn (val Story) php_class_name() string {
    return 'Story'
}

@[export: 'alias_base_new_raw']
pub fn alias_base_new_raw() voidptr {
    return vphp.generic_new_raw[AliasBase]()
}
@[export: 'alias_base_free_raw']
pub fn alias_base_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[AliasBase](ptr)
}
@[export: 'alias_base_cleanup_raw']
pub fn alias_base_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'alias_base_get_prop']
pub fn alias_base_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &AliasBase(ptr)
        if name == 'label' {
            ret.v[string](obj.label)
            return
        }
    }
}
@[export: 'alias_base_set_prop']
pub fn alias_base_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &AliasBase(ptr)
        if name == 'label' {
            obj.label = arg.get_string()
            return
        }
    }
}
@[export: 'alias_base_sync_props']
pub fn alias_base_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &AliasBase(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'label', obj.label)
    }
}
@[export: 'vphp_wrap_alias_base_construct']
pub fn vphp_wrap_alias_base_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasBase(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'label' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.construct(arg_0)
    ctx.return().return_v_object[AliasBase](res, .borrowed)
}
@[export: 'alias_base_handlers']
pub fn alias_base_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: alias_base_get_prop,
        write_handler: alias_base_set_prop,
        sync_handler: alias_base_sync_props,
        new_raw: alias_base_new_raw,
        cleanup_raw: alias_base_cleanup_raw,
        free_raw: alias_base_free_raw
    )
}
pub fn AliasBase.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.demo__contracts__aliasbase_ce)
}

pub fn AliasBase.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(alias_base_handlers())
}

pub fn AliasBase.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[AliasBase](v_ptr, ownership)
}

pub fn (obj &AliasBase) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[AliasBase](obj)
}

pub fn (obj &AliasBase) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[AliasBase](obj)
}

pub fn (obj &AliasBase) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[AliasBase](obj)
}

pub fn (obj &AliasBase) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[AliasBase](obj)
}

pub fn (val AliasBase) php_class_name() string {
    return 'Demo\\Contracts\\AliasBase'
}

@[export: 'alias_worker_new_raw']
pub fn alias_worker_new_raw() voidptr {
    return vphp.generic_new_raw[AliasWorker]()
}
@[export: 'alias_worker_free_raw']
pub fn alias_worker_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[AliasWorker](ptr)
}
@[export: 'alias_worker_cleanup_raw']
pub fn alias_worker_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'alias_worker_get_prop']
pub fn alias_worker_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &AliasWorker(ptr)
        if name == 'title' {
            ret.v[string](obj.title)
            return
        }
    }
}
@[export: 'alias_worker_set_prop']
pub fn alias_worker_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &AliasWorker(ptr)
        if name == 'title' {
            obj.title = arg.get_string()
            return
        }
    }
}
@[export: 'alias_worker_sync_props']
pub fn alias_worker_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &AliasWorker(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'title', obj.title)
    }
}
@[export: 'vphp_wrap_alias_worker_construct']
pub fn vphp_wrap_alias_worker_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'label' },
        vphp.PhpArgMeta{ index: 1, name: 'title' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.construct(arg_0, arg_1)
    ctx.return().return_v_object[AliasWorker](res, .borrowed)
}
@[export: 'vphp_wrap_alias_worker_save']
pub fn vphp_wrap_alias_worker_save(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.save()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_alias_worker_get_formatted_title']
pub fn vphp_wrap_alias_worker_get_formatted_title(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_formatted_title()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_alias_worker_ping']
pub fn vphp_wrap_alias_worker_ping(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ping()
    ctx.return().v[string](res)
}
@[export: 'alias_worker_handlers']
pub fn alias_worker_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: alias_worker_get_prop,
        write_handler: alias_worker_set_prop,
        sync_handler: alias_worker_sync_props,
        new_raw: alias_worker_new_raw,
        cleanup_raw: alias_worker_cleanup_raw,
        free_raw: alias_worker_free_raw
    )
}
pub fn AliasWorker.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.aliasworker_ce)
}

pub fn AliasWorker.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(alias_worker_handlers())
}

pub fn AliasWorker.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[AliasWorker](v_ptr, ownership)
}

pub fn (obj &AliasWorker) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[AliasWorker](obj)
}

pub fn (obj &AliasWorker) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[AliasWorker](obj)
}

pub fn (obj &AliasWorker) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[AliasWorker](obj)
}

pub fn (obj &AliasWorker) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[AliasWorker](obj)
}

pub fn (val AliasWorker) php_class_name() string {
    return 'AliasWorker'
}

@[export: 'runtime_demo_base_exception_new_raw']
pub fn runtime_demo_base_exception_new_raw() voidptr {
    return vphp.generic_new_raw[RuntimeDemoBaseException]()
}
@[export: 'runtime_demo_base_exception_free_raw']
pub fn runtime_demo_base_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[RuntimeDemoBaseException](ptr)
}
@[export: 'runtime_demo_base_exception_cleanup_raw']
pub fn runtime_demo_base_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
pub fn runtime_demo_base_exception_load_from_php(php_obj vphp.ZendObject) RuntimeDemoBaseException {
    return RuntimeDemoBaseException{
    }
}
pub fn runtime_demo_base_exception_snapshot(recv RuntimeDemoBaseException) RuntimeDemoBaseException {
    return recv
}
pub fn runtime_demo_base_exception_sync_to_php(php_obj vphp.ZendObject, original RuntimeDemoBaseException, recv RuntimeDemoBaseException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'runtime_demo_base_exception_get_prop']
pub fn runtime_demo_base_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'runtime_demo_base_exception_set_prop']
pub fn runtime_demo_base_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'runtime_demo_base_exception_sync_props']
pub fn runtime_demo_base_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'runtime_demo_base_exception_handlers']
pub fn runtime_demo_base_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: runtime_demo_base_exception_get_prop,
        write_handler: runtime_demo_base_exception_set_prop,
        sync_handler: runtime_demo_base_exception_sync_props,
        new_raw: runtime_demo_base_exception_new_raw,
        cleanup_raw: runtime_demo_base_exception_cleanup_raw,
        free_raw: runtime_demo_base_exception_free_raw
    )
}
pub fn RuntimeDemoBaseException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.runtimedemo__baseexception_ce)
}

pub fn RuntimeDemoBaseException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(runtime_demo_base_exception_handlers())
}

pub fn RuntimeDemoBaseException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[RuntimeDemoBaseException](v_ptr, ownership)
}

pub fn (obj &RuntimeDemoBaseException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[RuntimeDemoBaseException](obj)
}

pub fn (obj &RuntimeDemoBaseException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[RuntimeDemoBaseException](obj)
}

pub fn (obj &RuntimeDemoBaseException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[RuntimeDemoBaseException](obj)
}

pub fn (obj &RuntimeDemoBaseException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[RuntimeDemoBaseException](obj)
}

pub fn (val RuntimeDemoBaseException) php_class_name() string {
    return 'RuntimeDemo\\BaseException'
}

@[export: 'runtime_demo_child_exception_new_raw']
pub fn runtime_demo_child_exception_new_raw() voidptr {
    return vphp.generic_new_raw[RuntimeDemoChildException]()
}
@[export: 'runtime_demo_child_exception_free_raw']
pub fn runtime_demo_child_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[RuntimeDemoChildException](ptr)
}
@[export: 'runtime_demo_child_exception_cleanup_raw']
pub fn runtime_demo_child_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
pub fn runtime_demo_child_exception_load_from_php(php_obj vphp.ZendObject) RuntimeDemoChildException {
    return RuntimeDemoChildException{
    }
}
pub fn runtime_demo_child_exception_snapshot(recv RuntimeDemoChildException) RuntimeDemoChildException {
    return recv
}
pub fn runtime_demo_child_exception_sync_to_php(php_obj vphp.ZendObject, original RuntimeDemoChildException, recv RuntimeDemoChildException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'runtime_demo_child_exception_get_prop']
pub fn runtime_demo_child_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'runtime_demo_child_exception_set_prop']
pub fn runtime_demo_child_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'runtime_demo_child_exception_sync_props']
pub fn runtime_demo_child_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'runtime_demo_child_exception_handlers']
pub fn runtime_demo_child_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: runtime_demo_child_exception_get_prop,
        write_handler: runtime_demo_child_exception_set_prop,
        sync_handler: runtime_demo_child_exception_sync_props,
        new_raw: runtime_demo_child_exception_new_raw,
        cleanup_raw: runtime_demo_child_exception_cleanup_raw,
        free_raw: runtime_demo_child_exception_free_raw
    )
}
pub fn RuntimeDemoChildException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.runtimedemo__childexception_ce)
}

pub fn RuntimeDemoChildException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(runtime_demo_child_exception_handlers())
}

pub fn RuntimeDemoChildException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[RuntimeDemoChildException](v_ptr, ownership)
}

pub fn (obj &RuntimeDemoChildException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[RuntimeDemoChildException](obj)
}

pub fn (obj &RuntimeDemoChildException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[RuntimeDemoChildException](obj)
}

pub fn (obj &RuntimeDemoChildException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[RuntimeDemoChildException](obj)
}

pub fn (obj &RuntimeDemoChildException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[RuntimeDemoChildException](obj)
}

pub fn (val RuntimeDemoChildException) php_class_name() string {
    return 'RuntimeDemo\\ChildException'
}

@[export: 'callable_processor_new_raw']
pub fn callable_processor_new_raw() voidptr {
    return vphp.generic_new_raw[CallableProcessor]()
}
@[export: 'callable_processor_free_raw']
pub fn callable_processor_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[CallableProcessor](ptr)
}
@[export: 'callable_processor_cleanup_raw']
pub fn callable_processor_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'callable_processor_get_prop']
pub fn callable_processor_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &CallableProcessor(ptr)
        if name == 'prefix' {
            ret.v[string](obj.prefix)
            return
        }
    }
}
@[export: 'callable_processor_set_prop']
pub fn callable_processor_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &CallableProcessor(ptr)
        if name == 'prefix' {
            obj.prefix = arg.get_string()
            return
        }
    }
}
@[export: 'callable_processor_sync_props']
pub fn callable_processor_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &CallableProcessor(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'prefix', obj.prefix)
    }
}
@[export: 'vphp_wrap_callable_processor_construct']
pub fn vphp_wrap_callable_processor_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    recv.construct(arg_0)
}
@[export: 'vphp_wrap_callable_processor_process']
pub fn vphp_wrap_callable_processor_process(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    res := recv.process(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_callable_processor_transform']
pub fn vphp_wrap_callable_processor_transform(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
        vphp.PhpArgMeta{ index: 1, name: 'input' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[string]()
    res := recv.transform(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_callable_processor_apply']
pub fn vphp_wrap_callable_processor_apply(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
        vphp.PhpArgMeta{ index: 1, name: 'data' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[string]()
    res := CallableProcessor.apply(arg_0, arg_1)
    ctx.return().v[string](res)
}
__global C.struct_closure_arginfo_callableprocessor_struct_closure voidptr

pub type VPhpStructClosureCallableProcessorStructClosure = fn (StructClosureArgs) string

fn vphp_struct_closure_bridge_callableprocessor_struct_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureCallableProcessorStructClosure(v_ptr))
        arg_count := ctx.num_args()
        if arg_count < 2 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least 2 arguments', 0)
            return
        }
        field_0 := ctx.closure_arg_to_v[string](0) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (name): ${err.msg()}', 0) }
            return
        }
        field_1 := ctx.closure_arg_to_v[int](1) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (count): ${err.msg()}', 0) }
            return
        }
        args := StructClosureArgs{
            name: field_0
            count: field_1
        }
        ctx.forward_struct_closure[StructClosureArgs, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_callableprocessor_struct_closure(ctx vphp.Context, cb VPhpStructClosureCallableProcessorStructClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureCallableProcessorStructClosure](cb, vphp_struct_closure_bridge_callableprocessor_struct_closure, 2, 2, C.struct_closure_arginfo_callableprocessor_struct_closure)
}

@[export: 'vphp_wrap_callable_processor_struct_closure']
pub fn vphp_wrap_callable_processor_struct_closure(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := CallableProcessor.struct_closure()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_struct_closure_callableprocessor_struct_closure(ctx, res)
}
@[export: 'vphp_wrap_callable_processor_computed_params']
pub fn vphp_wrap_callable_processor_computed_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'sequence' },
        vphp.PhpArgMeta{ index: 1, name: 'label' },
        vphp.PhpArgMeta{ index: 2, name: 'enabled' },
    ])
    arg_0_params_sequence := if php_args.has(0) {
        php_args.at(0).as_v[int]()
    } else {
        defaults := VPhpComputedParamsDemo{
            label: none
        }
        if vphp.has_exception() {
            return
        }
        defaults.sequence
    }
    arg_0_params_label := if php_args.has(1) {
        php_args.at(1).as_v_opt[string]()
    } else {
        defaults := VPhpComputedParamsDemo{
            sequence: int(0)
        }
        if vphp.has_exception() {
            return
        }
        defaults.label
    }
    arg_0_params_enabled := if php_args.has(2) { php_args.at(2).as_v[bool]() } else { true }
    arg_0_params := VPhpComputedParamsDemo{
        sequence: arg_0_params_sequence
        label: arg_0_params_label
        enabled: arg_0_params_enabled
    }
    res := recv.computed_params(arg_0_params)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_callable_processor_literal_params']
pub fn vphp_wrap_callable_processor_literal_params(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message' },
        vphp.PhpArgMeta{ index: 1, name: 'raw' },
        vphp.PhpArgMeta{ index: 2, name: 'octal' },
        vphp.PhpArgMeta{ index: 3, name: 'binary' },
        vphp.PhpArgMeta{ index: 4, name: 'floating' },
        vphp.PhpArgMeta{ index: 5, name: 'single' },
        vphp.PhpArgMeta{ index: 6, name: 'option' },
        vphp.PhpArgMeta{ index: 7, name: 'nullable' },
        vphp.PhpArgMeta{ index: 8, name: 'items' },
        vphp.PhpArgMeta{ index: 9, name: 'empty' },
        vphp.PhpArgMeta{ index: 10, name: 'lookup' },
        vphp.PhpArgMeta{ index: 11, name: 'tail' },
    ])
    arg_0_params_message := if php_args.has(0) { php_args.at(0).as_v[string]() } else { 'a\n\t\x00\xe2\x98\xba\$\'\\"' }
    arg_0_params_raw := if php_args.has(1) { php_args.at(1).as_v[string]() } else { '\\n\${literal}' }
    arg_0_params_octal := if php_args.has(2) { php_args.at(2).as_v[int]() } else { -15 }
    arg_0_params_binary := if php_args.has(3) { php_args.at(3).as_v[i64]() } else { i64(161) }
    arg_0_params_floating := if php_args.has(4) { php_args.at(4).as_v[f64]() } else { 2.0 }
    arg_0_params_single := if php_args.has(5) { php_args.at(5).as_v[f32]() } else { f32(0.1) }
    arg_0_params_option := if php_args.has(6) { php_args.at(6).as_v_opt[string]() } else { ?string('present') }
    arg_0_params_nullable := if php_args.has(7) { php_args.at(7).as_v_opt[int]() } else { none }
    arg_0_params_items := if php_args.has(8) { php_args.at(8).as_v[[]int]() } else { [1, 16] }
    arg_0_params_empty := if php_args.has(9) { php_args.at(9).as_v[[]string]() } else { []string{} }
    arg_0_params_lookup := if php_args.has(10) { php_args.at(10).as_v[map[string]int]() } else { {'count': 16} }
    arg_0_params_tail := if php_args.has(11) { php_args.at(11).as_v[bool]() } else { true }
    arg_0_params := VPhpLiteralParamsDemo{
        message: arg_0_params_message
        raw: arg_0_params_raw
        octal: arg_0_params_octal
        binary: arg_0_params_binary
        floating: arg_0_params_floating
        single: arg_0_params_single
        option: arg_0_params_option
        nullable: arg_0_params_nullable
        items: arg_0_params_items
        empty: arg_0_params_empty
        lookup: arg_0_params_lookup
        tail: arg_0_params_tail
    }
    res := CallableProcessor.literal_params(arg_0_params)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_callable_processor_overridden_params']
pub fn vphp_wrap_callable_processor_overridden_params(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'option', use_php_default: true },
        vphp.PhpArgMeta{ index: 1, name: 'spacer' },
        vphp.PhpArgMeta{ index: 2, name: 'count', use_php_default: true },
        vphp.PhpArgMeta{ index: 3, name: 'nullable', use_php_default: true },
        vphp.PhpArgMeta{ index: 4, name: 'items', use_php_default: true },
        vphp.PhpArgMeta{ index: 5, name: 'tail' },
    ]) or {
        return
    }
    arg_0 := ctx
    arg_1_params_option := php_args.at(0).as_v_opt[string]()
    arg_1_params_spacer := if php_args.has(1) { php_args.at(1).as_v[string]() } else { 'native spacer' }
    arg_1_params_count := php_args.at(2).as_v[int]()
    arg_1_params_nullable := php_args.at(3).as_v_opt[string]()
    arg_1_params_items := php_args.at(4).array() or {
        vphp.throw_exception('argument 4 must be array', 0)
        return
    }
    arg_1_params_tail := if php_args.has(5) { php_args.at(5).as_v[bool]() } else { true }
    arg_1_params := VPhpOverriddenParamsDemo{
        option: arg_1_params_option
        spacer: arg_1_params_spacer
        count: arg_1_params_count
        nullable: arg_1_params_nullable
        items: arg_1_params_items
        tail: arg_1_params_tail
    }
    res := recv.overridden_params(arg_0, arg_1_params)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_callable_processor_direct_defaults']
pub fn vphp_wrap_callable_processor_direct_defaults(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
        vphp.PhpArgMeta{ index: 1, name: 'count', use_php_default: true },
        vphp.PhpArgMeta{ index: 2, name: 'values', use_php_default: true },
        vphp.PhpArgMeta{ index: 3, name: 'label', use_php_default: true },
        vphp.PhpArgMeta{ index: 4, name: 'enabled', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := ctx
    arg_1 := php_args.at(0).as_v[string]()
    arg_2 := php_args.at(1).as_v[int]()
    arg_3 := php_args.at(2).array()
    arg_4 := php_args.at(3).as_v_opt[string]()
    arg_5 := php_args.at(4).as_v[bool]()
    res := CallableProcessor.direct_defaults(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
    ctx.return().v[string](res)
}
@[export: 'callable_processor_handlers']
pub fn callable_processor_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: callable_processor_get_prop,
        write_handler: callable_processor_set_prop,
        sync_handler: callable_processor_sync_props,
        new_raw: callable_processor_new_raw,
        cleanup_raw: callable_processor_cleanup_raw,
        free_raw: callable_processor_free_raw
    )
}
pub fn CallableProcessor.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.callableprocessor_ce)
}

pub fn CallableProcessor.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(callable_processor_handlers())
}

pub fn CallableProcessor.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[CallableProcessor](v_ptr, ownership)
}

pub fn (obj &CallableProcessor) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[CallableProcessor](obj)
}

pub fn (obj &CallableProcessor) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[CallableProcessor](obj)
}

pub fn (obj &CallableProcessor) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[CallableProcessor](obj)
}

pub fn (obj &CallableProcessor) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[CallableProcessor](obj)
}

pub fn (val CallableProcessor) php_class_name() string {
    return 'CallableProcessor'
}

@[export: 'finder_new_raw']
pub fn finder_new_raw() voidptr {
    return vphp.generic_new_raw[Finder]()
}
@[export: 'finder_free_raw']
pub fn finder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Finder](ptr)
}
@[export: 'finder_cleanup_raw']
pub fn finder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'finder_get_prop']
pub fn finder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'finder_set_prop']
pub fn finder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'finder_sync_props']
pub fn finder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_finder_construct']
pub fn vphp_wrap_finder_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    recv.construct(arg_0)
}
@[export: 'vphp_wrap_finder_find']
pub fn vphp_wrap_finder_find(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keyword' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_option[string](fn [arg_0, recv] () ?string {
        return recv.find(arg_0)
    })
}
@[export: 'vphp_wrap_finder_index_of']
pub fn vphp_wrap_finder_index_of(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keyword' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_option[int](fn [arg_0, recv] () ?int {
        return recv.index_of(arg_0)
    })
}
@[export: 'vphp_wrap_finder_has_match']
pub fn vphp_wrap_finder_has_match(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keyword' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_option[bool](fn [arg_0, recv] () ?bool {
        return recv.has_match(arg_0)
    })
}
@[export: 'vphp_wrap_finder_try_parse_int']
pub fn vphp_wrap_finder_try_parse_int(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 's' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_option[int](fn [arg_0] () ?int {
        return Finder.try_parse_int(arg_0)
    })
}
@[export: 'finder_handlers']
pub fn finder_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: finder_get_prop,
        write_handler: finder_set_prop,
        sync_handler: finder_sync_props,
        new_raw: finder_new_raw,
        cleanup_raw: finder_cleanup_raw,
        free_raw: finder_free_raw
    )
}
pub fn Finder.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.finder_ce)
}

pub fn Finder.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(finder_handlers())
}

pub fn Finder.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[Finder](v_ptr, ownership)
}

pub fn (obj &Finder) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[Finder](obj)
}

pub fn (obj &Finder) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[Finder](obj)
}

pub fn (obj &Finder) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[Finder](obj)
}

pub fn (obj &Finder) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[Finder](obj)
}

pub fn (val Finder) php_class_name() string {
    return 'Finder'
}

@[export: 'readonly_record_new_raw']
pub fn readonly_record_new_raw() voidptr {
    return vphp.generic_new_raw[ReadonlyRecord]()
}
@[export: 'readonly_record_free_raw']
pub fn readonly_record_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[ReadonlyRecord](ptr)
}
@[export: 'readonly_record_cleanup_raw']
pub fn readonly_record_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'readonly_record_get_prop']
pub fn readonly_record_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &ReadonlyRecord(ptr)
        if name == 'created_at' {
            ret.v[i64](i64(obj.created_at))
            return
        }
        if name == 'title' {
            ret.v[string](obj.title)
            return
        }
    }
}
@[export: 'readonly_record_set_prop']
pub fn readonly_record_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &ReadonlyRecord(ptr)
        if name == 'title' {
            obj.title = arg.get_string()
            return
        }
    }
}
@[export: 'readonly_record_sync_props']
pub fn readonly_record_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &ReadonlyRecord(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'created_at', obj.created_at)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'title', obj.title)
    }
}
@[export: 'vphp_wrap_readonly_record_construct']
pub fn vphp_wrap_readonly_record_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &ReadonlyRecord(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.construct(arg_0)
    ctx.return().return_v_object[ReadonlyRecord](res, .borrowed)
}
@[export: 'vphp_wrap_readonly_record_reveal']
pub fn vphp_wrap_readonly_record_reveal(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &ReadonlyRecord(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.reveal()
    ctx.return().v[string](res)
}
@[export: 'readonly_record_handlers']
pub fn readonly_record_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: readonly_record_get_prop,
        write_handler: readonly_record_set_prop,
        sync_handler: readonly_record_sync_props,
        new_raw: readonly_record_new_raw,
        cleanup_raw: readonly_record_cleanup_raw,
        free_raw: readonly_record_free_raw
    )
}
pub fn ReadonlyRecord.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.readonlyrecord_ce)
}

pub fn ReadonlyRecord.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(readonly_record_handlers())
}

pub fn ReadonlyRecord.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[ReadonlyRecord](v_ptr, ownership)
}

pub fn (obj &ReadonlyRecord) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[ReadonlyRecord](obj)
}

pub fn (obj &ReadonlyRecord) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[ReadonlyRecord](obj)
}

pub fn (obj &ReadonlyRecord) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[ReadonlyRecord](obj)
}

pub fn (obj &ReadonlyRecord) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[ReadonlyRecord](obj)
}

pub fn (val ReadonlyRecord) php_class_name() string {
    return 'ReadonlyRecord'
}

@[export: 'vphp_enum_backing_values_vphp__compiler__moduleprobekind']
fn vphp_enum_backing_values_vphp__compiler__moduleprobekind(values &i64) {
    unsafe {
        values[0] = i64(VphpModuleProbeKind.alpha)
        values[1] = i64(VphpModuleProbeKind.beta)
    }
}
pub fn (val VphpModuleProbeKind) php_class_name() string {
    return 'VPHP\\Compiler\\ModuleProbeKind'
}

@[export: 'vphp_enum_backing_values_vphp__compiler__otherprobekind']
fn vphp_enum_backing_values_vphp__compiler__otherprobekind(values &i64) {
    unsafe {
        values[0] = i64(VphpOtherProbeKind.other)
    }
}
pub fn (val VphpOtherProbeKind) php_class_name() string {
    return 'VPHP\\Compiler\\OtherProbeKind'
}

@[export: 'vphp_module_probe_read_only_box_new_raw']
pub fn vphp_module_probe_read_only_box_new_raw() voidptr {
    return vphp.generic_new_raw[VphpModuleProbeReadOnlyBox]()
}
@[export: 'vphp_module_probe_read_only_box_free_raw']
pub fn vphp_module_probe_read_only_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VphpModuleProbeReadOnlyBox](ptr)
}
@[export: 'vphp_module_probe_read_only_box_cleanup_raw']
pub fn vphp_module_probe_read_only_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vphp_module_probe_read_only_box_get_prop']
pub fn vphp_module_probe_read_only_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VphpModuleProbeReadOnlyBox(ptr)
        if name == 'title' {
            ret.v[string](obj.title)
            return
        }
        if name == 'value' {
            ret.v[i64](i64(obj.value))
            return
        }
    }
}
@[export: 'vphp_module_probe_read_only_box_set_prop']
pub fn vphp_module_probe_read_only_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vphp_module_probe_read_only_box_sync_props']
pub fn vphp_module_probe_read_only_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VphpModuleProbeReadOnlyBox(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'title', obj.title)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'value', obj.value)
    }
}
@[export: 'vphp_module_probe_read_only_box_handlers']
pub fn vphp_module_probe_read_only_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vphp_module_probe_read_only_box_get_prop,
        write_handler: vphp_module_probe_read_only_box_set_prop,
        sync_handler: vphp_module_probe_read_only_box_sync_props,
        new_raw: vphp_module_probe_read_only_box_new_raw,
        cleanup_raw: vphp_module_probe_read_only_box_cleanup_raw,
        free_raw: vphp_module_probe_read_only_box_free_raw
    )
}
pub fn VphpModuleProbeReadOnlyBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__compiler__moduleprobereadonlybox_ce)
}

pub fn VphpModuleProbeReadOnlyBox.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vphp_module_probe_read_only_box_handlers())
}

pub fn VphpModuleProbeReadOnlyBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VphpModuleProbeReadOnlyBox](v_ptr, ownership)
}

pub fn (obj &VphpModuleProbeReadOnlyBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VphpModuleProbeReadOnlyBox](obj)
}

pub fn (obj &VphpModuleProbeReadOnlyBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VphpModuleProbeReadOnlyBox](obj)
}

pub fn (obj &VphpModuleProbeReadOnlyBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VphpModuleProbeReadOnlyBox](obj)
}

pub fn (obj &VphpModuleProbeReadOnlyBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VphpModuleProbeReadOnlyBox](obj)
}

pub fn (val VphpModuleProbeReadOnlyBox) php_class_name() string {
    return 'VPHP\\Compiler\\ModuleProbeReadOnlyBox'
}

@[export: 'vphp_module_probe_box_new_raw']
pub fn vphp_module_probe_box_new_raw() voidptr {
    return vphp.generic_new_raw[VphpModuleProbeBox]()
}
@[export: 'vphp_module_probe_box_free_raw']
pub fn vphp_module_probe_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VphpModuleProbeBox](ptr)
}
@[export: 'vphp_module_probe_box_cleanup_raw']
pub fn vphp_module_probe_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vphp_module_probe_box_get_prop']
pub fn vphp_module_probe_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VphpModuleProbeBox(ptr)
        if name == 'name' {
            ret.v[string](obj.name)
            return
        }
        if name == 'count' {
            ret.v[i64](i64(obj.count))
            return
        }
    }
}
@[export: 'vphp_module_probe_box_set_prop']
pub fn vphp_module_probe_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VphpModuleProbeBox(ptr)
        if name == 'name' {
            obj.name = arg.get_string()
            return
        }
        if name == 'count' {
            obj.count = int(arg.get_int())
            return
        }
    }
}
@[export: 'vphp_module_probe_box_sync_props']
pub fn vphp_module_probe_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VphpModuleProbeBox(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'name', obj.name)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'count', obj.count)
    }
}
@[export: 'vphp_wrap_vphp_module_probe_box_test_sumtype']
pub fn vphp_wrap_vphp_module_probe_box_test_sumtype(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'val' },
    ])
    arg_0 := php_args.at(0).as_v[VphpModuleProbeSum]()
    res := recv.test_sumtype(arg_0)
    ctx.return().v[VphpModuleProbeSum](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_test_enum_echo']
pub fn vphp_wrap_vphp_module_probe_box_test_enum_echo(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'kind' },
    ])
    arg_0 := php_args.at(0).as_v[VphpModuleProbeKind]()
    res := recv.test_enum_echo(arg_0)
    ctx.return().v[VphpModuleProbeKind](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_test_sumtype_echo']
pub fn vphp_wrap_vphp_module_probe_box_test_sumtype_echo(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'val' },
    ])
    arg_0 := php_args.at(0).as_v[VphpModuleProbeSumType]()
    res := recv.test_sumtype_echo(arg_0)
    ctx.return().v[VphpModuleProbeSumType](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_test_variadic']
pub fn vphp_wrap_vphp_module_probe_box_test_variadic(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    if !ctx.reject_named_variadic_args() {
        return
    }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'sep' },
        vphp.PhpArgMeta{ index: 1, name: 'args' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.as_variadic_v[string](1)
    res := recv.test_variadic(arg_0, ...arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_test_struct_param']
pub fn vphp_wrap_vphp_module_probe_box_test_struct_param(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'box' },
    ])
    arg_0 := php_args.at(0).bound_v_object[VphpModuleProbeReadOnlyBox]() or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return
    }
    res := recv.test_struct_param(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_label']
pub fn vphp_wrap_vphp_module_probe_box_label(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.label()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_compound_identity']
pub fn vphp_wrap_vphp_module_probe_box_compound_identity(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).value
    res := recv.compound_identity(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_step_reference']
pub fn vphp_wrap_vphp_module_probe_box_step_reference(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'cursor' },
    ])
    arg_0 := ctx
    arg_1 := php_args.at(0).reference() or {
        vphp.throw_exception('argument 0 must be reference', 0)
        return
    }
    res := recv.step_reference(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vphp_module_probe_box_static_label']
pub fn vphp_wrap_vphp_module_probe_box_static_label(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VphpModuleProbeBox.static_label()
    ctx.return().v[string](res)
}
@[export: 'vphp_module_probe_box_handlers']
pub fn vphp_module_probe_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vphp_module_probe_box_get_prop,
        write_handler: vphp_module_probe_box_set_prop,
        sync_handler: vphp_module_probe_box_sync_props,
        new_raw: vphp_module_probe_box_new_raw,
        cleanup_raw: vphp_module_probe_box_cleanup_raw,
        free_raw: vphp_module_probe_box_free_raw
    )
}
pub fn VphpModuleProbeBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__compiler__moduleprobebox_ce)
}

pub fn VphpModuleProbeBox.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vphp_module_probe_box_handlers())
}

pub fn VphpModuleProbeBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VphpModuleProbeBox](v_ptr, ownership)
}

pub fn (obj &VphpModuleProbeBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VphpModuleProbeBox](obj)
}

pub fn (obj &VphpModuleProbeBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VphpModuleProbeBox](obj)
}

pub fn (obj &VphpModuleProbeBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VphpModuleProbeBox](obj)
}

pub fn (obj &VphpModuleProbeBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VphpModuleProbeBox](obj)
}

pub fn (val VphpModuleProbeBox) php_class_name() string {
    return 'VPHP\\Compiler\\ModuleProbeBox'
}

@[export: 'vphp_copyable_box_new_raw']
pub fn vphp_copyable_box_new_raw() voidptr {
    return vphp.generic_new_raw[VphpCopyableBox]()
}
@[export: 'vphp_copyable_box_free_raw']
pub fn vphp_copyable_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VphpCopyableBox](ptr)
}
@[export: 'vphp_copyable_box_cleanup_raw']
pub fn vphp_copyable_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vphp_copyable_box_clone_into_raw']
pub fn vphp_copyable_box_clone_into_raw(source voidptr, target voidptr) {
    unsafe {
        src := &VphpCopyableBox(source)
        mut dst := &VphpCopyableBox(target)
        src.clone_into(mut dst)
    }
}
@[export: 'vphp_copyable_box_get_prop']
pub fn vphp_copyable_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VphpCopyableBox(ptr)
        if name == 'count' {
            ret.v[i64](i64(obj.count))
            return
        }
    }
}
@[export: 'vphp_copyable_box_set_prop']
pub fn vphp_copyable_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VphpCopyableBox(ptr)
        if name == 'count' {
            obj.count = int(arg.get_int())
            return
        }
    }
}
@[export: 'vphp_copyable_box_sync_props']
pub fn vphp_copyable_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VphpCopyableBox(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'count', obj.count)
    }
}
@[export: 'vphp_wrap_vphp_copyable_box_hold']
pub fn vphp_wrap_vphp_copyable_box_hold(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpCopyableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).value
    recv.hold(arg_0)
}
@[export: 'vphp_wrap_vphp_copyable_box_clone_initialized']
pub fn vphp_wrap_vphp_copyable_box_clone_initialized(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpCopyableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clone_initialized()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vphp_copyable_box_bump']
pub fn vphp_wrap_vphp_copyable_box_bump(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpCopyableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'delta' },
    ])
    arg_0 := php_args.at(0).as_v[int]()
    recv.bump(arg_0)
}
@[export: 'vphp_wrap_vphp_copyable_box_state']
pub fn vphp_wrap_vphp_copyable_box_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpCopyableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.state()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vphp_copyable_box_serialize_state']
pub fn vphp_wrap_vphp_copyable_box_serialize_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpCopyableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.serialize_state()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vphp_copyable_box_unserialize_state']
pub fn vphp_wrap_vphp_copyable_box_unserialize_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpCopyableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    recv.unserialize_state(arg_0)
}
@[export: 'vphp_copyable_box_handlers']
pub fn vphp_copyable_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vphp_copyable_box_get_prop,
        write_handler: vphp_copyable_box_set_prop,
        sync_handler: vphp_copyable_box_sync_props,
        new_raw: vphp_copyable_box_new_raw,
        cleanup_raw: vphp_copyable_box_cleanup_raw,
        free_raw: vphp_copyable_box_free_raw,
        init_php_state: vphp_copyable_box_init_php_state
    )
}
fn vphp_copyable_box_init_php_state(ptr voidptr) {
    unsafe {
        mut obj := &VphpCopyableBox(ptr)
        obj.init_php_state()
    }
}
pub fn VphpCopyableBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__compiler__copyablebox_ce)
}

pub fn VphpCopyableBox.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vphp_copyable_box_handlers())
}

pub fn VphpCopyableBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VphpCopyableBox](v_ptr, ownership)
}

pub fn (obj &VphpCopyableBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VphpCopyableBox](obj)
}

pub fn (obj &VphpCopyableBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VphpCopyableBox](obj)
}

pub fn (obj &VphpCopyableBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VphpCopyableBox](obj)
}

pub fn (obj &VphpCopyableBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VphpCopyableBox](obj)
}

pub fn (val VphpCopyableBox) php_class_name() string {
    return 'VPHP\\Compiler\\CopyableBox'
}

@[export: 'vphp_tagged_box_new_raw']
pub fn vphp_tagged_box_new_raw() voidptr {
    return vphp.generic_new_raw[VphpTaggedBox]()
}
@[export: 'vphp_tagged_box_free_raw']
pub fn vphp_tagged_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    mut obj := unsafe { &VphpTaggedBox(ptr) }
    vphp.generic_release_fields(mut obj.VphpCopyableBox)
    vphp.generic_free_raw[VphpTaggedBox](ptr)
}
@[export: 'vphp_tagged_box_cleanup_raw']
pub fn vphp_tagged_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vphp_tagged_box_clone_into_raw']
pub fn vphp_tagged_box_clone_into_raw(source voidptr, target voidptr) {
    unsafe {
        src := &VphpTaggedBox(source)
        mut dst := &VphpTaggedBox(target)
        src.clone_into(mut dst)
    }
}
@[export: 'vphp_tagged_box_get_prop']
pub fn vphp_tagged_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VphpTaggedBox(ptr)
        if name == 'tag' {
            ret.v[string](obj.tag)
            return
        }
        if name == 'count' {
            ret.v[i64](i64(obj.VphpCopyableBox.count))
            return
        }
    }
}
@[export: 'vphp_tagged_box_set_prop']
pub fn vphp_tagged_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VphpTaggedBox(ptr)
        if name == 'tag' {
            obj.tag = arg.get_string()
            return
        }
        if name == 'count' {
            obj.VphpCopyableBox.count = int(arg.get_int())
            return
        }
    }
}
@[export: 'vphp_tagged_box_sync_props']
pub fn vphp_tagged_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VphpTaggedBox(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'tag', obj.tag)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'count', obj.VphpCopyableBox.count)
    }
}
@[export: 'vphp_wrap_vphp_tagged_box_serialize_tagged_state']
pub fn vphp_wrap_vphp_tagged_box_serialize_tagged_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpTaggedBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.serialize_tagged_state()
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vphp_tagged_box_unserialize_tagged_state']
pub fn vphp_wrap_vphp_tagged_box_unserialize_tagged_state(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpTaggedBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    recv.unserialize_tagged_state(arg_0)
}
@[export: 'vphp_tagged_box_handlers']
pub fn vphp_tagged_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vphp_tagged_box_get_prop,
        write_handler: vphp_tagged_box_set_prop,
        sync_handler: vphp_tagged_box_sync_props,
        new_raw: vphp_tagged_box_new_raw,
        cleanup_raw: vphp_tagged_box_cleanup_raw,
        free_raw: vphp_tagged_box_free_raw,
        init_php_state: vphp_tagged_box_init_php_state
    )
}
fn vphp_tagged_box_init_php_state(ptr voidptr) {
    unsafe {
        mut obj := &VphpTaggedBox(ptr)
        obj.init_php_state()
    }
}
pub fn VphpTaggedBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__compiler__taggedbox_ce)
}

pub fn VphpTaggedBox.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vphp_tagged_box_handlers())
}

pub fn VphpTaggedBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VphpTaggedBox](v_ptr, ownership)
}

pub fn (obj &VphpTaggedBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VphpTaggedBox](obj)
}

pub fn (obj &VphpTaggedBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VphpTaggedBox](obj)
}

pub fn (obj &VphpTaggedBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VphpTaggedBox](obj)
}

pub fn (obj &VphpTaggedBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VphpTaggedBox](obj)
}

pub fn (val VphpTaggedBox) php_class_name() string {
    return 'VPHP\\Compiler\\TaggedBox'
}

@[export: 'vphp_numbered_box_new_raw']
pub fn vphp_numbered_box_new_raw() voidptr {
    return vphp.generic_new_raw[VphpNumberedBox]()
}
@[export: 'vphp_numbered_box_free_raw']
pub fn vphp_numbered_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    mut obj := unsafe { &VphpNumberedBox(ptr) }
    vphp.generic_release_fields(mut obj.VphpTaggedBox)
    vphp.generic_release_fields(mut obj.VphpTaggedBox.VphpCopyableBox)
    vphp.generic_free_raw[VphpNumberedBox](ptr)
}
@[export: 'vphp_numbered_box_cleanup_raw']
pub fn vphp_numbered_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vphp_numbered_box_clone_into_raw']
pub fn vphp_numbered_box_clone_into_raw(source voidptr, target voidptr) {
    unsafe {
        src := &VphpNumberedBox(source)
        mut dst := &VphpNumberedBox(target)
        src.clone_into(mut dst)
    }
}
@[export: 'vphp_numbered_box_get_prop']
pub fn vphp_numbered_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VphpNumberedBox(ptr)
        if name == 'number' {
            ret.v[i64](i64(obj.number))
            return
        }
        if name == 'tag' {
            ret.v[string](obj.VphpTaggedBox.tag)
            return
        }
        if name == 'count' {
            ret.v[i64](i64(obj.VphpTaggedBox.VphpCopyableBox.count))
            return
        }
    }
}
@[export: 'vphp_numbered_box_set_prop']
pub fn vphp_numbered_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VphpNumberedBox(ptr)
        if name == 'number' {
            obj.number = int(arg.get_int())
            return
        }
        if name == 'tag' {
            obj.VphpTaggedBox.tag = arg.get_string()
            return
        }
        if name == 'count' {
            obj.VphpTaggedBox.VphpCopyableBox.count = int(arg.get_int())
            return
        }
    }
}
@[export: 'vphp_numbered_box_sync_props']
pub fn vphp_numbered_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VphpNumberedBox(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'number', obj.number)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'tag', obj.VphpTaggedBox.tag)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'count', obj.VphpTaggedBox.VphpCopyableBox.count)
    }
}
@[export: 'vphp_numbered_box_handlers']
pub fn vphp_numbered_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vphp_numbered_box_get_prop,
        write_handler: vphp_numbered_box_set_prop,
        sync_handler: vphp_numbered_box_sync_props,
        new_raw: vphp_numbered_box_new_raw,
        cleanup_raw: vphp_numbered_box_cleanup_raw,
        free_raw: vphp_numbered_box_free_raw,
        init_php_state: vphp_numbered_box_init_php_state
    )
}
fn vphp_numbered_box_init_php_state(ptr voidptr) {
    unsafe {
        mut obj := &VphpNumberedBox(ptr)
        obj.init_php_state()
    }
}
pub fn VphpNumberedBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__compiler__numberedbox_ce)
}

pub fn VphpNumberedBox.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vphp_numbered_box_handlers())
}

pub fn VphpNumberedBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VphpNumberedBox](v_ptr, ownership)
}

pub fn (obj &VphpNumberedBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VphpNumberedBox](obj)
}

pub fn (obj &VphpNumberedBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VphpNumberedBox](obj)
}

pub fn (obj &VphpNumberedBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VphpNumberedBox](obj)
}

pub fn (obj &VphpNumberedBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VphpNumberedBox](obj)
}

pub fn (val VphpNumberedBox) php_class_name() string {
    return 'VPHP\\Compiler\\NumberedBox'
}

@[export: 'vphp_module_probe_typed_consts_new_raw']
pub fn vphp_module_probe_typed_consts_new_raw() voidptr {
    return vphp.generic_new_raw[VphpModuleProbeTypedConsts]()
}
@[export: 'vphp_module_probe_typed_consts_free_raw']
pub fn vphp_module_probe_typed_consts_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VphpModuleProbeTypedConsts](ptr)
}
@[export: 'vphp_module_probe_typed_consts_cleanup_raw']
pub fn vphp_module_probe_typed_consts_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vphp_module_probe_typed_consts_get_prop']
pub fn vphp_module_probe_typed_consts_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vphp_module_probe_typed_consts_set_prop']
pub fn vphp_module_probe_typed_consts_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vphp_module_probe_typed_consts_sync_props']
pub fn vphp_module_probe_typed_consts_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
pub fn VphpModuleProbeTypedConsts.consts() VphpModuleProbeConsts {
    return compiler_probe_consts
}
@[export: 'vphp_module_probe_typed_consts_handlers']
pub fn vphp_module_probe_typed_consts_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vphp_module_probe_typed_consts_get_prop,
        write_handler: vphp_module_probe_typed_consts_set_prop,
        sync_handler: vphp_module_probe_typed_consts_sync_props,
        new_raw: vphp_module_probe_typed_consts_new_raw,
        cleanup_raw: vphp_module_probe_typed_consts_cleanup_raw,
        free_raw: vphp_module_probe_typed_consts_free_raw
    )
}
pub fn VphpModuleProbeTypedConsts.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__compiler__moduleprobetypedconsts_ce)
}

pub fn VphpModuleProbeTypedConsts.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vphp_module_probe_typed_consts_handlers())
}

pub fn VphpModuleProbeTypedConsts.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VphpModuleProbeTypedConsts](v_ptr, ownership)
}

pub fn (obj &VphpModuleProbeTypedConsts) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VphpModuleProbeTypedConsts](obj)
}

pub fn (obj &VphpModuleProbeTypedConsts) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VphpModuleProbeTypedConsts](obj)
}

pub fn (obj &VphpModuleProbeTypedConsts) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VphpModuleProbeTypedConsts](obj)
}

pub fn (obj &VphpModuleProbeTypedConsts) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VphpModuleProbeTypedConsts](obj)
}

pub fn (val VphpModuleProbeTypedConsts) php_class_name() string {
    return 'VPHP\\Compiler\\ModuleProbeTypedConsts'
}

@[export: 'vphp_module_probe_wrapper_box_new_raw']
pub fn vphp_module_probe_wrapper_box_new_raw() voidptr {
    return vphp.generic_new_raw[VphpModuleProbeWrapperBox]()
}
@[export: 'vphp_module_probe_wrapper_box_free_raw']
pub fn vphp_module_probe_wrapper_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VphpModuleProbeWrapperBox](ptr)
}
@[export: 'vphp_module_probe_wrapper_box_cleanup_raw']
pub fn vphp_module_probe_wrapper_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vphp_module_probe_wrapper_box_get_prop']
pub fn vphp_module_probe_wrapper_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VphpModuleProbeWrapperBox(ptr)
        if name == 'val' {
            vphp.PhpObjectPropertyHandler.return_value(ret, obj.val)
            return
        }
        if name == 'obj' {
            vphp.PhpObjectPropertyHandler.return_value(ret, obj.obj.to_value())
            return
        }
        if name == 'str' {
            vphp.PhpObjectPropertyHandler.return_value(ret, obj.str.to_value())
            return
        }
        if name == 'num' {
            vphp.PhpObjectPropertyHandler.return_value(ret, obj.num.to_value())
            return
        }
        if name == 'b' {
            vphp.PhpObjectPropertyHandler.return_value(ret, obj.b.to_value())
            return
        }
        if name == 'arr' {
            vphp.PhpObjectPropertyHandler.return_value(ret, obj.arr.to_value())
            return
        }
    }
}
@[export: 'vphp_module_probe_wrapper_box_set_prop']
pub fn vphp_module_probe_wrapper_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VphpModuleProbeWrapperBox(ptr)
        if name == 'val' {
            mut previous := obj.val
            obj.val = vphp.PhpValue.from_zval(arg).retain()
            previous.release()
            return
        }
        if name == 'obj' {
            mut previous := obj.obj
            obj.obj = (vphp.PhpObject.from_zval(arg) or { vphp.PhpObject.invalid() }).retain()
            previous.release()
            return
        }
        if name == 'str' {
            mut previous := obj.str
            obj.str = vphp.PhpString.coerce(arg).retain()
            previous.release()
            return
        }
        if name == 'num' {
            mut previous := obj.num
            obj.num = vphp.PhpInt.coerce(arg).retain()
            previous.release()
            return
        }
        if name == 'b' {
            mut previous := obj.b
            obj.b = vphp.PhpBool.coerce(arg).retain()
            previous.release()
            return
        }
        if name == 'arr' {
            mut previous := obj.arr
            obj.arr = (vphp.PhpArray.from_zval(arg) or { vphp.PhpArray.empty() }).retain()
            previous.release()
            return
        }
    }
}
@[export: 'vphp_module_probe_wrapper_box_sync_props']
pub fn vphp_module_probe_wrapper_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VphpModuleProbeWrapperBox(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'val', obj.val)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'obj', obj.obj.to_value())
        vphp.PhpObjectPropertyHandler.sync_property(out, 'str', obj.str.to_value())
        vphp.PhpObjectPropertyHandler.sync_property(out, 'num', obj.num.to_value())
        vphp.PhpObjectPropertyHandler.sync_property(out, 'b', obj.b.to_value())
        vphp.PhpObjectPropertyHandler.sync_property(out, 'arr', obj.arr.to_value())
    }
}
@[export: 'vphp_wrap_vphp_module_probe_wrapper_box_change_props']
pub fn vphp_wrap_vphp_module_probe_wrapper_box_change_props(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VphpModuleProbeWrapperBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'newVal' },
        vphp.PhpArgMeta{ index: 1, name: 'newObj' },
        vphp.PhpArgMeta{ index: 2, name: 'newStr' },
        vphp.PhpArgMeta{ index: 3, name: 'newNum' },
        vphp.PhpArgMeta{ index: 4, name: 'newB' },
        vphp.PhpArgMeta{ index: 5, name: 'newArr' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    arg_2 := php_args.at(2).string_value() or {
        vphp.throw_exception('argument 2 must be string', 0)
        return
    }
    arg_3 := php_args.at(3).int_value() or {
        vphp.throw_exception('argument 3 must be int', 0)
        return
    }
    arg_4 := php_args.at(4).bool_value() or {
        vphp.throw_exception('argument 4 must be bool', 0)
        return
    }
    arg_5 := php_args.at(5).array() or {
        vphp.throw_exception('argument 5 must be array', 0)
        return
    }
    recv.change_props(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
}
@[export: 'vphp_module_probe_wrapper_box_handlers']
pub fn vphp_module_probe_wrapper_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: vphp_module_probe_wrapper_box_get_prop,
        write_handler: vphp_module_probe_wrapper_box_set_prop,
        sync_handler: vphp_module_probe_wrapper_box_sync_props,
        new_raw: vphp_module_probe_wrapper_box_new_raw,
        cleanup_raw: vphp_module_probe_wrapper_box_cleanup_raw,
        free_raw: vphp_module_probe_wrapper_box_free_raw
    )
}
pub fn VphpModuleProbeWrapperBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__compiler__moduleprobewrapperbox_ce)
}

pub fn VphpModuleProbeWrapperBox.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vphp_module_probe_wrapper_box_handlers())
}

pub fn VphpModuleProbeWrapperBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VphpModuleProbeWrapperBox](v_ptr, ownership)
}

pub fn (obj &VphpModuleProbeWrapperBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VphpModuleProbeWrapperBox](obj)
}

pub fn (obj &VphpModuleProbeWrapperBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VphpModuleProbeWrapperBox](obj)
}

pub fn (obj &VphpModuleProbeWrapperBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VphpModuleProbeWrapperBox](obj)
}

pub fn (obj &VphpModuleProbeWrapperBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VphpModuleProbeWrapperBox](obj)
}

pub fn (val VphpModuleProbeWrapperBox) php_class_name() string {
    return 'VPHP\\Compiler\\ModuleProbeWrapperBox'
}

@[export: 'trait_post_new_raw']
pub fn trait_post_new_raw() voidptr {
    return vphp.generic_new_raw[TraitPost]()
}
@[export: 'trait_post_free_raw']
pub fn trait_post_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[TraitPost](ptr)
}
@[export: 'trait_post_cleanup_raw']
pub fn trait_post_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'trait_post_get_prop']
pub fn trait_post_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &TraitPost(ptr)
        if name == 'title' {
            ret.v[string](obj.title)
            return
        }
        if name == 'slug' {
            ret.v[string](obj.slug)
            return
        }
        if name == 'visits' {
            ret.v[i64](i64(obj.visits))
            return
        }
    }
}
@[export: 'trait_post_set_prop']
pub fn trait_post_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &TraitPost(ptr)
        if name == 'title' {
            obj.title = arg.get_string()
            return
        }
        if name == 'slug' {
            obj.slug = arg.get_string()
            return
        }
        if name == 'visits' {
            obj.visits = int(arg.get_int())
            return
        }
    }
}
@[export: 'trait_post_sync_props']
pub fn trait_post_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &TraitPost(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'title', obj.title)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'slug', obj.slug)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'visits', obj.visits)
    }
}
@[export: 'vphp_wrap_trait_post_construct']
pub fn vphp_wrap_trait_post_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.construct(arg_0)
    ctx.return().return_v_object[TraitPost](res, .borrowed)
}
@[export: 'vphp_wrap_trait_post_summary']
pub fn vphp_wrap_trait_post_summary(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.summary()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_trait_post_bump']
pub fn vphp_wrap_trait_post_bump(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.bump()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_trait_post_trait_only']
pub fn vphp_wrap_trait_post_trait_only(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.trait_only()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_trait_post_internal_trait']
pub fn vphp_wrap_trait_post_internal_trait(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.internal_trait()
    ctx.return().v[string](res)
}
@[export: 'trait_post_handlers']
pub fn trait_post_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: trait_post_get_prop,
        write_handler: trait_post_set_prop,
        sync_handler: trait_post_sync_props,
        new_raw: trait_post_new_raw,
        cleanup_raw: trait_post_cleanup_raw,
        free_raw: trait_post_free_raw
    )
}
pub fn TraitPost.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.traitpost_ce)
}

pub fn TraitPost.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(trait_post_handlers())
}

pub fn TraitPost.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[TraitPost](v_ptr, ownership)
}

pub fn (obj &TraitPost) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[TraitPost](obj)
}

pub fn (obj &TraitPost) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[TraitPost](obj)
}

pub fn (obj &TraitPost) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[TraitPost](obj)
}

pub fn (obj &TraitPost) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[TraitPost](obj)
}

pub fn (val TraitPost) php_class_name() string {
    return 'TraitPost'
}

@[export: 'validator_new_raw']
pub fn validator_new_raw() voidptr {
    return vphp.generic_new_raw[Validator]()
}
@[export: 'validator_free_raw']
pub fn validator_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Validator](ptr)
}
@[export: 'validator_cleanup_raw']
pub fn validator_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'validator_get_prop']
pub fn validator_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &Validator(ptr)
        if name == 'strict' {
            ret.v[bool](obj.strict)
            return
        }
    }
}
@[export: 'validator_set_prop']
pub fn validator_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &Validator(ptr)
        if name == 'strict' {
            obj.strict = arg.get_bool()
            return
        }
    }
}
@[export: 'validator_sync_props']
pub fn validator_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Validator(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'strict', obj.strict)
    }
}
@[export: 'vphp_wrap_validator_construct']
pub fn vphp_wrap_validator_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'strict' },
    ])
    arg_0 := php_args.at(0).as_v[bool]()
    recv.construct(arg_0)
}
@[export: 'vphp_wrap_validator_check']
pub fn vphp_wrap_validator_check(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_result[bool](fn [arg_0, recv] () !bool {
        return recv.check(arg_0)!
    })
}
@[export: 'vphp_wrap_validator_sanitize']
pub fn vphp_wrap_validator_sanitize(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_result[string](fn [arg_0, recv] () !string {
        return recv.sanitize(arg_0)!
    })
}
@[export: 'vphp_wrap_validator_assert_valid']
pub fn vphp_wrap_validator_assert_valid(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_result_void(fn [arg_0, recv] () ! {
        recv.assert_valid(arg_0)!
    })
}
@[export: 'vphp_wrap_validator_parse_int']
pub fn vphp_wrap_validator_parse_int(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 's' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_result[int](fn [arg_0] () !int {
        return Validator.parse_int(arg_0)!
    })
}
@[export: 'validator_handlers']
pub fn validator_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: validator_get_prop,
        write_handler: validator_set_prop,
        sync_handler: validator_sync_props,
        new_raw: validator_new_raw,
        cleanup_raw: validator_cleanup_raw,
        free_raw: validator_free_raw
    )
}
pub fn Validator.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.validator_ce)
}

pub fn Validator.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(validator_handlers())
}

pub fn Validator.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[Validator](v_ptr, ownership)
}

pub fn (obj &Validator) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[Validator](obj)
}

pub fn (obj &Validator) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[Validator](obj)
}

pub fn (obj &Validator) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[Validator](obj)
}

pub fn (obj &Validator) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[Validator](obj)
}

pub fn (val Validator) php_class_name() string {
    return 'Validator'
}

@[export: 'dispatchable_sample_new_raw']
pub fn dispatchable_sample_new_raw() voidptr {
    return vphp.generic_new_raw[DispatchableSample]()
}
@[export: 'dispatchable_sample_free_raw']
pub fn dispatchable_sample_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[DispatchableSample](ptr)
}
@[export: 'dispatchable_sample_cleanup_raw']
pub fn dispatchable_sample_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'dispatchable_sample_get_prop']
pub fn dispatchable_sample_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &DispatchableSample(ptr)
        if name == 'name' {
            ret.v[string](obj.name)
            return
        }
    }
}
@[export: 'dispatchable_sample_set_prop']
pub fn dispatchable_sample_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &DispatchableSample(ptr)
        if name == 'name' {
            obj.name = arg.get_string()
            return
        }
    }
}
@[export: 'dispatchable_sample_sync_props']
pub fn dispatchable_sample_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &DispatchableSample(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'name', obj.name)
    }
}
@[export: 'vphp_wrap_dispatchable_sample_construct']
pub fn vphp_wrap_dispatchable_sample_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &DispatchableSample(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.construct(arg_0)
    ctx.return().return_v_object[DispatchableSample](res, .borrowed)
}
@[export: 'vphp_wrap_dispatchable_sample_tagged']
pub fn vphp_wrap_dispatchable_sample_tagged(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &DispatchableSample(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: [vphp.PhpAttribute.named('FromQuery').for_parameter().string('name'), vphp.PhpAttribute.named('MustBeString').for_parameter()] },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.tagged(arg_0)
    ctx.return().v[string](res)
}
@[export: 'dispatchable_sample_handlers']
pub fn dispatchable_sample_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: dispatchable_sample_get_prop,
        write_handler: dispatchable_sample_set_prop,
        sync_handler: dispatchable_sample_sync_props,
        new_raw: dispatchable_sample_new_raw,
        cleanup_raw: dispatchable_sample_cleanup_raw,
        free_raw: dispatchable_sample_free_raw
    )
}
pub fn DispatchableSample.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.dispatchablesample_ce)
}

pub fn DispatchableSample.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(dispatchable_sample_handlers())
}

pub fn DispatchableSample.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[DispatchableSample](v_ptr, ownership)
}

pub fn (obj &DispatchableSample) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[DispatchableSample](obj)
}

pub fn (obj &DispatchableSample) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[DispatchableSample](obj)
}

pub fn (obj &DispatchableSample) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[DispatchableSample](obj)
}

pub fn (obj &DispatchableSample) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[DispatchableSample](obj)
}

pub fn (val DispatchableSample) php_class_name() string {
    return 'DispatchableSample'
}

@[export: 'vphp_enum_backing_values_articlestatus']
fn vphp_enum_backing_values_articlestatus(values &i64) {
    unsafe {
        values[0] = i64(ArticleStatus.draft)
        values[1] = i64(ArticleStatus.review)
        values[2] = i64(ArticleStatus.published)
    }
}
pub fn (val ArticleStatus) php_class_name() string {
    return 'ArticleStatus'
}

@[export: 'v_php_task_new_raw']
pub fn v_php_task_new_raw() voidptr {
    return vphp.generic_new_raw[VPhpTask]()
}
@[export: 'v_php_task_free_raw']
pub fn v_php_task_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VPhpTask](ptr)
}
@[export: 'v_php_task_cleanup_raw']
pub fn v_php_task_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'v_php_task_get_prop']
pub fn v_php_task_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'v_php_task_set_prop']
pub fn v_php_task_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'v_php_task_sync_props']
pub fn v_php_task_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_v_php_task_spawn']
pub fn vphp_wrap_v_php_task_spawn(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    VPhpTask.@spawn(arg_0)
}
@[export: 'vphp_wrap_v_php_task_wait']
pub fn vphp_wrap_v_php_task_wait(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    VPhpTask.wait(arg_0)
}
@[export: 'vphp_wrap_v_php_task_list']
pub fn vphp_wrap_v_php_task_list(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    VPhpTask.list(arg_0)
}
@[export: 'v_php_task_handlers']
pub fn v_php_task_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: v_php_task_get_prop,
        write_handler: v_php_task_set_prop,
        sync_handler: v_php_task_sync_props,
        new_raw: v_php_task_new_raw,
        cleanup_raw: v_php_task_cleanup_raw,
        free_raw: v_php_task_free_raw
    )
}
pub fn VPhpTask.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__task_ce)
}

pub fn VPhpTask.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(v_php_task_handlers())
}

pub fn VPhpTask.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VPhpTask](v_ptr, ownership)
}

pub fn (obj &VPhpTask) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VPhpTask](obj)
}

pub fn (obj &VPhpTask) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VPhpTask](obj)
}

pub fn (obj &VPhpTask) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VPhpTask](obj)
}

pub fn (obj &VPhpTask) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VPhpTask](obj)
}

pub fn (val VPhpTask) php_class_name() string {
    return 'VPhp\\Task'
}

@[export: 'stringable_box_new_raw']
pub fn stringable_box_new_raw() voidptr {
    return vphp.generic_new_raw[StringableBox]()
}
@[export: 'stringable_box_free_raw']
pub fn stringable_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[StringableBox](ptr)
}
@[export: 'stringable_box_cleanup_raw']
pub fn stringable_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'stringable_box_get_prop']
pub fn stringable_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &StringableBox(ptr)
        if name == 'name' {
            ret.v[string](obj.name)
            return
        }
    }
}
@[export: 'stringable_box_set_prop']
pub fn stringable_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &StringableBox(ptr)
        if name == 'name' {
            obj.name = arg.get_string()
            return
        }
    }
}
@[export: 'stringable_box_sync_props']
pub fn stringable_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &StringableBox(ptr)
        vphp.PhpObjectPropertyHandler.sync_property(out, 'name', obj.name)
    }
}
@[export: 'vphp_wrap_stringable_box_construct']
pub fn vphp_wrap_stringable_box_construct(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &StringableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := recv.construct(arg_0)
    ctx.return().return_v_object[StringableBox](res, .borrowed)
}
@[export: 'vphp_wrap_stringable_box_str']
pub fn vphp_wrap_stringable_box_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &StringableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'stringable_box_handlers']
pub fn stringable_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new_typed(
        prop_handler: stringable_box_get_prop,
        write_handler: stringable_box_set_prop,
        sync_handler: stringable_box_sync_props,
        new_raw: stringable_box_new_raw,
        cleanup_raw: stringable_box_cleanup_raw,
        free_raw: stringable_box_free_raw
    )
}
pub fn StringableBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.stringablebox_ce)
}

pub fn StringableBox.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(stringable_box_handlers())
}

pub fn StringableBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[StringableBox](v_ptr, ownership)
}

pub fn (obj &StringableBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[StringableBox](obj)
}

pub fn (obj &StringableBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[StringableBox](obj)
}

pub fn (obj &StringableBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[StringableBox](obj)
}

pub fn (obj &StringableBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[StringableBox](obj)
}

pub fn (val StringableBox) php_class_name() string {
    return 'StringableBox'
}

@[export: 'vphp_wrap_v_add']
fn vphp_wrap_v_add(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'a' },
        vphp.PhpArgMeta{ index: 1, name: 'b' },
    ])
    arg_0 := php_args.at(0).as_v[i64]()
    arg_1 := php_args.at(1).as_v[i64]()
    res := v_add(arg_0, arg_1)
    ctx.return().v[i64](res)
}

@[export: 'vphp_wrap_v_greet']
fn vphp_wrap_v_greet(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := v_greet(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_float_const']
fn vphp_wrap_v_float_const(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_float_const()
    ctx.return().v[f64](res)
}

@[export: 'vphp_wrap_v_float_id']
fn vphp_wrap_v_float_id(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'x' },
    ])
    arg_0 := php_args.at(0).as_v[f64]()
    res := v_float_id(arg_0)
    ctx.return().v[f64](res)
}

@[export: 'vphp_wrap_v_pure_map_test']
fn vphp_wrap_v_pure_map_test(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'k' },
        vphp.PhpArgMeta{ index: 1, name: 'v' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := v_pure_map_test(arg_0, arg_1)
    ctx.return().v[map[string]string](res)
}

@[export: 'vphp_wrap_v_process_list']
fn vphp_wrap_v_process_list(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_process_list(arg_0)
}

@[export: 'vphp_wrap_v_test_map']
fn vphp_wrap_v_test_map(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_test_map(arg_0)
}

@[export: 'vphp_wrap_v_get_config']
fn vphp_wrap_v_get_config(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_get_config(arg_0)
}

@[export: 'vphp_wrap_v_get_user']
fn vphp_wrap_v_get_user(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_get_user(arg_0)
}

@[export: 'vphp_wrap_v_call_back']
fn vphp_wrap_v_call_back(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_call_back(arg_0)
}

@[export: 'vphp_wrap_v_bind_class_interface']
fn vphp_wrap_v_bind_class_interface(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'className' },
        vphp.PhpArgMeta{ index: 1, name: 'ifaceName' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := v_bind_class_interface(arg_0, arg_1)
    ctx.return().v[bool](res)
}

@[export: 'vphp_wrap_v_complex_test']
fn vphp_wrap_v_complex_test(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_complex_test(arg_0)
}

@[export: 'vphp_wrap_v_persistent_nested_roundtrip']
fn vphp_wrap_v_persistent_nested_roundtrip(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_persistent_nested_roundtrip(arg_0)
}

@[export: 'vphp_wrap_v_persistent_multi_nested_stress']
fn vphp_wrap_v_persistent_multi_nested_stress(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_persistent_multi_nested_stress(arg_0)
}

@[export: 'vphp_wrap_v_analyze_user_object']
fn vphp_wrap_v_analyze_user_object(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_analyze_user_object(arg_0)
}

@[export: 'vphp_wrap_v_mutate_user_object']
fn vphp_wrap_v_mutate_user_object(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_mutate_user_object(arg_0)
}

@[export: 'vphp_wrap_v_check_user_object_props']
fn vphp_wrap_v_check_user_object_props(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_check_user_object_props(arg_0)
}

@[export: 'vphp_wrap_v_construct_php_object']
fn vphp_wrap_v_construct_php_object(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_construct_php_object(arg_0)
}

@[export: 'vphp_wrap_v_call_php_static_method']
fn vphp_wrap_v_call_php_static_method(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_call_php_static_method(arg_0)
}

@[export: 'vphp_wrap_v_mutate_php_static_prop']
fn vphp_wrap_v_mutate_php_static_prop(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_mutate_php_static_prop(arg_0)
}

@[export: 'vphp_wrap_v_read_php_class_constant']
fn vphp_wrap_v_read_php_class_constant(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_read_php_class_constant(arg_0)
}

@[export: 'vphp_wrap_v_typed_php_interop']
fn vphp_wrap_v_typed_php_interop(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'obj' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_typed_php_interop(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_typed_object_restore']
fn vphp_wrap_v_typed_object_restore(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_typed_object_restore(arg_0)
}

@[export: 'vphp_wrap_v_zval_conversion_api']
fn vphp_wrap_v_zval_conversion_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_zval_conversion_api()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_vptr_root_count']
fn vphp_wrap_v_vptr_root_count(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_vptr_root_count()
    ctx.return().v[int](res)
}

@[export: 'vphp_wrap_v_persistent_fallback_counter_probe']
fn vphp_wrap_v_persistent_fallback_counter_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_persistent_fallback_counter_probe(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_request_scope_counter_probe']
fn vphp_wrap_v_request_scope_counter_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rounds' },
    ])
    arg_0 := php_args.at(0).as_v[int]()
    res := v_request_scope_counter_probe(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_value_zbox_lifecycle_probe']
fn vphp_wrap_v_php_value_zbox_lifecycle_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_value_zbox_lifecycle_probe(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_unified_object_interop']
fn vphp_wrap_v_unified_object_interop(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_unified_object_interop(arg_0)
}

@[export: 'vphp_wrap_v_php_class_named_api']
fn vphp_wrap_v_php_class_named_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_class_named_api(arg_0)
}

@[export: 'vphp_wrap_v_php_function_named_api']
fn vphp_wrap_v_php_function_named_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_function_named_api(arg_0)
}

@[export: 'vphp_wrap_v_php_closure_api']
fn vphp_wrap_v_php_closure_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_closure_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_closure_persistent_api']
fn vphp_wrap_v_php_closure_persistent_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_closure_persistent_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_class_meta_api']
fn vphp_wrap_v_php_class_meta_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_class_meta_api(arg_0)
}

@[export: 'vphp_wrap_v_php_object_api']
fn vphp_wrap_v_php_object_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_object_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_array_api']
fn vphp_wrap_v_php_array_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_array_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_callable_api']
fn vphp_wrap_v_php_callable_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_callable_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_value_api']
fn vphp_wrap_v_php_value_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_value_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_scalar_api']
fn vphp_wrap_v_php_scalar_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_scalar_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_scalar_strict_api']
fn vphp_wrap_v_php_scalar_strict_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_php_scalar_strict_api()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_semantic_empty_api']
fn vphp_wrap_v_php_semantic_empty_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_php_semantic_empty_api()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_params_struct_api']
fn vphp_wrap_v_php_params_struct_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status' },
        vphp.PhpArgMeta{ index: 1, name: 'reasonPhrase' },
        vphp.PhpArgMeta{ index: 2, name: 'secure' },
        vphp.PhpArgMeta{ index: 3, name: 'ratio' },
    ])
    arg_0_params_status := if php_args.has(0) { php_args.at(0).as_v[int]() } else { 200 }
    arg_0_params_reason_phrase := if php_args.has(1) { php_args.at(1).as_v[string]() } else { '' }
    arg_0_params_secure := if php_args.has(2) { php_args.at(2).as_v[bool]() } else { false }
    arg_0_params_ratio := if php_args.has(3) { php_args.at(3).as_v[f64]() } else { 1.5 }
    arg_0_params := VPhpParamsStructDemo{
        status: arg_0_params_status
        reason_phrase: arg_0_params_reason_phrase
        secure: arg_0_params_secure
        ratio: arg_0_params_ratio
    }
    res := v_php_params_struct_api(arg_0_params)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_computed_params']
fn vphp_wrap_v_php_computed_params(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
        vphp.PhpArgMeta{ index: 1, name: 'sequence' },
        vphp.PhpArgMeta{ index: 2, name: 'label' },
        vphp.PhpArgMeta{ index: 3, name: 'enabled' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1_params_sequence := if php_args.has(1) {
        php_args.at(1).as_v[int]()
    } else {
        defaults := VPhpComputedParamsDemo{
            label: none
        }
        if vphp.has_exception() {
            return
        }
        defaults.sequence
    }
    arg_1_params_label := if php_args.has(2) {
        php_args.at(2).as_v_opt[string]()
    } else {
        defaults := VPhpComputedParamsDemo{
            sequence: int(0)
        }
        if vphp.has_exception() {
            return
        }
        defaults.label
    }
    arg_1_params_enabled := if php_args.has(3) { php_args.at(3).as_v[bool]() } else { true }
    arg_1_params := VPhpComputedParamsDemo{
        sequence: arg_1_params_sequence
        label: arg_1_params_label
        enabled: arg_1_params_enabled
    }
    res := v_php_computed_params(arg_0, arg_1_params)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_arg_binding_optional_scalar_api']
fn vphp_wrap_v_php_arg_binding_optional_scalar_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'count', use_php_default: true },
        vphp.PhpArgMeta{ index: 1, name: 'label', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[int]()
    arg_1 := php_args.at(1).as_v[string]()
    res := v_php_arg_binding_optional_scalar_api(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_direct_arg_camel_api']
fn vphp_wrap_v_php_direct_arg_camel_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'firstName' },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    res := v_php_direct_arg_camel_api(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_call_style_arg_attrs_api']
fn vphp_wrap_v_php_call_style_arg_attrs_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'valueAlias' },
        vphp.PhpArgMeta{ index: 1, name: 'optionalCount', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[int]()
    res := v_php_call_style_arg_attrs_api(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_semantic_params_struct_api']
fn vphp_wrap_v_php_semantic_params_struct_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'label' },
        vphp.PhpArgMeta{ index: 1, name: 'flag' },
        vphp.PhpArgMeta{ index: 2, name: 'items' },
    ])
    arg_0_params_label := if php_args.has(0) {
        php_args.at(0).string_value() or {
            vphp.throw_exception('argument 0 must be string', 0)
            return
        }
    } else {
        vphp.PhpString.empty()
    }
    arg_0_params_flag := if php_args.has(1) {
        php_args.at(1).bool_value() or {
            vphp.throw_exception('argument 1 must be bool', 0)
            return
        }
    } else {
        vphp.PhpBool.false_value()
    }
    arg_0_params_items := if php_args.has(2) {
        php_args.at(2).array() or {
            vphp.throw_exception('argument 2 must be array', 0)
            return
        }
    } else {
        vphp.PhpArray.empty()
    }
    arg_0_params := VPhpSemanticParamsStructDemo{
        label: arg_0_params_label
        flag: arg_0_params_flag
        items: arg_0_params_items
    }
    res := v_php_semantic_params_struct_api(arg_0_params)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_args_api']
fn vphp_wrap_v_php_args_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    res := v_php_args_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_resource_api']
fn vphp_wrap_v_php_resource_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_resource_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_wrapper_param_api']
fn vphp_wrap_v_php_wrapper_param_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
        vphp.PhpArgMeta{ index: 1, name: 'obj' },
        vphp.PhpArgMeta{ index: 2, name: 'arr' },
        vphp.PhpArgMeta{ index: 3, name: 'callable' },
        vphp.PhpArgMeta{ index: 4, name: 'nullValue' },
        vphp.PhpArgMeta{ index: 5, name: 'maybeObj' },
    ])
    arg_0 := php_args.at(0).value
    arg_1 := php_args.at(1).object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    arg_2 := php_args.at(2).array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := php_args.at(3).callable() or {
        vphp.throw_exception('argument 3 must be callable', 0)
        return
    }
    arg_4 := php_args.at(4).null_value() or {
        vphp.throw_exception('argument 4 must be null', 0)
        return
    }
    arg_5 := php_args.at(5).object()
    res := v_php_wrapper_param_api(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_optional_value_api']
fn vphp_wrap_v_php_optional_value_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := if php_args.has(0) { ?vphp.PhpValue(php_args.at(0).value) } else { none }
    res := v_php_optional_value_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_optional_object_api']
fn vphp_wrap_v_php_optional_object_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'obj' },
    ])
    arg_0 := php_args.at(0).object()
    res := v_php_optional_object_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_return_value_api']
fn vphp_wrap_v_php_return_value_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).value
    res := v_php_return_value_api(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}

@[export: 'vphp_wrap_v_php_return_array_api']
fn vphp_wrap_v_php_return_array_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'arr' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := v_php_return_array_api(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}

@[export: 'vphp_wrap_v_php_return_object_api']
fn vphp_wrap_v_php_return_object_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'obj' },
    ])
    arg_0 := php_args.at(0).object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := v_php_return_object_api(arg_0)
    ctx.return().v[vphp.PhpObject](res)
}

@[export: 'vphp_wrap_v_php_return_callable_api']
fn vphp_wrap_v_php_return_callable_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callable' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    res := v_php_return_callable_api(arg_0)
    ctx.return().v[vphp.PhpCallable](res)
}

@[export: 'vphp_wrap_v_php_return_string_wrapper_api']
fn vphp_wrap_v_php_return_string_wrapper_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).string_value() or {
        vphp.throw_exception('argument 0 must be string', 0)
        return
    }
    res := v_php_return_string_wrapper_api(arg_0)
    ctx.return().v[vphp.PhpString](res)
}

@[export: 'vphp_wrap_v_php_return_persistent_array_api']
fn vphp_wrap_v_php_return_persistent_array_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'arr' },
    ])
    arg_0 := php_args.at(0).array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := v_php_return_persistent_array_api(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}

@[export: 'vphp_wrap_v_dyn_value_runtime_refs']
fn vphp_wrap_v_dyn_value_runtime_refs(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rawObj' },
        vphp.PhpArgMeta{ index: 1, name: 'callback' },
        vphp.PhpArgMeta{ index: 2, name: 'rawRes' },
    ])
    arg_0 := php_args.at(0).zval()
    arg_1 := php_args.at(1).zval()
    arg_2 := php_args.at(2).zval()
    res := v_dyn_value_runtime_refs(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_reference_api']
fn vphp_wrap_v_php_reference_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_reference_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_step_reference']
fn vphp_wrap_v_step_reference(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'step' },
        vphp.PhpArgMeta{ index: 1, name: 'cursor' },
    ])
    arg_0 := php_args.at(0).as_v[int]()
    arg_1 := php_args.at(1).reference() or {
        vphp.throw_exception('argument 1 must be reference', 0)
        return
    }
    v_step_reference(arg_0, arg_1)
}

@[export: 'vphp_wrap_v_optional_reference']
fn vphp_wrap_v_optional_reference(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'cursor' },
        vphp.PhpArgMeta{ index: 1, name: 'label' },
    ])
    arg_0 := php_args.at(0).reference()
    arg_1 := php_args.at(1).as_v_opt[string]()
    res := v_optional_reference(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_step_references']
fn vphp_wrap_v_step_references(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    if !ctx.reject_named_variadic_args() {
        return
    }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'step' },
        vphp.PhpArgMeta{ index: 1, name: 'cursors' },
    ])
    arg_0 := php_args.at(0).as_v[int]()
    arg_1 := php_args.variadic_references(1) or {
        vphp.PhpException.raise_class('TypeError', err.msg(), 0)
        return
    }
    res := v_step_references(arg_0, ...arg_1)
    ctx.return().v[int](res)
}

@[export: 'vphp_wrap_v_replace_reference']
fn vphp_wrap_v_replace_reference(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'target' },
        vphp.PhpArgMeta{ index: 1, name: 'replacement' },
    ])
    arg_0 := php_args.at(0).reference() or {
        vphp.throw_exception('argument 0 must be reference', 0)
        return
    }
    arg_1 := php_args.at(1).zval()
    v_replace_reference(arg_0, arg_1)
}

@[export: 'vphp_wrap_v_php_iterable_api']
fn vphp_wrap_v_php_iterable_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_iterable_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_superglobals_api']
fn vphp_wrap_v_php_superglobals_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_php_superglobals_api()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_throwable_api']
fn vphp_wrap_v_php_throwable_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_throwable_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_enum_api']
fn vphp_wrap_v_php_enum_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_php_enum_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_unified_ownership_interop']
fn vphp_wrap_v_unified_ownership_interop(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_unified_ownership_interop(arg_0)
}

@[export: 'vphp_wrap_v_read_php_global_const']
fn vphp_wrap_v_read_php_global_const(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_read_php_global_const(arg_0)
}

@[export: 'vphp_wrap_v_php_symbol_exists']
fn vphp_wrap_v_php_symbol_exists(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_symbol_exists(arg_0)
}

@[export: 'vphp_wrap_v_include_php_file']
fn vphp_wrap_v_include_php_file(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_include_php_file(arg_0)
}

@[export: 'vphp_wrap_v_include_php_file_once']
fn vphp_wrap_v_include_php_file_once(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_include_php_file_once(arg_0)
}

@[export: 'vphp_wrap_v_include_php_module_demo']
fn vphp_wrap_v_include_php_module_demo(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_include_php_module_demo(arg_0)
}

@[export: 'vphp_wrap_v_php_object_meta']
fn vphp_wrap_v_php_object_meta(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_object_meta(arg_0)
}

@[export: 'vphp_wrap_v_php_object_introspection']
fn vphp_wrap_v_php_object_introspection(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_object_introspection(arg_0)
}

@[export: 'vphp_wrap_v_php_array_introspection']
fn vphp_wrap_v_php_array_introspection(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_array_introspection(arg_0)
}

@[export: 'vphp_wrap_v_php_object_probe']
fn vphp_wrap_v_php_object_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_object_probe(arg_0)
}

@[export: 'vphp_wrap_v_trigger_user_action']
fn vphp_wrap_v_trigger_user_action(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_trigger_user_action(arg_0)
}

@[export: 'vphp_wrap_v_call_php_closure']
fn vphp_wrap_v_call_php_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_call_php_closure(arg_0)
}

@[export: 'vphp_wrap_v_call_php_closure_helper']
fn vphp_wrap_v_call_php_closure_helper(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_call_php_closure_helper(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_test_globals']
fn vphp_wrap_v_test_globals(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_test_globals(arg_0)
}

__global C.struct_closure_arginfo_v_get_v_closure voidptr

pub type VPhpVariadicClosureVGetVClosure = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_v_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVClosure(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_v_closure(ctx vphp.Context, cb VPhpVariadicClosureVGetVClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVClosure](cb, vphp_variadic_closure_bridge_v_get_v_closure, 1, 0, C.struct_closure_arginfo_v_get_v_closure)
}

@[export: 'vphp_wrap_v_get_v_closure']
fn vphp_wrap_v_get_v_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_v_closure()
    vphp_wrap_variadic_closure_v_get_v_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_v_closure_auto voidptr

pub type VPhpVariadicClosureVGetVClosureAuto = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_v_closure_auto(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVClosureAuto(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_v_closure_auto(ctx vphp.Context, cb VPhpVariadicClosureVGetVClosureAuto) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVClosureAuto](cb, vphp_variadic_closure_bridge_v_get_v_closure_auto, 1, 0, C.struct_closure_arginfo_v_get_v_closure_auto)
}

@[export: 'vphp_wrap_v_get_v_closure_auto']
fn vphp_wrap_v_get_v_closure_auto(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_v_closure_auto()
    vphp_wrap_variadic_closure_v_get_v_closure_auto(ctx, res)
}

@[export: 'vphp_wrap_v_iter_helpers_demo']
fn vphp_wrap_v_iter_helpers_demo(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_iter_helpers_demo(arg_0)
}

@[export: 'vphp_wrap_v_iterable_object_demo']
fn vphp_wrap_v_iterable_object_demo(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input' },
    ])
    arg_0 := php_args.at(0).zval()
    res := v_iterable_object_demo(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_reverse_string']
fn vphp_wrap_v_reverse_string(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_reverse_string(arg_0)
}

@[export: 'vphp_wrap_v_logic_main']
fn vphp_wrap_v_logic_main(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_logic_main(arg_0)
}

@[export: 'vphp_wrap_v_invoke_callable']
fn vphp_wrap_v_invoke_callable(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    res := v_invoke_callable(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_invoke_with_arg']
fn vphp_wrap_v_invoke_with_arg(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback' },
        vphp.PhpArgMeta{ index: 1, name: 'value' },
    ])
    arg_0 := php_args.at(0).callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := php_args.at(1).as_v[string]()
    res := v_invoke_with_arg(arg_0, arg_1)
    ctx.return().v[string](res)
}

__global C.struct_closure_arginfo_v_get_closure_0 voidptr

pub type VPhpVariadicClosureVGetClosure0 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_0(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure0(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_0(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure0) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetClosure0](cb, vphp_variadic_closure_bridge_v_get_closure_0, 1, 0, C.struct_closure_arginfo_v_get_closure_0)
}

@[export: 'vphp_wrap_v_get_closure_0']
fn vphp_wrap_v_get_closure_0(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_0()
    vphp_wrap_variadic_closure_v_get_closure_0(ctx, res)
}

__global C.struct_closure_arginfo_v_get_closure_1 voidptr

pub type VPhpVariadicClosureVGetClosure1 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_1(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure1(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_1(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure1) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetClosure1](cb, vphp_variadic_closure_bridge_v_get_closure_1, 1, 0, C.struct_closure_arginfo_v_get_closure_1)
}

@[export: 'vphp_wrap_v_get_closure_1']
fn vphp_wrap_v_get_closure_1(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_1()
    vphp_wrap_variadic_closure_v_get_closure_1(ctx, res)
}

__global C.struct_closure_arginfo_v_get_closure_2 voidptr

pub type VPhpVariadicClosureVGetClosure2 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_2(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure2(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_2(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure2) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetClosure2](cb, vphp_variadic_closure_bridge_v_get_closure_2, 1, 0, C.struct_closure_arginfo_v_get_closure_2)
}

@[export: 'vphp_wrap_v_get_closure_2']
fn vphp_wrap_v_get_closure_2(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_2()
    vphp_wrap_variadic_closure_v_get_closure_2(ctx, res)
}

__global C.struct_closure_arginfo_v_get_closure_3 voidptr

pub type VPhpVariadicClosureVGetClosure3 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_3(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure3(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_3(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure3) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetClosure3](cb, vphp_variadic_closure_bridge_v_get_closure_3, 1, 0, C.struct_closure_arginfo_v_get_closure_3)
}

@[export: 'vphp_wrap_v_get_closure_3']
fn vphp_wrap_v_get_closure_3(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_3()
    vphp_wrap_variadic_closure_v_get_closure_3(ctx, res)
}

__global C.struct_closure_arginfo_v_get_closure_4 voidptr

pub type VPhpVariadicClosureVGetClosure4 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_4(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure4(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_4(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure4) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetClosure4](cb, vphp_variadic_closure_bridge_v_get_closure_4, 1, 0, C.struct_closure_arginfo_v_get_closure_4)
}

@[export: 'vphp_wrap_v_get_closure_4']
fn vphp_wrap_v_get_closure_4(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_4()
    vphp_wrap_variadic_closure_v_get_closure_4(ctx, res)
}

__global C.struct_closure_arginfo_v_get_closure_3_void voidptr

pub type VPhpVariadicClosureVGetClosure3Void = fn (...vphp.ZVal)

fn vphp_variadic_closure_bridge_v_get_closure_3_void(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure3Void(v_ptr))
        ctx.forward_variadic_closure_void[vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_3_void(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure3Void) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetClosure3Void](cb, vphp_variadic_closure_bridge_v_get_closure_3_void, 1, 0, C.struct_closure_arginfo_v_get_closure_3_void)
}

@[export: 'vphp_wrap_v_get_closure_3_void']
fn vphp_wrap_v_get_closure_3_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_3_void()
    vphp_wrap_variadic_closure_v_get_closure_3_void(ctx, res)
}

__global C.struct_closure_arginfo_v_get_closure_4_void voidptr

pub type VPhpVariadicClosureVGetClosure4Void = fn (...vphp.ZVal)

fn vphp_variadic_closure_bridge_v_get_closure_4_void(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure4Void(v_ptr))
        ctx.forward_variadic_closure_void[vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_4_void(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure4Void) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetClosure4Void](cb, vphp_variadic_closure_bridge_v_get_closure_4_void, 1, 0, C.struct_closure_arginfo_v_get_closure_4_void)
}

@[export: 'vphp_wrap_v_get_closure_4_void']
fn vphp_wrap_v_get_closure_4_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_4_void()
    vphp_wrap_variadic_closure_v_get_closure_4_void(ctx, res)
}

__global C.struct_closure_arginfo_v_get_struct_param_closure voidptr

pub type VPhpStructClosureVGetStructParamClosure = fn (StructClosureArgs) string

fn vphp_struct_closure_bridge_v_get_struct_param_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructParamClosure(v_ptr))
        arg_count := ctx.num_args()
        if arg_count < 2 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least 2 arguments', 0)
            return
        }
        field_0 := ctx.closure_arg_to_v[string](0) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (name): ${err.msg()}', 0) }
            return
        }
        field_1 := ctx.closure_arg_to_v[int](1) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (count): ${err.msg()}', 0) }
            return
        }
        args := StructClosureArgs{
            name: field_0
            count: field_1
        }
        ctx.forward_struct_closure[StructClosureArgs, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_param_closure(ctx vphp.Context, cb VPhpStructClosureVGetStructParamClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVGetStructParamClosure](cb, vphp_struct_closure_bridge_v_get_struct_param_closure, 2, 2, C.struct_closure_arginfo_v_get_struct_param_closure)
}

@[export: 'vphp_wrap_v_get_struct_param_closure']
fn vphp_wrap_v_get_struct_param_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_param_closure()
    vphp_wrap_struct_closure_v_get_struct_param_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_struct_default_closure voidptr

pub type VPhpStructClosureVGetStructDefaultClosure = fn (StructClosureDefaults) string

fn vphp_struct_closure_bridge_v_get_struct_default_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructDefaultClosure(v_ptr))
        arg_count := ctx.num_args()
        if arg_count < 1 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least 1 argument', 0)
            return
        }
        field_0 := ctx.closure_arg_to_v[string](0) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (name): ${err.msg()}', 0) }
            return
        }
        field_1 := if arg_count > 1 {
            provided_1 := ctx.closure_arg_to_v[int](1) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (count): ${err.msg()}', 0) }
                return
            }
            provided_1
        } else {
            7
        }
        field_2 := if arg_count > 2 {
            provided_2 := ctx.closure_arg_to_v[bool](2) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 3 (flag): ${err.msg()}', 0) }
                return
            }
            provided_2
        } else {
            true
        }
        field_3 := if arg_count > 3 {
            mut provided_3 := ?string(none)
            if !ctx.arg_val(3).is_null() {
                provided_3 = ctx.closure_arg_to_v[string](3) or {
                    if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 4 (label): ${err.msg()}', 0) }
                    return
                }
            }
            provided_3
        } else {
            none
        }
        field_4 := if arg_count > 4 && !ctx.arg_val(4).is_undef() {
            provided_4 := ctx.closure_arg_to_v[int](4) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 5 (computed): ${err.msg()}', 0) }
                return
            }
            provided_4
        } else {
            defaults := StructClosureDefaults{
            }
            if arg_count > 4 && vphp.has_exception() {
                return
            }
            defaults.computed
        }
        if arg_count <= 4 && vphp.has_exception() {
            return
        }
        args := StructClosureDefaults{
            name: field_0
            count: field_1
            flag: field_2
            label: field_3
            computed: field_4
        }
        ctx.forward_struct_closure[StructClosureDefaults, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_default_closure(ctx vphp.Context, cb VPhpStructClosureVGetStructDefaultClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVGetStructDefaultClosure](cb, vphp_struct_closure_bridge_v_get_struct_default_closure, 5, 1, C.struct_closure_arginfo_v_get_struct_default_closure)
}

@[export: 'vphp_wrap_v_get_struct_default_closure']
fn vphp_wrap_v_get_struct_default_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_default_closure()
    vphp_wrap_struct_closure_v_get_struct_default_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_struct_default_closure_void voidptr

pub type VPhpStructClosureVGetStructDefaultClosureVoid = fn (StructClosureDefaults)

fn vphp_struct_closure_bridge_v_get_struct_default_closure_void(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructDefaultClosureVoid(v_ptr))
        arg_count := ctx.num_args()
        if arg_count < 1 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least 1 argument', 0)
            return
        }
        field_0 := ctx.closure_arg_to_v[string](0) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (name): ${err.msg()}', 0) }
            return
        }
        field_1 := if arg_count > 1 {
            provided_1 := ctx.closure_arg_to_v[int](1) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (count): ${err.msg()}', 0) }
                return
            }
            provided_1
        } else {
            7
        }
        field_2 := if arg_count > 2 {
            provided_2 := ctx.closure_arg_to_v[bool](2) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 3 (flag): ${err.msg()}', 0) }
                return
            }
            provided_2
        } else {
            true
        }
        field_3 := if arg_count > 3 {
            mut provided_3 := ?string(none)
            if !ctx.arg_val(3).is_null() {
                provided_3 = ctx.closure_arg_to_v[string](3) or {
                    if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 4 (label): ${err.msg()}', 0) }
                    return
                }
            }
            provided_3
        } else {
            none
        }
        field_4 := if arg_count > 4 && !ctx.arg_val(4).is_undef() {
            provided_4 := ctx.closure_arg_to_v[int](4) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 5 (computed): ${err.msg()}', 0) }
                return
            }
            provided_4
        } else {
            defaults := StructClosureDefaults{
            }
            if arg_count > 4 && vphp.has_exception() {
                return
            }
            defaults.computed
        }
        if arg_count <= 4 && vphp.has_exception() {
            return
        }
        args := StructClosureDefaults{
            name: field_0
            count: field_1
            flag: field_2
            label: field_3
            computed: field_4
        }
        ctx.forward_struct_closure_void[StructClosureDefaults](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_default_closure_void(ctx vphp.Context, cb VPhpStructClosureVGetStructDefaultClosureVoid) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVGetStructDefaultClosureVoid](cb, vphp_struct_closure_bridge_v_get_struct_default_closure_void, 5, 1, C.struct_closure_arginfo_v_get_struct_default_closure_void)
}

@[export: 'vphp_wrap_v_get_struct_default_closure_void']
fn vphp_wrap_v_get_struct_default_closure_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_default_closure_void()
    vphp_wrap_struct_closure_v_get_struct_default_closure_void(ctx, res)
}

__global C.struct_closure_arginfo_v_get_struct_computed_defaults_closure voidptr

pub type VPhpStructClosureVGetStructComputedDefaultsClosure = fn (StructClosureComputedDefaults) string

fn vphp_struct_closure_bridge_v_get_struct_computed_defaults_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructComputedDefaultsClosure(v_ptr))
        arg_count := ctx.num_args()
        if arg_count < 1 {
            vphp.PhpException.raise_class('ArgumentCountError', 'closure requires at least 1 argument', 0)
            return
        }
        field_0 := ctx.closure_arg_to_v[string](0) or {
            if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (name): ${err.msg()}', 0) }
            return
        }
        field_1 := if arg_count > 1 && !ctx.arg_val(1).is_undef() {
            provided_1 := ctx.closure_arg_to_v[int](1) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (first): ${err.msg()}', 0) }
                return
            }
            provided_1
        } else {
            defaults := StructClosureComputedDefaults{
                second: none
            }
            if arg_count > 1 && vphp.has_exception() {
                return
            }
            defaults.first
        }
        field_2 := if arg_count > 2 && !ctx.arg_val(2).is_undef() {
            mut provided_2 := ?int(none)
            if !ctx.arg_val(2).is_null() {
                provided_2 = ctx.closure_arg_to_v[int](2) or {
                    if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 3 (second): ${err.msg()}', 0) }
                    return
                }
            }
            provided_2
        } else {
            defaults := StructClosureComputedDefaults{
                first: int(0)
            }
            if arg_count > 2 && vphp.has_exception() {
                return
            }
            defaults.second
        }
        field_3 := if arg_count > 3 {
            provided_3 := ctx.closure_arg_to_v[bool](3) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 4 (flag): ${err.msg()}', 0) }
                return
            }
            provided_3
        } else {
            true
        }
        if arg_count <= 2 && vphp.has_exception() {
            return
        }
        args := StructClosureComputedDefaults{
            name: field_0
            first: field_1
            second: field_2
            flag: field_3
        }
        ctx.forward_struct_closure[StructClosureComputedDefaults, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_computed_defaults_closure(ctx vphp.Context, cb VPhpStructClosureVGetStructComputedDefaultsClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVGetStructComputedDefaultsClosure](cb, vphp_struct_closure_bridge_v_get_struct_computed_defaults_closure, 4, 1, C.struct_closure_arginfo_v_get_struct_computed_defaults_closure)
}

@[export: 'vphp_wrap_v_get_struct_computed_defaults_closure']
fn vphp_wrap_v_get_struct_computed_defaults_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_computed_defaults_closure()
    vphp_wrap_struct_closure_v_get_struct_computed_defaults_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_struct_native_defaults_closure voidptr

pub type VPhpStructClosureVGetStructNativeDefaultsClosure = fn (StructClosureNativeDefaults) string

fn vphp_struct_closure_bridge_v_get_struct_native_defaults_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructNativeDefaultsClosure(v_ptr))
        arg_count := ctx.num_args()
        field_0 := if arg_count > 0 && !ctx.arg_val(0).is_undef() {
            provided_0 := ctx.closure_arg_to_v[NativeClosurePayload](0) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (payload): ${err.msg()}', 0) }
                return
            }
            provided_0
        } else {
            defaults := StructClosureNativeDefaults{
            }
            if arg_count > 0 && vphp.has_exception() {
                return
            }
            defaults.payload
        }
        field_1 := if arg_count > 1 {
            provided_1 := ctx.closure_arg_to_v[string](1) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (label): ${err.msg()}', 0) }
                return
            }
            provided_1
        } else {
            'trailing'
        }
        if arg_count <= 0 && vphp.has_exception() {
            return
        }
        args := StructClosureNativeDefaults{
            payload: field_0
            label: field_1
        }
        ctx.forward_struct_closure[StructClosureNativeDefaults, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_native_defaults_closure(ctx vphp.Context, cb VPhpStructClosureVGetStructNativeDefaultsClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVGetStructNativeDefaultsClosure](cb, vphp_struct_closure_bridge_v_get_struct_native_defaults_closure, 2, 0, C.struct_closure_arginfo_v_get_struct_native_defaults_closure)
}

@[export: 'vphp_wrap_v_get_struct_native_defaults_closure']
fn vphp_wrap_v_get_struct_native_defaults_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_native_defaults_closure()
    vphp_wrap_struct_closure_v_get_struct_native_defaults_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_struct_failing_defaults_closure voidptr

pub type VPhpStructClosureVGetStructFailingDefaultsClosure = fn (StructClosureFailingDefaults) string

fn vphp_struct_closure_bridge_v_get_struct_failing_defaults_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructFailingDefaultsClosure(v_ptr))
        arg_count := ctx.num_args()
        field_0 := if arg_count > 0 && !ctx.arg_val(0).is_undef() {
            provided_0 := ctx.closure_arg_to_v[int](0) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (first): ${err.msg()}', 0) }
                return
            }
            provided_0
        } else {
            defaults := StructClosureFailingDefaults{
                second: int(0)
            }
            if arg_count > 0 && vphp.has_exception() {
                return
            }
            defaults.first
        }
        field_1 := if arg_count > 1 && !ctx.arg_val(1).is_undef() {
            provided_1 := ctx.closure_arg_to_v[int](1) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (second): ${err.msg()}', 0) }
                return
            }
            provided_1
        } else {
            defaults := StructClosureFailingDefaults{
                first: int(0)
            }
            if arg_count > 1 && vphp.has_exception() {
                return
            }
            defaults.second
        }
        field_2 := if arg_count > 2 {
            provided_2 := ctx.closure_arg_to_v[bool](2) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 3 (tail): ${err.msg()}', 0) }
                return
            }
            provided_2
        } else {
            true
        }
        if arg_count <= 1 && vphp.has_exception() {
            return
        }
        args := StructClosureFailingDefaults{
            first: field_0
            second: field_1
            tail: field_2
        }
        ctx.forward_struct_closure[StructClosureFailingDefaults, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_failing_defaults_closure(ctx vphp.Context, cb VPhpStructClosureVGetStructFailingDefaultsClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVGetStructFailingDefaultsClosure](cb, vphp_struct_closure_bridge_v_get_struct_failing_defaults_closure, 3, 0, C.struct_closure_arginfo_v_get_struct_failing_defaults_closure)
}

@[export: 'vphp_wrap_v_get_struct_failing_defaults_closure']
fn vphp_wrap_v_get_struct_failing_defaults_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_failing_defaults_closure()
    vphp_wrap_struct_closure_v_get_struct_failing_defaults_closure(ctx, res)
}

@[export: 'vphp_wrap_v_invoke_legacy_struct_closure']
fn vphp_wrap_v_invoke_legacy_struct_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_invoke_legacy_struct_closure(arg_0)
}

@[export: 'vphp_wrap_v_invoke_legacy_struct_closure_void']
fn vphp_wrap_v_invoke_legacy_struct_closure_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_invoke_legacy_struct_closure_void(arg_0)
}

__global C.struct_closure_arginfo_v_get_variadic_value_closure voidptr

pub type VPhpVariadicClosureVGetVariadicValueClosure = fn (...vphp.PhpValue) string

fn vphp_variadic_closure_bridge_v_get_variadic_value_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicValueClosure(v_ptr))
        ctx.forward_variadic_closure[vphp.PhpValue, string](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_value_closure(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicValueClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVariadicValueClosure](cb, vphp_variadic_closure_bridge_v_get_variadic_value_closure, 1, 0, C.struct_closure_arginfo_v_get_variadic_value_closure)
}

@[export: 'vphp_wrap_v_get_variadic_value_closure']
fn vphp_wrap_v_get_variadic_value_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_value_closure()
    vphp_wrap_variadic_closure_v_get_variadic_value_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_variadic_zval_closure voidptr

pub type VPhpVariadicClosureVGetVariadicZvalClosure = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_variadic_zval_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicZvalClosure(v_ptr))
        ctx.forward_variadic_closure[vphp.ZVal, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_zval_closure(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicZvalClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVariadicZvalClosure](cb, vphp_variadic_closure_bridge_v_get_variadic_zval_closure, 1, 0, C.struct_closure_arginfo_v_get_variadic_zval_closure)
}

@[export: 'vphp_wrap_v_get_variadic_zval_closure']
fn vphp_wrap_v_get_variadic_zval_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_zval_closure()
    vphp_wrap_variadic_closure_v_get_variadic_zval_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_variadic_zval_void voidptr

pub type VPhpVariadicClosureVGetVariadicZvalVoid = fn (...vphp.ZVal)

fn vphp_variadic_closure_bridge_v_get_variadic_zval_void(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicZvalVoid(v_ptr))
        ctx.forward_variadic_closure_void[vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_zval_void(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicZvalVoid) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVariadicZvalVoid](cb, vphp_variadic_closure_bridge_v_get_variadic_zval_void, 1, 0, C.struct_closure_arginfo_v_get_variadic_zval_void)
}

@[export: 'vphp_wrap_v_get_variadic_zval_void']
fn vphp_wrap_v_get_variadic_zval_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_zval_void()
    vphp_wrap_variadic_closure_v_get_variadic_zval_void(ctx, res)
}

__global C.struct_closure_arginfo_v_get_variadic_borrowed_closure voidptr

pub type VPhpVariadicClosureVGetVariadicBorrowedClosure = fn (...vphp.RequestBorrowedZBox) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_variadic_borrowed_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicBorrowedClosure(v_ptr))
        ctx.forward_variadic_closure[vphp.RequestBorrowedZBox, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_borrowed_closure(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicBorrowedClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVariadicBorrowedClosure](cb, vphp_variadic_closure_bridge_v_get_variadic_borrowed_closure, 1, 0, C.struct_closure_arginfo_v_get_variadic_borrowed_closure)
}

@[export: 'vphp_wrap_v_get_variadic_borrowed_closure']
fn vphp_wrap_v_get_variadic_borrowed_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_borrowed_closure()
    vphp_wrap_variadic_closure_v_get_variadic_borrowed_closure(ctx, res)
}

__global C.struct_closure_arginfo_v_get_variadic_scalar_string voidptr

pub type VPhpVariadicClosureVGetVariadicScalarString = fn (...vphp.VScalarValue) string

fn vphp_variadic_closure_bridge_v_get_variadic_scalar_string(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicScalarString(v_ptr))
        ctx.forward_variadic_closure[vphp.VScalarValue, string](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_scalar_string(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicScalarString) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVariadicScalarString](cb, vphp_variadic_closure_bridge_v_get_variadic_scalar_string, 1, 0, C.struct_closure_arginfo_v_get_variadic_scalar_string)
}

@[export: 'vphp_wrap_v_get_variadic_scalar_string']
fn vphp_wrap_v_get_variadic_scalar_string(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_scalar_string()
    vphp_wrap_variadic_closure_v_get_variadic_scalar_string(ctx, res)
}

__global C.struct_closure_arginfo_v_get_variadic_scalar_i64 voidptr

pub type VPhpVariadicClosureVGetVariadicScalarI64 = fn (...vphp.VScalarValue) i64

fn vphp_variadic_closure_bridge_v_get_variadic_scalar_i64(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicScalarI64(v_ptr))
        ctx.forward_variadic_closure[vphp.VScalarValue, i64](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_scalar_i64(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicScalarI64) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVariadicScalarI64](cb, vphp_variadic_closure_bridge_v_get_variadic_scalar_i64, 1, 0, C.struct_closure_arginfo_v_get_variadic_scalar_i64)
}

@[export: 'vphp_wrap_v_get_variadic_scalar_i64']
fn vphp_wrap_v_get_variadic_scalar_i64(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_scalar_i64()
    vphp_wrap_variadic_closure_v_get_variadic_scalar_i64(ctx, res)
}

__global C.struct_closure_arginfo_v_get_variadic_scalar_value voidptr

pub type VPhpVariadicClosureVGetVariadicScalarValue = fn (...vphp.VScalarValue) vphp.VScalarValue

fn vphp_variadic_closure_bridge_v_get_variadic_scalar_value(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicScalarValue(v_ptr))
        ctx.forward_variadic_closure[vphp.VScalarValue, vphp.VScalarValue](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_scalar_value(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicScalarValue) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpVariadicClosureVGetVariadicScalarValue](cb, vphp_variadic_closure_bridge_v_get_variadic_scalar_value, 1, 0, C.struct_closure_arginfo_v_get_variadic_scalar_value)
}

@[export: 'vphp_wrap_v_get_variadic_scalar_value']
fn vphp_wrap_v_get_variadic_scalar_value(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_scalar_value()
    vphp_wrap_variadic_closure_v_get_variadic_scalar_value(ctx, res)
}

@[export: 'vphp_wrap_v_invoke_legacy_variadic_scalar']
fn vphp_wrap_v_invoke_legacy_variadic_scalar(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_invoke_legacy_variadic_scalar(arg_0)
}

@[export: 'vphp_wrap_v_invoke_legacy_variadic_scalar_alias']
fn vphp_wrap_v_invoke_legacy_variadic_scalar_alias(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_invoke_legacy_variadic_scalar_alias(arg_0)
}

@[export: 'vphp_wrap_v_invoke_legacy_variadic_void']
fn vphp_wrap_v_invoke_legacy_variadic_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_invoke_legacy_variadic_void(arg_0)
}

@[export: 'vphp_wrap_v_invoke_legacy_variadic_void_alias']
fn vphp_wrap_v_invoke_legacy_variadic_void_alias(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_invoke_legacy_variadic_void_alias(arg_0)
}

@[export: 'vphp_wrap_v_php_literal_params']
fn vphp_wrap_v_php_literal_params(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message' },
        vphp.PhpArgMeta{ index: 1, name: 'raw' },
        vphp.PhpArgMeta{ index: 2, name: 'octal' },
        vphp.PhpArgMeta{ index: 3, name: 'binary' },
        vphp.PhpArgMeta{ index: 4, name: 'floating' },
        vphp.PhpArgMeta{ index: 5, name: 'single' },
        vphp.PhpArgMeta{ index: 6, name: 'option' },
        vphp.PhpArgMeta{ index: 7, name: 'nullable' },
        vphp.PhpArgMeta{ index: 8, name: 'items' },
        vphp.PhpArgMeta{ index: 9, name: 'empty' },
        vphp.PhpArgMeta{ index: 10, name: 'lookup' },
        vphp.PhpArgMeta{ index: 11, name: 'tail' },
    ])
    arg_0_params_message := if php_args.has(0) { php_args.at(0).as_v[string]() } else { 'a\n\t\x00\xe2\x98\xba\$\'\\"' }
    arg_0_params_raw := if php_args.has(1) { php_args.at(1).as_v[string]() } else { '\\n\${literal}' }
    arg_0_params_octal := if php_args.has(2) { php_args.at(2).as_v[int]() } else { -15 }
    arg_0_params_binary := if php_args.has(3) { php_args.at(3).as_v[i64]() } else { i64(161) }
    arg_0_params_floating := if php_args.has(4) { php_args.at(4).as_v[f64]() } else { 2.0 }
    arg_0_params_single := if php_args.has(5) { php_args.at(5).as_v[f32]() } else { f32(0.1) }
    arg_0_params_option := if php_args.has(6) { php_args.at(6).as_v_opt[string]() } else { ?string('present') }
    arg_0_params_nullable := if php_args.has(7) { php_args.at(7).as_v_opt[int]() } else { none }
    arg_0_params_items := if php_args.has(8) { php_args.at(8).as_v[[]int]() } else { [1, 16] }
    arg_0_params_empty := if php_args.has(9) { php_args.at(9).as_v[[]string]() } else { []string{} }
    arg_0_params_lookup := if php_args.has(10) { php_args.at(10).as_v[map[string]int]() } else { {'count': 16} }
    arg_0_params_tail := if php_args.has(11) { php_args.at(11).as_v[bool]() } else { true }
    arg_0_params := VPhpLiteralParamsDemo{
        message: arg_0_params_message
        raw: arg_0_params_raw
        octal: arg_0_params_octal
        binary: arg_0_params_binary
        floating: arg_0_params_floating
        single: arg_0_params_single
        option: arg_0_params_option
        nullable: arg_0_params_nullable
        items: arg_0_params_items
        empty: arg_0_params_empty
        lookup: arg_0_params_lookup
        tail: arg_0_params_tail
    }
    res := v_php_literal_params(arg_0_params)
    ctx.return().v[string](res)
}

__global C.struct_closure_arginfo_v_get_struct_literal_defaults_closure voidptr

pub type VPhpStructClosureVGetStructLiteralDefaultsClosure = fn (VPhpLiteralParamsDemo) string

fn vphp_struct_closure_bridge_v_get_struct_literal_defaults_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructLiteralDefaultsClosure(v_ptr))
        arg_count := ctx.num_args()
        field_0 := if arg_count > 0 {
            provided_0 := ctx.closure_arg_to_v[string](0) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 1 (message): ${err.msg()}', 0) }
                return
            }
            provided_0
        } else {
            'a\n\t\x00\xe2\x98\xba\$\'\\"'
        }
        field_1 := if arg_count > 1 {
            provided_1 := ctx.closure_arg_to_v[string](1) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 2 (raw): ${err.msg()}', 0) }
                return
            }
            provided_1
        } else {
            '\\n\${literal}'
        }
        field_2 := if arg_count > 2 {
            provided_2 := ctx.closure_arg_to_v[int](2) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 3 (octal): ${err.msg()}', 0) }
                return
            }
            provided_2
        } else {
            -15
        }
        field_3 := if arg_count > 3 {
            provided_3 := ctx.closure_arg_to_v[i64](3) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 4 (binary): ${err.msg()}', 0) }
                return
            }
            provided_3
        } else {
            i64(161)
        }
        field_4 := if arg_count > 4 {
            provided_4 := ctx.closure_arg_to_v[f64](4) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 5 (floating): ${err.msg()}', 0) }
                return
            }
            provided_4
        } else {
            2.0
        }
        field_5 := if arg_count > 5 {
            provided_5 := ctx.closure_arg_to_v[f32](5) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 6 (single): ${err.msg()}', 0) }
                return
            }
            provided_5
        } else {
            f32(0.1)
        }
        field_6 := if arg_count > 6 {
            mut provided_6 := ?string(none)
            if !ctx.arg_val(6).is_null() {
                provided_6 = ctx.closure_arg_to_v[string](6) or {
                    if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 7 (option): ${err.msg()}', 0) }
                    return
                }
            }
            provided_6
        } else {
            ?string('present')
        }
        field_7 := if arg_count > 7 {
            mut provided_7 := ?int(none)
            if !ctx.arg_val(7).is_null() {
                provided_7 = ctx.closure_arg_to_v[int](7) or {
                    if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 8 (nullable): ${err.msg()}', 0) }
                    return
                }
            }
            provided_7
        } else {
            none
        }
        field_8 := if arg_count > 8 {
            provided_8 := ctx.closure_arg_to_v[[]int](8) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 9 (items): ${err.msg()}', 0) }
                return
            }
            provided_8
        } else {
            [1, 16]
        }
        field_9 := if arg_count > 9 {
            provided_9 := ctx.closure_arg_to_v[[]string](9) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 10 (empty): ${err.msg()}', 0) }
                return
            }
            provided_9
        } else {
            []string{}
        }
        field_10 := if arg_count > 10 {
            provided_10 := ctx.closure_arg_to_v[map[string]int](10) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 11 (lookup): ${err.msg()}', 0) }
                return
            }
            provided_10
        } else {
            {'count': 16}
        }
        field_11 := if arg_count > 11 {
            provided_11 := ctx.closure_arg_to_v[bool](11) or {
                if !vphp.has_exception() { vphp.PhpException.raise_class('TypeError', 'argument 12 (tail): ${err.msg()}', 0) }
                return
            }
            provided_11
        } else {
            true
        }
        args := VPhpLiteralParamsDemo{
            message: field_0
            raw: field_1
            octal: field_2
            binary: field_3
            floating: field_4
            single: field_5
            option: field_6
            nullable: field_7
            items: field_8
            empty: field_9
            lookup: field_10
            tail: field_11
        }
        ctx.forward_struct_closure[VPhpLiteralParamsDemo, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_literal_defaults_closure(ctx vphp.Context, cb VPhpStructClosureVGetStructLiteralDefaultsClosure) {
    ctx.create_typed_saved_closure_with_arginfo[VPhpStructClosureVGetStructLiteralDefaultsClosure](cb, vphp_struct_closure_bridge_v_get_struct_literal_defaults_closure, 12, 0, C.struct_closure_arginfo_v_get_struct_literal_defaults_closure)
}

@[export: 'vphp_wrap_v_get_struct_literal_defaults_closure']
fn vphp_wrap_v_get_struct_literal_defaults_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_literal_defaults_closure()
    vphp_wrap_struct_closure_v_get_struct_literal_defaults_closure(ctx, res)
}

@[export: 'vphp_wrap_v_php_overridden_params']
fn vphp_wrap_v_php_overridden_params(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
        vphp.PhpArgMeta{ index: 1, name: 'option', use_php_default: true },
        vphp.PhpArgMeta{ index: 2, name: 'spacer' },
        vphp.PhpArgMeta{ index: 3, name: 'count', use_php_default: true },
        vphp.PhpArgMeta{ index: 4, name: 'nullable', use_php_default: true },
        vphp.PhpArgMeta{ index: 5, name: 'items', use_php_default: true },
        vphp.PhpArgMeta{ index: 6, name: 'tail' },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1_params_option := php_args.at(1).as_v_opt[string]()
    arg_1_params_spacer := if php_args.has(2) { php_args.at(2).as_v[string]() } else { 'native spacer' }
    arg_1_params_count := php_args.at(3).as_v[int]()
    arg_1_params_nullable := php_args.at(4).as_v_opt[string]()
    arg_1_params_items := php_args.at(5).array() or {
        vphp.throw_exception('argument 5 must be array', 0)
        return
    }
    arg_1_params_tail := if php_args.has(6) { php_args.at(6).as_v[bool]() } else { true }
    arg_1_params := VPhpOverriddenParamsDemo{
        option: arg_1_params_option
        spacer: arg_1_params_spacer
        count: arg_1_params_count
        nullable: arg_1_params_nullable
        items: arg_1_params_items
        tail: arg_1_params_tail
    }
    res := v_php_overridden_params(arg_0, arg_1_params)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_direct_defaults']
fn vphp_wrap_v_php_direct_defaults(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
        vphp.PhpArgMeta{ index: 1, name: 'count', use_php_default: true },
        vphp.PhpArgMeta{ index: 2, name: 'values', use_php_default: true },
        vphp.PhpArgMeta{ index: 3, name: 'label', use_php_default: true },
        vphp.PhpArgMeta{ index: 4, name: 'enabled', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[int]()
    arg_2 := php_args.at(2).array()
    arg_3 := php_args.at(3).as_v_opt[string]()
    arg_4 := php_args.at(4).as_v[bool]()
    res := v_php_direct_defaults(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_legacy_optional_tail']
fn vphp_wrap_v_php_legacy_optional_tail(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'before', use_php_default: true },
        vphp.PhpArgMeta{ index: 1, name: 'blocked' },
        vphp.PhpArgMeta{ index: 2, name: 'tail' },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[int]()
    arg_1 := php_args.at(1).as_v[int]()
    arg_2 := php_args.at(2).as_v[int]()
    res := v_php_legacy_optional_tail(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_lifecycle_hook_state']
fn vphp_wrap_v_lifecycle_hook_state(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_lifecycle_hook_state()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_test_concurrent_object_roots']
fn vphp_wrap_v_test_concurrent_object_roots(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := test_concurrent_object_roots()
    ctx.return().v[bool](res)
}

@[export: 'vphp_wrap_v_find_after']
fn vphp_wrap_v_find_after(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'haystack' },
        vphp.PhpArgMeta{ index: 1, name: 'needle' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    ctx.return().from_option[string](fn [arg_0, arg_1] () ?string {
        return v_find_after(arg_0, arg_1)
    })
}

@[export: 'vphp_wrap_v_try_divide']
fn vphp_wrap_v_try_divide(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'a' },
        vphp.PhpArgMeta{ index: 1, name: 'b' },
    ])
    arg_0 := php_args.at(0).as_v[int]()
    arg_1 := php_args.at(1).as_v[int]()
    ctx.return().from_option[int](fn [arg_0, arg_1] () ?int {
        return v_try_divide(arg_0, arg_1)
    })
}

@[export: 'vphp_wrap_v_record_match']
fn vphp_wrap_v_record_match(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path' },
        vphp.PhpArgMeta{ index: 1, name: 'haystack' },
        vphp.PhpArgMeta{ index: 2, name: 'needle' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    ctx.return().from_option_void(fn [arg_0, arg_1, arg_2] () ? {
        v_record_match(arg_0, arg_1, arg_2)
    })
}

@[export: 'vphp_wrap_v_typed_raw_string_param']
fn vphp_wrap_v_typed_raw_string_param(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'text', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    res := v_typed_raw_string_param(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_typed_alias_bool_param']
fn vphp_wrap_v_typed_alias_bool_param(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'enabled', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[bool]()
    res := v_typed_alias_bool_param(arg_0)
    ctx.return().v[bool](res)
}

@[export: 'vphp_wrap_v_typed_bool_params']
fn vphp_wrap_v_typed_bool_params(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'firstFlag', use_php_default: true },
        vphp.PhpArgMeta{ index: 1, name: 'secondFlag', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[bool]()
    arg_1 := php_args.at(1).as_v[bool]()
    res := v_typed_bool_params(arg_0, arg_1)
    ctx.return().v[int](res)
}

@[export: 'vphp_wrap_v_compiler_probe']
fn vphp_wrap_v_compiler_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_compiler_probe()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_compiler_probe_named_sum']
fn vphp_wrap_v_compiler_probe_named_sum(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).as_v_opt[VphpModuleProbeSumType]()
    ctx.return().from_option[VphpModuleProbeSumType](fn [arg_0] () ?VphpModuleProbeSumType {
        return v_compiler_probe_named_sum(arg_0)
    })
}

@[export: 'vphp_wrap_v_compiler_probe_explicit_union']
fn vphp_wrap_v_compiler_probe_explicit_union(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).value
    res := v_compiler_probe_explicit_union(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}

@[export: 'vphp_wrap_v_compiler_probe_intersection']
fn vphp_wrap_v_compiler_probe_intersection(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value' },
    ])
    arg_0 := php_args.at(0).value
    res := v_compiler_probe_intersection(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}

@[export: 'vphp_wrap_v_compiler_probe_wrong_dnf_return']
fn vphp_wrap_v_compiler_probe_wrong_dnf_return(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_compiler_probe_wrong_dnf_return()
    ctx.return().v[vphp.PhpValue](res)
}

@[export: 'vphp_wrap_v_compiler_probe_variadic']
fn vphp_wrap_v_compiler_probe_variadic(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    if !ctx.reject_named_variadic_args() {
        return
    }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'args' },
    ])
    arg_0 := php_args.as_variadic_v[int](0)
    res := v_compiler_probe_variadic(...arg_0)
    ctx.return().v[int](res)
}

@[export: 'vphp_wrap_v_compiler_probe_options']
fn vphp_wrap_v_compiler_probe_options(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
        vphp.PhpArgMeta{ index: 1, name: 'count' },
    ])
    arg_0_params_prefix := if php_args.has(0) { php_args.at(0).as_v[string]() } else { 'default' }
    arg_0_params_count := if php_args.has(1) { php_args.at(1).as_v[int]() } else { 3 }
    arg_0_params := VphpModuleProbeOptions{
        prefix: arg_0_params_prefix
        count: arg_0_params_count
    }
    res := v_compiler_probe_options(arg_0_params)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_typed_string_param']
fn vphp_wrap_v_typed_string_param(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_php_defaults([
        vphp.PhpArgMeta{ index: 0, name: 'prefix' },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', use_php_default: true },
        vphp.PhpArgMeta{ index: 2, name: 'suffix', use_php_default: true },
    ]) or {
        return
    }
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    arg_2 := php_args.at(2).as_v[string]()
    res := v_typed_string_param(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_typed_required_string_param']
fn vphp_wrap_v_typed_required_string_param(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'text' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    res := v_typed_required_string_param(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_new_coach']
fn vphp_wrap_v_new_coach(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_new_coach(arg_0)
}

@[export: 'vphp_wrap_v_new_db']
fn vphp_wrap_v_new_db(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_new_db(arg_0)
}

@[export: 'vphp_wrap_v_check_res']
fn vphp_wrap_v_check_res(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_check_res(arg_0)
}

@[export: 'vphp_wrap_v_safe_divide']
fn vphp_wrap_v_safe_divide(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'a' },
        vphp.PhpArgMeta{ index: 1, name: 'b' },
    ])
    arg_0 := php_args.at(0).as_v[int]()
    arg_1 := php_args.at(1).as_v[int]()
    ctx.return().from_result[int](fn [arg_0, arg_1] () !int {
        return v_safe_divide(arg_0, arg_1)!
    })
}

@[export: 'vphp_wrap_v_capitalize']
fn vphp_wrap_v_capitalize(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    ctx.return().from_result[string](fn [arg_0] () !string {
        return v_capitalize(arg_0)!
    })
}

@[export: 'vphp_wrap_v_record_success']
fn vphp_wrap_v_record_success(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path' },
        vphp.PhpArgMeta{ index: 1, name: 'label' },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[string]()
    ctx.return().from_result_void(fn [arg_0, arg_1] () ! {
        v_record_success(arg_0, arg_1)!
    })
}

@[export: 'vphp_wrap_v_php_param_attr_api']
fn vphp_wrap_v_php_param_attr_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'query', attributes: [vphp.PhpAttribute.named('FromQuery').for_parameter().string('q'), vphp.PhpAttribute.named('MustBeString').for_parameter()] },
        vphp.PhpArgMeta{ index: 1, name: 'page', attributes: [vphp.PhpAttribute.named('FromQuery').for_parameter().string('page'), vphp.PhpAttribute.named('MustBeInt').for_parameter()] },
    ])
    arg_0 := php_args.at(0).as_v[string]()
    arg_1 := php_args.at(1).as_v[int]()
    res := v_php_param_attr_api(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_arg_attr_runtime_api']
fn vphp_wrap_v_php_arg_attr_runtime_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_php_arg_attr_runtime_api(arg_0)
}

@[export: 'vphp_wrap_v_analyze_fitness_data']
fn vphp_wrap_v_analyze_fitness_data(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_analyze_fitness_data(arg_0)
}

@[export: 'vphp_wrap_v_get_alerts']
fn vphp_wrap_v_get_alerts(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    v_get_alerts(arg_0)
}

fn vphp_get_class_entry_by_v_name(v_name string) voidptr {
    return match v_name {
        'AbstractReport' { C.abstractreport_ce }
        'DailyReport' { C.dailyreport_ce }
        'Author' { C.author_ce }
        'Post' { C.post_ce }
        'Article' { C.article_ce }
        'Story' { C.story_ce }
        'interface:main.ContentContract' { C.contentcontract_ce }
        'interface:main.NamedContract' { C.demo__contracts__namedcontract_ce }
        'interface:main.AliasContract' { C.demo__contracts__aliascontract_ce }
        'AliasBase' { C.demo__contracts__aliasbase_ce }
        'AliasWorker' { C.aliasworker_ce }
        'RuntimeDemoBaseException' { C.runtimedemo__baseexception_ce }
        'RuntimeDemoChildException' { C.runtimedemo__childexception_ce }
        'CallableProcessor' { C.callableprocessor_ce }
        'Finder' { C.finder_ce }
        'ReadonlyRecord' { C.readonlyrecord_ce }
        'interface:main.VphpModuleProbeContract' { C.vphp__compiler__moduleprobecontract_ce }
        'VphpModuleProbeKind' { C.vphp__compiler__moduleprobekind_ce }
        'VphpOtherProbeKind' { C.vphp__compiler__otherprobekind_ce }
        'VphpModuleProbeReadOnlyBox' { C.vphp__compiler__moduleprobereadonlybox_ce }
        'VphpModuleProbeBox' { C.vphp__compiler__moduleprobebox_ce }
        'VphpCopyableBox' { C.vphp__compiler__copyablebox_ce }
        'VphpTaggedBox' { C.vphp__compiler__taggedbox_ce }
        'VphpNumberedBox' { C.vphp__compiler__numberedbox_ce }
        'VphpModuleProbeTypedConsts' { C.vphp__compiler__moduleprobetypedconsts_ce }
        'VphpModuleProbeWrapperBox' { C.vphp__compiler__moduleprobewrapperbox_ce }
        'TraitPost' { C.traitpost_ce }
        'Validator' { C.validator_ce }
        'DispatchableSample' { C.dispatchablesample_ce }
        'ArticleStatus' { C.articlestatus_ce }
        'VPhpTask' { C.vphp__task_ce }
        'StringableBox' { C.stringablebox_ce }
        else { unsafe { nil } }
    }
}

@[export: 'vphp_ext_auto_startup']
fn vphp_ext_auto_startup() {
    vphp.register_auto_interface_binding('AliasWorker', 'RuntimeContracts\\Greeter')

    vphp.register_class_entry_lookup(vphp_get_class_entry_by_v_name)

    vphp.ITask.register('AnalyzeTask', fn (args []vphp.ZVal) vphp.ITask {
        return AnalyzeTask{
            symbol: args[0].to_v[string]() or { '' }
            count: args[1].to_v[int]() or { 0 }
        }
    })
}
