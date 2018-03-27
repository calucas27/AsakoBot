#Asako:  A simple Discord Bot written in Ruby.
#Author: https://github.com/calucas27

require 'discordrb'

bot = Discordrb::Bot.new token:'YOURTOKENGOESHERE'

bot.message(content: 'Asako') do |event|
    event.respond 'Hello, my name is Asako!  Check out https://github.com/calucas27 for more cool stuff!'
end

bot.message(content: 'Asako help') do |event|
    commands = %{
        *Here's my commands! -- Mention me and I can reply back to you!*
        `Asako`: Say hello to Asako!
        `help`: Displays this list again.
        `voice`: Join the currently active voice channel and play a song.
    }
    event.respond(commands)
end

bot.message(content: 'Pi') do |event|
    event.respond "Hi, I'd like to check the status of your secure heart information transmitter."
end

bot.message(start_with: "Asako gitsearch") do |event|
    query = event.message.content
    query_split = query.split(' ')
    query_split = query_split.last
    puts query_split
    url = 'https://github.com/'
    url.concat(query_split)
    event.respond(url)
end

bot.mention do |event|
    output = `py -3 markov.py bible.txt`
    event.respond(output)
end

bot.run