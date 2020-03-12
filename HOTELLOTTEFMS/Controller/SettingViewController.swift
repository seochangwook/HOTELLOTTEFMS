//
//  SettingViewController.swift
//  LOTTEHOTELFMS
//
//  Created by ldcc on 2019/10/28.
//  Copyright © 2019 ldcc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var serveriplabel: UILabel!
    @IBOutlet weak var serverportlabel: UILabel!
    @IBOutlet weak var settingnavbar: UINavigationBar!
    @IBOutlet weak var savebuttonoutlet: UIButton!
    
    
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
    
    @IBAction func savebutton(_ sender: UIButton) {
        ///Call shouldPerformSegue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serveriplabel.text = "ServerIP".localized()
        serverportlabel.text = "ServerPORT".localized()
        settingnavbar.topItem?.title = "Setting".localized()
        savebuttonoutlet.setTitle("Savebuttontitle".localized(), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        ///FIrst Active Condition
        if isBeingPresented || isMovingToParent {
            performSegue(withIdentifier: "setting_privacymodal", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     ///Conditional Segue
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "setting_mainwebview" {
                ///1. IP, Port Validation Check
                let ip_textfield_text : String = ip_textfield.text!
                let port_textfiled_text : String = port_textfield.text!
                
                let defaults = UserDefaults.standard
                
                defaults.set(ip_textfield_text, forKey: "ip")
                defaults.set(port_textfiled_text, forKey: "port")
                
                performSegue(withIdentifier: "setting_mainwebview", sender: self)
                
                /*if(ip_textfield_text.isEmpty || port_textfiled_text.isEmpty || NetworkUtil.isIPv4(ip_textfield_text) == false){
                    let inputCheckAlert = UIAlertController(title: "AppTitle".localized(), message: "ipportvalidationmessage".localized(), preferredStyle: UIAlertController.Style.alert)
                    
                    inputCheckAlert.addAction(UIAlertAction(title: "okmodalbutton".localized(), style: .default, handler: { (action: UIAlertAction!) in
                    }))
                    
                    self.present(inputCheckAlert, animated: true, completion: nil)
                    
                    return false
                } else{
                    ///2. IP, PORT UserDefaults 저장
                    let defaults = UserDefaults.standard
                    
                    defaults.set(ip_textfield_text, forKey: "ip")
                    defaults.set(port_textfiled_text, forKey: "port")
                    
                    performSegue(withIdentifier: "setting_mainwebview", sender: self)
                }*/
            }
        }
        
        return true
    }
    
    ///Move (iOS 13 Response - Modality changes (FullScreen))
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var segue_id : String = segue.identifier!
    
        if(segue_id == "setting_mainwebview"){
            let destination = segue.destination as! MainWebViewController
            
            destination.modalPresentationStyle = .fullScreen
        } else if(segue_id == "setting_privacymodal"){
            let destination = segue.destination as! PrivacyInfoModalViewController
            
            if #available(iOS 13.0, *) {
                destination.isModalInPresentation = true
            } else {
                // Fallback on earlier versions
            }
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
}
