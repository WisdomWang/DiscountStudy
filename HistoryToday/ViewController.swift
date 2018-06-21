//
//  ViewController.swift
//  HistoryToday
//
//  Created by Cary on 2018/6/8.
//  Copyright © 2018年 Cary. All rights reserved.
//

import UIKit
import Alamofire

// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

var idStr = ""

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var arrList = [Any]()
    var arrDate = [Any]()
    var idNameArr = [Any]()
    let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableViewStyle.plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadList()
        self.navigationItem.title = "历史上的今天"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 90
        self.view.addSubview(mainTableView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "mainCell"
        let cell = MyTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.titleLabel.text = arrList[indexPath.row] as? String
        cell.dateLabel.text = (arrDate[indexPath.row] as!String)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        idStr = idNameArr[indexPath.row] as! String
    }
    
    func loadList() {
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM/dd"
        print("当前日期时间：\(dformatter.string(from: now))")
        let str = dformatter.string(from: now)
        let str10 = (str as NSString).substring(to: 2)
        let value10 = (str10 as NSString).integerValue
        let str20 = (str as NSString).substring(from: 3)
        let value20 = (str20 as NSString).integerValue
        let url2 = "\(value10)/\(value20)"
        let url1 = "http://v.juhe.cn/todayOnhistory/queryEvent.php?key=3955d71543be4871a52345def305b057&date="
        let url =  url1+url2
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.result.value as Any)
            
            let dic : Dictionary<String, Any> = response.result.value as! Dictionary<String, Any>
            let arr:Array<Any> = dic["result"] as!Array<Any>
            for i in 0..<arr.count {
                
                let dic3:Dictionary<String,Any> = arr[i] as! Dictionary<String, Any>
                self.arrList.append(dic3["title"]!)
                self.arrDate.append(dic3["date"]!)
                self.idNameArr.append(dic3["e_id"]!)
            }
            self.mainTableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

