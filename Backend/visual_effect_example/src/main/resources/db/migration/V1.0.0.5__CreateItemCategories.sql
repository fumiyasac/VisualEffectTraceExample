CREATE TABLE `item_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(11) unsigned NOT NULL COMMENT 'アイテムID',
  `category_id` int(11) unsigned NOT NULL COMMENT 'カテゴリーID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテムとカテゴリーを紐づける中間データ作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテムとカテゴリーを紐づける中間データ更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- // 外部キー制約の付与: items & item_categories / categories & item_categories テーブルに対して外部キー制約を付与する

ALTER TABLE `item_categories` ADD FOREIGN KEY (`category_id`) REFERENCES categories (`id`) ON DELETE CASCADE;
ALTER TABLE `item_categories` ADD FOREIGN KEY (`item_id`) REFERENCES items (`id`) ON DELETE CASCADE;
