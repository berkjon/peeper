bob = User.create({username: "bobbylikes", email: "bob@gmail.com"})
sam = User.create({username: "samiam", email: "sam@gmail.com"})
laura = User.create({username: "lauralovespuppies", email: "laura@gmail.com"})
jen = User.create({username: "jennyontheblock", email: "jen@gmail.com"})
alph = User.create({username: "alphie", email: "alph@gmail.com"})

bob.stalkees << sam
bob.stalkees << jen

bob.stalkers << laura
bob.stalkers << alph

bob.save!
bob.reload

Whisper.create(user_id: 2, content: "hey pretty lady")
Whisper.create(user_id: 4, content: "i love puppies!!!")
Whisper.create(user_id: 6, content: "burrito for breakfast, yum!")
Whisper.create(user_id: 3, content: "i see you")
Whisper.create(user_id: 2, content: "nice stockings")
Whisper.create(user_id: 4, content: "buying booties for my pup!")
Whisper.create(user_id: 6, content: "burrito for lunch, yea")
Whisper.create(user_id: 3, content: "whatever they say, it's not true")









