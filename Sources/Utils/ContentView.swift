//
//  ContentView.swift
//  Utils
//
//  Created by Home on 28/02/25.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var Mul: CGFloat = 1
    
    var body: some View {
        HStack(spacing: -20) {
            Capsule()
                .fill(.red)
                .rotationEffect(Angle(degrees: -15 * Mul), anchor: .trailing)
            Capsule()
                .fill(.green)
                .rotationEffect(Angle(degrees: 15 * Mul), anchor: .leading)
            
        }
        .compositingGroup()
        .frame(width: 400, height: 20)
        .opacity(0.5)
        .onTapGesture {
            withAnimation(.linear(duration: 1)) {
                Mul *= -1
            }
        }
    }
}

#Preview {
    ContentView1()
}

struct ContentView1: View {
    var scene: SKScene {
        let scene = CollisionScene()
        scene.size = CGSize(width: 300, height: 600)
        scene.scaleMode = .resizeFill
        return scene
    }

    var img: UIImage {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        myView.backgroundColor = .systemBlue

        return myView.asImage()
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 300, height: 600)
            .border(Color.black, width: 2)
            .overlay {
//                Image(uiImage: Text("text 1").snapshot(size: CGSize(width: 30, height: 30)))
//                Image(uiImage: img)
            }
    }
}



import SpriteKit

class CollisionScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = .zero
        
        // Add image-based sprites
        Task {
            await addImageSprite(named: Rectangle(), at: CGPoint(x: 100, y: 300))
            await addImageSprite(
                named:
                    AngularGradient(
                        colors: [Color.blue, Color.red], center: .center
                    )
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                ,
                at: CGPoint(x: 200, y: 300))
        }
    }

    private func addImageSprite<V: View>(named imageName: V, at position: CGPoint) async {
        guard let image = await imageName.asHighQualityUIImage(size: CGSize(width: 60, height: 60)) else {return}
        //snapshot(size: CGSize(width: 30, height: 60))
//        guard let image = UIImage(systemName: imageName) else {
//            print("Image \(imageName) not found")
//            return
//        }

        let texture = SKTexture(image: image)
        let sprite = SKSpriteNode(texture: texture)
        sprite.size = CGSize(width: 60, height: 60) // Adjust size as needed
        sprite.position = position
        sprite.name = "imageName" + UUID().uuidString

        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        sprite.physicsBody?.restitution = 0.8
        sprite.physicsBody?.friction = 0.3
        sprite.physicsBody?.linearDamping = 0.1
        sprite.physicsBody?.allowsRotation = true
        sprite.physicsBody?.mass = 1.0

        addChild(sprite)

        // Apply initial impulse
        let dx = CGFloat.random(in: -150...150)
        let dy = CGFloat.random(in: -150...150)
        sprite.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
    }
}
