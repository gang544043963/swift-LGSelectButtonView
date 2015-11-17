//
//  LGSelectButtonView.swift
//  SwiftStudy
//
//  Created by ligang on 15/11/8.
//  Copyright © 2015年 L&G. All rights reserved.
//

import UIKit
protocol LGSelectButtonViewDelegate {
    func didSelectRowAtIndexPath(indexPath:NSIndexPath)
}

class LGSelectButtonView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var btnHeight:CGFloat = 30.0
    var button:UIButton?
    var tableView:UITableView?
    var origFrame:CGRect?
    var delegate:LGSelectButtonViewDelegate?
    var imageName:NSString {
        get{
            return self.button!.selected ? "class_up_arrow_iPhone.png" : "class_down_arrow_iPhone.png"
        }
    }
    
    var tableViewTextLableArray: NSMutableArray? {
        didSet {
            setupButton()
            setupTableView()
        }
    }
    
    func setupButton() {
        let button = UIButton.init(frame: CGRectMake(0, 0 , frame.size.width, btnHeight));
        button.setBackgroundImage(UIImage(named: "preference_button_iphone.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: "btnTouchd:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
        self.button = button
        button.setImage(UIImage(named: imageName as String), forState: UIControlState.Normal)
    }
    
    func setupTableView() {
        let tableView = UITableView.init(frame: CGRectMake(0, btnHeight, frame.size.width, frame.size.height - btnHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 4
        tableView.backgroundColor = UIColor.clearColor()
        self.addSubview(tableView)
        self.tableView = tableView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.origFrame = frame
        self.backgroundColor = UIColor(white: 255, alpha: 0.8)
        self.layer.cornerRadius = 4
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnTouchd(sender:UIButton) {
        self.button!.setImage(UIImage(named: imageName as String), forState: UIControlState.Normal)
        (self.button!.selected == true) ? (self.button!.selected = false) : (self.button!.selected = true)
        
        if self.button!.selected == true {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.btnHeight)
                self.tableView!.frame = CGRectMake(0, self.btnHeight, self.frame.size.width, 0)
            })
        } else {
            [UIView .animateWithDuration(0.5, animations: { () -> Void in
                self.frame = self.origFrame!
                self.tableView!.frame = CGRectMake(0, self.btnHeight, self.frame.size.width, self.frame.size.height - self.btnHeight)
            })]
        }
    }
    

    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableViewTextLableArray?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = UITableViewCell.init(style: UITableViewCellStyle.Default , reuseIdentifier:nil)
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.text = tableViewTextLableArray?[indexPath.row] as? String
            return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        let labelStr = self.tableViewTextLableArray?[indexPath.row] as? String
        button!.setTitle(labelStr, forState: UIControlState.Normal)
        delegate?.didSelectRowAtIndexPath(indexPath)
        btnTouchd(self.button!)
    }
    
}
