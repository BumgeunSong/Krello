//
//  SceneDelegate.swift
//  Krello
//
//  Created by Bumgeun Song on 2022/05/03.
//

import UIKit

struct Default {
    private static let key = "userIdentifier"

    static func setUserIdentifier(uid: String) {
        UserDefaults.standard.set(uid, forKey: key)
    }

    static func getUserIdentifer() -> String? {
        return UserDefaults.standard.string(forKey: self.key) ?? nil
    }

}

enum SceneType {
    case login
    case signup
    case board(uid: String)

    func instance(with coordinator: ApplicationCoordinator) -> UIViewController {
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

enum TransitionStyle {
    case root
    case push
    case present
}

class ApplicationCoordinator {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func getRootViewController() -> UIViewController {
        return self.navigationController
    }

    func start(userIdentifier: String?) {
        if let userIdentifier = Default.getUserIdentifer() {
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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let coordinator = ApplicationCoordinator()
        coordinator.start(userIdentifier: Default.getUserIdentifer())
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.getRootViewController()
        window?.makeKeyAndVisible()
    }

    private func createBoardListViewController(uid: String) -> UIViewController {
        let childVC = BoardListViewController(boardManager: BoardManager(userUID: uid))
        return UINavigationController(rootViewController: childVC)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
