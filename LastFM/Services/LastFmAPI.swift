import Foundation

struct LastFmAPI: ServiceProtocol {
    static let apiKeySettingKey = "api_key"
    static let baseURL = URL(string: "http://ws.audioscrobbler.com/2.0/")!
    static let topArtistsQuery = "method=chart.gettopartists&api_key=\(Self.lastFmApiKey)&format=json"
    static let similarArtistsQuery = "method=artist.getsimilar&artist=@@@&api_key=\(Self.lastFmApiKey)&format=json"
    
    private let api: API
    
    init(api: API) {
        self.api = api
    }
    
    func fetchTopArtists<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        let endpoint = Endpoint<T>(path: "", query: Self.topArtistsQuery)
        
        api.load(endpoint, completion: { (result) in
            completion(result)
        })
    }
    
    func fetchSimilarArtists<R: MbIdentity, T: Decodable>(request: R, completion: @escaping (Result<T, Error>) -> Void) {
        let query = Self.similarArtistsQuery.injectValue(request.name)
        let endpoint = Endpoint<T>(path: "", query: query)
        
        api.load(endpoint, completion: { (result) in
            completion(result)
        })
    }
    
    static var lastFmApiKey: String {
        guard let apiKey = UserDefaults.standard.string(forKey: self.apiKeySettingKey), !apiKey.trimmingCharacters(in: .whitespaces).isEmpty else {
            return ""
        }

        return apiKey
    }
}

extension String {
    func injectValue(_ value: String) -> String {
        self.replacingOccurrences(of: "@@@", with: value)
    }
}
