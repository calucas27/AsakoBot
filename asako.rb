#Asako:  A simple Discord Bot written in Ruby.
#Author: https://github.com/calucas27
require 'discordrb'

bot = Discordrb::Bot.new token:'<|Your Token Goes Here|>'

bot.message(content: 'Asako') do |event|
    event.respond 'Hello, my name is Asako!  Check out https://github.com/calucas27 for more cool stuff!'
end

bot.message(content: 'Asako help') do |event|
    commands = %{
        *Here's my commands! -- Mention me and I can reply back to you!*
        `Asako`: Say hello to Asako!
        `Asako help`: Displays this list again.
	    `Asako say`: Make Asako say something in the current channel.
	    `Asako ping`: Pong!
        `Asako gitsearch`: Search github for a given username.
        `Asako join channel`: Joins the bot to the current voice channel.
        `Asako play song`: Play's everyone's favorite CCDC cleanup song.
        `Asako leave channel`: Kills the current voice session.
    }
    event.user.pm(commands)
end

bot.message(content: 'Pi') do |event|
    event.respond "Hi, I'd like to check the status of your secure heart information transmitter."
end

bot.message(start_with: "Asako gitsearch") do |event|
    query = event.message.content
    query_split = query.split(' ').last
    url = 'https://github.com/'
    url.concat(query_split)
    event.respond(url)
end

bot.message(content: "Asako join channel") do |event|
    channel = event.user.voice_channel
    next "You're not in a voice channel!" unless channel

    bot.voice_connect(channel)
    "Connected to voice channel: #{channel.name}"
end

bot.message(content: "Asako play song") do |event|
    #if not already in voice channel
    channel = event.user.voice_channel
    next "You're not in a voice channel!" unless channel

    voice_bot = event.voice
    event.respond("Here's your music!~")
    voice_bot.play_file('epicsaxguy.mp3')

    if voice_bot.isplaying? == false
        event.respond("Your song has ended!")
        bot.voice_destroy(channel)
    end

end

bot.message(content: "Asako leave channel") do |event|
    channel = event.user.voice_channel
    next "You're not in a voice channel!" unless channel

    event.respond("That's enough music for now...")
    bot.voice_destroy(channel)
end

bot.message(start_with: "Asako say") do |event_say|
	msg = event_say.message.content
	msg = msg.split(' ')[2..-1].join(' ')
	event_say.respond(msg)
end

bot.message(content: "Asako ping") do |event|
	pingmsg = event.respond("Pong")
	pingmsg.edit("Pong! -- I answered in #{Time.now - event.timestamp} seconds!")
end

bot.mention do |event|
    output = `python3 markov.py lotrscript.txt`
    event.respond(output)
end

bot.run
