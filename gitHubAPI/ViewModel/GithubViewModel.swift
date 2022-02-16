import Foundation

class GithubViewModel {
    
    private var apiService = ApiService()
    var popularRepos = [Item]()
    
    func fetchPopularGithubData(lang: String, completion: @escaping () -> ()) {
        
        apiService.getPopularGithubData(language: lang) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.popularRepos = listOf.items
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularRepos.count != 0 {
            return popularRepos.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Item {
        return popularRepos[indexPath.row]
    }
}
