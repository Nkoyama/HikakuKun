//
//  HowToUseVC.swift
//  HikakuKun
//
//  Created by Nozomi Koyama on 2020/09/05.
//  Copyright © 2020 Nozomi Koyama. All rights reserved.
//

import UIKit
import SnapKit

class HowToUseVC: UIViewController {
	
	let closeBtn		= UIButton()
	let titleL			= UILabel()

	override func viewDidLoad() {
		// background color
		self.view.backgroundColor = UIColor.white

		// close button
		self.closeBtn.setTitle("× close", for: .normal)
		self.closeBtn.setTitleColor(UIColor.blue, for: .normal)
		self.closeBtn.backgroundColor = UIColor.clear
		self.closeBtn.layer.borderColor = UIColor.clear.cgColor
		self.view.addSubview(self.closeBtn)
		self.closeBtn.addTarget(self,
								action: #selector(self.closeBtnDidTap(_:)),
								for: .touchUpInside)
		self.closeBtn.snp.makeConstraints { (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
			make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).inset(10)
		}

		// title
		self.titleL.text = "使い方"
		self.titleL.textColor = .black
		self.titleL.font = UIFont.systemFont(ofSize: 30)
		self.view.addSubview(self.titleL)
		self.titleL.snp.makeConstraints{ (make) in
			make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
			make.centerX.equalToSuperview()
		}
	}
	
	/// close button action
	/// - Parameter sender: UIButton
	@objc func closeBtnDidTap(_ sender: UIButton) {
		self.dismiss(animated: true)
	}
}
