//
//  CardsViewController.swift
//  DateMatch
//
//  Created by Mark Rabins on 11/17/15.
//  Copyright © 2015 self.swift. All rights reserved.
//

import UIKit

weak var cardStackView: UIView!

class CardsViewController: UIViewController {
    
    let frontCardTopMargin: CGFloat = 0
    let backCardTopMargin: CGFloat = 10
    
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: SwipeView?
    var frontCard: SwipeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardStackView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
        
        backCard = SwipeView(frame: createCardFrame(backCardTopMargin))
        cardStackView.addSubview(backCard!)
        
        frontCard = SwipeView(frame: createCardFrame(frontCardTopMargin))
        cardStackView.addSubview(frontCard!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createCardFrame(topMargin: CGFloat) -> CGRect {
        return CGRect(x:0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }

}
