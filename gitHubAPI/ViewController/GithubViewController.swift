import UIKit

class GithubViewController: UIViewController {
    
    let reachability = try! Reachability()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = GithubViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopularGithubData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            DispatchQueue.main.async {
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
        }
        self.reachability.whenUnreachable = { _ in
            print("Not reachable")
            if let networkVC = self.storyboard?.instantiateViewController(withIdentifier:"NetworkErrorViewController") as? NetworkErrorViewController
            {
                print("going!")
                DispatchQueue.main.async {
                    self.present(networkVC, animated: true, completion: nil)
                }
            }
        }

        do {
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        reachability.stopNotifier()
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

