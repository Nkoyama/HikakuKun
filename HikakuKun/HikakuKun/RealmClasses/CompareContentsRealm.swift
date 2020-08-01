//
//  CompareRealm.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/07/26.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import Foundation
import RealmSwift

class CompareContentsRealm: Object {
	dynamic var groupId		: Int		= 0		// 比較グループID
	dynamic var id			: Int		= 0		// 比較グループ内ID
	dynamic var name		: String	= ""	// 比較対象名前
	dynamic var content1	: String	= ""	// 比較項目①内容
	dynamic var content2	: String	= ""	// 比較項目②内容
	dynamic var content3	: String	= ""	// 比較項目③内容
	dynamic var content4	: String	= ""	// 比較項目④内容
	dynamic var content5	: String	= ""	// 比較項目⑤内容
	dynamic var content6	: String	= ""	// 比較項目⑥内容
	dynamic var content7	: String	= ""	// 比較項目⑦内容
	dynamic var content8	: String	= ""	// 比較項目⑧内容
	dynamic var content9	: String	= ""	// 比較項目⑨内容
	dynamic var content10	: String	= ""	// 比較項目⑩内容
	dynamic var memo		: String	= ""
	dynamic var timestamp	: String	= ""

	/// get max id
	/// - Returns: max id(Int)
	/// - Authors: Nozomi Koyama
	func getMaxId() -> Int {
		let realm = try! Realm()
		let idCount = realm.objects(CompareContentsRealm.self).count
		var maxId: Int = -1
		if( idCount > 0 ) {
			let max = realm.objects(CompareContentsRealm.self).sorted(byKeyPath: "id",
																	  ascending: false).first?.id
			maxId = Int(max!)
		}
		return maxId
	}
}
