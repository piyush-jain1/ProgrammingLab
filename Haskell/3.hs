import Data.List

-- find a[i]-min(a) for each element of list
getAns [] m = 0
getAns (x : xs) m = x - m + getAns xs m

main = do
  putStrLn "Enter number of workers: "
  inputx <- getLine
  let x = (read inputx :: Int)
  putStrLn "Enter  salaries of workers: "
  ln <- getLine
  let ints = map read (words ln)  :: [Int]
  let m = minimum ints
  print(getAns ints m) 