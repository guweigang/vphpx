module main

import vphp

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
__global C.traitpost_ce &C.zend_class_entry
__global C.validator_ce &C.zend_class_entry
__global C.dispatchablesample_ce &C.zend_class_entry
__global C.articlestatus_ce &C.zend_class_entry
__global C.vphp__task_ce &C.zend_class_entry
__global C.stringablebox_ce &C.zend_class_entry

@[export: 'AbstractReport_new_raw']
pub fn abstractreport_new_raw() voidptr {
    return vphp.generic_new_raw[AbstractReport]()
}
@[export: 'AbstractReport_free_raw']
pub fn abstractreport_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[AbstractReport](ptr)
}
@[export: 'AbstractReport_cleanup_raw']
pub fn abstractreport_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'AbstractReport_get_prop']
pub fn abstractreport_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'AbstractReport_set_prop']
pub fn abstractreport_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'AbstractReport_sync_props']
pub fn abstractreport_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &AbstractReport(ptr)
        out.add_property_string('title', obj.title)
    }
}
@[export: 'vphp_wrap_AbstractReport_label']
pub fn vphp_wrap_abstractreport_label(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AbstractReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.label()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_AbstractReport_summarize']
pub fn vphp_wrap_abstractreport_summarize(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AbstractReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.summarize()
    ctx.return().v[string](res)
}
@[export: 'AbstractReport_handlers']
pub fn abstractreport_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(abstractreport_get_prop),
        write_handler: voidptr(abstractreport_set_prop),
        sync_handler: voidptr(abstractreport_sync_props),
        new_raw: voidptr(abstractreport_new_raw),
        cleanup_raw: voidptr(abstractreport_cleanup_raw),
        free_raw: voidptr(abstractreport_free_raw)
    )
}
pub fn AbstractReport.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.abstractreport_ce)
}

pub fn AbstractReport.php_object_handlers() voidptr {
    return abstractreport_handlers()
}

pub fn AbstractReport.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[AbstractReport]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &AbstractReport) bind_php_object() vphp.ZVal {
    return AbstractReport.php_object_zval(obj, .borrowed)
}

pub fn (obj &AbstractReport) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &AbstractReport) bind_owned_php_object() vphp.ZVal {
    return AbstractReport.php_object_zval(obj, .owned_request)
}

pub fn (obj &AbstractReport) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'DailyReport_new_raw']
pub fn dailyreport_new_raw() voidptr {
    return vphp.generic_new_raw[DailyReport]()
}
@[export: 'DailyReport_free_raw']
pub fn dailyreport_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[DailyReport](ptr)
}
@[export: 'DailyReport_cleanup_raw']
pub fn dailyreport_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'DailyReport_get_prop']
pub fn dailyreport_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'DailyReport_set_prop']
pub fn dailyreport_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'DailyReport_sync_props']
pub fn dailyreport_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &DailyReport(ptr)
        out.add_property_string('summary', obj.summary)
    }
}
@[export: 'vphp_wrap_DailyReport_construct']
pub fn vphp_wrap_dailyreport_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &DailyReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'summary', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'title').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'summary').as_v[string]()
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_DailyReport_summarize']
pub fn vphp_wrap_dailyreport_summarize(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &DailyReport(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.summarize()
    ctx.return().v[string](res)
}
@[export: 'DailyReport_handlers']
pub fn dailyreport_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(dailyreport_get_prop),
        write_handler: voidptr(dailyreport_set_prop),
        sync_handler: voidptr(dailyreport_sync_props),
        new_raw: voidptr(dailyreport_new_raw),
        cleanup_raw: voidptr(dailyreport_cleanup_raw),
        free_raw: voidptr(dailyreport_free_raw)
    )
}
pub fn DailyReport.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.dailyreport_ce)
}

pub fn DailyReport.php_object_handlers() voidptr {
    return dailyreport_handlers()
}

pub fn DailyReport.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[DailyReport]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &DailyReport) bind_php_object() vphp.ZVal {
    return DailyReport.php_object_zval(obj, .borrowed)
}

pub fn (obj &DailyReport) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &DailyReport) bind_owned_php_object() vphp.ZVal {
    return DailyReport.php_object_zval(obj, .owned_request)
}

pub fn (obj &DailyReport) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'Author_new_raw']
pub fn author_new_raw() voidptr {
    return vphp.generic_new_raw[Author]()
}
@[export: 'Author_free_raw']
pub fn author_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Author](ptr)
}
@[export: 'Author_cleanup_raw']
pub fn author_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'Author_get_prop']
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
@[export: 'Author_set_prop']
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
@[export: 'Author_sync_props']
pub fn author_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Author(ptr)
        out.add_property_string('name', obj.name)
    }
}
@[export: 'vphp_wrap_Author_create']
pub fn vphp_wrap_author_create(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := Author.create(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_Author_get_name']
pub fn vphp_wrap_author_get_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Author(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_name()
    ctx.return().v[string](res)
}
@[export: 'Author_handlers']
pub fn author_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(author_get_prop),
        write_handler: voidptr(author_set_prop),
        sync_handler: voidptr(author_sync_props),
        new_raw: voidptr(author_new_raw),
        cleanup_raw: voidptr(author_cleanup_raw),
        free_raw: voidptr(author_free_raw)
    )
}
pub fn Author.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.author_ce)
}

pub fn Author.php_object_handlers() voidptr {
    return author_handlers()
}

pub fn Author.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[Author]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &Author) bind_php_object() vphp.ZVal {
    return Author.php_object_zval(obj, .borrowed)
}

pub fn (obj &Author) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &Author) bind_owned_php_object() vphp.ZVal {
    return Author.php_object_zval(obj, .owned_request)
}

pub fn (obj &Author) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'Post_new_raw']
pub fn post_new_raw() voidptr {
    return vphp.generic_new_raw[Post]()
}
@[export: 'Post_free_raw']
pub fn post_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Post](ptr)
}
@[export: 'Post_cleanup_raw']
pub fn post_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'Post_get_prop']
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
@[export: 'Post_set_prop']
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
@[export: 'Post_sync_props']
pub fn post_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Post(ptr)
        out.add_property_long('post_id', i64(obj.post_id))
    }
}
@[export: 'vphp_wrap_Post_set_author']
pub fn vphp_wrap_post_set_author(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Post(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'author', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &Author(php_args.at_named_or_index(0, 'author').raw_obj()) }
    recv.set_author(arg_0)
}
@[export: 'vphp_wrap_Post_get_author']
pub fn vphp_wrap_post_get_author(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &Post(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_author()
    return voidptr(res)
}
@[export: 'Post_handlers']
pub fn post_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(post_get_prop),
        write_handler: voidptr(post_set_prop),
        sync_handler: voidptr(post_sync_props),
        new_raw: voidptr(post_new_raw),
        cleanup_raw: voidptr(post_cleanup_raw),
        free_raw: voidptr(post_free_raw)
    )
}
pub fn Post.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.post_ce)
}

pub fn Post.php_object_handlers() voidptr {
    return post_handlers()
}

pub fn Post.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[Post]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &Post) bind_php_object() vphp.ZVal {
    return Post.php_object_zval(obj, .borrowed)
}

pub fn (obj &Post) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &Post) bind_owned_php_object() vphp.ZVal {
    return Post.php_object_zval(obj, .owned_request)
}

pub fn (obj &Post) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'Article_new_raw']
pub fn article_new_raw() voidptr {
    return vphp.generic_new_raw[Article]()
}
@[export: 'Article_free_raw']
pub fn article_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Article](ptr)
}
@[export: 'Article_cleanup_raw']
pub fn article_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'Article_get_prop']
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
@[export: 'Article_set_prop']
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
@[export: 'Article_sync_props']
pub fn article_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Article(ptr)
        out.add_property_long('created_at', i64(obj.created_at))
        out.add_property_long('id', i64(obj.id))
        out.add_property_string('title', obj.title)
        out.add_property_bool('is_top', obj.is_top)
    }
}
pub fn Article.consts() ArticleConsts {
    return article_consts
}
pub fn Article.statics() &ArticleStatics {
    return &article_statics
}
pub fn Article.sync_statics_to_php(ctx vphp.Context) {
    ce := ctx.active_class_entry()
    if !ce.is_valid() { return }
    ce.set_static_prop("total_count", article_statics.total_count)
}
pub fn Article.sync_statics_from_php(ctx vphp.Context) {
    ce := ctx.active_class_entry()
    if !ce.is_valid() { return }
    mut s := Article.statics()
    s.total_count = ce.static_prop[int]("total_count")
}
@[export: 'vphp_wrap_Article_construct']
pub fn vphp_wrap_article_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'id', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'title').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'id').as_v[int]()
    Article.sync_statics_from_php(ctx)
    res := recv.construct(arg_0, arg_1)
    Article.sync_statics_to_php(ctx)
    return voidptr(res)
}
@[export: 'vphp_wrap_Article_internal_format']
pub fn vphp_wrap_article_internal_format(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    Article.sync_statics_from_php(ctx)
    res := recv.internal_format()
    Article.sync_statics_to_php(ctx)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_Article_create']
pub fn vphp_wrap_article_create(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'title').as_v[string]()
    Article.sync_statics_from_php(ctx)
    res := Article.create(arg_0)
    Article.sync_statics_to_php(ctx)
    return voidptr(res)
}
@[export: 'vphp_wrap_Article_get_formatted_title']
pub fn vphp_wrap_article_get_formatted_title(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    Article.sync_statics_from_php(ctx)
    res := recv.get_formatted_title()
    Article.sync_statics_to_php(ctx)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_Article_save']
pub fn vphp_wrap_article_save(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    Article.sync_statics_from_php(ctx)
    res := recv.save()
    Article.sync_statics_to_php(ctx)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_Article_dump_properties']
pub fn vphp_wrap_article_dump_properties(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'data').zval()
    Article.sync_statics_from_php(ctx)
    recv.dump_properties(arg_0)
    Article.sync_statics_to_php(ctx)
}
@[export: 'vphp_wrap_Article_process_with_callback']
pub fn vphp_wrap_article_process_with_callback(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Article(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    Article.sync_statics_from_php(ctx)
    res := recv.process_with_callback(arg_0)
    Article.sync_statics_to_php(ctx)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_Article_restore_author']
pub fn vphp_wrap_article_restore_author(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'authorVal', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'authorVal').zval()
    Article.sync_statics_from_php(ctx)
    res := Article.restore_author(arg_0)
    Article.sync_statics_to_php(ctx)
    return voidptr(res)
}
@[export: 'Article_handlers']
pub fn article_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(article_get_prop),
        write_handler: voidptr(article_set_prop),
        sync_handler: voidptr(article_sync_props),
        new_raw: voidptr(article_new_raw),
        cleanup_raw: voidptr(article_cleanup_raw),
        free_raw: voidptr(article_free_raw)
    )
}
pub fn Article.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.article_ce)
}

pub fn Article.php_object_handlers() voidptr {
    return article_handlers()
}

pub fn Article.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[Article]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &Article) bind_php_object() vphp.ZVal {
    return Article.php_object_zval(obj, .borrowed)
}

pub fn (obj &Article) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &Article) bind_owned_php_object() vphp.ZVal {
    return Article.php_object_zval(obj, .owned_request)
}

pub fn (obj &Article) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'Story_new_raw']
pub fn story_new_raw() voidptr {
    return vphp.generic_new_raw[Story]()
}
@[export: 'Story_free_raw']
pub fn story_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Story](ptr)
}
@[export: 'Story_cleanup_raw']
pub fn story_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'Story_get_prop']
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
@[export: 'Story_set_prop']
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
@[export: 'Story_sync_props']
pub fn story_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Story(ptr)
        out.add_property_long('chapter_count', i64(obj.chapter_count))
    }
}
@[export: 'vphp_wrap_Story_create']
pub fn vphp_wrap_story_create(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'author', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'chapters', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &Author(php_args.at_named_or_index(0, 'author').raw_obj()) }
    arg_1 := php_args.at_named_or_index(1, 'chapters').as_v[int]()
    res := Story.create(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_Story_tell']
pub fn vphp_wrap_story_tell(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Story(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.tell()
    ctx.return().v[string](res)
}
@[export: 'Story_handlers']
pub fn story_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(story_get_prop),
        write_handler: voidptr(story_set_prop),
        sync_handler: voidptr(story_sync_props),
        new_raw: voidptr(story_new_raw),
        cleanup_raw: voidptr(story_cleanup_raw),
        free_raw: voidptr(story_free_raw)
    )
}
pub fn Story.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.story_ce)
}

pub fn Story.php_object_handlers() voidptr {
    return story_handlers()
}

pub fn Story.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[Story]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &Story) bind_php_object() vphp.ZVal {
    return Story.php_object_zval(obj, .borrowed)
}

pub fn (obj &Story) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &Story) bind_owned_php_object() vphp.ZVal {
    return Story.php_object_zval(obj, .owned_request)
}

pub fn (obj &Story) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'AliasBase_new_raw']
pub fn aliasbase_new_raw() voidptr {
    return vphp.generic_new_raw[AliasBase]()
}
@[export: 'AliasBase_free_raw']
pub fn aliasbase_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[AliasBase](ptr)
}
@[export: 'AliasBase_cleanup_raw']
pub fn aliasbase_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'AliasBase_get_prop']
pub fn aliasbase_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'AliasBase_set_prop']
pub fn aliasbase_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'AliasBase_sync_props']
pub fn aliasbase_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &AliasBase(ptr)
        out.add_property_string('label', obj.label)
    }
}
@[export: 'vphp_wrap_AliasBase_construct']
pub fn vphp_wrap_aliasbase_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &AliasBase(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'label', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'label').as_v[string]()
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'AliasBase_handlers']
pub fn aliasbase_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(aliasbase_get_prop),
        write_handler: voidptr(aliasbase_set_prop),
        sync_handler: voidptr(aliasbase_sync_props),
        new_raw: voidptr(aliasbase_new_raw),
        cleanup_raw: voidptr(aliasbase_cleanup_raw),
        free_raw: voidptr(aliasbase_free_raw)
    )
}
pub fn AliasBase.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.demo__contracts__aliasbase_ce)
}

pub fn AliasBase.php_object_handlers() voidptr {
    return aliasbase_handlers()
}

pub fn AliasBase.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[AliasBase]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &AliasBase) bind_php_object() vphp.ZVal {
    return AliasBase.php_object_zval(obj, .borrowed)
}

pub fn (obj &AliasBase) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &AliasBase) bind_owned_php_object() vphp.ZVal {
    return AliasBase.php_object_zval(obj, .owned_request)
}

pub fn (obj &AliasBase) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'AliasWorker_new_raw']
pub fn aliasworker_new_raw() voidptr {
    return vphp.generic_new_raw[AliasWorker]()
}
@[export: 'AliasWorker_free_raw']
pub fn aliasworker_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[AliasWorker](ptr)
}
@[export: 'AliasWorker_cleanup_raw']
pub fn aliasworker_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'AliasWorker_get_prop']
pub fn aliasworker_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'AliasWorker_set_prop']
pub fn aliasworker_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'AliasWorker_sync_props']
pub fn aliasworker_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &AliasWorker(ptr)
        out.add_property_string('title', obj.title)
    }
}
@[export: 'vphp_wrap_AliasWorker_construct']
pub fn vphp_wrap_aliasworker_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'label', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'title', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'label').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'title').as_v[string]()
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_AliasWorker_save']
pub fn vphp_wrap_aliasworker_save(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.save()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_AliasWorker_get_formatted_title']
pub fn vphp_wrap_aliasworker_get_formatted_title(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_formatted_title()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_AliasWorker_ping']
pub fn vphp_wrap_aliasworker_ping(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &AliasWorker(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ping()
    ctx.return().v[string](res)
}
@[export: 'AliasWorker_handlers']
pub fn aliasworker_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(aliasworker_get_prop),
        write_handler: voidptr(aliasworker_set_prop),
        sync_handler: voidptr(aliasworker_sync_props),
        new_raw: voidptr(aliasworker_new_raw),
        cleanup_raw: voidptr(aliasworker_cleanup_raw),
        free_raw: voidptr(aliasworker_free_raw)
    )
}
pub fn AliasWorker.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.aliasworker_ce)
}

pub fn AliasWorker.php_object_handlers() voidptr {
    return aliasworker_handlers()
}

pub fn AliasWorker.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[AliasWorker]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &AliasWorker) bind_php_object() vphp.ZVal {
    return AliasWorker.php_object_zval(obj, .borrowed)
}

pub fn (obj &AliasWorker) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &AliasWorker) bind_owned_php_object() vphp.ZVal {
    return AliasWorker.php_object_zval(obj, .owned_request)
}

pub fn (obj &AliasWorker) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'RuntimeDemoBaseException_new_raw']
pub fn runtimedemobaseexception_new_raw() voidptr {
    return vphp.generic_new_raw[RuntimeDemoBaseException]()
}
@[export: 'RuntimeDemoBaseException_free_raw']
pub fn runtimedemobaseexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[RuntimeDemoBaseException](ptr)
}
@[export: 'RuntimeDemoBaseException_cleanup_raw']
pub fn runtimedemobaseexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn runtimedemobaseexception_load_from_php(php_obj vphp.ZendObject) RuntimeDemoBaseException {
    mut recv := RuntimeDemoBaseException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn runtimedemobaseexception_sync_to_php(php_obj vphp.ZendObject, recv RuntimeDemoBaseException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'RuntimeDemoBaseException_get_prop']
pub fn runtimedemobaseexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'RuntimeDemoBaseException_set_prop']
pub fn runtimedemobaseexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'RuntimeDemoBaseException_sync_props']
pub fn runtimedemobaseexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'RuntimeDemoBaseException_handlers']
pub fn runtimedemobaseexception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(runtimedemobaseexception_get_prop),
        write_handler: voidptr(runtimedemobaseexception_set_prop),
        sync_handler: voidptr(runtimedemobaseexception_sync_props),
        new_raw: voidptr(runtimedemobaseexception_new_raw),
        cleanup_raw: voidptr(runtimedemobaseexception_cleanup_raw),
        free_raw: voidptr(runtimedemobaseexception_free_raw)
    )
}
pub fn RuntimeDemoBaseException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.runtimedemo__baseexception_ce)
}

pub fn RuntimeDemoBaseException.php_object_handlers() voidptr {
    return runtimedemobaseexception_handlers()
}

pub fn RuntimeDemoBaseException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[RuntimeDemoBaseException]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &RuntimeDemoBaseException) bind_php_object() vphp.ZVal {
    return RuntimeDemoBaseException.php_object_zval(obj, .borrowed)
}

pub fn (obj &RuntimeDemoBaseException) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &RuntimeDemoBaseException) bind_owned_php_object() vphp.ZVal {
    return RuntimeDemoBaseException.php_object_zval(obj, .owned_request)
}

pub fn (obj &RuntimeDemoBaseException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'RuntimeDemoChildException_new_raw']
pub fn runtimedemochildexception_new_raw() voidptr {
    return vphp.generic_new_raw[RuntimeDemoChildException]()
}
@[export: 'RuntimeDemoChildException_free_raw']
pub fn runtimedemochildexception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[RuntimeDemoChildException](ptr)
}
@[export: 'RuntimeDemoChildException_cleanup_raw']
pub fn runtimedemochildexception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn runtimedemochildexception_load_from_php(php_obj vphp.ZendObject) RuntimeDemoChildException {
    mut recv := RuntimeDemoChildException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn runtimedemochildexception_sync_to_php(php_obj vphp.ZendObject, recv RuntimeDemoChildException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'RuntimeDemoChildException_get_prop']
pub fn runtimedemochildexception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'RuntimeDemoChildException_set_prop']
pub fn runtimedemochildexception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'RuntimeDemoChildException_sync_props']
pub fn runtimedemochildexception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'RuntimeDemoChildException_handlers']
pub fn runtimedemochildexception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(runtimedemochildexception_get_prop),
        write_handler: voidptr(runtimedemochildexception_set_prop),
        sync_handler: voidptr(runtimedemochildexception_sync_props),
        new_raw: voidptr(runtimedemochildexception_new_raw),
        cleanup_raw: voidptr(runtimedemochildexception_cleanup_raw),
        free_raw: voidptr(runtimedemochildexception_free_raw)
    )
}
pub fn RuntimeDemoChildException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.runtimedemo__childexception_ce)
}

pub fn RuntimeDemoChildException.php_object_handlers() voidptr {
    return runtimedemochildexception_handlers()
}

pub fn RuntimeDemoChildException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[RuntimeDemoChildException]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &RuntimeDemoChildException) bind_php_object() vphp.ZVal {
    return RuntimeDemoChildException.php_object_zval(obj, .borrowed)
}

pub fn (obj &RuntimeDemoChildException) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &RuntimeDemoChildException) bind_owned_php_object() vphp.ZVal {
    return RuntimeDemoChildException.php_object_zval(obj, .owned_request)
}

pub fn (obj &RuntimeDemoChildException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'CallableProcessor_new_raw']
pub fn callableprocessor_new_raw() voidptr {
    return vphp.generic_new_raw[CallableProcessor]()
}
@[export: 'CallableProcessor_free_raw']
pub fn callableprocessor_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[CallableProcessor](ptr)
}
@[export: 'CallableProcessor_cleanup_raw']
pub fn callableprocessor_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'CallableProcessor_get_prop']
pub fn callableprocessor_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'CallableProcessor_set_prop']
pub fn callableprocessor_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'CallableProcessor_sync_props']
pub fn callableprocessor_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &CallableProcessor(ptr)
        out.add_property_string('prefix', obj.prefix)
    }
}
@[export: 'vphp_wrap_CallableProcessor_construct']
pub fn vphp_wrap_callableprocessor_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    recv.construct(arg_0)
    return ptr
}
@[export: 'vphp_wrap_CallableProcessor_process']
pub fn vphp_wrap_callableprocessor_process(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    res := recv.process(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_CallableProcessor_transform']
pub fn vphp_wrap_callableprocessor_transform(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &CallableProcessor(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'input', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'input').as_v[string]()
    res := recv.transform(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_CallableProcessor_apply']
pub fn vphp_wrap_callableprocessor_apply(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'data').as_v[string]()
    res := CallableProcessor.apply(arg_0, arg_1)
    ctx.return().v[string](res)
}
pub type VPhpStructClosureCallableProcessorStructClosure = fn (StructClosureArgs) string

fn vphp_struct_closure_bridge_callableprocessor_struct_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureCallableProcessorStructClosure(v_ptr))
        args := StructClosureArgs{
            name: ctx.arg[string](0)
            count: ctx.arg[int](1)
        }
        ctx.invoke_struct_closure[VPhpStructClosureCallableProcessorStructClosure, StructClosureArgs, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_callableprocessor_struct_closure(ctx vphp.Context, cb VPhpStructClosureCallableProcessorStructClosure) {
    ctx.create_saved_closure[VPhpStructClosureCallableProcessorStructClosure](cb, voidptr(vphp_struct_closure_bridge_callableprocessor_struct_closure), 2)
}

@[export: 'vphp_wrap_CallableProcessor_struct_closure']
pub fn vphp_wrap_callableprocessor_struct_closure(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := CallableProcessor.struct_closure()
    // Returned value is a struct-param closure: wrap using generated bridge
    vphp_wrap_struct_closure_callableprocessor_struct_closure(ctx, res)
}
@[export: 'CallableProcessor_handlers']
pub fn callableprocessor_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(callableprocessor_get_prop),
        write_handler: voidptr(callableprocessor_set_prop),
        sync_handler: voidptr(callableprocessor_sync_props),
        new_raw: voidptr(callableprocessor_new_raw),
        cleanup_raw: voidptr(callableprocessor_cleanup_raw),
        free_raw: voidptr(callableprocessor_free_raw)
    )
}
pub fn CallableProcessor.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.callableprocessor_ce)
}

pub fn CallableProcessor.php_object_handlers() voidptr {
    return callableprocessor_handlers()
}

pub fn CallableProcessor.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[CallableProcessor]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &CallableProcessor) bind_php_object() vphp.ZVal {
    return CallableProcessor.php_object_zval(obj, .borrowed)
}

pub fn (obj &CallableProcessor) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &CallableProcessor) bind_owned_php_object() vphp.ZVal {
    return CallableProcessor.php_object_zval(obj, .owned_request)
}

pub fn (obj &CallableProcessor) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'Finder_new_raw']
pub fn finder_new_raw() voidptr {
    return vphp.generic_new_raw[Finder]()
}
@[export: 'Finder_free_raw']
pub fn finder_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Finder](ptr)
}
@[export: 'Finder_cleanup_raw']
pub fn finder_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'Finder_get_prop']
pub fn finder_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'Finder_set_prop']
pub fn finder_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'Finder_sync_props']
pub fn finder_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_Finder_construct']
pub fn vphp_wrap_finder_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    recv.construct(arg_0)
    return ptr
}
@[export: 'vphp_wrap_Finder_find']
pub fn vphp_wrap_finder_find(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keyword', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'keyword').as_v[string]()
    ctx.return().from_option[string](fn [arg_0, recv] () ?string {
        return recv.find(arg_0)
    })
}
@[export: 'vphp_wrap_Finder_index_of']
pub fn vphp_wrap_finder_index_of(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keyword', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'keyword').as_v[string]()
    ctx.return().from_option[int](fn [arg_0, recv] () ?int {
        return recv.index_of(arg_0)
    })
}
@[export: 'vphp_wrap_Finder_has_match']
pub fn vphp_wrap_finder_has_match(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Finder(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keyword', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'keyword').as_v[string]()
    ctx.return().from_option[bool](fn [arg_0, recv] () ?bool {
        return recv.has_match(arg_0)
    })
}
@[export: 'vphp_wrap_Finder_try_parse_int']
pub fn vphp_wrap_finder_try_parse_int(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 's', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 's').as_v[string]()
    ctx.return().from_option[int](fn [arg_0] () ?int {
        return Finder.try_parse_int(arg_0)
    })
}
@[export: 'Finder_handlers']
pub fn finder_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(finder_get_prop),
        write_handler: voidptr(finder_set_prop),
        sync_handler: voidptr(finder_sync_props),
        new_raw: voidptr(finder_new_raw),
        cleanup_raw: voidptr(finder_cleanup_raw),
        free_raw: voidptr(finder_free_raw)
    )
}
pub fn Finder.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.finder_ce)
}

pub fn Finder.php_object_handlers() voidptr {
    return finder_handlers()
}

pub fn Finder.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[Finder]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &Finder) bind_php_object() vphp.ZVal {
    return Finder.php_object_zval(obj, .borrowed)
}

pub fn (obj &Finder) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &Finder) bind_owned_php_object() vphp.ZVal {
    return Finder.php_object_zval(obj, .owned_request)
}

pub fn (obj &Finder) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'ReadonlyRecord_new_raw']
pub fn readonlyrecord_new_raw() voidptr {
    return vphp.generic_new_raw[ReadonlyRecord]()
}
@[export: 'ReadonlyRecord_free_raw']
pub fn readonlyrecord_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[ReadonlyRecord](ptr)
}
@[export: 'ReadonlyRecord_cleanup_raw']
pub fn readonlyrecord_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'ReadonlyRecord_get_prop']
pub fn readonlyrecord_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'ReadonlyRecord_set_prop']
pub fn readonlyrecord_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'ReadonlyRecord_sync_props']
pub fn readonlyrecord_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &ReadonlyRecord(ptr)
        out.add_property_long('created_at', i64(obj.created_at))
        out.add_property_string('title', obj.title)
    }
}
@[export: 'vphp_wrap_ReadonlyRecord_construct']
pub fn vphp_wrap_readonlyrecord_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &ReadonlyRecord(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'title').as_v[string]()
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_ReadonlyRecord_reveal']
pub fn vphp_wrap_readonlyrecord_reveal(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &ReadonlyRecord(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.reveal()
    ctx.return().v[string](res)
}
@[export: 'ReadonlyRecord_handlers']
pub fn readonlyrecord_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(readonlyrecord_get_prop),
        write_handler: voidptr(readonlyrecord_set_prop),
        sync_handler: voidptr(readonlyrecord_sync_props),
        new_raw: voidptr(readonlyrecord_new_raw),
        cleanup_raw: voidptr(readonlyrecord_cleanup_raw),
        free_raw: voidptr(readonlyrecord_free_raw)
    )
}
pub fn ReadonlyRecord.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.readonlyrecord_ce)
}

pub fn ReadonlyRecord.php_object_handlers() voidptr {
    return readonlyrecord_handlers()
}

pub fn ReadonlyRecord.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[ReadonlyRecord]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &ReadonlyRecord) bind_php_object() vphp.ZVal {
    return ReadonlyRecord.php_object_zval(obj, .borrowed)
}

pub fn (obj &ReadonlyRecord) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &ReadonlyRecord) bind_owned_php_object() vphp.ZVal {
    return ReadonlyRecord.php_object_zval(obj, .owned_request)
}

pub fn (obj &ReadonlyRecord) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'TraitPost_new_raw']
pub fn traitpost_new_raw() voidptr {
    return vphp.generic_new_raw[TraitPost]()
}
@[export: 'TraitPost_free_raw']
pub fn traitpost_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[TraitPost](ptr)
}
@[export: 'TraitPost_cleanup_raw']
pub fn traitpost_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'TraitPost_get_prop']
pub fn traitpost_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'TraitPost_set_prop']
pub fn traitpost_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'TraitPost_sync_props']
pub fn traitpost_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &TraitPost(ptr)
        out.add_property_string('title', obj.title)
        out.add_property_string('slug', obj.slug)
        out.add_property_long('visits', i64(obj.visits))
    }
}
@[export: 'vphp_wrap_TraitPost_construct']
pub fn vphp_wrap_traitpost_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'title', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'title').as_v[string]()
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_TraitPost_summary']
pub fn vphp_wrap_traitpost_summary(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.summary()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_TraitPost_bump']
pub fn vphp_wrap_traitpost_bump(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.bump()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_TraitPost_trait_only']
pub fn vphp_wrap_traitpost_trait_only(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.trait_only()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_TraitPost_internal_trait']
pub fn vphp_wrap_traitpost_internal_trait(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &TraitPost(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.internal_trait()
    ctx.return().v[string](res)
}
@[export: 'TraitPost_handlers']
pub fn traitpost_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(traitpost_get_prop),
        write_handler: voidptr(traitpost_set_prop),
        sync_handler: voidptr(traitpost_sync_props),
        new_raw: voidptr(traitpost_new_raw),
        cleanup_raw: voidptr(traitpost_cleanup_raw),
        free_raw: voidptr(traitpost_free_raw)
    )
}
pub fn TraitPost.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.traitpost_ce)
}

pub fn TraitPost.php_object_handlers() voidptr {
    return traitpost_handlers()
}

pub fn TraitPost.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[TraitPost]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &TraitPost) bind_php_object() vphp.ZVal {
    return TraitPost.php_object_zval(obj, .borrowed)
}

pub fn (obj &TraitPost) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &TraitPost) bind_owned_php_object() vphp.ZVal {
    return TraitPost.php_object_zval(obj, .owned_request)
}

pub fn (obj &TraitPost) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'Validator_new_raw']
pub fn validator_new_raw() voidptr {
    return vphp.generic_new_raw[Validator]()
}
@[export: 'Validator_free_raw']
pub fn validator_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[Validator](ptr)
}
@[export: 'Validator_cleanup_raw']
pub fn validator_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'Validator_get_prop']
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
@[export: 'Validator_set_prop']
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
@[export: 'Validator_sync_props']
pub fn validator_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &Validator(ptr)
        out.add_property_bool('strict', obj.strict)
    }
}
@[export: 'vphp_wrap_Validator_construct']
pub fn vphp_wrap_validator_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'strict', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'strict').as_v[bool]()
    recv.construct(arg_0)
    return ptr
}
@[export: 'vphp_wrap_Validator_check']
pub fn vphp_wrap_validator_check(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'input').as_v[string]()
    ctx.return().from_result[bool](fn [arg_0, recv] () !bool {
        return recv.check(arg_0)!
    })
}
@[export: 'vphp_wrap_Validator_sanitize']
pub fn vphp_wrap_validator_sanitize(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'input').as_v[string]()
    ctx.return().from_result[string](fn [arg_0, recv] () !string {
        return recv.sanitize(arg_0)!
    })
}
@[export: 'vphp_wrap_Validator_assert_valid']
pub fn vphp_wrap_validator_assert_valid(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &Validator(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'input').as_v[string]()
    ctx.return().from_result_void(fn [arg_0, recv] () ! {
        recv.assert_valid(arg_0)!
    })
}
@[export: 'vphp_wrap_Validator_parse_int']
pub fn vphp_wrap_validator_parse_int(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 's', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 's').as_v[string]()
    ctx.return().from_result[int](fn [arg_0] () !int {
        return Validator.parse_int(arg_0)!
    })
}
@[export: 'Validator_handlers']
pub fn validator_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(validator_get_prop),
        write_handler: voidptr(validator_set_prop),
        sync_handler: voidptr(validator_sync_props),
        new_raw: voidptr(validator_new_raw),
        cleanup_raw: voidptr(validator_cleanup_raw),
        free_raw: voidptr(validator_free_raw)
    )
}
pub fn Validator.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.validator_ce)
}

pub fn Validator.php_object_handlers() voidptr {
    return validator_handlers()
}

pub fn Validator.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[Validator]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &Validator) bind_php_object() vphp.ZVal {
    return Validator.php_object_zval(obj, .borrowed)
}

pub fn (obj &Validator) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &Validator) bind_owned_php_object() vphp.ZVal {
    return Validator.php_object_zval(obj, .owned_request)
}

pub fn (obj &Validator) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'DispatchableSample_new_raw']
pub fn dispatchablesample_new_raw() voidptr {
    return vphp.generic_new_raw[DispatchableSample]()
}
@[export: 'DispatchableSample_free_raw']
pub fn dispatchablesample_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[DispatchableSample](ptr)
}
@[export: 'DispatchableSample_cleanup_raw']
pub fn dispatchablesample_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'DispatchableSample_get_prop']
pub fn dispatchablesample_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'DispatchableSample_set_prop']
pub fn dispatchablesample_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'DispatchableSample_sync_props']
pub fn dispatchablesample_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &DispatchableSample(ptr)
        out.add_property_string('name', obj.name)
    }
}
@[export: 'vphp_wrap_DispatchableSample_construct']
pub fn vphp_wrap_dispatchablesample_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &DispatchableSample(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_DispatchableSample_tagged']
pub fn vphp_wrap_dispatchablesample_tagged(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &DispatchableSample(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: [vphp.PhpAttribute.named('FromQuery').for_parameter().string('name'), vphp.PhpAttribute.named('MustBeString').for_parameter()] },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.tagged(arg_0)
    ctx.return().v[string](res)
}
@[export: 'DispatchableSample_handlers']
pub fn dispatchablesample_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(dispatchablesample_get_prop),
        write_handler: voidptr(dispatchablesample_set_prop),
        sync_handler: voidptr(dispatchablesample_sync_props),
        new_raw: voidptr(dispatchablesample_new_raw),
        cleanup_raw: voidptr(dispatchablesample_cleanup_raw),
        free_raw: voidptr(dispatchablesample_free_raw)
    )
}
pub fn DispatchableSample.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.dispatchablesample_ce)
}

pub fn DispatchableSample.php_object_handlers() voidptr {
    return dispatchablesample_handlers()
}

pub fn DispatchableSample.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[DispatchableSample]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &DispatchableSample) bind_php_object() vphp.ZVal {
    return DispatchableSample.php_object_zval(obj, .borrowed)
}

pub fn (obj &DispatchableSample) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &DispatchableSample) bind_owned_php_object() vphp.ZVal {
    return DispatchableSample.php_object_zval(obj, .owned_request)
}

pub fn (obj &DispatchableSample) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'VPhpTask_new_raw']
pub fn vphptask_new_raw() voidptr {
    return vphp.generic_new_raw[VPhpTask]()
}
@[export: 'VPhpTask_free_raw']
pub fn vphptask_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VPhpTask](ptr)
}
@[export: 'VPhpTask_cleanup_raw']
pub fn vphptask_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VPhpTask_get_prop']
pub fn vphptask_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VPhpTask_set_prop']
pub fn vphptask_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VPhpTask_sync_props']
pub fn vphptask_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VPhpTask_spawn']
pub fn vphp_wrap_vphptask_spawn(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    VPhpTask.@spawn(arg_0)
}
@[export: 'vphp_wrap_VPhpTask_wait']
pub fn vphp_wrap_vphptask_wait(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    VPhpTask.wait(arg_0)
}
@[export: 'vphp_wrap_VPhpTask_list']
pub fn vphp_wrap_vphptask_list(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    arg_0 := ctx
    VPhpTask.list(arg_0)
}
@[export: 'VPhpTask_handlers']
pub fn vphptask_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vphptask_get_prop),
        write_handler: voidptr(vphptask_set_prop),
        sync_handler: voidptr(vphptask_sync_props),
        new_raw: voidptr(vphptask_new_raw),
        cleanup_raw: voidptr(vphptask_cleanup_raw),
        free_raw: voidptr(vphptask_free_raw)
    )
}
pub fn VPhpTask.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vphp__task_ce)
}

pub fn VPhpTask.php_object_handlers() voidptr {
    return vphptask_handlers()
}

pub fn VPhpTask.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[VPhpTask]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &VPhpTask) bind_php_object() vphp.ZVal {
    return VPhpTask.php_object_zval(obj, .borrowed)
}

pub fn (obj &VPhpTask) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &VPhpTask) bind_owned_php_object() vphp.ZVal {
    return VPhpTask.php_object_zval(obj, .owned_request)
}

pub fn (obj &VPhpTask) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'StringableBox_new_raw']
pub fn stringablebox_new_raw() voidptr {
    return vphp.generic_new_raw[StringableBox]()
}
@[export: 'StringableBox_free_raw']
pub fn stringablebox_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[StringableBox](ptr)
}
@[export: 'StringableBox_cleanup_raw']
pub fn stringablebox_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'StringableBox_get_prop']
pub fn stringablebox_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'StringableBox_set_prop']
pub fn stringablebox_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'StringableBox_sync_props']
pub fn stringablebox_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &StringableBox(ptr)
        out.add_property_string('name', obj.name)
    }
}
@[export: 'vphp_wrap_StringableBox_construct']
pub fn vphp_wrap_stringablebox_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &StringableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.construct(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_StringableBox_str']
pub fn vphp_wrap_stringablebox_str(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &StringableBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.str()
    ctx.return().v[string](res)
}
@[export: 'StringableBox_handlers']
pub fn stringablebox_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(stringablebox_get_prop),
        write_handler: voidptr(stringablebox_set_prop),
        sync_handler: voidptr(stringablebox_sync_props),
        new_raw: voidptr(stringablebox_new_raw),
        cleanup_raw: voidptr(stringablebox_cleanup_raw),
        free_raw: voidptr(stringablebox_free_raw)
    )
}
pub fn StringableBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.stringablebox_ce)
}

pub fn StringableBox.php_object_handlers() voidptr {
    return stringablebox_handlers()
}

pub fn StringableBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    mut value := vphp.PhpValue.null()
    binding := vphp.PhpObjectBinding.new[StringableBox]()
    if v_ptr == 0 || !binding.is_valid() {
        return value.take_zval()
    }
    vphp.PhpReturn.from_zval(value.to_zval()).bound_object(v_ptr, binding.class_entry, binding.handlers, ownership)
    return value.take_zval()
}

pub fn (obj &StringableBox) bind_php_object() vphp.ZVal {
    return StringableBox.php_object_zval(obj, .borrowed)
}

pub fn (obj &StringableBox) bind_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_php_object())
}

pub fn (obj &StringableBox) bind_owned_php_object() vphp.ZVal {
    return StringableBox.php_object_zval(obj, .owned_request)
}

pub fn (obj &StringableBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.PhpValue.adopt_zval(obj.bind_owned_php_object())
}

@[export: 'vphp_wrap_v_add']
fn vphp_wrap_v_add(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'a', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'b', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'a').as_v[i64]()
    arg_1 := php_args.at_named_or_index(1, 'b').as_v[i64]()
    res := v_add(arg_0, arg_1)
    ctx.return().v[i64](res)
}

@[export: 'vphp_wrap_v_greet']
fn vphp_wrap_v_greet(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
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
        vphp.PhpArgMeta{ index: 0, name: 'x', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'x').as_v[f64]()
    res := v_float_id(arg_0)
    ctx.return().v[f64](res)
}

@[export: 'vphp_wrap_v_pure_map_test']
fn vphp_wrap_v_pure_map_test(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'k', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'v', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'k').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'v').as_v[string]()
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
        vphp.PhpArgMeta{ index: 0, name: 'className', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'ifaceName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'className').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'ifaceName').as_v[string]()
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
        vphp.PhpArgMeta{ index: 0, name: 'obj', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'obj').zval()
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

@[export: 'vphp_wrap_v_persistent_fallback_counter_probe']
fn vphp_wrap_v_persistent_fallback_counter_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
    res := v_persistent_fallback_counter_probe(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_request_scope_counter_probe']
fn vphp_wrap_v_request_scope_counter_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rounds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rounds').as_v[int]()
    res := v_request_scope_counter_probe(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_value_zbox_lifecycle_probe']
fn vphp_wrap_v_php_value_zbox_lifecycle_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
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
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').zval()
    res := v_php_closure_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_closure_persistent_api']
fn vphp_wrap_v_php_closure_persistent_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').zval()
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
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
    res := v_php_object_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_array_api']
fn vphp_wrap_v_php_array_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
    res := v_php_array_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_callable_api']
fn vphp_wrap_v_php_callable_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').zval()
    res := v_php_callable_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_value_api']
fn vphp_wrap_v_php_value_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
    res := v_php_value_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_scalar_api']
fn vphp_wrap_v_php_scalar_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
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
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'reasonPhrase', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'secure', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'ratio', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_params_status := if php_args.has_named_or_index(0, 'status') { php_args.at_named_or_index(0, 'status').as_v[int]() } else { 200 }
    arg_0_params_reason_phrase := if php_args.has_named_or_index(1, 'reasonPhrase') { php_args.at_named_or_index(1, 'reasonPhrase').as_v[string]() } else { '' }
    arg_0_params_secure := if php_args.has_named_or_index(2, 'secure') { php_args.at_named_or_index(2, 'secure').as_v[bool]() } else { false }
    arg_0_params_ratio := if php_args.has_named_or_index(3, 'ratio') { php_args.at_named_or_index(3, 'ratio').as_v[f64]() } else { 1.5 }
    arg_0_params := VPhpParamsStructDemo{
        status: arg_0_params_status
        reason_phrase: arg_0_params_reason_phrase
        secure: arg_0_params_secure
        ratio: arg_0_params_ratio
    }
    res := v_php_params_struct_api(arg_0_params)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_arg_binding_optional_scalar_api']
fn vphp_wrap_v_php_arg_binding_optional_scalar_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'count', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'label', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'count') { php_args.at_named_or_index(0, 'count').as_v[int]() } else { 7 }
    arg_1 := if php_args.has_named_or_index(1, 'label') { php_args.at_named_or_index(1, 'label').as_v[string]() } else { 'fallback' }
    res := v_php_arg_binding_optional_scalar_api(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_direct_arg_camel_api']
fn vphp_wrap_v_php_direct_arg_camel_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'firstName', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'firstName').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'defaultValue').as_v[string]()
    res := v_php_direct_arg_camel_api(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_call_style_arg_attrs_api']
fn vphp_wrap_v_php_call_style_arg_attrs_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'valueAlias', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'optionalCount', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'valueAlias').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'optionalCount') { php_args.at_named_or_index(1, 'optionalCount').as_v[int]() } else { 7 }
    res := v_php_call_style_arg_attrs_api(arg_0, arg_1)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_semantic_params_struct_api']
fn vphp_wrap_v_php_semantic_params_struct_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'label', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'flag', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'items', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_params_label := if php_args.has_named_or_index(0, 'label') {
        php_args.at_named_or_index(0, 'label').string_value() or {
            vphp.throw_exception('argument 0 must be string', 0)
            return
        }
    } else {
        vphp.PhpString.empty()
    }
    arg_0_params_flag := if php_args.has_named_or_index(1, 'flag') {
        php_args.at_named_or_index(1, 'flag').bool_value() or {
            vphp.throw_exception('argument 1 must be bool', 0)
            return
        }
    } else {
        vphp.PhpBool.false_value()
    }
    arg_0_params_items := if php_args.has_named_or_index(2, 'items') {
        php_args.at_named_or_index(2, 'items').array() or {
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
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
    res := v_php_resource_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_wrapper_param_api']
fn vphp_wrap_v_php_wrapper_param_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'obj', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'arr', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'callable', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'nullValue', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'maybeObj', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'value').value
    arg_1 := php_args.at_named_or_index(1, 'obj').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    arg_2 := php_args.at_named_or_index(2, 'arr').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return
    }
    arg_3 := php_args.at_named_or_index(3, 'callable').callable() or {
        vphp.throw_exception('argument 3 must be callable', 0)
        return
    }
    arg_4 := php_args.at_named_or_index(4, 'nullValue').null_value() or {
        vphp.throw_exception('argument 4 must be null', 0)
        return
    }
    arg_5 := php_args.at_named_or_index(5, 'maybeObj').object()
    res := v_php_wrapper_param_api(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_optional_value_api']
fn vphp_wrap_v_php_optional_value_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'value') { ?vphp.PhpValue(php_args.at_named_or_index(0, 'value').value) } else { none }
    res := v_php_optional_value_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_optional_object_api']
fn vphp_wrap_v_php_optional_object_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'obj', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'obj').object()
    res := v_php_optional_object_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_return_value_api']
fn vphp_wrap_v_php_return_value_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'value').value
    res := v_php_return_value_api(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}

@[export: 'vphp_wrap_v_php_return_array_api']
fn vphp_wrap_v_php_return_array_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'arr', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'arr').array() or {
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
        vphp.PhpArgMeta{ index: 0, name: 'obj', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'obj').object() or {
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
        vphp.PhpArgMeta{ index: 0, name: 'callable', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callable').callable() or {
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
        vphp.PhpArgMeta{ index: 0, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'value').string_value() or {
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
        vphp.PhpArgMeta{ index: 0, name: 'arr', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'arr').array() or {
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
        vphp.PhpArgMeta{ index: 0, name: 'rawObj', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'callback', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'rawRes', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rawObj').zval()
    arg_1 := php_args.at_named_or_index(1, 'callback').zval()
    arg_2 := php_args.at_named_or_index(2, 'rawRes').zval()
    res := v_dyn_value_runtime_refs(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_reference_api']
fn vphp_wrap_v_php_reference_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
    res := v_php_reference_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_iterable_api']
fn vphp_wrap_v_php_iterable_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
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
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
    res := v_php_throwable_api(arg_0)
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_php_enum_api']
fn vphp_wrap_v_php_enum_api(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
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
        vphp.PhpArgMeta{ index: 0, name: 'raw', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'raw').zval()
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

pub type VPhpVariadicClosureVGetVClosure = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_v_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVClosure(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetVClosure, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_v_closure(ctx vphp.Context, cb VPhpVariadicClosureVGetVClosure) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVClosure](cb, voidptr(vphp_variadic_closure_bridge_v_get_v_closure))
}

@[export: 'vphp_wrap_v_get_v_closure']
fn vphp_wrap_v_get_v_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_v_closure()
    vphp_wrap_variadic_closure_v_get_v_closure(ctx, res)
}

pub type VPhpVariadicClosureVGetVClosureAuto = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_v_closure_auto(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVClosureAuto(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetVClosureAuto, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_v_closure_auto(ctx vphp.Context, cb VPhpVariadicClosureVGetVClosureAuto) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVClosureAuto](cb, voidptr(vphp_variadic_closure_bridge_v_get_v_closure_auto))
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
        vphp.PhpArgMeta{ index: 0, name: 'input', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'input').zval()
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
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').callable() or {
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
        vphp.PhpArgMeta{ index: 0, name: 'callback', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'callback').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    res := v_invoke_with_arg(arg_0, arg_1)
    ctx.return().v[string](res)
}

pub type VPhpVariadicClosureVGetClosure0 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_0(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure0(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetClosure0, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_0(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure0) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetClosure0](cb, voidptr(vphp_variadic_closure_bridge_v_get_closure_0))
}

@[export: 'vphp_wrap_v_get_closure_0']
fn vphp_wrap_v_get_closure_0(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_0()
    vphp_wrap_variadic_closure_v_get_closure_0(ctx, res)
}

pub type VPhpVariadicClosureVGetClosure1 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_1(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure1(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetClosure1, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_1(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure1) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetClosure1](cb, voidptr(vphp_variadic_closure_bridge_v_get_closure_1))
}

@[export: 'vphp_wrap_v_get_closure_1']
fn vphp_wrap_v_get_closure_1(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_1()
    vphp_wrap_variadic_closure_v_get_closure_1(ctx, res)
}

pub type VPhpVariadicClosureVGetClosure2 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_2(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure2(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetClosure2, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_2(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure2) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetClosure2](cb, voidptr(vphp_variadic_closure_bridge_v_get_closure_2))
}

@[export: 'vphp_wrap_v_get_closure_2']
fn vphp_wrap_v_get_closure_2(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_2()
    vphp_wrap_variadic_closure_v_get_closure_2(ctx, res)
}

pub type VPhpVariadicClosureVGetClosure3 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_3(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure3(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetClosure3, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_3(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure3) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetClosure3](cb, voidptr(vphp_variadic_closure_bridge_v_get_closure_3))
}

@[export: 'vphp_wrap_v_get_closure_3']
fn vphp_wrap_v_get_closure_3(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_3()
    vphp_wrap_variadic_closure_v_get_closure_3(ctx, res)
}

pub type VPhpVariadicClosureVGetClosure4 = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_closure_4(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure4(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetClosure4, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_4(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure4) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetClosure4](cb, voidptr(vphp_variadic_closure_bridge_v_get_closure_4))
}

@[export: 'vphp_wrap_v_get_closure_4']
fn vphp_wrap_v_get_closure_4(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_4()
    vphp_wrap_variadic_closure_v_get_closure_4(ctx, res)
}

pub type VPhpVariadicClosureVGetClosure3Void = fn (...vphp.ZVal)

fn vphp_variadic_closure_bridge_v_get_closure_3_void(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure3Void(v_ptr))
        ctx.invoke_variadic_closure_void[VPhpVariadicClosureVGetClosure3Void](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_3_void(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure3Void) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetClosure3Void](cb, voidptr(vphp_variadic_closure_bridge_v_get_closure_3_void))
}

@[export: 'vphp_wrap_v_get_closure_3_void']
fn vphp_wrap_v_get_closure_3_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_3_void()
    vphp_wrap_variadic_closure_v_get_closure_3_void(ctx, res)
}

pub type VPhpVariadicClosureVGetClosure4Void = fn (...vphp.ZVal)

fn vphp_variadic_closure_bridge_v_get_closure_4_void(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetClosure4Void(v_ptr))
        ctx.invoke_variadic_closure_void[VPhpVariadicClosureVGetClosure4Void](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_closure_4_void(ctx vphp.Context, cb VPhpVariadicClosureVGetClosure4Void) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetClosure4Void](cb, voidptr(vphp_variadic_closure_bridge_v_get_closure_4_void))
}

@[export: 'vphp_wrap_v_get_closure_4_void']
fn vphp_wrap_v_get_closure_4_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_closure_4_void()
    vphp_wrap_variadic_closure_v_get_closure_4_void(ctx, res)
}

pub type VPhpStructClosureVGetStructParamClosure = fn (StructClosureArgs) string

fn vphp_struct_closure_bridge_v_get_struct_param_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpStructClosureVGetStructParamClosure(v_ptr))
        args := StructClosureArgs{
            name: ctx.arg[string](0)
            count: ctx.arg[int](1)
        }
        ctx.invoke_struct_closure[VPhpStructClosureVGetStructParamClosure, StructClosureArgs, string](cb, args)
    }
}

fn vphp_wrap_struct_closure_v_get_struct_param_closure(ctx vphp.Context, cb VPhpStructClosureVGetStructParamClosure) {
    ctx.create_saved_closure[VPhpStructClosureVGetStructParamClosure](cb, voidptr(vphp_struct_closure_bridge_v_get_struct_param_closure), 2)
}

@[export: 'vphp_wrap_v_get_struct_param_closure']
fn vphp_wrap_v_get_struct_param_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_struct_param_closure()
    vphp_wrap_struct_closure_v_get_struct_param_closure(ctx, res)
}

pub type VPhpVariadicClosureVGetVariadicValueClosure = fn (...vphp.PhpValue) string

fn vphp_variadic_closure_bridge_v_get_variadic_value_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicValueClosure(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetVariadicValueClosure, string](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_value_closure(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicValueClosure) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVariadicValueClosure](cb, voidptr(vphp_variadic_closure_bridge_v_get_variadic_value_closure))
}

@[export: 'vphp_wrap_v_get_variadic_value_closure']
fn vphp_wrap_v_get_variadic_value_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_value_closure()
    vphp_wrap_variadic_closure_v_get_variadic_value_closure(ctx, res)
}

pub type VPhpVariadicClosureVGetVariadicZvalClosure = fn (...vphp.ZVal) vphp.ZVal

fn vphp_variadic_closure_bridge_v_get_variadic_zval_closure(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicZvalClosure(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetVariadicZvalClosure, vphp.ZVal](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_zval_closure(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicZvalClosure) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVariadicZvalClosure](cb, voidptr(vphp_variadic_closure_bridge_v_get_variadic_zval_closure))
}

@[export: 'vphp_wrap_v_get_variadic_zval_closure']
fn vphp_wrap_v_get_variadic_zval_closure(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_zval_closure()
    vphp_wrap_variadic_closure_v_get_variadic_zval_closure(ctx, res)
}

pub type VPhpVariadicClosureVGetVariadicZvalVoid = fn (...vphp.ZVal)

fn vphp_variadic_closure_bridge_v_get_variadic_zval_void(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicZvalVoid(v_ptr))
        ctx.invoke_variadic_closure_void[VPhpVariadicClosureVGetVariadicZvalVoid](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_zval_void(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicZvalVoid) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVariadicZvalVoid](cb, voidptr(vphp_variadic_closure_bridge_v_get_variadic_zval_void))
}

@[export: 'vphp_wrap_v_get_variadic_zval_void']
fn vphp_wrap_v_get_variadic_zval_void(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_zval_void()
    vphp_wrap_variadic_closure_v_get_variadic_zval_void(ctx, res)
}

pub type VPhpVariadicClosureVGetVariadicScalarString = fn (...vphp.VScalarValue) string

fn vphp_variadic_closure_bridge_v_get_variadic_scalar_string(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicScalarString(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetVariadicScalarString, string](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_scalar_string(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicScalarString) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVariadicScalarString](cb, voidptr(vphp_variadic_closure_bridge_v_get_variadic_scalar_string))
}

@[export: 'vphp_wrap_v_get_variadic_scalar_string']
fn vphp_wrap_v_get_variadic_scalar_string(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_scalar_string()
    vphp_wrap_variadic_closure_v_get_variadic_scalar_string(ctx, res)
}

pub type VPhpVariadicClosureVGetVariadicScalarI64 = fn (...vphp.VScalarValue) i64

fn vphp_variadic_closure_bridge_v_get_variadic_scalar_i64(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicScalarI64(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetVariadicScalarI64, i64](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_scalar_i64(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicScalarI64) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVariadicScalarI64](cb, voidptr(vphp_variadic_closure_bridge_v_get_variadic_scalar_i64))
}

@[export: 'vphp_wrap_v_get_variadic_scalar_i64']
fn vphp_wrap_v_get_variadic_scalar_i64(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_scalar_i64()
    vphp_wrap_variadic_closure_v_get_variadic_scalar_i64(ctx, res)
}

pub type VPhpVariadicClosureVGetVariadicScalarValue = fn (...vphp.VScalarValue) vphp.VScalarValue

fn vphp_variadic_closure_bridge_v_get_variadic_scalar_value(v_ptr voidptr, ex &C.zend_execute_data, ret &C.zval) {
    unsafe {
        ctx := vphp.Context.from_ptr(ex, ret)
        cb := *(&VPhpVariadicClosureVGetVariadicScalarValue(v_ptr))
        ctx.invoke_variadic_closure[VPhpVariadicClosureVGetVariadicScalarValue, vphp.VScalarValue](cb)
    }
}

fn vphp_wrap_variadic_closure_v_get_variadic_scalar_value(ctx vphp.Context, cb VPhpVariadicClosureVGetVariadicScalarValue) {
    ctx.create_saved_variadic_closure[VPhpVariadicClosureVGetVariadicScalarValue](cb, voidptr(vphp_variadic_closure_bridge_v_get_variadic_scalar_value))
}

@[export: 'vphp_wrap_v_get_variadic_scalar_value']
fn vphp_wrap_v_get_variadic_scalar_value(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_get_variadic_scalar_value()
    vphp_wrap_variadic_closure_v_get_variadic_scalar_value(ctx, res)
}

@[export: 'vphp_wrap_v_lifecycle_hook_state']
fn vphp_wrap_v_lifecycle_hook_state(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := v_lifecycle_hook_state()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_v_find_after']
fn vphp_wrap_v_find_after(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'haystack', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'needle', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'haystack').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'needle').as_v[string]()
    ctx.return().from_option[string](fn [arg_0, arg_1] () ?string {
        return v_find_after(arg_0, arg_1)
    })
}

@[export: 'vphp_wrap_v_try_divide']
fn vphp_wrap_v_try_divide(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'a', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'b', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'a').as_v[int]()
    arg_1 := php_args.at_named_or_index(1, 'b').as_v[int]()
    ctx.return().from_option[int](fn [arg_0, arg_1] () ?int {
        return v_try_divide(arg_0, arg_1)
    })
}

@[export: 'vphp_wrap_v_record_match']
fn vphp_wrap_v_record_match(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'haystack', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'needle', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'haystack').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'needle').as_v[string]()
    ctx.return().from_option_void(fn [arg_0, arg_1, arg_2] () ? {
        v_record_match(arg_0, arg_1, arg_2)
    })
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
        vphp.PhpArgMeta{ index: 0, name: 'a', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'b', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'a').as_v[int]()
    arg_1 := php_args.at_named_or_index(1, 'b').as_v[int]()
    ctx.return().from_result[int](fn [arg_0, arg_1] () !int {
        return v_safe_divide(arg_0, arg_1)!
    })
}

@[export: 'vphp_wrap_v_capitalize']
fn vphp_wrap_v_capitalize(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'input', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'input').as_v[string]()
    ctx.return().from_result[string](fn [arg_0] () !string {
        return v_capitalize(arg_0)!
    })
}

@[export: 'vphp_wrap_v_record_success']
fn vphp_wrap_v_record_success(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'label', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'label').as_v[string]()
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
    arg_0 := php_args.at_named_or_index(0, 'query').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'page').as_v[int]()
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

@[export: 'vphp_ext_auto_startup']
fn vphp_ext_auto_startup() {
    vphp.register_auto_interface_binding('AliasWorker', 'RuntimeContracts\\Greeter')

    vphp.ITask.register('AnalyzeTask', fn (args []vphp.ZVal) vphp.ITask {
        return AnalyzeTask{
            symbol: args[0].to_v[string]() or { '' }
            count: args[1].to_v[int]() or { 0 }
        }
    })
}
