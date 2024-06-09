//
//  RoverDetailsVC.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import UIKit

class RoverDetailsVC: UIViewController {
    @IBOutlet weak var roverImageView: UIImageView!
    @IBOutlet weak var numberOfCamerasLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: RoverDetailsVM!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = viewModel else {
            fatalError("viewModel is not set")
        }

        self.title = viewModel.rover.name
        tableView.dataSource = self
        tableView.delegate = self
        setupBindings()
        viewModel.fetchLatestPhotos()

        configureView()
    }

    func configureView() {
        roverImageView.image = UIImage(named: viewModel.rover.name.lowercased())
        numberOfCamerasLabel.text = "Number of Cameras: \(viewModel.rover.cameras.count)"
        numberOfPhotosLabel.text = "Number of Photos: \(viewModel.rover.total_photos)"
    }

    func setupBindings() {
        viewModel.onPhotosUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension RoverDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.latestPhotos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        let photo = viewModel.latestPhotos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
}

extension RoverDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust as needed
    }
}
