import Foundation

class LSystem {
    let alphabet: Set<Character>
    let axiom: String
    let productionRules: ProductionRules

    init(alphabet: Set<Character>, axiom: String, productionRules: ProductionRules){
        self.alphabet = alphabet
        self.axiom = axiom
        self.productionRules = productionRules
    }
    
}

class ProductionRule {
    let predecessor: Character
    let successor: String

    init(predecessor: Character, successor: String){
        self.predecessor = predecessor
        self.successor = successor
    }
}

class ProductionRules {
    typealias RulesDictionary = Dictionary<Character, ProductionRule>
    let rulesDictionary: RulesDictionary

    init(alphabet: Set<Character>, productionRules: [ProductionRule]) {
        var rulesDictionary = RulesDictionary()
        //Add all explicit rules
        for productionRule in productionRules {
            precondition(rulesDictionary[productionRule.predecessor] == nil, "Rule already exists")
            precondition(alphabet.contains(productionRule.predecessor), "Predecessor must be in the alphabet: \(productionRule.predecessor)")

            rulesDictionary[productionRule.predecessor] = productionRule
        }
        let predecessors = Set(productionRules.map {$0.predecessor})
        let sucessors = alphabet.subtracting(predecessors)
        
        self.rulesDictionary = rulesDictionary
    }
}
/*
func nonTerminals() -> Set<Character> {
    let nonTerminals = alphabet.filter { !axiom.contains($0) }
    for rule in productionRules.rulesDictionary.values {
        nonTerminals.formUnion(rule.successor.filter { !axiom.contains($0) })
    }
    return nonTerminals
}

func terminals() -> Set<Character> {
    let allChars = Set(axiom).union(productionRules.rulesDictionary.values.flatMap { Array($0.successor) })
    return alphabet.filter { !nonTerminals().contains($0) && allChars.contains($0) }
}
*/
func produce(generationCount: Int, lSystem: LSystem) -> String {
    var currentGeneration = lSystem.axiom
    for _ in 0..<generationCount {
        var nextGeneration = ""
        for character in currentGeneration {
            if let productionRule = lSystem.productionRules.rulesDictionary[character] {
                nextGeneration += productionRule.successor
            } else {
                nextGeneration += String(character)
            }
        }
        currentGeneration = nextGeneration
    }
    return currentGeneration
}

//let productionRules = [ProductionRule(predecessor:"1", successor:"11"), ProductionRule(predecessor:"0", successor:"1[0]0")]
//let lSystem = LSystem(alphabet:["0", "1", "[", "]"], axiom:"0", productionRules:productionRules)
