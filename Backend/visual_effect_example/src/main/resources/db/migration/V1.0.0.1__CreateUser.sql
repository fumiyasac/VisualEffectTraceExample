CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL COMMENT 'ユーザー名',
  `mail_address` varchar(255) NOT NULL COMMENT 'メールアドレス',
  `password` varchar(255) NOT NULL COMMENT 'パスワード',
  `auth_token` text COMMENT 'アクセス認可トークン',
  `device_token` text COMMENT 'デバイストークン',
  `status_code` int(1) NOT NULL DEFAULT '0' COMMENT 'ユーザーの状態コード（0:有効 1:無効）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザー情報作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザー情報更新日',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  UNIQUE KEY `mail_address_UNIQUE` (`mail_address`),
  UNIQUE KEY `password_UNIQUE` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;