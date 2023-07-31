import SwiftUI

struct ContentView: View {

    enum direction {
        case up, down, left, right
    }

    @State var startPosition: CGPoint = .zero
    @State var isStarted: Bool = true
    @State var gameOver = false
    @State var dir = direction.up
    @State var positionArray = [CGPoint(x: 0, y: 0)]
    @State var foodPosition = CGPoint(x: 0, y: 0)
    let snakeSize: CGFloat = 10
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    
    let minX = UIScreen.main.bounds.minX
    let maxX = UIScreen.main.bounds.maxX
    let minY = UIScreen.main.bounds.minY
    let maxY = UIScreen.main.bounds.maxY

    func changeRectPos() -> CGPoint {
            let rows = Int(maxX/snakeSize)
            let cols = Int(maxY/snakeSize)
            
            let randomX = Int.random(in: 1..<rows) * Int(snakeSize)
            let randomY = Int.random(in: 1..<cols) * Int(snakeSize)
            
            return CGPoint(x: randomX, y: randomY)
        }
    func changeDirection() {
        if self.positionArray[0].x < minX || self.positionArray[0].x > maxX && !gameOver {
            gameOver.toggle()
        }
        else if self.positionArray[0].y < minY || self.positionArray[0].y > maxY && !gameOver {
            gameOver.toggle()
        }
        var prev = positionArray[0]
        if dir == .down {
            self.positionArray[0].y += snakeSize
        } else if dir == .up {
            self.positionArray[0].y += snakeSize
        } else if dir == .left {
            self.positionArray[0].x += snakeSize
        } else if dir == .right {
            self.positionArray[0].x += snakeSize
        }
        
        for index  in 1..<positionArray.count{
            let current = positionArray[index]
            positionArray[index] = prev
            prev = current
        }
    }
    
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            ZStack{
                ForEach (0..<positionArray.count, id: \.self) { index in
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: snakeSize, height: snakeSize)
                        .position(positionArray[index])
                }
                Rectangle()
                    .fill(Color.red)
                    .frame(width: snakeSize, height: snakeSize)
                    .position(foodPosition)
            }
            
            if gameOver {
                Text("GAME OVER")
            }
        } .onAppear() {
            self.foodPosition = self.changeRectPos()
            self.positionArray[0] = self.changeRectPos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
