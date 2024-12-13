import System.IO
import Numeric

blink :: [Int] -> [Int]
blink [] = []
blink (0:xs) = 1 : blink xs
blink (x:xs) = let len = 1 + floor (logBase 10 (fromIntegral x)) in
    if even len then
        div x (10 ^ div len 2) : rem x (10 ^ div len 2) : blink xs
    else
        x * 2024 : blink xs

main = do
    inputFile <- readFile "inputs/day11.txt"
    let stones = map read $ words inputFile
    let blinks = iterate blink stones
    print $ length $ blinks !! 25
    print $ length $ blinks !! 75