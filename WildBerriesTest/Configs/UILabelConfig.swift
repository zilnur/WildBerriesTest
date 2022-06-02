//
//  UILabelConfug.swift
//  WildBerriesTest
//
//  Created by Ильнур Закиров on 01.06.2022.
//

import Foundation
import UIKit

extension UILabel {
    func textWithImage(imageName: String, text: String) {
        let attachement = NSTextAttachment()
        attachement.image = UIImage(systemName: imageName)?.withTintColor(.purple)
        let textImage = NSAttributedString(attachment: attachement)
        
        let labelText = NSMutableAttributedString(string: text)
        labelText.insert(textImage, at: 0)
        self.attributedText = labelText
    }
}
