//
//  ScreenshotsCell.swift
//  AppStoreOld
//
//  Created by Saleh Masum on 26/12/18.
//  Copyright © 2018 Saleh Masum. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let cellId = "cellId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
       
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        addSubview(dividerLineView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
        
        dividerLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        dividerLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = app?.screenshots?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        
        cell.imageView.image = UIImage(named: app?.screenshots?[indexPath.item] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
}

private class ScreenshotImageCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .green
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    fileprivate override func setupViews() {
        super.setupViews()
        
        layer.masksToBounds = true
        
        addSubview(imageView)
        backgroundColor = .yellow
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
    }
    
    
    
}
