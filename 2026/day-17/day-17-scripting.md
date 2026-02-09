# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## Task 1: For Loop
1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one
   
   [Here is the script for_loop.sh](scripts/for_loop.sh)
   
   ![snapshot](images/for_loop.png)

2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop
   
   [Here is the script count.sh](scripts/count.sh)
   
   ![snapshot](images/count.png)

---

## Task 2: While Loop
1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end

   [Here is the script countdown.sh](scripts/countdown.sh)
   
   ![snapshot](images/countdown.png)
   
---

## Task 3: Command-Line Arguments
1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"
   
   [Here is the script greet.sh](scripts/greet.sh)
   
   ![snapshot](images/greet.png)

2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)
   
   [Here is the script args_demo.sh](scripts/args_demo.sh)
   
   ![snapshot](images/args_demo.png)

---

## Task 4: Install Packages via Script
1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package
   
   [Here is the script install_packages.sh](scripts/install_packages.sh)
   
   ![snapshot](images/install_packages.png)

---

## Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails
   
   [Here is the script safe_script.sh](scripts/safe_script.sh)
   
   ![snapshot](images/safe_script.png)


2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.

   [Here is the script modified_install_packages.sh](scripts/modified_install_packages.sh)
   
   ![snapshot](images/modified_install_packages.png)

---

## What I learned

* Using loops(while,for)
* Error handling
* Using CLI arguments


