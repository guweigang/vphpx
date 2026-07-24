<?php
$link = mysqli_connect("127.0.0.1", "root", "Abcd.1234", "test");
if (!$link) {
    echo "Connect failed\n";
    exit(1);
}

mysqli_query($link, "CREATE TABLE IF NOT EXISTS test_users (id INT, name VARCHAR(50))");
mysqli_query($link, "DELETE FROM test_users");
mysqli_query($link, "INSERT INTO test_users VALUES (1, 'Alice'), (2, 'Bob')");

$res = mysqli_query($link, "SELECT id, name FROM test_users ORDER BY id ASC");
echo "Rows count: " . mysqli_num_rows($res) . "\n";

while ($row = mysqli_fetch_assoc($res)) {
    echo "User: " . $row['name'] . " (ID: " . $row['id'] . ")\n";
}

mysqli_close($link);
