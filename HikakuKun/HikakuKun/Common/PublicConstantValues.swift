//
//  PublicConstantValues.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/07/26.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import UIKit

public let keyWindow = UIApplication.shared.connectedScenes
	.filter({$0.activationState == .foregroundActive})
	.map({$0 as? UIWindowScene})
	.compactMap({$0})
	.first?.windows
	.filter({$0.isKeyWindow}).first
