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

class MessageListener {
    
    var currentHandle: UInt?
    
    init(matchID: String, startDate: NSDate, classback: (Message) -> ()) {
        let handle = ref.childByAppendingPath(matchID).queryOrderedByKey().queryStartingAtValue(dateFormatter().stringFromDate(startDate)).observeEventType(FEventType.ChildAdded, withBlock: {
            snapshot in
            let message = snapshotToMessage(snapshot)
            callback(message)
        })
        self.currentHandle = handle
    }
    func stop() {
        if let handle = currentHandle {
            ref.removeObserverWithHandle(handle)
            currentHandle = nil
        }
    }
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

private func snapshotToMessage(snapshot: FDataSnapshot) -> Message {
    let date = dateFormatter().dateFromString(snapshot.key)
    let sender = snapshot.value["sender"] as? String
    let text = snapshot.value["message"] as? String
    return Message(message: text!, senderID: sender!, date: date!)
}

func fetchMessages(matchID: String, callback: ([Message]) -> ()) {
    ref.childByAppendingPath(matchID).queryLimitedToFirst(25).observeSingleEventOfType(FEventType.Value, withBlock: {
        snapshot in
        var messages = Array<Message>()
        let enumerator = snapshot.children
        while let data = enumerator.nextObject() as? FDataSnapshot {
            messages.append(snapshotToMessage(data))
        }
        callback(messages)
    })
}

