/*
Greed is Good
Greed is a dice game played with five six-sided dice. Your mission, should you choose to accept it, is to score a throw according to these rules. You will always be given an array with five six-sided dice values.

 Three 1's => 1000 points
 Three 6's =>  600 points
 Three 5's =>  500 points
 Three 4's =>  400 points
 Three 3's =>  300 points
 Three 2's =>  200 points
 One   1   =>  100 points
 One   5   =>   50 point
A single die can only be counted once in each roll. For example, a given "5" can only count as part of a triplet (contributing to the 500 points) or as a single 50 points, but not both in the same roll.

Example scoring

 Throw       Score
 ---------   ------------------
 5 1 3 4 1   250:  50 (for the 5) + 2 * 100 (for the 1s)
 1 1 1 3 1   1100: 1000 (for three 1s) + 100 (for the other 1)
 2 4 4 5 4   450:  400 (for three 4s) + 50 (for the 5)
In some languages, it is possible to mutate the input to the function. This is something that you should never do. If you mutate the input, you will not be able to pass all the tests.
*/

//Второй вариант реализации. Попытался как-то чище код написать)))
func score(_ dice: [Int]) -> Int {
  var result: Int = 0
  print("in: \(dice)")
  for i in 1...6{
    let diceFilter: Int = dice.filter{$0==i}.count
    if i == 1 || i == 5{
      result += jackpot(diceFilter, i)
    }else{
      result += FindTreeplet(diceFilter, i)
    }
  }
  print("out: \(result)")
  return result
}

func FindTreeplet(_ diceRoll: Int,_ diceType: Int) -> Int{
  if diceRoll >= 3{
    return 100*diceType
  }  
  return 0
}

func jackpot(_ diceRoll: Int,_ diceType: Int)->Int{
  if diceRoll == 3{
    switch diceType{
      case 1:
        return 1000
      case 5:
        return 500
      default:
        return 0
    }
  }else if diceRoll < 3{
    switch diceType{
      case 1:
        return 100*diceRoll
      case 5:
        return 50*diceRoll
      default:
        return 0
      }
  }else if diceRoll > 3{
    switch diceType{
      case 1: 
        return 1000 + (100*(diceRoll-3))
      case 5:
        return 500 + (50*(diceRoll-3))
      default: return 0
      }
  }
  
  return 0
}
//Первый вариант который сразу пришел в голову.
func score(_ dice: [Int]) -> Int {
  var result = 0
  var oneDFilter = dice.filter{$0==1}
  
  if oneDFilter.count == 3{
     result += 1000
  }else if oneDFilter.count < 3{
     result += 100*oneDFilter.count
  }else if oneDFilter.count > 3{
     result = (result + 1000) + (100*(oneDFilter.count-3))
  }
  
  oneDFilter = dice.filter{$0==5}
  if oneDFilter.count == 3{
     result += 500
  }else if oneDFilter.count < 3{
     result += 50*oneDFilter.count
  }else if oneDFilter.count > 3{
      result = (result + 500) + (50*(oneDFilter.count-3))
  }
  
  oneDFilter = dice.filter{$0==2}
  if oneDFilter.count >= 3{result += 200}
  oneDFilter = dice.filter{$0==3}
  if oneDFilter.count >= 3{result += 300}
  oneDFilter = dice.filter{$0==4}
  if oneDFilter.count >= 3{result += 400}
  oneDFilter = dice.filter{$0==6}
  if oneDFilter.count >= 3{result += 600}
  
  print(result)
  
  return result
}