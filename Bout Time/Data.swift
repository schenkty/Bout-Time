//
//  Data.swift
//  Bout Time
//
//  Created by Ty Schenk on 12/17/16.
//  Copyright © 2016 Ty SchenkTy Schenk. All rights reserved.
//

import Foundation
import GameKit

struct Round {
    var firstQuestion: LanguageEvent
    var secondQuestion: LanguageEvent
    var thirdQuestion: LanguageEvent
    var fourthQuestion: LanguageEvent
    var correctOrder: [LanguageEvent]{
        let tempOrder = [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion]
        return tempOrder.sorted {$0.year < $1.year}
    }
}

protocol LanguageType {
    var name: String { get }
    var year: Int { get }
    var url: String { get }
}

struct LanguageEvent: LanguageType {
    var name: String
    var year: Int
    var url: String
}

//Create a Random number generator using the Gamekit Framework
func numberGenerator(_ max: Int) -> Int {
    let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: max)
    return randomNumber
}
//The number created above may have been used already, here that is checked, if the number is used we generate a new one, otherwise we return it
func randomNumberGenerator(usedNumbers: [Int], max: Int) -> Int {
    //Get a number from the numberGenerator
    var randomNumber = numberGenerator(max)
    //Check if it's in the usedNumbers array
    while usedNumbers.contains(randomNumber) {
        //The number is already used, create a new one and check again
        randomNumber = numberGenerator(max)
    }
    //Return a number that is not used before
    return randomNumber
}

var usedEvents: [String] = []

let events: [LanguageEvent] = [
    LanguageEvent(name: "Logo", year: 1968, url: "https://en.wikipedia.org/wiki/Logo_(programming_language)"),
    LanguageEvent(name: "B", year: 1969, url: "https://en.wikipedia.org/wiki/B_(programming_language)"),
    LanguageEvent(name: "Pascal", year: 1970, url: "https://en.wikipedia.org/wiki/Pascal_(programming_language)"),
    LanguageEvent(name: "Forth", year: 1970, url: "https://en.wikipedia.org/wiki/Forth_(programming_language)"),
    LanguageEvent(name: "C", year: 1972, url: "https://en.wikipedia.org/wiki/C_(programming_language)"),
    LanguageEvent(name: "Smalltalk", year: 1972, url: "https://en.wikipedia.org/wiki/Smalltalk"),
    LanguageEvent(name: "Prolog", year: 1972, url: "https://en.wikipedia.org/wiki/Prolog"),
    LanguageEvent(name: "ML", year: 1973, url: "https://en.wikipedia.org/wiki/ML_(programming_language)"),
    LanguageEvent(name: "Scheme", year: 1975, url: "https://en.wikipedia.org/wiki/Scheme_(programming_language)"),
    LanguageEvent(name: "SQL", year: 1978, url: "https://en.wikipedia.org/wiki/SQL"),
    LanguageEvent(name: "C++", year: 1980, url: "https://en.wikipedia.org/wiki/C%2B%2B"),
    LanguageEvent(name: "Ada", year: 1983, url: "https://en.wikipedia.org/wiki/Ada_(programming_language)"),
    LanguageEvent(name: "Common Lisp", year: 1984, url: "https://en.wikipedia.org/wiki/Common_Lisp"),
    LanguageEvent(name: "MATLAB", year: 1984, url: "https://en.wikipedia.org/wiki/MATLAB"),
    LanguageEvent(name: "Eiffel", year: 1985, url: "https://en.wikipedia.org/wiki/Eiffel_(programming_language)"),
    LanguageEvent(name: "Objective C", year: 1986, url: "https://en.wikipedia.org/wiki/Objective-C"),
    LanguageEvent(name: "Erlang", year: 1986, url: "https://en.wikipedia.org/wiki/Erlang_(programming_language)"),
    LanguageEvent(name: "Perl", year: 1987, url: "https://en.wikipedia.org/wiki/Perl"),
    LanguageEvent(name: "TCL", year: 1988, url: "https://en.wikipedia.org/wiki/Tcl"),
    LanguageEvent(name: "Wolfram Language", year: 1988, url: "https://en.wikipedia.org/wiki/Wolfram_Language"),
    LanguageEvent(name: "FL", year: 1989, url: "https://en.wikipedia.org/wiki/FL_(programming_language)"),
    LanguageEvent(name: "Haskell", year: 1990, url: "https://en.wikipedia.org/wiki/Haskell_(programming_language)"),
    LanguageEvent(name: "Python", year: 1991, url: "https://en.wikipedia.org/wiki/Python_(programming_language)"),
    LanguageEvent(name: "Visual Basic", year: 1991, url: "https://en.wikipedia.org/wiki/Visual_Basic"),
    LanguageEvent(name: "Ruby", year: 1993, url: "https://en.wikipedia.org/wiki/Ruby_(programming_language)"),
    LanguageEvent(name: "Lua", year: 1993, url: "https://en.wikipedia.org/wiki/Lua_(programming_language)"),
    LanguageEvent(name: "R", year: 1993, url: "https://en.wikipedia.org/wiki/R_(programming_language)"),
    LanguageEvent(name: "CLOS", year: 1994, url: "https://en.wikipedia.org/wiki/CLOS"),
    LanguageEvent(name: "Ada 95", year: 1995, url: "https://en.wikipedia.org/wiki/Ada_95"),
    LanguageEvent(name: "Java", year: 1995, url: "https://en.wikipedia.org/wiki/Java_(programming_language)"),
    LanguageEvent(name: "Delphi", year: 1995, url: "https://en.wikipedia.org/wiki/Embarcadero_Delphi"),
    LanguageEvent(name: "JavaScript", year: 1995, url: "https://en.wikipedia.org/wiki/JavaScript"),
    LanguageEvent(name: "PHP", year: 1995, url: "https://en.wikipedia.org/wiki/PHP"),
    LanguageEvent(name: "Rebol", year: 1997, url: "https://en.wikipedia.org/wiki/REBOL"),
    LanguageEvent(name: "D", year: 1999, url: "https://en.wikipedia.org/wiki/D_(programming_language)"),
    LanguageEvent(name: "ActionScript", year: 2000, url: "https://en.wikipedia.org/wiki/ActionScript"),
    LanguageEvent(name: "C#", year: 2001, url: "https://en.wikipedia.org/wiki/C_Sharp_(programming_language)"),
    LanguageEvent(name: "Apache Groovy", year: 2003, url: "https://en.wikipedia.org/wiki/Groovy_(programming_language)"),
    LanguageEvent(name: "Scala", year: 2003, url: "https://en.wikipedia.org/wiki/Scala_(programming_language)"),
    LanguageEvent(name: "F#", year: 2005, url: "https://en.wikipedia.org/wiki/F_Sharp_(programming_language)"),
    LanguageEvent(name: "Windows Powershell", year: 2006, url: "https://en.wikipedia.org/wiki/Windows_PowerShell"),
    LanguageEvent(name: "Clojure", year: 2007, url: "https://en.wikipedia.org/wiki/Clojure"),
    LanguageEvent(name: "Go", year: 2009, url: "https://en.wikipedia.org/wiki/Go_(programming_language)"),
    LanguageEvent(name: "Rust", year: 2010, url: "https://en.wikipedia.org/wiki/Rust_(programming_language)"),
    LanguageEvent(name: "Dart", year: 2011, url: "https://en.wikipedia.org/wiki/Dart_(programming_language)"),
    LanguageEvent(name: "Julia", year: 2012, url: "https://en.wikipedia.org/wiki/Julia_(programming_language)"),
    LanguageEvent(name: "Swift", year: 2014, url: "https://en.wikipedia.org/wiki/Swift_(programming_language)")
]

//Setup of a round
func setupRound() -> Round {
    //Create blank round to add objects to
    var round: Round = Round(firstQuestion: events[0], secondQuestion: events[0], thirdQuestion: events[0], fourthQuestion: events[0])
    var usedNumbers: [Int] = []
    //Add random events to the round object
    usedNumbers.removeAll()
    var randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
    usedNumbers.append(randomNumber)
    let firstEvent = events[randomNumber]
    randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
    usedNumbers.append(randomNumber)
    let secondEvent = events[randomNumber]
    randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
    usedNumbers.append(randomNumber)
    let thirdEvent = events[randomNumber]
    randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
    usedNumbers.append(randomNumber)
    let fourthEvent = events[randomNumber]
    round.firstQuestion = firstEvent
    round.secondQuestion = secondEvent
    round.thirdQuestion = thirdEvent
    round.fourthQuestion = fourthEvent
    usedEvents.append(fourthEvent.name)
    usedEvents.append(thirdEvent.name)
    usedEvents.append(secondEvent.name)
    usedEvents.append(firstEvent.name)
    return round
}

// Sounds
var gameSound: SystemSoundID = 0
//Function to play sound
func playSound(path: String) {
    let soundURL = URL(fileURLWithPath: path)
    AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    AudioServicesPlaySystemSound(gameSound)
}
