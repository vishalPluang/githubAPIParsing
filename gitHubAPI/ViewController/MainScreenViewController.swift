import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var goToDropdownMenuScreen: UIButton!
    @IBOutlet weak var goToSearchBarScreen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goToDropDownMenuScreen(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GithubViewController") as? GithubViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func goToSearchBarScreen(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchBarViewController") as? SearchBarViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
