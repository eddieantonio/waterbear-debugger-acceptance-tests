# Acceptance tests!

## Feature list

These are sorted in order of relative priority.

 - [x] Pause execution
    - [x] while Waterbear is running a continuous task (e.g., updating
          the canvas)
 * [x] Single-step through blocks
    - [x] Before execution has started
    - [x] When execution is paused.
 * [ ] Set a breakpoint on a selected step blocks
     * [ ] Unset an existing breakpoint on a selected step blocks
 - [ ] Pause on breakpoints
 * [x] Resume execution once paused
 * [x] Pause/step across asynchronous calls -- though this isn't a thing the user should care about
 * [ ] Slow down script running if some input is active (e.g,. <kbd>shift</kbd> depressed)
 * [x] Dynamically add elements when "paused"
 * [ ] Show how many times a line gets called
 * [ ] [Extra credit] Show the value variables as you step (like a table)
 * [ ] [Extra credit] Add a console (similar to the box in Xcode playgrounds)

## User stories

As a user, I want to see how my program affected the state of the screen
and variables when I stop my application.

[VAGUE] As a user, I want to debug my program.

As a user, I want to step through each block invocation in my program.

As a user, I want to see the current value of variables as I step
through my program.


# Tests


## Requirement 1: Pause Execution

### Setup

Load a script with at least one _continuously_ running, non-blocking step.

[Example Script][AT-1A]

### Test

 1. Start the execution of the script.
 2. Give the input for `pause script` (e.g., tapping the pause button).

### Acceptance Criteria

 1. There is _at least_ visual indication (if not more than visual) that
    execution has _paused_. This indication is distinct from that that
    is stopped.
 2. The step/context block that will be executed _next_ will be
    **directly** indicated, e.g., it would be highlighted, or annotated
    with a clearly visible icon.
 3. The option to pause the script will be disabled. The option to
    resume/continue the script will be enabled.

Notes: If there is only one block in the looping context, as there is in
[AT-1A][], then this block is the only possible block that can execution
can be paused at.

[AT-1A]: http://waterbearlang.com/playground.html?gist=27192efe96985464c5c3


## Requirement 2a: Single-step through blocks (execution stopped)

### Setup

Load a script with at least one step block. Unlike
[1](#requirement-1-pause-execution), this step block does not have to be
a continuously looping context. Regardless, the same script suffices for
this test.

[Example Script][AT-1A]

### Preconditions

Execution is *stopped*.

### Test

 1. Give the input to step to the next block of the script (e.g., tap
    the step button).

### Acceptance Criteria

 1. Execution is started and is immediately paused on the _first_ step
    block -- whatever that may be. In the case of this test input, it is
    the first block in the drawing context.
 2. Indicators as in [1][], using the first block in the script.

## Requirement 2b: Single-step through blocks (execution paused)

Load a script with at least two step blocks.

[Example Script](http://localhost:8000/playground.html?gist=f839aaf6e81db0ac5eca)

### Preconditions

Execution is *stopped*.

### Test

 1. As in [2a][], single-step to the first block.
 2. Give the input to step to the next block of the script (e.g., tap
    the step button).

### Acceptance Criteria

 1. Execution is paused on the _second_ block.
 2. Indicators as in [1][], using the second block in the script.



## Requirement 3a: Set a pausepoint (breakpoint) on a selected block

### Setup

Load a script with at least one step or context block.

[Example Script](http://localhost:8000/playground.html?gist=f839aaf6e81db0ac5eca)

### Preconditions

Execution is *stopped*.

### Test

 1. Give the input to place a pausepoint on the block. (exact interface
    to be determined).

### Acceptance Criteria

 1. There is a visible indicator (such as an icon annotation) that this
    block can be paused.
 2. There is an obvious indication that this pausepoint can be
    removed/unset. For example, some sort of icon, or the abillity to
    toggle the pausepoint by tapping it.


## Requirement 3b: Unset an existing pausepoint on a block

### Setup

Load a script with at least one step or context block.  Place a
pausepoint on a step or context block as in [3a][].

[Example Script](http://localhost:8000/playground.html?gist=f839aaf6e81db0ac5eca)

### Preconditions

Execution is *stopped*, 

### Test

 1. Give the input to remove the pausepoint on the selected block.
    (exact interface to be determined).

### Acceptance Criteria

 1. The pausepoint indicator is a removed. It is obvious that this
    pausepoint is no longer active.
 2. Running the script again in debugging mode does not pause prior to
    executing this block.

## Requirement 4: Pause on pausepoints

### Setup

Load a script with at least two step or context blocks. Place a
pausepoint on a block—preferably not the first block. Ensure that this
block is placed in an execution path that _will_ run.

[Example Script](http://waterbearlang.com/playground.html?gist=e994f304fb953f1ecf6c)

### Preconditions

Execution is *stopped*.

### Test

 1. Give the input to run/start execution.

### Acceptance Criteria

 1. The blocks previous to the paused block should have run. For
    example, in the example script, the console should have the first
    message written, but not the second.
 2. Execution should be paused on the block with the pausepoint with
    indicators as shown in [1][]. 


## Requirement 5: Resume execution once paused

### Setup

Load a script with at least one block. By some means (such as stepping
from pause—see [2a][]), be paused before executing a block.

[Example Script](http://waterbearlang.com/playground.html?gist=f880cd9122673f84c622)

### Preconditions

Execution is *paused*. The blocks prior to the paused block should have
been executed.

### Test

 1. Give the input to resume/unpause execution.

### Acceptance Criteria

 1. All blocks should have been executed. In the example script, both
    messages should have printed.


## Requirement 6: Pause/step across asynchronous calls

### Setup

Load a script with an asynchronous context block, such as a "when my
location changes", or "when key pressed". Within this context should be
a least one set or context block. To make testing more deterministic,
place a pausepoint on this block within the asynchronous context block
of choice.

[Example Script](http://waterbearlang.com/playground.html?gist=03b68ac36f82730aa225)

### Preconditions

Execution is *started*.

### Test

 1. Trigger the asynchronous event. In the case of "when key pressed",
    press the appropriate key for the context block.

### Acceptance Criteria

 1. Execution should now be _paused_.
 2. The block on which execution should be paused (see [1][]) on should
    be the block on which the pausepoint was placed. That is, the block
    within the asynchronous context block.


## Requirement 7: Slow down script running if some input is active

### Setup

Load a script with several continuously running (within some kind of
loop) blocks. For this demonstration to be obvious, each step in the
loop must have some noticeable side-effect. For example, the given
example script updates the screen.

[Example Script](http://waterbearlang.com/playground.html?gist=32f2a8f1bff8c267fec6!)

### Preconditions

Execution is *started*.

### Test

 1. Give the input to slow down the script. For non-mobile users, this
    has been tentativly chosen as keeping shift pressed.

### Acceptance Criteria

 1. Execution of each block should be clearly visible, with some kind of
    visible indication of which block is next to execute.
 2. The actions of the blocks should be clearly visible. In the given
    example, script, the Astro-Waterbear should rotate at a
    significantly slower pace (such as two seconds per animation frame).

### Note

The exact slow down has not been specified, though it is informally
understood as being slow enough that the user would be able to see the
action of each step block.


## Requirement 8: Dynamically add elements when paused

### Setup

Load a script with multiple step or context blocks. To ease
demonstration, place a pausepoint on a block—preferably in a looping
context. With the pausepoint in place, run the script until it is
paused on this block.

[Example Script](http://waterbearlang.com/playground.html?gist=586d2a0d5f629114285a)

### Preconditions

Execution is *paused*.

### Test

 1. Drag a block into the script _after_ the block which is paused.
 2. Resume or step the execution.

### Acceptance Criteria

 1. The inserted block should have run. In the case of the given
    example, if the block was a "set [keepRunning] to [false]" will stop
    the infinite loop.

# Glossary

![Execution States](http://waterbearlang.github.io/images/testing/states.svg)

<dl>
<dt>paused</dt>
<dd>
Execution state wherein execution is suspended, but overall interpreter
state is defined. In laymen terms, stuff is running... but we just
frozen it for a moment to inspect what's going on.
</dd>

<dt>stopped<dt>
<dd>
Execution state that wherein execution is not defined! The only way out
is to start running. Stepping from the stopped state
<em>conceptually</em> starts the script and immediately pauses it.
</dd>

<dt> pausepoint </dt>
<dd> An indicator that can be placed on a step or a context block. This
indicator signifies that execution should pause just prior to executing
the indicated block. In popular debugging discourse, this is known as
a <em><a
href="http://en.wikipedia.org/wiki/Breakpoint">breakpoint</a></em>, but
the term <em>pausepoint</em> has been deemed more welcoming and intuitive to
newcomers.
</dd>
</dl>

<!-- Cross-reference requirements. -->
[1]: #requirement-1-pause-execution
[2a]: #requirement-2a-single-step-through-blocks-execution-stopped
[3a]: #requirement-3a-set-a-pausepoint-breakpoint-on-a-selected-block
