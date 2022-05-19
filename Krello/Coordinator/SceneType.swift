import UIKit

enum SceneType {
    case login
    case signup
    case board(uid: String)

    func instance(with coordinator: SceneCoordinator) -> UIViewController {
        switch self {
        case .login:
            return LoginViewController(coordinator: coordinator)
        case .signup:
            return SignupViewController(coordinator: coordinator)
        case .board(let uid):
            return BoardListViewController(boardManager: BoardManager(userUID: uid))
        }
    }
}
