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
        DispatchQueue.global().async {
            self.service.fetchSimilarArtists(request: self.request) { (result) in
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
