//
//  RoundedButton.swift
//  MT-Liftoff-VunglerSDK-Project
//
//  Created by Matthew Tripodi on 1/25/24.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Giving the button a rounded look by adjusting the corner radius
        layer.cornerRadius = 8
        layer.borderWidth = 2
    }
}
