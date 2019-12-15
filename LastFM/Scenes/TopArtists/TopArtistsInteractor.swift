import Foundation

struct TopArtistsInteractor: TopArtistsInteractionProtocol {
    typealias Scene = TopArtistsScene
    let presenter: Scene.Presenter
    let service: RootServiceProtocol

    init(request: Scene.Request, service: RootServiceProtocol, presenter: Scene.Presenter) {
        self.presenter = presenter
        self.service = service
    }
    
    func fetchArtists() {
        service.fetchTopArtists { (result) in
            self.presenter.presentFetchedArtists(for: result)
        }
    }
}
