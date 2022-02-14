import UIKit

class GithubTableViewCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    func setCellWithValuesOf(_ item:Item)
    {
        updateUI(repoName: item.repo, poster: item.avatars[0])
    }
        
    private func updateUI(repoName: String?, poster: String?)
    {
        self.repoName.text = repoName
        let temp = repoName?.components(separatedBy: "/")
        self.userName.text = temp![0]
        
        guard let posterString = poster else {return}
        let urlString = posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.posterImage.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.posterImage.image = nil
        
        getImageDataFrom(url: posterImageURL)
    }

    private func getImageDataFrom(url: URL)
    {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.posterImage.image = image
                    self.posterImage.clipsToBounds = true
                    self.posterImage.layer.cornerRadius = self.posterImage.frame.height/2
                }
            }
        }.resume()
    }
}
