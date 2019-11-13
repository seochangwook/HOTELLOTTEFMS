//
//  MainWebViewController.swift
//  LOTTEHOTELFMS
//
//  Created by ldcc on 2019/10/28.
//  Copyright © 2019 ldcc. All rights reserved.
//

import UIKit
import WebKit

class MainWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        ///JavaScript Call Setting
        initWKWebViewJS()
        
        ///WKWebView Setting (View and Delegating)
        loadWKWebViewSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back_button(_ sender: UIBarButtonItem) {
        let convert_StringUrl : String = webView.url!.path
        
        if(webView.canGoBack){
            if(convert_StringUrl.contains("/fms/fms_main")){
                //FMS Main Page Back button click
                let appExitAlert = UIAlertController(title: "HOTEL FMS", message: "앱을 종료하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                
                appExitAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    
                    ///App exit is go home screen
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }))
                
                appExitAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                self.present(appExitAlert, animated: true, completion: nil)
            } else{
                webView.goBack()
            }
        } else{
            ///Login Page Back button click
            let appExitAlert = UIAlertController(title: "HOTEL FMS", message: "앱을 종료하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            
            appExitAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }))
            
            appExitAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            self.present(appExitAlert, animated: true, completion: nil)
        }
    }
    
    func loadWKWebViewSetting(){
        ///WKWebview 셋팅 (초기셋팅 UserDefaults 이용)
        let defaults = UserDefaults.standard
        
        var ip : String = ""
        var port : String = ""

        if let getIp = defaults.string(forKey: "ip") {
            ip = getIp
        }
        
        if let getPort = defaults.string(forKey: "port") {
            port = getPort
        }
        
        let url = URL(string: "http://" + ip + ":" + port)
        let request = URLRequest(url: url!)
            
        webView.load(request)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        view.addSubview(webView)
    }
    
    func initWKWebViewJS(){
        ///JavaScript Call Setting
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        ///연동 Point JavaScript 함수 추가
        contentController.add(self, name : "setting")
        
        config.userContentController = contentController
        
        webView = WKWebView(frame:self.webView.frame, configuration:config)
    }
    
    /// WKScriptMessageHandler Callback (Javascript -> Native Call (Param))
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "setting"){
            print("call setting")
            print(message.body)
        }
    }
    
    ///WKUIDelegate 3가지 필수 Callback 함수
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "HOTEL FMS", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: {(action) in
            completionHandler()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "HOTEL FMS", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "HOTEL FMS", message: prompt, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }))

        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in
            completionHandler(nil)
        }))

        self.present(alertController, animated: true, completion: nil)
    }
    
    ///WKNavigationDelegate 중복적으로 리로드 방지 (iOS 9 이후지원)
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}
