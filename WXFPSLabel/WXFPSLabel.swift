//
//  WXFPSLabel.swift
//  WXFPSLabel
//
//  Created by Gus on 2020/12/16.
//

import UIKit

class WXFPSLabel: UILabel {
    
    lazy var link = CADisplayLink(target: self, selector: #selector(tick(link:)))
    var lastTime: NSInteger = 0
    var count = 0
    
    init() {
        super.init(frame: CGRect(x: 10, y: 100, width: 65, height: 22))
        layer.cornerRadius = 5
        clipsToBounds = true
        textAlignment = .center
        isUserInteractionEnabled = false
        backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        
        link.add(to: .main, forMode: .common)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = Int(link.timestamp)
            return
        }

        count += 1
        let delta = (Int)(link.timestamp) - lastTime
        if delta < 1 { return }
        lastTime = NSInteger(link.timestamp)
        let fps = count / delta
        count = 0
        
        let progress = fps / 60
        let color = UIColor(hue: 0.27 * (CGFloat(progress) - 0.2), saturation: 1, brightness: 0.9, alpha: 1)
        
        let text = NSMutableAttributedString.init(string: "\(Int(round(Double(fps)))) FPS")
        text.setAttributes([NSAttributedString.Key.foregroundColor : color], range: NSMakeRange(0, text.length - 3))
        text.setAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], range: NSMakeRange(text.length - 3, 3))
        self.attributedText = text
    }
    
    deinit {
        link.invalidate()
    }
}
