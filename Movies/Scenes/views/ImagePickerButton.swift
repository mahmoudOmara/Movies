//
//  AddMovieVCRouter.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

protocol ImagePickerButtonDelegate {
    func ImagePickerButton(imagePickerButton: ImagePickerButton, didDidEndPickingImage image: UIImage)
}

class ImagePickerButton: UIButton, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var delegate: ImagePickerButtonDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        
    }

    
    func open(imageSource: UIImagePickerController.SourceType) {
        let imagPickerController = UIImagePickerController()
        imagPickerController.sourceType = imageSource
        imagPickerController.delegate = self
        
        imagPickerController.allowsEditing = true
        UIApplication.shared.keyWindow?.rootViewController?.present(imagPickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker : UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let sellectedPhoto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        delegate.ImagePickerButton(imagePickerButton: self, didDidEndPickingImage: self.imageOrientation(sellectedPhoto))
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnClick(_ sender: Any) {
        let alert = UIAlertController.init(title: "Choose Image From", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let camera = UIAlertAction.init(title: "Camera", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.open(imageSource: .camera)
            alert.dismiss(animated: true, completion: nil)
        }
        let gallery = UIAlertAction.init(title: "Gallery", style: UIAlertAction.Style.default) { (UIAlertAction) in
            self.open(imageSource: .photoLibrary)
            alert.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    private func imageOrientation(_ src:UIImage)->UIImage {
        if src.imageOrientation == UIImage.Orientation.up {
            return src
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch src.imageOrientation {
        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
            transform = transform.translatedBy(x: src.size.width, y: src.size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
            transform = transform.translatedBy(x: src.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
            break
        case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: src.size.height)
            transform = transform.rotated(by: -CGFloat.pi / 2)
            break
        case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
            break
        }
        
        switch src.imageOrientation {
        case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
            transform.translatedBy(x: src.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
            transform.translatedBy(x: src.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
            break
        }
        
        let ctx:CGContext = CGContext(data: nil, width: Int(src.size.width), height: Int(src.size.height), bitsPerComponent: (src.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (src.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch src.imageOrientation {
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.height, height: src.size.width))
            break
        default:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.width, height: src.size.height))
            break
        }
        
        let cgimg:CGImage = ctx.makeImage()!
        let img:UIImage = UIImage(cgImage: cgimg)
        
        return img
    }
}
