import UIKit

class SceneCoordinator {
    enum TransitionStyle {
        case root
        case push
        case present
    }

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func getRootViewController() -> UIViewController {
        return self.navigationController
    }

    func start(userIdentifier: String?) {
        if let userIdentifier = userIdentifier {
            performTransition(to: .board(uid: userIdentifier), style: .root)
        } else {
            performTransition(to: .login, style: .root)
        }
    }

    func performTransition(to sceneType: SceneType, style: TransitionStyle) {
        let instance = sceneType.instance(with: self)

        switch style {
        case .root:
            self.navigationController.setViewControllers([instance], animated: false)
        case .push:
            self.navigationController.pushViewController(instance, animated: false)
        case .present:
            self.navigationController.present(instance, animated: false)
        }
    }

    func dismissPresented() {
        if let presented = self.navigationController.presentedViewController {
            presented.dismiss(animated: false)
        }
    }
}
