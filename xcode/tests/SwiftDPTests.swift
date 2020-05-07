//
//  SwiftDPTests.swift
//  SwiftDP
//
//  Created by Madhava Jay on 6/5/20.
//

import XCTest

class SwiftDPTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCarrots() throws {
        // create a carrot reporter
        let carrotData: [String: NSNumber] = ["Aardvark": 1, "Albatross": 88, "Alligator": 35, "Alpaca": 99, "Ant": 69, "Anteater": 14, "Antelope": 77, "Ape": 53, "Armadillo": 94, "Baboon": 67, "Badger": 92, "Barracuda": 87, "Bat": 70, "Bear": 31, "Beaver": 14, "Bee": 14, "Bison": 61, "Boar": 57, "Buffalo": 68, "Butterfly": 13, "Camel": 21, "Caribou": 38, "Cat": 92, "Caterpillar": 39, "Cattle": 46, "Chamois": 36, "Cheetah": 23, "Chicken": 76, "Chimpanzee": 8, "Chinchilla": 69, "Chough": 35, "Clam": 83, "Capybara": 40, "Cobra": 74, "Cockroach": 17, "Cod": 77, "Cormorant": 52, "Coyote": 31, "Crab": 14, "Crane": 40, "Crocodile": 46, "Crow": 99, "Curlew": 44, "Deer": 15, "Dinosaur": 89, "Dog": 36, "Dogfish": 98, "Dolphin": 20, "Donkey": 56, "Dove": 90, "Dragonfly": 5, "Duck": 75, "Dugong": 56, "Eagle": 23, "Echidna": 49, "Eel": 83, "Elephant": 55, "Elk": 22, "Emu": 7, "Falcon": 16, "Ferret": 91, "Finch": 80, "Fish": 21, "Flamingo": 56, "Fly": 10, "Fox": 28, "Frog": 29, "Gazelle": 19, "Gerbil": 73, "Giraffe": 45, "Gnat": 5, "Goat": 20, "Goldfinch": 28, "Goldfish": 45, "Goose": 39, "Gorilla": 64, "Grasshopper": 22, "Gull": 7, "Hamster": 30, "Hare": 10, "Hawk": 48, "Hedgehog": 60, "Heron": 73, "Herring": 82, "Hippopotamus": 96, "Hornet": 82, "Horse": 38, "Hummingbird": 84, "Hyena": 39, "Jackal": 12, "Jaguar": 75, "Jay": 75, "Kangaroo": 45, "Koala": 87, "Lark": 91, "Lemur": 33, "Leopard": 40, "Lion": 0, "Llama": 67, "Lobster": 63, "Locust": 16, "Mallard": 93, "Manatee": 19, "Marten": 72, "Meerkat": 46, "Mole": 73, "Monkey": 98, "Moose": 86, "Mosquito": 3, "Mouse": 64, "Mule": 94, "Narwhal": 75, "Newt": 2, "Nightingale": 87, "Octopus": 74, "Opossum": 79, "Ostrich": 56, "Otter": 51, "Owl": 77, "Ox": 81, "Oyster": 42, "Panther": 90, "Parrot": 96, "Peafowl": 4, "Pelican": 58, "Penguin": 73, "Pheasant": 27, "Pig": 56, "Pigeon": 80, "Porcupine": 10, "Porpoise": 35, "Quail": 86, "Rabbit": 100, "Raccoon": 16, "Rail": 7, "Ram": 30, "Rat": 84, "Raven": 50, "Rhinoceros": 86, "Salamander": 21, "Salmon": 15, "Sardine": 66, "Scorpion": 75, "Seahorse": 71, "Seal": 56, "Shark": 52, "Sheep": 99, "Shrew": 45, "Shrimp": 84, "Skunk": 99, "Snail": 51, "Snake": 37, "Spider": 96, "Squid": 90, "Squirrel": 92, "Starling": 80, "Stingray": 96, "Stinkbug": 31, "Stork": 39, "Swallow": 2, "Swan": 68, "Tapir": 53, "Tiger": 47, "Toad": 82, "Trout": 51, "Turkey": 57, "Turtle": 10, "Viper": 28, "Vulture": 91, "Walrus": 94, "Wasp": 51, "Weasel": 20, "Whale": 87, "Wolf": 81, "Wolverine": 36, "Wombat": 84, "Woodcock": 54, "Woodpecker": 7, "Worm": 42, "Wren": 55, "Yak": 60, "Zebra": 7]

        PrintF("\nIt is a new day. Farmer Fred is ready to ask the animals about their " +
            "carrot consumption.\n")

        let defaultEpsilon =  log2(3.0)
        let epsilon = defaultEpsilon * 4
        let reporter = OCDPCarrotReporter(epsilon: epsilon, andData: carrotData)

        // Query for the total number of carrots. Notice that we explicitly use 25% of
        // our privacy budget.
        let privacyBudget1 = reporter.privacyBudget()
        PrintF("\nFarmer Fred asks the animals how many total carrots they have " +
            "eaten. The animals know the true sum but report the " +
            "differentially private sum to Farmer Fred. But first, they ensure " +
            "that Farmer Fred still has privacy budget left.\n")
        PrintF("\nPrivacy budget remaining: %.2f\n", privacyBudget1)
        XCTAssertEqual(privacyBudget1, 1.0)
        let trueSum = reporter.sum()
        XCTAssertEqual(trueSum, 9649)

        PrintF("True sum: %d\n", trueSum)
        var dpSumCompare: Int32 = 0
        if let dpsum = reporter.privateSum(0.25).value()?.getInt() {
            PrintF("DP sum:   %d\n", dpsum)
            dpSumCompare = dpsum
        }
        XCTAssertGreaterThan(dpSumCompare, 9300)
        XCTAssertLessThan(dpSumCompare, 9900)

        let privacyBudget2 = reporter.privacyBudget()
        PrintF("\nFarmer Fred catches on that the animals are giving him DP results. " +
            "He asks for the mean number of carrots eaten, but this time, he wants " +
            "some additional accuracy information to build his intuition.\n")
        PrintF("\nPrivacy budget remaining: %.2f\n", privacyBudget2)
        XCTAssertEqual(privacyBudget2, 0.75)

        let trueMean = reporter.mean()
        PrintF("True mean: %.2f\n", trueMean)
        XCTAssertEqual(trueMean, 53.02, accuracy: 0.01)

        let mean_status = reporter.privateMean(0.25)

        if !mean_status.ok() {
            // note we must use %@ not %s because %s is for c strings
            PrintF("Error obtaining mean: %@ - %@\n", mean_status.status().message())
          PrintF(
              "The animals were not able to get the private mean with the current " +
              "privacy parameters. This is due to the small size of the dataset and " +
              "random chance. Please re-run report_the_carrots to try again.\n")
        } else {
            XCTAssertEqual(mean_status.status().code(), DPStatus.statuskOk)
            if let mean_output = mean_status.value(),
               let report = mean_output.error_report()?.bounding_report() {

                let mean = mean_output.getDouble()
                XCTAssertEqual(mean, 60.00, accuracy: 10.0)
                let lower_bound = report.lower_bound()
                XCTAssertEqual(lower_bound, 32)
                let upper_bound = report.upper_bound()
                XCTAssertEqual(upper_bound, 128)
                let num_inputs = report.num_inputs()
                XCTAssertEqual(num_inputs, 176, accuracy: 50)
                let num_outside = report.num_outside()
                XCTAssertEqual(num_outside, 46, accuracy: 50)
                PrintF("DP mean output:\n%@\n", mean_output.debugString())
                PrintF(
                    "The animals help Fred interpret the results. %.2f is the DP mean. " +
                    "Since no bounds were set for  the DP mean algorithm, bounds on the " +
                    "input data were automatically determined. Most of the data fell " +
                    "between [%d, %d]. Thus, these bounds were used to determine clamping " +
                    "and global sensitivity. In addition, around %.0f input values fell " +
                    "inside of these bounds, and around %.0f inputs fell outside of these " +
                    "bounds. num_inputs and num_outside are themselves DP counts.\n",
                    mean, lower_bound, upper_bound, num_inputs, num_outside)
            } else {
                XCTFail("Unable to unpack Mean Status and Bounding Report")
            }
        }

         // Query for the count with a noise confidence interval.
       let privacyBudget3 = reporter.privacyBudget()
       PrintF(
           "\nFred wonders how many gluttons are in his zoo. How many animals ate " +
           "over 90 carrots? And how accurate is the result?\n")
       PrintF("\nPrivacy budget remaining: %.2f\n", privacyBudget3)
        XCTAssertEqual(privacyBudget3, 0.5)
        if let count_output = reporter.privateCount(above: 0.25, limit: 90).value(),
           let ci = count_output.error_report()?.noise_confidence_interval() {

            let count = count_output.getInt()
            XCTAssertLessThan(count - 20, 5)
            let confidence_level = ci.confidence_level()
            XCTAssertEqual(confidence_level, 0.95)
            let lower_bound = ci.lower_bound()
            let range = 2.0
            XCTAssertEqual(lower_bound, range * -1, accuracy: 0.2)
            let upper_bound = ci.upper_bound()
            XCTAssertEqual(upper_bound, range, accuracy: 1.0)
           PrintF("True count: %d\n", reporter.count(above: 90))
           PrintF("DP count output:\n%@\n", count_output.debugString())
           PrintF(
               "The animals tell Fred that %d is the DP count. [%.2f, %.2f] is the " +
               "%.2f confidence interval of the noise added to the count.\n",
               count, lower_bound, upper_bound, confidence_level)
        } else {
            XCTFail("Unable to unpack Private Count and Noise Confidence Interval")
        }

         // Query for the maximum.
        let privacyBudget4 = reporter.privacyBudget()
        let max2 = reporter.max()
         PrintF("\n'And how gluttonous is the biggest glutton of them all?' Fred " +
             "exclaims. He asks for the maximum number of carrots any animal has " +
             "eaten.\n")
         PrintF("\nPrivacy budget remaining: %.2f\n", privacyBudget4)
         PrintF("True max: %d\n", max2)
         XCTAssertEqual(privacyBudget4, 0.25)
         XCTAssertEqual(max2, 100)
         if let dpmax = reporter.privateMax(0.25).value()?.getInt() {
             PrintF("DP max:   %d\n", dpmax)
             XCTAssertLessThan(abs(dpmax - 100), 30)
         }

         // Refuse to query for the count of animals who didn't eat carrots.
         let privacyBudget5 = reporter.privacyBudget()
         PrintF("\nFred also wonders how many animals are not eating any carrots at " +
             "all.\n")
         PrintF("\nPrivacy budget remaining: %.2f\n", privacyBudget5)
         XCTAssertEqual(privacyBudget5, 0.0)
         let status = reporter.privateCount(above: 0.25, limit: 0).status()
         XCTAssertEqual(status.code(), DPStatus.statuskInvalidArgument)
         PrintF("Error querying for count: %@\n", status.message())
         PrintF("The animals notice that the privacy budget is depleted. They refuse " +
             "to answer any more of Fred's questions for risk of violating " +
             "privacy.\n")
    }
}

func PrintF(_ params: CVarArg...) {
    if let format = params.first as? String {
        let args = Array(params.dropFirst())
        print(String(format: format, arguments: args))
    }
}
