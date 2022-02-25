import XCTest
@testable import gitHubAPI

class ViewModelUnitTestCases: XCTestCase {

    var viewModel = GithubViewModel(apiManager: MockAPIService())
    
    func test_rows_count_returns_success()
    {
        let resultExpectations = expectation(description: "WithValidRequest_Returns_Success")

        viewModel.fetchPopularGithubData(lang: "c++"){() in
            resultExpectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.popularRepos.count, 2)
    }
    
    func test_correct_data_returns_success()
    {
        let resultExpectations = expectation(description: "WithValidRequest_Returns_Success")

        viewModel.fetchPopularGithubData(lang: "c++"){() in
            resultExpectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.popularRepos[0].repo, "vishal123262/xyz")
    }
    
    func test_incorrect_data_returns_success()
    {
        let resultExpectations = expectation(description: "WithValidRequest_Returns_Success")

        viewModel.fetchPopularGithubData(lang: "robot"){() in
            resultExpectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.popularRepos.count, 0)
    }
}
