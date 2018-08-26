import Chess.Fen

main = do
    putStrLn "Enter a FEN"
    fen <- getLine
    putStrLn $ show (parseFEN fen)