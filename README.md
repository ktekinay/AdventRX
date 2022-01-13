# AdventRX
Xojo Advent of Code project

## Description

A Xojo project framework to tackle the [Advent of Code](https://adventofcode.com) challenges. Solutions are included for 2021 and some past years.

## Usage

Duplicate the `AdventTemplate` class and rename it with year_month_day, for example, `Advent_2021_12_02`. In the `WndAdvent.InitAdvent` method, use `AddRow` to add the new class, e.g., `AddRow new Advent_2021_12_02`.

In the class, fill in the constants `kInput` and `kTestInput` with your data, then code it within the `CalculateResultA` and `CalculateResultB` methods.

Look around for helper methods in the `AdventBase` class and the `Advent` module. For example, within your code you can use `Print` to print lines to a pseudo-console.

Run the project, then double-click the day to run the code. Each day runs in a Thread so you could, if you wanted, run them simultaneously. Double-click again to pause while running, or run again after it's done.

## Who Did This

This project was created by Kem Tekinay (ktekinay at mactechnologies dot com). It may or may not be maintained, but is free to use as a framework.
