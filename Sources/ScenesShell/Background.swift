import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    private var didRender = false
    private var generationCount = 1
    private var stepCount = 5
    private var lSystemNum = 0
    private var angleL = 90
    private var angleR = 90
    private var color = 0
    private var colorArr = [Color(.red), Color(.green), Color(.blue), Color(.orange), Color(.purple)]
    
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }
    
    override func render(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize, !didRender {
            let turtle = Turtle(canvasSize:canvasSize)

            //Set Color
            turtle.penColor(color:colorArr[color])
            
            moveTurtleForKochCurve(turtle:turtle, generationCount:generationCount, steps:stepCount, lSystemNum:lSystemNum, angleL:angleL, angleR:angleR)
            
            clearCanvas(canvas: canvas)
            
            canvas.render(turtle)
            
            //let angleLText = Text(location:Point(x:100,y:1300), text:"Left Angle: \(angleL)")
            //angleLText.font = "30pt Arial"
            //canvas.render(angleLText)
            
            didRender = true
        }
        
        
        
       
    }
    
    public func incrementGenerationCount() {
        if generationCount < 6 {
            generationCount += 1
        }
        didRender = false
    }

    public func decrementGenerationCount() {
        if generationCount > 1 {
            generationCount -= 1
        }
        didRender = false
    }

    public func incrementStepCount() {
        if stepCount < 50 {
            stepCount += 1
        }
        didRender = false
    }

    public func decrementStepCount() {
        if stepCount > 0 {
            stepCount -= 1
        }
        didRender = false
    }

    public func incrementAngleL() {
        if angleL < 360 {
            angleL += 1
        }
        
        didRender = false
    }

    public func decrementAngleL() {
        if angleL > 0 {
            angleL -= 1
        }
        didRender = false
    }

    public func incrementAngleR() {
        if angleR < 360 {
            angleR += 1
        }
        didRender = false
    }

    public func decrementAngleR() {
        if angleR > 0 {
            angleR -= 1
        }
        didRender = false
    }

    public func cycleLSystem() {
        if lSystemNum < 6 {
            lSystemNum += 1
        }
        else {
            lSystemNum = 0
        }

        // Reset gen count on cycle
        generationCount = 1
        
        didRender = false
    }

    public func cycleColor() {
        if color < 4 {
            color += 1
        }
        else {
            color = 0
        }
                
        didRender = false
    }
    
    func moveTurtleForKochCurve(turtle:Turtle, generationCount:Int, steps:Int, lSystemNum:Int, angleL:Int, angleR:Int) {
        // Init
        let alphabet : Set<Character>
        let axiom : String
        let productionRulesArr : [ProductionRule]
        let productionRules : ProductionRules
        let lSystem : LSystem
        let production : String 
        let angleL = Double(angleL)
        let angleR = Double(angleR)
        
        // Create LSystem
        switch lSystemNum {
        case 0: 
            alphabet = Set<Character>(["F", "+", "-"])
            axiom = "F"
            
            productionRulesArr = [ProductionRule(predecessor:"F", successor:"F+F-F-F+F")]
            productionRules = ProductionRules(alphabet: alphabet, productionRules:productionRulesArr)
            
            lSystem = LSystem(alphabet:alphabet, axiom:axiom, productionRules:productionRules)
            production = produce(generationCount:generationCount, lSystem: lSystem)

            // Map the LSystem to turtle graphics
            // Start in a good direction
            // Start in a good direction
            turtle.penUp()
            turtle.left(degrees:90)
            turtle.forward(steps:450)
            turtle.left(degrees:90)
            turtle.forward(steps:250)
            turtle.right(degrees:180)
            turtle.penDown()
            turtle.right(degrees:90)
        
            for letter in production {
                switch (letter) {
                case "F":
                    turtle.forward(steps:steps)
                case "+":
                    turtle.left(degrees:90) //90
                case "-":
                    turtle.right(degrees:90) //90
                default:
                    fatalError("Unexepected letter '\(letter)' in production.")
                }
                
            }
        case 1:
            alphabet = Set<Character>(["F", "G", "+", "-"])
            axiom = "F-G-G"
            
            productionRulesArr = [ProductionRule(predecessor:"F", successor:"F-G+F+G-F"), ProductionRule(predecessor:"G", successor:"GG")]
            productionRules = ProductionRules(alphabet: alphabet, productionRules:productionRulesArr)
            
            lSystem = LSystem(alphabet:alphabet, axiom:axiom, productionRules:productionRules)
            production = produce(generationCount:generationCount, lSystem: lSystem)

            // Map the LSystem to turtle graphics
            // Start in a good direction
            turtle.penUp()
            turtle.right(degrees:90)
            turtle.forward(steps:450)
            turtle.right(degrees:90)
            turtle.forward(steps:250)
            turtle.left(degrees:180)
            turtle.penDown()
            turtle.right(degrees:270)
            
            for letter in production {
                switch (letter) {
                case "F":
                    turtle.forward(steps:steps)
                case "G":
                    turtle.forward(steps:steps)
                case "+":
                    turtle.left(degrees:120) // 120
                case "-":
                    turtle.right(degrees:120) // 120
                default:
                    fatalError("Unexepected letter '\(letter)' in production.")
                }
               
            }
        case 2:
            alphabet = Set<Character>(["F", "G", "+", "-"])
            axiom = "F"
            
            productionRulesArr = [ProductionRule(predecessor:"F", successor:"F+G"), ProductionRule(predecessor:"G", successor:"F-G")]
            productionRules = ProductionRules(alphabet: alphabet, productionRules:productionRulesArr)
            
            lSystem = LSystem(alphabet:alphabet, axiom:axiom, productionRules:productionRules)
            production = produce(generationCount:generationCount, lSystem: lSystem)

            // Map the LSystem to turtle graphics
            for letter in production {
                switch (letter) {
                case "F":
                    turtle.forward(steps:steps)
                case "G":
                    turtle.forward(steps:steps)
                case "+":
                    turtle.left(degrees:90) // 90
                case "-":
                    turtle.right(degrees:90) // 90
                default:
                    fatalError("Unexepected letter '\(letter)' in production.")
                }
            }
        case 3:
            alphabet = Set<Character>(["F", "X", "+", "-", "[", "]", "0", "1", "2", "3"])
            axiom = "FX"
            
            productionRulesArr = [ProductionRule(predecessor:"F", successor:"0FF-[1-F+F]+[2+F-F]"), ProductionRule(predecessor:"X", successor:"0FF+[1+F]+[3-F]")]
            productionRules = ProductionRules(alphabet: alphabet, productionRules:productionRulesArr)
            
            lSystem = LSystem(alphabet:alphabet, axiom:axiom, productionRules:productionRules)
            production = produce(generationCount:generationCount, lSystem: lSystem)

            // Map the LSystem to turtle graphics
            for letter in production {
                switch (letter) {
                case "F":
                    turtle.forward(steps:steps)
                case "X":
                    turtle.forward(steps:steps)
                case "+":
                    turtle.left(degrees:25) //25
                case "-":
                    turtle.right(degrees:25) //25
                case "[":
                    turtle.push()
                case "]":
                    turtle.pop()
                case "0":
                    turtle.penColor(color:Color(red:140,green:80,blue:60))
                case "1":
                    turtle.penColor(color:Color(red:24,green:180,blue:24))
                case "2":
                    turtle.penColor(color:Color(red:48,green:220,blue:48))
                case "3":
                    turtle.penColor(color:Color(red:64,green:255,blue:64))
                default:
                    fatalError("Unexepected letter '\(letter)' in production.")
                }
            }
        case 4:
            alphabet = Set<Character>(["F", "X", "+", "-", "[", "]"])
            axiom = "X"
            
            productionRulesArr = [ProductionRule(predecessor:"F", successor:"FF"), ProductionRule(predecessor:"X", successor:"F+[[X]-X]-F[-FX]+X")]
            productionRules = ProductionRules(alphabet: alphabet, productionRules:productionRulesArr)
            
            lSystem = LSystem(alphabet:alphabet, axiom:axiom, productionRules:productionRules)
            production = produce(generationCount:generationCount, lSystem: lSystem)

            // Map the LSystem to turtle graphics
            for letter in production {
                switch (letter) {
                case "F":
                    turtle.forward(steps:steps)
                case "X":
                    turtle.forward(steps:steps)
                case "+":
                    turtle.left(degrees:25) //25
                case "-":
                    turtle.right(degrees:25) //25
                case "[":
                    turtle.push()
                case "]":
                    turtle.pop()
                default:
                    fatalError("Unexepected letter '\(letter)' in production.")
                }
                
            }
        case 5:
            alphabet = Set<Character>(["F", "+", "-", "[", "]"])
            axiom = "F"
            
            productionRulesArr = [ProductionRule(predecessor:"F", successor:"F[+FF][-FF]F[-F][+F]F")]
            productionRules = ProductionRules(alphabet: alphabet, productionRules:productionRulesArr)
            
            lSystem = LSystem(alphabet:alphabet, axiom:axiom, productionRules:productionRules)
            production = produce(generationCount:generationCount, lSystem: lSystem)

            // Map the LSystem to turtle graphics
            for letter in production {
                switch (letter) {
                case "F":
                    turtle.forward(steps:steps)
                case "+":
                    turtle.left(degrees:35) //35
                case "-":
                    turtle.right(degrees:35) //35
                case "[":
                    turtle.push()
                case "]":
                    turtle.pop()
                default:
                    fatalError("Unexepected letter '\(letter)' in production.")
                }
            }
        case 6:
            alphabet = Set<Character>(["F", "X", "+", "-", "[", "]"])
            axiom = "X"
            
            productionRulesArr = [ProductionRule(predecessor:"X", successor:"F+[[X]-X]-F[-FX]+X"), ProductionRule(predecessor:"F", successor:"FF")]
            productionRules = ProductionRules(alphabet: alphabet, productionRules:productionRulesArr)
            
            lSystem = LSystem(alphabet:alphabet, axiom:axiom, productionRules:productionRules)
            production = produce(generationCount:generationCount, lSystem: lSystem)

            // Map the LSystem to turtle graphics
            for letter in production {
                switch (letter) {
                case "F":
                    turtle.forward(steps:steps)
                case "X":
                    turtle.forward(steps:steps)
                case "+":
                    turtle.left(degrees:25) //25
                case "-":
                    turtle.right(degrees:25) //25
                case "[":
                    turtle.push()
                case "]":
                    turtle.pop()
                default:
                    fatalError("Unexepected letter '\(letter)' in production.")
                }
            }
        default:
            production = "Error"
            fatalError("Unexepected production '\(production)' in system.")
        }
        

        
    }

}
