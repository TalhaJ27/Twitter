//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Talha Jahangir on 3/13/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { Error in
                print("Favorite did not succeed: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { Error in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    @IBAction func reTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("Error in retweeting: \(error)")
        })
        
    }
    
    func setRetweeted( isRetweeted:Bool){
        if (isRetweeted){
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for:UIControl.State.normal)
            reTweetButton.isEnabled = false
        } else {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for:UIControl.State.normal)
            reTweetButton.isEnabled = true
        }
    }
    
    func setFavorite( isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
