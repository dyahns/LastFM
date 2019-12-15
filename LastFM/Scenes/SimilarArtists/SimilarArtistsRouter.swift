import Foundation

struct SimilarArtistsRouter: SimilarArtistsRoutingProtocol {
    typealias Scene = SimilarArtistsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func showSimilarArtists(to artist: SimilarArtistsScene.ItemViewModel) {
        let similarArtistsScene = SimilarArtistsScene.assemble(request: SimilarArtistsScene.Request(name: artist.name))
        controller?.show(similarArtistsScene, sender: nil)
    }
}
