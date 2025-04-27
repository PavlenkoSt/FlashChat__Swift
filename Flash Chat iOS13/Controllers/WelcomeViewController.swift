//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateWelcomeText()
    }
    
    private func animateWelcomeText() {
        titleLabel.text = ""
        
        let titleText = "⚡️FlashChat"
        var letterIdx = 0.0

        for letter in titleText {
            letterIdx += 1
            Timer.scheduledTimer(withTimeInterval: 0.1 * letterIdx, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
        }
    }
}
