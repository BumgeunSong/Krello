import UIKit

enum SceneType {
    case login
    case signup
    case board(uid: String)

    func instance(with coordinator: SceneCoordinator) -> UIViewController {
        switch self {
        case .login:
            let vc = LoginViewController()
            vc.coordinator = coordinator
            return vc
        case .signup:
            let vc = SignupViewController()
            vc.coordinator = coordinator
            return vc
        case .board(let uid):
            return BoardListViewController(boardManager: BoardManager(userUID: uid))
        }
    }
}
