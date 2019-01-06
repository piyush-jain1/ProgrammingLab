import Data.Char

-- get int mapping of char: [a,b,c,...] - [1,2,3,...]
replace :: Char -> Int
replace c = ord c - ord 'a' + 1

-- get number of operations
pal :: String -> Int
pal s = a where 
 n = length s
 b = if n > 1
      then if replace(s !! 0) < replace(s !! (n-1)) 
            then replace(s !! (n-1)) - replace(s !! 0) 
            else replace(s !! 0) - replace(s !! (n-1)) 
      else 0
 c = if n > 3
      then if replace(s !! 1) < replace(s !! (n-2)) 
            then replace(s !! (n-2)) - replace(s !! 1) 
            else replace(s !! 1) - replace(s !! (n-2)) 
      else 0

 a = b + c

main = do
 putStrLn "Enter string: "
 x <- getLine
 print(pal(x))