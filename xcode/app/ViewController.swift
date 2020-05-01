//
//  ViewController.swift
//  SwiftDP_Example
//
//  Created by Madalin Mamuleanu on 09/04/2020.
//  Copyright © 2020 OpenMined. All rights reserved.
//

import UIKit
import SwiftDP

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let sandbox = Sandbox()
        print("Running objective-c++ sandbox")
        sandbox.test()

        // test status
        let status = DPStatus.statuskUnknown // 2
        let message = "Test Status"
        if let status = OCDPStatus(status: status, andMessage: message) {
            print("Status Code: \(status.code())")
            print("Status Code: \(String(describing: status.message()))")
        }

        // create a carrot reporter
        let carrotData: [String: NSNumber] = ["Aardvark": 1, "Albatross": 88, "Alligator": 35, "Alpaca": 99, "Ant": 69, "Anteater": 14, "Antelope": 77, "Ape": 53, "Armadillo": 94, "Baboon": 67, "Badger": 92, "Barracuda": 87, "Bat": 70, "Bear": 31, "Beaver": 14, "Bee": 14, "Bison": 61, "Boar": 57, "Buffalo": 68, "Butterfly": 13, "Camel": 21, "Caribou": 38, "Cat": 92, "Caterpillar": 39, "Cattle": 46, "Chamois": 36, "Cheetah": 23, "Chicken": 76, "Chimpanzee": 8, "Chinchilla": 69, "Chough": 35, "Clam": 83, "Capybara": 40, "Cobra": 74, "Cockroach": 17, "Cod": 77, "Cormorant": 52, "Coyote": 31, "Crab": 14, "Crane": 40, "Crocodile": 46, "Crow": 99, "Curlew": 44, "Deer": 15, "Dinosaur": 89, "Dog": 36, "Dogfish": 98, "Dolphin": 20, "Donkey": 56, "Dove": 90, "Dragonfly": 5, "Duck": 75, "Dugong": 56, "Eagle": 23, "Echidna": 49, "Eel": 83, "Elephant": 55, "Elk": 22, "Emu": 7, "Falcon": 16, "Ferret": 91, "Finch": 80, "Fish": 21, "Flamingo": 56, "Fly": 10, "Fox": 28, "Frog": 29, "Gazelle": 19, "Gerbil": 73, "Giraffe": 45, "Gnat": 5, "Goat": 20, "Goldfinch": 28, "Goldfish": 45, "Goose": 39, "Gorilla": 64, "Grasshopper": 22, "Gull": 7, "Hamster": 30, "Hare": 10, "Hawk": 48, "Hedgehog": 60, "Heron": 73, "Herring": 82, "Hippopotamus": 96, "Hornet": 82, "Horse": 38, "Hummingbird": 84, "Hyena": 39, "Jackal": 12, "Jaguar": 75, "Jay": 75, "Kangaroo": 45, "Koala": 87, "Lark": 91, "Lemur": 33, "Leopard": 40, "Lion": 0, "Llama": 67, "Lobster": 63, "Locust": 16, "Mallard": 93, "Manatee": 19, "Marten": 72, "Meerkat": 46, "Mole": 73, "Monkey": 98, "Moose": 86, "Mosquito": 3, "Mouse": 64, "Mule": 94, "Narwhal": 75, "Newt": 2, "Nightingale": 87, "Octopus": 74, "Opossum": 79, "Ostrich": 56, "Otter": 51, "Owl": 77, "Ox": 81, "Oyster": 42, "Panther": 90, "Parrot": 96, "Peafowl": 4, "Pelican": 58, "Penguin": 73, "Pheasant": 27, "Pig": 56, "Pigeon": 80, "Porcupine": 10, "Porpoise": 35, "Quail": 86, "Rabbit": 100, "Raccoon": 16, "Rail": 7, "Ram": 30, "Rat": 84, "Raven": 50, "Rhinoceros": 86, "Salamander": 21, "Salmon": 15, "Sardine": 66, "Scorpion": 75, "Seahorse": 71, "Seal": 56, "Shark": 52, "Sheep": 99, "Shrew": 45, "Shrimp": 84, "Skunk": 99, "Snail": 51, "Snake": 37, "Spider": 96, "Squid": 90, "Squirrel": 92, "Starling": 80, "Stingray": 96, "Stinkbug": 31, "Stork": 39, "Swallow": 2, "Swan": 68, "Tapir": 53, "Tiger": 47, "Toad": 82, "Trout": 51, "Turkey": 57, "Turtle": 10, "Viper": 28, "Vulture": 91, "Walrus": 94, "Wasp": 51, "Weasel": 20, "Whale": 87, "Wolf": 81, "Wolverine": 36, "Wombat": 84, "Woodcock": 54, "Woodpecker": 7, "Worm": 42, "Wren": 55, "Yak": 60, "Zebra": 7]

        let carrots = OCDPCarrotReporter(epsilon: 1, andData: carrotData)
        let carrotDataBack = carrots.getCarrotsData()
        print("Carrots Data is: ", carrotDataBack)

        let sum = carrots.sum()
        let countAbove = carrots.count(above: -1)
        let mean = sum / countAbove
        let max = carrots.max()
        print("sum countAbove mean max", sum, countAbove, mean, max)
        assert(max == 100, "Carrots MAX == 100")

        print("privacy budget", carrots.privacyBudget())
        assert(carrots.privacyBudget() == 1, "Privacy Budget == 1")

        let privateMax = carrots.privateSum(1)
        print("private max", privateMax)
    }

}
