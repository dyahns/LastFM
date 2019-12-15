import Foundation
@testable import LastFM

class MockViewController: DisplayProtocol {
    typealias Scene = MockScene
    var interactor: Scene.Interactor!
    var router: Scene.Router!
}
