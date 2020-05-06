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

        PrintF("\nIt is a new day. Farmer Fred is ready to ask the animals about their " +
            "carrot consumption.\n")

        let defaultEpsilon =  log2(3.0)
        let epsilon = defaultEpsilon * 4
        let reporter = OCDPCarrotReporter(epsilon: epsilon, andData: carrotData)

        // Query for the total number of carrots. Notice that we explicitly use 25% of
        // our privacy budget.
        PrintF("\nFarmer Fred asks the animals how many total carrots they have " +
            "eaten. The animals know the true sum but report the " +
            "differentially private sum to Farmer Fred. But first, they ensure " +
            "that Farmer Fred still has privacy budget left.\n")
        PrintF("\nPrivacy budget remaining: %.2f\n", reporter.privacyBudget())
        PrintF("True sum: %d\n", reporter.sum())
        if let dpsum = reporter.privateSum(0.25).value()?.getInt() {
            PrintF("DP sum:   %d\n", dpsum)
        }

        PrintF("\nFarmer Fred catches on that the animals are giving him DP results. " +
            "He asks for the mean number of carrots eaten, but this time, he wants " +
            "some additional accuracy information to build his intuition.\n")
        PrintF("\nPrivacy budget remaining: %.2f\n", reporter.privacyBudget())
        PrintF("True mean: %.2f\n", reporter.mean())

        let mean_status = reporter.privateMean(0.25)
        if (!mean_status.ok()) {
            // note we must use %@ not %s because %s is for c strings
            PrintF("Error obtaining mean: %@ - %@\n", mean_status.status().message());
          PrintF(
              "The animals were not able to get the private mean with the current " +
              "privacy parameters. This is due to the small size of the dataset and " +
              "random chance. Please re-run report_the_carrots to try again.\n")
        } else {
            if let mean_output = mean_status.value(),
               let report = mean_output.error_report()?.bounding_report() {

                let mean = mean_output.getDouble()
                let lower_bound = report.lower_bound()
                let upper_bound = report.upper_bound()
                let num_inputs = report.num_inputs()
                let num_outside = report.num_outside()
                PrintF("DP mean output:\n%@\n", mean_output.debugString());
                PrintF(
                    "The animals help Fred interpret the results. %.2f is the DP mean. " +
                    "Since no bounds were set for  the DP mean algorithm, bounds on the " +
                    "input data were automatically determined. Most of the data fell " +
                    "between [%d, %d]. Thus, these bounds were used to determine clamping " +
                    "and global sensitivity. In addition, around %.0f input values fell " +
                    "inside of these bounds, and around %.0f inputs fell outside of these " +
                    "bounds. num_inputs and num_outside are themselves DP counts.\n",
                    mean, lower_bound, upper_bound, num_inputs, num_outside)
            }
        }


         // Query for the count with a noise confidence interval.
       PrintF(
           "\nFred wonders how many gluttons are in his zoo. How many animals ate " +
           "over 90 carrots? And how accurate is the result?\n")
       PrintF("\nPrivacy budget remaining: %.2f\n", reporter.privacyBudget())
        if let count_output = reporter.privateCount(above: 0.25, limit: 90).value(),
           let ci = count_output.error_report()?.noise_confidence_interval() {

            let count = count_output.getInt()
            let confidence_level = ci.confidence_level()
            let lower_bound = ci.lower_bound()
            let upper_bound = ci.upper_bound()
           PrintF("True count: %d\n", reporter.count(above: 90))
           PrintF("DP count output:\n%@\n", count_output.debugString())
           PrintF(
               "The animals tell Fred that %d is the DP count. [%.2f, %.2f] is the " +
               "%.2f confidence interval of the noise added to the count.\n",
               count, lower_bound, upper_bound, confidence_level)
        }

         // Query for the maximum.
         PrintF("\n'And how gluttonous is the biggest glutton of them all?' Fred " +
             "exclaims. He asks for the maximum number of carrots any animal has " +
             "eaten.\n")
         PrintF("\nPrivacy budget remaining: %.2f\n", reporter.privacyBudget())
         PrintF("True max: %d\n", reporter.max())
         if let dpmax = reporter.privateMax(0.25).value()?.getInt() {
             PrintF("DP max:   %d\n", dpmax)
         }

         // Refuse to query for the count of animals who didn't eat carrots.
         PrintF("\nFred also wonders how many animals are not eating any carrots at " +
             "all.\n")
         PrintF("\nPrivacy budget remaining: %.2f\n", reporter.privacyBudget())
         PrintF("Error querying for count: %@\n",
                reporter.privateCount(above: 0.25, limit: 0).status().message())
         PrintF("The animals notice that the privacy budget is depleted. They refuse " +
             "to answer any more of Fred's questions for risk of violating " +
             "privacy.\n")
    }

}

func PrintF(_ params: CVarArg...) -> () {
    if let format = params.first as? String {
        let args = Array(params.dropFirst())
        print(String(format: format, arguments: args))
    }
}

