//
//  GameScene.swift
//  gameduaxe
//
//  Created by HaiPhan on 5/23/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var matdat: SKSpriteNode!
    var vekeduong: SKSpriteNode!
    var player: SKSpriteNode!
    var enemy1: SKSpriteNode!
    var enemy2: SKSpriteNode!
    var enemy3: SKSpriteNode!
    var enemy4: SKSpriteNode!
    var enemy5: SKSpriteNode!
    enum vachamcar:UInt32 {
        case enemy1 = 1
        case  enemy2 = 2
        case enemy3 = 3
        case player = 4
        case enemy4 = 5
        case enemy5 = 6
    }
    var timer: Timer!
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createbackground()
        keduong()
        createplayer()
//        createenemy()
//        moveenemy()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(createenemy), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(createenemy2), userInfo: nil, repeats: true)
//        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveenemy), userInfo: nil, repeats: true)
        // Get label node from scene and store it for use later
        
        // Create shape node to use during mouse interaction
    }
    func moveenemy2(){
        let actionmove: SKAction = SKAction.moveTo(y: -self.view!.frame.size.height + 50 , duration: 4)
        let removeaction: SKAction = SKAction.removeFromParent()
        enemy4.run(actionmove) {
            self.enemy4.run(removeaction)
        }
        enemy5.run(actionmove) {
            self.enemy5.run(removeaction)
        }
    }
     func moveenemy(){
        let actionmove: SKAction = SKAction.moveTo(y: -self.view!.frame.size.height + 50 , duration: 4)
        let removeaction: SKAction = SKAction.removeFromParent()
//        let waito : SKAction = SKAction.wait(forDuration: 4)
//        let listaction: SKAction = SKAction.sequence([actionmove,waito,removeaction])
//        enemy1.run(listaction)
        enemy1.run(actionmove) {
            self.enemy1.run(removeaction)
        }
        enemy2.run(actionmove) {
            self.enemy2.run(removeaction)
        }
        enemy3.run(actionmove) {
            self.enemy3.run(removeaction)
        }
    }
    func createfire(location: CGPoint){
        let path = Bundle.main.path(forResource: "fire", ofType: "sks")
        let file = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        file.position = location
        self.addChild(file)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == vachamcar.player.rawValue || contact.bodyB.categoryBitMask == vachamcar.player.rawValue {
            if contact.bodyA.categoryBitMask == vachamcar.enemy1.rawValue || contact.bodyB.categoryBitMask == vachamcar.enemy1.rawValue {
                player.removeFromParent()
                enemy1.removeFromParent()
                createfire(location: contact.contactPoint)
                timer.invalidate()
            }
        }
        if contact.bodyA.categoryBitMask == vachamcar.player.rawValue || contact.bodyB.categoryBitMask == vachamcar.player.rawValue {
            if contact.bodyA.categoryBitMask == vachamcar.enemy2.rawValue || contact.bodyB.categoryBitMask == vachamcar.enemy2.rawValue {
                player.removeFromParent()
                enemy2.removeFromParent()
                createfire(location: contact.contactPoint)
                timer.invalidate()
            }
        }
        if contact.bodyA.categoryBitMask == vachamcar.player.rawValue || contact.bodyB.categoryBitMask == vachamcar.player.rawValue {
            if contact.bodyA.categoryBitMask == vachamcar.enemy3.rawValue || contact.bodyB.categoryBitMask == vachamcar.enemy3.rawValue {
                player.removeFromParent()
                enemy3.removeFromParent()
                createfire(location: contact.contactPoint)
                timer.invalidate()
            }
        }
    }
    @objc func createenemy2(){
        enemy4 = SKSpriteNode(imageNamed: "4.png")
        enemy4.position = CGPoint(x: Int.random(in: -300 ... -299), y: Int.random(in: 799...800))
        enemy4.size = player.size
        enemy4.zPosition = 1
        enemy4.physicsBody = SKPhysicsBody(rectangleOf: enemy4.size)
        enemy4.physicsBody?.isDynamic = false
        enemy4.physicsBody?.affectedByGravity = false
        enemy4.physicsBody?.categoryBitMask = vachamcar.enemy4.rawValue
        enemy4.physicsBody?.contactTestBitMask = vachamcar.player.rawValue
        self.addChild(enemy4)
        
        enemy5 = SKSpriteNode(imageNamed: "2.png")
        enemy5.position = CGPoint(x: Int.random(in: -200...200), y: Int.random(in: 799...800))
        enemy5.size = player.size
        enemy5.zPosition = 1
        enemy5.physicsBody = SKPhysicsBody(rectangleOf: enemy5.size)
        enemy5.physicsBody?.isDynamic = false
        enemy5.physicsBody?.affectedByGravity = false
        enemy5.physicsBody?.categoryBitMask = vachamcar.enemy5.rawValue
        enemy5.physicsBody?.contactTestBitMask = vachamcar.player.rawValue
        self.addChild(enemy5)
        moveenemy2()
        
    }
    @objc func createenemy(){
//        let positionx = Int.random(in: -200...200)
//        let positiony = Int.random(in: 799...600)
        enemy1 = SKSpriteNode(imageNamed: "1.png")
        enemy1.position = CGPoint(x: Int.random(in: -300 ... -299), y: Int.random(in: 799...800))
        enemy1.size = player.size
        enemy1.zPosition = 1
        enemy1.physicsBody = SKPhysicsBody(rectangleOf: enemy1.size)
        enemy1.physicsBody?.isDynamic = false
        enemy1.physicsBody?.affectedByGravity = false
        enemy1.physicsBody?.categoryBitMask = vachamcar.enemy1.rawValue
        enemy1.physicsBody?.contactTestBitMask = vachamcar.player.rawValue
        self.addChild(enemy1)
        
        enemy2 = SKSpriteNode(imageNamed: "2.png")
        enemy2.position = CGPoint(x: Int.random(in: -200...200), y: Int.random(in: 799...800))
        enemy2.size = player.size
        enemy2.zPosition = 1
        enemy2.physicsBody = SKPhysicsBody(rectangleOf: enemy2.size)
        enemy2.physicsBody?.isDynamic = false
        enemy2.physicsBody?.affectedByGravity = false
        enemy2.physicsBody?.categoryBitMask = vachamcar.enemy2.rawValue
        enemy2.physicsBody?.contactTestBitMask = vachamcar.player.rawValue
        self.addChild(enemy2)
        
        enemy3 = SKSpriteNode(imageNamed: "3.png")
        enemy3.position = CGPoint(x: Int.random(in: -200...200), y: Int.random(in: 799...800))
        enemy3.size = player.size
        enemy3.zPosition = 1
        enemy3.physicsBody = SKPhysicsBody(rectangleOf: enemy3.size)
        enemy3.physicsBody?.isDynamic = false
        enemy3.physicsBody?.affectedByGravity = false
        enemy3.physicsBody?.categoryBitMask = vachamcar.enemy3.rawValue
        enemy3.physicsBody?.contactTestBitMask = vachamcar.player.rawValue
        self.addChild(enemy3)
        moveenemy()
        
    }
    func createplayer(){
        player = SKSpriteNode(imageNamed: "police.png")
        player.position = CGPoint(x: 0, y: -self.view!.frame.height + 180)
        player.size = CGSize(width: self.frame.size.width/7, height: self.frame.size.height/7)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = vachamcar.player.rawValue
        player.physicsBody?.contactTestBitMask = vachamcar.player.rawValue
        self.addChild(player)
    }
    func keduong(){
        vekeduong = SKSpriteNode(imageNamed: "soc.png")
        vekeduong.position = CGPoint(x: 0, y: 0)
        vekeduong.size = CGSize(width: 20, height: 100)
        self.addChild(vekeduong)
        
        let keduong2: SKSpriteNode = SKSpriteNode(imageNamed: "soc.png")
        keduong2.position = CGPoint(x: 0, y: vekeduong.position.y + 400)
        keduong2.size = vekeduong.size
        self.addChild(keduong2)
        
        let keduong3: SKSpriteNode = SKSpriteNode(imageNamed: "soc.png")
        keduong3.position = CGPoint(x: 0, y: vekeduong.position.y - 400)
        keduong3.size = vekeduong.size
        self.addChild(keduong3)
    }
    func createbackground(){
        matdat = SKSpriteNode(imageNamed: "matduong.png")
        matdat.position = CGPoint(x: 0, y: 0)
        matdat.size = CGSize(width: self.view!.frame.width*2, height: self.view!.frame.height*2)
        self.addChild(matdat)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
            player.position = t.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
