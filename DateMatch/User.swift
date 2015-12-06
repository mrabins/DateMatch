//
//  User.swift
//  DateMatch
//
//  Created by Mark Rabins on 11/28/15.
//  Copyright (c) 2015 self.swift. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let pictureURL: String
    let name: String
    private let pfUser: PFUser
}

func getPhoto (callback:(UIImage) -> ()) {
    let imageFile = pfUser.objectForKey("picture") as PFFile
    imageFile.getDataInBackgroundWithBlock({
        data, error in
        if let data = data {
            callback(UIImage(data: data )!)
        }
        
    })
}

private func pfUserToUser(user: PFUser) -> User {
    return User(id: user.objectId, pictureURL: user.objectForKey("picture") as String, name: user.objectForKey("firstName") as String, pfUser: user)
}

func currentUser() -> User? {
    if let user = PFUser.currentUser() {
        return pfUserToUser(user)
    }
    return nil
}
