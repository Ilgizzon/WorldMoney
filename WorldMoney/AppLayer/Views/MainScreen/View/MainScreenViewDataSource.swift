//
//  MainScreenViewDataSource.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 28.08.2021.
//

import UIKit

extension MainScreenView: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return money?.stock.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MainScreenCell",
            for: indexPath
        ) as! MainScreenCell
        let stock = money?.stock[indexPath.row]
        
        cell.setData(name: stock?.name)
        return cell
        
    }
        
}
