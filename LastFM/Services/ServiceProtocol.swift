import Foundation

protocol ServiceProtocol {
    func fetchTopArtists<T: Codable>(completion: @escaping (Result<T, Error>) -> Void)
    func fetchSimilarArtists<R: MbIdentity, T: Codable>(request: R, completion: @escaping (Result<T, Error>) -> Void)
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

protocol RootServiceProtocol: ServiceProtocol {
}

protocol CacheWriter {
    func cache<T: Encodable>(topArtists: T)
    func cache<R: MbIdentity, T: Encodable>(similarArtists: T, to request: R)
    func cache(data: Data, to url: String)
}
