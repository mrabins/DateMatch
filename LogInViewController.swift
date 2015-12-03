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
                
                var alert = UIAlertController(title: "Oh no!", message: "This app requires Facebook. Please log in with Facebook", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                return
            }
            else if user.isNew {
                println("User signed up with logged in through Facebook!")
                
                FBRequestConnection.startWithGraphPath("/me?fields=picture,first_name,birthday,gender", completionHandler: {
                    connection, result, error in
                    var r = result as NSDictionary
                    user ["firstName"] = r["first_name"]
                    user ["gener"] = r ["gender"]
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateformat = "MM/dd/yyyy"
                    user ["birthday"] = dateformatter.dateFromString(r["birthday"] as String)
                    
                    let pictureURL = ((r["picture"] as NSDictionary)["data"] as NSDictionary) ["url"] as String
                    let url = NSURL(string: pictureURL)
                    let request = NSURLRequest(URL: url!)
                    
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                        response, data, error in
                        
                        let imageFile = PFFile(name: "avatar.jpg", data: data)
                        user ["picture"] = imageFile
                        user.saveInBackgroundWithBlock(nil)
                        
                    })
                    
                    user.saveInBackgroundWithBlock({
                        success, error in
                        println(success)
                        println(error)
                    })
                })
                
                
            }
            else {
                println("User logged in through facebook!")
            }
            
            let vc = UIStoryboard (name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as? UIViewController
            
            self.presentViewController(cv!, animated: true, completion: nil)
        })
    }

}
