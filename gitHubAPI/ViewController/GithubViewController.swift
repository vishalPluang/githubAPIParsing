import UIKit

class GithubViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = GithubViewModel()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            loadPopularGithubData()
    }
        
    private func loadPopularGithubData() {
        viewModel.fetchPopularGithubData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
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
        //let detailsViewConroller = DetailsViewController()
        //self.navigationController?.pushViewController(detailsViewConroller, animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        vc?.repoItem = repoItem
        self.navigationController?.pushViewController(vc!, animated: true)
        //vc?.showDetails(repoItem)
        
    }
}

