//
//  MoviesVC+TableView.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/2/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit


extension MoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return doesExitOfflineMovies ?
                ["My Movies", "All Movies"][section] :
                "All Movies"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
        view.borderColor = UIColor.black
        view.borderWidth = 1.0
    }
}

extension MoviesVC: UITableViewDataSource {
    
    var doesExitOfflineMovies: Bool {
        return (presenter?.getOfflineMoviesCount() ?? 0) > 0
    }
    
    func setupTableView() {
        self.moviesTV.dataSource = self
        self.moviesTV.delegate = self
        moviesTV.register(UINib(nibName: "MovieTVC", bundle: nil), forCellReuseIdentifier: "movieCell")
        
        moviesTV.rowHeight = UITableView.automaticDimension
        moviesTV.estimatedRowHeight = 500
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return doesExitOfflineMovies ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let offlineMoviesCount = presenter?.getOfflineMoviesCount() ?? 0
        let moviesCount = (presenter?.getMoviesCount() ?? 0) + 1  // +1 for loading cell
        
        return doesExitOfflineMovies ?
            [offlineMoviesCount, moviesCount][section] :
            moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTVC
        cell.reset()
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            presenter?.getNextMoviesPage()
            cell.setupForLoading()
            return cell
        }
        !doesExitOfflineMovies ?
            presenter?.configure(cell: cell, for: indexPath.row) :
            indexPath.section == 0 ?
                presenter?.configure(offlineCell: cell, for: indexPath.row) :
                presenter?.configure(cell: cell, for: indexPath.row)
        return cell
    }
    
    
}
