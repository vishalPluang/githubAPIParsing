import UIKit
import DropDown

class GithubViewController: UIViewController
{
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var dropDownview: UIView!
    @IBOutlet weak var selectedDropdown: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView?
    
    var viewModel = GithubViewModel(_cdGithubDataRepository: CoreDataRepository(), _githubApiRepository: ApiService())
    let dropDown = DropDown()
    let dropDownValues = ["C", "Java", "Python", "Swift", "Scala", "Golang","None"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Treding Repositry"
        loadDropDown()
    }
    
    private func loadDropDown()
    {
        selectedDropdown.text = "Select a language for trending repositry"
        dropDown.anchorView = dropDownview
        dropDown.dataSource = dropDownValues
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            selectedDropdown.text = item
            if(item != "none")
            {
                loadPopularGithubData(selectedLang: selectedDropdown.text!)
            }
            else
            {
                viewDidLoad()
                tableView?.dataSource = nil
                tableView?.reloadData()
            }
        }
    }
    
    @IBAction func showLanguages(_ sender: Any)
    {
        dropDown.show()
        dropDownButton.setTitle("down", for: .normal)
    }

    deinit
    {
        print("------ GithubViewController is removed from memory -------")
    }
    
    func loadPopularGithubData(selectedLang: String)
    {
        activityIndicator.startAnimating()
        viewModel.fetchPopularGithubData(lang: selectedLang){ [weak self] in
            self?.tableView?.dataSource = self
            self?.tableView?.delegate = self
            self?.tableView?.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.dropDownButton.setTitle("up", for: .normal)
        }
    }
}

extension GithubViewController: UITableViewDataSource, UITableViewDelegate
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
