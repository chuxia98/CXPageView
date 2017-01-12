//
//  CXPageView.swift
//  pageView
//
//  Created by mac on 2016/12/22.
//  Copyright © 2016年 chuxia. All rights reserved.
//

import UIKit

class CXPageView: UIView {

    fileprivate var titles : [String]
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVC : UIViewController
    fileprivate var style : CXPageStyle
    
    init(_ frame: CGRect, _ titles: [String], _ childVcs: [UIViewController], _ parentVC : UIViewController, _ style : CXPageStyle) {
        
        self.titles = titles
        self.childVcs = childVcs
        self.parentVC = parentVC
        self.style = style
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 设置UI界面
extension CXPageView {
    fileprivate func setupUI() {
        setupTitleView()
        setupContentView()
    }
    
    private func setupTitleView() {
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleViewHeight)
        let titleView = CXTitleView(frame, titles, style)
        
        addSubview(titleView)
    }
    
    private func setupContentView() {
        let frame = CGRect(x: 0, y: style.titleViewHeight, width: bounds.width, height: bounds.height - style.titleViewHeight)
        let contentView = CXContentView(frame, childVcs, parentVC)
        
        addSubview(contentView)
    }
}
