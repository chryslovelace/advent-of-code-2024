import System.IO
import Numeric
import Data.Map

blinkOne :: Int -> Either Int (Int, Int)
blinkOne 0 = Left 1
blinkOne x = let len = 1 + floor (logBase 10 (fromIntegral x)) in
    if even len then
        Right (div x (10 ^ div len 2), rem x (10 ^ div len 2))
    else
        Left $ x * 2024

blinkMap :: Map Int Int -> Map Int Int
blinkMap = foldlWithKey f empty where
    f a k v = case blinkOne k of
        Left n -> insertWith (+) n v a
        Right (l, r) -> insertWith (+) l v $ insertWith (+) r v a

main = do
    inputFile <- readFile "inputs/day11.txt"
    let stones = fromList $ Prelude.map (\x-> (read x, 1)) $ words inputFile
    let blinks = iterate blinkMap stones
    let countStones = Data.Map.foldl (+) 0 
    print $ countStones $ blinks !! 25
    print $ countStones $ blinks !! 75