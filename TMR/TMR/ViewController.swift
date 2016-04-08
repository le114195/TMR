//
//  ViewController.swift
//  TMR
//
//  Created by 勒俊 on 16/3/27.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var facilityID:String = ""

class ViewController: UIViewController {

    private var name = String?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let facility = NSUserDefaults.standardUserDefaults().valueForKey("facilityID")
        if facility == nil {
            let login = TMRLogin()
            self.navigationController?.pushViewController(login, animated: false)
        }else {
            facilityID = facility as! String
        }
        
        
        print(sqlite_path)
        self.view.backgroundColor = UIColor.whiteColor()
        self.createSubView()
        self.createAllTable()
        
        self.createRightBtn()
//        self.alamofireTest()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createRightBtn() {
        
        let rightBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 55, height: 44))
        
        rightBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        rightBtn.setTitle("退出登录", forState: UIControlState.Normal)
        rightBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        rightBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        rightBtn.addTarget(self, action: #selector(ViewController.rightAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    
    func rightAction() {
        
        let login = TMRLogin()
        self.navigationController?.pushViewController(login, animated: false)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(nil, forKey: "facilityID")
    }
    
    
    private func createSubView() {
        
        let height:CGFloat = (screen_height - 64) / 4
        
        for i in 0...3{
            let btny:CGFloat = 64 + CGFloat(i) * height;
            let btn1 = UIButton.init(frame: CGRect.init(x: 0, y: btny, width: screen_width, height: height - 1))
            btn1.tag = i
            
            btn1.backgroundColor = UIColor.blueColor()
            
            btn1.layer.cornerRadius = 5
            
            btn1.addTarget(self, action: #selector(ViewController.clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(btn1)
            
            btn1.titleLabel?.font = UIFont.systemFontOfSize(34)
            
            switch i {
            case 0:
                btn1.setTitle("数据处理", forState: UIControlState.Normal)
                break
                
            case 1:
                btn1.setTitle("历史数据查看", forState: UIControlState.Normal)
                break
                
            case 2:
                btn1.setTitle("制作加工单", forState: UIControlState.Normal)
                break
                
            case 3:
                btn1.setTitle("网络", forState: UIControlState.Normal)
                break
            default:
                break
            }
        }
    }
    
    func clickBtn(btn:UIButton) {
        
        
        switch btn.tag {
        case 0:
            
            let processing = TMRProcessing()
            self.navigationController?.pushViewController(processing, animated: true)
            break
        case 1:
            
            let processed = TMRProcessed()
            self.navigationController?.pushViewController(processed, animated: true)
            
            break
        case 2:

            let worksheet = TMRWorksheet()
            self.navigationController?.pushViewController(worksheet, animated: true)

            break
            
        case 3:
            
            let network = TMRNetwork()
            self.navigationController?.pushViewController(network, animated: true)
            break
            
        default:
            break
        }
    }

    private func createAllTable() {
        let tmrsql = TMRSQLite()
        if !tmrsql.openDatabase() {
            print("打开数据库失败！！！")
            return
        }
        let work_sheet = "create table if not exists work_sheet (worksheet_id integer primary key, sheet_name text, forage_name text, originWeight double, processedWeight double, percent text, status integer, uploadStatus integer, subDate text, date text, facilityID text)"
        
        self.createTable(work_sheet, tmrsql: tmrsql)
        
        let forage_manage = "create table if not exists forage_manage (forage_name text, forage_id integer primary key, repertory integer, proportion integer, forage_type text)"
        self.createTable(forage_manage, tmrsql: tmrsql)
        
        let cattle_manage = "create table if not exists cattle_manage (cattle_name text, cattle_type text, cattle_num integer, morning_proportion integer, nooning_proportion integer, evening_proportion integer, cttle_id integer auto_increment primary key)"
        self.createTable(cattle_manage, tmrsql: tmrsql)
        
        let foundation_manage = "create table if not exists foundation_manage (cattle_name text, forage_name text, forage_type text, forage_weight double)"
        self.createTable(foundation_manage, tmrsql: tmrsql)
        
        tmrsql.sqlite_close()

    }
    
    private func createTable(sql:String, tmrsql:TMRSQLite){
        
        var stmt:COpaquePointer = nil
        if tmrsql.sqlite_prepared(sql, stmt: &stmt) != SQLITE_OK {
            print("sqlite_prepared error!!!")
        }
        if tmrsql.sqlite_step(stmt) == SQLITE_ERROR {
            print("sqlite_step error!!!")
        }
        tmrsql.sqlite_finalize(stmt)
    }
    
    
    private func alamofireTest(){

        
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRLoginQuery", parameters: nil)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                        let json = JSON(response.result.value!)
                        print(json)
                    
                    }
                    
                }
                
    }
}

