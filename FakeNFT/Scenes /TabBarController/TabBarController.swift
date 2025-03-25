import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileViewController = ProfileViewController(servicesAssembly: servicesAssembly)
                    profileViewController.tabBarItem = profileTabBarItem
                    let profileNavController = UINavigationController(rootViewController: profileViewController)
        
        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        catalogController.tabBarItem = catalogTabBarItem
        viewControllers = [catalogController,profileViewController]

     //   view.backgroundColor = .systemBackground
    }
}
