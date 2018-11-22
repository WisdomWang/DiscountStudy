//
//  ViewController.swift
//  HistoryToday
//
//  Created by Cary on 2018/6/8.
//  Copyright © 2018年 Cary. All rights reserved.
//

import UIKit
import Alamofire
import Hue

// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let STATUS = UIApplication.shared.statusBarFrame.size.height

let NAV:CGFloat = 44

var idStr = ""

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var label:UILabel!
    var arrList = [Any]()
    var arrDate = [Any]()
    var idNameArr = [Any]()
    let now = Date()
    let dformatter = DateFormatter()
    
    var changedDate:Date!
    
    var bgView:UIView!
    
    let mainTableView = UITableView(frame: CGRect(x: 0, y: 50+NAV+STATUS, width:SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableViewStyle.plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "历史上的今天"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 90
        mainTableView.showsVerticalScrollIndicator = false
        self.view.addSubview(mainTableView)
        self.loadList(date: now)
        changedDate = now
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: STATUS+NAV, width: SCREEN_WIDTH, height: 50)
        headerView.backgroundColor = UIColor(hex: "#eeeeee")
        label = UILabel(frame: CGRect(x: 16, y: 0, width: SCREEN_WIDTH-32, height: 50))
        dformatter.dateFormat = "YYYY年MM月dd日"
        label.text = dformatter.string(from:now)
        //label.text = "Today：\(dformatter.string(from: now))"
        headerView.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: SCREEN_WIDTH-76, y: 0, width: 60, height: 50))
        button.setTitle("切换日期", for:.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        button.addTarget(self, action: #selector(changeDate), for: .touchUpInside)
        headerView.addSubview(button)
        
        self.view.addSubview(headerView)

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
    
   @objc func changeDate () {
    
       let window = UIApplication.shared.keyWindow
        bgView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bgView.backgroundColor = UIColor(hex: "#000000").alpha(0.4)
        self.view.insertSubview(bgView, aboveSubview: window!)
    
    
        let picker = UIDatePicker(frame: CGRect(x: 0, y: SCREEN_HEIGHT-200, width: SCREEN_WIDTH, height: 200))
        picker.datePickerMode = UIDatePickerMode.date
        picker.backgroundColor = UIColor(hex: "#eeeeee")
        picker.date = changedDate
        bgView.addSubview(picker)
        picker.addTarget(self, action: #selector(dateChange(picker:)), for: .valueChanged)
        let locale = NSLocale(localeIdentifier: "zh_CN")
        picker.locale = locale as Locale
    
        let button = UIButton(frame: CGRect(x: picker.frame.size.width - 50, y: SCREEN_HEIGHT-190, width: 40, height: 30))
        button.setTitle("确定", for:.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        button.addTarget(self, action: #selector(finish), for: .touchUpInside)
        bgView.addSubview(button)
    
        let cancelButton = UIButton(frame: CGRect(x: 10, y: SCREEN_HEIGHT-190, width: 40, height: 30))
        cancelButton.setTitle("取消", for:.normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.setTitleColor(UIColor(hex: "#333333"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        bgView.addSubview(cancelButton)

    }
    
    @objc  func cancel () {
        
        UIView.animate(withDuration: 0.5) {
            
            self.bgView.removeFromSuperview()
        }

    }
    
    @objc  func  finish () {
        
        bgView.removeFromSuperview()
        dformatter.dateFormat = "yyyy年 MM月 dd日"
        label.text = dformatter.string(from:changedDate)
        self.loadList(date: changedDate)
    }
    
    @objc  func dateChange (picker:UIDatePicker) {
        
        changedDate = Date()
        changedDate = picker.date
    }
    
    func loadList(date:Date) {
       
        arrList.removeAll()
        arrDate.removeAll()
        idNameArr.removeAll()
        dformatter.dateFormat = "MM/dd"
        print("当前日期时间：\(dformatter.string(from: date))")
        let str = dformatter.string(from: date)
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

