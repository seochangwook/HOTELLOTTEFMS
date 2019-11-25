//
//  PrivacyInfoModalController.swift
//  HOTELLOTTEFMS
//
//  Created by seo on 2019/11/21.
//  Copyright © 2019 ldcc. All rights reserved.
//

import UIKit

class PrivacyInfoModalViewController: UIViewController{
    @IBOutlet weak var privacymaintitle: UILabel!
    @IBOutlet weak var privacysubtitle: UILabel!
    @IBOutlet weak var agreebuttonoutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        privacymaintitle.text = "privacymaintitle".localized()
        privacysubtitle.text="privacysubtitle".localized()
        agreebuttonoutlet.setTitle("agreebuttontitle".localized(), for: .normal)
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
