//
//  ViewController.swift
//  webViewSample
//
//  Created by 川崎浩司 on 2015/05/15.
//  Copyright (c) 2015年 Koji Kawasaki. All rights reserved.
//

import UIKit

// twitterなどのSocialへ投稿する際に必要な機能を外部から読み込むための初期化
import Social

class ViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    //表示したいURLを設定(初期化)
    var targetURL = "http://rakutenqute.herokuapp.com/"
    
    // twitter投稿画面を生成するための初期化
    var myComposeView : SLComposeViewController!
    // twitter用のボタンを生成するための初期化
    var myTwitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // webViewを表示するためのメソッド呼び出し
        loadAddressURL()
        
        // twitterに似た色合いをコードで生成するための設定。色味のみの設定
        let hex: Int = 0x55ACEE
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var myColor: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1.0))
        
        // twitter用のボタンを設定。ボタンを押された後にtwitter投稿用のメソッド呼び出しまで設定
        myTwitterButton = UIButton()
        myTwitterButton.frame = CGRectMake(0,0,100,100)
        myTwitterButton.backgroundColor = myColor
        myTwitterButton.layer.masksToBounds = true
        myTwitterButton.setTitle("Twitter", forState: UIControlState.Normal)
        myTwitterButton.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(30))
        myTwitterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myTwitterButton.layer.cornerRadius = 50.0
        myTwitterButton.layer.position = CGPoint(x: self.view.frame.width - 55, y:self.view.frame.height - 115)
        myTwitterButton.tag = 1
        myTwitterButton.addTarget(self, action: "onPostToTwitter:", forControlEvents: .TouchUpInside)
        
        // twitter用のボタンを画面に表示させるための設定
        self.view.addSubview(myTwitterButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAddressURL(){
        
        // 初期化済みのURLを読み込む
        let requestURL = NSURL(string: targetURL)
        
        // 読み込んだURLの実行結果を取得する
        let req = NSURLRequest(URL:requestURL!)
        
        // webvieにデータをロードする
        webView.loadRequest(req)
        webView.scalesPageToFit = true
        
    }
    
    func onPostToTwitter(sender : AnyObject) {
    myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    myComposeView.setInitialText("Swift講座でアプリ作ったよ！  ")
    self.presentViewController(myComposeView, animated: true, completion: nil)
    }


}

