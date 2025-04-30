//
//  Toast.swift
//  Flash Chat iOS13
//
//  Created by Stanislav Pavlenko on 30.04.2025.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

func showToast(message: String, in view: UIView, duration: Double = 3.0) {
    let toastLabel = UILabel()
    toastLabel.text = message
    toastLabel.textColor = .white
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textAlignment = .center
    toastLabel.font = UIFont.systemFont(ofSize: 14)
    toastLabel.numberOfLines = 0
    
    let padding: CGFloat = 16
    let maxSize = CGSize(width: view.frame.size.width - 2 * padding, height: .greatestFiniteMagnitude)
    let expectedSize = toastLabel.sizeThatFits(maxSize)
    toastLabel.frame = CGRect(
        x: padding,
        y: view.frame.size.height - expectedSize.height - 100,
        width: view.frame.size.width - 2 * padding,
        height: expectedSize.height + 16
    )
    toastLabel.layer.cornerRadius = 8
    toastLabel.clipsToBounds = true
    
    view.addSubview(toastLabel)
    toastLabel.alpha = 0.0
    
    UIView.animate(withDuration: 0.3, animations: {
        toastLabel.alpha = 1.0
    }, completion: { _ in
        UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    })
}
