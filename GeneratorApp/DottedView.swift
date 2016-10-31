//
//  DottedView.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/30/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class DottedView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
        makeDots()
    }
    
    func makeDots(){
        self.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "dot-pttn"))
    }
}
