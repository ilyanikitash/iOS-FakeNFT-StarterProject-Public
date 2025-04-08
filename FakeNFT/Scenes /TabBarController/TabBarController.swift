import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly!

    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )
    
    private let cartTabBarItem = UITabBarItem(
        title: NSLocalizedString("Корзина", comment: ""),
        image: UIImage(named: "cart"),
        tag: 0
    )
    
    private let profileTabBarItem = UITabBarItem(
        title: "Профиль",
        image: UIImage(named: "Profile"),
        tag: 0
    )
    private let statisticTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.statistic", comment: ""),
        image: UIImage(named: "tab_statistic"),
        tag: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileViewController = ProfileViewController(servicesAssembly: servicesAssembly)
        profileViewController.tabBarItem = profileTabBarItem
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        
        let profileImage = UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = profileImage?.resized(to: CGSize(width: 30, height: 30))
        profileTabBarItem.image = resizedImage
        
        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        
        let statisticUsersListVC = StatisticUsersListViewController()
        let statisticUsersListVCNavController = UINavigationController(rootViewController: statisticUsersListVC)
        statisticUsersListVCNavController.setNavigationBarHidden(false, animated: false)
        
        catalogController.tabBarItem = catalogTabBarItem
        
        let cartController = UINavigationController(rootViewController: CartMainViewController())
        cartController.tabBarItem = cartTabBarItem

        statisticUsersListVCNavController.tabBarItem = statisticTabBarItem

        viewControllers = [catalogController]
        viewControllers?.append(statisticUsersListVCNavController)
        viewControllers?.append(profileNavController)
        
        view.backgroundColor = .systemBackground
    }
}
