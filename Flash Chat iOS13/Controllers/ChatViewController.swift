//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        navigationItem.hidesBackButton = true
        navigationItem.title = Constants.appName
        
        tableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.cellIdentifier
        )
        
        addMessagesListener()
    }
    
    private func addMessagesListener() {
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener {snapshot, error in
                if let e = error {
                    showToast(message: e.localizedDescription, in: self.view)
                }else {
                    self.messages = []
                    
                    if let snapshotDocuments = snapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let sender = data[Constants.FStore.senderField] as! String
                            let messageBody = data[Constants.FStore.bodyField] as! String
                            
                            self.messages.append(
                                Message(sender: sender, body: messageBody)
                            )
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                if self.messages.count > 0 {
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,
           let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody,
                Constants.FStore.dateField: Date().timeIntervalSince1970
            ], completion: {error in
                if let e = error {
                    showToast(message: e.localizedDescription, in: self.view)
                }else{
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            })
        }
    }
    
    @IBAction func logOutPress(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            showToast(message: signOutError.localizedDescription, in: self.view)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        
        // message from current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
        }else {
            // message from another sender
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.messageBuble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        
        cell.label.text = message.body
        
        return cell
    }
}
