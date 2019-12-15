import XCTest
@testable import LastFM

struct MockIdentity: MbIdentity {
    let name: String
}

class LastFmAPITests: XCTestCase {
    let url = URL(string: "http://lastfm.com")!
    let urlSession = MockURLSession()

    func testFetchTopArtistsSendsAPIRequest() {
        let service = LastFmAPI(api: API(urlSession: urlSession, baseURL: url))

        service.fetchTopArtists { (result: Result<[Artist], Error>) in
        }
        
        XCTAssertEqual(urlSession.lastRequest?.httpMethod, "GET")
        XCTAssertEqual(urlSession.lastRequest?.url?.query, LastFmAPI.topArtistsQuery)
    }

    func testFetchSimilarArtistsSendsAPIRequest() {
        let service = LastFmAPI(api: API(urlSession: urlSession, baseURL: url))
        let identity = MockIdentity(name: "???")
        
        service.fetchSimilarArtists(request: identity) { (result: Result<[Artist], Error>) in
        }
        
        XCTAssertEqual(urlSession.lastRequest?.httpMethod, "GET")
        XCTAssertEqual(urlSession.lastRequest?.url?.query, LastFmAPI.similarArtistsQuery.injectValue(identity.name))

    }
}
