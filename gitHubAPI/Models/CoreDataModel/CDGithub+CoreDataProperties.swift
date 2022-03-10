import Foundation
import CoreData

extension CDGithub {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGithub> {
        return NSFetchRequest<CDGithub>(entityName: "CDGithub")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var repo: String?
    @NSManaged public var repoLink: String?
    @NSManaged public var lang: String?
    @NSManaged public var stars: String?
    @NSManaged public var forks: String?
    @NSManaged public var addedStars: String?
    @NSManaged public var avatars: String?
    @NSManaged public var desc: String?
    
    func convertToGithubItem() -> Item
    {
        return Item(repo: self.repo!, repoLink: self.repoLink!, desc: self.desc!, lang: self.lang!, stars: self.stars!, forks: self.forks!, addedStars: self.addedStars!, avatars: [self.avatars!])
    }
}

extension CDGithub : Identifiable {

}
