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

// MARK: - ApplicationUserRepository

open class ApplicationUserRepositoryMock: ApplicationUserRepository, Mock {
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





    open func updatePassTutorialStatus() {
        addInvocation(.m_updatePassTutorialStatus)
		let perform = methodPerformValue(.m_updatePassTutorialStatus) as? () -> Void
		perform?()
    }

    open func updateJsonAccessToken(_ token: String) {
        addInvocation(.m_updateJsonAccessToken__token(Parameter<String>.value(`token`)))
		let perform = methodPerformValue(.m_updateJsonAccessToken__token(Parameter<String>.value(`token`))) as? (String) -> Void
		perform?(`token`)
    }


    fileprivate enum MethodType {
        case m_updatePassTutorialStatus
        case m_updateJsonAccessToken__token(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_updatePassTutorialStatus, .m_updatePassTutorialStatus): return .match

            case (.m_updateJsonAccessToken__token(let lhsToken), .m_updateJsonAccessToken__token(let rhsToken)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "_ token"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_updatePassTutorialStatus: return 0
            case let .m_updateJsonAccessToken__token(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_updatePassTutorialStatus: return ".updatePassTutorialStatus()"
            case .m_updateJsonAccessToken__token: return ".updateJsonAccessToken(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func updatePassTutorialStatus() -> Verify { return Verify(method: .m_updatePassTutorialStatus)}
        public static func updateJsonAccessToken(_ token: Parameter<String>) -> Verify { return Verify(method: .m_updateJsonAccessToken__token(`token`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func updatePassTutorialStatus(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_updatePassTutorialStatus, performs: perform)
        }
        public static func updateJsonAccessToken(_ token: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_updateJsonAccessToken__token(`token`), performs: perform)
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

// MARK: - ApplicationUserStatusUseCase

open class ApplicationUserStatusUseCaseMock: ApplicationUserStatusUseCase, Mock {
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





    open func executeUpdatePassTutorialStatus() {
        addInvocation(.m_executeUpdatePassTutorialStatus)
		let perform = methodPerformValue(.m_executeUpdatePassTutorialStatus) as? () -> Void
		perform?()
    }

    open func executeUpdateToken(_ token: String) {
        addInvocation(.m_executeUpdateToken__token(Parameter<String>.value(`token`)))
		let perform = methodPerformValue(.m_executeUpdateToken__token(Parameter<String>.value(`token`))) as? (String) -> Void
		perform?(`token`)
    }


    fileprivate enum MethodType {
        case m_executeUpdatePassTutorialStatus
        case m_executeUpdateToken__token(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_executeUpdatePassTutorialStatus, .m_executeUpdatePassTutorialStatus): return .match

            case (.m_executeUpdateToken__token(let lhsToken), .m_executeUpdateToken__token(let rhsToken)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "_ token"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_executeUpdatePassTutorialStatus: return 0
            case let .m_executeUpdateToken__token(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_executeUpdatePassTutorialStatus: return ".executeUpdatePassTutorialStatus()"
            case .m_executeUpdateToken__token: return ".executeUpdateToken(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func executeUpdatePassTutorialStatus() -> Verify { return Verify(method: .m_executeUpdatePassTutorialStatus)}
        public static func executeUpdateToken(_ token: Parameter<String>) -> Verify { return Verify(method: .m_executeUpdateToken__token(`token`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func executeUpdatePassTutorialStatus(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_executeUpdatePassTutorialStatus, performs: perform)
        }
        public static func executeUpdateToken(_ token: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_executeUpdateToken__token(`token`), performs: perform)
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

// MARK: - KeychainAccessProtocol

open class KeychainAccessProtocolMock: KeychainAccessProtocol, Mock {
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





    open func saveJsonAccessToken(_ token: String) {
        addInvocation(.m_saveJsonAccessToken__token(Parameter<String>.value(`token`)))
		let perform = methodPerformValue(.m_saveJsonAccessToken__token(Parameter<String>.value(`token`))) as? (String) -> Void
		perform?(`token`)
    }

    open func deleteJsonAccessToken() {
        addInvocation(.m_deleteJsonAccessToken)
		let perform = methodPerformValue(.m_deleteJsonAccessToken) as? () -> Void
		perform?()
    }

    open func existsJsonAccessToken() -> Bool {
        addInvocation(.m_existsJsonAccessToken)
		let perform = methodPerformValue(.m_existsJsonAccessToken) as? () -> Void
		perform?()
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_existsJsonAccessToken).casted()
		} catch {
			onFatalFailure("Stub return value not specified for existsJsonAccessToken(). Use given")
			Failure("Stub return value not specified for existsJsonAccessToken(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_saveJsonAccessToken__token(Parameter<String>)
        case m_deleteJsonAccessToken
        case m_existsJsonAccessToken

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_saveJsonAccessToken__token(let lhsToken), .m_saveJsonAccessToken__token(let rhsToken)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "_ token"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteJsonAccessToken, .m_deleteJsonAccessToken): return .match

            case (.m_existsJsonAccessToken, .m_existsJsonAccessToken): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_saveJsonAccessToken__token(p0): return p0.intValue
            case .m_deleteJsonAccessToken: return 0
            case .m_existsJsonAccessToken: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_saveJsonAccessToken__token: return ".saveJsonAccessToken(_:)"
            case .m_deleteJsonAccessToken: return ".deleteJsonAccessToken()"
            case .m_existsJsonAccessToken: return ".existsJsonAccessToken()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func existsJsonAccessToken(willReturn: Bool...) -> MethodStub {
            return Given(method: .m_existsJsonAccessToken, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func existsJsonAccessToken(willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_existsJsonAccessToken, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func saveJsonAccessToken(_ token: Parameter<String>) -> Verify { return Verify(method: .m_saveJsonAccessToken__token(`token`))}
        public static func deleteJsonAccessToken() -> Verify { return Verify(method: .m_deleteJsonAccessToken)}
        public static func existsJsonAccessToken() -> Verify { return Verify(method: .m_existsJsonAccessToken)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func saveJsonAccessToken(_ token: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_saveJsonAccessToken__token(`token`), performs: perform)
        }
        public static func deleteJsonAccessToken(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_deleteJsonAccessToken, performs: perform)
        }
        public static func existsJsonAccessToken(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_existsJsonAccessToken, performs: perform)
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

// MARK: - MainRepository

open class MainRepositoryMock: MainRepository, Mock {
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





    open func searchApplicationUserData() -> ApplicationUserStatus {
        addInvocation(.m_searchApplicationUserData)
		let perform = methodPerformValue(.m_searchApplicationUserData) as? () -> Void
		perform?()
		var __value: ApplicationUserStatus
		do {
		    __value = try methodReturnValue(.m_searchApplicationUserData).casted()
		} catch {
			onFatalFailure("Stub return value not specified for searchApplicationUserData(). Use given")
			Failure("Stub return value not specified for searchApplicationUserData(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_searchApplicationUserData

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_searchApplicationUserData, .m_searchApplicationUserData): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_searchApplicationUserData: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_searchApplicationUserData: return ".searchApplicationUserData()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func searchApplicationUserData(willReturn: ApplicationUserStatus...) -> MethodStub {
            return Given(method: .m_searchApplicationUserData, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func searchApplicationUserData(willProduce: (Stubber<ApplicationUserStatus>) -> Void) -> MethodStub {
            let willReturn: [ApplicationUserStatus] = []
			let given: Given = { return Given(method: .m_searchApplicationUserData, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (ApplicationUserStatus).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func searchApplicationUserData() -> Verify { return Verify(method: .m_searchApplicationUserData)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func searchApplicationUserData(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_searchApplicationUserData, performs: perform)
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

// MARK: - MainScreenUseCase

open class MainScreenUseCaseMock: MainScreenUseCase, Mock {
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





    open func execute() -> ApplicationUserStatus {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
		var __value: ApplicationUserStatus
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


        public static func execute(willReturn: ApplicationUserStatus...) -> MethodStub {
            return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(willProduce: (Stubber<ApplicationUserStatus>) -> Void) -> MethodStub {
            let willReturn: [ApplicationUserStatus] = []
			let given: Given = { return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (ApplicationUserStatus).self)
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

// MARK: - RealmAccessProtocol

open class RealmAccessProtocolMock: RealmAccessProtocol, Mock {
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





    open func getApplicationUser() -> ApplicationUserEntity? {
        addInvocation(.m_getApplicationUser)
		let perform = methodPerformValue(.m_getApplicationUser) as? () -> Void
		perform?()
		var __value: ApplicationUserEntity? = nil
		do {
		    __value = try methodReturnValue(.m_getApplicationUser).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func saveApplicationUser(_ applicationUserEntity: ApplicationUserEntity) {
        addInvocation(.m_saveApplicationUser__applicationUserEntity(Parameter<ApplicationUserEntity>.value(`applicationUserEntity`)))
		let perform = methodPerformValue(.m_saveApplicationUser__applicationUserEntity(Parameter<ApplicationUserEntity>.value(`applicationUserEntity`))) as? (ApplicationUserEntity) -> Void
		perform?(`applicationUserEntity`)
    }

    open func deleteApplicationUser(_ applicationUserEntity: ApplicationUserEntity) {
        addInvocation(.m_deleteApplicationUser__applicationUserEntity(Parameter<ApplicationUserEntity>.value(`applicationUserEntity`)))
		let perform = methodPerformValue(.m_deleteApplicationUser__applicationUserEntity(Parameter<ApplicationUserEntity>.value(`applicationUserEntity`))) as? (ApplicationUserEntity) -> Void
		perform?(`applicationUserEntity`)
    }


    fileprivate enum MethodType {
        case m_getApplicationUser
        case m_saveApplicationUser__applicationUserEntity(Parameter<ApplicationUserEntity>)
        case m_deleteApplicationUser__applicationUserEntity(Parameter<ApplicationUserEntity>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getApplicationUser, .m_getApplicationUser): return .match

            case (.m_saveApplicationUser__applicationUserEntity(let lhsApplicationuserentity), .m_saveApplicationUser__applicationUserEntity(let rhsApplicationuserentity)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsApplicationuserentity, rhs: rhsApplicationuserentity, with: matcher), lhsApplicationuserentity, rhsApplicationuserentity, "_ applicationUserEntity"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteApplicationUser__applicationUserEntity(let lhsApplicationuserentity), .m_deleteApplicationUser__applicationUserEntity(let rhsApplicationuserentity)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsApplicationuserentity, rhs: rhsApplicationuserentity, with: matcher), lhsApplicationuserentity, rhsApplicationuserentity, "_ applicationUserEntity"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getApplicationUser: return 0
            case let .m_saveApplicationUser__applicationUserEntity(p0): return p0.intValue
            case let .m_deleteApplicationUser__applicationUserEntity(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getApplicationUser: return ".getApplicationUser()"
            case .m_saveApplicationUser__applicationUserEntity: return ".saveApplicationUser(_:)"
            case .m_deleteApplicationUser__applicationUserEntity: return ".deleteApplicationUser(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getApplicationUser(willReturn: ApplicationUserEntity?...) -> MethodStub {
            return Given(method: .m_getApplicationUser, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getApplicationUser(willProduce: (Stubber<ApplicationUserEntity?>) -> Void) -> MethodStub {
            let willReturn: [ApplicationUserEntity?] = []
			let given: Given = { return Given(method: .m_getApplicationUser, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (ApplicationUserEntity?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getApplicationUser() -> Verify { return Verify(method: .m_getApplicationUser)}
        public static func saveApplicationUser(_ applicationUserEntity: Parameter<ApplicationUserEntity>) -> Verify { return Verify(method: .m_saveApplicationUser__applicationUserEntity(`applicationUserEntity`))}
        public static func deleteApplicationUser(_ applicationUserEntity: Parameter<ApplicationUserEntity>) -> Verify { return Verify(method: .m_deleteApplicationUser__applicationUserEntity(`applicationUserEntity`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getApplicationUser(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getApplicationUser, performs: perform)
        }
        public static func saveApplicationUser(_ applicationUserEntity: Parameter<ApplicationUserEntity>, perform: @escaping (ApplicationUserEntity) -> Void) -> Perform {
            return Perform(method: .m_saveApplicationUser__applicationUserEntity(`applicationUserEntity`), performs: perform)
        }
        public static func deleteApplicationUser(_ applicationUserEntity: Parameter<ApplicationUserEntity>, perform: @escaping (ApplicationUserEntity) -> Void) -> Perform {
            return Perform(method: .m_deleteApplicationUser__applicationUserEntity(`applicationUserEntity`), performs: perform)
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

// MARK: - RecentAnnouncementRepository

open class RecentAnnouncementRepositoryMock: RecentAnnouncementRepository, Mock {
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





    open func requestRecentAnnouncementData() -> Single<AnnouncementDetailAPIResponse> {
        addInvocation(.m_requestRecentAnnouncementData)
		let perform = methodPerformValue(.m_requestRecentAnnouncementData) as? () -> Void
		perform?()
		var __value: Single<AnnouncementDetailAPIResponse>
		do {
		    __value = try methodReturnValue(.m_requestRecentAnnouncementData).casted()
		} catch {
			onFatalFailure("Stub return value not specified for requestRecentAnnouncementData(). Use given")
			Failure("Stub return value not specified for requestRecentAnnouncementData(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_requestRecentAnnouncementData

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_requestRecentAnnouncementData, .m_requestRecentAnnouncementData): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_requestRecentAnnouncementData: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_requestRecentAnnouncementData: return ".requestRecentAnnouncementData()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func requestRecentAnnouncementData(willReturn: Single<AnnouncementDetailAPIResponse>...) -> MethodStub {
            return Given(method: .m_requestRecentAnnouncementData, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func requestRecentAnnouncementData(willProduce: (Stubber<Single<AnnouncementDetailAPIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<AnnouncementDetailAPIResponse>] = []
			let given: Given = { return Given(method: .m_requestRecentAnnouncementData, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<AnnouncementDetailAPIResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func requestRecentAnnouncementData() -> Verify { return Verify(method: .m_requestRecentAnnouncementData)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func requestRecentAnnouncementData(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_requestRecentAnnouncementData, performs: perform)
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

// MARK: - SigninRepository

open class SigninRepositoryMock: SigninRepository, Mock {
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





    open func requestSignin(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse> {
        addInvocation(.m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`)))
		let perform = methodPerformValue(.m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))) as? (String, String) -> Void
		perform?(`mailAddress`, `rawPassword`)
		var __value: Single<SigninSuccessResponse>
		do {
		    __value = try methodReturnValue(.m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for requestSignin(mailAddress: String, rawPassword: String). Use given")
			Failure("Stub return value not specified for requestSignin(mailAddress: String, rawPassword: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(let lhsMailaddress, let lhsRawpassword), .m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(let rhsMailaddress, let rhsRawpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMailaddress, rhs: rhsMailaddress, with: matcher), lhsMailaddress, rhsMailaddress, "mailAddress"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawpassword, rhs: rhsRawpassword, with: matcher), lhsRawpassword, rhsRawpassword, "rawPassword"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword: return ".requestSignin(mailAddress:rawPassword:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func requestSignin(mailAddress: Parameter<String>, rawPassword: Parameter<String>, willReturn: Single<SigninSuccessResponse>...) -> MethodStub {
            return Given(method: .m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func requestSignin(mailAddress: Parameter<String>, rawPassword: Parameter<String>, willProduce: (Stubber<Single<SigninSuccessResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<SigninSuccessResponse>] = []
			let given: Given = { return Given(method: .m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<SigninSuccessResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func requestSignin(mailAddress: Parameter<String>, rawPassword: Parameter<String>) -> Verify { return Verify(method: .m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func requestSignin(mailAddress: Parameter<String>, rawPassword: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_requestSignin__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), performs: perform)
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

// MARK: - SigninUsecase

open class SigninUsecaseMock: SigninUsecase, Mock {
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





    open func execute(mailAddress: String, rawPassword: String) -> Single<SigninSuccessResponse> {
        addInvocation(.m_execute__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`)))
		let perform = methodPerformValue(.m_execute__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))) as? (String, String) -> Void
		perform?(`mailAddress`, `rawPassword`)
		var __value: Single<SigninSuccessResponse>
		do {
		    __value = try methodReturnValue(.m_execute__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(mailAddress: String, rawPassword: String). Use given")
			Failure("Stub return value not specified for execute(mailAddress: String, rawPassword: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__mailAddress_mailAddressrawPassword_rawPassword(Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__mailAddress_mailAddressrawPassword_rawPassword(let lhsMailaddress, let lhsRawpassword), .m_execute__mailAddress_mailAddressrawPassword_rawPassword(let rhsMailaddress, let rhsRawpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMailaddress, rhs: rhsMailaddress, with: matcher), lhsMailaddress, rhsMailaddress, "mailAddress"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawpassword, rhs: rhsRawpassword, with: matcher), lhsRawpassword, rhsRawpassword, "rawPassword"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__mailAddress_mailAddressrawPassword_rawPassword(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__mailAddress_mailAddressrawPassword_rawPassword: return ".execute(mailAddress:rawPassword:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(mailAddress: Parameter<String>, rawPassword: Parameter<String>, willReturn: Single<SigninSuccessResponse>...) -> MethodStub {
            return Given(method: .m_execute__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(mailAddress: Parameter<String>, rawPassword: Parameter<String>, willProduce: (Stubber<Single<SigninSuccessResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<SigninSuccessResponse>] = []
			let given: Given = { return Given(method: .m_execute__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<SigninSuccessResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(mailAddress: Parameter<String>, rawPassword: Parameter<String>) -> Verify { return Verify(method: .m_execute__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(mailAddress: Parameter<String>, rawPassword: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_execute__mailAddress_mailAddressrawPassword_rawPassword(`mailAddress`, `rawPassword`), performs: perform)
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

// MARK: - SignupRepository

open class SignupRepositoryMock: SignupRepository, Mock {
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





    open func requestSignup(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse> {
        addInvocation(.m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`)))
		let perform = methodPerformValue(.m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))) as? (String, String, String) -> Void
		perform?(`userName`, `mailAddress`, `rawPassword`)
		var __value: Single<GeneralPostSuccessARIResponse>
		do {
		    __value = try methodReturnValue(.m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for requestSignup(userName: String, mailAddress: String, rawPassword: String). Use given")
			Failure("Stub return value not specified for requestSignup(userName: String, mailAddress: String, rawPassword: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>, Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(let lhsUsername, let lhsMailaddress, let lhsRawpassword), .m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(let rhsUsername, let rhsMailaddress, let rhsRawpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUsername, rhs: rhsUsername, with: matcher), lhsUsername, rhsUsername, "userName"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMailaddress, rhs: rhsMailaddress, with: matcher), lhsMailaddress, rhsMailaddress, "mailAddress"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawpassword, rhs: rhsRawpassword, with: matcher), lhsRawpassword, rhsRawpassword, "rawPassword"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword: return ".requestSignup(userName:mailAddress:rawPassword:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func requestSignup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, willReturn: Single<GeneralPostSuccessARIResponse>...) -> MethodStub {
            return Given(method: .m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func requestSignup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, willProduce: (Stubber<Single<GeneralPostSuccessARIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<GeneralPostSuccessARIResponse>] = []
			let given: Given = { return Given(method: .m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<GeneralPostSuccessARIResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func requestSignup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>) -> Verify { return Verify(method: .m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func requestSignup(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, perform: @escaping (String, String, String) -> Void) -> Perform {
            return Perform(method: .m_requestSignup__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), performs: perform)
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

// MARK: - SignupUsecase

open class SignupUsecaseMock: SignupUsecase, Mock {
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





    open func execute(userName: String, mailAddress: String, rawPassword: String) -> Single<GeneralPostSuccessARIResponse> {
        addInvocation(.m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`)))
		let perform = methodPerformValue(.m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))) as? (String, String, String) -> Void
		perform?(`userName`, `mailAddress`, `rawPassword`)
		var __value: Single<GeneralPostSuccessARIResponse>
		do {
		    __value = try methodReturnValue(.m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>.value(`userName`), Parameter<String>.value(`mailAddress`), Parameter<String>.value(`rawPassword`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(userName: String, mailAddress: String, rawPassword: String). Use given")
			Failure("Stub return value not specified for execute(userName: String, mailAddress: String, rawPassword: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(Parameter<String>, Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(let lhsUsername, let lhsMailaddress, let lhsRawpassword), .m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(let rhsUsername, let rhsMailaddress, let rhsRawpassword)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUsername, rhs: rhsUsername, with: matcher), lhsUsername, rhsUsername, "userName"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMailaddress, rhs: rhsMailaddress, with: matcher), lhsMailaddress, rhsMailaddress, "mailAddress"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRawpassword, rhs: rhsRawpassword, with: matcher), lhsRawpassword, rhsRawpassword, "rawPassword"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword: return ".execute(userName:mailAddress:rawPassword:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, willReturn: Single<GeneralPostSuccessARIResponse>...) -> MethodStub {
            return Given(method: .m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, willProduce: (Stubber<Single<GeneralPostSuccessARIResponse>>) -> Void) -> MethodStub {
            let willReturn: [Single<GeneralPostSuccessARIResponse>] = []
			let given: Given = { return Given(method: .m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<GeneralPostSuccessARIResponse>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>) -> Verify { return Verify(method: .m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(userName: Parameter<String>, mailAddress: Parameter<String>, rawPassword: Parameter<String>, perform: @escaping (String, String, String) -> Void) -> Perform {
            return Perform(method: .m_execute__userName_userNamemailAddress_mailAddressrawPassword_rawPassword(`userName`, `mailAddress`, `rawPassword`), performs: perform)
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

