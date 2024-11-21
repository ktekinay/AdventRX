# AdventRX
Xojo Advent of Code project

## Description

A Xojo project framework to tackle the [Advent of Code](https://adventofcode.com) challenges. Solutions are included for 2021 and some past years.

## Usage

Duplicate the `AdventTemplate` class and rename it with year_month_day, for example, `Advent_2021_12_02`. In the `WndAdvent.InitAdvent` method, use `AddRow` to add the new class, e.g., `AddRow new Advent_2021_12_02`.

In the class, fill in the constants `kInput` and `kTestInput` with your data, then code it within the `CalculateResultA` and `CalculateResultB` methods.

Look around for helper methods in the `AdventBase` class and the `Advent` module. For example, within your code you can use `Print` to print lines to a pseudo-console.

Run the project, then double-click the day to run the code. Each day runs in a Thread so you could, if you wanted, run them simultaneously. Double-click again to pause while running, or run again after it's done.

## Included Solutions

The project includes solutions to all of 2021 and some of other years. More may be added as time goes on. The solutions are meant to solve the puzzles and should not be taken as examples of proper coding or technique.

In other words, some of this is ugly, but I'm posting it anyway. :-)

## Puzzle Data

If you use this project, create a folder "Puzzle Data" at the top level to store your input. The file names should be in the form "Advent_YYYY_12_DD.txt", e.g., "Advent_2023_12_01.txt". (Advent of Code has asked that we not make our puzzle data public.)

You can use the included IDE script to download the puzzle automatically, but it might take some tweaking.

First, log into [Advent of Code](https://www.adventofcode.com/) and use your browser's developer tools to copy the session cookie. In your shell profile, set an environment variable `AOC_SESSION_COOKIE` with that cookie. (You wil have to manually refresh that as needed.)

In the project, highlight `AdventTemplate` and duplicate it. Then run the IDE script. You can enter "year-day", e.g., "2023-1", and it will rename the template copy, enter the init code on the window, and fetch the data into "Puzzle Data".

## Who Did This

This project was created by Kem Tekinay (ktekinay at mactechnologies dot com). It may or may not be maintained, but is free to use as a framework.
