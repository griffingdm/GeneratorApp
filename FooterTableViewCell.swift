//
//  FooterTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/29/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class FooterTableViewCell: UITableViewCell {
    
    @IBOutlet var viewsToRound: [UIView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for view in viewsToRound{
            view.layer.cornerRadius = view.frame.height / 2
            view.clipsToBounds = true
        }
    }
    
    @IBAction func pressPowerDown(_ sender: Any) { 
        print("pressed power down")
        self.window?.rootViewController?.dismiss(animated: true, completion: {
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
