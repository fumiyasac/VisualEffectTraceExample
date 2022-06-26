// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0


import SwiftyMocky
import XCTest
import Foundation
import UIKit
import RxSwift
@testable import VisualEffectTraceExample


// MARK: - APIRequestProtocol

open class APIRequestProtocolMock: APIRequestProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getTopBanners() -> Single<TopBannerAPIResponse> {
        addInvocation(.m_getTopBanners)
		let perform = methodPerformValue(.m_getTopBanners) as? () -> Void
		perform?()
		var __value: Single<TopBannerAPIResponse>
		do {
		    __value = try methodReturnValue(.m_getTopBanners).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getTopBanners(). Use given")
			Failure("Stub return value not specified for getTopBanners(). Use given")
		}
		return __value
    }

    open func getEventIntroductionsBy(page: Int) -> Single<EventIntroductionAPIResponse> {
        addInvocation(.m_getEventIntroductionsBy__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_getEventIntroductionsBy__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: Single<EventIntroductionAPIResponse>
		do {
		    __value = try methodReturnValue(.m_getEventIntroductionsBy__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getEventIntroductionsBy(page: Int). Use given")
			Failure("Stub return value not specified for getEventIntroductionsBy(page: Int). Use given")
		}
		return __value
    }

    open func getRecentAnnouncement() -> Single<AnnouncementDetailAPIResponse> {
        addInvocation(.m_getRecentAnnouncement)
		let perform = methodPerformValue(.m_getRecentAnnouncement) as? () -> Void
		perform?()
		var __value: Single<AnnouncementDetailAPIResponse>
		do {
		    __value = try methodReturnValue(.m_getRecentAnnouncement).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getRecentAnnouncement(). Use given")
			Failure("Stub return value not specified for getRecentAnnouncement(). Use given")
		}
		return __value
    }

    open func getItemsBy(page: Int) -> Single<ItemAPIResponse> {
        addInvocation(.m_getItemsBy__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_getItemsBy__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: Single<ItemAPIResponse>
		do {
		    __value = try methodReturnValue(.m_getItemsBy__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getItemsBy(page: Int). Use given")
			Failure("Stub return value not specified for getItemsBy(page: Int). Use given")
		}
		return __value
    }

    open func getFeaturedArticles() -> Single<FeaturedArticleAPIResponse> {
        addInvocation(.m_getFeaturedArticles)
		let perform = methodPerformValue(.m_getFeaturedArticles) as? () -> Void
		perform?()
		var __value: Single<FeaturedArticleAPIResponse>
		do {
		    __value = try methodReturnValue(.m_getFeaturedArticles).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getFeaturedArticles(). Use given")
			Failure("Stub return value not specified for getFeaturedArticles(). Use given")
		}
		return __value
    }

    open func getStories() -> Single<StoryAPIResponse> {
        addInvocation(.m_getStories)
		let perform = methodPerformValue(.m_getStories) as? () -> Void
		perform?()
		var __value: Single<StoryAPIResponse>
		do {
		    __value = try methodReturnValue(.m_getStories).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getStories(). Use given")
			Failure("Stub return value not specified for getStories(). Use given")
		}
		return __value
    }

    open func getAnnouncements() -> Single<AnnouncementListAPIResponse> {
        addInvocation(.m_getAnnouncements)
		let perform = methodPerformValue(.m_getAnnouncements) as? () -> Void
		perform?()
		var __value: Single<AnnouncementListAPIResponse>
		do {
		    __value = try methodReturnValue(.m_getAnnouncements).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getAnnouncements(). Use given")
			Failure("Stub return value not specified for getAnnouncements(). Use given")
		}
		return __value
    }

    open func requestSiginin(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse> {
        addInvocation(.m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`)))
		let perform = methodPerformValue(.m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))) as? (String, String) -> Void
		perform?(`mailAddress`, `rawPassword`)
		var __value: Single<SigninSuccessResponse>
		do {
		    __value = try methodReturnValue(.m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for requestSiginin(mailAddress: String, rawPassword: String). Use given")
			Failure("Stub return value not specified for requestSiginin(mailAddress: String, rawPassword: String). Use given")
		}
		return __value
    }

    open func requestSiginup(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse> {
        addInvocation(.m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`)))
		let perform = methodPerformValue(.m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))) as? (String, String, String) -> Void
		perform?(`userName`, `mailAddress`, `rawPassword`)
		var __value: Single<GeneralPostSuccessARIResponse>
		do {
		    __value = try methodReturnValue(.m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for requestSiginup(userName: String, mailAddress: String, rawPassword: String). Use given")
			Failure("Stub return value not specified for requestSiginup(userName: String, mailAddress: String, rawPassword: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getTopBanners
        case m_getEventIntroductionsBy__page_page(Parameter<Int>)
        case m_getRecentAnnouncement
        case m_getItemsBy__page_page(Parameter<Int>)
        case m_getFeaturedArticles
        case m_getStories
        case m_getAnnouncements
        case m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>, Parameter<String>)
        case m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>, Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getTopBanners, .m_getTopBanners): return .match

            case (.m_getEventIntroductionsBy__page_page(let lhsPage), .m_getEventIntroductionsBy__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_getRecentAnnouncement, .m_getRecentAnnouncement): return .match

            case (.m_getItemsBy__page_page(let lhsPage), .m_getItemsBy__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_getFeaturedArticles, .m_getFeaturedArticles): return .match

            case (.m_getStories, .m_getStories): return .match

            case (.m_getAnnouncements, .m_getAnnouncements): return .match

            case (.m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(let lhsMailaddress, let lhsRawpassword), .m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(let rhsMailaddress, let rhsRawpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMailaddress, rhs: rhsMailaddress, with: matcher), lhsMailaddress, rhsMailaddress, "mailAddress"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawpassword, rhs: rhsRawpassword, with: matcher), lhsRawpassword, rhsRawpassword, "rawPassword"))
				return Matcher.ComparisonResult(results)

            case (.m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(let lhsUsername, let lhsMailaddress, let lhsRawpassword), .m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(let rhsUsername, let rhsMailaddress, let rhsRawpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUsername, rhs: rhsUsername, with: matcher), lhsUsername, rhsUsername, "userName"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMailaddress, rhs: rhsMailaddress, with: matcher), lhsMailaddress, rhsMailaddress, "mailAddress"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawpassword, rhs: rhsRawpassword, with: matcher), lhsRawpassword, rhsRawpassword, "rawPassword"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getTopBanners: return 0
            case let .m_getEventIntroductionsBy__page_page(p0): return p0.intValue
            case .m_getRecentAnnouncement: return 0
            case let .m_getItemsBy__page_page(p0): return p0.intValue
            case .m_getFeaturedArticles: return 0
            case .m_getStories: return 0
            case .m_getAnnouncements: return 0
            case let .m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(p0, p1): return p0.intValue + p1.intValue
            case let .m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getTopBanners: return ".getTopBanners()"
            case .m_getEventIntroductionsBy__page_page: return ".getEventIntroductionsBy(page:)"
            case .m_getRecentAnnouncement: return ".getRecentAnnouncement()"
            case .m_getItemsBy__page_page: return ".getItemsBy(page:)"
            case .m_getFeaturedArticles: return ".getFeaturedArticles()"
            case .m_getStories: return ".getStories()"
            case .m_getAnnouncements: return ".getAnnouncements()"
            case .m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword: return ".requestSiginin(mailAddress:rawPassword:)"
            case .m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword: return ".requestSiginup(userName:mailAddress:rawPassword:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getTopBanners(willReturn: Single<TopBannerAPIResponse>...) -> MethodStub {
            return Given(method: .m_getTopBanners, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getEventIntroductionsBy(page: Parameter<Int>, willReturn: Single<EventIntroductionAPIResponse>...) -> MethodStub {
            return Given(method: .m_getEventIntroductionsBy__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getRecentAnnouncement(willReturn: Single<AnnouncementDetailAPIResponse>...) -> MethodStub {
            return Given(method: .m_getRecentAnnouncement, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getItemsBy(page: Parameter<Int>, willReturn: Single<ItemAPIResponse>...) -> MethodStub {
            return Given(method: .m_getItemsBy__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getFeaturedArticles(willReturn: Single<FeaturedArticleAPIResponse>...) -> MethodStub {
            return Given(method: .m_getFeaturedArticles, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getStories(willReturn: Single<StoryAPIResponse>...) -> MethodStub {
            return Given(method: .m_getStories, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getAnnouncements(willReturn: Single<AnnouncementListAPIResponse>...) -> MethodStub {
            return Given(method: .m_getAnnouncements, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func requestSiginin(mailAddress: Parameter<String>, rawPassword: Parameter<String>, willReturn: Single<SigninSuccessResponse>...) -> MethodStub {
            return Given(method: .m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func requestSiginup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, willReturn: Single<GeneralPostSuccessARIResponse>...) -> MethodStub {
            return Given(method: .m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getTopBanners(willProduce: (Stubber<Single<TopBannerAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<TopBannerAPIResponse>] = []
			let given: Given = { return Given(method: .m_getTopBanners, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<TopBannerAPIResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func getEventIntroductionsBy(page: Parameter<Int>, willProduce: (Stubber<Single<EventIntroductionAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<EventIntroductionAPIResponse>] = []
			let given: Given = { return Given(method: .m_getEventIntroductionsBy__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<EventIntroductionAPIResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func getRecentAnnouncement(willProduce: (Stubber<Single<AnnouncementDetailAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<AnnouncementDetailAPIResponse>] = []
			let given: Given = { return Given(method: .m_getRecentAnnouncement, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<AnnouncementDetailAPIResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func getItemsBy(page: Parameter<Int>, willProduce: (Stubber<Single<ItemAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<ItemAPIResponse>] = []
			let given: Given = { return Given(method: .m_getItemsBy__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<ItemAPIResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func getFeaturedArticles(willProduce: (Stubber<Single<FeaturedArticleAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<FeaturedArticleAPIResponse>] = []
			let given: Given = { return Given(method: .m_getFeaturedArticles, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<FeaturedArticleAPIResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func getStories(willProduce: (Stubber<Single<StoryAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<StoryAPIResponse>] = []
			let given: Given = { return Given(method: .m_getStories, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<StoryAPIResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func getAnnouncements(willProduce: (Stubber<Single<AnnouncementListAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<AnnouncementListAPIResponse>] = []
			let given: Given = { return Given(method: .m_getAnnouncements, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<AnnouncementListAPIResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func requestSiginin(mailAddress: Parameter<String>, rawPassword: Parameter<String>, willProduce: (Stubber<Single<SigninSuccessResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<SigninSuccessResponse>] = []
			let given: Given = { return Given(method: .m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<SigninSuccessResponse>).self)
			willProduce(stubber)
			return given
        }
        public static func requestSiginup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, willProduce: (Stubber<Single<GeneralPostSuccessARIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<GeneralPostSuccessARIResponse>] = []
			let given: Given = { return Given(method: .m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<GeneralPostSuccessARIResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getTopBanners() -> Verify { return Verify(method: .m_getTopBanners)}
        public static func getEventIntroductionsBy(page: Parameter<Int>) -> Verify { return Verify(method: .m_getEventIntroductionsBy__page_page(`page`))}
        public static func getRecentAnnouncement() -> Verify { return Verify(method: .m_getRecentAnnouncement)}
        public static func getItemsBy(page: Parameter<Int>) -> Verify { return Verify(method: .m_getItemsBy__page_page(`page`))}
        public static func getFeaturedArticles() -> Verify { return Verify(method: .m_getFeaturedArticles)}
        public static func getStories() -> Verify { return Verify(method: .m_getStories)}
        public static func getAnnouncements() -> Verify { return Verify(method: .m_getAnnouncements)}
        public static func requestSiginin(mailAddress: Parameter<String>, rawPassword: Parameter<String>) -> Verify { return Verify(method: .m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`))}
        public static func requestSiginup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>) -> Verify { return Verify(method: .m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getTopBanners(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getTopBanners, performs: perform)
        }
        public static func getEventIntroductionsBy(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_getEventIntroductionsBy__page_page(`page`), performs: perform)
        }
        public static func getRecentAnnouncement(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getRecentAnnouncement, performs: perform)
        }
        public static func getItemsBy(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_getItemsBy__page_page(`page`), performs: perform)
        }
        public static func getFeaturedArticles(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getFeaturedArticles, performs: perform)
        }
        public static func getStories(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getStories, performs: perform)
        }
        public static func getAnnouncements(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getAnnouncements, performs: perform)
        }
        public static func requestSiginin(mailAddress: Parameter<String>, rawPassword: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_requestSiginin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), performs: perform)
        }
        public static func requestSiginup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, perform: @escaping (String, String, String) -> Void) -> Perform {
            return Perform(method: .m_requestSiginup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - AnnouncementRepository

open class AnnouncementRepositoryMock: AnnouncementRepository, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func requestAnnouncementDataList() -> Single<AnnouncementListAPIResponse> {
        addInvocation(.m_requestAnnouncementDataList)
		let perform = methodPerformValue(.m_requestAnnouncementDataList) as? () -> Void
		perform?()
		var __value: Single<AnnouncementListAPIResponse>
		do {
		    __value = try methodReturnValue(.m_requestAnnouncementDataList).casted()
		} catch {
			onFatalFailure("Stub return value not specified for requestAnnouncementDataList(). Use given")
			Failure("Stub return value not specified for requestAnnouncementDataList(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_requestAnnouncementDataList

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_requestAnnouncementDataList, .m_requestAnnouncementDataList): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_requestAnnouncementDataList: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_requestAnnouncementDataList: return ".requestAnnouncementDataList()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func requestAnnouncementDataList(willReturn: Single<AnnouncementListAPIResponse>...) -> MethodStub {
            return Given(method: .m_requestAnnouncementDataList, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func requestAnnouncementDataList(willProduce: (Stubber<Single<AnnouncementListAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<AnnouncementListAPIResponse>] = []
			let given: Given = { return Given(method: .m_requestAnnouncementDataList, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<AnnouncementListAPIResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func requestAnnouncementDataList() -> Verify { return Verify(method: .m_requestAnnouncementDataList)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func requestAnnouncementDataList(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_requestAnnouncementDataList, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - TutorialRepository

open class TutorialRepositoryMock: TutorialRepository, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getDataList() -> Array<TutorialEntity> {
        addInvocation(.m_getDataList)
		let perform = methodPerformValue(.m_getDataList) as? () -> Void
		perform?()
		var __value: Array<TutorialEntity>
		do {
		    __value = try methodReturnValue(.m_getDataList).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getDataList(). Use given")
			Failure("Stub return value not specified for getDataList(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getDataList

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getDataList, .m_getDataList): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getDataList: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getDataList: return ".getDataList()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getDataList(willReturn: Array<TutorialEntity>...) -> MethodStub {
            return Given(method: .m_getDataList, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getDataList(willProduce: (Stubber<Array<TutorialEntity>>) -> Void) -> MethodStub {
            let willReturn: [Array<TutorialEntity>] = []
			let given: Given = { return Given(method: .m_getDataList, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Array<TutorialEntity>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getDataList() -> Verify { return Verify(method: .m_getDataList)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getDataList(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getDataList, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - TutorialUseCase

open class TutorialUseCaseMock: TutorialUseCase, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute() -> Array<TutorialEntity> {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
		var __value: Array<TutorialEntity>
		do {
		    __value = try methodReturnValue(.m_execute).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(). Use given")
			Failure("Stub return value not specified for execute(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute, .m_execute): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_execute: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute: return ".execute()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(willReturn: Array<TutorialEntity>...) -> MethodStub {
            return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(willProduce: (Stubber<Array<TutorialEntity>>) -> Void) -> MethodStub {
            let willReturn: [Array<TutorialEntity>] = []
			let given: Given = { return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Array<TutorialEntity>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute() -> Verify { return Verify(method: .m_execute)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_execute, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

