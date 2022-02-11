import UIKit

class GithubViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = GithubViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popular Repostries"
        loadPopularGithubData()
    }
        
    private func loadPopularGithubData() {
        
        activityIndicator.startAnimating()
        viewModel.fetchPopularGithubData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}

extension GithubViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GithubTableViewCell
        
        let githubItem = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(githubItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let repoItem = viewModel.cellForRowAt(indexPath: indexPath)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewDetailsViewController") as? NewDetailsViewController
        vc?.repoItem = repoItem
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

