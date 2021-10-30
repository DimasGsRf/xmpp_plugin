//
//  XMPPReceiveMessage.swift
//  flutter_xmpp
//
//  Created by xRStudio on 17/08/21.
//

import Foundation
import Foundation
import XMPPFramework

extension XMPPController {
    
    func handel_ChatMessage(_ message: XMPPMessage, withType type : String, withStrem : XMPPStream) {
        if APP_DELEGATE.objEventData == nil {
            print("\(#function) | Nil data of APP_DELEGATE.objEventData")
            return
        }
        
        //TODO: Message - Singal
        var objMess : Message = Message.init()
        objMess.initWithMessage(message: message)
        let vId : String = objMess.id.trim()
        if vId.count == 0 {
            print("\(#function) | Message Id nil")
            return
        }
        
        let customElement : String = message.getCustomElementInfo(withKey: eleCustom.Kay)
        let vMessType : String = type
        let dicDate = ["type" : "incoming",
                       "id" : objMess.id,
                       "from" : objMess.senderJid,
                       "body" : objMess.message,
                       "customText" : customElement,
                       "msgtype" : vMessType,
                       "senderJid": objMess.senderJid] as [String : Any]
        APP_DELEGATE.objEventData!(dicDate)
        
//        ///Send Delivery Ack
//        if (type == xmppChatType.CHAT){
//            self.senMessDeliveryReceipt(withMessage: objMess, withStrem: withStrem /*APP_DELEGATE.objXMPP.xmppStream*/)
//        }
    }
    
    func handelNormalChatMessage(_ message: XMPPMessage, withStrem : XMPPStream) {
        if message.hasReceiptResponse {
            guard let messId = message.receiptResponseID else {
                print("\(#function) | ReceiptResponseId is empty/nil.")
                return
            }
            self.senAckDeliveryReceipt(withMessageId: messId)
            return
        }
    }
}
