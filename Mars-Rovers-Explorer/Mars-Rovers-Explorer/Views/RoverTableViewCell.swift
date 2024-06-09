//
//  RoverTableViewCell.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import UIKit

import UIKit

class RoverTableViewCell: UITableViewCell {
    @IBOutlet weak var roverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var landingDateLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!

    func configure(with rover: Rover) {
        nameLabel.text = rover.name
        landingDateLabel.text = "Landing Date: \(rover.landing_date)"
        launchDateLabel.text = "Launch Date: \(rover.launch_date)"
        statusLabel.text = rover.status.capitalized
        statusLabel.backgroundColor = rover.status == "active" ? .systemGreen : .systemRed
        roverImageView.image = UIImage(named: rover.name.lowercased())
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .systemGray
        
        // Design adjustments
        statusLabel.textColor = .white
        statusLabel.layer.cornerRadius = 10
        statusLabel.layer.masksToBounds = true
        statusLabel.sizeToFit()
    }
}
