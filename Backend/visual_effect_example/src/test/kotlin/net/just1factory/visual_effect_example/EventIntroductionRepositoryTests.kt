package net.just1factory.visual_effect_example

// MEMO: テスト対象のRepository・Entityのインポート
import net.just1factory.visual_effect_example.domain.entity.EventIntroductionEntity
import net.just1factory.visual_effect_example.domain.repository.EventIntroductionRepository

// MEMO: JUnit5で提供されているアノテーション（JUnit4とは異なる点に注意）
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

// MEMO: JUnitで利用できる検証のためのアサーション
import org.assertj.core.api.Assertions.assertThat

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired

// MEMO: EntityとRepositoryのテストを実施するにあたりAutoConfigurationを利用するためのアノテーション
// 参考: https://qiita.com/fanfanta/items/05d7d0ac2b5a43935ee3
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase

// MEMO: Spring TestContext Frameworkを利用可能にする
// 参考: https://qiita.com/kazuki43zoo/items/4a9ead225a9a9897af4a
import org.springframework.test.context.junit.jupiter.SpringExtension

// MEMO: JUnit5からはSpringExtensionになる点に注意
@ExtendWith(SpringExtension::class)

// MEMO: JPAを利用した処理をテストする
@DataJpaTest

// MEMO: テスト用のデータベースを選択してマイグレーションを実施する
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class EventIntroductionRepositoryTests {

    // MEMO: Spring 管理下のオブジェクトの中から適切なものを変数に追加する (Setter Injection)
    @Autowired
    private lateinit var eventIntroductionRepository: EventIntroductionRepository

    // MEMO: 各種テストコードの実行前にする処理
    @BeforeEach
    fun beforeEach() {
        println("↓↓↓ 自動テストを開始します: ↓↓↓")
    }

    // MEMO: 各種テストコードの実行後にする処理
    @AfterEach
    fun afterEach() {
        println("↑↑↑ 自動テストを終了します: ↑↑↑")
    }

    // MEMO: 実行するテストコード

    // 全件取得総数に関するテスト
    @Test
    fun findAllCountTest() {
        val eventIntroductions: List<EventIntroductionEntity> = eventIntroductionRepository.findAll()

        // MEMO: 予めテスト用で登録しているデータを利用したテスト
        assertThat(eventIntroductions.count()).isEqualTo(15)
    }

    // 取得数と取得開始位置に関するテスト
    @Test
    fun findListPerPageTest() {

        // MEMO: 予めテスト用で登録しているデータを利用したテスト
        val firstEventIntroductions: List<EventIntroductionEntity> = eventIntroductionRepository.selectEventIntroductionPerPage(limit = 7, offset = 0)
        assertThat(firstEventIntroductions.size).isEqualTo(7)
        assertThat(firstEventIntroductions.first().id).isEqualTo(15)
        assertThat(firstEventIntroductions.last().id).isEqualTo(9)

        val secondEventIntroductions: List<EventIntroductionEntity> = eventIntroductionRepository.selectEventIntroductionPerPage(limit = 5, offset = 8)
        assertThat(secondEventIntroductions.size).isEqualTo(5)
        assertThat(secondEventIntroductions.first().id).isEqualTo(7)
        assertThat(secondEventIntroductions.last().id).isEqualTo(3)

        val thirdEventIntroductions: List<EventIntroductionEntity> = eventIntroductionRepository.selectEventIntroductionPerPage(limit = 5, offset = 15)
        assertThat(thirdEventIntroductions.size).isEqualTo(0)
        assertThat(thirdEventIntroductions).isEqualTo(emptyList<EventIntroductionEntity>())
    }
}