//
//  ViewController.swift
//  SwiftStudy
//
//  Created by ligang on 15/11/8.
//  Copyright © 2015年 L&G. All rights reserved.
//

import UIKit

class ViewController: UIViewController,LGSelectButtonViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "intelligent_backImage_ipad.jpg")!)
        // Do any additional setup after loading the view, typically from a nib.
        let selectBtn = LGSelectButtonView.init(frame: CGRectMake(100, 100, 100, 200))
        selectBtn.tableViewTextLableArray = ["德玛西亚","寒冰射手","无极剑圣","山丘之王"]
        selectBtn.delegate = self
        self.view.addSubview(selectBtn)
    }
    func didSelectRowAtIndexPath(indexPath: NSIndexPath) {
        NSLog("您点击了第\(indexPath.row)行")
    }
}

