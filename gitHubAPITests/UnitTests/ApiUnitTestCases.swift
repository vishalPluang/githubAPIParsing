import XCTest
@testable import gitHubAPI

class GitHubAPITests: XCTestCase {
    
    func test_use_proper_langauge_for_data()
    {
        let testObj = MockAPIService()
        let resultExpectations = expectation(description: "WithValidRequest_Returns_Data")
        var popularRepos = [Item]()
        
        testObj.getPopularGithubData(language: "c++"){(result) in
            switch result {
            case .success(let listOf):
                popularRepos = listOf.items
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
            XCTAssertEqual(popularRepos.count , 2)
            resultExpectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_use_improper_langauge_for_data()
    {
        let testObj = MockAPIService()
        var errorMessage: String?
        let resultExpectations = expectation(description: "WithInValidRequest_Returns_Error")
        
        testObj.getPopularGithubData(language: "robot"){(result) in
            switch result {
            case .failure(let error):
                errorMessage = error.localizedDescription
            case .success(_):
                print("success")
            }
            XCTAssertEqual(errorMessage, "Enter a vaild programming langauge")
            resultExpectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
