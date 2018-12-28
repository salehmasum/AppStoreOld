//
//  Models.swift
//  AppStoreOld
//
//  Created by Saleh Masum on 24/12/18.
//  Copyright © 2018 Saleh Masum. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject {
    
    @objc var bannerCategory: AppCategory?
    @objc var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [AppCategory]()
            for dict in value as! [[String: AnyObject]] {
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
        }else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String: AnyObject])
            
        }else {
            super.setValue(value, forKey: key)
        }
    }
}

class AppCategory: NSObject {
    
    @objc var name: String?
    @objc var apps: [App]?
    @objc var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
            
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps( completionHandler: @escaping (FeaturedApps) -> () ) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            do {
                let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json as! [String: AnyObject])
                DispatchQueue.main.async {
                    completionHandler(featuredApps)
                }
            }catch let err {
                print(err)
            }
        }.resume()
    }
    
    static func sampleAppCategories() -> [AppCategory] {
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        //logic
        let frozenApp = App()
        frozenApp.name = "Disney Build It: Frozen"
        frozenApp.imageName = "frozen"
        frozenApp.category = "Entertainment"
        frozenApp.price = NSNumber(floatLiteral: 3.99)
        apps.append(frozenApp)
        
        bestNewAppsCategory.apps = apps
        
        let bestNewGameCategory = AppCategory()
        bestNewGameCategory.name = "Best New Games"
        
        var bestNewGamesApps = [App]()
        
        let telepaintApp = App()
        telepaintApp.name = "Telepaint"
        telepaintApp.category = "Games"
        telepaintApp.price = NSNumber(floatLiteral: 2.99)
        telepaintApp.imageName = "telepaint"
        
        bestNewGamesApps.append(telepaintApp)
        bestNewGameCategory.apps = bestNewGamesApps
        
        return [bestNewAppsCategory, bestNewGameCategory]
    }
}

class App: NSObject {
    @objc var id: NSNumber?
    @objc var name: String?
    @objc var category: String?
    @objc var price: NSNumber?
    @objc var imageName: String?
    
    @objc var screenshots: [String]?
    @objc var appInformation: AnyObject?
    @objc var desc: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            self.desc = value as? String
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
}
