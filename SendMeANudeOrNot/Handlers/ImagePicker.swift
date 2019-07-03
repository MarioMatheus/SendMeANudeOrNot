//
//  ImagePicker.swift
//  SendMeANudeOrNot
//
//  Created by Mario Matheus on 02/07/19.
//  Copyright © 2019 Mario Code House. All rights reserved.
//

import UIKit

typealias ImagePickerCompletion = (UIImage?) -> Void

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let controller = ImagePicker()
    private let imagePickerCtrl = UIImagePickerController()
    private var imagePickerCompletion: ImagePickerCompletion?
    
    
    private override init() {
        super.init()
        imagePickerCtrl.delegate = self
        imagePickerCtrl.allowsEditing = true
    }
    
    func pickPhotoFromCamera(in ctrl: UIViewController, completion: @escaping ImagePickerCompletion) {
        imagePickerCtrl.sourceType = .camera
        imagePickerCompletion = completion
        
        ctrl.present(imagePickerCtrl, animated: true, completion: nil)
    }
    
    func pickPhotoFromGallery(in ctrl: UIViewController, completion: @escaping ImagePickerCompletion) {
        imagePickerCtrl.sourceType = .photoLibrary
        imagePickerCompletion = completion
        
        ctrl.present(imagePickerCtrl, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerCompletion?(info[.editedImage] as? UIImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerCompletion?(nil)
        picker.dismiss(animated: true, completion: nil)
    }
    
}

