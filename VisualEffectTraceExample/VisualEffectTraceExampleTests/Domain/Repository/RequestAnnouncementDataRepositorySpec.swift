//
//  RequestAnnouncementDataRepositorySpec.swift
//  VisualEffectTraceExampleTests
//
//  Created by 酒井文也 on 2022/06/13.
//  Copyright © 2022 酒井文也. All rights reserved.
//

@testable import VisualEffectTraceExample

import Nimble
import Quick
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

final class RequestAnnouncementDataRepositorySpec: QuickSpec {

    // MARK: - Override

    override func spec() {

        let apiRequestManagerMock = APIRequestProtocolMock()
        let target = RequestAnnouncementDataRepository()

        describe("RequestAnnouncementDataRepository") {

            // MARK: - requestAnnouncementDataListを実行した際のテスト

            describe("#requestAnnouncementDataList") {

                // MEMO: API通信処理成功時の想定
                context("APIから正常にデータが返却される場合") {
                    let result = getDataList()
                    let announcementListAPIResponse = AnnouncementListAPIResponse(result: result)

                    // Mockに差し替えたメソッドが返却する値を定める
                    beforeEach {
                        apiRequestManagerMock.given(
                            .getAnnouncements(
                                willReturn: Single.just(announcementListAPIResponse)
                            )
                        )
                    }
                    it("StubのJSON値を変換したものをそのまま返却すること") {
                        expect(
                            try! target.requestAnnouncementDataList().toBlocking().first()
                        ).to(
                            equal(announcementListAPIResponse)
                        )
                    }
                }
            }
        }
    }

    private func getDataList() -> Array<AnnouncementEntity> {

        // JSONファイルから表示用のデータを取得する
        guard let path = Bundle(for: VisualEffectTraceExampleTests.self).path(forResource: "announcement_data", ofType: "json") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError()
        }
        guard let announcementDataList = try? JSONDecoder().decode(Array<AnnouncementEntity>.self, from: data) else {
            fatalError()
        }
        return announcementDataList
    }
}
