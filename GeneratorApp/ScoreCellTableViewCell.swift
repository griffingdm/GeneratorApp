//
//  ScoreCellTableViewCell.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/15/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import UIKit

class ScoreCellTableViewCell: UITableViewCell {
    @IBOutlet weak var rankLabel: SpaceLabel!
    @IBOutlet weak var NameLabel: SpaceLabel!
    @IBOutlet weak var scoreLabel: SpaceLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
