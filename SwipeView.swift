//
//  SwipeView.swift
//  DateMatch
//
//  Created by Mark Rabins on 11/15/15.
//  Copyright (c) 2015 self.swift. All rights reserved.
//

import Foundation
import UIKit

class SwipeView: UIView {
    
    private let card: CardView = CardView ()
    
   required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize () 
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize ()
    }
    
    override init() {
        super.init()
        initialize ()
    }
    
    private func initialize () {
        self.backgroundColor = UIColor.clearColor()
        addSubview(card)
        setConstraints()
    }
    private func setConstraints () {
        
    }
    
}
