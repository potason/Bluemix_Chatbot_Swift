//
//  ViewController.swift
//  MidnightChatbot
//
//  Created by Finn Potason on 08/12/2017.
//  Copyright © 2017 Finn Potason. All rights reserved.
//

import UIKit
import ConversationV1
//import JSQMessages


class ViewController: UIViewController {

    
    let APIKey = "cc6f56ad-4c66-4478-a59f-6fa3f3be4fa0"
    let version = "2017-11-26"
    
    let ranbID = "60fde55d-c0d2-4e8e-8747-d7caf62d652c"
    let tulpID = "abc8e83f-e82e-4fb9-8d80-bafbc628d37f"
    
//    let username = "cc6f56ad-4c66-4478-a59f-6fa3f3be4fa0"
//    let password = "B1o1dKCeWkG3"
    
    
    let conversation = Conversation(username:"cc6f56ad-4c66-4478-a59f-6fa3f3be4fa0",  password: "B1o1dKCeWkG3", version:"2017-12-10")
    
    var context: Context?
    
    var reply = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startConversation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var text1: UITextView!
    
    @IBOutlet weak var text2: UITextView!
    
    @IBOutlet weak var visitor_input: UITextField!
    
    @IBAction func send(_ sender: UIButton) {
        
        print(" button pressed; time to chat")
        
//        print ("visitor input = ", visitor_input!.text!)
        let text = visitor_input!.text!
        text2.text = text
        //interact with the server
        
//        text1.text = "Hello. How can I help you?"
        
//        startConversation()
        
        
        // send text to conversation service
        let input = InputData(text: text)
        let request = MessageRequest(input: input, context: context)
        conversation.message(
            workspaceID: ranbID,
            request: request,
            failure: failure,
            success: presentResponse
        )
        
//        startConversation()
        
        text1.text = self.reply
        print("The reply from Watson is: ", reply)

//        visitor_input!.text = ""
    }
    
    /// Present an error message
    func failure(error: Error) {
        let alert = UIAlertController(
            title: "Watson Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    
    // next, specify which chatbot to use?
    
    /// Present a conversation reply and speak it to the user
   
    func presentResponse(_ response: MessageResponse) {
        print("success ")
//
        print ("WATSON: ",response.output.text.joined())
        self.reply = response.output.text.joined()
        
    }
    
    func startConversation() {
        conversation.message(
            workspaceID: ranbID,
            failure: failure,
            success: presentResponse
        )
    }
    
    
    
    
   
}

