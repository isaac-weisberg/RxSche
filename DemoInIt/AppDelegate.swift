import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let controller = MainViewController()
        let viewModel = MainViewModel()
        controller.apply(viewModel: viewModel)

        window?.rootViewController = controller

        window!.makeKeyAndVisible()

        return true
    }
}
