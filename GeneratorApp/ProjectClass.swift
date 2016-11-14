//
//  ProjectClass.swift
//  GeneratorApp
//
//  Created by Abowd, Jonathan on 11/13/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import Foundation
import UIKit

class Project {
    //for table
    var name: String!
    var model: String!
    var image: UIImage!
    var qty: Int!
    
    //for detail
    var detailImages: [UIImage]!
    var instructionText: String!
    
    
    init(eName: String, eModel: String, eImage: UIImage, eQuant: Int, eDetailImages: [UIImage], eInstruct: String) {
        name = eName
        model = eModel
        image = eImage
        qty = eQuant
        detailImages = eDetailImages
        instructionText = eInstruct
    }
    
    func clone(equip: Equipment){
        name = equip.name
        model = equip.model
        image = equip.image
        qty = equip.qty
        detailImages = equip.detailImages
        instructionText = equip.instructionText
    }
}
