//
//  PlayerViewController.swift
//  MyMusic
//
//  Created by Afraz Siddiqui on 4/3/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import AVFoundation
import UIKit

class OurMusicPlayerViewController: UIViewController {

    public var songsPosition: Int = 0
    public var mySongs: [Song] = []

    var myPlayer: AVAudioPlayer?
    private var volume: Float = 1.0
    
    @IBOutlet var playingView: UIView!


    // User Interface elements

    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()

    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        label.font.withSize(CGFloat(30))
        return label
    }()

    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()

    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 // line wrap
        return label
    }()

    let playPauseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        playingView.backgroundColor = #colorLiteral(red: 0.9685265468, green: 0.8388833598, blue: 1, alpha: 1)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if playingView.subviews.count == 0 {
            configure()
        }
    }

    func configure() {
        // set up player
        let song = mySongs[songsPosition]

        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")

        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                print("urlstring is nil")
                return
            }

            myPlayer = try AVAudioPlayer(contentsOf: URL(string: urlString)!)

            guard let player = myPlayer else {
                print("player is nil")
                return
            }
//            player.volume = 0.5

            player.play()
        }
        catch {
            print("error occurred")
        }

        // set up user interface elements

        // album cover
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: playingView.frame.size.width-20,
                                      height: playingView.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        playingView.addSubview(albumImageView)

        // Labels: Song name, album, artist
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 30,
                                     width: playingView.frame.size.width-20,
                                     height: 70)
        songNameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        songNameLabel.textColor = .black
        albumNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 30 + 60,
                                     width: playingView.frame.size.width-20,
                                     height: 70)
        albumNameLabel.textColor = .black
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 30 + 110,
                                       width: playingView.frame.size.width-20,
                                       height: 70)
        artistNameLabel.textColor = .black

        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName

        playingView.addSubview(songNameLabel)
        playingView.addSubview(albumNameLabel)
        playingView.addSubview(artistNameLabel)

        // Player controls
        let nextButton = UIButton()
        let backButton = UIButton()

        // Frame
        let yPosition = playingView.frame.size.height - 120 - 50 - 30
        let size: CGFloat = 70

        playPauseButton.frame = CGRect(x: (playingView.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)

        nextButton.frame = CGRect(x: playingView.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        // Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)

        // Styling

        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward"), for: .normal)

        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black

        playingView.addSubview(playPauseButton)
        playingView.addSubview(nextButton)
        playingView.addSubview(backButton)

        // slider
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: playingView.frame.size.height - 120,
                                            width: playingView.frame.size.width - 40,
                                            height: 50))
        slider.value = volume
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        slider.maximumTrackTintColor = .gray
        slider.minimumTrackTintColor = .purple
        
        myPlayer?.volume = volume
        
        playingView.addSubview(slider)
    }

    @objc func didTapBackButton() {
        if songsPosition > 0 {
            songsPosition = songsPosition - 1
            myPlayer?.stop()
            for subview in playingView.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }

    @objc func didTapNextButton() {
        if songsPosition < (mySongs.count - 1) {
            songsPosition = songsPosition + 1
            myPlayer?.stop()
            for subview in playingView.subviews {
                subview.removeFromSuperview()
            }
            configure()
        } else {
            songsPosition = 0
            myPlayer?.stop()
            for subview in playingView.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }

    @objc func didTapPlayPauseButton() {
        if myPlayer?.isPlaying == true {
            // pause
            myPlayer?.pause()
            // show play button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)

            // shrink image
            UIView.animate(withDuration: 0.3, animations: {
                self.albumImageView.frame = CGRect(x: 50,
                                                   y: 50,
                                                   width: self.playingView.frame.size.width - 100,
                                                   height: self.playingView.frame.size.width - 100)
            })
        }
        else {
            // play
            myPlayer?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)

            // increase image size
            UIView.animate(withDuration: 0.1, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                              y: 10,
                                              width: self.playingView.frame.size.width - 20,
                                              height: self.playingView.frame.size.width - 20)
            })
        }
    }

    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        myPlayer?.volume = value
        volume = slider.value
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = myPlayer {
            player.stop()
        }
    }

}
