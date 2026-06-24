<?php
class User {
    const ROLE_ADMIN = "admin";
    const ROLE_USER = "user";

    public function getAdminRole() {
        return self::ROLE_ADMIN;
    }
}

echo User::ROLE_ADMIN . "\n";

$u = new User();
echo $u->getAdminRole() . "\n";
