import Foundation

struct LastFmCache {
    static let topArtistsKey = "topArtists"
    static let similarArtistsKey = "similarTo"
}

extension LastFmCache: ServiceProtocol {
    func fetchTopArtists<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        FileManager.default.readFromCache(with: Self.topArtistsKey) { (result) in
            completion(result)
        }
    }
    
    func fetchSimilarArtists<R: MbIdentity, T: Codable>(request: R, completion: @escaping (Result<T, Error>) -> Void) {
        FileManager.default.readFromCache(with: request.similarCacheKey) { (result) in
            completion(result)
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        FileManager.default.readFromCache(with: url.base64) { (result) in
            completion(result)
        }
    }
}

extension LastFmCache: CacheWriter {
    func cache<T: Encodable>(topArtists: T) {
        FileManager.default.cache(data: topArtists, with: Self.topArtistsKey)
    }
    
    func cache<R: MbIdentity, T: Encodable>(similarArtists: T, to request: R) {
        FileManager.default.cache(data: similarArtists, with: request.similarCacheKey)
    }
    
    func cache(data: Data, to url: String) {
        FileManager.default.cache(data: data, with: url.base64)
    }
}

extension MbIdentity {
    var similarCacheKey: String {
        "\(LastFmCache.similarArtistsKey)\(self.name)".base64
    }
}
