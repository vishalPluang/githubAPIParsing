import UIKit

class NewDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var viewDetailsModel = NewDetailsViewModel()
    var repoItem: Item?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details Of The Repositry"
        viewDetailsModel.extractDetails(repoItem!)
        profileImage.image = image
        self.tableView.backgroundColor = UIColor.orange
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
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
        cell.backgroundColor = UIColor.systemPink
        return cell
    }
}
