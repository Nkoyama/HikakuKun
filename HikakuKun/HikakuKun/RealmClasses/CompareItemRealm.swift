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
	@objc dynamic var groupId	: String	= ""	// 比較グループID
	@objc dynamic var groupName	: String	= ""	// 比較グループ名
	@objc dynamic var item1		: String	= ""	// 比較項目①
	@objc dynamic var item2		: String	= ""	// 比較項目②
	@objc dynamic var item3		: String	= ""	// 比較項目③
	@objc dynamic var item4		: String	= ""	// 比較項目④
	@objc dynamic var item5		: String	= ""	// 比較項目⑤
	@objc dynamic var item6		: String	= ""	// 比較項目⑥
	@objc dynamic var item7		: String	= ""	// 比較項目⑦
	@objc dynamic var timestamp	: String	= ""

	/// get max groupId
	/// - Returns: max groupId(Int)
	/// - Authors: Nozomi Koyama
	func getMaxGroupId() -> String {
		let realm = try! Realm()
		let groupCount = realm.objects(CompareItemRealm.self).count
		var maxGroupId: String = ""
		if( groupCount > 0 ) {
			let max = realm.objects(CompareItemRealm.self).sorted(byKeyPath: "groupId",
																  ascending: false).first?.groupId
			maxGroupId = max!
		}
		return maxGroupId
	}

	/// get items
	/// - Parameter groupId: groupId(Int)
	/// - Returns: contents list (Results<CompareItemRealm>)
	/// - Authors: Nozomi Koyama
	func getItems(groupId: String) throws -> Results<CompareItemRealm> {
		var items: Results<CompareItemRealm>
		do{
			let realm = try Realm()
			items = realm.objects(CompareItemRealm.self).filter("groupId = %@", groupId)
		} catch {
			throw NSError(domain: "error", code: -1, userInfo: nil)
		}
		return items
	}
}
