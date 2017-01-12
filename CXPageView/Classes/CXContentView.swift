//
//  CXContentVIew.swift
//  pageView
//
//  Created by mac on 2016/12/22.
//  Copyright © 2016年 chuxia. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

class CXContentView: UIView {
    
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVC : UIViewController
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    init(_ frame: CGRect, _ controllers: [UIViewController], _ parentVC : UIViewController) {
        self.childVcs = controllers
        self.parentVC = parentVC
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CXContentView {
    fileprivate func setupUI() {
        for vc in childVcs {
            parentVC.addChildViewController(vc)
        }
        
        addSubview(collectionView)
    }
}

extension CXContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
