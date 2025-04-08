import UIKit

final class TabBarController: UITabBarController {
    let servicesAssembly = ServicesAssembly(
           networkClient: DefaultNetworkClient(),
           nftStorage: NftStorageImpl(),
           myNftStorage: MyNftStorageImpl()
       )
    
    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 0
    )
    
<<<<<<< HEAD
    private let cartTabBarItem = UITabBarItem(
        title: NSLocalizedString("Корзина", comment: ""),
        image: UIImage(named: "cart"),
        tag: 0
    )
    
=======
>>>>>>> 6cbfd2aa4f4919913285ebc3831eb40866c8d70b
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
<<<<<<< HEAD

=======
        
>>>>>>> 6cbfd2aa4f4919913285ebc3831eb40866c8d70b
        let profileViewController = ProfileViewController(servicesAssembly: servicesAssembly)
        profileViewController.tabBarItem = profileTabBarItem
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        
        let profileImage = UIImage(named: "Profile")?.withRenderingMode(.alwaysOriginal)
        let resizedImage = profileImage?.resized(to: CGSize(width: 30, height: 30))
        profileTabBarItem.image = resizedImage
        
        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
<<<<<<< HEAD
        
=======
>>>>>>> 6cbfd2aa4f4919913285ebc3831eb40866c8d70b
        let statisticUsersListVC = StatisticUsersListViewController()
        let statisticUsersListVCNavController = UINavigationController(rootViewController: statisticUsersListVC)
        statisticUsersListVCNavController.setNavigationBarHidden(false, animated: false)
        
        catalogController.tabBarItem = catalogTabBarItem
<<<<<<< HEAD
        
        let cartController = UINavigationController(rootViewController: CartMainViewController())
        cartController.tabBarItem = cartTabBarItem

=======
>>>>>>> 6cbfd2aa4f4919913285ebc3831eb40866c8d70b
        statisticUsersListVCNavController.tabBarItem = statisticTabBarItem

        viewControllers = [catalogController]
        viewControllers?.append(statisticUsersListVCNavController)
        viewControllers?.append(profileNavController)
<<<<<<< HEAD
        
=======

>>>>>>> 6cbfd2aa4f4919913285ebc3831eb40866c8d70b
        view.backgroundColor = .systemBackground
    }
}

