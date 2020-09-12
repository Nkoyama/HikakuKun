//
//  PublicConstantValues.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/07/26.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import UIKit
import RealmSwift

public let realmFileNmae = "develop.realm"		//develop
//public let realmFileNmae = "Hikakukun.realm"	//deploy

public let keyWindow = UIApplication.shared.connectedScenes
	.filter({$0.activationState == .foregroundActive})
	.map({$0 as? UIWindowScene})
	.compactMap({$0})
	.first?.windows
	.filter({$0.isKeyWindow}).first

public let adUnitId = "ca-app-pub-3940256099942544/4411468910"	//develop
//public let adUnitId = "ca-app-pub-7688401383404240/1582914564"	//deploy
