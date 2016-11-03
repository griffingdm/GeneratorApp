//
//  EquipmentTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 10/30/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class EquipmentTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: SpaceLabel!
    @IBOutlet weak var modelLabel: SpaceLabel!
    @IBOutlet weak var equipImage: UIImageView!
    @IBOutlet weak var quantity: SpaceLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}