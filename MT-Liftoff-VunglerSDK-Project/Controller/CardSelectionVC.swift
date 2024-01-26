//
//  CardSelectionVCViewController.swift
//  MT-Liftoff-VunglerSDK-Project
//
//  Created by Matthew Tripodi on 1/25/24.
//

import UIKit
import VungleAdsSDK

class CardSelectionVC: UIViewController, UIGestureRecognizerDelegate {
    private var interstitialAd: VungleInterstitial?
    
    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var playAndStopButton: UIButton!
    @IBOutlet var rulesButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    // Array of all the Card images
    var cards: [UIImage] = Card.allValues
    var timer: Timer!
    // Tap counter to keep track of how many times the Rules button has been tapped
    // Will trigger the Ad after X amount of taps
    var tapCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the Button to Play on launch
        playAndStopButton.setTitle("Play!", for: .normal)
        playAndStopButton.backgroundColor = UIColor.systemGreen
        
        // Add button gesture recognizer to rules button for the purpose of tracking the number of times the button was tapped
        // After X amount of taps will trigger an add
        rulesButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stopping the timer if the screen is closed
        timer.invalidate()
    }
    
    // Setting up a timer, every 10th of a second this timer fires off and it changes the card image
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(showrandomImage), userInfo: nil, repeats: true)
    }
    
    @objc func showrandomImage() {
        // This is going to pull out a random element / card from the cards array
        // If for some reason the array were to be empty the image will default to the Ace of Spades image
        cardImageView.image = cards.randomElement() ?? UIImage(named: "AS")
    }
    
    // Tap Gesture Recognizer
    @objc private func tap(tapGestureRecognizer: UITapGestureRecognizer) {
        print("tap")
        
        // Tracking the number of taps on the Rules button
        // After X amount of taps the Vungle Ad will play instead of initiating the Segue
        tapCounter = tapCounter + 1
        print(tapCounter)
        if tapCounter <= 1 {
            self.performSegue(withIdentifier: "toRules", sender: self)
        } else {
            print("Play Add")
            tapCounter = 0
            // Check if the add can be played and then play it
            if (self.interstitialAd?.canPlayAd() != nil) {
                self.interstitialAd?.present(with: self)
            }
        }
    }
    
    @IBAction func playAndStopButtonTapped(_ sender: UIButton) {
        // Starting the timer when the button is 'set' to 'Play' and is tapped
        // Then setting the button to appear and function as the 'Stop' button
        if playAndStopButton.currentTitle == "Play!" {
            startTimer()
            playAndStopButton.setTitle("Stop!", for: .normal)
            playAndStopButton.backgroundColor = UIColor.systemRed
        } else {
            //Stopping the timer when the 'Stop' button is tapped and then setting the button to appear and function as the 'Play' button
            timer.invalidate()
            playAndStopButton.setTitle("Play!", for: .normal)
            playAndStopButton.backgroundColor = UIColor.systemGreen
        }
        
        // If the play/stop button is tapped the Vungle interstitialAd will load
        // Only loading the Add when the playAndStopButton is set to 'Stop!'
        if playAndStopButton.currentTitle == "Stop!" {
            if sender == self.playAndStopButton {
                if self.interstitialAd != nil {
                    self.interstitialAd?.delegate = nil
                    self.interstitialAd = nil
                }
                
                // Unwrapping the placementID optional
                guard let placementID = Keys.placementID else {
                    return
                }
                // Loading the interestitial Ad
                self.interstitialAd = VungleInterstitial(placementId: placementID)
                self.interstitialAd?.delegate = self
                self.interstitialAd?.load()
            }
        }
    }
    
    @IBAction func rulesButtonTapped(_ sender: UIButton) {
        // Button functionality is in the tap gesture recognizer
    }
}


// MARK: - Vungle SDK Interstitial Delegate Callbacks
extension CardSelectionVC: VungleInterstitialDelegate {
    // Ad load events
    func interstitialAdDidLoad(_ interstitial: VungleInterstitial) {
        print("interstitialAdDidLoad")
        print(interstitial.description)
    }
    
    func interstitialAdDidFailToLoad(_ interstitial: VungleInterstitial, withError: NSError) {
        print("interstitialAdDidFailToLoad")
    }
    
    // Ad Lifecycle Events
    func interstitialAdWillPresent(_ interstitial: VungleInterstitial) {
        print("interstitialAdWillPresent")
    }
    
    func interstitialAdDidPresent(_ interstitial: VungleInterstitial) {
        print("interstitialAdDidPresent")
    }
    
    func interstitialAdDidFailToPresent(_ interstitial: VungleInterstitial, withError: NSError) {
        print("interstitialAdDidFailToPresent")
        print(withError.localizedDescription)
    }
    
    func interstitialAdDidTrackImpression(_ interstitial: VungleInterstitial) {
        print("interstitialAdDidTrackImpression")
    }
    
    func interstitialAdDidClick(_ interstitial: VungleInterstitial) {
        print("interstitialAdDidClick")
    }
    
    func interstitialAdWillLeaveApplication(_ interstitial: VungleInterstitial) {
        print("interstitialAdWillLeaveApplication")
    }
    
    func interstitialAdWillClose(_ interstitial: VungleInterstitial) {
        print("interstitialAdWillClose")
    }
    
    func interstitialAdDidClose(_ interstitial: VungleInterstitial) {
        print("interstitialAdDidClose")
    }
}
