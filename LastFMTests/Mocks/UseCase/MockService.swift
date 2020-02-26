import Foundation
@testable import LastFM

struct MockService: RootServiceProtocol {
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
    }
    
    func fetchTopArtists<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
    }
    
    func fetchSimilarArtists<R, T>(request: R, completion: @escaping (Result<T, Error>) -> Void) where R : MbIdentity, T : Decodable, T : Encodable {
    }
}
