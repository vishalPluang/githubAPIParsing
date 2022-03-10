import Foundation

class GithubViewModel
{
    private var apiManager: ApiBaseProtocol
    var popularRepos = [Item]()
    
    init(apiManager: ApiBaseProtocol)
    {
        self.apiManager = apiManager
    }
    
    private let _cdGithubDataRepository : GithubCoreDataProtocol = CoreDataRepository()
    private let _githubApiRepository: ApiBaseProtocol = ApiService()
    
    
    func fetchPopularGithubData(lang: String, completion: @escaping () -> ())
    {
      _cdGithubDataRepository.getPopularGithubData(language: lang) { (response) in
            switch response {
            case .success(let listOf):
                self.popularRepos = listOf.items
                completion()
            case .failure(let error):
                self._githubApiRepository.getPopularGithubData(language: lang) { (result) in
                    switch result {
                    case .success(let listOf):
                        self.popularRepos = listOf.items
                        _ = self._cdGithubDataRepository.insertGithubRecords(records: listOf.items)
                        completion()
                    case .failure(let error):
                        print("Error processing json data: \(error)")
                        completion()
                    }
                }
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int
    {
        if popularRepos.count != 0
        {
            return popularRepos.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Item
    {
        return popularRepos[indexPath.row]
    }
}
