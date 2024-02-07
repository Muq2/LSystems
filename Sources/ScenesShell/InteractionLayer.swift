import Igis
import Scenes
import ScenesControls

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer {

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")
        let increaseGenerationButton = Button(name: "IncreaseGenCount", labelString: "Increase Generation  +", topLeft: Point(x: 50, y: 50))
        increaseGenerationButton.clickHandler = onIncreaseGenerationButtonClickHandler
        insert(entity: increaseGenerationButton, at: .front)                                                                                                                                                                                                   
        let decreaseGenerationButton = Button(name: "DecreaseGenCount", labelString: "Decrease Generation  -", topLeft: Point(x: 50, y: 80))
        decreaseGenerationButton.clickHandler = onDecreaseGenerationButtonClickHandler
        insert(entity: decreaseGenerationButton, at: .front)
        
        let increaseStepButton = Button(name: "IncreaseStepCount", labelString: "Increase Steps  +", topLeft: Point(x: 350, y: 50))
        increaseStepButton.clickHandler = onIncreaseStepButtonClickHandler
        insert(entity: increaseStepButton, at: .front)                                                                                                                                                                                                   
        let decreaseStepButton = Button(name: "DecreaseStepCount", labelString: "Decrease Steps  -", topLeft: Point(x: 350, y: 80))
        decreaseStepButton.clickHandler = onDecreaseStepButtonClickHandler
        insert(entity: decreaseStepButton, at: .front)

        let increaseAngleLButton = Button(name: "IncreaseAngleL", labelString: "Increase Angle L +", topLeft: Point(x: 350, y: 110))
        increaseAngleLButton.clickHandler = onIncreaseAngleLButtonClickHandler
        insert(entity: increaseAngleLButton, at: .front)                                                                                                                                                                                                   
        let decreaseAngleLButton = Button(name: "DecreaseAngleL", labelString: "Decrease Angle L -", topLeft: Point(x: 350, y: 140))
        decreaseAngleLButton.clickHandler = onDecreaseAngleLButtonClickHandler
        insert(entity: decreaseAngleLButton, at: .front)

        let increaseAngleRButton = Button(name: "IncreaseAngleR", labelString: "Increase Angle R +", topLeft: Point(x: 650, y: 110))
        increaseAngleRButton.clickHandler = onIncreaseAngleRButtonClickHandler
        insert(entity: increaseAngleRButton, at: .front)                                                                                                                                                                                                   
        let decreaseAngleRButton = Button(name: "DecreaseAngleR", labelString: "Decrease Angle R -", topLeft: Point(x: 650, y: 140))
        decreaseAngleRButton.clickHandler = onDecreaseAngleRButtonClickHandler
        insert(entity: decreaseAngleRButton, at: .front)

        let lSystemButton = Button(name: "lSystem", labelString: "Cycle Systems", topLeft: Point(x: 50, y: 110))
        lSystemButton.clickHandler = onLSystemButtonClickHandler
        insert(entity: lSystemButton, at: .front)

        let colorButton = Button(name: "color", labelString: "Cycle Colors", topLeft: Point(x: 50, y: 140))
        colorButton.clickHandler = onColorButtonClickHandler
        insert(entity: colorButton, at: .front)                                                                    
    }

    func background() -> Background {
        guard let mainScene = scene as? MainScene else {
            fatalError("mainScene of type MainScene is required")
        }
        let backgroundLayer = mainScene.backgroundLayer
        let background = backgroundLayer.background
        return background
    }
 
    
    func onIncreaseGenerationButtonClickHandler(control: Control, localLocation: Point) {
        background().incrementGenerationCount()
    }
    
    func onDecreaseGenerationButtonClickHandler(control: Control, localLocation: Point) {
        background().decrementGenerationCount()
    }

    func onIncreaseStepButtonClickHandler(control: Control, localLocation: Point) {
        background().incrementStepCount()
    }
    
    func onDecreaseStepButtonClickHandler(control: Control, localLocation: Point) {
        background().decrementStepCount()
    }

    func onIncreaseAngleLButtonClickHandler(control: Control, localLocation: Point) {
        background().incrementAngleL()
    }
    
    func onDecreaseAngleLButtonClickHandler(control: Control, localLocation: Point) {
        background().decrementAngleL()
    }
    
    func onIncreaseAngleRButtonClickHandler(control: Control, localLocation: Point) {
        background().incrementAngleR()
    }
    
    func onDecreaseAngleRButtonClickHandler(control: Control, localLocation: Point) {
        background().decrementAngleR()
    }

    func onLSystemButtonClickHandler(control: Control, localLocation: Point) {
        background().cycleLSystem()
    }

    func onColorButtonClickHandler(control: Control, localLocation: Point) {
        background().cycleColor()
    }
}
