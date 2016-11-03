//
//  SpaceLabel.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/26/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class SpaceLabel: UILabel {
    
    let spacing = 4.4
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override var text: String? {
        didSet {
            addCharacterSpacing()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        //self.layer.cornerRadius = self.bounds.width/2
        //self.clipsToBounds = true
        //self.textColor = UIColor.white
        //self.setProperties(borderWidth: 1.0, borderColor:UIColor.black)
        addCharacterSpacing()
    }
    
    func addCharacterSpacing(){
        let attributedString = NSMutableAttributedString(string: self.text!)
        
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func setProperties(borderWidth: Float, borderColor: UIColor) {
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }
}
