import Foundation
@testable import gitHubAPI

protocol OurErrorProtocol: LocalizedError {

    var title: String? { get }
    var code: Int { get }
}

struct CustomError: OurErrorProtocol {

    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

class MockAPIService: ApiBaseProtocol
{
    func getPopularGithubData(language: String, completionHandler: @escaping(Result<GitHub, Error>) -> Void)
    {
       if language == "java" || language == "c++" || language == "python"
       {
           var listOfItems = [Item]()
           let data1: Item = Item(repo: "vishal123262/xyz", repoLink: "ncdnkdm", desc: "bjnbdjc", lang: "njdnckd", stars: "4", forks: "v443", addedStars: "cvfv", avatars: ["cdjcdc", "jdcndjcmd"])
           let data2: Item = Item(repo: "vishal123262/xyz", repoLink: "ncdnkdm", desc: "bjnbdjc", lang: "njdnckd", stars: "4", forks: "v443", addedStars: "cvfv", avatars: ["cdjcdc", "jdcndjcmd"])
           listOfItems.append(data1)
           listOfItems.append(data2)
           let item = GitHub(items: listOfItems)
           completionHandler(.success(item))
       }
       else
       {
           let error = CustomError.init(title: nil, description: "Enter a vaild programming langauge", code: 404)
           completionHandler(.failure(error))
       }
    }
}
