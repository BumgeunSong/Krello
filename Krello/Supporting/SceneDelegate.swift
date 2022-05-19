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


class ApplicationCoordinator {
    private var navigationController = UINavigationController()
    private let loginViewController = LoginViewController()
    private let signupViewController = SignupViewController()

    func start(userIdentifier: String? = Default.getUserIdentifer()) {
        if let userIdentifier = Default.getUserIdentifer() {
            let boardListViewController = BoardListViewController(boardManager: BoardManager(userUID: userIdentifier))
            navigationController = UINavigationController(rootViewController: boardListViewController)

        } else {
            loginViewController.coordinator = self
            signupViewController.coordinator = self
            navigationController = UINavigationController(rootViewController: loginViewController)
        }
    }

    func getRootViewController() -> UIViewController {
        return self.navigationController
    }

    // 로그인 화면 -> 회원가입화면 열기
    func presentSignup() {
        self.navigationController.present(signupViewController, animated: false)
    }

    // 로그인화면 -> (action:로그인) -> 보드화면
    // 회원가입화면 -> (action:회원 가입)->(자동 로그인) -> 보드화면
    func showBoard(uid: String) {
        Default.setUserIdentifier(uid: uid)

        let boardListViewController = BoardListViewController(boardManager: BoardManager(userUID: uid))
        // TODO: push 가 아닌, child coordinator(새로운 navigator) 로 대체
        self.navigationController.pushViewController(boardListViewController, animated: false)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let coordinator = ApplicationCoordinator()
        coordinator.start()
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
