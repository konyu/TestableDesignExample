import XCTest
import PromiseKit
import MirrorDiffKit
@testable import TestableDesignExample



class UserRepositoryTests: XCTestCase {
    func testGet() {
        async(test: self) { () -> Promise<Void> in
            let response = JsonReader.dictionary(from: R.file.userJson.path()!)
            let apiStub = GitHubApiClientStub(firstResult: Promise(value: response))

            let repository = UserApiRepository(fetchingVia: apiStub)

            let expected = GitHubUser(
                id: GitHubUser.Id(text: "1"),
                name: GitHubUser.Name(text: "octocat"),
                avatar: URL(string: "https://github.com/images/error/octocat_happy.gif")!
            )

            return repository.get(by: GitHubUser.Id(text: "1"))
                .then { user in
                    XCTAssert(
                        expected =~ user,
                        diff(between: expected, and: user)
                    )
                }
        }
    }
}
