//
//  DetailsGridController.swift
//  Flix
//
//  Created by LYON on 2/26/22.
//

import UIKit
import AlamofireImage

class DetailsGridController: UIViewController {

    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        dateLabel.text = movie["release_date"] as? String
        dateLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"]as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af.setImage(withURL: posterUrl)
        
        let backDropPath = movie["backdrop_path"] as! String
        let backDropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backDropPath)!
        backDropView.af.setImage(withURL: backDropUrl)
        
        // The didTap: method will be defined in Step 3 below.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))

        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 2

        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        print("hello")
    }
    
    @objc func didTap(sender: UITapGestureRecognizer) {
       let location = sender.location(in: view)
       // User tapped at the point above. Do something with that if you want.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected movie to the TrailerViewController
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movie = movie
    }
}
