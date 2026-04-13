<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->execute('ALTER TABLE `knowledge_releases` ADD COLUMN `notes` text NOT NULL DEFAULT ""');
        } catch (\Throwable) {
        }
        return true;
    }

    public function down(): bool
    {
        return true;
    }
};
