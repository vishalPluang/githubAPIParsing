import Foundation
import CoreData

protocol ApiBaseProtocol
{
    func getPopularGithubData(language: String, completionHandler: @escaping(Result<GitHub, Error>) -> Void)
}

protocol GithubCoreDataProtocol
{
    func getPopularGithubData(language: String, completionHandler: @escaping(Result<GitHub, Error>) -> Void)
    func insertGithubRecords(records:Array<Item>) -> Bool
}

