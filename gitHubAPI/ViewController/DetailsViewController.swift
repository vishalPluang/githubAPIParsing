import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var repoName: UILabel!
    
    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var repoLink: UILabel!
    
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var totalForks: UILabel!
    
    @IBOutlet weak var totalStars: UILabel!
    
    @IBOutlet weak var totalAddedStars: UILabel!
    
    func showDetails(_ item:Item)
    {
        self.repoName.text = item.repo
        self.repoDescription.text = item.desc
        self.repoLink.text = item.repoLink
        self.language.text = item.lang
        self.totalForks.text = item.forks
        self.totalStars.text = item.stars
        self.totalAddedStars.text = item.addedStars
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
