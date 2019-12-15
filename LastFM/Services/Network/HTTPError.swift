import Foundation

enum HTTPError: Error {
    case noResponse
    case requestError(Error)
    case invalidResponse(URLResponse)
    case errorResponse(LastFmError)
    case unsuccessful(statusCode: Int, urlResponse: HTTPURLResponse, error: Error?)
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noResponse:
            return "No Response"
        case .requestError(let error):
            return "Request Error: \(error)"
        case .invalidResponse(let response):
            return "Invalid response. Expected HTTPURLResponse got \(type(of: response))"
        case .errorResponse(let lastFmError):
            return lastFmError.message
        case .unsuccessful(let statusCode, _, _):
            return "Unsuccessful. Status code: \(statusCode)"
        }
    }
}

struct LastFmError: Decodable {
    let error: Int
    let message: String
    
    struct Codes {
        static let invalidApiKey = 10
    }
}
