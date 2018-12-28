//
//  ViewController.swift
//  AppStoreOld
//
//  Created by Saleh Masum on 22/12/18.
//  Copyright © 2018 Saleh Masum. All rights reserved.
//

import UIKit
 
class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    private let headerId = "headerId"
    
    var featuredApps: FeaturedApps?
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Featured Apps"
      //  appCategories = AppCategory.sampleAppCategories()
        AppCategory.fetchFeaturedApps { (featuredApps) in
            self.featuredApps = featuredApps
            self.appCategories = featuredApps.appCategories
            self.collectionView.reloadData()
        }
        
        collectionView.backgroundColor = .white
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func showAppDetailForApp(app: App) {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = AppDetailController(collectionViewLayout: layout)
        appDetailController.app = app
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            cell.appCategory = appCategories?[indexPath.item]
            cell.featuredAppsController = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        cell.featuredAppsController = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 160)
        }
        return CGSize(width: view.frame.width, height: 230)
    }
    
    // Delegate method responsible for collectionview section header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        header.appCategory = featuredApps?.bannerCategory
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
}

class LargeCategoryCell: CategoryCell {
    
    let largeAppCellId = "largeAppCellId"
    
    override func setupViews() {
        super.setupViews()
        appsCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: "largeAppCellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 32)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellId, for: indexPath) as! LargeAppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    class LargeAppCell: AppCell {
        
        override func setupViews() {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        }
    }
    
}

class Header: CategoryCell {
    
    let bannerCellId = "bannerCellId"
    
    override func setupViews() {
        super.setupViews()
        
        appsCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellId)
        
        addSubview(appsCollectionView)
        appsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        appsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        appsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        appsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        appsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width / 2 + 50, height: frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellId, for: indexPath) as! BannerCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    class BannerCell: AppCell {
        
        override func setupViews() {
            addSubview(imageView)
            
            imageView.layer.cornerRadius = 0
            imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
            imageView.layer.borderWidth = 0.5
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        }
    }
    
}


