package net.just1factory.visual_effect_example

// MEMO: テスト対象のRepository・Entityのインポート
import net.just1factory.visual_effect_example.domain.entity.ApplicationUserEntity
import net.just1factory.visual_effect_example.domain.repository.ApplicationUserRepository

// MEMO: JUnit5で提供されているアノテーション（JUnit4とは異なる点に注意）
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith

// MEMO: JUnitで利用できる検証のためのアサーション
import org.assertj.core.api.Assertions.assertThat

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired;

// MEMO: EntityとRepositoryのテストを実施するにあたりAutoConfigurationを利用するためのアノテーション
// 参考: https://qiita.com/fanfanta/items/05d7d0ac2b5a43935ee3
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;

// MEMO: Spring TestContext Frameworkを利用可能にする
// 参考: https://qiita.com/kazuki43zoo/items/4a9ead225a9a9897af4a
import org.springframework.test.context.junit.jupiter.SpringExtension

// MEMO: BCryptPasswordEncoderを利用可能にする
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

// MEMO: JUnit5からはSpringExtensionになる点に注意
@ExtendWith(SpringExtension::class)

// MEMO: JPAを利用した処理をテストする
@DataJpaTest

// MEMO: テスト用のデータベースを選択してマイグレーションを実施する
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class ApplicationUserRepositoryTests {

    // MEMO: Spring 管理下のオブジェクトの中から適切なものを変数に追加する (Setter Injection)
    @Autowired
    private lateinit var applicationUserRepository: ApplicationUserRepository

    private val testUsers: List<ApplicationUserEntity> =
        listOf(
            // 🐊さんのアカウント情報
            ApplicationUserEntity(
                userName = "wanisan",
                mailAddress = "wani@example.com",
                password = BCryptPasswordEncoder().encode("wanigabugabu")
            ),
            // 🐈さんのアカウント情報
            ApplicationUserEntity(
                userName = "nekochan",
                mailAddress = "neko@example.com",
                password = BCryptPasswordEncoder().encode("nekomomimomi")
            ),
            // 🐇さんのアカウント情報
            ApplicationUserEntity(
                userName = "usagikun",
                mailAddress = "usagi@example.com",
                password = BCryptPasswordEncoder().encode("usagimofumofu")
            )
        )

    // MEMO: 各種テストコードの実行前にする処理
    @BeforeEach
    fun beforeEach() {
        println("↓↓↓ 自動テストを開始します: ↓↓↓")
        testUsers.map {
            applicationUserRepository.save(it)
        }
    }

    // MEMO: 各種テストコードの実行後にする処理
    @AfterEach
    fun afterEach() {
        testUsers.map {
            applicationUserRepository.delete(it)
        }
        println("↑↑↑ 自動テストを終了します: ↑↑↑")
    }

    // MEMO: 実行するテストコード

    // データ引き当て処理に関するテスト（※前提としてmailAddressとuserNameはUnique制約がかかっている）
    @Test
    fun findApplicationUserTest() {

        // MEMO: applicationUser1: ユーザー名をキーにして対応するメールアドレスが取得できる
        val applicationUser1: ApplicationUserEntity? = applicationUserRepository.findByUserName(
            userName = "wanisan"
        )
        assertThat(applicationUser1).isNotNull
        assertThat(applicationUser1!!.mailAddress).isEqualTo("wani@example.com")
        assertThat(applicationUser1!!.mailAddress).isNotEqualTo("neko@example.com")
        assertThat(applicationUser1!!.mailAddress).isNotEqualTo("usagi@example.com")

        // MEMO: applicationUser2: メールアドレスをキーにして対応するユーザー名が取得できる
        val applicationUser2: ApplicationUserEntity? = applicationUserRepository.findByMailAddress(
            mailAddress = "neko@example.com"
        )
        assertThat(applicationUser2).isNotNull
        assertThat(applicationUser2!!.userName).isNotEqualTo("wanisan")
        assertThat(applicationUser2!!.userName).isEqualTo("nekochan")
        assertThat(applicationUser2!!.userName).isNotEqualTo("usagikun")
    }
}