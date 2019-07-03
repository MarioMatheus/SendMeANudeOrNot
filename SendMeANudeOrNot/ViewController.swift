//
//  ViewController.swift
//  SendMeANudeOrNot
//
//  Created by Mario Matheus on 02/07/19.
//  Copyright © 2019 Mario Code House. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nudeLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var nudeImageView: UIImageView! {
        didSet {
            nudeImageView.contentMode = .scaleAspectFill
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func classifyImage(_ image: UIImage) {
        if let (className, percentage) = NudityBase().predict(with: image) {
            switch className {
            case "NSFW":
                nudeLabel.text = "Is a Nude"
            case "SFW":
                nudeLabel.text = "Not a nude"
            default:
                nudeLabel.text = "Error"
            }
            percentageLabel.text = "\(Int(percentage * 100))%"
        }
        displayActivityIndicator(shouldDisplay: false)
    }
    
    func setOutlets(with image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            guard let image = image else {
                self?.displayActivityIndicator(shouldDisplay: false)
                return
            }
            self?.nudeImageView.image = image
            self?.classifyImage(image)
        }
    }
    
    func openCamera(action: UIAlertAction) -> Void {
        displayActivityIndicator(shouldDisplay: true)
        ImagePicker.controller.pickPhotoFromCamera(in: self) { image in
            self.setOutlets(with: image)
        }
    }
    
    func openGallery(action: UIAlertAction) -> Void {
        displayActivityIndicator(shouldDisplay: true)
        ImagePicker.controller.pickPhotoFromGallery(in: self) { image in
            self.setOutlets(with: image)
        }
    }

    @IBAction func imageViewDidTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Pick a photo", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: openCamera))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: openGallery))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in actionSheet.dismiss(animated: true, completion: nil) }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
}
