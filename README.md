# Go Project COMP 520
There's a project task tab and wiki tab. Check them out!

There are many scripts from the instructor and some come purely from us:

* `programs`: Test programs are organized by compilation phase and by expected result. Valid programs should output `OK` and status code `0`, while invalid programs should output `Error: <description>` and status code `1`.
  * `Scan+parse`: Runs both the scanner and parser phases
  * `Typecheck`: Runs until the end of the typechecker phase
  * `Codegen`: Runs until your compiler outputs the target code
* `programs-solution`: Test programs from the solution set of Milestone 1, organized like in `programs`
* `src`: Source code for your assignment
* `build.sh`: Builds your compiler using `Make` or similar. You should replace the commands here if necessary to build your compiler
* `movefiles.sh`: Move test files around both program directories. Only used for grading milestone 2.
* `prettyChecker.py`: Checks whether two files are identical in content. If not, it reports the line where they differ. Although named for the pretty printer, it can be used to compare any two files. Requires `python3`.
* `run.sh`: Runs your compiler using two arguments (mode - $1 and input file - $2). You should replace the commands here if necessary to invoke your compiler
* `test.sh`: Automatically runs your compiler against test programs in the programs directory and checks the output
* `test-solution.sh`: Automatically runs your compiler against **Solution test programs** given by the instructor
* `testScan.sh`: Automatically runs the scanner against test programs in the `1-scan+parse` directory. 
  * `tokens`: make the scanner run on the **entire** program. 
  * no arguments given: builds the scanner and runs it for one token.
* `testPretty.sh`: Automatically runs the pretty printer against test programs in the given argument `$1` directory. The test is divided in 2 phases: pretty printing twice and comparison to ensure the pretty invariant. To run the second phase, use the `compare` argument as `$2`. The script will create a directory called `pretty` in the same directory. It contains the following sub-directories. All these directories are ignored by `git` and are destroyed upon using `testPretty.sh` again.
  * `$1`: Path to a directory with `.go` files
  * `$2`: (optional) if it is `compare` then the script checks for the invariant
  * `first`: Contains the first pretty printed output of valid `.go` files
  * `second`: Contains the second pretty printed output of valid `.go` files. Requires the first pretty printed output be successfully printed.

Comments found in both files provide more details as to the requirements. Since a large portion of grading is performed automatically, please ensure to follow the input/output specifications **exactly**. You must be able to run the provided scripts on the SOCS Trottier machines.

## Milestone 1
Assignment description: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone1.pdf

Specifications: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone1_Specifications.pdf

Rubric: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone1_Rubric.pdf

Report Google doc: https://docs.google.com/document/d/1vYhJTqpWyOOF-wvh8Kg6RB_f8D3YG6cP70nl1RN3q2s/edit?usp=sharing

## Milestone 2
Assignment description: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone2.pdf

Specifications: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone2_Specifications.pdf

Rubric: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone2_Rubric.pdf

Report Google doc: https://docs.google.com/document/d/1LOxscfPnuSVjlCml0N6HCuIO17D91X-Ot_sBorizRGI/edit?ts=5c869eb9

## Milestone 3
Assignment description: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone3.pdf

Rubric: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone3_Rubric.pdf

Tutorial: https://www.cs.mcgill.ca/~cs520/2019/slides/10-golite-tutorial.pdf

Report Google doc: https://docs.google.com/document/d/1XdmYVDXqE7iNQWk2r2ZnVAexotE-3Z0spWudZLKTfcc/edit?usp=gmail_thread&ts=5c969b37

## Milestone 4
Assignment description: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone4.pdf

Rubric: https://www.cs.mcgill.ca/~cs520/2019/project/Milestone4_Rubric.pdf

Report guidelines: https://www.cs.mcgill.ca/~cs520/2019/project/Report.pdf

Report Google doc: https://docs.google.com/document/d/1A5af4S31CZ0YImwoFrAFps7LKQl4jKlOEh6hM9-60GM/edit?usp=sharing
