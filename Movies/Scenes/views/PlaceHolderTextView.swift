//
//  AddMovieVCRouter.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

@IBDesignable
class PlaceHolderTextView: UITextView {
    
    @IBInspectable var placeHolder: String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.text = placeHolder
        
    }
}

extension PlaceHolderTextView: UITextViewDelegate {
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolder {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolder
        }
    }
}
