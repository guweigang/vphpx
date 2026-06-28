<?php

if ($argc < 2) {
    fprintf(STDERR, "Usage: php parser.php <file.php>\n");
    exit(1);
}

$file = $argv[1];
if (!file_exists($file)) {
    fprintf(STDERR, "File not found: %s\n", $file);
    exit(1);
}

require __DIR__ . '/vendor/autoload.php';

use PhpParser\ParserFactory;

function cleanNode($node) {
    if ($node === null) {
        return null;
    }
    // 如果是 Name 节点或 Identifier 节点，直接转为字符串，简化 V 侧的解析
    if ($node instanceof \PhpParser\Node\Name || $node instanceof \PhpParser\Node\Identifier) {
        return $node->toString();
    }
    // NullableType 扁平化为 "?type" 字符串
    if ($node instanceof \PhpParser\Node\NullableType) {
        return '?' . $node->type->toString();
    }
    if ($node instanceof \PhpParser\Node) {
        $res = [
            'nodeType' => $node->getType(),
            'line' => $node->getStartLine()
        ];
        foreach ($node->getSubNodeNames() as $subName) {
            $val = $node->$subName;
            $outName = $subName;
            if (($node->getType() === 'Arg' || $node->getType() === 'ArrayItem') && $subName === 'value') {
                $outName = 'expr';
            }
            if ($node->getType() === 'Stmt_For' && $subName === 'cond') {
                $outName = 'conds';
            }
            if ($node->getType() === 'Stmt_PropertyProperty' && $subName === 'default') {
                $outName = 'expr';
            }
            if ($node->getType() === 'Expr_FuncCall' && $subName === 'name' && !is_string($val) && !($val instanceof \PhpParser\Node\Name)) {
                $outName = 'expr';
            }
            if ($node->getType() === 'Expr_New' && $subName === 'class' && !is_string($val) && !($val instanceof \PhpParser\Node\Name)) {
                $outName = 'class_expr';
            }
            if ($node->getType() === 'Expr_MethodCall' && $subName === 'name' && !is_string($val) && !($val instanceof \PhpParser\Node\Identifier)) {
                $outName = 'name_expr';
            }
            if (is_array($val)) {
                $res[$outName] = array_map('cleanNode', $val);
            } elseif ($val instanceof \PhpParser\Node) {
                $res[$outName] = cleanNode($val);
            } else {
                if (is_bool($val)) {
                    $res[$outName] = $val ? 'true' : 'false';
                } elseif ($val === null) {
                    $res[$outName] = null;
                } else {
                    $res[$outName] = (string)$val;
                }
            }
        }
        return $res;
    }
    if (is_bool($node)) {
        return $node ? 'true' : 'false';
    }
    return (string)$node;
}

$code = file_get_contents($file);
$parser = (new ParserFactory())->createForNewestSupportedVersion();

try {
    $stmts = $parser->parse($code);
} catch (PhpParser\Error $error) {
    fprintf(STDERR, "Parse error: %s\n", $error->getMessage());
    exit(1);
}

$cleaned = array_map('cleanNode', $stmts);

echo json_encode($cleaned, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n";
