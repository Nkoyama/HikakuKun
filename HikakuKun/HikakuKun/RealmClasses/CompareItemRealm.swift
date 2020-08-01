//
//  CompareItemRealm.swift
//  hikakuKun
//
//  Created by Nozomi Koyama on 2020/07/26.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import Foundation
import RealmSwift

class CompareItemRealm: Object {
	dynamic var groupId		: Int		= 0		// 比較グループID
	dynamic var groupName	: String	= ""	// 比較グループ名
	dynamic var item1		: String	= ""	// 比較項目①
	dynamic var item2		: String	= ""	// 比較項目②
	dynamic var item3		: String	= ""	// 比較項目③
	dynamic var item4		: String	= ""	// 比較項目④
	dynamic var item5		: String	= ""	// 比較項目⑤
	dynamic var item6		: String	= ""	// 比較項目⑥
	dynamic var item7		: String	= ""	// 比較項目⑦
	dynamic var item8		: String	= ""	// 比較項目⑧
	dynamic var item9		: String	= ""	// 比較項目⑨
	dynamic var item10		: String	= ""	// 比較項目⑩
	dynamic var timestamp	: String	= ""
}
