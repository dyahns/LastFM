import Foundation

struct LastFmService: RootServiceProtocol {
    static let defaultConfig = LastFmService(api: LastFmAPI(api: API(urlSession: URLSession.shared, baseURL: LastFmAPI.baseURL)), cache: LastFmCache())
    
    init(api: ServiceProtocol, cache: (ServiceProtocol & CacheWriter)?) {
        self.api = api
        self.cache = cache
    }
    
    private let api: ServiceProtocol
    private let cache: (ServiceProtocol & CacheWriter)?

    func fetchTopArtists<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        let semaphore = ServiceSemaphore()

        api.fetchTopArtists { (result: Result<T, Error>) in
            let data = try? result.get()
            semaphore.priorityHandler(success: data != nil) {
                completion(result)
            }
            
            if let data = data {
                self.cache?.cache(topArtists: data)
            }
        }

        cache?.fetchTopArtists { (result) in
            semaphore.failoverHandler {
                completion(result)
            }
        }
    }
    
    func fetchSimilarArtists<R: MbIdentity, T: Codable>(request: R, completion: @escaping (Result<T, Error>) -> Void) {
        let semaphore = ServiceSemaphore()

        api.fetchSimilarArtists(request: request) { (result: Result<T, Error>) in
            let data = try? result.get()
            semaphore.priorityHandler(success: data != nil) {
                completion(result)
            }
            
            if let data = data {
                self.cache?.cache(similarArtists: data, to: request)
            }
        }
        
        cache?.fetchSimilarArtists(request: request) { (result) in
            semaphore.priorityHandler(success: (try? result.get()) != nil) {
                completion(result)
            }
        }
    }
}
