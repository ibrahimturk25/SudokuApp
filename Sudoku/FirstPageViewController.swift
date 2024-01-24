//
//  FirstPageViewController.swift
//  Sudoku
//
//  Created by İbrahim Türk on 1.01.2024.
//

import UIKit

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func buttonResumeClicked(_ sender: Any) {
        performSegue(withIdentifier: "toGameVC", sender: nil)
    }
    
  
    @IBAction func buttonNewGameClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
}
