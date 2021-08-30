//
//  MainScreenCell.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import UIKit

protocol MainScreenCellDelegate: AnyObject {
    func onTapCell(_ symbol: String?)
}

class MainScreenCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    private weak var delegate: MainScreenCellDelegate?
    private var symbol: String?
    
    func setData(
        name: String?,
        symbol: String?,
        delegate: MainScreenCellDelegate?
    ){
        self.delegate = delegate
        self.symbol = symbol
        nameLabel.text = name
    }
    
    @IBAction func tapAction(_ sender: Any) {
        delegate?.onTapCell(symbol)
    }
}
