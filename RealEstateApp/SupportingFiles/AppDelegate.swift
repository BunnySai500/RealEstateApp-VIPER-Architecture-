 

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var dataStore = RealmManager.shared()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SetDateChangedValue()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

  func SetDateChangedValue()
  {
    if let oldDate = UserDefaults.standard.object(forKey: DefaultConstants.date) as? Date
    {
    if !Calendar.current.isDateInToday(oldDate) {
    UserDefaults.standard.set(true, forKey: DefaultConstants.datechange)
    UserDefaults.standard.set(Date(), forKey: DefaultConstants.date)
    }
    else{
    UserDefaults.standard.set(false, forKey: DefaultConstants.datechange)
        }
    }
    else{
    UserDefaults.standard.set(Date(), forKey: DefaultConstants.date)
    }
}
}

