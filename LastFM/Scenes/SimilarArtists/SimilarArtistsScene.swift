import Foundation

enum SimilarArtistsScene: AppScene {
    typealias Controller = SimilarArtistsViewController
    typealias Interactor = SimilarArtistsInteractor
    typealias Presenter = SimilarArtistsPresenter
    typealias Router = SimilarArtistsRouter

    static let viewResource: (storyboard: String, identifier: String?) = ("SimilarArtists", nil)
    static let service: RootServiceProtocol = LastFmService.defaultConfig

    struct Request: MbIdentity {
        let name: String
    }

    struct Data: Codable {
        let similarartists: ArtistsList

        struct ArtistsList: Codable {
            let artist: [Artist]
            let attr: Attributes

            struct Attributes: Codable {
                let artist: String
            }
            
            private enum CodingKeys: String, CodingKey {
                case artist
                case attr = "@attr"
            }
        }
    }

    struct ViewModel {
        let artistName: String
        let artists: [ItemViewModel]
        
        init(response: Data.ArtistsList) {
            artistName = response.attr.artist
            artists = response.artist.map { ItemViewModel($0) }
        }
    }
    
    struct ItemViewModel {
        let mbid: String?
        let name: String
        
        init(_ artist: Artist) {
            mbid = artist.mbid
            name = artist.name
        }
    }
}
