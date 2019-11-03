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
        var ip_textfield_text : String = ip_textfield.text!
        var port_textfiled_text : String = port_textfield.text!
        
        if(ip_textfield_text.isEmpty || port_textfiled_text.isEmpty || isIPv4(ip_textfield_text) == false){
            print("not valid")
        } else{
            ///2. UserDefaults 저장
            
        }
    }
    
    func isIPv4(_ IP: String) -> Bool {
        let items = IP.components(separatedBy: ".")
        
        if(items.count != 4) {
            return false
        }
        
        for item in items {
            var tmp = 0
            
            if(item.count > 3 || item.count < 1){
                return false
            }
            
            for char in item{
                if(char < "0" || char > "9"){
                    return false
                }
                
                tmp = tmp * 10 + Int(String(char))!
            }
            
            if(tmp < 0 || tmp > 255){
                return false
            }
            
            if((tmp > 0 && item.first == "0") || (tmp == 0 && item.count > 1)){
                return false
            }
        }
        
        return true
    }
}
