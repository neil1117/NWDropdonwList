//
//  ViewController.swift
//  DropdownList
//
//  Created by Neil Wu on 2019/6/10.
//  Copyright © 2019 Neil Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dropDownList: DropdownList = DropdownList.init()
    var aView: UIView = UIView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        aView = UIView.init(frame: CGRect.init(x:20, y: 50, width: self.view.bounds.size.width-40, height: 150))
        aView.backgroundColor = .red
        self.view.addSubview(aView)
        let touch = UITapGestureRecognizer.init(target: self, action: #selector(self.touche))
        touch.numberOfTapsRequired = 1
        aView.addGestureRecognizer(touch)
        dropDownList.delegate = self
        dropDownList.updateDropdownListContent(list: ["1", "2", "3"])
        
    }
    
    @objc func touche() {
        dropDownList.show(withObject: aView)
    }

}

extension ViewController: DropdownDelegate {
    func dropdownList(_ dropdonwList: DropdownList, selectIndex: Int) {
        debugPrint(selectIndex)
    }
}



