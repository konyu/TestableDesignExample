import RxSwift
import RxCocoa
@testable import TestableDesignExample



class UserModelStub: UserModelProtocol {
    private let stateMachine: StateMachine<UserModelState>


    init(withInitialState initialState: UserModelState) {
        self.stateMachine = StateMachine<UserModelState>(startingWith: initialState)
    }


    var didChange: RxCocoa.Driver<UserModelState> {
        return self.stateMachine.didChange
    }


    var currentState: UserModelState {
        get {
            return self.stateMachine.currentState
        }

        set {
            self.stateMachine.transit(to: newValue)
        }
    }


    func fetch() {}
}