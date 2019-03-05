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
    
    var presenter: MoviesVCPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
        
        setupNavigationBar()
        
        presenter?.viewDidLoad()

    }

    private func setupNavigationBar() {
        self.title = "Movies"
        
        let addMovieButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createMovie))
        addMovieButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = addMovieButton
    }
    
    
    @objc func createMovie() {
        presenter?.addMovie()
    }


}


