### Global day of code retreat


It was so cool. We were a rather small bunch of 10, which was great, as in the end our pairing graph was almost complete, and our discussions & reviews never got out of hand.

For those who don't exactly know what a [GDCR](http://coderetreat.org/) is supposed to be, it's day of [semi-formalized programming excercise](http://coderetreat.org/facilitating/activity-catalog). There are supposed to be about 6 sessions of pair programming, each of those about 45 minutes long. The goal of each session is to write an implementation of [Conway's game of life](http://coderetreat.org/gol). It does not sound so exciting, but GOL is not what it's about - it just gives an abstract context for learning other things. GOL is just a neat, round, reasonably simple and rewarding challenge.

The learning you are supposed to have is about communication - with words, pictures and code.
To enhance the learning, a bunch of constraints can be applied to each section.

Typical constraints include using no mouse (how comfortable are you with outr tools?), no if statements (branching is easy, but not elegant), not talking to each other (lat the code do the talking). [Here are some more](http://coderetreat.org/group/facilitators/forum/topics/what-are-some-exercises-and-constraints-that-people-use-during-se)

Use any programming language you might want to. Let your partner show you a language you are not familiar or comfortable with.

So what did I learn and reiterated?

* Testing structure might be an easier way, but tasting behavior will lead to better, leaner code.

* Naming is hard. Duh indeed.

* Scala is readable and reasonable (I have been somewhat put off by functional languages by my first (and very unprepared) encounters with Scheme (a Lisp dialect (it does look a bit like this (with all the parens (everywhere)))))

* Communicating by code only has been a nice highlight on the importance of expressiveness and storytelling in code.

* Pair programming is effective. It might not be for everybody, but it seems to be both much more effective in solving the problem at hand as well as in distributing knowledge.

Many thanks to the organizers: Matthias Baumgart, Sebastian Schmeck and Sven Hoffman and Saxonia Systems AG for facilitating.

tl;dr [let Corey Haines tell it better with words and pictures and stuff](http://coderetreat.org/about)


### An interesting constraint for GDCR: creating legacy code

Separate the pairs.

The remaining half will be told to hurry up and finish the stuff, no tests necessary. Voile instant legacy code.

The parting half will wait a while and then return to the room to 'replace' the pressured coders and work it out.

[source with more details](http://agilecoach.de/2013-12-14/creating-legacy-behavior-in-15-minutes/)

### console coloring

Though it is simple to do yourself - just issue the [ANSI control sequence](). For simple examples, see [here](http://blog.sosedoff.com/2010/06/01/making-colorized-console-output-with-ruby/) and [here](http://kpumuk.info/ruby-on-rails/colorizing-console-ruby-script-output/)

But as with so many wheels, bicycles and programming tools - Simpsons already did it.

There is a [bunch of gems](https://www.ruby-toolbox.com/categories/Terminal_Coloring)  with similar popularity on rubygems and github. Here are the most popular ones (yeah, I'm a [shoemaker's apprentice](http://english.stackexchange.com/questions/22147/etymology-of-snob) alright])

* [term-ansicolor](https://github.com/flori/term-ansicolor) - the most popular one, stable high popularity

* [ansi](https://github.com/rubyworks/ansi) - stable high popularity.

* [colored](https://github.com/defunkt/colored) - slowly rising medium popularity

* [colorize](https://github.com/fazibear/colorize) - swiftly rising, medium popularity

I'm a magpie, so I go for the new, shiny stuff first. Let's try colorize.
