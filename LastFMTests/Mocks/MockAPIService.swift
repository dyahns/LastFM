import Foundation
@testable import LastFM

class MockAPIService: ServiceProtocol {
    var apiShouldSucceed = true
    var queriedTopArtists = false
    var queriedSimilarArtists = false

    func fetchTopArtists<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        queriedTopArtists = true
        
        if apiShouldSucceed {
            completion(Result.success(MockModel(value: 1) as! T))
        } else {
            completion(.failure(MockError.test))
        }
    }
    
    func fetchSimilarArtists<R, T>(request: R, completion: @escaping (Result<T, Error>) -> Void) where R : MbIdentity, T : Decodable, T : Encodable {
        queriedSimilarArtists = true

        if apiShouldSucceed {
            completion(Result.success(MockModel(value: 1) as! T))
        } else {
            completion(.failure(MockError.test))
        }
    }
}
