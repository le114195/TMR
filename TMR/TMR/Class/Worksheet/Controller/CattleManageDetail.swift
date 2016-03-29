//
//  CattleManageDetail.swift
//  TMR
//
//  Created by 勒俊 on 16/3/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class CattleManageDetail: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var cattleModel:CattleManage!
    
    var arrayData = NSMutableArray()
    
    @IBOutlet weak var cattle_name: UITextField!
    @IBOutlet weak var cattle_type: UITextField!
    @IBOutlet weak var cattle_num: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rightBtn?.hidden = false
        
        self.initTableView()
        
        self.cattle_type.userInteractionEnabled = false
        self.cattle_name.userInteractionEnabled = false
        
        
        self.cattle_name?.text = self.cattleModel.cattle_name
        self.cattle_type?.text = self.cattleModel.cattle_type
        self.cattle_num?.text = "\(self.cattleModel.cattle_num)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightBtn() {
        
        
        
    }
    
    private func initTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "CattleManageDetailCell", bundle: nil), forCellReuseIdentifier: "CattleManageDetailCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CattleManageDetailCell = self.tableView.dequeueReusableCellWithIdentifier("CattleManageDetailCell", forIndexPath: indexPath) as! CattleManageDetailCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    
}
