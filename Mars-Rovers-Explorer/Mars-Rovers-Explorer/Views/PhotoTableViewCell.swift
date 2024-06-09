//
//  PhotoTableViewCell.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Design adjustments
        photoImageView.layer.cornerRadius = 10
        photoImageView.clipsToBounds = true
    }

    func configure(with photo: Photo) {
        idLabel.text = "ID: \(photo.id)"
        cameraLabel.text = photo.camera.full_name
        dateLabel.text = photo.earth_date
        if let url = URL(string: photo.img_src) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.photoImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
