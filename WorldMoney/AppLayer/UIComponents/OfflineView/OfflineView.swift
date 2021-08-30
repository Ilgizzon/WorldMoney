//
//  OfflineView.swift
//  WorldMoney
//
//  Created by Ilgiz Fazlyev on 30.08.2021.
//

import UIKit
import Foundation
class OfflineView: UIView {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXIB()
    }
    
    private func loadXIB() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
        let bundle = Bundle.init(for: OfflineView.self)
        if let viewsToAdd = bundle.loadNibNamed(
            String(describing: OfflineView.self),
            owner: self,
            options: nil),
           let contentView = viewsToAdd.first as? UIView {
            
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            overrideUserInterfaceStyle = .light
            configUI()
        }
        
    }


    private func configUI() {
        self.alpha = 0
        self.isUserInteractionEnabled = false
        labelView.layer.cornerRadius = 8
        labelView.clipsToBounds = true
        labelView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
    
    func showErrorView(date: Date?) {
        guard self.alpha == 0 else {
            return
        }
        configUI()
        timeLabel.text = convertTimeToString(date: date)
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.5
        }
        
    }
    
    func hideErrorView() {
        guard self.alpha == 0.5 else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
        
    }
    
    private func convertTimeToString(date: Date?) -> String? {
        guard let date = date  else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        
        return dateFormatter.string(from: date)
    }
}
