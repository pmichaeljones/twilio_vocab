# Twilio Vocabulary-Building Application
---
### How It Works
1. User signs up by texting a "starting word" to a Twilio number. Most likely "vocab" but not sure yet.
2. User gets a profile page using phone number app-name-here.com/5553334444.
3. User texts unknown word to Twilio number, app verfies user phone number, makes API call to dictionary API site and saves definition(s) to user's page.
4. User can log into page and study words that they didn't know the day before.
5. User can erase profile by sending a "delete profile" keyword(yet to be determined).

### Trying to stay away from being just a straight Rails developer who has forgetten other technologies, I've decided to build this using Sinatra and ActiveRecord. It's so simple to just run rails new project_name but I think it will be good experience for me to build another sinatra app.
