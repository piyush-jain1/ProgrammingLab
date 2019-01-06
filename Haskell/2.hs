-- get number of parathas using tokens
useToken :: Int -> Int -> Int
useToken token 0 = 0
useToken token z = 
    if(z>token)
        then 0
        else 1 + useToken rem z
            where rem = token-z+1


--Main function
main = do
    putStrLn "Enter x (initial amount): "
    inputx <- getLine
    putStrLn "Enter  y (price per paratha): "
    inputy <- getLine 
    putStrLn "Enter z (Number of tokens required to buy a paratha): "
    inputz <- getLine 
    let x = (read inputx :: Int)
    let y = (read inputy :: Int)
    let z = (read inputz :: Int)
    putStrLn ("Total number of parathas that can be bought is: ")
    -- get number of parathas using initial amount
    let useMoney = x `div` y
    let token = x `div` y
    print (useMoney + useToken token z)