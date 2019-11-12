//
//  ViewController.swift
//  LOTTEHOTELFMS
//
//  Created by ldcc on 2019/10/22.
//  Copyright © 2019 ldcc. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        ///Check Network Connection
        checkNetworkConnect()
        
        ///UserDefaults value get check
        var settingviewcode : Int = 1
        
        let defaults = UserDefaults.standard

        if let getIp = defaults.string(forKey: "ip") {
        } else{
            settingviewcode = 2
        }
        
        if let getPort = defaults.string(forKey: "port") {
        } else{
            settingviewcode = 2
        }
               
        if(settingviewcode == 1){
            performSegue(withIdentifier: "loading_mainwebview", sender: self)
        } else if(settingviewcode == 2){
            performSegue(withIdentifier: "loading_setting", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     ///Move (iOS 13 Response - Modality changes (FullScreen))
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var segue_id : String = segue.identifier!
    
        if(segue_id == "loading_mainwebview"){
            let destination = segue.destination as! MainWebViewController
            
            destination.modalPresentationStyle = .fullScreen
        } else if(segue_id == "loading_setting"){
            let destination = segue.destination as! SettingViewController
            
            destination.modalPresentationStyle = .fullScreen
        }
    }
    
    func checkNetworkConnect(){
        if NetworkUtil.isConnectedToNetwork(){
            ///TODO : Network Connect Success Process
            
        } else{
             ///TODO : Network Not Connect Success Process
            let networkCheckAlert = UIAlertController(title: "HOTEL FMS", message: "앱을 종료합니다.(네트워크를 연결해주세요)", preferredStyle: UIAlertController.Style.alert)
            
            networkCheckAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }))
            
            self.present(networkCheckAlert, animated: true, completion: nil)
        }
    }
}

