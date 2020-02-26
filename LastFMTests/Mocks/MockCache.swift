import Foundation
@testable import LastFM

class MockCache: ServiceProtocol & CacheWriter {
    var queriedTopArtists = false
    var queriedSimilarArtists = false
    var cachedTopArtists = false
    var cachedSimilarArtists = false

    func cache<T>(topArtists: T) where T : Encodable {
        cachedTopArtists = true
    }
    
    func cache<R, T>(similarArtists: T, to request: R) where R : MbIdentity, T : Encodable {
        cachedSimilarArtists = true
    }
    
    func cache(data: Data, to url: String) {
    }
    
    func fetchTopArtists<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        queriedTopArtists = true
        completion(.failure(MockError.test))
    }
    
    func fetchSimilarArtists<R, T>(request: R, completion: @escaping (Result<T, Error>) -> Void) where R : MbIdentity, T : Decodable, T : Encodable {
        queriedSimilarArtists = true
        completion(.failure(MockError.test))
    }

    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
    }
}
