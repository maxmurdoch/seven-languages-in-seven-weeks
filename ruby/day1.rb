# print 'Hello, world.'
puts 'Hello, world.'

# find the index of the word 'Ruby' in the string 'Hello, Ruby'
'Hello, Ruby'.index('Ruby')

# print your name 10 times
i = 0
while i < 10
  puts 'Max'
  i = i + 1
end

# print the string 'This is sentence number 1', where the number 1 changes from 1 to 10
i = 1
while i < 11
  puts "This is sentence number #{i}"
  i = i + 1
end

# run a ruby program from a file
$ ruby ruby_day_1.rb

# bonus: write a program that picks a random number
rand_num = rand(10)
negative_phrases = ['Hell no!',
                    'Nope.',
                    'No, no, definitely not.',
                    'Are you stupid?',
                    'Dung for brains you’ve got!']
guess = 0

puts 'Guess a number between 1-10:'

while guess != rand_num
  guess = gets.to_i
  puts "#{guess}? #{negative_phrases[rand(negative_phrases.length)]} Higher!" if guess < rand_num
  puts "#{guess}? #{negative_phrases[rand(negative_phrases.length)]} Lower!" if guess > rand_num
end

puts 'Well done!'
