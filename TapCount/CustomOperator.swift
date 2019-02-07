//
//  CustomOperator.swift
//  TapCount
//
//  Created by 唐子轩 on 2018/11/28.
//  Copyright © 2018 TonyTang. All rights reserved.
//

func == (lhs: ThemeProtocol, rhs: ThemeProtocol) -> Bool {
    var returnValue = false
    if (lhs.mainColor == rhs.mainColor) && (lhs.backgroundColor == rhs.backgroundColor) && (lhs.countDisplayColor == rhs.countDisplayColor) && (lhs.subLabelColor == rhs.subLabelColor) && (lhs.cellSelectionColor == rhs.cellSelectionColor) && (lhs.statusBarStyle == rhs.statusBarStyle)
    {
        returnValue = true
    }
    return returnValue
}


//var mainColor: UIColor { get }
//var backgroundColor: UIColor { get }
//var countDisplayColor: UIColor { get }
//var subLabelColor: UIColor { get }
//var cellSelectionColor: UIColor { get }
//var statusBarStyle: String { get }
