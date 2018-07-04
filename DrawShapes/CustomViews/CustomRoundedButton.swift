//
//  CustomRoundedButton.swift
//  DrawShapes
//
//  Created by Mohit Totlani on 04/07/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class CustomRoundedButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layer.cornerRadius = self.layer.frame.size.height/2;
        
    }

}
