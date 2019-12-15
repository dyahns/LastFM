import Foundation

protocol SimilarArtistsDisplayProtocol: DisplayProtocol {
    func displayFetchedArtists(with viewModel: SimilarArtistsScene.ViewModel)
}

protocol SimilarArtistsInteractionProtocol: InteractionProtocol {
    func fetchArtists()
}
 
protocol SimilarArtistsPresentationProtocol: PresentationProtocol {
    func presentFetchedArtists(for data: Result<SimilarArtistsScene.Data, Error>)
}

protocol SimilarArtistsRoutingProtocol: RoutingProtocol {
    func showSimilarArtists(to artist: SimilarArtistsScene.ItemViewModel)
}
