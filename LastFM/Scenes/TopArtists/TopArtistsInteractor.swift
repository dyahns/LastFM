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
        DispatchQueue.global().async {
            self.service.fetchTopArtists { (result) in
                self.presenter.presentFetchedArtists(for: result)
            }
        }
    }
    
    func fetchImage(from url: String, for index: Int) {
        DispatchQueue.global().async {
            self.service.fetchData(url: url) { (result) in
                self.presenter.presentFetched(data: result, for: index)
            }
        }
    }
}
