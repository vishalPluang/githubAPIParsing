import Foundation
import CoreData

protocol OurErrorProtocol: LocalizedError
{
    var title: String? { get }
    var code: Int { get }
}

struct CustomError: OurErrorProtocol
{
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    private var _description: String

    init(title: String?, description: String, code: Int)
    {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

struct CoreDataRepository : GithubCoreDataProtocol
{
    func getPopularGithubData(language: String, completionHandler: @escaping (Result<GitHub, Error>) -> Void)
    {
        PersistentStorage.shared.printDocumentDirectoryPath()
        let fetchRequest = NSFetchRequest<CDGithub>(entityName: "CDGithub")
        let predicate = NSPredicate(format: "lang == %@", language)

        fetchRequest.predicate = predicate
        do
        {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest) as [CDGithub]

            if result.isEmpty == true
            {
                let error = CustomError.init(title: nil, description: "Enter a vaild programming langauge", code: 404)
                completionHandler(.failure(error))
                return ;
            }

            var data: Array<Item> = []
            result.forEach({ (cdGithub) in
                    data.append(cdGithub.convertToGithubItem())
            })
            let response = GitHub(items: data)
            completionHandler(.success(response))
        }
        catch let error
        {
            completionHandler(.failure(error))
        }
//        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDGithub.self)
//        if result?.isEmpty == true
//        {
//            let error = CustomError.init(title: nil, description: "Enter a vaild programming langauge", code: 404)
//            completionHandler(.failure(error))
//        }
//        var data: Array<Item> = []
//        result?.forEach({ (cdGithub) in
//                data.append(cdGithub.convertToGithubItem())
//        })
//        let response = GitHub(items: data)
//        completionHandler(.success(response))
    }
    
    func insertGithubRecords(records: Array<Item>) -> Bool
    {
        debugPrint("CoreDataRepository: Insert record operation is starting")

        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            records.forEach { githubRecord in
                let cdGithub = CDGithub(context: privateManagedContext)
                cdGithub.id = UUID()
                cdGithub.avatars = githubRecord.avatars[0]
                cdGithub.addedStars = githubRecord.addedStars
                cdGithub.forks = githubRecord.forks
                cdGithub.stars = githubRecord.stars
                cdGithub.lang = githubRecord.lang
                cdGithub.repoLink = githubRecord.repoLink
                cdGithub.repo = githubRecord.repo
                cdGithub.desc = githubRecord.desc
            }

            if privateManagedContext.hasChanges
            {
                try? privateManagedContext.save()
                debugPrint("CoreDataRepository: Insert record operation is completed")
            }
        }
        return true
    }
}
