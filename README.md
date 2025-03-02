# Just playing with OpenSCAD

As the description for this repo notes, nothing of importance here. If I do
something that is generally useful in OpenSCAD at some point, it may start here
but I will move it into its own repo once it approaches at least Beta quality.

Some of the files are examples from the online book
[Mastering OpenSCAD](https://mastering-openscad.eu/buch/introduction/); at some
point I'll probably have variants of all the projects in that book here...but
don't sit and hit refresh...I have way too many projects going and I'm easily
distracted.

## Nameplate Stuff

Again, not important, and definitely not complete, but there are a group of
files here that are at least vaguely interesting, those with "nameplate" in
their filenames.

If you look at them without context they are probably a bit confusing. I warn
you that once you have the context, you probably don't want to join me going
down this slightly strange rabbit hole.

### So, here's the context

I build 3D printers. I probably have spent about equal amounts of time building
3D printers as I have using 3D printers to print things. As you go deeper into
building 3D printers (and somewhat designing and printing other things), you
end up needed lots of screws and other assorted bits.

Eventually, you want to sort those bits. I bought an Akro-Mills cabinet for this
purpose and initially just used a label printer to label the drawers. Decided
that I could do better and eventually replaced all the drawers with ones I've
printed that incorporate a few changes I wanted from the "stock" ones.

* Stiffer
* Printed nameplates
* Some drawers have dividers, but they are fixed
    *  the "stock" ones always seem to come loose and then your drawer contents
    get mixed up

I originally thought about color coding the drawers and you may think the ones
in the picture are somehow coded...they aren't...just whatever filament I had on
hand until I finally started using white and yellow (each for a different reason
that is not important here).

Anyway, I did the drawer and drawer nameplate design in F360. Works great for
the drawers and with just a little tweaking of parameters I was able to resize
the drawers to fit the bigger Akro-Mills slots (you can see a bit of this on
the left of the picture) and for the slightly smaller craftsman storage thing
I had (you can see this if you break into my apartment, it's right above the
storage bin in the picture).

But, I found F360 a PITA for doing the nameplates. I probably just don't know
how to get what I want from F360, but I was spending 30-60 seconds for each
nameplate:

1. Open the sketch with the text
1. Double click the text to edit
1. Edit the text, change font size if needed
1. Exit the sketch
1. Export the mesh giving it a meaningful name
1. Return to (1) for the next nameplate

I also did some with just adding text in via the slicer, but that didn't line
things up as nicely as I'd like.

So I decided to learn enough OpenSCAD to help me generate the nameplates. I
probably have spent more time in learning and then creating the OpenSCAD project
for this then it would have take to just keep doing it in F360...but it was fun
and I can now extend this for the other sizes I need then probably for other
things as well (like add a couple depressions in the back for magnets and I'll
have plates for my tool chest).

If you read this far, you are either bored or you saw the picture of my
"modded Akro Mills storage cabinet" and are trying to figure out where the STLs
for the drawers are...I haven't put them up yet as my guess is that nobody else
would do something like this. If you want them though, let me know and I'll post
the F360 files in a repo and might even post the drawers and blank nameplates to
one of the model sharing sites.

![Modded Akro Mills storage cabinet](/images/akro_mills_modded.jpg)

FWIW, this is an older picture with some of the nameplates from F360 with text,
some from F360 as blanks with text added in slicer, and a couple (one?) from
the nameplate OpenSCAD file in this repo. I didn't reprint all of them, but I
did reprint all the ones that weren't black on white.