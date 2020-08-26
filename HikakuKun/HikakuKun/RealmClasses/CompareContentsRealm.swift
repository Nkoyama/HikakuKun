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
	@objc dynamic var groupId	: Int		= 0		// 比較グループID
	@objc dynamic var id		: Int		= 0		// 比較グループ内ID
	@objc dynamic var name		: String	= ""	// 比較対象名前
	@objc dynamic var content1	: String	= ""	// 比較項目①内容
	@objc dynamic var content2	: String	= ""	// 比較項目②内容
	@objc dynamic var content3	: String	= ""	// 比較項目③内容
	@objc dynamic var content4	: String	= ""	// 比較項目④内容
	@objc dynamic var content5	: String	= ""	// 比較項目⑤内容
	@objc dynamic var content6	: String	= ""	// 比較項目⑥内容
	@objc dynamic var content7	: String	= ""	// 比較項目⑦内容
	@objc dynamic var content8	: String	= ""	// no use
	@objc dynamic var content9	: String	= ""	// no use
	@objc dynamic var content10	: String	= ""	// no use
	@objc dynamic var memo		: String	= ""
	@objc dynamic var timestamp	: String	= ""

	/// get max id
	/// - Returns: max id(Int)
	/// - Authors: Nozomi Koyama
	func getMaxId() -> String {
		let realm = try! Realm(configuration: config)
		let idCount = realm.objects(CompareContentsRealm.self).count
		var maxId: String = "-1"
		if( idCount > 0 ) {
			let max = realm.objects(CompareContentsRealm.self).sorted(byKeyPath: "id",
																	  ascending: false).first?.id
			maxId = String(max!)
		}
		return maxId
	}

	/// get contents list
	/// - Parameter groupId: groupId(Int)
	/// - Returns: contents list (Results<CompareContentsRealm>)
	/// - Authors: Nozomi Koyama
	func getContentsList(groupId: String) throws -> Results<CompareContentsRealm> {
		var contentsList: Results<CompareContentsRealm>
		do {
			let realm = try Realm(configuration: config)
			contentsList = realm.objects(CompareContentsRealm.self).filter("groupId = %@", groupId)
		} catch {
			throw NSError(domain: "error", code: -1, userInfo: nil)
		}
		return contentsList
	}
}
