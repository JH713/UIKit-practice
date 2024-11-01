//
//  ViewController.swift
//  timerPractice
//
//  Created by 이지현 on 11/1/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var countdownTimer = Timer()
    private var timerMilliseconds = 60 * 3 * 1000
    private var backgroundEnterDate: Date?
    
    private lazy var timeLabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)  // 옵저버 제거
        countdownTimer.invalidate()  // 타이머 해제
    }
    
    private func startTimer() {
        updateLabels()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] timer in
            guard let self else { return }
            timerMilliseconds -= 100
            updateLabels()
            
            if timerMilliseconds <= 0 {
                resetTimer()
            }
        }
    }
    
    private func updateLabels() {
        let totalSeconds = timerMilliseconds / 1000
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        timeLabel.text = "\(minutes):\(secondsString)"
    }
    
    private func resetTimer() {
        countdownTimer.invalidate()
        view.backgroundColor = .systemRed
    }
    
    @objc private func appDidEnterBackground() {
        backgroundEnterDate = Date()  // 백그라운드로 들어간 시간을 저장
        countdownTimer.invalidate()  // 타이머 정지
    }

    @objc private func appWillEnterForeground() {
        guard let backgroundEnterDate else { return }
        
        let timeSpentInBackground = Int(Date().timeIntervalSince(backgroundEnterDate) * 1000)
        timerMilliseconds -= timeSpentInBackground

        if timerMilliseconds <= 0 {
            timerMilliseconds = 0
            resetTimer()
            updateLabels()
        } else {
            startTimer()
        }
    }

}

