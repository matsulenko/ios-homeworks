import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)

        let feedViewController = FeedViewController()
        feedViewController.title = "Лента"
        feedViewController.view.backgroundColor = .systemBackground
        
        let logInViewController = LogInViewController()

        let postViewController = PostViewController()
        postViewController.title = "Просмотр поста"
        postViewController.view.backgroundColor = .systemGray2

        let tabBarController = UITabBarController()

        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "book.fill"), tag: 0)
        logInViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)

        let controllers = [feedViewController, logInViewController]

        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController:  $0)
        }
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.backgroundColor = .white

        window.rootViewController = tabBarController

        self.window = window
        
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

