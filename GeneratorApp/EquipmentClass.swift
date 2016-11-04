//
//  EquipmentClass.swift
//  GeneratorApp
//
//  Created by Mullins, Griffin on 11/3/16.
//  Copyright © 2016 Mullins, Griffin. All rights reserved.
//

import Foundation
import UIKit

class Equipment {
    //for table
    var name: String!
    var model: String!
    var image: UIImage!
    var qty: Int!
    
    //for detail
    
    
    
    init(eName: String, eModel: String, eImage: UIImage, eQuant: Int) {
        name = eName
        model = eModel
        image = eImage
        qty = eQuant
    }
}
