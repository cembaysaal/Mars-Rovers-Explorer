//
//  PhotoCollectionViewCell.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

//import UIKit
//
//class PhotoCollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var imageView: UIImageView!
//
//    func configure(with photo: Photo) {
//        if let url = URL(string: photo.img_src) {
//            DispatchQueue.global().async {
//                if let data = try? Data(contentsOf: url) {
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
//    }
//}
