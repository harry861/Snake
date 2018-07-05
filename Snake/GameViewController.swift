//
//  GameViewController.swift
//  
//
//  Created by AutumnCAT on 2018/6/26.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    var timer=Timer()
    var game:Game!
    var counter = 0.0
    var notfinish = false
    var pausee=true
    var setting=Setting.readLoversFromFile()
    var speed=1
    
    var audioEatPlayer: AVAudioPlayer!
    var audioDeadPlayer: AVAudioPlayer!
    
    @IBOutlet weak var gameRange: UIView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    
    @IBAction func startGame(_ sender: Any) {
        game=Game()
        timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(speed-1)),
                                     target:self,
                                     selector: #selector( tickDown ),
                                     userInfo:nil,repeats:true)
        start.setTitle("重新開始", for: .normal)
        pause.isEnabled=true
        start.isEnabled=false
        
        topButton.isEnabled=true
        downButton.isEnabled=true
        rightButton.isEnabled=true
        leftButton.isEnabled=true
        
        let urlDead = Bundle.main.url(forResource: "死亡bgm", withExtension: "m4a")
        do {
            audioDeadPlayer = try AVAudioPlayer(contentsOf: urlDead!)
            audioDeadPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        
        let urlEat = Bundle.main.url(forResource: "吃到食物", withExtension: "m4a")
        do {
            audioEatPlayer = try AVAudioPlayer(contentsOf: urlEat!)
            audioEatPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
    }
    
    
    
    @IBAction func pauseGame(_ sender: Any) {
        if pausee{
            timer.invalidate()
            pause.setTitle("恢復", for: .normal)
            pausee=false
            
            topButton.isEnabled=false
            downButton.isEnabled=false
            rightButton.isEnabled=false
            leftButton.isEnabled=false
        }
        else{
            if (1-(0.05*Double(speed-1)+Double(game.point/5))) >= 0{
                timer.invalidate()
                
                timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(speed-1)+0.1*Double(game.point/5)),
                                             target:self,
                                             selector: #selector( tickDown ),
                                             userInfo:nil,repeats:true)
            }
            else {
                timer = Timer.scheduledTimer(timeInterval:1 - 0.95,
                                             target:self,
                                             selector: #selector( tickDown ),
                                             userInfo:nil,repeats:true)
            }
            
            
            
            
            pause.setTitle("暫停", for: .normal)
            pausee=true
            
            topButton.isEnabled=true
            downButton.isEnabled=true
            rightButton.isEnabled=true
            leftButton.isEnabled=true
        }
    }
    
    @IBAction func 轉方向(_ sender: UIButton) {
        if sender.titleLabel?.text=="上"{
            if game.snakeHead.move != Move.down{
                game.snakeHead.move=Move.top
            }
        }
        else if sender.titleLabel?.text=="下"{
            if game.snakeHead.move != Move.top{
                game.snakeHead.move=Move.down
            }
        }
        else if sender.titleLabel?.text=="左"{
            if game.snakeHead.move != Move.right{
                game.snakeHead.move=Move.left
            }
        }
        else if sender.titleLabel?.text=="右"{
            if game.snakeHead.move != Move.left{
                game.snakeHead.move=Move.right
            }
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        start.isEnabled=true
        pause.isEnabled=false
        topButton.isEnabled=false
        downButton.isEnabled=false
        rightButton.isEnabled=false
        leftButton.isEnabled=false
        
        
        if let speedd = setting?.speed{
            speed=speedd
        }
        // 向上滑動
        let swipeUp = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeUp.direction = .up
        
        // 幾根指頭觸發 預設為 1
        swipeUp.numberOfTouchesRequired = 1
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeUp)
        
        
        // 向左滑動
        let swipeLeft = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeLeft.direction = .left
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeLeft)
        
        
        // 向下滑動
        let swipeDown = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeDown.direction = .down
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeDown)
        
        
        // 向右滑動
        let swipeRight = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeRight.direction = .right
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    
    
    
    @objc func tickDown()
    {
        notfinish=game.runOneRound()
        if notfinish {
            let cgX=gameRange.frame.size.width/(CGFloat(game.boundaryX)-1)
            let cgY=gameRange.frame.size.height/(CGFloat(game.boundaryY)-1)
            
            
            //清空圖片
            for v in gameRange.subviews as [UIView] {
                v.removeFromSuperview()
            }
            
            //畫頭
            var myImageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(game.snakeHead.x-1)*cgX,
                    y: CGFloat(game.snakeHead.y-1)*cgY,
                    width: cgX,
                    height: cgY))
            if game.snakeHead.move==Move.top{
                myImageView.image = UIImage(named: "蛇頭 2.png")
            }
            else if game.snakeHead.move==Move.down{
                myImageView.image = UIImage(named: "蛇頭 4.png")
            }
            else if game.snakeHead.move==Move.right{
                myImageView.image = UIImage(named: "蛇頭 3.png")
            }
            else if game.snakeHead.move==Move.left{
                myImageView.image = UIImage(named: "蛇頭 1.png")
            }
            gameRange.addSubview(myImageView)
            
            //畫身體
            for sn in game.snakeBody{
                myImageView = UIImageView(
                    frame: CGRect(
                        x: CGFloat(sn.x-1)*cgX,
                        y: CGFloat(sn.y-1)*cgY,
                        width: cgX,
                        height: cgY))
                
                if sn.move==Move.top{
                    myImageView.image = UIImage(named: "蛇身 2.png")
                }
                else if sn.move==Move.down{
                    myImageView.image = UIImage(named: "蛇身 4.png")
                }
                else if sn.move==Move.right{
                    myImageView.image = UIImage(named: "蛇身 3.png")
                }
                else if sn.move==Move.left{
                    myImageView.image = UIImage(named: "蛇身 1.png")
                }
                
                gameRange.addSubview(myImageView)
            }
            
            //畫尾巴
            myImageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(game.snakeTail.x-1)*cgX,
                    y: CGFloat(game.snakeTail.y-1)*cgY,
                    width: cgX,
                    height: cgY))
            
            if game.snakeTail.move==Move.top{
                myImageView.image = UIImage(named: "蛇尾 2.png")
            }
            else if game.snakeTail.move==Move.down{
                myImageView.image = UIImage(named: "蛇尾 4.png")
            }
            else if game.snakeTail.move==Move.right{
                myImageView.image = UIImage(named: "蛇尾 3.png")
            }
            else if game.snakeTail.move==Move.left{
                myImageView.image = UIImage(named: "蛇尾 1.png")
            }
            
            gameRange.addSubview(myImageView)
            
            
            //畫食物
            myImageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(game.food.x-1)*cgX,
                    y: CGFloat(game.food.y-1)*cgY,
                    width: cgX,
                    height: cgY))
            
            myImageView.image = UIImage(named: "food"+String(game.food.foodImg)+".png")
            gameRange.addSubview(myImageView)
            
            //修改分數
            point.text="分數： " + String(format: "%02i", game.point)
            
            if game.point >= 20 {
                point.backgroundColor = UIColor(red: 50, green: 0, blue: 0, alpha: 1)
            }
            else if game.point >= 15 {
                point.backgroundColor = UIColor(red: 50, green: 0, blue: 50, alpha: 1)
            }
            else if game.point >= 10 {
                point.backgroundColor = UIColor(red: 50, green: 50, blue: 0, alpha: 1)
            }
            else if game.point >= 5 {
                point.backgroundColor = UIColor(red: 0, green: 25, blue: 50, alpha: 1)
            }
            
            
            print(game.food)
            print(game.snakeHead)
            
            //吃到食物時播音樂
            if game.status==Status.eat{
                audioEatPlayer.play()
            }
            //加速
            if game.point%5 == 0 && game.point != 0{
                if (1-(0.05*Double(speed-1)+0.1*Double(game.point/5))) >= 0{
                    timer.invalidate()
                    
                    timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(speed-1)+0.1*Double(game.point/5)),
                                                 target:self,
                                                 selector: #selector( tickDown ),
                                                 userInfo:nil,repeats:true)
                }
                else {
                    timer.invalidate()
                    
                    timer = Timer.scheduledTimer(timeInterval: 1-0.95,
                                                 target:self,
                                                 selector: #selector( tickDown ),
                                                 userInfo:nil,repeats:true)
                }
            }
        }
        else{
            //遊戲結束，紀錄成績 重設遊戲
            var tmp=User(no: 0, point: game.point, user: (setting?.name)!, description: "")
            
            User.saveToFile(user: tmp)
            
            timer.invalidate()
            
            start.isEnabled=true
            pause.isEnabled=false
            
            topButton.isEnabled=false
            downButton.isEnabled=false
            rightButton.isEnabled=false
            leftButton.isEnabled=false
            
            if game.status==Status.dead{
                audioDeadPlayer.play()
            }
        }
    }
    
    
    @objc func 滑動(recognizer:UISwipeGestureRecognizer) {
        
        if recognizer.direction == .up {
            if game.snakeHead.move != Move.down{
                game.snakeHead.move=Move.top
            }
        }
        else if recognizer.direction == .left {
            if game.snakeHead.move != Move.right{
                game.snakeHead.move=Move.left
            }
        }
        else if recognizer.direction == .down {
            if game.snakeHead.move != Move.top{
                game.snakeHead.move=Move.down
            }
        }
        else if recognizer.direction == .right {
            if game.snakeHead.move != Move.left{
                game.snakeHead.move=Move.right
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        // Show the navigation bar on other view controllers
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
