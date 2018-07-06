//
//  DetailTableViewCell.swift
//  HistoryToday
//
//  Created by Cary on 2018/7/5.
//  Copyright © 2018年 Cary. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    var detailLabel = UILabel()
    var img = UIImageView()
    //240
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.right.equalTo(self.contentView.snp.right).offset(-16)
        }
        
        self.contentView.addSubview(detailLabel)
        detailLabel.numberOfLines = 0
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self.contentView.snp.left).offset(16)
            make.right.equalTo(self.contentView.snp.right).offset(-16)
        }
        self.contentView.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(5)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.centerX.equalTo(self.contentView.snp.centerX)
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
