//
//  LogInViewController.swift
//  DateMatch
//
//  Created by Mark Rabins on 11/27/15.
//  Copyright © 2015 self.swift. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedFBLogin(sender: UIButton) {
        
        PFFacebookUtils.logInWithPermissions(permissions: ["public_profile", "user_about_me", "user_birthday"], block: {
            user, error in
            if user == nil {
                println("Uh oh. The user cancalled the facebook Login")
            }
            else if user.isNew {
                println("User signed up with logged in through Facebook!")
            }
            else {
                println("User logged in through facebook")
            }
        })
    }

}
