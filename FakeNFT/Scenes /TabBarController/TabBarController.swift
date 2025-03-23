import UIKit

final class TabBarController: UITabBarController {

 //   var servicesAssembly: ServicesAssembly!
    
    let servicesAssembly = ServicesAssembly(
           networkClient: DefaultNetworkClient(),
           nftStorage: NftStorageImpl()
       )

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )
    
    private let profileTabBarItem = UITabBarItem(
        title: "Профиль",
        image: UIImage(named: "Profile"),
        tag: 0
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileController = ProfileViewController()
              profileController.tabBarItem = profileTabBarItem
        _ = UINavigationController(rootViewController: profileController)

        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        catalogController.tabBarItem = catalogTabBarItem

        viewControllers = [catalogController,profileController]

        view.backgroundColor = .systemBackground
    }
}

