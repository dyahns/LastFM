import UIKit

class TopArtistsViewController: UITableViewController {
    var interactor: Scene.Interactor!
    var router: Scene.Router!
    
    private var viewModel: TopArtistsScene.ViewModel? {
        didSet {
            tableView.reloadData()
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

        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artist = viewModel?.artists[indexPath.row] else {
            return
        }
        
        router.showSimilarArtists(to: artist)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}

extension TopArtistsViewController: TopArtistsDisplayProtocol {
    typealias Scene = TopArtistsScene
    
    func displayFetchedArtists(with viewModel: TopArtistsScene.ViewModel) {
        self.viewModel = viewModel
    }
}
