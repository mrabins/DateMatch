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
    
    private var originalPoint: CGPoint?
    
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
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "dragged:"))
    }
    
    func dragged(gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translationInView(self)
        println("Distance x: \(distance.x) y: \(distance.y)")
        
        switch gestureRecognizer.state {
            
        case UIGestureRecognizerState.Began:
            originalPoint = center
            
        case UIGestureRecognizerState.Changed:
            let rotationPercentage = min(distance.x/(self.superview!.frame.width/2), 1)
            let rotationAngle = (CGFloat(2*M_PI/16)*rotationPercentage)
            transform = CGAffineTransformRotate(transform, rotationAngle)
            
            center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
            
        case UIGestureRecognizerState.Ended:
            resetViewPositionAndTransformations()
            
        default:
            println("Default triggered for GestureRecognizer")
            break
        }
    }
    
    private func resetViewPositionAndTransformations () {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0)

        })
        
    }
}
