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
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button .setImage(UIImage(named: "popBack"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftButton

        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedRowHeight = self.view.frame.size.height
        mainTableView.rowHeight = UITableViewAutomaticDimension
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        self.loadList()
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "detailCell"
        let cell = DetailTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let user = arrList[indexPath.row] as! detailModel
        cell.titleLabel.text = user.title
        cell.detailLabel.text = user.content
        //定义URL对象
        if (user.url != nil) {
            let url = URL(string: user.url!)
            let data = try! Data(contentsOf: url!)
            let newImage = UIImage(data: data)
            cell.img.image = newImage
        }
        
        cell.pushToBigPic = {
            
            if cell.img.image != nil {
                
                PopView.showImage(image: cell.img.image!)
            }
        }
        
        return cell
    }
    
    func loadList() {
        var url = "http://v.juhe.cn/todayOnhistory/queryDetail.php?key=3955d71543be4871a52345def305b057&e_id="
        url = url+idStr
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            print(response.error as Any)
           let dic : Dictionary<String, Any> = response.result.value as! Dictionary<String, Any>
            var arr:Array<Any>?
            arr = dic["result"] as? Array<Any>
            print(response.result.value as Any)
            if !(arr != nil) {
                return
            }
            for i in 0..<arr!.count {

                let dic3:Dictionary<String,Any> = arr?[i] as! Dictionary<String, Any>
                let user = detailModel(JSON:dic3)
                print(user?.url as Any)
                self.arrList.append(user as Any)
            }
          self.mainTableView.reloadData()
        }
    }
    
    @objc func popBack() {
        
        self.navigationController?.popViewController(animated: true)
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
