//
//  AddMovieVC+ImagePickerDelegate.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

extension AddMovieVC: ImagePickerButtonDelegate {
    func ImagePickerButton(imagePickerButton: ImagePickerButton, didDidEndPickingImage image: UIImage) {
        movieImage = image
        confirmedImageIV.isHidden = false
    }
}
