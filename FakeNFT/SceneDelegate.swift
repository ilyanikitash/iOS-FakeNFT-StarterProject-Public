import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    let tokenStorage = TokenKeychainStorage()
    lazy var servicesAssembly = ServicesAssembly(
        
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl(),
        tokenStorage: tokenStorage
    )
    
    func scene(_: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        saveUserToken()
        let tabBarController = window?.rootViewController as? TabBarController
        tabBarController?.servicesAssembly = servicesAssembly
        
    }
    func saveUserToken() {
        let token = "1"
        do {
            try tokenStorage.store(token: token)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
