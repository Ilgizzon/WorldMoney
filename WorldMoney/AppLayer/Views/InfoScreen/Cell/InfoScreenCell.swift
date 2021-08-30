//
//  InfoScreenCell.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import UIKit

class InfoScreenCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func setData(
        name: String?,
        amount: String?
    ){
        amountLabel.text = amount
        nameLabel.text = name
    }

}
