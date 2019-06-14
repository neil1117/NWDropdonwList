//
//  NWDropdonwList.swift
//  DropdownList
//
//  Created by Neil Wu on 2019/6/10.
//  Copyright © 2019 Neil Wu. All rights reserved.
//

import UIKit

class DropdownList: UIView {
     
     static let dropdownCell: String = "dropdownCell"
     var delegate: DropdownDelegate?
     var dropDownArray = [String]()
     let dropdownTableView = UITableView.init(frame: CGRect.zero, style: .plain)
     
     init() {
          super.init(frame: CGRect.zero)
          self.backgroundColor = .clear
          let touch = UITapGestureRecognizer.init()
          touch.addTarget(self, action: #selector(self.touch))
          self.addGestureRecognizer(touch)
          dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: DropdownList.dropdownCell)
          dropdownTableView.delegate = self
          dropdownTableView.dataSource = self
     }
     
     @objc func touch() {
          debugPrint("touch")
          self.remove()
     }
     
     func updateDropdownListContent(list: Array<String>) {
          dropDownArray = list
     }
     
     func show(withObject object: AnyObject) {
          guard let objectRect = object.frame, let window = UIApplication.shared.keyWindow , let objectParent = object.superview! else { return }
          self.frame = window.bounds
          window.addSubview(self)
          let tableViewHeight:CGFloat = dropDownArray.count > 3 ? 3 * 30 : CGFloat(dropDownArray.count * 30)
          let rect = CGRect.init(x: objectRect.origin.x, y: objectRect.origin.y + objectRect.height, width: objectRect.width, height: tableViewHeight)
          dropdownTableView.frame = objectParent.convert(rect, to: self)
          window.addSubview(dropdownTableView)
     }
     
     func remove() {
          self.frame = CGRect.zero
          self.removeFromSuperview()
          dropdownTableView.frame = CGRect.zero
          dropdownTableView.removeFromSuperview()
     }
     
     required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
}

extension DropdownList: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          debugPrint(dropDownArray[indexPath.row])
          remove()
          delegate?.dropdownList(self, selectIndex: indexPath.row)
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 30
     }
}

extension DropdownList: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return dropDownArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = UITableViewCell.init(style: .default, reuseIdentifier: DropdownList.dropdownCell)
          cell.textLabel?.text = dropDownArray[indexPath.row]
          cell.selectionStyle = .none
          return cell
     }
     
     
}

protocol DropdownDelegate {
     func dropdownList(_ dropdonwList: DropdownList, selectIndex: Int)
}
