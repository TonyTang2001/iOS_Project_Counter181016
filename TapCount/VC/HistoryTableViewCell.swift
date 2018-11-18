//
//  HistoryTableViewCell.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/10/14.
//  Copyright © 2018 TonyTang. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var CountNumLb: CountNumLb!
    @IBOutlet weak var TimeLb: TimeLb!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//MARK: - HistoryCellLabels
class HistoryCellLb: UILabel, ThemeManagerProtocol {
    //init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.changeTheme()
    }
    
    func changeTheme() {
        NotificationCenter.default.addObserver(self, selector: #selector(handelNotification(notification:)),
                                               name: ThemeNotifacationName,
                                               object: nil)
        ThemeManager.themeUpdate()
    }
    
    @objc func handelNotification(notification: NSNotification) {
        guard let theme = notification.object as? ThemeProtocol else { return }
        self.textColor = self.themeTextColor(theme: theme)
    }
    
    func themeTextColor(theme:ThemeProtocol) -> UIColor {
        return theme.mainColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class TimeLb: HistoryCellLb {
    
    override func themeTextColor(theme: ThemeProtocol) -> UIColor {
        return theme.subLabelColor
    }
}

class CountNumLb: HistoryCellLb {

    override func themeTextColor(theme: ThemeProtocol) -> UIColor {
        return theme.mainColor
    }
}
