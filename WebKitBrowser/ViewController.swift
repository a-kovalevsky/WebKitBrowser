//
//  ViewController.swift
//  WebKitBrowser
//
//  Created by andrew on 5.05.22.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webkit: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var textfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield.delegate = self //назначаем делегатом
        webkit.navigationDelegate = self //назначаем делегатом
        
        let homePage = "https://www.apple.com"
        
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        textfield.text = homePage
        
        webkit.load(request)
        webkit.allowsBackForwardNavigationGestures = true
    }
    
    @IBAction func forwardButtonAction(_ sender: UIButton){
        if webkit.canGoForward{
            webkit.goForward()
        }
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webkit.canGoBack{
            webkit.goBack()
        }
    }
}
extension ViewController:UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webkit.load(request)
        
        textField.resignFirstResponder()//скрытие клавиатуры при нажатии ретерн
        
        return true
    }//метод для возврата данных из текст филд новых
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {//как я понял перед загрузкой страницы
        textfield.text = webView.url?.absoluteString //адрес страницы нынещний  в текст филд
        backButton.isEnabled = webView.canGoBack //кнопка станет активной перед загрузкой новой страницы,когда будет возможность вернуться на предыдущую страницу
        forwardButton.isEnabled = webView.canGoForward //тоже самое,тока вперед
        
    }
}

