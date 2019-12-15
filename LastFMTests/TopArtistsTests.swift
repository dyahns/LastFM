import XCTest
@testable import LastFM

class TopArtistsTests: XCTestCase, SceneTests {
    typealias Scene = TopArtistsScene
    var controller: Scene.Controller!
    
    override func setUp() {
        controller = TopArtistsScene.assemble(request: TopArtistsScene.Request(), viewControler: TopArtistsViewController(), service: MockService())
    }
    
    func testCompositionRoot() {
        testSceneReferences()
    }
    
    func testPresenterReferencesControllerWeakly() {
        testPresenterReferencesControllerWeakly(newController: TopArtistsViewController())
    }
    
    func testRouterReferencesControllerWeakly() {
        testRouterReferencesControllerWeakly(newController: TopArtistsViewController())
    }
}
