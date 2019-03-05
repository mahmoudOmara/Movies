//
//  AddMovieVC.swift
//  Movies
//
//  Created by Mahmoud Omara on 3/4/19.
//  Copyright © 2019 Mahmoud Omara. All rights reserved.
//

import UIKit

class AddMovieVC: UIViewController {

    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var overViewTV: UITextView!
    @IBOutlet weak var rateTF: UITextField!
    @IBOutlet weak var productionYearTF: UITextField!
    @IBOutlet weak var addImageBtn: ImagePickerButton!
    @IBOutlet weak var confirmedImageIV: UIImageView!

    var presenter: AddMovieVCPresenter?
    var movieImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
        setupNavigationBar()
        
        addImageBtn.delegate = self
    }
    
    private func setupNavigationBar() {
        self.title = "Add Movie"
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func addMovieBtnClicked(_ sender: Any) {
        presenter?.addMovie(title: titleTF.text,
                            overview: overViewTV.text == "Overview" ? "" : overViewTV.text,
                            rate: Double(rateTF.text!) ?? 0.0,
                            productionYear: productionYearTF.text,
                            image: movieImage)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
