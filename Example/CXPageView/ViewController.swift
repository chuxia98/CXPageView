//
//  ViewController.swift
//  CXPageView
//
//  Created by chuxia98 on 01/10/2017.
//  Copyright (c) 2017 chuxia98. All rights reserved.
//

import UIKit
import CXPageView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        super.viewDidLoad()
        
        let titles = ["游玩", "户外", "明星", "游戏"];
        
        var childVcs = [UIViewController]()
        
        for _ in 0...titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs .append(vc)
        }
        
        let style = CXPageStyle()
        
        let pageView = CXPageView(view.bounds, titles, childVcs, self, style)
        
        view .addSubview(pageView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

