import Foundation

enum BasicError: LocalizedError {
	case `default`
	case message(_ message: String)
	
	var errorDescription: String? {
		switch self {
		case .default:
			return nil
		case let .message(message):
			return message
		}
	}
	
	var localizedDescription: String {
		errorDescription ?? "Default basic error"
	}
}
