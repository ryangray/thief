# Thief game by Ryan Gray

This is from April 1990 when I'd revisited the 2068 for making some new programs
even though I had gone through my PCjr and my 286 was a few years old. This 
game is pretty simple as it is just you against the clock going around a 
platform level of ladders, overhead bars and digging to collect the treasure.

This may sound familiar since I was basically jealous of some of the games that
my friends had on their Apple IIs and Ataris back when I first had the Timex, 
but I never had tried to make a game of any signifigance. So, years later when I
was playing with my old machines again, I decided to try to make one. This is
then heavily influenced by Lode Runner, but I greatly simplified it since I was
writing it in BASIC. I was also trying to learn more machine coding at the time
to eventually help improve the games, but I never got around to doing that.

It has a level editor that you can use to make your own levels since I had to 
make them myself anyway. These are loaded as character arrays of data. Since I 
used a monochrome composite monitor, I didn't make the game have color at first
other than the splash screen and the word "TIME" on the main screen. I probably
would have gone back and made color elements. 

When I recovered the program from my old tapes in 2022, I was so happy. Then,
I saw a bug on the load screen where it told you to collect the treasures, and
the graphic was a "J", indicating the UDGs had not been initialized yet. Then,
like with my [QuickFont][] program, I immediately wanted to fix the bug, and
that led to starting to improve the game.

[QuickFont]: https://github.com/ryangray/quickfont

After working on it some more, I came across articles that talked about the
"DEFADD trick", and I added it to be able to finally make a color version since
the overhead of setting the color was too slow before. I also used it to speed
up saving and restoring a copy of the level. I also applied some other
improvements to speed up the game play.

## Game Play

You play against the clock on each level, which gives you an amount of time 
based on the number of treasures to collect on each level. You can move and
climb around. Falling won't kill you. In fact, the only things that will are
the time running out before collecting all the treasures and pressing `d` when
you get stuck to start again. You get points for each treasure, and you get a
bonus for the time remaining when you complete a level. You can press `x` and
`c` to jump up and over one space to perhaps get out of a hole.

There are ladders and overhead bars that you can use to climb. You can jump off
them by moving down. There are some fake bricks that you can move or fall 
through which look just like normal bricks.

To get to some treasures, you have to dig down (`n` and `m`) keys. You need to
think about how many spaces to dig at the top level first before jumping down 
since you can only dig the space to your left or right, so you need at least two
spaces to jump down into. The exception would be if the treasure were the last 
one on the level, you could jump down into the single-space pit it resides in.
You can also fill in holes you've dug using the same keys. There are some rules
about where you can and can't dig or fill.

You can choose key help and game help from the main screen to learn more. The
Timex joystick is also supported for the left port.


## Keys

The keys (which the program neglects to tell you) are:

    a - move up
    z - move down/drop
    k - move left
    l - move right
    n - dig/fill left
    m - dig/fill right
    c - jump left
    x - jump right
    d - die (when you get trapped)

You can also press `d` to simply move to the next level or redo the current
level, but at the cost of one life.

## Levels

1. CASTLE
2. unknown (can't recover from the tape yet)
3. VAULT
4. BIG ROOM
5. BASEMENT
6. KING'S DEN


## Level Editor

When the program starts, you can choose to edit a level which takes you to the
level edit screen. You can use keys to lay down elements to build a level and
save it to tape. You can also load an existing level from tape to start with.

### Level Editor Keys

    a - move up
    z - move down
    k - move left
    l - move right
    1 - Place textured brick
    2 - Place fake brick (sppears different in editor)
    3 - Place passage brick
    4 - Place solid brick
    5 - Place ladder
    6 - Place overhead bar
    7 - Place treasure
    8 - Set player start location 
    space - Clear cell
    g - Get (load) a level
    s - Save a level
    x - Exit without save (can play and go back to editing)
    n - Set level name

After saving the level, it will ask if you want to edit another. If you don't,
then it asks if you want to play the level. It doesn't let you go back to 
editing after that though.

### Level Data Storage

The level is stored as a string array, `a$`, with dimensions of 43 rows and 32
columns. Row 22 is where level info is stored, and rows 23 through 43 are the
color info for the cells.
