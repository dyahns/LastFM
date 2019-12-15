import Foundation

struct TopArtistsRouter: TopArtistsRoutingProtocol {
    typealias Scene = TopArtistsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func showSimilarArtists(to artist: TopArtistsScene.ItemViewModel) {
        let similarArtistsScene = SimilarArtistsScene.assemble(request: SimilarArtistsScene.Request(name: artist.name))
        controller?.show(similarArtistsScene, sender: nil)
    }
}
