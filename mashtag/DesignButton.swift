//
//  DesignButton.swift
//  mashtag
//
//  Created by Austin Chan on 7/10/15.
//  Copyright (c) 2015 Fiftyawoe. All rights reserved.
//

import UIKit

// UIButton subclass that supports changing letter spacing in Interface Builder. Very useful!
class DesignButton: UIButton {

    var characterSpacing: NSNumber!

    override func awakeFromNib() {
        setup()
    }

    func setup() {
        if characterSpacing != nil && characterSpacing != 0 {
            var string = titleLabel?.text!
            var attributedString: NSMutableAttributedString = NSMutableAttributedString(string: string!)
            attributedString.addAttribute(NSKernAttributeName, value: CGFloat(characterSpacing), range: NSRange(location: 0, length: count(string!)))
            UIView.performWithoutAnimation({
                self.setAttributedTitle(attributedString, forState: .Normal)
                self.layoutIfNeeded()
            })
        }
    }

}
