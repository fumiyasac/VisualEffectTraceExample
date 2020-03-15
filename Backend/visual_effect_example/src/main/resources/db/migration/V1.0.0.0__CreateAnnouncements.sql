-- // プラグイン「Flyway」を利用したDBマイグレーション機構を準備する
-- // SQLの定義をしておけばプロジェクトを起動したタイミングでDB内にテーブル定義を展開してくれる。
-- // ※Go言語でほとんど同様の機能を実現する「goose」というパッケージと似ている（コンセプトは恐らくRailsのマイグレーションからだと思われる）

-- // 参考URL(1): Spring Boot (Kotlin) + Flywayでサーバサイドアプリケーション作ってみた
-- // https://qiita.com/morimorim/items/2447048c0275c843b89c

-- // 参考URL(2): すぐに始めるKotlinサーバサイド開発(Spring Boot + Swagger + Flyway + Mybatis)
-- // https://gumiossan.hatenablog.com/entry/2018/12/01/224510

-- // 参考URL(3): DBマイグレーションツール活用のすすめ 〜Flyway〜
-- // https://qiita.com/osuo/items/3aa375f1a1d6dd3d2459

CREATE TABLE `announcements` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) NOT NULL DEFAULT '' COMMENT '運営からのお知らせ用タイトル',
  `statement` text COMMENT '運営からのお知らせ用本文',
  `thumbnail_url` text COMMENT '運営からのお知らせ用サムネイル画像URL',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT '運営からのお知らせ用公開フラグ（0:公開 1:非公開）',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '運営からのお知らせ用作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '運営からのお知らせ用更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `announcements` WRITE;

INSERT INTO `announcements` (`id`, `title`, `statement`, `thumbnail_url`, `publish_flag`, `created_at`, `updated_at`)
VALUES
	(1,'新しいiOSアプリのUI実装サンプルを追加しました。','今回のサンプルは、規模が大きな感じのアプリになっても柔軟に対応できる事を想定してRxSwiftを利用したMVVM（Model - View - ViewModel）構成で実現するロジックのハンドリング処理とReSwiftを利用したRedux構成で実現するViewや画面における状態管理をミックスさせたUI実装サンプルになっております。','https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/announcement/annoucement_sample1.jpg',0,'2020-03-29 00:00:00','2020-03-29 00:00:00'),
	(2,'今回のサンプルでは、フロントエンド・バックエンドの実装も含んでいます。','昨今のアプリ開発における大規模化・多機能化の流れがより激しくなってきたこともあり、iOSアプリ開発においてもいわゆる「横の連携」や「Web開発に関する知識」についても求められる場面が増えてきた様に思います。iOSアプリ開発を取り巻く周辺技術も一緒に知る機会となれば良いなという僕の想いも込めてWebAPI用バックエンドとWeb表示画面のフロントエンドの環境も準備しています。バックエンドは「Server Side Kotlin」、フロントエンドは「React.js」を利用しています。','https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/announcement/annoucement_sample2.jpg',0,'2020-03-29 00:00:00','2020-03-29 00:00:00'),
	(3,'アプリ開発者であってもバックエンドやフロントエンドの知識を持っておくと良い理由を少しだけ説明できればと思います。','私自身はメインの仕事はiOSアプリ開発を担当しておりますが、元々はWebデザイナーからキャリアがスタートして、26歳からWebエンジニアへのジョブチェンジをして5年程はPHPやRubyを利用した大規模サービスやソーシャルゲームのバックエンド側を担当していた経験があります。デザインのすり合わせやアプリ側で表示するデータに関する調整をする場面は、特に人数が少ないときやサービスの立ち上げ時期に限らず平素の業務の中でも数多くあると思います。その中で、自分が取り扱う技術の範囲外のものに対しても一緒に考えてサジェストすることができるならばそれはチームにとっても大きな推進力となりえるはずです。','https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/announcement/annoucement_sample3.jpg',0,'2020-03-29 00:00:00','2020-03-29 00:00:00');

UNLOCK TABLES;