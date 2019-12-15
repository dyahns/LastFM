import XCTest
@testable import LastFM

class LastFmServiceTests: XCTestCase {
    var service: LastFmService!
    var api: MockAPIService!
    var cache: MockCache!
    
    override func setUp() {
        api = MockAPIService()
        cache = MockCache()
        service = LastFmService(api: api, cache: cache)
    }
    
    func testFetchTopArtistsHitsBothCacheAndApi() {
        let _ = service.fetchTopArtists { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedTopArtists)
        XCTAssertTrue(cache.queriedTopArtists)
    }

    func testFetchTopArtistsFromApiWritesToCache() {
        let _ = service.fetchTopArtists { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedTopArtists)
        XCTAssertTrue(cache.cachedTopArtists)
    }
    
    func testFetchTopArtistsOnApiFailureNoWritingToCache() {
        api.apiShouldSucceed = false
        let _ = service.fetchTopArtists { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedTopArtists)
        XCTAssertFalse(cache.cachedTopArtists)
    }

    func testFetchSimilarArtistsHitsBothCacheAndApi() {
        let _ = service.fetchSimilarArtists(request: SimilarArtistsScene.Request(name: "")) { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedSimilarArtists)
        XCTAssertTrue(cache.queriedSimilarArtists)
    }

    func testFetchSimilarArtistsFromApiWritesToCache() {
        let _ = service.fetchSimilarArtists(request: SimilarArtistsScene.Request(name: "")) { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedSimilarArtists)
        XCTAssertTrue(cache.cachedSimilarArtists)
    }
    
    func testFetchSimilarArtistsOnApiFailureNoWritingToCache() {
        api.apiShouldSucceed = false
        let _ = service.fetchSimilarArtists(request: SimilarArtistsScene.Request(name: "")) { (result: Result<MockModel, Error>) in
        }
        
        XCTAssertTrue(api.queriedSimilarArtists)
        XCTAssertFalse(cache.cachedSimilarArtists)
    }


}
