import Foundation
let latinArray:[Int] = [
    1000,
    500,
    100,
    50,
    10,
    5,
    1,
]

let romanDictionary:[Int:String] = [
    1000:"M",
    500:"D",
    100:"C",
    50:"L",
    10:"X",
    5:"V",
    1:"I",
]

var runCount = 0
var index = 0
var outputString = ""

func jamesBrown(input:Int) -> String{
    //break our input down into the denominations in our latinArray
    //works best while listening to http://www.youtube.com/watch?v=95Y5kRQBKo0
    runCount++
    assert(runCount < 30, "if we're looping around more than 30 times, there could be something wrong")
    assert(input<8999, "I don't think this will work well for inputs that are over 9000")
    //check our index isn't shooting above the limits of our array.
    assert(index <= latinArray.count, "index has run over the length of the latinArray")
    let denominator = latinArray[index]
    let modulus = input%denominator
    let roundedDiv = input/denominator
    let inputString = "\(input)"
    //the first digit of our input
    let inputPrefix = inputString.substringToIndex(advance(inputString.startIndex, 1))
    var thisString = ""
    //println("index: \(index), input: \(input), denominator: \(denominator), modulus: \(modulus), roundedDiv: \(roundedDiv)")
    if(roundedDiv == 0){
        if(input != 0){
            //skip over any denominators which fail to divide at least once wholey.
            index++
            jamesBrown(modulus)
        }
    }else if(inputPrefix == "4"){
        let current = find(latinArray, denominator)!
        //output one at the current order of magnitude
        outputString += romanDictionary[latinArray[current]]!
        //output one above the current order of magnitude
        outputString += romanDictionary[latinArray[current-1]]!
        if(input != 4){
            jamesBrown(input - (denominator*4))
        }
    }else if(inputPrefix == "9"){
        let current = find(latinArray, denominator)!
        //output one below the current order of magnitude
        outputString += romanDictionary[latinArray[current+1]]!
        //output one above the current order of magnitude
        outputString += romanDictionary[latinArray[current-1]]!
        if(input != 9){
            jamesBrown(input - ((denominator/5)*9))
        }
    }else{
        var x = 0
        while(x<roundedDiv){
            thisString += romanDictionary[denominator]!
            x++
        }
        outputString += thisString
        if( modulus != 0 ){
            index++
            jamesBrown(modulus)
        }
    }
    return outputString
}


func runNumber(input:Int) -> String{
    runCount = 0
    //depending on what the starting point is we start breaking things down from different points in our array of denominators
    switch input {
    case 1...3:
        index = 5
    case 4...8:
        index = 4
    case 9...39:
        index = 3
    case 40...89:
        index = 2
    case 90...899:
        index = 1
    default:
        index = 0
    }
    outputString = ""
    return jamesBrown(input)
}



//tests
func returnTest(q:Int, a:String) -> String{
    if( runNumber(q) == a ){
        return "YEP! input:\(a) output: \(runNumber(q))"
    }else{
        return "NUP! input:\(a) output: \(runNumber(q))"
    }
}

returnTest(1, "I")
returnTest(2, "II")
returnTest(3, "III")
returnTest(4, "IV")
returnTest(5, "V")
/*returnTest(6, "VI")
returnTest(7, "VII")
returnTest(8, "VIII")
returnTest(9, "IX")
returnTest(10, "X")
returnTest(11, "XI")
returnTest(12, "XII")
returnTest(13, "XIII")
returnTest(14, "XIV")
returnTest(15, "XV")
returnTest(16, "XVI")
returnTest(17, "XVII")
returnTest(18, "XVIII")
returnTest(19, "XIX")
returnTest(20, "XX")
returnTest(21, "XXI")
returnTest(22, "XXII")
returnTest(23, "XXIII")
returnTest(24, "XXIV")
returnTest(25, "XXV")
returnTest(26, "XXVI")
returnTest(27, "XXVII")
returnTest(28, "XXVIII")
returnTest(29, "XXIX")
returnTest(30, "XXX")
returnTest(31, "XXXI")
returnTest(32, "XXXII")
returnTest(33, "XXXIII")
returnTest(34, "XXXIV")
returnTest(35, "XXXV")
returnTest(36, "XXXVI")
returnTest(37, "XXXVII")
returnTest(38, "XXXVIII")
returnTest(39, "XXXIX")
returnTest(40, "XL")
returnTest(41, "XLI")
returnTest(42, "XLII")
returnTest(43, "XLIII")
returnTest(44, "XLIV")
returnTest(45, "XLV")
returnTest(46, "XLVI")
returnTest(47, "XLVII")
returnTest(48, "XLVIII")
returnTest(49, "XLIX")
returnTest(50, "L")
returnTest(51, "LI")
returnTest(52, "LII")
returnTest(53, "LIII")
returnTest(54, "LIV")
returnTest(55, "LV")
returnTest(56, "LVI")
returnTest(57, "LVII")
returnTest(58, "LVIII")
returnTest(59, "LIX")

returnTest(84, "LXXXIV")
returnTest(85, "LXXXV")
returnTest(86, "LXXXVI")
returnTest(87, "LXXXVII")
returnTest(88, "LXXXVIII")
returnTest(89, "LXXXIX")
returnTest(90, "XC")
returnTest(91, "XCI")
returnTest(92, "XCII")
returnTest(93, "XCIII")
returnTest(94, "XCIV")
returnTest(95, "XCV")
returnTest(96, "XCVI")
returnTest(97, "XCVII")
returnTest(98, "XCVIII")
returnTest(99, "XCIX")
returnTest(100, "C")
returnTest(101, "CI")
returnTest(102, "CII")
returnTest(103, "CIII")
returnTest(104, "CIV")

returnTest(388, "CCCLXXXVIII")
returnTest(389, "CCCLXXXIX")
returnTest(390, "CCCXC")
returnTest(391, "CCCXCI")
returnTest(392, "CCCXCII")
returnTest(393, "CCCXCIII")
returnTest(394, "CCCXCIV")
returnTest(395, "CCCXCV")
returnTest(396, "CCCXCVI")
returnTest(397, "CCCXCVII")
returnTest(398, "CCCXCVIII")
returnTest(399, "CCCXCIX")
returnTest(400, "CD")
returnTest(401, "CDI")
returnTest(402, "CDII")
returnTest(403, "CDIII")
returnTest(404, "CDIV")
returnTest(405, "CDV")

returnTest(888, "DCCCLXXXVIII")
returnTest(889, "DCCCLXXXIX")
returnTest(890, "DCCCXC")
returnTest(891, "DCCCXCI")
returnTest(892, "DCCCXCII")
returnTest(893, "DCCCXCIII")
returnTest(894, "DCCCXCIV")
returnTest(895, "DCCCXCV")
returnTest(896, "DCCCXCVI")
returnTest(897, "DCCCXCVII")
returnTest(898, "DCCCXCVIII")
returnTest(899, "DCCCXCIX")
returnTest(900, "CM")
returnTest(901, "CMI")
returnTest(902, "CMII")
returnTest(903, "CMIII")
returnTest(904, "CMIV")
returnTest(905, "CMV")
returnTest(906, "CMVI")
returnTest(907, "CMVII")
returnTest(908, "CMVIII")
returnTest(909, "CMIX")
returnTest(910, "CMX")
returnTest(911, "CMXI")

returnTest(3988, "MMMCMLXXXVIII")
returnTest(3989, "MMMCMLXXXIX")
returnTest(3990, "MMMCMXC")
returnTest(3991, "MMMCMXCI")
returnTest(3992, "MMMCMXCII")
returnTest(3993, "MMMCMXCIII")
returnTest(3994, "MMMCMXCIV")
returnTest(3995, "MMMCMXCV")
returnTest(3996, "MMMCMXCVI")
returnTest(3997, "MMMCMXCVII")
returnTest(3998, "MMMCMXCVIII")
returnTest(3999, "MMMCMXCIX")*/
