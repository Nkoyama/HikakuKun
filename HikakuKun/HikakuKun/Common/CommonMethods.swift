//
//  CommonMethods.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/08/02.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import Foundation
import UIKit

/// 小数点以下第3位を切り捨て
/// - Parameter num: 切り捨て対象
/// - Returns: 切り捨て後（少数第2位まで）
public func floor_2(num: CGFloat) -> CGFloat {
	return floor(num * 100) / 100
}
