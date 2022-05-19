import UIKit

enum SceneType {
    case login
    case signup
    case boardList(uid: String)
    case board

    func instance(with coordinator: SceneCoordinator) -> UIViewController {
        switch self {
        case .login:
            return LoginViewController(coordinator: coordinator)
        case .signup:
            return SignupViewController(coordinator: coordinator)
        case .boardList(let uid):
            return BoardListViewController(boardManager: BoardManager(userUID: uid), coordinator: coordinator)
        case .board:
            return BoardViewController(coordinator: coordinator)
        }
    }
}
