//
//  TipView.swift
//  HistoryToday
//
//  Created by Cary on 2018/7/20.
//  Copyright © 2018年 Cary. All rights reserved.
//

import UIKit
typealias callbackFunc = ()->Void

class TipView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var evaluationBlockCallback:callbackFunc?
    
    class func showCenterTitle (title:String,duration:TimeInterval, complition:@escaping ()->Void){
        let bg = TipView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        let window = UIApplication.shared.keyWindow
        bg.backgroundColor = UIColor.clear
        window?.addSubview(bg)
        let labelTitle = UILabel()
        labelTitle.textColor = UIColor.white
        labelTitle.textAlignment = .center
        labelTitle.backgroundColor = UIColor.black
        labelTitle.alpha = 0.7
        labelTitle.numberOfLines = 0
        labelTitle.font = UIFont.systemFont(ofSize: 18)
        labelTitle.text = title
        labelTitle.frame = CGRect(x: 0, y: 0, width: bg.frame.size.width - 88, height: 0)
        labelTitle.sizeToFit()
        var rect = labelTitle.bounds
        rect.size.width = rect.size.width + 22
        rect.size.height = rect.size.height + 11
        labelTitle.bounds = rect
        labelTitle.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2)
        labelTitle.layer.cornerRadius = 5
        
        bg.addSubview(labelTitle)
        bg.evaluationBlockCallback = complition
        if duration == TimeInterval(MAXFLOAT) {
            return
        }
        bg.perform(#selector(removeFromSuperview), with: nil, afterDelay: duration)
        
    }
    @objc override func removeFromSuperview() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (finished) in
            
            UIView.animate(withDuration: 0.25, animations: {
                super.removeFromSuperview()
            }, completion: { (finished) in
                self.evaluationBlockCallback!()
            })
        }
    }
    
}
