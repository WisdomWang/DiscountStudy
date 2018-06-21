//
//  DetailViewController.swift
//  HistoryToday
//
//  Created by Cary on 2018/6/13.
//  Copyright © 2018年 Cary. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableViewStyle.plain)
    
    var arrList = [Any]()
    var arrDate = [Any]()
    var idNameArr = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "历史上的今天"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.view.addSubview(mainTableView)
        self.loadList()
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "detailCell"
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let user = arrList[indexPath.row] as! detailModel
        cell.textLabel?.text = user.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = user.content
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    func loadList() {
        var url = "http://v.juhe.cn/todayOnhistory/queryDetail.php?key=3955d71543be4871a52345def305b057&e_id="
        url = url+idStr
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
           let dic : Dictionary<String, Any> = response.result.value as! Dictionary<String, Any>
            let arr:Array<Any> = dic["result"] as!Array<Any>
            for i in 0..<arr.count {

                let dic3:Dictionary<String,Any> = arr[i] as! Dictionary<String, Any>
                let user = detailModel(JSON:dic3)
                self.arrList.append(user as Any)
            }
          self.mainTableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
