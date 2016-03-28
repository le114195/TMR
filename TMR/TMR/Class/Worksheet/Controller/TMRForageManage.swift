//
//  TMRForageManage.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRForageManage: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    var forageAddView:ForageAddView?
    var cover:UIButton?
    
    var arrayData:NSMutableArray? = nil
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rightBtn?.hidden = false
        
        self.initTableView()
        
        self.createForageAddView()
        
        self.arrayData = ForageManage .getAllData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightBtn() {
        
        self.forageAddView?.alpha = 0.99
        self.cover?.alpha = 0.99
        self.forageAddView?.isAdd = true
        
    }

    private func initTableView(){
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.registerNib(UINib.init(nibName: "ForageManageCell", bundle: nil), forCellReuseIdentifier: "ForageManageCell")
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.arrayData?.count)!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:ForageManageCell = self.tableview.dequeueReusableCellWithIdentifier("ForageManageCell", forIndexPath: indexPath) as! ForageManageCell
        
        let model:ForageManage = self.arrayData![indexPath.row] as! ForageManage
        
        cell.setModel(model)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    private func createForageAddView(){
        
        self.cover = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        self.cover?.backgroundColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 0.9)
        self.cover?.alpha = 0
        self.view.addSubview(self.cover!)
        
        
        
        forageAddView = NSBundle.mainBundle().loadNibNamed("ForageAddView", owner: nil, options: nil).first as? ForageAddView
        forageAddView?.frame = CGRect.init(x: 20, y: 64 + 12, width: screen_width - 40, height: 175)
        forageAddView?.alpha = 0
        self.view.addSubview(forageAddView!)
        forageAddView?.cancelBlock = {()->() in
            
            UIView.animateWithDuration(0.5, animations: { 
                
                self.forageAddView?.alpha = 0
                self.cover?.alpha = 0
                
            })
            
        }
        
        
        forageAddView?.sureBlock = {(forage:ForageManage) -> ()in
        
            UIView.animateWithDuration(0.5, animations: { 
                
                self.forageAddView?.alpha = 0
                self.cover?.alpha = 0
                
            })
            
            
        }
        
    }
    
    
    

}
