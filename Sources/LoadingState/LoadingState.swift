import Foundation

public enum LoadingState: Equatable {
	public static var loading: Self { .loading() }
	public static var success: Self { .success() }
	public static var failure: Self { .failure() }
	
	public static func failure(endDate: Date = .init(), message: String = "Unknown error") -> Self {
		.failure(endDate: endDate, error: BasicError.message(message))
	}
	
	case none
	case loading(startDate: Date = .init())
	case success(endDate: Date = .init())
	case failure(endDate: Date = .init(), error: Error)
	
	public init(_ value: Self = .none) {
		self = value
	}
	
	@discardableResult
	public mutating func reset() -> Self {
		self = .none
		return self
	}
	
	@discardableResult
	public mutating func startLoading() -> Self {
		self = .loading
		return self
	}
	
	@discardableResult
	public mutating func succeed() -> Self {
		self = .success
		return self
	}
	
	@discardableResult
	public mutating func fail(error: Error) -> Self {
		self = .failure(error: error)
		return self
	}
	
	@discardableResult
	public mutating func fail(message: String) -> Self {
		self = .failure(message: message)
		return self
	}
	
	public var isNone: Bool {
		get {
			if case .none = self {
				return true
			}
			return false
		}
		set {
			guard newValue else { return }
			self = .none
		}
	}
	
	public var isLoading: Bool {
		get {
			if case .loading(startDate: _) = self {
				return true
			}
			return false
		}
		set {
			self = newValue ? .loading : .none
		}
	}
	
	public var didSucceed: Bool {
		get {
			if case .success(endDate: _) = self {
				return true
			}
			return false
		}
		set {
			self = newValue ? .success : .none
		}
	}
	
	public var didFail: Bool {
		get {
			if case .failure(endDate: _, error: _) = self {
				return true
			}
			return false
		}
		set {
			self = newValue ? .failure(error: BasicError.message("Unknown")) : .none
		}
	}
	
	public var error: Error? {
		if case let .failure(endDate: _, error: error) = self {
			return error
		}
		return nil
	}
	
	internal var baseType: LoadingStateBaseType {
		switch true {
		case isLoading:
			return .loading
		case didSucceed:
			return .success
		case didFail:
			return .failure
		default:
			return .none
		}
	}
	
	public var errorCode: Int? {
		error?._code
	}
	
	public var errorMessage: String? {
		error?.localizedDescription
	}
	
	public var date: Date? {
		switch self {
		case .none:
			return nil
		case let .loading(startDate: startDate):
			return startDate
		case let .success(endDate: endDate):
			return endDate
		case let .failure(endDate: endDate, error: _):
			return endDate
		}
	}
	
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.baseType == rhs.baseType
	}
}
