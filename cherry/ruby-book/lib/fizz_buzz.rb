COUNT = 10
COUNT.times do |num|
  fizz_buzz(num+1)
end

def fizz_buzz(num)
  if num % 15 == 0
    puts "Fizz Buzz"
  elsif num % 5 == 0
    puts "Buzz"
  elsif num % 3 == 0
    puts "Fizz"
  else
    puts num.to_s
  end
end
