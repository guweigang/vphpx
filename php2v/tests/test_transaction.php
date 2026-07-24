<?php
header('Content-Type: text/plain');
echo "=== PDO Transaction & Proof Test ===\n\n";

try {
    $pdo = new PDO("mysql:host=127.0.0.1;port=3306;dbname=wordpress", "root", "Abcd.1234");
    echo "1. Checking inTransaction() initially: " . ($pdo->inTransaction() ? "YES" : "NO") . "\n";

    echo "2. Starting Transaction...\n";
    $pdo->beginTransaction();
    echo "   inTransaction(): " . ($pdo->inTransaction() ? "YES" : "NO") . "\n";

    echo "3. Rolling Back Transaction...\n";
    $pdo->rollBack();
    echo "   inTransaction(): " . ($pdo->inTransaction() ? "YES" : "NO") . "\n";

    echo "4. Starting New Transaction for Commit test...\n";
    $pdo->beginTransaction();
    echo "5. Committing Transaction...\n";
    $pdo->commit();
    echo "   inTransaction(): " . ($pdo->inTransaction() ? "YES" : "NO") . "\n";

    echo "\nTransaction Test Completed Successfully!\n";
} catch (Throwable $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
