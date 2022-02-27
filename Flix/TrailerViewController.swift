//
//  TrailerViewController.swift
//  Flix
//
//  Created by LYON on 2/26/22.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    var movie: [String:Any]!
    var key: String!
    //var movies = [[String:Any]]()
    //var movieDictionary: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let movieId = movie["id"] as! Int
        let url = URL(string: "https://api.themoviedb.org/3/movie/" + String(movieId) + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                let results = dataDictionary["results"] as! [[String:Any]]
                
                //self.key = results[0]["key"] as? String
                print(results[0]["key"] as! String)
                
             }
        }
        task.resume()
        
        //let trailerPath = movies["key"] as! String
        let trailerURL = URL(string: "https://www.youtube.com")
        //let trailerURL = URL(string: "https://www.youtube.com/watch?v=" + key)
        let trailerRequest = URLRequest(url: trailerURL!)
        webView.load(trailerRequest)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
