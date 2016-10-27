//
//  PrincipalTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/26/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class PrincipalTableViewCell: UITableViewCell {
    @IBOutlet var patternViews: [UIView]!
    @IBOutlet weak var number: SpaceLabel!
    @IBOutlet weak var icon: UIImage!
    @IBOutlet weak var header: SpaceLabel!
    @IBOutlet var labels: [UILabel]!

//    var headerString: String!
//    var numberString: String!
//    var labelAr: [String] = []
//    var iconImage: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
