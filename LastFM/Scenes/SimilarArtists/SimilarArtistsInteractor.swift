import Foundation

struct SimilarArtistsInteractor: SimilarArtistsInteractionProtocol {
    typealias Scene = SimilarArtistsScene
    let presenter: Scene.Presenter
    let request: Scene.Request
    let service: RootServiceProtocol
    
    init(request: Scene.Request, service: RootServiceProtocol, presenter: Scene.Presenter) {
        self.request = request
        self.service = service
        self.presenter = presenter
    }
    
    func fetchArtists() {
        service.fetchSimilarArtists(request: request) { (result) in
            self.presenter.presentFetchedArtists(for: result)
        }
    }
}
