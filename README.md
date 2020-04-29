# tsv2md
for sad Blackboard users

## Export to markdown:

`tsv2md.pl` tries to understand these question types:
* `MC` / `MA` multiple choice: incorrect answers are ~~stricken~~
* `TF` (true/false): give the correct answer with a bullet
* `ORD` (ordering): list answers in the correct order
* `SR` short response

Sample usage:
```
$ ./tsv2md.pl < sample.tsv > output.md
```

Sample output:

**MC** 1 < 3
- always
- ~~sometimes~~
- ~~never~~

**MA** n < m
- ~~always~~
- sometimes
- ~~never~~
- there's not enough information

**TF** This is a ridiculous question.
- false

**ORD** List the following in the following order:
1. a
1. b
1. c

**SR** So how's it going?

## Import from markdown

`md2tsv.pl` tries to understand the same question types: MC, MA, TF, ORD, SR.

It expects you to leave a blank line between questions, like above.

Sample usage:
```
$ ./md2tsv.pl < sample.md > output.tsv
```

The above markdown produces the following tsv:

```
MC	1 < 3	always	correct	sometimes	incorrect	never	incorrect
MA	n < m	always	incorrect	sometimes	correct	never	incorrect	there's not enough information	correct
TF	Blah blah blah	false
ORD	List the following in the following order:	a	b	c
SR	So how's it going?
```
