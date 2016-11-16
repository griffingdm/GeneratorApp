//
//  TouchDownGestureRecognizer.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/15/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class TouchDownGestureRecognizer: UIGestureRecognizer
{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible
        {
            self.state = .recognized
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
    
}
