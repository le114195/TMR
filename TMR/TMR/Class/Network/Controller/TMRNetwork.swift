//
//  TMRNetwork.swift
//  TMR
//
//  Created by 勒俊 on 16/3/27.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRNetwork: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    private var arrayData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrayData = Worksheet.getDate()
        self.initTableView()
        
        // Do any additional setup after loading the view.
    }

    private func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "NetWorkCell", bundle: nil), forCellReuseIdentifier: "NetWorkCell")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func uploadAction(sender: AnyObject) {
        
        
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:NetWorkCell = self.tableView.dequeueReusableCellWithIdentifier("NetWorkCell", forIndexPath: indexPath) as! NetWorkCell
        
        cell.setModelData(self.arrayData[indexPath.row] as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    
}
