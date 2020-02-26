import Foundation

struct Artist: Codable {
    let mbid: String?
    let name: String
    let image: [ImageSize: String]
    
    struct ArtistImage: Codable {
        let size: String
        let url: String
        
        private enum CodingKeys: String, CodingKey {
            case size
            case url = "#text"
        }
    }
    
    enum ImageSize: String, Codable {
        case small
        case medium
        case large
        case extralarge
        case mega
    }
}

extension Artist {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mbid = try? values.decode(String.self, forKey: .mbid)
        name = try values.decode(String.self, forKey: .name)

        if let cachedImage = try? values.decode([ImageSize: String].self, forKey: .image) {
            // from cache
            image = cachedImage
        } else {
            // from server
            let imageArray = try values.decode([ArtistImage].self, forKey: .image)
            image = imageArray.reduce([ImageSize: String]()) { (dict, image) -> [ImageSize: String] in
                guard let size = ImageSize(rawValue: image.size) else { return dict }
                var dict = dict
                dict[size] = image.url
                return dict
            }
        }
    }
}
