import Foundation

class GithubViewModel
{
    private var apiManager: ApiBaseProtocol?
    private var _cdGithubDataRepository : GithubCoreDataProtocol?
    private var _githubApiRepository: ApiBaseProtocol?
    var popularRepos = [Item]()
    
    init(apiManager: ApiBaseProtocol)
    {
        self.apiManager = apiManager
    }
    
    init(_cdGithubDataRepository: GithubCoreDataProtocol , _githubApiRepository: ApiBaseProtocol)
    {
        self._githubApiRepository = _githubApiRepository
        self._cdGithubDataRepository = _cdGithubDataRepository
    }
    
    
    func fetchPopularGithubData(lang: String, completion: @escaping () -> ())
    {
        // for unit testing
        if _cdGithubDataRepository == nil && _githubApiRepository == nil
        {
            apiManager?.getPopularGithubData(language: lang){ (response) in
                switch response {
                case .success(let listOf):
                    self.popularRepos = listOf.items
                    completion()
                case .failure(let error):
                    print("Error processing json data: \(error)")
                    completion()
                }
            }
            return
        }
        
        // for normal working
        _cdGithubDataRepository?.getPopularGithubData(language: lang) { (response) in
            switch response {
            case .success(let listOf):
                self.popularRepos = listOf.items
                completion()
            case .failure(let error):
                self._githubApiRepository?.getPopularGithubData(language: lang) { (result) in
                    switch result {
                    case .success(let listOf):
                        self.popularRepos = listOf.items
                        _ = self._cdGithubDataRepository?.insertGithubRecords(records: listOf.items)
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
