import Foundation

protocol TopArtistsDisplayProtocol: DisplayProtocol {
    func displayFetchedArtists(with viewModel: TopArtistsScene.ViewModel)
}

protocol TopArtistsInteractionProtocol: InteractionProtocol {
    func fetchArtists()
}
 
protocol TopArtistsPresentationProtocol: PresentationProtocol {
    func presentFetchedArtists(for data: Result<TopArtistsScene.Data, Error>)
}

protocol TopArtistsRoutingProtocol: RoutingProtocol {
    func showSimilarArtists(to artist: TopArtistsScene.ItemViewModel)
}
