//
//  WebView.swift
//  Bout Time
//
//  Created by Ty Schenk on 12/17/16.
//  Copyright © 2016 Ty SchenkTy Schenk. All rights reserved.
//

import UIKit

class WebView: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    var url: String!
    var objectTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = objectTitle
        webView.loadRequest(URLRequest(url: URL(string: url)!))
    }

    @IBAction func backButtonUsed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
