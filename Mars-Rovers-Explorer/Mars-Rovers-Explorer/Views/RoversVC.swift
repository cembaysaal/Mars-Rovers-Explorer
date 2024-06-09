//
//  RoversVC.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import UIKit

class RoversVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = RoversVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rovers"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150  // Adjust as needed

        setupTableViewHeader()
        setupBindings()
        viewModel.fetchRovers()
    }

    private func setupTableViewHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let headerLabel = UILabel(frame: headerView.bounds)
        headerLabel.text = "Rovers"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.textColor = .black
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
    }

    func setupBindings() {
        viewModel.onRoversUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { error in
            DispatchQueue.main.async {
                self.showErrorAlert(error)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRoverDetails" {
            guard let detailsVC = segue.destination as? RoverDetailsVC,
                  let selectedIndexPath = tableView.indexPathForSelectedRow else {
                print("Failed to get destination view controller or selected index path")
                return
            }
            let selectedRover = viewModel.rovers[selectedIndexPath.row]
            detailsVC.viewModel = RoverDetailsVM(rover: selectedRover)
        }
    }
    
    private func showErrorAlert(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension RoversVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rovers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoverCell", for: indexPath) as! RoverTableViewCell
        let rover = viewModel.rovers[indexPath.row]
        cell.configure(with: rover)
        return cell
    }
}

extension RoversVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRoverDetails", sender: self)
    }
}
