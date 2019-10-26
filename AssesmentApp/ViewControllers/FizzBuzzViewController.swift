//
//  SecondViewController.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/24/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import UIKit

class FizzBuzzViewController: UIViewController {

    @IBOutlet weak var fizzBuzzTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fizzBuzzTableView.registerCell(a: FizzBuzzCell())
        fizzBuzzTableView.separatorStyle = .none
    }
    
    func getValueFor(number: Int) -> String {
        switch true {
        case (number % 3) == 0 && (number % 5) == 0:
            return AppConstants.FIZZ_BUZZ_WORD
        case (number % 3 == 0):
            return AppConstants.FIZZ_WORD
        case (number % 5 == 0):
            return AppConstants.BUZZ_WORD
        default:
            return "\(number)"
        }
    }


}

extension FizzBuzzViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FizzBuzzCell.self), for: indexPath) as? FizzBuzzCell {
            cell.selectionStyle = .none
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.white.cgColor
            cell.numberLabel.text = getValueFor(number: indexPath.row + 1)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

