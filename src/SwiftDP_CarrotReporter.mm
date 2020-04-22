//
//  SwiftDP_CarrotReporter.mm
//  Dummy
//
//  Created by Madhava Jay on 20/4/20.
//

#import <Foundation/Foundation.h>
#import "SwiftDP_CarrotReporter.h"
#import "DPUtil.mm"
#include <string>
#include <map>

//#import "differential_privacy/algorithms/bounded-sum.h"

// class extension to hold iVars for PIMPL
@interface SwiftDP_CarrotReporter () {
  std::map<std::string, int> carrots_per_animal_;
  double epsilon_;
  double privacy_budget_;
}
+ (std::map<std::string, int>) createData; // only for private usage
@end

@implementation SwiftDP_CarrotReporter

- (nonnull instancetype) init {
    return [self initWithEpsilon:1]; // default value of epsilon
}

- (nonnull instancetype) initWithEpsilon: (double) epsilon {
    self = [super init];
    if (self) {
      // Start PIMPL
        self->epsilon_ = epsilon;
        self->carrots_per_animal_ = [SwiftDP_CarrotReporter createData];
      // End PIMPL
    }
    return self;
}
- (NSDictionary*) getCarrotsData {
    return DPUtil::convertToDictionary(carrots_per_animal_);
}

- (void) setCarrotsData: (NSDictionary *) carrotsAnimal {
    self->carrots_per_animal_ = DPUtil::convertFromDictionary(carrotsAnimal);
}

- (int) Sum {
  int sum = 0;
  for (const auto& pair : self->carrots_per_animal_) {
    sum += pair.second;
  }
  return sum;
}

// True mean of carrots eaten.
- (double) Mean {
  return static_cast<double>([self Sum]) / self->carrots_per_animal_.size();
}

- (int) CountAbove: (int) limit {
      int count = 0;
      for (const auto& pair : self->carrots_per_animal_) {
        if (pair.second > limit) {
          ++count;
        }
      }
      return count;
}

// True maximum of the number of carrots eaten by any one animal.
- (int) Max {
  int max = 0;
  for (const auto& pair : carrots_per_animal_) {
    max = std::max(pair.second, max);
  }
  return max;
}

// Returns the remaining privacy budget. Animals should check this to see if
// they should answer any more of Farmer Fred's questions.
- (double) PrivacyBudget { return self->privacy_budget_; }

- (void) PrivateSum {

    // base::StatusOr<Output>
    double privacy_budget = 0.5;

    if (privacy_budget_ < privacy_budget) {
        //return base::InvalidArgumentError("Not enough privacy budget.");
        return;
    }
    privacy_budget_ -= privacy_budget;
//    ASSIGN_OR_RETURN(std::unique_ptr<BoundedSum<int>> sum_algorithm,
//                   BoundedSum<int>::Builder()
//                       .SetEpsilon(epsilon_)
//                       .SetLower(0)
//                       .SetUpper(150)
//                       .Build());
//    for (const auto& pair : carrots_per_animal_) {
//        sum_algorithm->AddEntry(pair.second);
//    }
//    id result = sum_algorithm->PartialResult(privacy_budget);
}

@end

// category to hide the init of data from the code
@implementation SwiftDP_CarrotReporter (Fixtures)
+ (std::map<std::string, int>) createData {
    return {
    {"Aardvark",1},
    {"Albatross",88},
    {"Alligator",35},
    {"Alpaca",99},
    {"Ant",69},
    {"Anteater",14},
    {"Antelope",77},
    {"Ape",53},
    {"Armadillo",94},
    {"Baboon",67},
    {"Badger",92},
    {"Barracuda",87},
    {"Bat",70},
    {"Bear",31},
    {"Beaver",14},
    {"Bee",14},
    {"Bison",61},
    {"Boar",57},
    {"Buffalo",68},
    {"Butterfly",13},
    {"Camel",21},
    {"Caribou",38},
    {"Cat",92},
    {"Caterpillar",39},
    {"Cattle",46},
    {"Chamois",36},
    {"Cheetah",23},
    {"Chicken",76},
    {"Chimpanzee",8},
    {"Chinchilla",69},
    {"Chough",35},
    {"Clam",83},
    {"Capybara",40},
    {"Cobra",74},
    {"Cockroach",17},
    {"Cod",77},
    {"Cormorant",52},
    {"Coyote",31},
    {"Crab",14},
    {"Crane",40},
    {"Crocodile",46},
    {"Crow",99},
    {"Curlew",44},
    {"Deer",15},
    {"Dinosaur",89},
    {"Dog",36},
    {"Dogfish",98},
    {"Dolphin",20},
    {"Donkey",56},
    {"Dove",90},
    {"Dragonfly",5},
    {"Duck",75},
    {"Dugong",56},
    {"Eagle",23},
    {"Echidna",49},
    {"Eel",83},
    {"Elephant",55},
    {"Elk",22},
    {"Emu",7},
    {"Falcon",16},
    {"Ferret",91},
    {"Finch",80},
    {"Fish",21},
    {"Flamingo",56},
    {"Fly",10},
    {"Fox",28},
    {"Frog",29},
    {"Gazelle",19},
    {"Gerbil",73},
    {"Giraffe",45},
    {"Gnat",5},
    {"Goat",20},
    {"Goldfinch",28},
    {"Goldfish",45},
    {"Goose",39},
    {"Gorilla",64},
    {"Grasshopper",22},
    {"Gull",7},
    {"Hamster",30},
    {"Hare",10},
    {"Hawk",48},
    {"Hedgehog",60},
    {"Heron",73},
    {"Herring",82},
    {"Hippopotamus",96},
    {"Hornet",82},
    {"Horse",38},
    {"Hummingbird",84},
    {"Hyena",39},
    {"Jackal",12},
    {"Jaguar",75},
    {"Jay",75},
    {"Kangaroo",45},
    {"Koala",87},
    {"Lark",91},
    {"Lemur",33},
    {"Leopard",40},
    {"Lion",0},
    {"Llama",67},
    {"Lobster",63},
    {"Locust",16},
    {"Mallard",93},
    {"Manatee",19},
    {"Marten",72},
    {"Meerkat",46},
    {"Mole",73},
    {"Monkey",98},
    {"Moose",86},
    {"Mosquito",3},
    {"Mouse",64},
    {"Mule",94},
    {"Narwhal",75},
    {"Newt",2},
    {"Nightingale",87},
    {"Octopus",74},
    {"Opossum",79},
    {"Ostrich",56},
    {"Otter",51},
    {"Owl",77},
    {"Ox",81},
    {"Oyster",42},
    {"Panther",90},
    {"Parrot",96},
    {"Peafowl",4},
    {"Pelican",58},
    {"Penguin",73},
    {"Pheasant",27},
    {"Pig",56},
    {"Pigeon",80},
    {"Porcupine",10},
    {"Porpoise",35},
    {"Quail",86},
    {"Rabbit",100},
    {"Raccoon",16},
    {"Rail",7},
    {"Ram",30},
    {"Rat",84},
    {"Raven",50},
    {"Rhinoceros",86},
    {"Salamander",21},
    {"Salmon",15},
    {"Sardine",66},
    {"Scorpion",75},
    {"Seahorse",71},
    {"Seal",56},
    {"Shark",52},
    {"Sheep",99},
    {"Shrew",45},
    {"Shrimp",84},
    {"Skunk",99},
    {"Snail",51},
    {"Snake",37},
    {"Spider",96},
    {"Squid",90},
    {"Squirrel",92},
    {"Starling",80},
    {"Stingray",96},
    {"Stinkbug",31},
    {"Stork",39},
    {"Swallow",2},
    {"Swan",68},
    {"Tapir",53},
    {"Tiger",47},
    {"Toad",82},
    {"Trout",51},
    {"Turkey",57},
    {"Turtle",10},
    {"Viper",28},
    {"Vulture",91},
    {"Walrus",94},
    {"Wasp",51},
    {"Weasel",20},
    {"Whale",87},
    {"Wolf",81},
    {"Wolverine",36},
    {"Wombat",84},
    {"Woodcock",54},
    {"Woodpecker",7},
    {"Worm",42},
    {"Wren",55},
    {"Yak",60},
    {"Zebra",7}
    };
}

@end
