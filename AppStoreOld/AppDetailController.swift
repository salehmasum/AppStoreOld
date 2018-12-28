//
//  AppDetailController.swift
//  AppStoreOld
//
//  Created by Saleh Masum on 25/12/18.
//  Copyright © 2018 Saleh Masum. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var app: App? {
        didSet {
            //navigationItem.title = app?.name
            
            if app?.screenshots != nil {
                return
            }
            
            if let id = app?.id?.intValue {
                let urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
                let url = URL(string: urlString)!
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    //
                    if error != nil {
                        print(error ?? "")
                        return
                    }
                    do {
                        let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                        
                        let appDetail = App()
                        appDetail.setValuesForKeys(json as! [String: AnyObject])
                        self.app = appDetail  
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }catch let err {
                        print(err)
                    }
                    //
                    
                }.resume()
            }
            
        }
        
    }
    
    let headerId = "headerId"
    let cellId   = "cellId"
    let descriptionCellId = "descriptionCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellId, for: indexPath) as! AppDetailDescriptionCell
            cell.app = app
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotsCell
        cell.app = app
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            
            let helper = Helper()
            guard let descriptionText = app?.desc else { return .zero }
            let attributedText = helper.descriptionAttributedText(desc: descriptionText)
            
            let dummySize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let boundingRect = attributedText.boundingRect(with: dummySize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: boundingRect.height + 30)
        }
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppDetailHeader
        headerView.app = self.app
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
}

class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet {
            if let imageName = app?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            nameLabel.text = app?.name
            
            if let price = app?.price?.stringValue {
                buyButton.setTitle("$\(price)", for: .normal)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerLineView)
        
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14).isActive = true
        imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 14).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        buyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -14).isActive = true
        buyButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        dividerLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        dividerLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        dividerLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
