import Foundation

struct GitHub: Decodable
{
    var items: [Item]
}

struct Item: Decodable
{
    let repo: String
    let repoLink: String
    let desc: String
    let lang: String
    let stars, forks, addedStars: String
    let avatars: [String]

    enum CodingKeys: String, CodingKey
    {
        case repo
        case repoLink = "repo_link"
        case desc, lang, stars, forks
        case addedStars = "added_stars"
        case avatars
    }
}
