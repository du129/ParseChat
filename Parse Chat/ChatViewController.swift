//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Jonathan Du on 1/31/18.
//  Copyright © 2018 Jonathan Du. All rights reserved.
//

import UIKit
import Parse
class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
   
    var allPosts : [PFObject] = []
    @IBAction func sendButton(_ sender: Any) {
        let chatMessageA = PFObject(className: "Message")
        chatMessageA["text"] = chatMessage.text ?? ""
        chatMessageA.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = allPosts[indexPath.row]
        cell.messageData.text = message["text"] as? String
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        return cell
    }
    
    @IBOutlet weak var chatMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updatePosts), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updatePosts() {
        let messages = PFQuery(className:"Message").includeKey("user")
        messages.findObjectsInBackground {
            (messages,error) -> Void in
            if messages != nil {
                self.allPosts = messages!
                self.tableView.reloadData()
            }else{
                print(error!.localizedDescription)
            }
        }
//        messages.findObjectsInBackground
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
