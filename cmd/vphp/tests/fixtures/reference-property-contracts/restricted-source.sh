#!/bin/sh
set -eu

case "$1" in
    readonly) property="@[vphp.PhpDeclaredReadonlyProperty('score', 'int', .public)]" ;;
    protected) property="@[vphp.PhpDeclaredPropertyWithSetVisibility('score', 'int', .protected)]" ;;
    *) exit 2 ;;
esac
case "$2" in
    interface) parent="@[vphp.PhpImplements(names: 'RefPropertyContract')]" ;;
    abstract) parent="@[vphp.PhpExtends('AbstractRefReadWrite')]" ;;
    *) exit 2 ;;
esac
sed -e "s/@parent@/$parent/" -e "s/@property@/$property/" "${0%/*}/invalid-restricted.v.in"
