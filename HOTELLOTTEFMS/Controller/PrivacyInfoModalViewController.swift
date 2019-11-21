//
//  PrivacyInfoModalController.swift
//  HOTELLOTTEFMS
//
//  Created by seo on 2019/11/21.
//  Copyright © 2019 ldcc. All rights reserved.
//

import UIKit

class PrivacyInfoModalViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func agree_button(_ sender: UIButton) {
        dismiss(animated:true)
    }
}
