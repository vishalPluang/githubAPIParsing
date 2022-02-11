import UIKit

class DetailTableViewCell: UITableViewCell
{
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var explain: UILabel!
    
    func setCellWithValuesOf(_ item:Details)
    {
        updateUI(heading: item.title, explain: item.explain)
    }
        
    private func updateUI(heading: String?, explain: String?)
    {
        self.heading.text = heading
        self.explain.text = explain
    }
}
