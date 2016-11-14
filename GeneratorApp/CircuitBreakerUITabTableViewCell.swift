//
//  CircuitBreakerUITabTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/13/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class CircuitBreakerUITabTableViewCell: UITableViewCell {
    @IBOutlet weak var circuitBreakImageView: UIImageView!
    @IBOutlet weak var CircuitBreakLabel: SpaceLabel!
    @IBOutlet var circuitBreakDetailLabels: [UILabel]!

    var parentController: PrincipalViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func playCircuitBreaker(_ sender: Any) {
        parentController.tabViewController.performSegue(withIdentifier: "gameSegue", sender: nil)
    }
}
