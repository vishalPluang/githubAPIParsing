import UIKit

class SearchBarViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let data = ["C", "Java", "Python", "Swift", "None"]

    var filteredData: [String]!
    var selectedLanguage: String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = data
    }
}

extension SearchBarViewController
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        selectedLanguage = filteredData[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredData.count
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondGithubViewController") as? SecondGithubViewController
        vc?.selectedLanguage = selectedLanguage
        if selectedLanguage == "C" || selectedLanguage == "Java" || selectedLanguage == "Python" || selectedLanguage == "Swift"
        {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Please Enter A Valid Language.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
