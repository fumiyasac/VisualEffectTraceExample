CREATE TABLE `stories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT 'ストーリーのタイトル表記',
  `catch_copy` varchar(255) NOT NULL COMMENT 'ストーリーのキャッチコピー表記',
  `main_statement` text COMMENT 'ストーリーのメイン本文表記',
  `sub_statement` text COMMENT 'ストーリーのサブ本文表記',
  `thumbnail_url` text COMMENT 'ストーリーの画像サムネイルURL',
  `author` varchar(255) NOT NULL COMMENT 'ストーリーの著者表記',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT 'ストーリー用公開フラグ（0:公開 1:非公開）',
  `announcement_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ストーリー公開日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ストーリー作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ストーリー更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
