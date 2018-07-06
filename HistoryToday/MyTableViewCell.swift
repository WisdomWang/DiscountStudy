//
//  MyTableViewCell.swift
//  HistoryToday
//
//  Created by Cary on 2018/6/8.
//  Copyright © 2018年 Cary. All rights reserved.
//

import UIKit
import SnapKit
class MyTableViewCell: UITableViewCell {

    var dateLabel = UILabel()
    var titleLabel = UILabel()
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }

        self.contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
