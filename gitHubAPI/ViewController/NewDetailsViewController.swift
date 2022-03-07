import UIKit
import SafariServices

class NewDetailsViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var viewDetailsModel = NewDetailsViewModel()
    var repoItem: Item?
    var image: UIImage?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Details Of The Repositry"
        viewDetailsModel.extractDetails(repoItem!)
        profileImage.image = image
        self.tableView.backgroundColor = UIColor.systemYellow
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
    }
    
    deinit
    {
        print("new details view controller is removed from memory!")
    }
}

extension NewDetailsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewDetailsModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! DetailTableViewCell
        
        let detailItem = viewDetailsModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(detailItem)
        cell.selectionStyle = .none
        if indexPath.row == 2
        {
            cell.explain.textColor = UIColor.systemBlue
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 2
        {
            let detailItem = viewDetailsModel.cellForRowAt(indexPath: indexPath)
            guard let url = URL(string: detailItem.explain) else
            {
                return
            }
            let vc = SFSafariViewController(url: url)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
