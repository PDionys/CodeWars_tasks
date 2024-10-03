/*
Common Denominators
Common denominators

You will have a list of rationals in the form

{ {numer_1, denom_1} , ... {numer_n, denom_n} } 
or
[ [numer_1, denom_1] , ... [numer_n, denom_n] ] 
or
[ (numer_1, denom_1) , ... (numer_n, denom_n) ] 
where all numbers are positive ints. You have to produce a result in the form:

(N_1, D) ... (N_n, D) 
or
[ [N_1, D] ... [N_n, D] ] 
or
[ (N_1', D) , ... (N_n, D) ] 
or
{{N_1, D} ... {N_n, D}} 
or
"(N_1, D) ... (N_n, D)"
depending on the language (See Example tests) in which D is as small as possible and

N_1/D == numer_1/denom_1 ... N_n/D == numer_n,/denom_n.
Example:
convertFracs [(1, 2), (1, 3), (1, 4)] `shouldBe` [(6, 12), (4, 12), (3, 12)]
Note:
Due to the fact that the first translations were written long ago - more than 6 years - these first translations have only irreducible fractions.

Newer translations have some reducible fractions. To be on the safe side it is better to do a bit more work by simplifying fractions even if they don't have to be.

Note for Bash:
input is a string, e.g "2,4,2,6,2,8" output is then "6 12 4 12 3 12"
*/

//В данном задании не смог пройти глобальные тесты, маленький тест был пройден. С результатами не согласен.
func convertFracts(_ l: [(Int, Int)]) -> [(Int, Int)] {
  var previousNumber: Int = 0
  var currentNumber: Int
  var lcd: Int = 0
  let preProcesedArray = PreProcesing(l)
//   print(l)
  print("in: \(preProcesedArray)")
  for element in preProcesedArray{
    if previousNumber == 0{
      previousNumber = element.1
      continue
    }else{
      currentNumber = element.1
      lcd = LCD((previousNumber, currentNumber))
      previousNumber = lcd
    }
  }

  var resultArray: [(Int, Int)] = []
  for element in preProcesedArray{
    let numerator = (element.0*lcd)/element.1
    resultArray.append((numerator, lcd))
  }
  
  print("out: \(resultArray)")
  return resultArray
}

func GCF(_ twoNumbers: (Int, Int)) -> Int{
  var firstNumber = twoNumbers.0
  var secondNumber = twoNumbers.1
  while true{
    let gsf = firstNumber % secondNumber
    if gsf == 0{
      break
    }
    firstNumber = secondNumber
    secondNumber = gsf
  }

  return secondNumber
}

func LCD(_ twoNumbers: (Int, Int)) -> Int{
  let firstNumber = twoNumbers.0
  let secondNumber = twoNumbers.1
  let lcd = abs(firstNumber*secondNumber)/GCF(twoNumbers)

  return lcd
}

func PreProcesing(_ l: [(Int, Int)]) -> [(Int, Int)]{
  var resultArray: [(Int, Int)] = []
  for ele in l{
    var first = ele.0
    var second = ele.1
    while true{
      if first % 10 == 0 && second % 10 == 0{
        first = first / 10
        second = second / 10
      }else{break}
    }
    resultArray.append((first, second))
  }

  return resultArray
}