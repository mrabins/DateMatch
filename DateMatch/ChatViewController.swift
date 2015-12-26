//
//  ChatViewController.swift
//  
//
//  Created by Mark Rabins on 12/25/15.
//
//

import Foundation


class ChatViewController: JSQMessagesViewController {
    
    var messages: [JSQMessage] = []
    
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messagesBubbleBlueColor())
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithCollor(UIColor.jsq_messageBubbleLightGreyColor())
    
    
    override func viewDidLoad () {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        
    }
    
    func senderDisplayName() -> String! {
        return currentUser()!.id
    }
    
    func senderID() -> String! {
        return currentUser()!.id
        
    }
    
    override func collectionView(collectionView: JSQMessagesViewController!, messageDataForItemAtIndexPeth indexPath: NSIndexPath!) -> JSQMessageData! {
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        var data = self.messages[indexPath.row]
        if data.senderId == PFUser.currentUser().objectId {
            return outgoingBubble
        }
        else {
            return incomingBubble
        }
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(m)
        finishSendingMessage()
    }
    
    
}