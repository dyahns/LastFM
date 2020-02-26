import Foundation

struct TopArtistsPresenter: TopArtistsPresentationProtocol {
    typealias Scene = TopArtistsScene
    weak var controller: Scene.Controller?
    
    init(controller: Scene.Controller) {
        self.controller = controller
    }
    
    func presentFetchedArtists(for data: Result<TopArtistsScene.Data, Error>) {
        relayResult(data) { (data) in
            let viewModel = TopArtistsScene.ViewModel(response: data.artists)
            self.controller?.displayFetchedArtists(with: viewModel)
        }
    }
    
    func presentFetched(data: Result<Data, Error>, for index: Int) {
        relayResult(data) {
            self.controller?.updateImage(data: $0, at: index)
        }
    }
}
