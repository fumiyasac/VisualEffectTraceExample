CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL COMMENT 'ユーザー名',
  `mail_address` varchar(255) NOT NULL COMMENT 'メールアドレス',
  `password` varchar(255) NOT NULL COMMENT 'パスワード',
  `device_token` text COMMENT 'デバイストークン',
  `status_code` int(1) NOT NULL DEFAULT '0' COMMENT 'ユーザーの状態コード（0:有効 1:無効）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザー情報作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザー情報更新日',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`),
  UNIQUE KEY `mail_address_UNIQUE` (`mail_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `user` WRITE;

INSERT INTO `user` (`id`, `user_name`, `mail_address`, `password`, `device_token`, `status_code`, `created_at`, `updated_at`)
VALUES
	(1, 'fumiyasac', 'just1factory@gmail.com', '$2a$10$q0yZy5U8Ttz8vyakGgpZj.naWF0574p6i3.7lnkyN1DT06Fh/Jeq2', NULL, 0, '2020-03-08 00:00:00', '2020-03-08 00:00:00');

UNLOCK TABLES;
