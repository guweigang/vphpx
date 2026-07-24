<?php
// 测试：闭包内的内联赋值不应泄漏到外层作用域
// 源自 WordPress wp_extract_urls 中 array_map 闭包内 $link = html_entity_decode($link)

function process_items($items) {
    $result = array_map(
        function ($item) {
            $item = trim($item);
            return strtoupper($item);
        },
        $items
    );
    return $result;
}

function extract_and_transform($data) {
    $cleaned = array_unique(
        array_map(
            static function ($link) {
                $link = html_entity_decode($link);
                return str_replace(';', '', $link);
            },
            $data
        )
    );
    return array_values($cleaned);
}
