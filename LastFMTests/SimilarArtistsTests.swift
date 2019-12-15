import XCTest
@testable import LastFM

class SimilarArtistsTests: XCTestCase, SceneTests {
    var controller: Scene.Controller!
    typealias Scene = SimilarArtistsScene

    override func setUp() {
        controller = SimilarArtistsScene.assemble(request: SimilarArtistsScene.Request(name: ""), viewControler: SimilarArtistsViewController(), service: MockService())
    }
    
    func testCompositionRoot() {
        testSceneReferences()
    }
    
    func testPresenterReferencesControllerWeakly() {
        testPresenterReferencesControllerWeakly(newController: SimilarArtistsViewController())
    }

    func testRouterReferencesControllerWeakly() {
        testRouterReferencesControllerWeakly(newController: SimilarArtistsViewController())
    }
}
