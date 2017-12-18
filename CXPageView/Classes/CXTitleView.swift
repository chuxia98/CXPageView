//
//  CXTitleView.swift
//  pageView
//
//  Created by mac on 2016/12/22.
//  Copyright © 2016年 chuxia. All rights reserved.
//

import UIKit

public protocol CXTitleViewDelegate : class {
    func titleView(_ titleView : CXTitleView, currentIndex : Int)
}

public class CXTitleView: UIView {

    weak var delegate : CXTitleViewDelegate?
    
    fileprivate var titles : [String]
    fileprivate var style : CXPageStyle
    
    fileprivate lazy var currentIndex : Int = 0
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        return scrollView
    }()
    
    public init(_ frame: CGRect,_ titles: [String], _ style : CXPageStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CXTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        
        addTitleLables()
        
        setupTitleLableFrame()
    }
    
    fileprivate func addTitleLables() {
        for (i, title) in titles.enumerated() {
            let titleLabel = UILabel();
            titleLabel.text = title;
            titleLabel.font = style.titleFont
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            
            scrollView.addSubview(titleLabel)
            
            titleLabels.append(titleLabel)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    fileprivate func setupTitleLableFrame() {
        
        let count = titleLabels.count
        
        for (i, label) in titleLabels.enumerated() {
            var x : CGFloat = 0
            let h : CGFloat = bounds.height
            var w : CGFloat = 0
            let y : CGFloat = 0
            
            if style.isScrollEnable { // 可以滚动
                
                w = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : label.font], context: nil).width
                
                if i == 0 {
                    x = style.itemMargin * 0.5
                } else {
                    let preLabel = titleLabels[i - 1]
                    x = preLabel.frame.maxX + style.itemMargin
                }
                
            }
            else {
                w = bounds.width / CGFloat(count)
                x = CGFloat(i) * w
            }
            
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        scrollView.contentSize = style.isScrollEnable ? CGSize(width: titleLabels.last!.frame.maxX + style.itemMargin * 0.5, height: 0) : CGSize.zero
    }
    
}

extension CXTitleView {
    @objc fileprivate func tapAction(_ tap: UITapGestureRecognizer) {
        let targetLabel = tap.view as! UILabel
        let sourceLabel = titleLabels[currentIndex]
        
        targetLabel.textColor = style.selectColor
        sourceLabel.textColor = style.normalColor
        
        // 3.记录下标值
        currentIndex = targetLabel.tag
        
        delegate?.titleView(self, currentIndex: currentIndex)
        
        
        if style.isScrollEnable {
            var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
            if offsetX < 0 {
                offsetX = 0
            }
            if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
                offsetX = scrollView.contentSize.width - scrollView.bounds.width
            }
            scrollView.setContentOffset(CGPoint(x: offsetX, y : 0), animated: true)
        }
    }
}
