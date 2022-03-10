import Foundation

struct ApiService: ApiBaseProtocol
{
    func getPopularGithubData(language: String, completionHandler: @escaping(Result<GitHub, Error>) -> Void)
    {
        let githubApiUrl = "https://trendings.herokuapp.com/repo?lang=\(language)&since=weekly"
        
        let apiUrl = URL(string: githubApiUrl)!
        
        URLSession.shared.dataTask(with: apiUrl){(data, response, error) in
            
            if let error = error
            {
                completionHandler(.failure(error))
                print("error : \(error.localizedDescription)")
                return
            }
            
            guard let response = response else
            {
                return
            }
            
            print("response = \(response)")
            
            guard let data = data else
            {
                print("No data")
                return
            }
            
            do
            {
                let jsonData = try JSONDecoder().decode(GitHub.self, from: data)
                DispatchQueue.main.async
                {
                    completionHandler(.success(jsonData))
                }
            }
            catch let error
            {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
