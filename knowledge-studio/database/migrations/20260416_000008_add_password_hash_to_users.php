<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->addColumn('users', 'password_hash varchar(255) not null');
        } catch (\Throwable) {
        }

        try {
            $this->addColumn('users', 'password_reset_required tinyint(1) not null default 0');
        } catch (\Throwable) {
        }

        try {
            $hash = addslashes((string) password_hash('demo123', PASSWORD_DEFAULT));
            $this->execute("UPDATE `users` SET `password_hash` = '{$hash}' WHERE `password_hash` = '' OR `password_hash` IS NULL");
        } catch (\Throwable) {
        }

        try {
            $this->execute("UPDATE `users` SET `password_reset_required` = 0 WHERE `password_reset_required` IS NULL");
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropColumn('users', 'password_hash');
        } catch (\Throwable) {
        }

        try {
            $this->dropColumn('users', 'password_reset_required');
        } catch (\Throwable) {
        }

        return true;
    }
};
