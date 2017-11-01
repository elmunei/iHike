//
//  Group.swift
//  andika
//
//  Created by Elvis Tapfumanei on 10/6/17.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.

//

import Foundation
import NotificationBannerSwift
class Group {
    
    let groupDictionary: NSMutableDictionary
    
    init (name: String, ownerId: String, members: [String], avatar: String) {
        
        groupDictionary = NSMutableDictionary(objects: [name, ownerId, members, avatar], forKeys: [kNAME as NSCopying, kOWNERID as NSCopying, kMEMBERS as NSCopying, kAVATAR as NSCopying])
    }
    
    
    class func saveGroup(group: NSMutableDictionary) {
        
        let reference = firebase.child(kGROUP).childByAutoId()
        let date = dateFormatter().string(from: Date())
        
        group[kGROUPID] = reference.key
        group[kDATE] = date
        
        reference.setValue(group) { (error, ref) in
            
            if error != nil {
                
                let banner = StatusBarNotificationBanner(title: error!.localizedDescription, style: .danger)
                banner.show()
                
            }
        }
        
    }
    
    
    class func deleteGroup(groupId: String) {
        
        firebase.child(kGROUP).child(groupId).removeValue { (error, ref) in
            
            if error != nil {
                
                let banner = StatusBarNotificationBanner(title: error!.localizedDescription, style: .danger)
                banner.show()
                
            } else {
                
                deleteMultipleRecentItems(chatRoomID: groupId)
                
                deleteChatroom(chatRoomID: groupId)
            }
        }
    }
    
}
