//
//  InfoScreenDataSource.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 29.08.2021.
//

import UIKit

extension InfoScreenView: UITableViewDataSource {
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
            withIdentifier: "InfoScreenCell",
            for: indexPath
        ) as! InfoScreenCell
        let stock = money?.stock[indexPath.row]
        
        cell.setData(
            name: stock?.name,
            amount:"\(stock?.price.amount ?? 0)"
        )
        return cell
        
    }
        
}
