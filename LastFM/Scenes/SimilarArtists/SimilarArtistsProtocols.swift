import Foundation

protocol SimilarArtistsDisplayProtocol: DisplayProtocol {
    func displayFetchedArtists(with viewModel: SimilarArtistsScene.ViewModel)
    func updateImage(data: Data, at index: Int)
}

protocol SimilarArtistsInteractionProtocol: InteractionProtocol {
    func fetchArtists()
    func fetchImage(from url: String, for index: Int)
}
 
protocol SimilarArtistsPresentationProtocol: PresentationProtocol {
    func presentFetchedArtists(for data: Result<SimilarArtistsScene.Data, Error>)
    func presentFetched(data: Result<Data, Error>, for index: Int)
}

protocol SimilarArtistsRoutingProtocol: RoutingProtocol {
    func showSimilarArtists(to artist: SimilarArtistsScene.ItemViewModel)
}
