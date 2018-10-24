


//
//  PopView.swift
//  HistoryToday
//
//  Created by Cary on 2018/10/24.
//  Copyright © 2018 Cary. All rights reserved.
//

import UIKit
import SnapKit
class PopView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    class func showImage(image:UIImage) {
    
        let bg = PopView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        bg.backgroundColor = UIColor.black
        let window = UIApplication.shared.windows.last
        window?.addSubview(bg)
        
        let imageView = UIImageView(image: image)
         bg.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        imageView.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(bg.snp.centerX)
            make.centerY.equalTo(bg.snp.centerY)
        }
        
        let tap = UITapGestureRecognizer(target: bg, action: #selector(popBack))
        bg.addGestureRecognizer(tap)
        
    }
    
    @objc func popBack() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (finished) in
            
            self.removeFromSuperview()
            
        }
    }

}
