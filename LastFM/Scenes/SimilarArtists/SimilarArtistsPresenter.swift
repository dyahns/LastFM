import Foundation

struct SimilarArtistsPresenter: SimilarArtistsPresentationProtocol {
    typealias Scene = SimilarArtistsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func presentFetchedArtists(for data: Result<SimilarArtistsScene.Data, Error>) {
        guard case let .success(success) = data else {
            if case let .failure(error) = data {
                onMain {
                    self.controller?.displayError(error)
                }
            }
            return
        }
        
        let viewModel = SimilarArtistsScene.ViewModel(response: success.similarartists)
        onMain {
            self.controller?.displayFetchedArtists(with: viewModel)
        }
    }
}
