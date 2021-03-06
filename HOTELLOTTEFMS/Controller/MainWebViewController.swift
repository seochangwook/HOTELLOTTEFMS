//
//  MainWebViewController.swift
//  LOTTEHOTELFMS
//
//  Created by ldcc on 2019/10/28.
//  Copyright © 2019 ldcc. All rights reserved.
//
import UIKit
import WebKit

class MainWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, QRReadingDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    ///window.open() is new WKWebView
    var createWebView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        ///FIrst Active Condition
        if isBeingPresented || isMovingToParent {
            ///JavaScript Call Setting
            initWKWebViewJS()
            
            ///WKWebView Setting (View and Delegating)
            loadWKWebViewSetting()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back_button(_ sender: UIBarButtonItem) {
        let convert_StringUrl : String = webView.url?.path ?? "nil"
        
        if(convert_StringUrl == "nil"){
            ///TODO : WKWebView Not Connect Success Process
            let wkWebViewCheckAlert = UIAlertController(title: "AppTitle".localized(), message: "ipcheckalert".localized(), preferredStyle: UIAlertController.Style.alert)
                       
            wkWebViewCheckAlert.addAction(UIAlertAction(title: "okmodalbutton".localized(), style: .default, handler: { (action: UIAlertAction!) in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }))
                       
            self.present(wkWebViewCheckAlert, animated: true, completion: nil)
        }
        
        if(webView.canGoBack){
            if(convert_StringUrl.contains("/fms/fms_main")){
                //FMS Main Page Back button click
                let appExitAlert = UIAlertController(title: "AppTitle".localized(), message: "appexit".localized(), preferredStyle: UIAlertController.Style.alert)
                
                appExitAlert.addAction(UIAlertAction(title: "okmodalbutton".localized(), style: .default, handler: { (action: UIAlertAction!) in
                    
                    ///App exit is go home screen
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }))
                
                appExitAlert.addAction(UIAlertAction(title: "cancelmodalbutton".localized(), style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                self.present(appExitAlert, animated: true, completion: nil)
            } else{
                webView.goBack()
            }
        } else{
            ///Login Page Back button click
            let appExitAlert = UIAlertController(title: "AppTitle".localized(), message: "appexit".localized(), preferredStyle: UIAlertController.Style.alert)
            
            appExitAlert.addAction(UIAlertAction(title: "okmodalbutton".localized(), style: .default, handler: { (action: UIAlertAction!) in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            }))
            
            appExitAlert.addAction(UIAlertAction(title: "cancelmodalbutton".localized(), style: .default, handler: { (action: UIAlertAction!) in
                
            }))
            
            self.present(appExitAlert, animated: true, completion: nil)
        }
    }
    
    func initWKWebViewJS(){
        ///JavaScript Call Setting
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        
        ///연동 Point JavaScript 함수 추가
        contentController.add(self, name : "setting")
        contentController.add(self, name : "goPatrolBarCode")
        
        config.userContentController = contentController
        
        ///AutoLayout 적용 시 viewDidAppear 단계에서 초기화
        webView = WKWebView(frame:self.webView.frame, configuration:config)
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
        
        let url = URL(string: "https://" + ip)
        let request = URLRequest(url: url!)
        
        ///Delegating Setting
        webView.uiDelegate = self
        webView.navigationDelegate = self

        ///View Setting
        view.addSubview(webView)
        
        ///WebSite Load
        webView.load(request)
    }
    
    ///Move (iOS 13 Response - Modality changes (FullScreen))
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var segue_id : String = segue.identifier!
    
        if(segue_id == "mainwebview_setting"){
            let destination = segue.destination as! SettingViewController
            
            destination.modalPresentationStyle = .fullScreen
        } else if(segue_id == "mainwebview_qrreadingview"){
            let destination = segue.destination as! QRReadingViewController
            
            destination.qrReadingDelegate = self
            
            destination.modalPresentationStyle = .fullScreen
        }
    }
    
    /// WKScriptMessageHandler Callback (Javascript -> Native Call (Param))
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "setting"){
            performSegue(withIdentifier: "mainwebview_setting", sender: self)
        } else if(message.name == "goPatrolBarCode"){
            performSegue(withIdentifier: "mainwebview_qrreadingview", sender: self)
        }
    }
    
    ///WKUIDelegate 3가지 필수 Callback 함수
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "AppTitle".localized(), message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "okmodalbutton".localized(), style: .default, handler: {(action) in
            completionHandler()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "AppTitle".localized(), message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "okmodalbutton".localized(), style: .default, handler: { (action) in
            completionHandler(true)
        }))
        
        alertController.addAction(UIAlertAction(title: "cancelmodalbutton".localized(), style: .default, handler: { (action) in
            completionHandler(false)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "AppTitle".localized(), message: prompt, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        
        alertController.addAction(UIAlertAction(title: "okmodalbutton".localized(), style: .default, handler: { (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }))

        alertController.addAction(UIAlertAction(title: "cancelmodalbutton".localized(), style: .default, handler: { (action) in
            completionHandler(nil)
        }))

        self.present(alertController, animated: true, completion: nil)
    }
    
    ///WKNavigationDelegate 중복적으로 리로드 방지 (iOS 9 이후지원)
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
    
    ///Popup Callback  (JS window.open() 처리)
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        let frame = UIScreen.main.bounds
        
        createWebView = WKWebView(frame: frame, configuration: configuration)
        
        createWebView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        createWebView!.navigationDelegate = self
        createWebView!.uiDelegate = self
        
        self.webView.load(navigationAction.request)
        
        return nil
    }
    
    ///iOS9.0 이상
    func webViewDidClose(_ webView: WKWebView) {
        if webView == createWebView {
            createWebView?.removeFromSuperview()
            createWebView = nil
        }
    }
    
    ///QRReadingDelegate Callback
    func qrReadingReturnValue(data: String) {
        ///Javascript Function Setting (Param)
        let sendToCodefunc = "sendToCode('\(data)')"
        
        webView.evaluateJavaScript(sendToCodefunc, completionHandler: {(result, error) in
            if let result = result {

            }
        })
    }
}
