<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->execute('ALTER TABLE `knowledge_documents` ADD COLUMN `updated_at` datetime NULL');
        } catch (\Throwable) {
        }

        try {
            $this->execute('UPDATE `knowledge_documents` SET `updated_at` = `created_at` WHERE `updated_at` IS NULL');
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropColumn('knowledge_documents', 'updated_at');
        } catch (\Throwable) {
        }

        return true;
    }
};
