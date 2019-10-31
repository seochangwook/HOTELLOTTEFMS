//
//  SettingViewController.swift
//  LOTTEHOTELFMS
//
//  Created by ldcc on 2019/10/28.
//  Copyright © 2019 ldcc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var ip_textfield: UITextField! {
        didSet{
            ip_textfield.delegate = self
        }
    }
    
    @IBOutlet weak var port_textfield: UITextField! {
        didSet{
            port_textfield.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .fullScreen
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     ///Move (iOS 13 Response - Modality changes (FullScreen))
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var segue_id : String = segue.identifier!
    
        if(segue_id == "setting_mainwebview"){
            let destination = segue.destination as! MainWebViewController
            
            destination.modalPresentationStyle = .fullScreen
        }
    }
    
    ///Textfield Delegate Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    ///Textfield Registration
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ip_textfield.resignFirstResponder()
        port_textfield.resignFirstResponder()
        
        return true
    }
    
    @IBAction func savebutton(_ sender: UIButton) {
        print("Check Info and Save Info")
        ///1. IP, Port Validation Check
        
        
        ///2. UserDefaults 저장
        
    }
}
