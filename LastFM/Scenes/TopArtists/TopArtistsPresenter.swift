import Foundation

struct TopArtistsPresenter: TopArtistsPresentationProtocol {
    typealias Scene = TopArtistsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func presentFetchedArtists(for data: Result<TopArtistsScene.Data, Error>) {
        guard case let .success(success) = data else {
            if case let .failure(error) = data {
                onMain {
                    self.controller?.displayError(error)
                }
            }
            return
        }
        
        let viewModel = TopArtistsScene.ViewModel(response: success.artists)
        onMain {
            self.controller?.displayFetchedArtists(with: viewModel)
        }
    }
}
