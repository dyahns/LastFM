import UIKit

class SimilarArtistsViewController: UITableViewController {
    var interactor: Scene.Interactor!
    var router: Scene.Router!
    
    private var viewModel: SimilarArtistsScene.ViewModel? {
        didSet {
            title = viewModel?.artistName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.fetchArtists()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.artists.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let artist = viewModel?.artists[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = artist.name
        cell.detailTextLabel?.text = artist.mbid
        cell.imageView?.image = artist.image

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artist = viewModel?.artists[indexPath.row] else {
            return
        }
        
        router.showSimilarArtists(to: artist)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell.imageView?.image == nil, let artist = viewModel?.artists[indexPath.row] else {
            return
        }

        if artist.image == nil, let url = artist.imageUrl {
            interactor.fetchImage(from: url, for: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

extension SimilarArtistsViewController: SimilarArtistsDisplayProtocol {
    typealias Scene = SimilarArtistsScene
    
    func displayFetchedArtists(with viewModel: SimilarArtistsScene.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func updateImage(data: Data, at index: Int) {
        guard let artists = viewModel?.artists, artists.indices.contains(index), let image = UIImage(data: data) else {
            return
        }
        
        // update view model
        viewModel?.artists[index].image = image
        
        // update cell
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) else {
            return
        }
        cell.imageView?.image = image
        cell.setNeedsLayout()
    }
}
