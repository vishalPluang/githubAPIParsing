import Foundation

struct Details
{
    var title: String
    var explain: String
}

class NewDetailsViewModel {
    
    var details: [Details] = []
    
    func extractDetails(_ item:Item)
    {
        details.append(Details(title: "Name Of The Repo", explain: item.repo))
        details.append(Details(title: "Description Of The Repo", explain: item.desc))
        details.append(Details(title: "Link Of The Repo", explain: item.repoLink))
        details.append(Details(title: "Total Stars Of The Repo", explain: item.stars))
        details.append(Details(title: "Total Forks Of The Repo", explain: item.forks))
        details.append(Details(title: "Language Of The Repo", explain: item.lang))
        details.append(Details(title: "Total Added Stars Of The Repo", explain: item.addedStars))
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if details.count != 0 {
            return details.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Details {
        return details[indexPath.row]
    }
}

