//
//  ViewController.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/2/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    
    @IBOutlet weak var moviesTV: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesTV.register(UINib(nibName: "MovieTVC", bundle: nil), forCellReuseIdentifier: "movieCell")
        
        moviesTV.rowHeight = UITableView.automaticDimension
        moviesTV.estimatedRowHeight = 500
        
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let addMovieButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        self.navigationItem.rightBarButtonItem = addMovieButton
//        let searchController = UISearchController(searchResultsController: nil)
//        self.navigationItem.searchController = searchController
//        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    @objc func addMovie() {
        
    }


}


extension MoviesVC: UITableViewDelegate {
    
}

extension MoviesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTVC
        return cell ?? UITableViewCell()
    }
    
    
}

