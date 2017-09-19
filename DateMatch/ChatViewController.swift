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
    
    var matchID: String?
    
    var messageListener: MessageListener?
    
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messagesBubbleBlueColor())
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithCollor(UIColor.jsq_messageBubbleLightGreyColor())
    
    
    override func viewDidLoad () {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        if let id = matchID {
            fetchMatches(id, {
                messages in
                for m in messages {
                    self.messages.append(JSQMessage(senderID: m.senderID, senderDisplayName: m.senderID, date: m.date, text: m.message))
                }
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillAppear(animate: Bool) {
        
        if let id = matchID {
            messageListener = MessageListener(matchID: id, startDate: NSDate(), classback: {
                message in
                self.messages.append(JSQMessage(senderId: message.senderID, senderDisplayName: message.senderID, date: message.date, text: message.message))
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillDisappear (animate: Bool) {
        messageListener?.stop()
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
        
        if let id = matchID {
            saveMessage(id, Message(messages: text, senderID: senderID, date: date))
        }
        finishSendingMessage()
    }
}
