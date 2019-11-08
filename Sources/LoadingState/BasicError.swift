import Foundation

public enum BasicError: LocalizedError {
	case `default`
	case message(_ message: String)
	
	public var errorDescription: String? {
		switch self {
		case .default:
			return nil
		case let .message(message):
			return message
		}
	}
	
	public var localizedDescription: String {
		errorDescription ?? "Default basic error"
	}
}
