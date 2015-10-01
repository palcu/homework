let juma lista = [ x `div` 2 | x <- lista,  x `mod` 2 == 0 ]
juma [1,2,3,4,8]

# intre [1,2,7,3,4,5,9] 2 6 => [2,3,4,5]
let intre list left right = [ x | x <-list, x>=left, x<=right ]

# pozitive [1,-1,-3,4,7,-9] => 3
# cu `length` scoti marimea unei list

let pozitive list = length [ x | x <-list, x>=0 ]

