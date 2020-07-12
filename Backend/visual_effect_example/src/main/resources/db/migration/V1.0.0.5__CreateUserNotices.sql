CREATE TABLE `user_notices` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT 'ユーザーID',
  `title` varchar(255) NOT NULL COMMENT 'ユーザーへのお知らせタイトル表記',
  `statement` text COMMENT 'ユーザーへのお知らせ本文表記',
  `read_flag` int(1) NOT NULL DEFAULT '0' COMMENT 'ユーザーへのお知らせ既読管理フラグ（0:未読 1:既読）',
  `url` text COMMENT 'ユーザーへのお知らせ内での関連リンク',
  `notice_type` int(1) NOT NULL DEFAULT '0' COMMENT 'ユーザーへのお知らせ区分（0:システム自動追加）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザーへのお知らせ作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザーへのお知らせ更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
