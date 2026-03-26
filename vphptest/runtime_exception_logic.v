module main

@[heap]
@[php_class: 'RuntimeDemo\\BaseException']
@[php_extends: 'Exception']
struct RuntimeDemoBaseException {}

@[heap]
@[php_class: 'RuntimeDemo\\ChildException']
@[php_extends: 'RuntimeDemo\\BaseException']
struct RuntimeDemoChildException {}
