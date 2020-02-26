import Foundation

protocol TopArtistsDisplayProtocol: DisplayProtocol {
    func displayFetchedArtists(with viewModel: TopArtistsScene.ViewModel)
    func updateImage(data: Data, at index: Int)
}

protocol TopArtistsInteractionProtocol: InteractionProtocol {
    func fetchArtists()
    func fetchImage(from url: String, for index: Int)
}
 
protocol TopArtistsPresentationProtocol: PresentationProtocol {
    func presentFetchedArtists(for data: Result<TopArtistsScene.Data, Error>)
    func presentFetched(data: Result<Data, Error>, for index: Int)
}

protocol TopArtistsRoutingProtocol: RoutingProtocol {
    func showSimilarArtists(to artist: TopArtistsScene.ItemViewModel)
}
