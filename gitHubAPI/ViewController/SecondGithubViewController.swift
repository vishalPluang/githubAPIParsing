import UIKit
import DropDown

class SecondGithubViewController: UIViewController
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView?
    
    var viewModel = GithubViewModel(_cdGithubDataRepository: CoreDataRepository(), _githubApiRepository: ApiService())
    var selectedLanguage : String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Treding Repositry"
        loadPopularGithubData()
    }

    deinit
    {
        print("------ Second GithubViewController is removed from memory -------")
    }
    
    func loadPopularGithubData()
    {
        activityIndicator.startAnimating()
        viewModel.fetchPopularGithubData(lang: selectedLanguage!){ [weak self] in
            self?.tableView?.dataSource = self
            self?.tableView?.delegate = self
            self?.tableView?.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}

extension SecondGithubViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GithubTableViewCell
        
        cell.selectionStyle = .none
        let githubItem = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(githubItem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let repoItem = viewModel.cellForRowAt(indexPath: indexPath)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewDetailsViewController") as? NewDetailsViewController
        vc?.repoItem = repoItem
        if let cell = tableView.cellForRow(at: indexPath) as? GithubTableViewCell
        {
            let image = cell.posterImage.image
            vc?.image = image
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

