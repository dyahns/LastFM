import UIKit

enum TopArtistsScene: AppScene {
    typealias Controller = TopArtistsViewController
    typealias Interactor = TopArtistsInteractor
    typealias Presenter = TopArtistsPresenter
    typealias Router = TopArtistsRouter

    static let viewResource: (storyboard: String, identifier: String?) = ("TopArtists", nil)
    static let service: RootServiceProtocol = LastFmService.defaultConfig

    struct Request {
    }

    struct Data: Codable {
        let artists: ArtistsList

        struct ArtistsList: Codable {
            let artist: [Artist]
            let attr: Attributes

            struct Attributes: Codable {
                let page: String
                let perPage: String
                let totalPages: String
                let total: String
            }
            
            private enum CodingKeys: String, CodingKey {
                case artist
                case attr = "@attr"
            }
        }
    }

    struct ViewModel {
        var artists: [ItemViewModel]
        
        init(response: Data.ArtistsList) {
            artists = response.artist.map { TopArtistsScene.ItemViewModel($0) }
        }
    }
    
    struct ItemViewModel {
        let mbid: String
        let name: String
        let imageUrl: String?
        var image: UIImage?
        
        init(_ artist: Artist) {
            mbid = (artist.mbid ?? "").isEmpty ? "n/a" : artist.mbid!
            name = artist.name
            imageUrl = artist.image[.medium] ?? artist.image[.large]
        }
    }
}
