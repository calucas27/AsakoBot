import markovify
import sys

#import pyttsx3
#engine = pyttsx3.init()

success = 0
while success != 1:
    try:
        f = open(sys.argv[1], encoding="Latin-1")
        success = 1
    except:
        text = input('Feed Markov with what file: ')
        try:
            f = open(text, encoding="Latin-1")
            success = 1
        except:
            print('File name was not valid!')

text = f.read()
model = markovify.Text(text)
sentence = model.make_short_sentence(10000)
print(sentence)
#engine.say(sentence)
#engine.runAndWait()
