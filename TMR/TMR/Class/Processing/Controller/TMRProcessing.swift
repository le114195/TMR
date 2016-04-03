//
//  TMRProcessing.swift
//  TMR
//
//  Created by 勒俊 on 16/4/2.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit


class TMRProcessing: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var morningBtn: UIButton!
    @IBOutlet weak var nooningBtn: UIButton!
    @IBOutlet weak var eveningBtn: UIButton!
    
    private lazy var alertController:UIAlertController = {
        
        let tempAlert = UIAlertController.init(title: "已经是最后一项，是否选择退出加工", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        weak var weakSelf = self
        let okAction = UIAlertAction.init(title: "退出加工", style: UIAlertActionStyle.Default, handler: { (okAction) in
            UIView.animateWithDuration(0.25, animations: {
                weakSelf?.processView.alpha = 0
            })
            weakSelf?.tableView.reloadData()
            weakSelf?.navigationController?.navigationBarHidden = false
        })
        tempAlert.addAction(cancelAction)
        tempAlert.addAction(okAction)
        return tempAlert
    }()
    
    private lazy var morningArrayData:NSMutableArray = {
        let tempArray = WorksheetModel.getData(0)
        return tempArray
    }()
    
    private lazy var nooningArrayData:NSMutableArray = {
        let tempArray = WorksheetModel.getData(1)
        return tempArray
    }()
    private lazy var eveningArrayData:NSMutableArray = {
        let tempArray = WorksheetModel.getData(2)
        return tempArray
    }()
    
    private var processView:ProcessingView!
    
    private var arrayData = NSMutableArray()
    
    private var selectBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBtn()
        self.initTableView()
        self.initProcessView()
    }
    
    private func initTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "TMRProcessingCell", bundle: nil), forCellReuseIdentifier: "TMRProcessingCell")
    }
    

    private func initBtn(){
        
        self.morningBtn.layer.cornerRadius = 5.0
        self.nooningBtn.layer.cornerRadius = 5.0
        self.eveningBtn.layer.cornerRadius = 5.0
        self.morningAction(self.morningBtn)
    }
    
    private func initProcessView(){
        
        self.processView = NSBundle.mainBundle().loadNibNamed("ProcessingView", owner: nil, options: nil).first as! ProcessingView
        self.processView.frame = CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height)
        self.processView.alpha = 0
        self.view.addSubview(self.processView)
        weak var weakSelf = self
        self.processView.closeBlock = {()->() in
            UIView.animateWithDuration(0.25, animations: {
                weakSelf?.processView.alpha = 0
            })
            weakSelf?.tableView.reloadData()
            weakSelf?.navigationController?.navigationBarHidden = false
        }
        self.processView.lastBlock = {()->() in
            weakSelf?.presentViewController((weakSelf?.alertController)!, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func morningAction(sender: AnyObject) {
        if self.selectBtn .isEqual(sender as! UIButton) {
            return
        }
        self.selectBtn = self.morningBtn
        self.morningBtn.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.nooningBtn.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        self.eveningBtn.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        self.arrayData = self.morningArrayData
        self.tableView.reloadData()
    }
    
    @IBAction func nooningAction(sender: AnyObject) {
        if self.selectBtn .isEqual(sender as! UIButton) {
            return
        }
        self.selectBtn = self.nooningBtn
        self.morningBtn.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        self.nooningBtn.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.eveningBtn.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        self.arrayData = self.nooningArrayData
        self.tableView.reloadData()

    }
    
    @IBAction func eveningAction(sender: AnyObject) {
        if self.selectBtn .isEqual(sender as! UIButton) {
            return
        }
        self.selectBtn = self.eveningBtn
        self.morningBtn.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        self.nooningBtn.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        self.eveningBtn.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        self.arrayData = self.eveningArrayData
        self.tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TMRProcessingCell = self.tableView.dequeueReusableCellWithIdentifier("TMRProcessingCell", forIndexPath: indexPath) as! TMRProcessingCell
        
        cell.setModelData(self.arrayData[indexPath.row] as! WorksheetModel)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        UIView.animateWithDuration(0.25) { 
            self.processView.alpha = 0.99
        }
        self.processView.startUpdateData()
        self.processView.setModelData(self.arrayData[indexPath.row] as! WorksheetModel)
        self.navigationController?.navigationBarHidden = true
    }
}
