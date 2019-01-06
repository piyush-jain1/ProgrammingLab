-- given smallest and largest dimension, get all possible dimensions 
getAll l h = 
 if (fst l == fst h) 
  then getAll2 l h
   else getAll2 l h ++ getAll lnew h
    where lnew = (fst l + 1, snd l) 

getAll2 l h = 
 if (snd l == snd h)
  then [l]
   else l:getAll2 lnew h
    where lnew = (fst l, snd l + 1)

-- find catesian products forming 2-tuple with dimensions of (bedroom, hall)
cartProd2 xs ys = [(x,y) | x <- xs, y <- ys]
-- find catesian products forming 3-tuple with dimensions of (bedroom, hall, kitchen)
cartProd3 xs ys = [(a, b, y) | (a,b) <- xs, y <- ys]
-- find catesian products forming 4-tuple with dimensions of (bedroom, hall, kitchen, bathroom)
cartProd4 xs ys = [(a, b, c, y) | (a,b,c) <- xs, y <- ys]
-- find catesian products forming 5-tuple with dimensions of (bedroom, hall, kitchen, bathroom, garden)
cartProd5 xs ys = [(a, b, c, d, y) | (a,b,c,d) <- xs, y <- ys]
-- find catesian products forming 6-tuple with dimensions of (bedroom, hall, kitchen, bathroom, garden, balcony)
cartProd6 xs ys = [(a, b, c, d, e, y) | (a,b,c,d,e) <- xs, y <- ys]

-- remove duplicate area dimensions from the list of 2-tuples
removeDuplicates2 list p q = remDups2 list [] p q
remDups2 [] _ _ _= []
remDups2 ((a,b):xs) list2 p q
    | (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q))  `elem` list2) = remDups2 xs list2 p q
    | otherwise = (a,b) : remDups2 xs (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)):list2) p q

-- remove duplicate area dimensions from the list of 3-tuples
removeDuplicates3 list p q r = remDups3 list [] p q r
remDups3 [] _ _ _ _= []
remDups3 ((a,b,c):xs) list2 p q r
    | (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r))  `elem` list2) = remDups3 xs list2 p q r
    | otherwise = (a,b,c) : remDups3 xs (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)):list2) p q r

-- remove duplicate area dimensions from the list of 4-tuples
removeDuplicates4 list p q r s = remDups4 list [] p q r s
remDups4 [] _ _ _ _ _= []
remDups4 ((a,b,c,d):xs) list2 p q r s
    | (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)+(fst(d)*snd(d)*s))  `elem` list2) = remDups4 xs list2 p q r s
    | otherwise = (a,b,c,d) : remDups4 xs (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)+(fst(d)*snd(d)*s)):list2) p q r s

-- remove duplicate area dimensions from the list of 5-tuples
removeDuplicates5 list p q r s t = remDups5 list [] p q r s t
remDups5 [] _ _ _ _ _ _= []
remDups5 ((a,b,c,d,e):xs) list2 p q r s t
    | (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)+(fst(d)*snd(d)*s)+(fst(e)*snd(e)*t))  `elem` list2) = remDups5 xs list2 p q r s t
    | otherwise = (a,b,c,d,e) : remDups5 xs (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)+(fst(d)*snd(d)*s)+(fst(e)*snd(e)*t)):list2) p q r s t
    
-- remove duplicate area dimensions from the list of 6-tuples
removeDuplicates6 list p q r s t u = remDups6 list [] p q r s t u
remDups6 [] _ _ _ _ _ _ _= []
remDups6 ((a,b,c,d,e,f):xs) list2 p q r s t u
    | (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)+(fst(d)*snd(d)*s)+(fst(e)*snd(e)*t)+(fst(f)*snd(f)*u))  `elem` list2) = remDups6 xs list2 p q r s t u
    | otherwise = (a,b,c,d,e,f) : remDups6 xs (((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)+(fst(d)*snd(d)*s)+(fst(e)*snd(e)*t)+(fst(f)*snd(f)*u)):list2) p q r s t u

-- get maximum area possible
getAns list p q r s t u= getMaxArea list p q r s t u
getMaxArea [] _ _ _ _ _ _= 0
getMaxArea ((a,b,c,d,e,f):xs) p q r s t u = maximum [((fst(a)*snd(a)*p)+(fst(b)*snd(b)*q)+(fst(c)*snd(c)*r)+(fst(d)*snd(d)*s)+(fst(e)*snd(e)*t)+(fst(f)*snd(f)*u)):: Integer, getMaxArea(xs) p q r s t u]
 
--Main function
main = do
 let bedroom = getAll (10,10) (15,15)
 let hall = getAll (15,10) (20,15)
 let kitchen = getAll (7,5) (15,13)
 let bathroom = getAll (4,5) (8,9)
 let garden = getAll (10,10) (20,20)
 let balcony = getAll (5,5) (10,10)
 putStrLn "Enter total area: "
 inputx <- getLine
 let area = (read inputx :: Integer)
 putStrLn "Enter number of bedrooms: "
 inputy <- getLine
 let count_bedroom = (read inputy :: Integer)
 putStrLn "Enter number of halls: "
 inputz <- getLine
 let count_hall = (read inputz :: Integer)
 let count_kitchen = ceiling(fromIntegral count_bedroom/3) :: Integer
 let count_bathroom = count_bedroom + 1
 let count_garden = 1
 let count_balcony = 1

 -- (bedroom, hall)
 let l1 = removeDuplicates2 (filter (\(a,b) -> ((fst(a)*snd(a)*count_bedroom) 
                               + (fst(b)*snd(b))*count_hall) <= area) 
                               (cartProd2 bedroom hall)) count_bedroom count_hall
 
 -- (bedroom, hall, kitchen)
 let l2 = removeDuplicates3 (filter (\(a,b,c) ->                            -- remove duplicate areas
                               (((fst(a)*snd(a)*count_bedroom)              -- area occupied by bedroom
                               + (fst(b)*snd(b)*count_hall)                 -- area occupied by halls
                               + (fst(c)*snd(c)*count_kitchen))             -- area occupied by kitchens
                               <= area)                                     -- sum should be less than equal to given area  
                               && (fst(c) <= fst(a) && fst(c) <= fst(b)     -- length of kitchen must not be larger than that of bedroom and hall
                               && snd(c) <= snd(a) && snd(c) <= snd(b)))    -- breadth of kitchen must not be larger than that of bedroom and hall 
                               (cartProd3 l1 kitchen))                      -- catesian product of dimensions
                               count_bedroom count_hall count_kitchen    
 -- (bedroom, hall, kitchen, bathroom)
 let l3 = removeDuplicates4 (filter (\(a,b,c,d) ->                          -- remove duplicate areas
                               (((fst(a)*snd(a)*count_bedroom)              -- area occupied by bedroom             
                               + (fst(b)*snd(b)*count_hall)                 -- area occupied by halls
                               + (fst(c)*snd(c)*count_kitchen)              -- area occupied by kitchens
                               + (fst(d)*snd(d)*count_bathroom))            -- area occupied by bathrooms
                               <= area)                                     -- sum should be less than equal to given area  
                               && (fst(d) <= fst(c) && snd(d) <= snd(c)))   -- dimension of bathroom must not be larger than that of kitchen
                               (cartProd4 l2 bathroom))                     -- catesian product of dimensions  
                               count_bedroom count_hall count_kitchen count_bathroom  

 -- (bedroom, hall, kitchen, bathroom, garden)
 let l4 = removeDuplicates5 (filter (\(a,b,c,d,e) ->                        -- remove duplicate areas
                               (((fst(a)*snd(a)*count_bedroom)              -- area occupied by bedroom             
                               + (fst(b)*snd(b)*count_hall)                 -- area occupied by halls
                               + (fst(c)*snd(c)*count_kitchen)              -- area occupied by kitchens
                               + (fst(d)*snd(d)*count_bathroom)             -- area occupied by bathrooms
                               + (fst(e)*snd(e)*count_garden))              -- area occupied by garden
                               <= area))                                    -- sum should be less than equal to given area  
                               (cartProd5 l3 garden))                       -- catesian product of dimensions 
                               count_bedroom count_hall count_kitchen count_bathroom count_garden    

 -- (bedroom, hall, kitchen, bathroom, garden, balcony)
 let l5 = removeDuplicates6 (filter (\(a,b,c,d,e,f) -> 
                               (((fst(a)*snd(a)*count_bedroom)              -- area occupied by bedroom             
                               + (fst(b)*snd(b)*count_hall)                 -- area occupied by halls
                               + (fst(c)*snd(c)*count_kitchen)              -- area occupied by kitchens
                               + (fst(d)*snd(d)*count_bathroom)             -- area occupied by bathrooms
                               + (fst(e)*snd(e)*count_garden)               -- area occupied by garden
                               + (fst(f)*snd(f)*count_balcony))             -- area occupied by balcony
                               <= area))                                    -- sum should be less than equal to given area  
                               (cartProd6 l4 balcony)) count_bedroom count_hall count_kitchen count_bathroom count_garden count_balcony   -- remove duplicate areas
 

 -- calculate max area possible
 let maxArea = getAns l5 count_bedroom count_hall count_kitchen count_bathroom count_garden count_balcony
 -- get the dimensions with maximum area
 let result = filter (\(a,b,c,d,e,f) ->                                     
                               ((fst(a)*snd(a)*count_bedroom)               
                               + (fst(b)*snd(b)*count_hall)                 
                               + (fst(c)*snd(c)*count_kitchen) 
                               + (fst(d)*snd(d)*count_bathroom) 
                               + (fst(e)*snd(e)*count_garden)
                               + (fst(f)*snd(f)*count_balcony)       
                               == maxArea)) l5

 -- print result
 if (length result == 0)
  then putStrLn $ "No design possible for the given constraints"
   else do 
    let (a,b,c,d,e,f) = result !! 0
    putStrLn $ "Bedroom: " ++ show (count_bedroom) ++ " " ++ show a
    putStrLn $ "Hall: " ++ show (count_hall) ++ " " ++ show b
    putStrLn $ "Kitchen: " ++ show (count_kitchen) ++ " " ++ show c
    putStrLn $ "Bathroom: " ++ show (count_bathroom) ++ " " ++ show d
    putStrLn $ "Garden: " ++ show (count_garden) ++ " " ++ show e
    putStrLn $ "Balcony: " ++ show (count_balcony) ++ " " ++ show f
    putStrLn $ "Unused Space: " ++ show (area-maxArea)
