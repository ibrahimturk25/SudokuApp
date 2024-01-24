//
//  HomeViewController.swift
//  Sudoku
//
//  Created by İbrahim Türk on 1.01.2024.
//

import UIKit

class HomeViewController: UIViewController {
    var difficulty = 0
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameVC"{
            let destinationVC = segue.destination as! GameViewController
            destinationVC.difficulty = self.difficulty
                
            
        }
    }
    @IBAction func buttonEasyClicked(_ sender: UIButton) {
        difficulty = 30
        performSegue(withIdentifier: "toGameVC", sender: nil)
    }
    
    @IBAction func buttonNormalClicked(_ sender: Any) {
        difficulty = 40
        performSegue(withIdentifier: "toGameVC", sender: nil)
    }
    
    @IBAction func buttonHardClicked(_ sender: Any) {
        difficulty = 50
        performSegue(withIdentifier: "toGameVC", sender: nil)
    }
}
