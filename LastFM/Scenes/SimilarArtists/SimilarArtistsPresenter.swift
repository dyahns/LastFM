import Foundation

struct SimilarArtistsPresenter: SimilarArtistsPresentationProtocol {
    typealias Scene = SimilarArtistsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func presentFetchedArtists(for data: Result<SimilarArtistsScene.Data, Error>) {
        relayResult(data) { (data) in
            let viewModel = SimilarArtistsScene.ViewModel(response: data.similarartists)
            self.controller?.displayFetchedArtists(with: viewModel)
        }
    }
    
    func presentFetched(data: Result<Data, Error>, for index: Int) {
        relayResult(data) {
            self.controller?.updateImage(data: $0, at: index)
        }
    }
}
