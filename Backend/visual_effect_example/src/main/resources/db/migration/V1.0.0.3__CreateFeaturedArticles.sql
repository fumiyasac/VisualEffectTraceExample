CREATE TABLE `featured_articles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '特集記事のタイトル表記',
  `catch_copy` varchar(255) NOT NULL COMMENT '特集記事のキャッチコピー表記',
  `statement` text COMMENT '特集記事の本文表記',
  `thumbnail_url` text COMMENT '特集記事の画像サムネイルURL',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT '特集記事用公開フラグ（0:公開 1:非公開）',
  `author` varchar(255) NOT NULL COMMENT '特集記事の著者表記',
  `announcement_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集記事公開日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集記事作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集記事更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `featured_articles` WRITE;

INSERT INTO `featured_articles` (`id`, `title`, `catch_copy`, `statement`, `thumbnail_url`, `publish_flag`, `author`, `announcement_at`, `created_at`, `updated_at`)
VALUES
	(1, '特集コンテンツ的なもの1', 'キャッチコピー表示事例1', 'こちらは特集コンテンツ1の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample1.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(2, '特集コンテンツ的なもの2', 'キャッチコピー表示事例2', 'こちらは特集コンテンツ2の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample2.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(3, '特集コンテンツ的なもの3', 'キャッチコピー表示事例3', 'こちらは特集コンテンツ3の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample3.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(4, '特集コンテンツ的なもの4', 'キャッチコピー表示事例4', 'こちらは特集コンテンツ4の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample4.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(5, '特集コンテンツ的なもの5', 'キャッチコピー表示事例5', 'こちらは特集コンテンツ5の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample5.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(6, '特集コンテンツ的なもの6', 'キャッチコピー表示事例6', 'こちらは特集コンテンツ6の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample6.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(7, '特集コンテンツ的なもの7', 'キャッチコピー表示事例7', 'こちらは特集コンテンツ7の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample7.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(8, '特集コンテンツ的なもの8', 'キャッチコピー表示事例8', 'こちらは特集コンテンツ8の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample8.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(9, '特集コンテンツ的なもの9', 'キャッチコピー表示事例9', 'こちらは特集コンテンツ9の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample9.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00'),
	(10, '特集コンテンツ的なもの10', 'キャッチコピー表示事例10', 'こちらは特集コンテンツ10の紹介文章サンプルになり、特集コンテンツの表示事例になります。見た目のデザインについては、iOSのSafariの様な表現をUICollectionViewのレイアウトをカスタマイズをすることで実現しています。', 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/featured_contents/featured_sample10.jpg', 0, 'admin', '2020-08-01 00:00:00', '2020-08-01 00:00:00', '2020-08-01 00:00:00');

UNLOCK TABLES;
