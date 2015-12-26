//
//  Message.swift
//  DateMatch
//
//  Created by Mark Rabins on 12/25/15.
//  Copyright (c) 2015 self.swift. All rights reserved.
//

import Foundation

struct Message {
    let message: String
    let senderID: String
    let date: NSDate
}

private let ref = Firebase(url: "https://datematch.firebaseio.com/messages")
private let dateFormat = "yyyyMMddHHmmss"

private func dateFormatter() -> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormat
}

func saveMessage(MatchID: String, message: Message) {
    
    ref.childByAppendingPath(MatchID).updateChildValues([dateFormatter().stringFromDate(message.date) : ["message" : message.message, "sender" : message.senderID]])
}

